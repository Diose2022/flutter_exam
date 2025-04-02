import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AdminDashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tableau de Bord Administrateur'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildProjectStatusChart(),
            SizedBox(height: 20),
            _buildUserStatusChart(),
            SizedBox(height: 20),
            _buildCompletionRateChart(),
            SizedBox(height: 20),
            _buildTeamPerformanceChart(),
            SizedBox(height: 20),
            _buildUserManagement(),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectStatusChart() {
    return SfCircularChart(
      title: ChartTitle(text: 'Statut des Projets'),
      legend: Legend(isVisible: true),
      series: <CircularSeries>[
        PieSeries<_ChartData, String>(
          dataSource: [
            _ChartData('En cours', 40),
            _ChartData('Annulés', 30),
            _ChartData('Terminés', 30),
          ],
          xValueMapper: (data, _) => data.label,
          yValueMapper: (data, _) => data.value,
          dataLabelSettings: DataLabelSettings(isVisible: true),
        )
      ],
    );
  }

  Widget _buildUserStatusChart() {
    return SfCartesianChart(
      title: ChartTitle(text: 'Statut des Utilisateurs'),
      primaryXAxis: CategoryAxis(),
      series: <CartesianSeries>[
        ColumnSeries<_ChartData, String>(
          dataSource: [
            _ChartData('Actifs', 120),
            _ChartData('Inactifs', 80),
          ],
          xValueMapper: (data, _) => data.label,
          yValueMapper: (data, _) => data.value,
          dataLabelSettings: DataLabelSettings(isVisible: true),
        )
      ],
    );
  }

  Widget _buildCompletionRateChart() {
    return SfCircularChart(
      title: ChartTitle(text: 'Taux de Complétion des Projets'),
      series: <CircularSeries>[
        DoughnutSeries<_ChartData, String>(
          dataSource: [
            _ChartData('Complété', 75),
            _ChartData('Restant', 25),
          ],
          xValueMapper: (data, _) => data.label,
          yValueMapper: (data, _) => data.value,
          dataLabelSettings: DataLabelSettings(isVisible: true),
        )
      ],
    );
  }

  Widget _buildTeamPerformanceChart() {
    return SfCartesianChart(
      title: ChartTitle(text: 'Performance des Équipes'),
      primaryXAxis: CategoryAxis(),
      series: <CartesianSeries>[
        ColumnSeries<_ChartData, String>(
          dataSource: [
            _ChartData('Équipe A', 90),
            _ChartData('Équipe B', 70),
            _ChartData('Équipe C', 60),
            _ChartData('Équipe D', 80),
          ],
          xValueMapper: (data, _) => data.label,
          yValueMapper: (data, _) => data.value,
          dataLabelSettings: DataLabelSettings(isVisible: true),
        )
      ],
    );
  }

  Widget _buildUserManagement() {
    return ListTile(
      title: Text('Utilisateur 1'),
      trailing: Switch(
        value: true,
        onChanged: (bool value) {
          // Logique pour activer/désactiver le compte utilisateur
        },
      ),
    );
  }
}

class _ChartData {
  final String label;
  final double value;
  _ChartData(this.label, this.value);
}
