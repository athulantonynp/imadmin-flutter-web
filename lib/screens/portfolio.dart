import 'package:flutter/material.dart';
import 'package:imadmin/api/imadminapi.dart';
import 'package:imadmin/models/shot.dart';
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
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        title: Text('Edit Portfolio'),
        content: getFutureBuilder(context),
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

  InkWell getShotCard(Shot shot){
    return InkWell(
      onTap: (){
        print(shot.id);
      },
      child:  Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Image.network(
            shot.images.normal,
            fit: BoxFit.fill,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 3
        ),
    );

  }


FutureBuilder<List<Shot>> getFutureBuilder(BuildContext context){
  var listFuture=MonsterAdminApi().getShots();
  return FutureBuilder(
      future: listFuture,
      builder: (context,snap){
      if(snap.hasData){
      return Container(
        
        width: MediaQuery.of(context).size.width-(50),
        child:  GridView.builder(
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                                   crossAxisCount: 4),
        itemCount: snap.data.length,
        itemBuilder: (context, index) {
          Shot shot = snap.data[index];
          return Column(
            children: <Widget>[
              Padding(child: getShotCard(shot),padding: EdgeInsets.fromLTRB(16, 0, 16, 0),)
            ],
          );
        },
      )
      );
      }else{
        return Container(
           child: new Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            new CircularProgressIndicator(),
            new Text("Loading Shots"),
          ],
        ),
        );
      }

      }
      
  );


}
}