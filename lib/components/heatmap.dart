import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
//import 'package:workout_tracker/datetime/datetime.dart';

class myHeatmap extends StatelessWidget {
  final Map<DateTime, int>? datasets;
  //final String startDateYYYYMMDD;

  const myHeatmap({
    super.key,
    required this.datasets,
    //required this.startDateYYYYMMDD
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25),
      child: HeatMapCalendar(
        datasets: datasets,
        colorMode: ColorMode.color,
        showColorTip: false,
        margin: EdgeInsets.all(2),
        size: 45,
        textColor: Colors.white,
        defaultColor: Colors.grey,
        weekTextColor: Colors.black,
        colorsets: const{
          1: Colors.green,
        }
      ),
    );
  }
}