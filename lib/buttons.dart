class Button {
  static const String add = "+";
  static const String minus = "-";
  static const String multiply = "*";
  static const String divide = "/";
  static const String dot = ".";
  static const String modulos = "%";
  static const String clear = "AC";
  static const String delete = "Del";
  static const String result = "=";

  static const String zero = '0';
  static const String num1 = '1';
  static const String num2 = '2';
  static const String num3 = '3';

  static const String num4 = '4';
  static const String num5 = '5';
  static const String num6 = '6';

  static const String num7 = '7';
  static const String num8 = '8';
  static const String num9 = '9';

  static const Map<String, dynamic> display = {
    '*': '×' ,
    '/': '÷'
  };

  static const List<String> row1 = [
    clear,
    multiply,
    divide,
    delete,
  ];
  static const List<String> row2 = [
    num7,
    num8,
    num9,
    modulos,
  ];
  static const List<String> row3 = [
    num4,
    num5,
    num6,
    minus,
  ];
  static const List<String> row4 = [
    num1,
    num2,
    num3,
    add,
  ];
  static const List<String> row5 = [
    ' ',
    zero,
    dot,
    result,
  ];
}
