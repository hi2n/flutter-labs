import 'story.dart';

class StoryBrain {
  int _storyNumber = 0;

  final List<Story> _storyData = [
    // 0: mở đầu
    Story(
      storyTitle:
          'Xe của bạn bị xẹp lốp trên một con đường vắng. Bạn quyết định đi nhờ xe. Một chiếc xe tải màu gỉ sét dừng lại bên cạnh bạn. Một người đàn ông với đôi mắt vô hồn mở cửa xe và hỏi: "Cần đi nhờ không?"',
      choice1: 'Đồng ý đi nhờ. Cảm ơn vì sự giúp đỡ!',
      choice2:
          'Khoan đã, tốt hơn là tôi nên hỏi anh ta trước xem anh ta có phải là kẻ giết người không.',
    ),
    // 1
    Story(
      storyTitle: 'Anh ta nhìn bạn một lúc lâu, rồi chậm rãi nói: "Không."',
      choice1: 'Tôi thấy yên tâm rồi, tôi sẽ lên xe.',
      choice2: 'Còn cái rìu ở ghế sau thì sao?',
    ),
    // 2
    Story(
      storyTitle:
          'Anh ta bật nhạc và hai người cùng hát suốt chặng đường. Khi tới thị trấn, anh ta hỏi: "Cậu muốn ghé quán ăn nghỉ chân không?"',
      choice1: 'Ghé quán ăn thôi!',
      choice2: 'Cảm ơn nhé, cho tôi xuống ở đây.',
    ),
    // 3
    Story(
      storyTitle:
          'Anh ta bật cười: "Tôi là thợ mộc, cái rìu để đốn củi thôi." Không khí bớt căng thẳng hơn hẳn.',
      choice1: 'Xin lỗi, tôi vẫn muốn xuống xe.',
      choice2: 'Vậy thì tuyệt, đi tiếp thôi!',
    ),
    // 4: KẾT THÚC (chỉ còn 1 lựa chọn)
    Story(
      storyTitle:
          'Bạn xuống xe và chờ xe cứu hộ. Một lúc sau xe cứu hộ đến, chiếc xe của bạn được sửa xong. KẾT THÚC.',
      choice1: 'Bắt đầu lại',
      choice2: '',
    ),
    // 5: KẾT THÚC
    Story(
      storyTitle:
          'Bạn và người tài xế trở thành bạn tốt, cùng nhau ăn một bữa thật ngon. KẾT THÚC.',
      choice1: 'Bắt đầu lại',
      choice2: '',
    ),
  ];

  // Chỉ số đoạn truyện kế tiếp: [khi chọn 1, khi chọn 2]
  final List<List<int>> _nextStory = [
    [2, 1], // 0
    [2, 3], // 1
    [5, 4], // 2
    [4, 2], // 3
    [0, 0], // 4 (kết thúc, bấm nút 1 để quay về đầu)
    [0, 0], // 5 (kết thúc)
  ];

  String getStory() => _storyData[_storyNumber].storyTitle;
  String getChoice1() => _storyData[_storyNumber].choice1;
  String getChoice2() => _storyData[_storyNumber].choice2;

  void nextStory(int choiceNumber) {
    _storyNumber = _nextStory[_storyNumber][choiceNumber - 1];
  }

  void restart() => _storyNumber = 0;

  // Nút 2 chỉ hiện khi đoạn truyện còn lựa chọn thứ hai
  bool buttonShouldBeVisible() => _storyData[_storyNumber].choice2.isNotEmpty;
}