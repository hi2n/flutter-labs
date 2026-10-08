import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper(this.url);
  final String url;

  Future<Map<String, dynamic>> getData() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else if (response.statusCode == 404) {
      throw Exception('Không tìm thấy thành phố');
    } else if (response.statusCode == 401) {
      throw Exception('API key không hợp lệ hoặc chưa kích hoạt');
    }
    throw Exception('Lỗi máy chủ (${response.statusCode})');
  }
}