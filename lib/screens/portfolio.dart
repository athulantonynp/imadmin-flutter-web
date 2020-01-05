import 'package:flutter/material.dart';
import 'package:imadmin/api/imadminapi.dart';
import 'package:imadmin/models/shot.dart';
import 'package:imadmin/screens/editshot.dart';
import 'package:imadmin/utils/admincolors.dart';

class Portfolio extends StatefulWidget {
  Portfolio({Key key}) : super(key: key);

  @override
  PortfolioState createState() => PortfolioState();
}

class PortfolioState extends State<Portfolio>{

   List<Shot> popupShots=new List();
   List<Shot> actualShots=new List();

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

  Widget getCurrentShots(){
    
  }

  _onEditShotUpdated(){
    setState(() {
       actualShots.clear();
        actualShots.addAll(popupShots);
        MonsterAdminApi().saveShotsToServer(popupShots);
    });
   
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
            showDialog(
              context: context,
              child: EditShotDialog(popupShots,_onEditShotUpdated)
            );
          },child: Text('Update',style: TextStyle(fontSize: 20)),splashColor: Colors.lightBlueAccent,
                elevation: 4,),
        ),
        )
      ]
    );
  }

}