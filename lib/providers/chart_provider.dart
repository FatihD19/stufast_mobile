import 'package:flutter/material.dart';
import 'package:stufast_mobile/models/chart_model.dart';
import 'package:stufast_mobile/services/chart_service.dart';

class ChartProvider with ChangeNotifier {
  ChartModel? _chart;
  ChartModel? get chart => _chart;

  set chart(ChartModel? chart) {
    _chart = chart;
    notifyListeners();
  }

  Future<void> getChart() async {
    try {
      ChartModel chart = await ChartService().getChart();
      _chart = chart;
    } catch (e) {
      print(e);
    }
  }

  Future<bool> addToChart(String type, String id) async {
    try {
      await ChartService().addChart(type, id);
      return true;
    } catch (e) {
      print('provider error $e');
      return false;
    }
  }

  Future<bool> deleteToChart(String id) async {
    try {
      await ChartService().deleteChart(id);
      return true;
    } catch (e) {
      print('provider delete error $e');
      return false;
    }
  }
}
