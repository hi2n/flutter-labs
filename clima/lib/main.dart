import 'package:flutter/material.dart';
import 'weather_model.dart';

void main() => runApp(const ClimaApp());

class ClimaApp extends StatelessWidget {
  const ClimaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
      home: const WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _service = WeatherService();
  final TextEditingController _controller = TextEditingController();

  Weather? _weather;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadByLocation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _load(Future<Weather> Function() fetch) async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final w = await fetch();
      if (!mounted) return;
      setState(() => _weather = w);
    } catch (e) {
      if (!mounted) return;
      setState(() => _error = e.toString().replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  // Thử lấy GPS trước; nếu thất bại thì dùng Hanoi mặc định
  Future<void> _loadByLocation() async {
    await _load(() async {
      try {
        return await _service.getLocationWeather();
      } catch (_) {
        return await _service.getCityWeather('Hanoi');
      }
    });
  }

  void _search() {
    final city = _controller.text.trim();
    if (city.isEmpty) return;
    FocusScope.of(context).unfocus();
    _load(() => _service.getCityWeather(city));
  }

  // Biểu tượng dự phòng theo mã icon của API
  IconData _fallbackIcon(String code) {
    switch (code.substring(0, 2)) {
      case '01':
        return Icons.wb_sunny;
      case '02':
        return Icons.wb_cloudy;
      case '03':
      case '04':
        return Icons.cloud;
      case '09':
      case '10':
        return Icons.grain;
      case '11':
        return Icons.flash_on;
      case '13':
        return Icons.ac_unit;
      case '50':
        return Icons.blur_on;
      default:
        return Icons.cloud;
    }
  }

  Widget _infoTile(IconData icon, String label, String value) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(
                        fontSize: 11, fontWeight: FontWeight.bold)),
                Text(value,
                    style:
                        const TextStyle(fontSize: 12, color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _weatherBody(Weather w) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.location_on, color: Colors.blue),
            Text('${w.city}, ${w.country}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
        Text(w.localTime,
            style: const TextStyle(color: Colors.black45, fontSize: 12)),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFEFF4FF),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Image.network(
                w.iconUrl,
                width: 100,
                height: 100,
                errorBuilder: (_, __, ___) => Icon(
                  _fallbackIcon(w.icon),
                  size: 80,
                  color: Colors.blue,
                ),
              ),
              Text(w.description, style: const TextStyle(fontSize: 16)),
              Text('${w.temp.round()}°C',
                  style: const TextStyle(
                      fontSize: 44, fontWeight: FontWeight.bold)),
              Text('Feels like ${w.feelsLike.round()}°C',
                  style: const TextStyle(color: Colors.black45, fontSize: 12)),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _infoTile(Icons.water_drop, 'Humidity', '${w.humidity}%'),
                  _infoTile(Icons.air, 'Wind Speed', '${w.windSpeed} m/s'),
                  _infoTile(
                      Icons.thermostat, 'Min Temp', '${w.tempMin.round()}°C'),
                  _infoTile(Icons.thermostat_auto, 'Max Temp',
                      '${w.tempMax.round()}°C'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE3EDFF), Color(0xFFF7F3FF)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text('Weather App',
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        onSubmitted: (_) => _search(),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          hintText: 'Enter city name (e.g. London)',
                          isDense: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: _search,
                      icon: const Icon(Icons.search, size: 16),
                      label: const Text('Search'),
                    ),
                    IconButton(
                      tooltip: 'Vị trí hiện tại',
                      onPressed: _loadByLocation,
                      icon: const Icon(Icons.my_location),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                if (_loading)
                  const Padding(
                    padding: EdgeInsets.all(40),
                    child: CircularProgressIndicator(),
                  )
                else if (_error != null)
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(_error!,
                        style: const TextStyle(color: Colors.red)),
                  )
                else if (_weather != null)
                  _weatherBody(_weather!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}