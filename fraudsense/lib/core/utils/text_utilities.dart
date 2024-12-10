class TextUtilities {
  //this cuts a large string into a list of smaller strings with a max length, while making sure words gets properly separated
  static List<String> cutTextIntoList(
      {required String text, required int maxLength}) {
    List<String> textList = [];

    List<String> textToWords = text.split(" ");

    String formingSection = "";

    for (var i = 0; i < textToWords.length; i++) {
      if (formingSection.length + textToWords[i].length + 1 < maxLength) {
        formingSection += "${textToWords[i]} ";

        if (i == textToWords.length - 1) {
          textList.add(formingSection);
        }
      } else {
        textList.add(formingSection);

        formingSection = "${textToWords[i]} ";
      }
    }

    return textList;
  }
}
