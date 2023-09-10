// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stufast_mobile/models/course_model.dart';
import 'package:stufast_mobile/models/tag_model.dart';
import 'package:stufast_mobile/providers/course_provider.dart';
import 'package:stufast_mobile/theme.dart';
import 'package:stufast_mobile/widget/course_card.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  TextEditingController _searchController = TextEditingController();
  bool isLoading = false;
  String selectedTag = 'all';
  bool filterActive = false;

  @override
  Widget build(BuildContext context) {
    CourseProvider courseProvider = Provider.of<CourseProvider>(context);

    Widget searchBar() {
      return Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Color(0xFFD2D2D2)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Cari course',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                        filterActive = true;
                        selectedTag = '';
                      });
                      // String query = _searchController.text;
                      // if (query.isNotEmpty) {
                      //   await courseProvider.searchCourses(query);
                      //   // Provider.of<CourseProvider>(context, listen: false)
                      //   //     .searchCourses(query);
                      // }
                      setState(() {
                        isLoading = false;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Image.asset('assets/icon_search.png'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    Widget tagItCourse(List<TagModel> tags) {
      return Container(
        margin: EdgeInsets.only(top: 20),
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                InkWell(
                  onTap: () async {
                    setState(() {
                      isLoading = true;
                      selectedTag = 'all'; // Set the selectedTag to 'all'
                    });

                    // await Provider.of<CourseProvider>(context, listen: false)
                    //     .getCourses('all'); // Get all courses

                    setState(() {
                      isLoading = false;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    margin: EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Color(0xffF3F3F3), // Warna garis tepi
                      ),
                      color: selectedTag == 'all'
                          ? Color(
                              0xffE9F2EC) // Change color if selectedTag is 'all'
                          : Color(0xffFAFAFA),
                    ),
                    child: Text(
                      'Semua Course',
                      style: secondaryTextStyle.copyWith(
                        color: selectedTag == 'all' ? Colors.green : null,
                      ),
                    ),
                  ),
                ),
                ...tags.map((tag) {
                  bool isSelected = selectedTag == tag.tagId;

                  return InkWell(
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                        selectedTag = tag.tagId!;
                        filterActive = false;
                        _searchController.text = '';
                      });
                      // await courseProvider.searchbyCourses(selectedTag);

                      setState(() {
                        isLoading = false;
                      });

                      print("tag = " + selectedTag!);
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      margin: EdgeInsets.only(right: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Color(0xffF3F3F3), // Warna garis tepi
                        ),
                        color:
                            isSelected ? Color(0xffE9F2EC) : Color(0xffFAFAFA),
                      ),
                      child: Text(
                        tag.name ?? '',
                        style: secondaryTextStyle.copyWith(
                          color: isSelected ? Colors.green : null,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ],
            )),
      );
    }

    Widget dropdownFilter() {
      return Row(
        children: [
          Row(
            children: [
              Image.asset('assets/icon_filter.png'),
              Text('Single Course',
                  style: primaryTextStyle.copyWith(fontWeight: bold))
            ],
          ),
          SizedBox(width: 16),
          Row(
            children: [
              Image.asset('assets/icon_filter.png'),
              Text('Semua Level',
                  style: primaryTextStyle.copyWith(fontWeight: bold))
            ],
          )
        ],
      );
    }

    // Widget listCourse() {
    //   return Consumer<CourseProvider>(
    //     builder: (context, courseProvider, _) {
    //       if (filterActive
    //           ? courseProvider.coursesFilter.isEmpty
    //           : courseProvider.courses.isEmpty) {
    //         return Center(
    //           child: Text('No courses found.'),
    //         );
    //       } else if (isLoading) {
    //         return Center(child: CircularProgressIndicator());
    //       } else {
    //         return GridView.builder(
    //           physics: ClampingScrollPhysics(),
    //           shrinkWrap: true,
    //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //             crossAxisCount: 2, // Satu kolom
    //             mainAxisSpacing: 16, // Jarak vertikal antara item
    //             childAspectRatio: 0.67,
    //           ),
    //           itemCount: filterActive
    //               ? courseProvider.coursesFilter.length
    //               : courseProvider.courses.length,
    //           itemBuilder: (context, index) {
    //             final course = filterActive
    //                 ? courseProvider.coursesFilter[index]
    //                 : courseProvider.courses[index];
    //             return CardCourse(course);
    //           },
    //         );
    //       }
    //     },
    //   );
    // }
    Widget gridCourse() {
      return FutureBuilder(
          future: selectedTag == 'all'
              ? courseProvider.getCourses('all')
              : filterActive
                  ? courseProvider.searchCourses(_searchController.text)
                  : courseProvider.searchbyCourses(selectedTag),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return GridView(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Satu kolom
                  mainAxisSpacing: 16, // Jarak vertikal antara item
                  childAspectRatio: 0.67,
                ),
                children: courseProvider.courses
                    // Hanya ambil 10 data
                    .map((course) => CardCourse(course))
                    .toList(),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          });
    }

    // Widget listCourse() {
    //   return Consumer<CourseProvider>(
    //     builder: (context, courseProvider, _) {
    //       if (courseProvider.courses.isEmpty) {
    //         return Center(
    //           child: Text('No courses found.'),
    //         );
    //       } else if (isLoading) {
    //         return Center(child: CircularProgressIndicator());
    //       } else {
    //         return GridView.builder(
    //           physics: ClampingScrollPhysics(),
    //           shrinkWrap: true,
    //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //             crossAxisCount: 2, // Satu kolom
    //             mainAxisSpacing: 16, // Jarak vertikal antara item
    //             childAspectRatio: 0.67,
    //           ),
    //           itemCount: courseProvider.courses.length,
    //           itemBuilder: (context, index) {
    //             final course = courseProvider.courses[index];
    //             return CardCourse(course);
    //           },
    //         );
    //       }
    //     },
    //   );
    // }

    Widget tabCourse() {
      return DefaultTabController(
        length: 2, // Jumlah tab
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: TabBar(
                labelColor: Color(0xFF248043), // Warna teks saat aktif
                unselectedLabelColor:
                    Color(0xFF7D7D7D), // Warna teks saat tidak aktif
                indicatorWeight: 4, // Ketebalan garis tepi bawah saat aktif
                indicator: BoxDecoration(
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
                  Tab(
                    text: 'IT',
                  ),
                  Tab(
                    text: 'Enginering',
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Isi konten tab IT
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        tagItCourse(courseProvider.tags),
                        SizedBox(height: 18),
                        dropdownFilter(),
                        SizedBox(height: 16),
                        gridCourse()
                      ],
                    ),
                  ),
                  // Isi konten tab Engineering
                  Center(
                    child: Text('Tab Engineering Content'),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(90),
          child: Container(
            margin: EdgeInsets.only(top: 24),
            child: AppBar(
                elevation: 0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: Colors.black,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                backgroundColor: Colors.white,
                centerTitle: false,
                title: searchBar()),
          ),
        ),
        body: tabCourse());
  }
}
