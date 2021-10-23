import 'package:flutter_test/flutter_test.dart';
import 'package:wolt/fee_calculation_functions.dart';

void main() {
  group('Total delivery fee function test', () {
    test('Cart value over 100 return 0 delivery fee', () {
      num fee =
          FeeCalFunctions.totalDeliveryFee(0, 1500, 5, '2021-10-15', '15.30');
      expect(fee, 0);
    });

    test('Maximum delivery fee is 15', () {
      num fee =
          FeeCalFunctions.totalDeliveryFee(0, 1500, 5, '2021-10-15', '15.30');
      bool result = fee <= 15;
      expect(result, true);
    });
  });
}
