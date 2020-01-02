import 'package:flutter/material.dart';
import 'package:imadmin/utils/admincolors.dart';

class Portfolio extends StatefulWidget {
  Portfolio({Key key}) : super(key: key);

  @override
  PortfolioState createState() => PortfolioState();
}

class PortfolioState extends State<Portfolio>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AdminColors.fromHex("#212121"),
        body: SingleChildScrollView(
            child: Column(
          
              children: <Widget>[
                getTitle(context)
              ],
            ),
        ));
  }

  Row getTitle(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 8,
          child: Padding(
        padding: EdgeInsets.fromLTRB(32, 24, 24, 16),
        child: RichText(
          text: TextSpan(
            text: 'Edit Portfolio',
            style: TextStyle(color: Colors.white, fontSize: 16),
            children: <TextSpan>[
              TextSpan(
                  text:"" ,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26))
            ],
          ),
        )),
        ),
        
        Expanded(
          flex: 1,
          child: Padding(
          padding: EdgeInsets.fromLTRB(32, 24, 24, 16),
          child:  RaisedButton(onPressed: (){
              _showShotsDialog(context);
          },child: Text('Add More',style: TextStyle(fontSize: 20)),splashColor: Colors.lightBlueAccent,
                elevation: 4,),
        ),
        )
      ]
    );
  }

Future<void> _showShotsDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Not in stock'),
        content: const Text('This item is no longer available'),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

}