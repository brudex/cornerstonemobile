import 'package:flutter/material.dart';

class Terms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromRGBO(242, 245, 247, 1),
        title: Text('Terms of Services', style: TextStyle(color: Colors.black ),),
        leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.black,), onPressed: () {  Navigator.pop(context);}),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            
            Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16.0, top: 16, bottom: 4),
              child: Row(
                children: [
                  Text(
                    'Cornerstone - Terms of Services',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Terms of service are a set of guidelines and rules that must be honored by an organization ' +
                      'or an individual if they want to use a certain service. In general, terms of service agreement is legally binding, but if it violates ' +
                      "some law on a local, or federal level it's not. \n" +
                      "\nTerms of service are subjected to change and " +
                      "if they do change, the person or the company providing a service needs to notify all the " +
                      "users in a timely manner.\n" +
                      "\nWebsites and mobile apps that only provide their visitors with information or sell products " +
                      "usually don't require terms of service, but if we are talking about providers that offer " +
                      "services online or on a site that will keep the user's personal data, then the terms of " +
                      "service agreement is required. \n" +
                      "\nSome of the broadest examples where the terms of service agreement is " +
                      "mandatory include social media, financial transaction websites and online auctions.",
                  style: TextStyle(fontSize: 15.0, color: Colors.grey),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Powered by Cornerstone',
                style: TextStyle(fontSize: 15.0, color: Colors.grey),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
