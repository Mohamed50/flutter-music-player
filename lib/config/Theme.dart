import 'package:flutter/material.dart';

String primaryFontFamily = "fira";

Color primaryColor = Colors.deepPurple;
Color accentColor = Colors.deepPurpleAccent;
Color lightScaffoldBackgroundColor = Colors.black;
Color lightBackgroundColor = Color(0xFF1A1A1A);
Color lightCardColor = Colors.grey[100];
Color lightIndicatorColor = Color(0xFF414042);
Color lightTextColor = Colors.grey[900];

Color darkScaffoldBackgroundColor = Colors.black;
Color darkBackgroundColor = Color(0xFF1A1A1A);
Color darkCardColor = Color(0xFF141414);
Color darkIndicatorColor = Color(0xFFFFE6B4);
Color darkTextColor =  Colors.white;
Color darkTitleTextColor =  Colors.grey[300];


ThemeData lightTheme = ThemeData(
  fontFamily: primaryFontFamily,
  primarySwatch: Colors.amber,
  primaryColor: primaryColor,
  accentColor: accentColor,
  backgroundColor: lightBackgroundColor,
  scaffoldBackgroundColor: lightScaffoldBackgroundColor,
  dialogBackgroundColor: lightBackgroundColor,
  primaryColorDark: lightIndicatorColor,
  primaryColorLight: primaryColor,
  indicatorColor: lightIndicatorColor,
  appBarTheme: AppBarTheme(
    color: primaryColor,
    textTheme: TextTheme(headline6: TextStyle(color: lightTextColor)),
  ),
  bottomAppBarColor: primaryColor,
  iconTheme: IconThemeData(color: lightTextColor),
  cardColor: lightCardColor,
  textTheme: TextTheme(
    headline6: TextStyle(color: lightTextColor),
    headline5: TextStyle(color: lightTextColor),
    headline4: TextStyle(color: lightTextColor),
    headline3: TextStyle(color: lightTextColor),
    headline2: TextStyle(color: lightTextColor),
    headline1: TextStyle(color: lightTextColor),
    bodyText1: TextStyle(color: lightTextColor),
    bodyText2: TextStyle(color: lightTextColor)
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: primaryColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
  ),
);

ThemeData darkTheme = ThemeData(
    fontFamily: primaryFontFamily,
    primarySwatch: Colors.amber,
    primaryColor: primaryColor,
    primaryColorDark: Color(0xFF414042),
    primaryColorLight: Color(0xFFFFE6B4),
    indicatorColor: Color(0xFFFFE6B4),
    accentColor: Color(0xFFFFE6B4),
    scaffoldBackgroundColor: darkScaffoldBackgroundColor,
    backgroundColor:  darkBackgroundColor,
    cardColor: darkCardColor,
    dialogBackgroundColor: darkCardColor,
    appBarTheme: AppBarTheme(
      color: darkCardColor,
      textTheme: TextTheme(
        headline6: TextStyle(color: darkTextColor),
      ),
    ),
    bottomAppBarColor: darkCardColor,
    iconTheme: IconThemeData(
      color: darkTextColor,
    ),
    textTheme: TextTheme(
      headline6: TextStyle(color: darkTextColor),
      headline5: TextStyle(color: darkTextColor),
      headline4: TextStyle(color: darkTextColor),
      headline3: TextStyle(color: darkTextColor),
      headline2: TextStyle(color: darkTextColor),
      headline1: TextStyle(color: darkTextColor),
      bodyText1: TextStyle(color: darkTextColor),
      bodyText2: TextStyle(color: darkTitleTextColor),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    ));



List<Color> list = [
  Colors.green[400],
  Colors.blue[400],
  Colors.amber[400],
  Colors.red[400],
  Colors.indigo[400],
  Colors.purple[400],
  Colors.orange[400],
  Colors.pink[400],
  Colors.deepPurple[400],
];

List<Color> lightList = [
  Colors.green[100],
  Colors.blue[100],
  Colors.amber[100],
  Colors.red[100],
  Colors.indigo[100],
  Colors.purple[100],
  Colors.orange[100],
  Colors.pink[100],
  Colors.deepPurple[100],
];

List<Color> darkList = [
  Colors.green[900],
  Colors.blue[900],
  Colors.amber[900],
  Colors.red[900],
  Colors.indigo[900],
  Colors.purple[900],
  Colors.orange[900],
  Colors.pink[900],
  Colors.deepPurple[900],
];


List<Color> getColorsList(){
  return list;
}

Color getColor(int index){
  index = index % list.length;
  return list[index];
}

Color getDarkColor(int index){
  index = index % darkList.length;
  return darkList[index];
}

Color getLightColor(int index){
  index = index % lightList.length;
  return lightList[index];
}