import 'package:auto_size_text/auto_size_text.dart';
import 'package:bezier_chart/bezier_chart.dart';
import 'package:flutter/material.dart';
import 'package:imadmin/models/user.dart';
import 'package:imadmin/utils/admincolors.dart';
import 'package:pie_chart/pie_chart.dart';

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                getWelcomeText(widget.user.name),
                Table(children: [_buildTableRow()],),
                getKPITitle(),
                _buildKpiRow(context)
                
              ],
            ),
        ));
  }

  Row _buildKpiRow(BuildContext context){
      return Row(
        children: <Widget>[
          getDummyChart(context),
            getPieChart(context)
        ],
      );
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
      _getCardRandom("#F44336", "Active Users", "300"),
      _getCardRandom("#607D8B", "Downloads", "12k"),
      _getCardRandom("#2196F3", "Rating", "4.5"),
      _getCardRandom("#673AB7", "Drop-Offs", "12"),
      _getCardRandom("#009688", "Retention", "5.8")
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
          padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
          child: AutoSizeText(
            title,
            style: TextStyle(
                color: AdminColors.fromHex("#f5f5f5"), fontSize: 24, fontWeight: FontWeight.bold),
                maxLines: 1,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(24, 0, 16, 16),
          child: AutoSizeText(
            value,
            style: TextStyle(
                color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold),
                maxLines: 1,
          ),
        )
      ],
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
    ),
    elevation: 8,
    margin: EdgeInsets.all(8),
  );
}

Center getDummyChart(BuildContext context){
  return Center(
    child: Container(
      color: AdminColors.fromHex("#212121"),
      height: MediaQuery.of(context).size.height / 1.5,
      width: MediaQuery.of(context).size.width/2 ,
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
          verticalIndicatorStrokeWidth: 12.0,
          verticalIndicatorColor: AdminColors.fromHex("#212121"),
          showVerticalIndicator: true,
          backgroundColor: AdminColors.fromHex("#212121"),
          snap: true,
        ),
      ),
    ),
  );
}


Center getPieChart(BuildContext context){
  Map<String, double> dataMap = new Map();
dataMap.putIfAbsent("Web", () => 5);
dataMap.putIfAbsent("Android", () => 3);
dataMap.putIfAbsent("ios", () => 2);
dataMap.putIfAbsent("Windows", () => 2);
  return Center(

    child:  PieChart(
        dataMap: dataMap,
        animationDuration: Duration(milliseconds: 800),
        chartLegendSpacing: 32.0,
        chartRadius: MediaQuery.of(context).size.width / 5,
        showChartValuesInPercentage: true,
        showChartValues: false,
        showChartValuesOutside: false,
        chartValueBackgroundColor: Colors.white,
        colorList: [
          AdminColors.fromHex("#F44336"),
          AdminColors.fromHex("#607D8B"),
          AdminColors.fromHex("#2196F3"),
          AdminColors.fromHex("#673AB7"),
          AdminColors.fromHex("#009688")
        ],
        showLegends: true,
        legendStyle:TextStyle(color: Colors.white) ,
        legendPosition: LegendPosition.right,
        decimalPlaces: 1,
        showChartValueLabel: true,
        initialAngle: 0,
        chartValueStyle: defaultChartValueStyle.copyWith(
          color: Colors.blueGrey[900].withOpacity(0.9),
        ),
        chartType: ChartType.disc,
    ),
  );
}
