import 'question.dart';

class QuizBrain {
  int _questionNumber = 0;

  final List<Question> _questionBank = [
    Question(questionText: 'Hà Nội là thủ đô của Việt Nam.', questionAnswer: true),
    Question(questionText: 'Việt Nam có đường biên giới với Campuchia.', questionAnswer: true),
    Question(questionText: 'Mặt trời mọc ở hướng Tây.', questionAnswer: false),
    Question(questionText: 'Người trưởng thành có 206 chiếc xương.', questionAnswer: true),
    Question(questionText: 'Sông Mê Kông chảy qua lãnh thổ Việt Nam.', questionAnswer: true),
    Question(questionText: 'Cá voi là một loài cá.', questionAnswer: false),
    Question(questionText: 'Nước sôi ở 100°C ở áp suất tiêu chuẩn.', questionAnswer: true),
    Question(questionText: 'Flutter do Facebook phát triển.', questionAnswer: false),
    Question(questionText: 'Dart là ngôn ngữ lập trình dùng cho Flutter.', questionAnswer: true),
    Question(questionText: 'Đà Nẵng nằm ở miền Bắc Việt Nam.', questionAnswer: false),
  ];

  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) _questionNumber++;
  }

  String getQuestionText() => _questionBank[_questionNumber].questionText;

  bool getCorrectAnswer() => _questionBank[_questionNumber].questionAnswer;

  bool isFinished() => _questionNumber >= _questionBank.length - 1;

  void reset() => _questionNumber = 0;
}