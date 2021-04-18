import 'package:flutter/material.dart';

class DonationHistory extends StatefulWidget {
  @override
  State createState() => DonationHistoryState();
}

class DonationHistoryState extends State<DonationHistory> {
  TextEditingController _searchController;
  FocusNode _searchFocus;

  // Initially password is obscure

  // ignore: unused_field
  String _search;
  


  void performDonationHistory() {
    //DonationHistory here
  }

  
  @override
  void initState() {
    _searchController = TextEditingController();

    _searchFocus = FocusNode();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
           
            Container(
              color: Color.fromRGBO(242, 245, 247, 1),
              child: Column(
                children: [
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
                      ),
                      Text('Donation History', style: TextStyle(fontSize: 20),)
                    ],
                  ),
                   Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16, bottom: 16),
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10.0),
                child: TextField(
                  focusNode: _searchFocus,
                  controller: _searchController,
                  obscureText: false,
                  textInputAction: TextInputAction.next,
                  onSubmitted: (input) {
                    _search = input;
                  },
                  onTap: () {},
                  decoration: InputDecoration(
                    
                    hintText: 'Search History',
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Colors.blue,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
            ),
                ],
              ),
            ),
           
          
           
             SizedBox(
                child: Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Today',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                height: 50,
              ),
            ListTile(
                leading: Image.asset('images/stripe.png'),

                title: Text(
                  'GHc 2,000.00',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'Tithe',
                  style: TextStyle(color: Colors.grey),
                ),
                trailing: Text(
                  'Success',
                  style: TextStyle(color: Colors.green),
                ),
              ),
              ListTile(
                leading: Image.asset('images/stripe.png'),

                title: Text(
                  'GHc 2,000.00',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'Offertory',
                  style: TextStyle(color: Colors.grey),
                ),
                trailing: Text(
                  'Success',
                  style: TextStyle(color: Colors.green),
                ),
              ),SizedBox(
                child: Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Yesterday',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                height: 50,
              ),
            ListTile(
                leading: Image.asset('images/paypal.png'),

                title: Text(
                  'GHc 2,000.00',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'Other seeds',
                  style: TextStyle(color: Colors.grey),
                ),
                trailing: Text(
                  'Failed',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              
             Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Powered by Cornerstone', style: TextStyle(color: Colors.grey),),
              )
            ),
          ],
        ),
      ),
    );
  }
}
