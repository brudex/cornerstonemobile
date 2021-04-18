import 'package:cornerstone/widgets.dart';
import 'package:flutter/material.dart';

class Donation extends StatefulWidget {
  @override
  State createState() => DonationState();
}

class DonationState extends State<Donation> {
  TextEditingController _amountController;
  FocusNode _amountFocus;

  // Initially password is obscure

  // ignore: unused_field
  String _amount;
  String _currentPaymentMethod;
  String _currentDonationType;

  var _paymentMethod = [
    "Stripe",
    "Paypal",
  ];

  var _donations = [
    "Tithe",
    "Offering",
    "Others",
  ];

  void performDonation() {
    //Donation here
  }

  // ignore: unused_element
  void _validate() {
    setState(() {
      _amount = _amountController.text;
    });
  }

  @override
  void initState() {
    _amountController = TextEditingController();

    _amountFocus = FocusNode();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Church Donations',
                    style: TextStyle(fontSize: 28.0),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'You are about to sow seed to the church. Enter details below to continue',
                style: TextStyle(fontSize: 15.0, color: Colors.grey),
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16, bottom: 16),
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10.0),
                child: TextField(
                  focusNode: _amountFocus,
                  controller: _amountController,
                  obscureText: false,
                  textInputAction: TextInputAction.next,
                  onSubmitted: (input) {
                    _amount = input;
                  },
                  onTap: () {},
                  decoration: InputDecoration(
                    labelText: "Enter amount",
                    hintText: 'Enter amount to donate',
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.money,
                        color: Colors.blue,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16, bottom: 16),
              child: FormField<String>(
                builder: (FormFieldState<String> state) {
                  return InputDecorator(
                    decoration: InputDecoration(
                      errorStyle: TextStyle(
                          color: Colors.redAccent, fontSize: 16),
                      hintText: 'Please select church',
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: Text('Select payment method'),
                        value: _currentPaymentMethod,
                        isDense: true,
                        onChanged: (String newValue) {
                          setState(() {
                            _currentPaymentMethod = newValue;
                            state.didChange(newValue);
                          });
                        },
                        items: _paymentMethod.map((String value) {
                          return DropdownMenuItem<String>(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(value),
                                Text('  '),
                                value == 'Stripe'?   Image.asset('images/stripe.png'):Image.asset('images/paypal.png'),
                              ],
                            ),
                            value: value,
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16, bottom: 16),
              child: FormField<String>(
                builder: (FormFieldState<String> state) {
                  return InputDecorator(
                    decoration: InputDecoration(
                      errorStyle: TextStyle(
                          color: Colors.redAccent, fontSize: 16),
                      hintText: 'Please select church',
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: Text('Select donation type'),
                        value: _currentDonationType,
                        isDense: true,
                        onChanged: (String newValue) {
                          setState(() {
                            _currentDonationType = newValue;
                            state.didChange(newValue);
                          });
                        },
                        items: _donations.map((String value) {
                          return DropdownMenuItem<String>(
                            child: Text(value),
                            value: value,
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
            ),
             Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: StyledButton(
                title: 'Donate',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
