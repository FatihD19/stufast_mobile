import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stufast_mobile/models/quiz_model.dart';
import 'package:stufast_mobile/providers/quiz_provider.dart';
import 'package:stufast_mobile/theme.dart';

class QuizPage extends StatefulWidget {
  String? id;
  List<QuizModel>? detailQuiz;
  QuizPage(this.id, {this.detailQuiz});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  bool? loading;
  QuizProvider quizProvider = QuizProvider();

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   Provider.of<QuizProvider>(context).getQuiz("${widget.id}");
  //   super.initState();
  // }

  // getInit() async {
  //   setState(() {
  //     loading = true;
  //   });
  //   await Provider.of<QuizProvider>(context).getQuiz("${widget.id}");
  //   setState(() {
  //     loading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    QuizProvider quizProvider = Provider.of<QuizProvider>(context);

    final quizList = quizProvider.quizList;
    final currentIndex = quizProvider.currentIndex;

    // Memeriksa apakah saat ini pertanyaan adalah yang terakhir
    final isLastQuestion = quizProvider.isLastQuestion();

    List<Map<String, String>> selectedAnswers = [];

    // final currentQuestion = quizList[currentIndex].question;

    Widget progress() {
      return Row(
        children: [
          Expanded(
            child: LinearProgressIndicator(
              borderRadius: BorderRadius.circular(20),
              minHeight: 20,
              value: ((currentIndex + 1) / 10) *
                  2, // Set the value based on the achievement score
              backgroundColor:
                  Color(0xffE9F2EC), // Background color of the progress bar
              valueColor: AlwaysStoppedAnimation<Color>(
                  primaryColor // Warna kuning jika progress kurang dari 100%
                  ),
            ),
          ),
          SizedBox(width: 27),
          Text(
            '${currentIndex + 1} / 5 ',
            style: thirdTextStyle.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      );
    }

    Widget question() {
      return Card(
        clipBehavior: Clip.antiAlias,
        color: Color(0xffF3F3F3),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: EdgeInsets.all(24),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Pertanyaan ${currentIndex + 1}',
              style: secondaryTextStyle.copyWith(fontWeight: semiBold),
            ),
            SizedBox(height: 8),
            Text(
              // '${currentIndex}',
              widget.detailQuiz![currentIndex].question,
              // quizList[currentIndex].question,
              style: primaryTextStyle.copyWith(fontWeight: semiBold),
            )
          ]),
        ),
      );
    }

    Widget answerTile(String option, String answer) {
      return Card(
        clipBehavior: Clip.antiAlias,
        color: Color(0xffF3F3F3),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.fromLTRB(0, 16, 6, 16),
            child: ListTile(
              leading: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xffE9E9E9)),
                width: 50,
                height: 50,
                child: Text(option,
                    style: primaryTextStyle.copyWith(
                        fontWeight: bold, fontSize: 18)),
              ),
              title: Text(
                answer,
                style: primaryTextStyle.copyWith(fontWeight: semiBold),
              ),
            )),
      );
    }

    // Widget answer() {
    //   return Column(
    //     children: [
    //       answerTile('A', "${quizList[currentIndex].answerA}"),
    //       answerTile('B', "${quizList[currentIndex].answerB}"),
    //       answerTile('C', "${quizList[currentIndex].answerC}"),
    //       answerTile('D', "${quizList[currentIndex].answerD}"),
    //     ],
    //   );
    // }

    Widget navigation() {
      return Container(
        height: 82,
        color: Color(0xffF3F3F3),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  quizProvider.previousQuestion();
                  print(currentIndex);
                },
                child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xffE9E9E9)),
                    width: 50,
                    height: 50,
                    child: Icon(Icons.arrow_back)),
              ),
              InkWell(
                onTap: () {
                  quizProvider.nextQuestion();
                  print(currentIndex);
                },
                child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xffE9E9E9)),
                    width: 50,
                    height: 50,
                    child: Icon(Icons.arrow_forward)),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.id}',
          style: primaryTextStyle.copyWith(fontWeight: semiBold),
        ),
        elevation: 0, // Menghilangkan shadow
        leadingWidth: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
      ),
      body:
          // loading == true
          //     ? CircularProgressIndicator()
          //     :
          Stack(children: [
        Container(
          padding: EdgeInsets.all(24),
          child: ListView(children: [
            progress(),
            SizedBox(height: 24),
            question(),
            SizedBox(height: 24),
            // answer(),
            SizedBox(height: 94),
          ]),
        ),
        Positioned(
          bottom: 0, // Menempatkan checkout di bagian bawah
          left: 0, // Atur posisi horizontal ke kiri
          right: 0, // Atur posisi horizontal ke kanan
          child: navigation(),
        ),
      ]),
    );
  }
}
