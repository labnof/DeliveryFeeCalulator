import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'fee_calculation_functions.dart' as fee_calculator;
import 'form_field_validators.dart' as fee_form_validators;

// Contains mainly the form for the fee calculation.
class DeliveryFeeForm extends StatefulWidget {
  const DeliveryFeeForm({Key? key}) : super(key: key);

  @override
  State<DeliveryFeeForm> createState() => _DeliveryFeeFormState();
}

class _DeliveryFeeFormState extends State<DeliveryFeeForm> {
  // Creates a global key that uniquely identifies the Form widget
  //used to validate the form.
  final _formKey = GlobalKey<FormState>();
  double _deliveryFeeTotal = 0.0; // Ephemeral state

  // the TextEditingControllers are use to access the TextFormField values
  final TextEditingController _catValueController = TextEditingController();
  final TextEditingController _deliveryDistanceController =
      TextEditingController();
  final TextEditingController _itemCountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  // Async Function to calculate and
  Future<void> _asyncCalculateDeliveryFee() async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Calculating delivery fee...')),
    );

    // Validate will return true if the form is valid, or false if
    // the form is invalid.
    if (_formKey.currentState!.validate()) {
      double cartValue = double.parse(_catValueController.text);
      int distance = int.parse(_deliveryDistanceController.text);
      int itemCount = int.parse(_itemCountController.text);
      String date = _dateController.text;
      String time = _timeController.text;
      double total;
      total = await fee_calculator.asyncTotalDeliveryFee(
          cartValue, distance, itemCount, date, time);
      setState(() {
        _deliveryFeeTotal = total;
      });
    }
  }

  //Date picker
  DateTime currentDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate) {
      setState(() {
        currentDate = pickedDate;
        _dateController.text = DateFormat('yyyy-MM-dd').format(currentDate);
      });
    }
  }

  //Time picker
  TimeOfDay currentTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: currentTime,
        builder: (context, child) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                  // Using 24-Hour format
                  alwaysUse24HourFormat: true),
              child: child!);
        });

    if (pickedTime != null && pickedTime != currentTime) {
      setState(() {
        currentTime = pickedTime;
        _timeController.text = '${currentTime.hour}:${currentTime.minute}';
        // The  code below does not work in emulator, but works on s10 mini,
        // Android 11 or 12.
        //_timeController.text = currentTime.format(context);});

      });
    }
  }

  @override
  void dispose() {
    _catValueController.dispose();
    _deliveryDistanceController.dispose();
    _itemCountController.dispose();
    _dateController.dispose();
    _timeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            TextFormField(
              controller: _catValueController,
              validator: fee_form_validators.numTextValidator,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                icon: Icon(Icons.shopping_cart),
                hintText: 'Enter cart value in ???',
                labelText: 'Cart Value',
              ),
            ),
            TextFormField(
              controller: _deliveryDistanceController,
              keyboardType: TextInputType.number,
              validator: fee_form_validators.numTextValidator,
              decoration: const InputDecoration(
                icon: Icon(Icons.social_distance),
                hintText: 'Enter delivery distance in meters',
                labelText: 'Delivery distance',
              ),
            ),
            TextFormField(
              controller: _itemCountController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              validator: fee_form_validators.itemTextValidator,
              decoration: const InputDecoration(
                icon: Icon(Icons.fastfood),
                hintText: 'Enter number of items',
                labelText: 'Number of items ',
              ),
            ),
            TextFormField(
              onTap: () => _selectDate(context),
              controller: _dateController,
              validator: fee_form_validators.dateTextValidator,
              decoration: const InputDecoration(
                icon: Icon(Icons.calendar_today),
                hintText: 'Enter date: year-month-day',
                labelText: 'Date',
              ),
            ),
            TextFormField(
              onTap: () => _selectTime(context),
              controller: _timeController,
              validator: fee_form_validators.timeTextValidator,
              decoration: const InputDecoration(
                icon: Icon(Icons.access_time),
                hintText: 'Enter time. e.g: 17:30',
                labelText: 'Time',
              ),
            ),
            const SizedBox(height: 52),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                        minimumSize: const Size(298, 52),
                        maximumSize: const Size(300, 52)),
                    onPressed: _asyncCalculateDeliveryFee,
                    child: const Text('Calculate delivery price'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 64),
            Text(
              ' Delivery price: ${double.parse((_deliveryFeeTotal).toStringAsFixed(2))}???',
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ],
        ),
      ),
    );
  }
}
