import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stufast_mobile/models/cv_model.dart';
import 'package:stufast_mobile/services/cv/cv_services.dart';

class CvProvider with ChangeNotifier {
  CVmodel? _cv;
  CVmodel? get cv => _cv;

  set cv(CVmodel? cv) {
    _cv = cv;
    notifyListeners();
  }

  Future<void> getCV() async {
    try {
      CVmodel cv = await CVservice().getCV();
      _cv = cv;
      educations.addAll(cv.education!);
      exps.addAll(cv.job!);
      exps.addAll(cv.organization!);
      achs.addAll(cv.achievement!);

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<bool> updateCV(
      {String? about,
      String? instagram,
      String? facebook,
      String? linkedin,
      String? status,
      String? method}) async {
    try {
      bool result = await CVservice().updateCV(
          about: about,
          instagram: instagram,
          facebook: facebook,
          linkedin: linkedin,
          status: status,
          method: method);

      return result;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> uploadPortofolio(
    String id,
    File portoFile,
  ) async {
    try {
      final result = await CVservice().uploadPortofolio(id, portoFile);

      return result;
    } catch (e) {
      print(e);
      return false;
    }
  }

  List<Education> educations = [];
  int selectedEducationIndex = -1;

  List<Job> exps = [];
  int selectedExpIndex = -1;

  List<Achievement> achs = [];
  int selectedAchIndex = -1;

  // Education
  void addEducation(Education education) {
    educations.add(education);
    notifyListeners();
  }

  void editEducation(int index, Education education) {
    educations[index] = education;
    notifyListeners();
  }

  void deleteEducation(int index) {
    educations.removeAt(index);
    selectedEducationIndex = -1; // Reset selected index after deleting
    notifyListeners();
  }

  void setSelectedEducationIndex(int index) {
    selectedEducationIndex = index;
    notifyListeners();
  }

  void disposeEducation() {
    educations.clear();
    notifyListeners();
  }

  void clearSelectedEducationIndex() {
    selectedEducationIndex = -1;
    notifyListeners();
  }

// Experience
  void addExperience(Job job) {
    exps.add(job);
    notifyListeners();
  }

  void editExperience(int index, Job job) {
    exps[index] = job;
    notifyListeners();
  }

  void deleteExperience(int index) {
    exps.removeAt(index);
    selectedExpIndex = -1; // Reset selected index after deleting
    notifyListeners();
  }

  void setSelectedExperienceIndex(int index) {
    selectedExpIndex = index;
    notifyListeners();
  }

  void disposeExperience() {
    exps.clear();
    notifyListeners();
  }

  void clearSelectedExperienceIndex() {
    selectedExpIndex = -1;
    notifyListeners();
  }

  //Achievement
  void addAchievement(Achievement achievement) {
    achs.add(achievement);
    notifyListeners();
  }

  void editAchievement(int index, Achievement achievement) {
    achs[index] = achievement;
    notifyListeners();
  }

  void deleteAchievement(int index) {
    achs.removeAt(index);
    selectedAchIndex = -1; // Reset selected index after deleting
    notifyListeners();
  }

  void setSelectedAchievementIndex(int index) {
    selectedAchIndex = index;
    notifyListeners();
  }

  void disposeAchievement() {
    achs.clear();
    notifyListeners();
  }

  void clearSelectedAchievementIndex() {
    selectedAchIndex = -1;
    notifyListeners();
  }

  void disposeAll() {
    educations.clear();
    exps.clear();
    achs.clear();
    notifyListeners();
  }

  void clearAllselected() {
    selectedEducationIndex = -1;
    selectedExpIndex = -1;
    selectedAchIndex = -1;
    notifyListeners();
  }

  Future<bool> updateCVeducation() async {
    try {
      bool result = await CVservice().updateCVEducation(educations
          .map((e) => {
                "id": e.userEducationId,
                "status": e.status,
                "education_name": e.educationName,
                "major": e.major,
                "year": e.year,
              })
          .toList());
      return result;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updateCvExperience() async {
    try {
      bool result = await CVservice().updateExp(exps
          .map((e) => {
                "id": e.userExperienceId,
                "type": e.type,
                "instance_name": e.instanceName,
                "position": e.position,
                "year": e.year,
              })
          .toList());
      return result;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updateCvAchievement() async {
    try {
      bool result = await CVservice().updateAch(achs
          .map((e) => {
                "id": e.userAchievementId,
                "event_name": e.eventName,
                "position": e.position,
                "year": e.year,
              })
          .toList());
      return result;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
