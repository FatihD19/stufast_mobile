// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stufast_mobile/models/cv_model.dart';
import 'package:stufast_mobile/pages/cv/data_personal_view.dart';
import 'package:stufast_mobile/pages/cv/form_achievement_view.dart';
import 'package:stufast_mobile/pages/cv/form_education_view.dart';
import 'package:stufast_mobile/pages/cv/form_exp_view.dart';

import '../../providers/cv_provider.dart';
import '../../theme.dart';

class CreateCvPage extends StatefulWidget {
  CVmodel? cv;
  CreateCvPage(this.cv, {super.key});

  @override
  State<CreateCvPage> createState() => _CreateCvPageState();
}

class _CreateCvPageState extends State<CreateCvPage> {
  getInit() async {
    await Provider.of<CvProvider>(context, listen: false).getCV();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Provider.of<CvProvider>(context, listen: false).disposeEducation();
    Provider.of<CvProvider>(context, listen: false).disposeExperience();
    Provider.of<CvProvider>(context, listen: false).disposeAchievement();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        dispose();
        return Future.value(false);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(
            'Curriculum Vitae',
            style:
                primaryTextStyle.copyWith(fontWeight: semiBold, fontSize: 18),
          ),
          elevation: 0, // Menghilangkan shadow
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
              dispose();
            },
          ),
          backgroundColor: Colors.white,
          centerTitle: false,
        ),
        body: DefaultTabController(
          length: 4,
          child: Column(
            children: [
              Container(
                color: Colors.white,
                // ignore: prefer_const_constructors
                child: TabBar(
                  labelPadding: EdgeInsets.symmetric(horizontal: 3.0),
                  labelStyle: thirdTextStyle.copyWith(fontSize: 14),
                  labelColor: const Color(0xFF248043), // Warna teks saat aktif
                  unselectedLabelColor:
                      const Color(0xFF7D7D7D), // Warna teks saat tidak aktif
                  indicatorWeight: 4, // Ketebalan garis tepi bawah saat aktif
                  indicator: const BoxDecoration(
                    color: Color(
                        0xFFE9F2EC), // Warna latar belakang saat tab aktif
                    border: Border(
                      bottom: BorderSide(
                        color: Color(
                            0xFF248043), // Warna garis tepi bawah saat aktif
                        width: 4, // Ketebalan garis tepi bawah saat aktif
                      ),
                    ),
                  ), // Warna garis tepi bawah saat aktif
                  tabs: [
                    const Tab(
                      text: 'Data Diri',
                    ),
                    Container(
                      width: 90,
                      child: Tab(
                        text: 'Pendidikan',
                      ),
                    ),
                    const Tab(
                      text: 'Pengalaman',
                    ),
                    const Tab(
                      text: 'Prestasi',
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    // Isi konten tab IT
                    DataPersonalView(widget.cv!),
                    EducationForm(),

                    ExperienceForm(),
                    AchievementForm(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
