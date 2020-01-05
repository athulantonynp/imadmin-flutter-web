import 'package:flutter/material.dart';
import 'package:imadmin/api/imadminapi.dart';
import 'package:imadmin/models/shot.dart';

class EditShotDialog extends StatefulWidget {
  List<Shot> popupShots;
  Function onEditShotUpdated;

  EditShotDialog(this.popupShots, this.onEditShotUpdated);
  @override
  State<StatefulWidget> createState() {
    return EditShotDialogState();
  }
}

class EditShotDialogState extends State<EditShotDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0))),
      title: Text('Edit Portfolio'),
      content: getFutureBuilder(context, widget.popupShots, this),
      actions: <Widget>[
       
        FlatButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),

         FlatButton(
          child: Text('Update'),
          onPressed: () {
             Navigator.of(context).pop();
            widget.onEditShotUpdated();
          },
        )       ],
    );
  }
}

InkWell getShotCard(
    Shot shot, int index, List<Shot> shots, EditShotDialogState state) {
  return InkWell(
    onTap: () {
      state.setState(() {
        shots[index].isSelected = !shots[index].isSelected;
      });
    },
    child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Stack(
          children: <Widget>[
            Image.network(
              shot.images.normal,
              fit: BoxFit.fill,
            ),
            getSelectedStateWidget(shots[index].isSelected)
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 3),
  );
}

Widget getSelectedStateWidget(bool isSelected) {
  if (isSelected) {
    return new RawMaterialButton(
      onPressed: () {},
      child: new Icon(
        Icons.check,
        color: Colors.greenAccent,
        size: 20.0,
      ),
      shape: new CircleBorder(),
      elevation: 1.0,
      fillColor: Colors.white
    );
  } else {
    return Container();
  }
}

FutureBuilder<List<Shot>> getFutureBuilder(BuildContext context,
    List<Shot> shots, EditShotDialogState editShotDialogState) {
  var listFuture = MonsterAdminApi().getShots();
  return FutureBuilder(
      future: listFuture,
      builder: (context, snap) {
        if (snap.hasData) {
          shots.addAll(snap.data);
          return Container(
              width: MediaQuery.of(context).size.width - (50),
              child: GridView.builder(
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemCount: snap.data.length,
                itemBuilder: (context, index) {
                  Shot shot = snap.data[index];
                  return Column(
                    children: <Widget>[
                      Padding(
                        child: getShotCard(
                            shot, index, shots, editShotDialogState),
                        padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                      )
                    ],
                  );
                },
              ));
        } else {
          return Container(
            child: new Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 8, 0),
                  child: new CircularProgressIndicator()  ,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: new Text("Loading Shots"),
                )
              ],
            ),
          );
        }
      });
}
