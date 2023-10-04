// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stufast_mobile/models/chart_model.dart';
import 'package:stufast_mobile/models/user_model.dart';
import 'package:stufast_mobile/providers/auth_provider.dart';
import 'package:stufast_mobile/providers/chart_provider.dart';
import 'package:stufast_mobile/providers/course_provider.dart';
import 'package:stufast_mobile/providers/user_course_provider.dart';
import 'package:stufast_mobile/theme.dart';
import 'package:stufast_mobile/widget/course_card.dart';
import 'package:stufast_mobile/widget/course_tile.dart';
import 'package:stufast_mobile/widget/webinar_card.dart';

import '../../providers/webinar_provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool? loading;
  int? jumlahCart;

  @override
  void initState() {
    // TODO: implement initState
    getInit();
    Provider.of<WebinarProvider>(context, listen: false).getWebinar(false);
    Provider.of<UserCourseProvider>(context, listen: false).getUserCourses();
    jumlahCart =
        Provider.of<ChartProvider>(context, listen: false).chart?.item?.length;

    super.initState();
  }

  getInit() async {
    setState(() {
      loading = true;
    });
    await Provider.of<ChartProvider>(context, listen: false).getChart();
    setState(() {
      jumlahCart = context.watch<ChartProvider>().chart?.item?.length;
    });

    setState(() {
      loading = false;
    });
  }

  List images = [
    'assets/banner-slide.png',
    'assets/banner-slide.png',
    'assets/banner-slide.png',
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel? user = authProvider.user;
    CourseProvider courseProvider = Provider.of<CourseProvider>(context);
    ChartProvider chartProvider = Provider.of<ChartProvider>(context);
    ChartModel? cart = chartProvider.chart;
    UserCourseProvider userCourseProvider =
        Provider.of<UserCourseProvider>(context);

    Widget cartItem() {
      return Stack(
        alignment: Alignment.center,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/chart-page');
            },
            icon: Image.asset('assets/icon_chart.png'),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.all(4), // Sesuaikan dengan kebutuhan Anda
              decoration: BoxDecoration(
                color: Colors.red, // Warna latar belakang angka
                borderRadius: BorderRadius.circular(20), // Bentuk angka
              ),
              child: Text(
                '${chartProvider.chart?.item?.length ?? 0}', // Angka yang ingin ditampilkan
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.white, // Warna teks angka
                  fontWeight: FontWeight.bold, // Gaya teks angka
                ),
              ),
            ),
          ),
        ],
      );
    }

    Widget header() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Welcome, ',
                  style: primaryTextStyle.copyWith(fontSize: 18),
                ),
                TextSpan(
                  text: '${user?.fullname}',
                  style: primaryTextStyle.copyWith(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
          ),
          Row(
            children: [
              cartItem(),
              IconButton(
                onPressed: () {
                  // Tambahkan fungsi ketika icon notification ditekan
                },
                icon: Image.asset('assets/icon_notification.png'),
              ),
            ],
          ),
        ],
      );
    }

    Widget searchInput() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xFFD2D2D2)),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Cari course',
                  border: InputBorder.none,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                // Tambahkan fungsi ketika ikon pencarian ditekan
              },
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Image.asset('assets/icon_search.png'),
              ),
            ),
          ],
        ),
      );
    }

    Widget indicator(int index) {
      return Container(
        width: 10,
        height: 10,
        margin: EdgeInsets.symmetric(
          horizontal: 2,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: currentIndex == index ? primaryColor : Color(0xffC4C4C4),
        ),
      );
    }

    Widget carousel() {
      int index = -1;
      return Column(
        children: [
          CarouselSlider(
            items: images
                .map(
                  (image) => Image.asset(
                    image,
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                  ),
                )
                .toList(),
            options: CarouselOptions(
              enlargeCenterPage: true,
              aspectRatio: 2,
              initialPage: 1,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: images.map((e) {
              index++;
              return indicator(index);
            }).toList(),
          ),
        ],
      );
    }

    Widget userCourseTile() {
      return userCourseProvider.loading
          ? CircularProgressIndicator()
          : ListView(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              children: userCourseProvider.userCourses
                  .take(1)
                  .map((userCourse) => CourseTile(userCourse))
                  .toList(),
            );
    }

    // Widget userCourseTile() {
    //   return FutureBuilder(
    //       future: userCourseProvider.getUserCourses(),
    //       builder: (context, snapshot) {
    //         return userCourseProvider.loading
    //             ? CircularProgressIndicator()
    //             : ListView(
    //                 physics: ClampingScrollPhysics(),
    //                 shrinkWrap: true,
    //                 children: userCourseProvider.userCourses
    //                     .take(1)
    //                     .map((userCourse) => CourseTile(userCourse))
    //                     .toList(),
    //               );
    //       });
    // }

    Widget continueCourse() {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Lanjutkan Kelas',
                style: primaryTextStyle.copyWith(fontWeight: bold),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/user-course');
                },
                child: Text(
                  'view all',
                  style: secondaryTextStyle.copyWith(
                    decoration: TextDecoration.underline,
                  ),
                ),
              )
            ],
          ),
          userCourseTile()
        ],
      );
    }

    Widget popularCourse() {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Popular Course',
                style: primaryTextStyle.copyWith(fontWeight: bold),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/course-page');
                },
                child: Text(
                  'view all',
                  style: secondaryTextStyle.copyWith(
                    decoration: TextDecoration.underline,
                  ),
                ),
              )
            ],
          ),
          FutureBuilder(
              future: courseProvider.getCourses('all'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: courseProvider.courses
                          .take(10) // Hanya ambil 10 data
                          .map((course) => CardCourse(
                                course: course,
                              ))
                          .toList(),
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
          // SingleChildScrollView(
          //   scrollDirection: Axis.horizontal,
          //   child: Row(
          //     children: courseProvider.courses
          //         .take(10) // Hanya ambil 10 data
          //         .map((course) => CardCourse(course))
          //         .toList(),
          //   ),
          // )
        ],
      );
    }

    Widget webinar() {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Webinar',
                style: primaryTextStyle.copyWith(fontWeight: bold),
              ),
              TextButton(
                onPressed: () {
                  // Navigator.pushNamed(context, '/course-page');
                },
                child: Text(
                  'view all',
                  style: secondaryTextStyle.copyWith(
                    decoration: TextDecoration.underline,
                  ),
                ),
              )
            ],
          ),
          context.watch<WebinarProvider>().loading == true
              ? CircularProgressIndicator()
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: context
                        .watch<WebinarProvider>()
                        .webinar
                        .map((webinar) => WebinarCard(webinar, false))
                        .toList(),
                  ),
                )
        ],
      );
    }

    return Container(
      padding: EdgeInsets.all(24),
      child:
          // loading == true
          //     ? Center(child: CircularProgressIndicator())
          //     :
          ListView(
        shrinkWrap: true,
        children: [
          header(),
          searchInput(),
          carousel(),
          continueCourse(),
          popularCourse(),
          webinar()
        ],
      ),
    );
  }
}
