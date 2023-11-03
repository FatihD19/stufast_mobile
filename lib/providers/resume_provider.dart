import 'package:flutter/foundation.dart';
import 'package:stufast_mobile/models/resume_model.dart';
import 'package:stufast_mobile/services/resume_service.dart';

class ResumeProvider with ChangeNotifier {
  Resume? _resume;
  Resume? get resume => _resume;

  set resume(Resume? resume) {
    _resume = resume;
    notifyListeners();
  }

  Future<void> getresume(String idResume) async {
    try {
      Resume resume = await ResumeService().getResume(idResume);
      _resume = resume;
    } catch (e) {
      print(e);
    }
  }

  Future<bool> storeResume(String videoId, String resume, {bool? later}) async {
    try {
      await ResumeService().storeResume(videoId, resume, later: later);
      return true;
    } catch (e) {
      print('provider error $e');
      return false;
    }
  }

  Future<bool> updateResume(
      String resumeId, String videoId, String resume) async {
    try {
      final result =
          await ResumeService.updateResume(resumeId, videoId, resume);
      if (result) {
        notifyListeners();
      }
      return result;
    } catch (e) {
      print('provider error $e');
      return false;
    }
  }
}
