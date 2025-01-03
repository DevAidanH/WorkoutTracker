import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class myHeatmap extends StatelessWidget {
  final Map<DateTime, int>? datasets;

  const myHeatmap({
    super.key,
    required this.datasets,
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
        textColor: Colors.black,
        defaultColor: Colors.grey[400],
        weekTextColor: Colors.black,
        colorsets: const{
          1: Color(0xFFA3EE5B),
          2: Color(0xFF66D855),
          3: Color(0xFF40BA0F),
          4: Color(0xFF188300)
        }
      ),
    );
  }
}