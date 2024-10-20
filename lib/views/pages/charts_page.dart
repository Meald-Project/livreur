import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../widgets/chart_slider.dart';

class ChartPage extends StatefulWidget {
  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  int _currentChartIndex = 0;

  List<List<FlSpot>> _data = [
    [FlSpot(0, 1), FlSpot(1, 3), FlSpot(2, 2), FlSpot(3, 5)],
    [FlSpot(0, 2), FlSpot(1, 4), FlSpot(2, 1), FlSpot(3, 6)],
  ];

  List<String> _timeFrames = ['Aujourd\'hui', 'Semaine Dernière', 'Mois Dernier', 'Tout'];

  void _updateChartData(String timeFrame) {
    // Your existing logic for updating chart data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Charts Carousel', style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0))),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: ChartSlider(
              data: _data,
              timeFrames: _timeFrames,
              onTimeFrameChanged: (timeFrame) {
                _updateChartData(timeFrame);
                setState(() {
                  _currentChartIndex = _timeFrames.indexOf(timeFrame);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
