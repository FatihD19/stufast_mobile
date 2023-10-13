import 'package:flutter/material.dart';
import 'package:stufast_mobile/models/talent_hub_model.dart';
import 'package:stufast_mobile/services/TalentHub/talentHub_service.dart';

class TalentHubProvider with ChangeNotifier {
  List<TalentHubModel> _talent = [];
  List<TalentHubModel> get talent => _talent;

  set talent(List<TalentHubModel> talent) {
    _talent = talent;
    notifyListeners();
  }

  DetailTalentHubModel? _detailTalent;
  DetailTalentHubModel? get detailTalent => _detailTalent;

  set detailTalent(DetailTalentHubModel? detailTalent) {
    _detailTalent = detailTalent;
    notifyListeners();
  }

  bool loading = true;
  Future<void> getTalentHub({String? sortBy, String? searchQuery}) async {
    try {
      List<TalentHubModel> talent = await TalentService().getTalentHub();
      // Melakukan sorting berdasarkan kriteria tertentu jika sortBy ditentukan
      if (sortBy != null) {
        if (sortBy == 'average_score') {
          talent.sort((a, b) => b.averageScore.compareTo(a.averageScore));
          _talent = talent;
          notifyListeners();
        } else if (sortBy == 'total_course') {
          talent.sort((a, b) => b.totalCourse.compareTo(a.totalCourse));
          _talent = talent;
          notifyListeners();
        }
        _talent = talent;
        notifyListeners();
      }

      // Melakukan pencarian jika searchQuery ditentukan
      if (searchQuery != null && searchQuery.isNotEmpty) {
        talent = talent
            .where((t) =>
                t.fullname!.toLowerCase().contains(searchQuery.toLowerCase()))
            .toList();
        _talent = talent;
        notifyListeners();
      }
      _talent = talent;
      loading = false;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> getDetailTalentHub(String id) async {
    try {
      DetailTalentHubModel detailTalent =
          await TalentService().getDetailTalent(id);
      _detailTalent = detailTalent;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
