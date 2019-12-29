import 'package:bezier_chart/bezier_chart.dart';
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
        body: SingleChildScrollView(

          child: Container(
            color: AdminColors.fromHex("#212121"),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                getWelcomeText(widget.user.name),
                Table(children: [_buildTableRow()],),
                getKPITitle(),
                getDummyChart(context)
              ],
            ),
        )));
  }

  Padding getKPITitle(){
    return Padding(
      padding: EdgeInsets.fromLTRB(32, 32, 24, 0),
      child: Text("KPI for your website",
      style:TextStyle(fontSize: 26,color:Colors.white,fontWeight: FontWeight.bold)),
    );
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
      _getCardRandom("#F44336", "Active Users", "30"),
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

Center getDummyChart(BuildContext context){
  return Center(
    child: Container(
      color: AdminColors.fromHex("#03A9F4"),
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width * 0.9,
      child: BezierChart(
        bezierChartScale: BezierChartScale.CUSTOM,
        xAxisCustomValues: const [0, 5, 10, 15, 20, 25, 30, 35],
        series: const [
          BezierLine(
            data: const [
              DataPoint<double>(value: 10, xAxis: 0),
              DataPoint<double>(value: 130, xAxis: 5),
              DataPoint<double>(value: 50, xAxis: 10),
              DataPoint<double>(value: 45, xAxis: 15),
              DataPoint<double>(value: 75, xAxis: 20),
              DataPoint<double>(value: 40, xAxis: 25),
              DataPoint<double>(value: 105, xAxis: 30),
              DataPoint<double>(value: 145, xAxis: 35),
            ],
          ),
        ],
        config: BezierChartConfig(
          verticalIndicatorStrokeWidth: 6.0,
          verticalIndicatorColor: Colors.black26,
          showVerticalIndicator: true,
          backgroundColor: AdminColors.fromHex("#212121"),
          snap: false,
        ),
      ),
    ),
  );
}
