import 'package:flutter_test/flutter_test.dart';
import 'package:wolt/form_field_validators.dart';

void main() {
  String numTffError = 'Please enter a number';
  String itemTffError = 'Please enter number of items';
  String dateTffError = 'Please enter date e,g 2021-20-01';
  String timeTffError = 'Please enter time e,g 17:00';

  group('Number  TextFormField validator test', () {
    test('Empty Input', () {
      var result = FfValidator.numTextValidator('');
      expect(result, numTffError);
    });

    test('Alphabet Input', () {
      var result = FfValidator.numTextValidator('One');
      expect(result, numTffError);
    });

    test('Alphanumeric Input', () {
      var result = FfValidator.numTextValidator('1 euros');
      expect(result, numTffError);
    });

    test('Numeric Input', () {
      var result = FfValidator.numTextValidator('13');
      expect(result, null);
    });
  });

  group('Items count  TextFormField validator test', () {
    test('Empty Input', () {
      var result = FfValidator.itemTextValidator('');
      expect(result, itemTffError);
    });

    test('Alphabet Input', () {
      var result = FfValidator.itemTextValidator('One');
      expect(result, itemTffError);
    });

    test('Alphanumeric Input', () {
      var result = FfValidator.itemTextValidator('1 euros');
      expect(result, itemTffError);
    });

    test('Numeric Input', () {
      var result = FfValidator.itemTextValidator('13');
      expect(result, null);
    });

    test('0 as Input', () {
      var result = FfValidator.itemTextValidator('0');
      expect(result, itemTffError);
    });
  });

  group('Date TextFormField validator test', () {
    test('Empty Input', () {
      var result = FfValidator.dateTextValidator('');
      expect(result, dateTffError);
    });

    test('Alphabet Input', () {
      var result = FfValidator.dateTextValidator('One');
      expect(result, dateTffError);
    });

    test('Alphanumeric Input', () {
      var result = FfValidator.dateTextValidator('1 euros');
      expect(result, dateTffError);
    });

    test(' Format (, separated date) other than 2021-10-12', () {
      var result = FfValidator.dateTextValidator('2021,10,12');
      expect(result, dateTffError);
    });

    test(' Format (. separated date) other than 2021-10-12', () {
      var result = FfValidator.dateTextValidator('2021.10.12');
      expect(result, dateTffError);
    });

    test(' Format (/ separated date) other than 2021-10-12', () {
      var result = FfValidator.dateTextValidator('2021/10/12');
      expect(result, dateTffError);
    });

    test('Date Picker date format', () {
      var result = FfValidator.dateTextValidator('2021-10-12');
      expect(result, null);
    });
  });

  group('Time TextFormField validator test', () {
    test('Empty Input', () {
      var result = FfValidator.timeTextValidator('');
      expect(result, timeTffError);
    });

    test('Alphabet Input', () {
      var result = FfValidator.timeTextValidator('One');
      expect(result, timeTffError);
    });

    test('Alphanumeric Input', () {
      var result = FfValidator.timeTextValidator('1 euros');
      expect(result, timeTffError);
    });

    test(' Format (. separated time) other than 10:12', () {
      var result = FfValidator.timeTextValidator('10.12');
      expect(result, timeTffError);
    });

    test('Time Picker date format', () {
      var result = FfValidator.timeTextValidator('10:12');
      expect(result, null);
    });

    group('Regex functions test', () {
      test('Wrong date format', () {
        bool result = FfValidator.isDateRegex('2021/01/10');
        expect(result, false);
      });
      test('Right date format', () {
        bool result = FfValidator.isDateRegex('2021-01-10');
        expect(result, true);
      });

      test('Wrong time format', () {
        bool result = FfValidator.isTimeRegex('20.23');
        expect(result, false);
      });
      test('Right time format', () {
        bool result = FfValidator.isTimeRegex('20:23');
        expect(result, true);
      });
    });
  });
}