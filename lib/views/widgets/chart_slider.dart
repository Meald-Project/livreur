import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'chart_button.dart';

class ChartSlider extends StatelessWidget {
  final List<List<FlSpot>> data;
  final List<String> timeFrames;
  final ValueChanged<String> onTimeFrameChanged;

  ChartSlider({
    required this.data,
    required this.timeFrames,
    required this.onTimeFrameChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index, int realIndex) {
        String currentTimeFrame = timeFrames[index];
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                currentTimeFrame,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 16),
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width - 50,
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(show: true),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              value.toString(),
                              style: TextStyle(color: Colors.black, fontSize: 12),
                            );
                          },
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              value.toString(),
                              style: TextStyle(color: Colors.black, fontSize: 12),
                            );
                          },
                        ),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: Border.all(color: Colors.black),
                    ),
                    minX: 0,
                    maxX: 3,
                    minY: 0,
                    maxY: 6,
                    lineBarsData: [
                      LineChartBarData(
                        spots: data[index],
                        isCurved: true,
                        color: const Color.fromARGB(255, 50, 121, 227),
                        dotData: FlDotData(show: false),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: timeFrames.map((timeFrame) {
                  return ChartButton(
                    timeFrame: timeFrame,
                    onPressed: () {
                      onTimeFrameChanged(timeFrame);
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
      options: CarouselOptions(
        height: 400,
        enlargeCenterPage: false,
        enableInfiniteScroll: false,
        viewportFraction: 1.0,
      ),
    );
  }
}
