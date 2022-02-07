# DeliveryFeeCalulator

Delivery Fee Calculator. 

## Getting Started

This project contains a single page App for calculating the distance fee base on the 
description in the 'Wolt grade - Delivery Fee Calculator - Frontend and Mobile.pdf'
file.

How to:

    - Terminal: git clone https://github.com/labnof/wolt.git
    - Open App in Android studio 
    - In Android studio goto file → settings → Languages and frameworks → Flutter
    - Set the flutter SDK path and Apply (download if necessary)
    - Terminal: flutter pub get or flutter pub upgrade
    - Connect you device 
    - Run App: flutter run in terminal or click the green play button

Main App code:

    lib
        - constants.dart
        - fee_calculation _functions.dart
        - form.dart
        - form_field_validators.dart
        - home.dart
        - main.dart


* main.dart: contains the starting point of the App.
* home.dart: contains the home setup for the App.
* form.dart: contains the code for App form.
* form_field-validators.dart: contains a class of functions for validating the forms text fields.
* fee_calculation _functions.dart: contains a class of functions to calculate delivery fee.
* constants.dart: contains constants used to calculate delivery fee.


