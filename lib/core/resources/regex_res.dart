class RegexRes {
  RegexRes._init();

  static RegExp kOnlyNumber = RegExp(r'^[0-9]+$');
  static RegExp kDoubleValue = RegExp(r'^\d*\.?\d*$'); 

  static RegExp kMobileNumber =
      RegExp(r"(^([+]{1}[8]{2}|0088)?(01){1}[3-9]{1}\d{8})$");

  static RegExp kEmailId = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@([a-zA-Z0-9_\-\.]+)\.[a-zA-Z]+");

  static RegExp kSpecialOneChar = RegExp(r'^.*\W$');

  static RegExp kNidNumber = RegExp(r'^([0-9]{10}|[0-9]{13}|[0-9]{17})$');

  static RegExp kDate = RegExp(r'^\d{4}-\d{2}-\d{2}$');

  
  
  static RegExp kPassword = RegExp(r'^{6,}$');
}
