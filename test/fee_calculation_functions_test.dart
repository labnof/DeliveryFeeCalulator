import 'package:flutter_test/flutter_test.dart';
import 'package:wolt/fee_calculation_functions.dart';

void main() {
  group('Total delivery fee function test', () {
    test('Cart value over 100 return 0 delivery fee', () {
      num fee =
          FeeCalFunctions.totalDeliveryFee(100, 1500, 5, '2021-10-15', '15.30');
      expect(fee, 0);
    });

    test('Maximum delivery fee is 15', () {
      num fee =
          FeeCalFunctions.totalDeliveryFee(0, 1500, 5, '2021-10-15', '15.30');
      bool result = fee <= 15;
      expect(result, true);
    });
  });

  group('Cart surcharge function test', () {
    test('Should return 10 when cart value is less than 10', () {
      num fee = FeeCalFunctions.cartValueSurcharge(5);
      expect(fee, 10);
    });

    test('Should return 10 when cart value is less than 10', () {
      double cartValue = 12;
      double fee = FeeCalFunctions.cartValueSurcharge(cartValue);
      expect(fee, cartValue);
    });

    group('Distance fee function test', () {
      test('Should return 0 for distance less than 1000', () {
        num fee = FeeCalFunctions.distanceFee(999);
        expect(fee, 0);
      });

      test('Should return 2 for a distance of 1000', () {
        num fee = FeeCalFunctions.distanceFee(1000);
        expect(fee, 2);
      });

      test('Should return 2 for a distance of 1000', () {
        num fee = FeeCalFunctions.distanceFee(1000);
        expect(fee, 2);
      });

      test('Distance ove 1000', () {
        num fee = FeeCalFunctions.distanceFee(1001);
        expect(fee, 3);
      });
    });

    group('Items count surcharge function test', () {
      test('Less than 5 items', () {
        num fee = FeeCalFunctions.foodCountSurcharge(4);
        expect(fee, 0);
      });

      test('>=  5 items', () {
        num fee = FeeCalFunctions.foodCountSurcharge(5);
        expect(fee, 0.50);
      });
    });

    group('Checks if a date is Friday or not', () {
      test('Friday Rush', () {
        bool isFR = FeeCalFunctions.isFridayRush('2021-10-15', '15.30');
        expect(isFR, true);
      });

      test('Friday Rush but not Rush', () {
        bool isFR = FeeCalFunctions.isFridayRush('2021-10-15', '11.30');
        expect(isFR, false);
      });

      test('Not Friday Rush', () {
        bool isFR = FeeCalFunctions.isFridayRush('2021-10-16', '15.30');
        expect(isFR, false);
      });
    });
  });
}