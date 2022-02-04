// Class for the Fee calculation functions.
import 'dart:math';

import 'package:wolt/constants.dart';

// Function calculates the total delivery cost
double totalDeliveryFee(
    double cartValue, int distance, int itemCount, String date, String time) {
  double totalDeliveryFee = 0.0;
  // Case 0:  return 0 if the Cart Value 0 and there is no item to deliver.
  if (cartValue == 0 && itemCount == 0) {
    return totalDeliveryFee;
  }
  // Case 1:
  if (cartValue < kMinimumCartValueWithNoDeliveryFee) {
    totalDeliveryFee = cartValueSurcharge(cartValue) +
        distanceFee(distance) +
        itemsCountSurcharge(itemCount);

    //Case 1.1: fridayRush
    bool fridayRush = isFridayRush(date, time);
    if (fridayRush) {
      totalDeliveryFee = totalDeliveryFee * kRushMultiplier;
    }
  }
  return min(totalDeliveryFee, kMaxDeliveryFee.toDouble());
}

// checks if it is friday rush
bool isFridayRush(String date, String time) {
  num givenTime = num.parse("${time.substring(0, 2)}.${time.substring(3, 5)}");
  bool isFriday = (DateTime.parse(date).weekday == DateTime.friday);
  bool isRushHr = givenTime >= kRushStartTime && givenTime <= kRushEndTime;

  return isFriday && isRushHr;
}

// Function adds surcharge to cart value if necessary
double cartValueSurcharge(double cartValue) {
  if (cartValue < kMinimumCartValue) {
    return kMinimumCartValue - cartValue;
  }
  return 0.0;
}

// Function calculates the distance fee
int distanceFee(int distance) {
  if (distance < kBaseDistance) {
    return kBaseFee;
  }
  return kBaseFee + ((distance - kBaseDistance) / kAdditionalDistance).ceil();
}

// Function calculates surcharge for food items over 4
double itemsCountSurcharge(int itemsCount) {
  double surcharge = 0;

  if (itemsCount > kMaxNumberOfItemsWithNoSurcharge) {
    surcharge =
        (itemsCount - kMaxNumberOfItemsWithNoSurcharge) * kAdditionalCharge;
  }
  return surcharge;
}
