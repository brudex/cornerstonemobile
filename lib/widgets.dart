import 'package:flutter/material.dart';

class StyledButton extends StatelessWidget {

  final String title;

  const StyledButton({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
                  margin: EdgeInsets.only(top: 32, bottom: 5),
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
                  width: 320,
                  child: FlatButton(
                    child: Text(title,
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    onPressed: () {},
                  ),
                );
  }
}