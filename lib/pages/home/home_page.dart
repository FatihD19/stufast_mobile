// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:searchfield/searchfield.dart';
import 'package:stufast_mobile/models/chart_model.dart';
import 'package:stufast_mobile/models/course_model.dart';
import 'package:stufast_mobile/models/user_model.dart';
import 'package:stufast_mobile/providers/auth_provider.dart';
import 'package:stufast_mobile/providers/chart_provider.dart';
import 'package:stufast_mobile/providers/course_provider.dart';
import 'package:stufast_mobile/providers/notif_provider.dart';
import 'package:stufast_mobile/providers/talentHub_provider.dart';
import 'package:stufast_mobile/providers/user_course_provider.dart';
import 'package:stufast_mobile/theme.dart';
import 'package:stufast_mobile/widget/course_card.dart';
import 'package:stufast_mobile/widget/course_tile.dart';
import 'package:stufast_mobile/widget/talent_card.dart';
import 'package:stufast_mobile/widget/webinar_card.dart';

import '../../providers/webinar_provider.dart';
import '../DetailPage/detail_course_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // bool? loading;
  int? jumlahCart;
  String? selectedCourse;
  @override
  void initState() {
    // TODO: implement initState
    getInit();

    Provider.of<WebinarProvider>(context, listen: false).getWebinar(false);
    // Provider.of<UserCourseProvider>(context, listen: false).getUserCourses();
    Provider.of<UserCourseProvider>(context, listen: false).getUserCourse();
    Provider.of<NotificationProvider>(context, listen: false).getNotification();

    // jumlahCart =
    //     Provider.of<ChartProvider>(context, listen: false).chart?.item?.length;

    super.initState();
  }

  getInit() async {
    // setState(() {
    //   loading = true;
    // });
    Provider.of<ChartProvider>(context, listen: false).getChart();
    await Provider.of<TalentHubProvider>(context, listen: false)
        .getTalentHub(index: 1);
    await Provider.of<CourseProvider>(context, listen: false).getCourses('all');
    // setState(() {
    //   jumlahCart = Provider.of<ChartProvider>(context, listen: false)
    //       .chart
    //       ?.item
    //       ?.length;
    // });

    // setState(() {
    //   loading = false;
    // });
  }

  int currentIndex = 0;
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List banner = context.watch<WebinarProvider>().banner;

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
            bottom: 25,
            child: CircleAvatar(
              radius: 8, // Sesuaikan dengan ukuran yang Anda inginkan
              backgroundColor:
                  Colors.yellow.shade700, // Warna latar belakang angka
              child: Text(
                  '${chartProvider.chart?.item?.length ?? 0}', // Angka yang ingin ditampilkan
                  style:
                      primaryTextStyle.copyWith(fontSize: 9, fontWeight: bold)),
            ),
          ),
        ],
      );
    }

    Widget header() {
      String? fullName = user?.fullname;
      if (fullName != null && fullName.length > 13) {
        fullName = fullName.substring(
            0, 13); // Memotong teks jika lebih dari 15 karakter
      }
      return fullName == null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selamat datang di Stufast',
                      style: primaryTextStyle.copyWith(
                          fontWeight: bold, fontSize: 18),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(
                        'Silahkan login untuk mengakses lebih banyak fitur',
                        style: secondaryTextStyle.copyWith(fontSize: 14),
                      ),
                    ),
                    SizedBox(height: 12)
                  ],
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/landing-page');
                    },
                    icon: Icon(Icons.login, size: 35, color: primaryColor)),
              ],
            )
          : Row(
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
                        text: '${fullName ?? ''}',
                        style: primaryTextStyle.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    cartItem(),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/notif-page');
                          },
                          icon: Image.asset('assets/icon_notification.png'),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 25,
                          child: CircleAvatar(
                            radius:
                                8, // Sesuaikan dengan ukuran yang Anda inginkan
                            backgroundColor: Colors
                                .yellow.shade700, // Warna latar belakang angka
                            child: Text(
                                '${context.watch<NotificationProvider>().notification?.unread}', // Angka yang ingin ditampilkan
                                style: primaryTextStyle.copyWith(
                                    fontSize: 9, fontWeight: bold)),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            );
    }

    Widget searchInput() {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xFFD2D2D2)),
        ),
        child: SearchField<CourseModel>(
          controller: searchController,
          searchInputDecoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 10)),
          hint: 'Cari Course...',
          itemHeight: 56,
          searchStyle: primaryTextStyle,
          suggestionState: Suggestion.expand,
          onSuggestionTap: (p0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailCoursePage(
                  idUserCourse: p0.item?.courseId ?? '',
                ),
              ),
            );
            searchController.clear();
          },
          suggestions: courseProvider.courses
              .map(
                (e) => SearchFieldListItem<CourseModel>(
                  '${e.title}',
                  item: e,
                  // Use child to show Custom Widgets in the suggestions
                  // defaults to Text widget
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "${e.title}",
                      style: primaryTextStyle,
                    ),
                  ),
                ),
              )
              .toList(),
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
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Column(
          children: [
            SizedBox(height: 10),
            CarouselSlider(
              items: banner
                  .map(
                    (image) => ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        image,
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                      ),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: banner.map((e) {
                index++;
                return indicator(index);
              }).toList(),
            ),
          ],
        ),
      );
    }

    Widget userCourseTile() {
      return userCourseProvider.loading
          ? ListView.builder(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: 2,
              itemBuilder: (context, index) {
                return CourseTileShimer();
              })
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
      return userCourseProvider.userCourses.length == 0
          ? Container()
          : Column(
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: courseProvider.courses
                  .take(10) // Hanya ambil 10 data
                  .map((course) => CardCourse(
                        course: course,
                      ))
                  .toList(),
            ),
          )
          // FutureBuilder(
          //     future: courseProvider.getCourses('all'),
          //     builder: (context, snapshot) {
          //       return courseProvider.loading == true
          //           ? CircularProgressIndicator()
          //           :
          //     }),
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

    Widget previewTalentHub() {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Talen Hub',
                style: primaryTextStyle.copyWith(fontWeight: bold),
              ),
              TextButton(
                onPressed: () {
                  // Navigator.pushNamed(context, '/course-page');
                },
                child: Text(
                  'Liat Semua',
                  style: secondaryTextStyle.copyWith(
                    decoration: TextDecoration.underline,
                  ),
                ),
              )
            ],
          ),
          Consumer<TalentHubProvider>(
            builder: (context, talentHubProvider, _) {
              return talentHubProvider.loading == true
                  ? CircularProgressIndicator()
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: talentHubProvider.talent
                            .map((talent) => TalentCard(talent))
                            .take(10)
                            .toList(),
                      ),
                    );
            },
          ),
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
          webinar(),
          previewTalentHub()
        ],
      ),
    );
  }
}
