import 'package:flutter_test/flutter_test.dart';
import 'package:wolt/form_field_validators.dart' as fee_form_validators;

void main() {
  String numTffError = 'Please enter a number';
  String itemTffError = 'Please enter number of items';
  String dateTffError = 'Please enter date e.g 2021-12-01';
  String timeTffError = 'Please enter time e.g 17:00';

  group('Number  TextFormField validator test', () {
    test('Empty Input', () {
      var result = fee_form_validators.numTextValidator('');
      expect(result, numTffError);
    });
    test('Negative Input', () {
      var result = fee_form_validators.numTextValidator('-10');
      expect(result, numTffError);
    });
    test('Alphabet Input', () {
      var result = fee_form_validators.numTextValidator('One');
      expect(result, numTffError);
    });

    test('Alphanumeric Input', () {
      var result = fee_form_validators.numTextValidator('1 euros');
      expect(result, numTffError);
    });

    test('Numeric Input', () {
      var result = fee_form_validators.numTextValidator('13');
      expect(result, null);
    });
  });

  group('Items count  TextFormField validator test', () {
    test('Empty Input', () {
      var result = fee_form_validators.itemTextValidator('');
      expect(result, itemTffError);
    });

    test('Negative Input', () {
      var result = fee_form_validators.itemTextValidator('-5');
      expect(result, itemTffError);
    });

    test('Alphabet Input', () {
      var result = fee_form_validators.itemTextValidator('One');
      expect(result, itemTffError);
    });

    test('Alphanumeric Input', () {
      var result = fee_form_validators.itemTextValidator('1 euros');
      expect(result, itemTffError);
    });

    test('Numeric Input', () {
      var result = fee_form_validators.itemTextValidator('13');
      expect(result, null);
    });

    test('0 as Input', () {
      var result = fee_form_validators.itemTextValidator('0');
      expect(result, itemTffError);
    });
  });

  group('Date TextFormField validator test', () {
    test('Empty Input', () {
      var result = fee_form_validators.dateTextValidator('');
      expect(result, dateTffError);
    });

    test('Alphabet Input', () {
      var result = fee_form_validators.dateTextValidator('One');
      expect(result, dateTffError);
    });

    test('Alphanumeric Input', () {
      var result = fee_form_validators.dateTextValidator('1 euros');
      expect(result, dateTffError);
    });

    test(' Format (, separated date) other than 2021-10-12', () {
      var result = fee_form_validators.dateTextValidator('2021,10,12');
      expect(result, dateTffError);
    });

    test(' Format (. separated date) other than 2021-10-12', () {
      var result = fee_form_validators.dateTextValidator('2021.10.12');
      expect(result, dateTffError);
    });

    test(' Format (/ separated date) other than 2021-10-12', () {
      var result = fee_form_validators.dateTextValidator('2021/10/12');
      expect(result, dateTffError);
    });

    test('Date Picker date format', () {
      var result = fee_form_validators.dateTextValidator('2021-10-12');
      expect(result, null);
    });
  });

  group('Time TextFormField validator test', () {
    test('Empty Input', () {
      var result = fee_form_validators.timeTextValidator('');
      expect(result, timeTffError);
    });

    test('Alphabet Input', () {
      var result = fee_form_validators.timeTextValidator('One');
      expect(result, timeTffError);
    });

    test('Alphanumeric Input', () {
      var result = fee_form_validators.timeTextValidator('1 euros');
      expect(result, timeTffError);
    });

    test(' Format (. separated time) other than 10:12', () {
      var result = fee_form_validators.timeTextValidator('10.12');
      expect(result, timeTffError);
    });

    test('Time Picker date format', () {
      var result = fee_form_validators.timeTextValidator('10:12');
      expect(result, null);
    });

    group('Regex functions test', () {
      test('Wrong date format', () {
        bool result = fee_form_validators.isDateRegex('2021/01/10');
        expect(result, false);
      });
      test('Right date format', () {
        bool result = fee_form_validators.isDateRegex('2021-01-10');
        expect(result, true);
      });

      test('Wrong time format', () {
        bool result = fee_form_validators.isTimeRegex('20.23');
        expect(result, false);
      });
      test('Right time format', () {
        bool result = fee_form_validators.isTimeRegex('20:23');
        expect(result, true);
      });
    });
  });
}