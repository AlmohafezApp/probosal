class Rcite {
  String title = "";
  String text = "";
  List<String> wordsList = [];
  List<String> repeatedWrongWordsList = [];
  List<String> wrongWordsList = [];
  List<RciteTring> tringList = [];
  void convertTextToList(String _text) {
    final stringList = _text.split(" ");
    for (String item in stringList) {
      if (item != "") {
        wordsList.add(item);
      }
    }
    text = '';
    for (int i = 0; i < wordsList.length; i++) {
      if (wordsList[i] != "") {
        text += wordsList[i] + " ";
        if (i % 5 == 0 && i != 0) {
          text += "\n";
        }
      }
    }
  }
}

class RciteTring {
  String date = "";
  String time = "";
  List<String> wrongWordsList = [];
  int totalWords = 0;
}
