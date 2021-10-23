// Call for the TextFormField validators.
class FfValidator{

// generic validator for TextFormField
  static String? genericTextValidator(value) {
    if (value == null || value.isEmpty ) {
      return 'Please enter some value';
    }
    return null;
  }
  // integer validator for TextFormField

  static bool isNumericRegex(String string) {
    final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');

    return numericRegex.hasMatch(string);
  }

  static String? numTextValidator(value) {
    try {
      num cartValue = num.parse(value);
      if (value == null ||
          value.isEmpty ||
          !isNumericRegex(value) ||
          cartValue == 0) {
        return 'Please enter a number';
      }
      return null;
    } catch (e) {
      return 'Please enter a number';
    }
  }

  // item count validator for TextFormField
  static String? itemTextValidator(value) {
    try {
      int itemsCount = int.parse(value);
      if (value == null ||
          value.isEmpty ||
          !isNumericRegex(value) ||
          itemsCount == 0) {
        return 'Please enter number of items';
      }
      return null;
    } catch (e) {
      return 'Please enter number of items';
    }
  }

  //  date validator for TextFormField
  static bool isDateRegex(String string) {
    final dateRegex =
        RegExp(r'^\d{4}-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])$');

    return dateRegex.hasMatch(string);
  }
  static String? dateTextValidator(value) {
    if (value == null || value.isEmpty || !isDateRegex(value)) {
      return 'Please enter date e,g 2021-20-01';
    }
    return null;
  }

  //  Time validator for TextFormField
  static bool isTimeRegex(String string) {
    final timeRegex =
    RegExp(r'^([0-1]?[0-9]|2[0-3])\:[0-5][0-9]$');
    return timeRegex.hasMatch(string);
  }
  static String? timeTextValidator(value) {
    if (value == null || value.isEmpty || !isTimeRegex(value) ){
      return 'Please enter time e,g 17:00';
    }
    return null;
  }

}