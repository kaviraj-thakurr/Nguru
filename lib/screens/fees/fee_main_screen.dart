import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class FeesMainScreen extends StatefulWidget {
  const FeesMainScreen({super.key});

  @override
  State<FeesMainScreen> createState() => _FeesMainScreenState();
}

class _FeesMainScreenState extends State<FeesMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}






 const Color arc_1 = Color(0xFF0160AE);
 const Color arc_2= Color(0xFF8D449A);
 const Color arc_3= Color(0xFF0261AE);
 const Color arc_4= Color(0xFFA0CB7C);
 const Color arc_5= Color(0xFFFF7E00);
 const Color arc_6= Color(0xFFFF4A45);

class DoughnutChart extends StatelessWidget {
  const DoughnutChart({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData('Category A', 20, [arc_1, arc_2]),
      ChartData('Category B', 20, [arc_3, arc_4]),
      ChartData('Category C', 20, [arc_5, arc_6]),
    ];

    final double total = chartData.map((e) => e.y).reduce((a, b) => a + b);

    return Scaffold(
      body: Center(
        child: SfCircularChart(
          series: <CircularSeries>[
            DoughnutSeries<ChartData, String>(
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
              pointShaderMapper: (dynamic data, int index, Color color, Rect rect) {
                return LinearGradient(
                  begin: Alignment.bottomLeft,
                end: Alignment.bottomRight,
                  colors: data.gradientColors,
                  stops:const [0.0, 1.0],
                ).createShader(rect);
              },
              dataLabelMapper: (ChartData data, _) {
                final percentage = (data.y / total) * 100;
                return '${percentage.toStringAsFixed(1)}%';
              },
              dataLabelSettings:const DataLabelSettings(
                isVisible: true,
                labelPosition: ChartDataLabelPosition.outside,
                textStyle: TextStyle(fontSize: 14, color: Colors.black),
              ),
              cornerStyle: CornerStyle.bothCurve,
              radius: '80%',
              innerRadius: '70%',
              explode: true,
              explodeOffset: '3%',
              explodeAll: true,
            )
          ],
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.gradientColors);
  final String x;
  final double y;
  final List<Color> gradientColors;
}