import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:news_app/helpers/constants.dart';

class PriceListChart extends StatelessWidget {
  const PriceListChart({
    super.key,
    required this.localPriceList,
    required this.isLocal,
  });

  final List localPriceList;
  final bool isLocal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: AspectRatio(
        aspectRatio: 1.2,
        child: LineChart(
          LineChartData(
            borderData: FlBorderData(
              show: true,
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.shade400,
                  width: 2,
                ),
                left: BorderSide(
                  color: Colors.grey.shade400,
                  width: 2,
                ),
              ),
            ),
            gridData: FlGridData(
              show: true,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: Colors.grey.shade300,
                  strokeWidth: 0.8,
                );
              },
              drawVerticalLine: false,
            ),
            titlesData: FlTitlesData(
              show: true,
              rightTitles: AxisTitles(),
              topTitles: AxisTitles(),
            ),
            lineBarsData: [
              LineChartBarData(
                spots: localPriceList
                    .map(
                      (price) => FlSpot(
                        double.parse(price.index.toString()),
                        double.parse(isLocal ? price.priceLocal : price.priceGlobal),
                      ),
                    )
                    .toList(),
                belowBarData: BarAreaData(
                  show: true,
                  color: Color.fromARGB(60, 13, 139, 118),
                ),
                isCurved: true,
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (p0, p1, p2, p3) {
                    return FlDotCirclePainter(
                      color: Colors.white,
                      radius: 2,
                    );
                  },
                ),
                curveSmoothness: 0.2,
                barWidth: 2,
                isStrokeCapRound: true,
              ),
            ],
            minY: 1970 - 50,
            maxY: 2000 + 50,
            lineTouchData: LineTouchData(enabled: true),
          ),
        ),
      ),
    );
  }
}
