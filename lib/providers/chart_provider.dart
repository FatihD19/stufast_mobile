import 'package:flutter/material.dart';
import 'package:stufast_mobile/models/chart_model.dart';
import 'package:stufast_mobile/services/chart_service.dart';

class ChartProvider with ChangeNotifier {
  List<ChartModel> _chart = [];
  List<ChartModel> get chart => _chart;

  set chart(List<ChartModel> chart) {
    _chart = chart;
    notifyListeners();
  }

  Future<void> getChart() async {
    try {
      List<ChartModel> chart = await ChartService().getChart();
      _chart = chart;
    } catch (e) {
      print(e);
    }
  }
}
