enum QuestionType { 
  multipleChoice, 
  trueFalse, 
  fillInBlank;

  factory QuestionType.valueOf(String type) {
    return QuestionType.values.firstWhere((e)=> e.name == type);
  }
}
