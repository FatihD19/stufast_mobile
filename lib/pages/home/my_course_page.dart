// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stufast_mobile/pages/DetailPage/detail_bundle_user.dart';
import 'package:stufast_mobile/pages/course_page.dart';
import 'package:stufast_mobile/pages/home/main_page.dart';
import 'package:stufast_mobile/providers/auth_provider.dart';
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
        .getUserCourse();
    // await Provider.of<UserCourseProvider>(context, listen: false)
    //     .getUserCourses();
    // await Provider.of<BundleProvider>(context, listen: false).getUserBundle();
  }

  bool loading = false;

  String selectedTag = 'Course';
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

    Widget nullCourse({bool? isBundle}) {
      return Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          isBundle == true
              ? Image.asset(
                  'assets/img_empty_bundle.png',
                  width: 200,
                )
              : Image.asset('assets/img_nullCourse.png'),
          isBundle == true
              ? Text(
                  'Belum ada Bundling yang kamu ambil, Yuk mulai cari bundling pilihanmu!',
                  textAlign: TextAlign.center,
                  style: primaryTextStyle.copyWith(fontWeight: bold))
              : Text(
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
          // tagView('Semua'),
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
      if (userCourseProvider.loadingCourse == true) {
        return ListView.builder(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: 2,
            itemBuilder: (context, index) {
              return CourseTileShimer();
            });
      } else {
        return userCourseProvider.userCourse!.course.isNotEmpty
            ? ListView(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                children: userCourseProvider.userCourse!.course
                    .map((userCourse) => CourseTile(userCourse))
                    .toList(),
              )
            : nullCourse();
      }
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
      return Consumer<UserCourseProvider>(
        builder: (context, bundleState, _) {
          if (bundleState.loadingCourse == true) {
            return ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return CourseTileShimer();
                });
          } else {
            return bundleState.userCourse!.bundling.isNotEmpty
                ? ListView(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    children: bundleState.userCourse!.bundling
                        .map((userBundle) => BundlingTile(userBundle))
                        .toList(),
                  )
                : nullCourse(isBundle: true);
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

    Widget learnProgress() {
      int progress = userCourseProvider.userCourse?.learningProgress ?? 90;
      double progressPercent = progress / 100;
      int progressPercentInt = (progressPercent * 100).toInt();
      return Container(
        decoration: BoxDecoration(
          color: Color(0xFAFAFA), // Warna background FAFAFA
          border: Border.all(color: Color(0xF3F3F3)), // Warna garis tepi F3F3F3
          borderRadius: BorderRadius.circular(8), // Sudut border radius
        ),
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Progress Belajar',
                    style: primaryTextStyle.copyWith(
                        fontWeight: bold, fontSize: 16),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: LinearProgressIndicator(
                        value: progressPercent,
                        backgroundColor: progressPercent == 1.0
                            ? primaryColor
                            : Color(0xffF0DB96),
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(0xffFEC202)),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      '${progressPercentInt}%',
                      style: primaryTextStyle.copyWith(fontWeight: bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
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
                  'Kursus Saya',
                  style:
                      primaryTextStyle.copyWith(fontWeight: bold, fontSize: 18),
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return CoursePage();
                        },
                      ));
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Cari Course',
                          style: thirdTextStyle.copyWith(fontWeight: bold),
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: context.read<AuthProvider>().user?.fullname == null
              ? nullCourse()
              : RefreshIndicator(
                  displacement: 10,
                  backgroundColor: primaryColor,
                  color: Colors.white,
                  strokeWidth: 3,
                  triggerMode: RefreshIndicatorTriggerMode.onEdge,
                  onRefresh: () async {
                    await Provider.of<BundleProvider>(context, listen: false)
                        .getUserBundle();
                  },
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      SizedBox(height: 10),
                      filterTag(),
                      SizedBox(height: 10),
                      learnProgress(),
                      SizedBox(height: 7),
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
      ),
    );
  }
}
