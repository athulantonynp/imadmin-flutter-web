import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:imadmin/utils/admincolors.dart';
import 'package:flutter/foundation.dart';


class MonsterBar extends StatefulWidget implements PreferredSizeWidget {

    var isLoggedIn=false;

    MonsterBar(this.isLoggedIn, {Key key}) : preferredSize = Size.fromHeight(60.0), super(key: key);
    

    @override
    final Size preferredSize; // default is 56.0

    @override
    MonsterBarState createState() => MonsterBarState();
}

class MonsterBarState extends State<MonsterBar>{

    String getTitleIcon(){
      if(kReleaseMode){ 
          return "web/assets/im_main.png";
        } else {
            return "im_main.png";
        }
    }
    @override
    Widget build(BuildContext context) {
        return  new Container(
        height: 60.0,
        decoration: new BoxDecoration(
            color: Colors.black,
            boxShadow: [
              BoxShadow(
                color: AdminColors.fromHex("#181d24"),
                blurRadius: 20.0,
                spreadRadius: 1.0,
                offset: Offset(
                  1.0, 
                  1.0,
                ),
              )
            ],
          ),


      child: new Row(
        children: <Widget>[

            widget.isLoggedIn==true ? Padding(
              child:IconButton(icon: Icon(Icons.menu,color: Colors.white,),
              onPressed: (){
                Scaffold.of(context).openDrawer();
              },) ,
              padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
            ) : Container(),
            Padding(
              child:Image.asset(getTitleIcon()) ,
              padding: EdgeInsets.fromLTRB(24, 0, 0, 0),
            ),
            Padding(
              child:Text("| Admin",style: TextStyle(
                color: Colors.white,
                fontSize: 20
              ),) ,
              padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
            )
            
        ],
      )
);
    }
}