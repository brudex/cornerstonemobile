import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../widgets.dart';

class ListEmptyPage extends StatelessWidget {
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
      body: Column(
        children: [
          Container(child: Center(child: SvgPicture.asset('images/empty.svg'),),),
             Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: StyledButton(
              title: 'Explore Sermons and Devotions',
            ),),
        ],
      ),
    );
  }
}
