/// use to check  what type of answer we have
/// -1 for statement , 0 for option , 1 for text input , 2 for date Type

abstract class AnswerType {
  static const int statement = -1;
  static const int option = 0;
  static const int textInput = 1;
  static const int date = 2;
}

/// use to check what type of question  is coming form question entity
/// 0 for question and 1 for statement
abstract class QuestionType {
  static const int question = 0;
  static const int statement = 1;
}
