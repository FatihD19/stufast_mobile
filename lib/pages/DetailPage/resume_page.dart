// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stufast_mobile/models/resume_model.dart';
import 'package:stufast_mobile/pages/DetailPage/detail_course_page.dart';
import 'package:stufast_mobile/providers/resume_provider.dart';
import 'package:stufast_mobile/services/resume_service.dart';
import 'package:stufast_mobile/widget/primary_button.dart';

import '../../theme.dart';

class ResumePage extends StatefulWidget {
  String? videoId;
  String? courseId;
  bool? isDetail;
  String? idResume;
  Resume? detail;
  ResumePage(this.videoId,
      {this.courseId, this.isDetail, this.idResume, this.detail, super.key});

  @override
  State<ResumePage> createState() => _ResumePageState();
}

class _ResumePageState extends State<ResumePage> {
  @override
  void initState() {
    // TODO: implement initState
    getInit();
    super.initState();
  }

  getInit() async {
    if (widget.isDetail == true) {
      // _resumeController.text = '${widget.detail?.resume}';
      await Provider.of<ResumeProvider>(context, listen: false)
          .getresume('${widget.idResume}');
      setState(() {
        _resumeController.text =
            Provider.of<ResumeProvider>(context, listen: false)
                    .resume
                    ?.resume ??
                '';
      });
    }
  }

  int? karakter;
  TextEditingController _resumeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ResumeProvider? resumeProvider = Provider.of<ResumeProvider>(context);

    Future<bool> showExitPopup() async {
      return await showDialog(
            //show confirm dialogue
            //the return value will be from "Yes" or "No" options
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Anda perlu mengerjakan Resume',
                  style: primaryTextStyle.copyWith(fontWeight: bold)),
              content: Text('Kerjakan Resume Nanti?', style: primaryTextStyle),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  //return false when click on "NO"
                  child:
                      Text('Tidak, kerjakan sekarang', style: buttonTextStyle),
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await resumeProvider.storeResume(
                          '${widget.videoId}', _resumeController.text,
                          later: true);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailCoursePage(
                                fromResumeOrQuiz: true,
                                idUserCourse: "${widget.courseId}")),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(
                            'gagal',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }
                  },
                  child: Text('Ya', style: buttonTextStyle),
                ),
              ],
            ),
          ) ??
          false; //if showDialouge had returned null, then return false
    }

    handleResume() async {
      if (_resumeController.text.length <= 100) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              'karakter resume kurang dari 100',
              textAlign: TextAlign.center,
            ),
          ),
        );
      } else if (_resumeController.text.length >= 1000) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              'karakter resume berlebihan',
              textAlign: TextAlign.center,
            ),
          ),
        );
      } else {
        if (widget.isDetail == true
            ? await ResumeService.updateResume('${widget.detail?.resumeId}',
                '${widget.videoId}', _resumeController.text)
            : await resumeProvider.storeResume(
                '${widget.videoId}', _resumeController.text)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                'Resume berhasil diUpdate',
                textAlign: TextAlign.center,
              ),
            ),
          );
          // widget.isDetail == true
          //     ? Navigator.pop(context)
          //     :
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DetailCoursePage(idUserCourse: '${widget.courseId}')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                'gagal',
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
      }
    }

    return WillPopScope(
      onWillPop: widget.isDetail == true
          ? () async {
              Navigator.pop(context);
              return true;
            }
          : showExitPopup,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            'Resume ',
            //${widget.detail?.resumeId} ${widget.videoId}
            style: primaryTextStyle.copyWith(fontWeight: semiBold),
          ),
          elevation: 0, // Menghilangkan shadow
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: widget.isDetail == true
                ? () {
                    Navigator.pop(context);
                  }
                : showExitPopup,
          ),
          backgroundColor: Colors.white,
          centerTitle: false,
        ),
        body: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              Text('Berikan Rangkuman dari materi yang telah kamu pelajari',
                  style: primaryTextStyle.copyWith(fontWeight: semiBold)),
              SizedBox(height: 16),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: double.infinity,
                  maxHeight: 350,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFFAFAFA), // Warna latar belakang FAFAFA
                    border: Border.all(
                      color: Color(0xff7D7D7D),
                      width: 2, // Border dengan stroke D2D2D2
                    ),
                    borderRadius: BorderRadius.circular(8), // Border radius 8
                  ),
                  child: TextField(
                    controller: _resumeController,
                    onChanged: (value) {
                      setState(() {});
                    },
                    style: primaryTextStyle.copyWith(fontSize: 15),
                    textAlign: TextAlign.justify,
                    maxLines: 15,
                    // controller: controller,
                    decoration: InputDecoration(
                      // hintText: hintText,
                      hintStyle: primaryTextStyle.copyWith(
                        fontWeight: semiBold,
                        fontSize: 14,
                      ),
                      contentPadding: EdgeInsets.all(12),
                      border: InputBorder
                          .none, // Tidak menampilkan border bawaan TextField
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('*) Minimal 100 Karakter', style: secondaryTextStyle),
                  Text('${_resumeController.text.length}/1000',
                      style: secondaryTextStyle),
                ],
              ),
              SizedBox(height: 24),
              Container(
                  width: double.infinity,
                  height: 54,
                  child:
                      PrimaryButton(text: 'Submit', onPressed: handleResume)),
            ],
          ),
        ),
      ),
    );
  }
}
