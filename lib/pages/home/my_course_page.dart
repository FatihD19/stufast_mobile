// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stufast_mobile/pages/DetailPage/detail_bundle_user.dart';
import 'package:stufast_mobile/pages/course_page.dart';
import 'package:stufast_mobile/pages/home/main_page.dart';
import 'package:stufast_mobile/providers/bundle_provider.dart';
import 'package:stufast_mobile/providers/user_course_provider.dart';
import 'package:stufast_mobile/theme.dart';
import 'package:stufast_mobile/widget/bundle_tile.dart';
import 'package:stufast_mobile/widget/course_tile.dart';

import '../../widget/primary_button.dart';

class MyCoursePage extends StatefulWidget {
  const MyCoursePage({super.key});

  @override
  State<MyCoursePage> createState() => _MyCoursePageState();
}

class _MyCoursePageState extends State<MyCoursePage> {
  @override
  void initState() {
    // TODO: implement initState
    getInit();
    super.initState();
  }

  getInit() async {
    await Provider.of<UserCourseProvider>(context, listen: false)
        .getUserCourses();
    await Provider.of<BundleProvider>(context, listen: false).getUserBundle();
  }

  String selectedTag = 'Semua';
  @override
  Widget build(BuildContext context) {
    UserCourseProvider userCourseProvider =
        Provider.of<UserCourseProvider>(context);
    BundleProvider userBundleProvider = Provider.of<BundleProvider>(context);

    Widget tagView(String tag) {
      return InkWell(
        onTap: () {
          setState(() {
            selectedTag = tag;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          margin: const EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xffF3F3F3), // Warna garis tepi
            ),
            color: selectedTag == tag
                ? const Color(
                    0xffE9F2EC) // Change color if selectedTag is 'all'
                : const Color(0xffFAFAFA),
          ),
          child: Text(
            tag,
            style: secondaryTextStyle.copyWith(
              color: selectedTag == tag ? Colors.green : null,
            ),
          ),
        ),
      );
    }

    Widget nullCourse() {
      return Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/img_nullCourse.png'),
          Text(
              'Belum ada Course yang kamu ambil, Yuk mulai cari course pilihanmu!',
              textAlign: TextAlign.center,
              style: primaryTextStyle.copyWith(fontWeight: bold)),
          SizedBox(height: 12),
          Container(
              width: double.infinity,
              height: 54,
              child: PrimaryButton(
                  text: 'Cari Course',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CoursePage()),
                    );
                  }))
        ],
      ));
    }

    Widget filterTag() {
      return Row(
        children: [
          tagView('Semua'),
          tagView('Course'),
          tagView('Bundling'),
        ],
      );
    }

    // Widget userCourseTile() {
    //   return FutureBuilder(
    //       future: userCourseProvider.getUserCourses(),
    //       builder: (context, snapshot) {
    //         if (snapshot.connectionState == ConnectionState.done) {
    //           return ListView(
    //             physics: ClampingScrollPhysics(),
    //             shrinkWrap: true,
    //             children: userCourseProvider.userCourses
    //                 .map((userCourse) => CourseTile(userCourse))
    //                 .toList(),
    //           );
    //         } else {
    //           return Center(child: CircularProgressIndicator());
    //         }
    //       });
    // }

    Widget userCourseTile() {
      return userBundleProvider.loading
          ? ListView.builder(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: 2,
              itemBuilder: (context, index) {
                return CourseTileShimer();
              })
          : userCourseProvider.userCourses.length == 0
              ? nullCourse()
              : ListView(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  children: userCourseProvider.userCourses
                      .map((userCourse) => CourseTile(userCourse))
                      .toList(),
                );
    }

    // Widget userBundleTile() {
    //   return ListView(
    //     physics: ClampingScrollPhysics(),
    //     shrinkWrap: true,
    //     children: userBundleProvider.bundle
    //         .map((userBundle) => BundlingTile(userBundle))
    //         .toList(),
    //   );
    // }

    Widget userBundleTile() {
      return Consumer<BundleProvider>(
        builder: (context, bundleState, _) {
          if (bundleState.userBundle.isNotEmpty) {
            return userBundleProvider.loading
                ? ListView.builder(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return CourseTileShimer();
                    })
                : ListView(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    children: userBundleProvider.userBundle
                        .map((userBundle) => BundlingTile(userBundle))
                        .toList(),
                  );
          } else {
            return userBundleProvider.loading == true
                ? ListView.builder(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return CourseTileShimer();
                    })
                : nullCourse();
          }
        },
      );

      // FutureBuilder(
      //     future: Provider.of<BundleProvider>(context, listen: false)
      //         .getUserBundle(),
      //     builder: (context, snapshot) {
      //       return userBundleProvider.loading
      //           ? ListView.builder(
      //               physics: ClampingScrollPhysics(),
      //               shrinkWrap: true,
      //               itemCount: 4,
      //               itemBuilder: (context, index) {
      //                 return CourseTileShimer();
      //               })
      //           : userCourseProvider.userCourses.isEmpty
      //               ? nullCourse()
      //               : ListView(
      //                   physics: ClampingScrollPhysics(),
      //                   shrinkWrap: true,
      //                   children: userBundleProvider.userBundle
      //                       .map((userBundle) => BundlingTile(userBundle))
      //                       .toList(),
      //                 );
      //     });
    }

    Widget tabBar() {
      return DefaultTabController(
        length: 2, // Jumlah tab
        child: Column(
          children: [
            Container(
              color: Colors.white,
              // ignore: prefer_const_constructors
              child: TabBar(
                labelColor: const Color(0xFF248043), // Warna teks saat aktif
                unselectedLabelColor:
                    const Color(0xFF7D7D7D), // Warna teks saat tidak aktif
                indicatorWeight: 4, // Ketebalan garis tepi bawah saat aktif
                indicator: const BoxDecoration(
                  color:
                      Color(0xFFE9F2EC), // Warna latar belakang saat tab aktif
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
                    text: 'Aktif',
                  ),
                  const Tab(
                    text: 'Menunggu',
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Isi konten tab IT
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        SizedBox(height: 24),
                        filterTag(),
                        SizedBox(height: 24),
                        selectedTag == 'Semua'
                            ? Column(
                                children: [userBundleTile(), userCourseTile()],
                              )
                            : selectedTag == 'Course'
                                ? userCourseTile()
                                : userBundleTile()
                      ],
                    ),
                  ),
                  // Isi konten tab Engineering
                  const Center(
                    child: Text('Tab Engineering Content'),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
        );
        return false;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            // margin: EdgeInsets.only(top: 24),
            child: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                centerTitle: false,
                leadingWidth: 0,
                title: Container(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(
                    'My Course',
                    style: primaryTextStyle.copyWith(
                        fontWeight: bold, fontSize: 18),
                  ),
                )),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            shrinkWrap: true,
            children: [
              SizedBox(height: 24),
              filterTag(),
              SizedBox(height: 24),
              selectedTag == 'Semua'
                  ?
                  // userCourseProvider.userCourses.length == 0 &&
                  //         userBundleProvider.userBundle.length == 0
                  //     ? nullCourse()
                  //     :
                  Column(
                      children: [userBundleTile(), userCourseTile()],
                    )
                  : selectedTag == 'Course'
                      ? userCourseTile()
                      : userBundleTile()
            ],
          ),
        ),
      ),
    );
  }
}
