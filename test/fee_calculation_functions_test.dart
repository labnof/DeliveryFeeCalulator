import 'package:flutter_test/flutter_test.dart';
import 'package:wolt/fee_calculation_functions.dart' as fee_calculator;

void main() {
  group('Total delivery fee function test', () {
    test('Cart value over 100 return 0 delivery fee', () {
      num fee =
          fee_calculator.totalDeliveryFee(100, 1500, 5, '2021-10-15', '15.30');
      expect(fee, 0);
    });

    test('Maximum delivery fee is 15', () {
      num fee =
          fee_calculator.totalDeliveryFee(10, 1500, 5, '2021-10-15', '15.30');
      bool result = fee <= 15;
      expect(result, true);
    });
  });

  group('Cart surcharge function test', () {
    test('Values less than 10', () {
      double cartValue = 5;
      double expectedOutPut = 10 - cartValue;
      double fee = fee_calculator.cartValueSurcharge(cartValue);
      expect(fee, expectedOutPut);
    });

    test('Values >= 10', () {
      double cartValue = 10;
      double fee = fee_calculator.cartValueSurcharge(cartValue);
      expect(fee, 0);
    });
  });

  group('Distance fee function test', () {
    test('distance less than 1000', () {
      num fee = fee_calculator.distanceFee(999);
      expect(fee, 0);
    });

    test('Distance of 1000', () {
      num fee = fee_calculator.distanceFee(1000);
      expect(fee, 2);
    });

    test('Distance of 1500', () {
      num fee = fee_calculator.distanceFee(1500);
      expect(fee, 3);
    });
    test('Distance of 1501', () {
      num fee = fee_calculator.distanceFee(1501);
      expect(fee, 4);
    });

    test('Distance ove 1000', () {
      num fee = fee_calculator.distanceFee(1001);
      expect(fee, 3);
    });
  });

    group('Items count surcharge function test', () {
      test('Less than 5 items', () {
        num fee = fee_calculator.itemsCountSurcharge(4);
      expect(fee, 0);
    });

    test('>=  5 items', () {
      num fee = fee_calculator.itemsCountSurcharge(5);
      expect(fee, 0.50);
    });
  });

  group(' isFridayRush test ', () {
    test('Friday Rush! ', () {
      bool isFR = fee_calculator.isFridayRush('2021-10-15', '15.30');
      expect(isFR, true);
    });

    test('Friday! Not Rush', () {
      bool isFR = fee_calculator.isFridayRush('2021-10-15', '11.30');
      expect(isFR, false);
    });

    test('Not Friday not Rush', () {
      bool isFR = fee_calculator.isFridayRush('2021-10-16', '15.30');
      expect(isFR, false);
    });
    });
}