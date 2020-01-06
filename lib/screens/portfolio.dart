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

    Future<List<Shot>> currentShots;

   @override
  void initState() {
    super.initState();
    currentShots=MonsterAdminApi().getCurrentShots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AdminColors.fromHex("#212121"),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
            getTitle(context),
             getCurrentShots(context, currentShots)
          ],
          ),
        ),
        );
  }

  FutureBuilder<List<Shot>> getCurrentShots(BuildContext context,Future<List<Shot>> future){
    return FutureBuilder<List<Shot>>(

      future: future,
      builder: (context,snapshot){
         if (snapshot.hasData) {
                return  GridView.builder(
                  shrinkWrap: true,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      Padding(
                        child: getShotCard(snapshot.data[index]),
                        padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                      )
                    ],
                  );
                },
              );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
      },


    );
  }

  InkWell getShotCard(Shot shot) {
  return InkWell(
    onTap: () {},
    child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Stack(
          children: <Widget>[
            Image.network(
              shot.images.normal,
              fit: BoxFit.fill,
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 3),
  );
}

    _displaySnackBar(BuildContext context,String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  _onEditShotUpdated(){
    setState(() {
        _showShotSaveDialog(context);
        actualShots.clear();
        actualShots.addAll(popupShots);
       MonsterAdminApi().saveShotsToServer(popupShots).then(_onShotEditResponse);
      
    });
   
  }

  _onShotEditResponse(int result){
      Navigator.of(context, rootNavigator: true).pop('dialog');
            if(result==200){
              _displaySnackBar(context, "Shots updated successfully");
            }else{
              _displaySnackBar(context, "Failed to update shots.Please try again");
   } 
  }

  _showShotSaveDialog(BuildContext context){
    showDialog(
      
        barrierDismissible: false,
        context: context,
         builder: (_) => new AlertDialog(
           shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0))),
            title: new Text("Saving Shots"),
            content: new Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 8, 0),
                  child: new CircularProgressIndicator()  ,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: new Text("Please Wait.."),
                )
              ],
            ),
        )
    );
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
            popupShots.clear();
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