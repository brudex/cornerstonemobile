
import 'package:cornerstone/ui/main_screens/donations/donation_failure.dart';
import 'package:cornerstone/ui/main_screens/donations/donation_success_screen.dart';
import 'package:cornerstone/ui/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';
import 'payment_page.dart';

class Donation extends StatefulWidget {
  @override
  State createState() => DonationState();
}

class DonationState extends State<Donation> {
  final _formKeyScreen1 = GlobalKey<FormState>();
  bool ready = false;
  TextEditingController _amountController;
  FocusNode _amountFocus;
  bool paymentMethod = true;
  bool donationType = true;
  bool amountEntered = true;

  // Initially password is obscure

  // ignore: unused_field
  String _amount;
  String _currentPaymentMethod;
  String _currentDonationType;

  var _paymentMethod = ["Visa, Mastercard & More", "PayPal"];

  List<String> _donations = [];
  List<int> _ids = [];
  Map<String, int> maps;

  Future performDonation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = "http://157.230.150.194:3000/api/initiatePaymentIntent";

    var data = {
      "amount": "${_amountController.text}",
      "paymentMode": "$_currentPaymentMethod" == 'Visa, Mastercard & More' ? 'stripe' : "$_currentPaymentMethod",
      "donationType": "${maps[_currentDonationType]}",
    };

    var token = "${prefs.getString('token')}";

    final response = await http.post(
      Uri.parse(url),
      body: data,
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );

    var message = jsonDecode(response.body);
    print(message);

    if (message['status'] == "00") {
      Navigator.pop(context);

      _navigateAndDisplaySelection(
          context, message['paymentUrl'], message['reference']);
      /*  Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentPage(
            paymentUrl: message['paymentUrl'],
            reference: message['reference'],
          ),
        ),
      ); */
    } else {
      Navigator.pop(context);

      failedAlertDialog(context, message['message'], message['reason']);
    }
  }

  @override
  void initState() {
    _amountController = TextEditingController();

    _amountFocus = FocusNode();

    super.initState();
    fetchDonationTypes();
  }

  void _navigateAndDisplaySelection(
      BuildContext context, String paymentUrl, String reference) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentPage(
          paymentUrl: paymentUrl,
          reference: reference,
        ),
      ),
    );

    print(result);

    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.

    if ("$result" == 'Failed') {
      setState(() {
        _amountController.clear();
      _currentPaymentMethod = null;
      _currentDonationType = null;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DonationFailure(),
        ),
      );
    } else if ("$result" == 'Success') {
       setState(() {
        _amountController.clear();
      _currentPaymentMethod = null;
      _currentDonationType = null;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DonationSuccess(),
        ),
      );
    }
  }

  Future fetchDonationTypes() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var url = "http://157.230.150.194:3000/api/donationTypes";

    var token = "${prefs.getString('token')}";

    final response = await http.get(
      Uri.parse(url),
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );

    final responseJson = jsonDecode(response.body);
    print('$responseJson' +
        'herrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrre  message 1 devotional');

    List<String> donationTypes = [];
    List<int> ids = [];

    for (var item in responseJson['data']) {
      donationTypes.add(item['donationType']);
      ids.add(item['id']);
    }

    if (this.mounted) {
      setState(() {
        _donations = donationTypes;
        _ids = ids;

        Map<String, int> map = new Map.fromIterables(_donations, _ids);

        print(map);
        maps = map;
        ready = true;
      });
    }

    //var value = jsonDecode(message['data']);
    //print(value);
  }

  // ignore: unused_element
  void _validate() {
    setState(() {
      _amount = _amountController.text;
    });
  }

  Future performDonate() async {
    if (_currentPaymentMethod == null) {
      setState(() {
        paymentMethod = false;
      });
    } else if (_currentPaymentMethod != null) {
      setState(() {
        paymentMethod = true;
      });
    }
    if (_currentDonationType == null) {
      setState(() {
        donationType = false;
      });
    } else if (_currentDonationType != null) {
      setState(() {
        donationType = true;
      });
    }
    if (_amountController.text == '') {
      amountEntered = false;
    } else if (_amountController.text != '') {
      amountEntered = true;
    }

    if (_currentPaymentMethod != null &&
        _currentDonationType != null &&
        _amountController.text != '') {
      showLoading(context);
      performDonation();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ready == false
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
        child: SafeArea(
          child:  Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: 15,
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
                            errorText: amountEntered
                                ? null
                                : "Please enter an amount to donate",
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
                              errorText: paymentMethod
                                  ? null
                                  : 'Please select a payment method',
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
                                    child: value == "Visa, Mastercard & More"
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(value),
                                              Text('  '),
                                              Image.asset('images/visa.jpeg', scale: 7,),
                                            ],
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(value),
                                              Text('  '),
                                              Image.asset('images/paypal.png',),
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
                              errorText: donationType
                                  ? null
                                  : 'Please select a donation type',
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
                                    print(maps[_currentDonationType]);
                                  });
                                },
                                items: _donations.map((var value) {
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
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: 250,
                        margin: EdgeInsets.only(top: 12, bottom: 5),
                        decoration: BoxDecoration(
                          //   color: Colors.blue,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Color(0xff4fc3f7), Color(0xff01579b)],
                          ),
                        ),
                        //width: 320,
                        height: 40,
                        // ignore: deprecated_member_use
                        child: FlatButton(
                          child: Text(' Donate',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                          onPressed: () {
                            performDonate();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
