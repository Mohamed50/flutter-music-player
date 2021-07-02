
List<String> supportedLanguages = ['ar','en'];
List<String> supportedLanguagesNames = ['العربية','English'];

getLanguageName(String langCode){
  return supportedLanguagesNames.elementAt(supportedLanguages.indexWhere((element) => element == langCode));
}
