import 'package:flutter/material.dart';
import 'package:stufast_mobile/models/talent_hub_model.dart';

import 'package:stufast_mobile/services/TalentHub/talentHub_service.dart';

class TalentHubProvider with ChangeNotifier {
  TalentHubModel? _talent;
  TalentHubModel? get talent => _talent;

  List<Talent> _talentList = [];
  List<Talent> get talentList => _talentList;

  int totalItemTalent = 0;

  set talent(TalentHubModel? talent) {
    _talent = talent;
    notifyListeners();
  }
  // TalentHubModel _talentPage ;
  // TalentHubModel get talentPage => _talentPage;

  // set talentPage(TalentHubModel talentPage) {
  //   _talentPage = talentPage;
  //   notifyListeners();
  // }

  // TalentHubModel _talentFilter ;
  // TalentHubModel get talentFilter => _talentFilter;

  // set talentFilter(TalentHubModel talentFilter) {
  //   _talentFilter = talentFilter;
  //   notifyListeners();
  // }

  DetailTalentHubModel? _detailTalent;
  DetailTalentHubModel? get detailTalent => _detailTalent;

  set detailTalent(DetailTalentHubModel? detailTalent) {
    _detailTalent = detailTalent;
    notifyListeners();
  }

  bool loading = true;
  bool error = false;
  bool loadingPagination = false;

  bool isEmpty = false;

  // Future<void> getTalentFilter(
  //     {bool? userFilter,
  //     String? sortBy,
  //     String? searchQuery,
  //     int? index}) async {
  //   try {
  //     TalentHubModel talentPage = await TalentService()
  //         .getTalentHub(useFilter: userFilter, index: index);

  //     if (sortBy != null) {
  //       if (sortBy == 'average_score') {
  //         talentPage.sort((a, b) => b.averageScore.compareTo(a.averageScore));
  //         _talentPage = talentPage;
  //         notifyListeners();
  //       } else if (sortBy == 'total_course') {
  //         talentPage.sort((a, b) => b.totalCourse.compareTo(a.totalCourse));
  //         _talentPage = talentPage;
  //         notifyListeners();
  //       }
  //       _talentPage = talentPage;
  //       notifyListeners();
  //     }

  //     // Melakukan pencarian jika searchQuery ditentukan
  //     if (searchQuery != null && searchQuery.isNotEmpty) {
  //       talentPage = talentPage
  //           .where((t) =>
  //               t.fullname!.toLowerCase().contains(searchQuery.toLowerCase()))
  //           .toList();
  //       _talentPage = talentPage;
  //       notifyListeners();
  //     }
  //     _talentPage = talentPage;

  //     loading = false;
  //     notifyListeners();
  //   } catch (e) {
  //     error = true;
  //     print(e);
  //   }
  // }

  Future<void> getTalentHub(
      {String? sort,
      int? index,
      String? searchQuery,
      String? status,
      String? method}) async {
    try {
      isEmpty = false;
      TalentHubModel talent = await TalentService().getTalentFilter(
          sort: sort,
          index: index,
          searchQuery: searchQuery,
          status: status,
          method: method);
      if (talent.talent!.isEmpty) {
        isEmpty = true;
      }
      _talentList.addAll(talent.talent!);
      totalItemTalent = talent.totalItem!;
      loading = false;
      notifyListeners();
    } catch (e) {
      error = true;
      print(e);
    }
  }

  // Future<void> getTalentFilterPagination(
  //     {String? sort, int? index, String? searchQuery}) async {
  //   try {
  //     TalentHubModel talentFilter = await TalentService()
  //         .getTalentFilter(sort: sort, index: index, searchQuery: searchQuery);
  //     _talentFilter = talentFilter;
  //     loadingPagination = false;
  //     notifyListeners();
  //   } catch (e) {
  //     print(e);
  //   }
  // }

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

  resetTalent() {
    _talent = null;
    _talentList = [];
    totalItemTalent = 0;
    notifyListeners();
  }
}
