// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stufast_mobile/pages/DetailPage/detail_course_page.dart';
import 'package:stufast_mobile/pages/DetailPage/quiz_page.dart';
import 'package:stufast_mobile/pages/DetailPage/resume_page.dart';

import '../../models/quiz_model.dart';
import '../../providers/quiz_provider.dart';
import '../../theme.dart';
import '../../widget/primary_button.dart';

class QuizResultPage extends StatefulWidget {
  bool? quizPass;
  int? quizScore;
  String? id;

  String? title;
  String? idCourse;

  QuizResultPage(this.quizPass, this.quizScore, this.id,
      {this.title, this.idCourse});

  @override
  State<QuizResultPage> createState() => _QuizResultPageState();
}

class _QuizResultPageState extends State<QuizResultPage> {
  List<QuizModel>? detailQuiz;
  @override
  Widget build(BuildContext context) {
    var soalBenar = widget.quizScore! ~/ 20;
    var soalSalah = (100 - widget.quizScore!) ~/ 20;

    Widget score() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('${widget.title}',
              style:
                  secondaryTextStyle.copyWith(fontWeight: bold, fontSize: 20)),
          SizedBox(height: 16),
          Text(
            '${widget.quizScore}/100',
            style: widget.quizPass == false
                ? buttonTextStyle.copyWith(
                    color: Colors.red, fontWeight: bold, fontSize: 50)
                : thirdTextStyle.copyWith(fontWeight: bold, fontSize: 50),
          )
        ],
      );
    }

    Widget rincianTile(String image, String title, String value) {
      return Column(
        children: [
          ListTile(
            leading: Image.asset('$image'),
            title: Text('$title',
                style: secondaryTextStyle.copyWith(fontWeight: semiBold)),
            subtitle: Text('$value',
                style: primaryTextStyle.copyWith(fontWeight: bold)),
          ),
          Divider(
            height: 20,
            thickness: 1,
            indent: 20,
            endIndent: 20,
            color: secondaryTextColor,
          ),
        ],
      );
    }

    Widget rincian() {
      return Card(
        clipBehavior: Clip.antiAlias,
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Color(0xffF3F3F3),
          ),
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              rincianTile('assets/ic_quizQ.png', 'Total Pertanyaan', '5'),
              rincianTile('assets/ic_quizT.png', 'Soal Benar', '$soalBenar'),
              rincianTile('assets/ic_quizF.png', 'Soal Salah', '$soalSalah')
            ],
          ),
        ),
      );
    }

    Widget actionBtn() {
      return Column(
        children: [
          widget.quizPass == false
              ? SizedBox()
              : Container(
                  width: double.infinity,
                  height: 54,
                  child: PrimaryButton(
                      text: 'Lanjut Kerjakan Resume',
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResumePage(
                                    "${widget.id}",
                                    courseId: widget.idCourse,
                                  )),
                        );
                        // Navigator.pushReplacement(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => DetailCoursePage(
                        //           idUserCourse:"${widget.idCourse}"
                        //               .replaceAll(' ', ''))),
                        // );
                      })),
          SizedBox(height: 18),
          Container(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: () async {
                await Provider.of<QuizProvider>(context, listen: false)
                    .getQuiz("${widget.id}");
                detailQuiz =
                    Provider.of<QuizProvider>(context, listen: false).quizList;

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => QuizPage(
                            "${widget.id}",
                            detailQuiz: detailQuiz,
                            title: widget.title,
                          )),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white, // Latar belakang putih
                onPrimary:
                    Color(0xFF248043), // Warna teks saat di atas latar putih
                side: BorderSide(
                    color: Color(0xFF248043),
                    width: 2), // Border berwarna 248043 dengan lebar 2
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Border radius 10
                ),
              ),
              child: Text(
                'Ulangi',
                style: thirdTextStyle.copyWith(fontWeight: bold),
              ),
            ),
          ),
          TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailCoursePage(
                              idUserCourse: "${widget.idCourse}",
                              fromResumeOrQuiz: true,
                            )));
              },
              child: Text('Kembali', style: secondaryTextStyle))
        ],
      );
    }

    Future<bool> showExitPopup() async {
      return widget.quizPass == true
          ? Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailCoursePage(
                      fromResumeOrQuiz: true,
                      idUserCourse: "${widget.idCourse}")),
            )
          : await showDialog(
                //show confirm dialogue
                //the return value will be from "Yes" or "No" options
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Anda belum lolos Quis',
                      style: primaryTextStyle.copyWith(fontWeight: bold)),
                  content:
                      Text('Kerjakan quis Nanti?', style: primaryTextStyle),
                  actions: [
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      //return false when click on "NO"
                      child: Text('Tidak, kerjakan sekarang',
                          style: buttonTextStyle),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailCoursePage(
                                  fromResumeOrQuiz: true,
                                  idUserCourse: "${widget.idCourse}")),
                        );
                      },
                      child: Text('Ya', style: buttonTextStyle),
                    ),
                  ],
                ),
              ) ??
              false; //if showDialouge had returned null, then return false
    }

    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Hasil Quiz ',
            style: primaryTextStyle.copyWith(fontWeight: semiBold),
          ),
          elevation: 0, // Menghilangkan shadow
          leadingWidth: 0,
          backgroundColor: Colors.white,
          centerTitle: false,
        ),
        body: Container(
          padding: EdgeInsets.all(24),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    score(),
                    SizedBox(height: 15),
                    rincian(),
                  ],
                ),
                actionBtn()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
