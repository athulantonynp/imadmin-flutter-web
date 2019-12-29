import 'package:flutter/material.dart';
import 'package:imadmin/models/user.dart';
import 'package:imadmin/utils/admincolors.dart';

class Home extends StatefulWidget {
  final User user;

  const Home(this.user);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AdminColors.fromHex("#212121"),
        body: Container(
            color: AdminColors.fromHex("#212121"),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                getWelcomeText(widget.user.name),
                Table(
                  children: [_buildTableRow()],
                )
              ],
            )));
  }

  Padding getWelcomeText(String name) {
    return Padding(
        padding: EdgeInsets.fromLTRB(32, 24, 24, 16),
        child: RichText(
          text: TextSpan(
            text: 'Welcome ',
            style: TextStyle(color: Colors.white, fontSize: 16),
            children: <TextSpan>[
              TextSpan(
                  text: name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26))
            ],
          ),
        ));
  }

  TableRow _buildTableRow() {
    return TableRow(children: [
      _getCardRandom("#FF9800", "Active Users", "30"),
      _getCardRandom("#607D8B", "Downloads", "12k"),
      _getCardRandom("#2196F3", "Rating", "4.5")
    ]);
  }
}

Card _getCardRandom(String color, String title, String value) {
  return Card(
    semanticContainer: true,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    color: AdminColors.fromHex(color),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            title,
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(24, 0, 16, 16),
          child: Text(
            value,
            style: TextStyle(
                color: Colors.white, fontSize: 80, fontWeight: FontWeight.bold),
          ),
        )
      ],
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
    ),
    elevation: 8,
    margin: EdgeInsets.all(16),
  );
}
