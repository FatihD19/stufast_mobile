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

  List<TalentHubModel> _talentPage = [];
  List<TalentHubModel> get talentPage => _talentPage;

  set talentPage(List<TalentHubModel> talentPage) {
    _talentPage = talentPage;
    notifyListeners();
  }

  DetailTalentHubModel? _detailTalent;
  DetailTalentHubModel? get detailTalent => _detailTalent;

  set detailTalent(DetailTalentHubModel? detailTalent) {
    _detailTalent = detailTalent;
    notifyListeners();
  }

  bool loading = true;
  bool error = false;

  Future<void> getTalentFilter(
      {bool? userFilter,
      String? sortBy,
      String? searchQuery,
      int? index}) async {
    try {
      List<TalentHubModel> talentPage = await TalentService()
          .getTalentHub(useFilter: userFilter, index: index);

      if (sortBy != null) {
        if (sortBy == 'average_score') {
          talentPage.sort((a, b) => b.averageScore.compareTo(a.averageScore));
          _talentPage = talentPage;
          notifyListeners();
        } else if (sortBy == 'total_course') {
          talentPage.sort((a, b) => b.totalCourse.compareTo(a.totalCourse));
          _talentPage = talentPage;
          notifyListeners();
        }
        _talentPage = talentPage;
        notifyListeners();
      }

      // Melakukan pencarian jika searchQuery ditentukan
      if (searchQuery != null && searchQuery.isNotEmpty) {
        talentPage = talentPage
            .where((t) =>
                t.fullname!.toLowerCase().contains(searchQuery.toLowerCase()))
            .toList();
        _talentPage = talentPage;
        notifyListeners();
      }
      _talentPage = talentPage;

      loading = false;
      notifyListeners();
    } catch (e) {
      error = true;
      print(e);
    }
  }

  Future<void> getTalentHub({int? index}) async {
    try {
      List<TalentHubModel> talent =
          await TalentService().getTalentHub(index: index);

      _talent.addAll(talent);
      loading = false;
      notifyListeners();
    } catch (e) {
      error = true;
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
