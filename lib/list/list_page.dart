import 'package:flutter/material.dart';


class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back, color: Colors.black),
        elevation: 0,
        backgroundColor: Color.fromRGBO(242, 245, 247, 1),
        title: Text(
          'My List',
          style: TextStyle(color: Colors.black),
        ),
   
      ),
      body: ListView(
        children: [
          Row(children: [
            Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 15, right: 15, bottom: 10),
              child: Text('Today', style: TextStyle(color: Colors.black, fontSize: 20),),
            )
          ],),
          ListTile(
            leading: Image.asset('images/list_image.png'),
            title: Text('The Law of Process'),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text('1hr 24mins', style: TextStyle(fontSize: 12),),
            ),
            trailing: Icon(Icons.more_vert, color: Colors.black),
          )
        ],
      )
    );
  }
}
