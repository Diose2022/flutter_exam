import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ProjectStatisticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Statistiques de projet"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Progrès des projets",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            _buildProgressChart(),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressChart() {
    return SizedBox(
      height: 300, // Give a fixed height
      child: BarChart(
        BarChartData(
          gridData: FlGridData(show: true),
          titlesData: FlTitlesData(
            show: true,
            leftTitles: AxisTitles(
              axisNameWidget: Text('Progrès'),
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  if (value == 0.0) return Text('0');
                  if (value == 5.0) return Text('50%');
                  if (value == 10.0) return Text('100%');
                  return Text('');
                },
              ),
            ),
            bottomTitles: AxisTitles(
              axisNameWidget: Text('Projets'),
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  if (value == 0.0) return Text('Projet 1');
                  if (value == 1.0) return Text('Projet 2');
                  if (value == 2.0) return Text('Projet 3');
                  return Text('');
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: true),
          barGroups: [
            BarChartGroupData(x: 0, barRods: [
              BarChartRodData(toY: 10.0, color: Colors.orangeAccent),
            ]),
            BarChartGroupData(x: 1, barRods: [
              BarChartRodData(toY: 5.0, color: Colors.blue),
            ]),
            BarChartGroupData(x: 2, barRods: [
              BarChartRodData(toY: 3.0, color: Colors.green),
            ]),
          ],
        ),
      ),
    );
  }
}