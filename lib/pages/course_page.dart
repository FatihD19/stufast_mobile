// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stufast_mobile/models/course_model.dart';
import 'package:stufast_mobile/models/tag_model.dart';
import 'package:stufast_mobile/providers/bundle_provider.dart';
import 'package:stufast_mobile/providers/course_provider.dart';
import 'package:stufast_mobile/theme.dart';
import 'package:stufast_mobile/widget/course_card.dart';
import 'package:stufast_mobile/widget/primary_button.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  TextEditingController _searchController = TextEditingController();
  bool isLoading = false;
  String selectedTag = 'all';
  String selectedJenis = 'Single Course';
  bool filterActive = false;
  bool showBundle = false;

  bool filterByLevel = false;

  @override
  Widget build(BuildContext context) {
    CourseProvider courseProvider = Provider.of<CourseProvider>(context);
    BundleProvider bundleProvider = Provider.of<BundleProvider>(context);

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
                        filterByLevel = false;
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

    void _showDropdown(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: DropdownButton<String>(
              value: selectedJenis,
              items: <String>['Single Course', 'Bundling'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedJenis = newValue!;
                  selectedJenis == 'Bundling'
                      ? showBundle = true
                      : showBundle = false;
                });
                Navigator.of(context).pop(); // Tutup dialog saat item dipilih
              },
            ),
          );
        },
      );
    }

    void _showBottomSheet(BuildContext context, bool isLevel) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 237,
            padding: EdgeInsets.fromLTRB(24, 24, 24, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(isLevel ? 'Level' : 'Jenis Course',
                    style: primaryTextStyle.copyWith(
                        fontWeight: bold, fontSize: 18)),
                SizedBox(height: 24),
                isLevel
                    ? Container(
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selectedTag = 'Basic';
                                  filterByLevel = true;
                                  Navigator.pop(context);
                                });

                                // Tutup bottom sheet setelah dipilih
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Basic',
                                      style: selectedTag == 'Basic'
                                          ? thirdTextStyle.copyWith(
                                              fontSize: 18)
                                          : secondaryTextStyle.copyWith(
                                              fontSize: 18)),
                                  Divider(
                                    height: 20,
                                    thickness: 1,
                                    indent: 3,
                                    endIndent: 3,
                                    color: selectedTag == 'Basic'
                                        ? primaryColor
                                        : secondaryColor,
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selectedTag = 'Intermediate';
                                  filterByLevel = true;
                                  Navigator.pop(context);
                                });

                                // Tutup bottom sheet setelah dipilih
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Intermediate',
                                      style: selectedTag == 'Intermediate'
                                          ? thirdTextStyle.copyWith(
                                              fontSize: 18)
                                          : secondaryTextStyle.copyWith(
                                              fontSize: 18)),
                                  Divider(
                                    height: 20,
                                    thickness: 1,
                                    indent: 3,
                                    endIndent: 3,
                                    color: selectedTag == 'Intermediate'
                                        ? primaryColor
                                        : secondaryColor,
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selectedTag = 'Advanced';
                                  filterByLevel = true;
                                  Navigator.pop(context);
                                });

                                // Tutup bottom sheet setelah dipilih
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Advanced',
                                      style: selectedTag == 'Advanced'
                                          ? thirdTextStyle.copyWith(
                                              fontSize: 18)
                                          : secondaryTextStyle.copyWith(
                                              fontSize: 18)),
                                  Divider(
                                    height: 20,
                                    thickness: 1,
                                    indent: 3,
                                    endIndent: 3,
                                    color: selectedTag == 'Advanced'
                                        ? primaryColor
                                        : secondaryColor,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selectedJenis = 'Single Course';
                                  showBundle = false;
                                  Navigator.pop(context);
                                });

                                // Tutup bottom sheet setelah dipilih
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Single Course',
                                      style: selectedJenis == 'Single Course'
                                          ? thirdTextStyle.copyWith(
                                              fontSize: 18)
                                          : secondaryTextStyle.copyWith(
                                              fontSize: 18)),
                                  Divider(
                                    height: 20,
                                    thickness: 1,
                                    indent: 3,
                                    endIndent: 3,
                                    color: selectedJenis == 'Single Course'
                                        ? primaryColor
                                        : secondaryColor,
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selectedJenis = 'Bundling';
                                  showBundle = true;
                                  Navigator.pop(context);
                                });

                                // Tutup bottom sheet setelah dipilih
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Bundling',
                                      style: selectedJenis == 'Bundling'
                                          ? thirdTextStyle.copyWith(
                                              fontSize: 18)
                                          : secondaryTextStyle.copyWith(
                                              fontSize: 18)),
                                  Divider(
                                    height: 20,
                                    thickness: 1,
                                    indent: 3,
                                    endIndent: 3,
                                    color: selectedJenis == 'Bundling'
                                        ? primaryColor
                                        : secondaryColor,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
              ],
            ),
          );
        },
      );
    }

// Panggil fungsi _showBottomSheet saat Anda ingin menampilkan bottom sheet, misalnya pada sebuah tombol.

    Widget dropdownFilter() {
      return Row(
        children: [
          InkWell(
            onTap: () {
              _showBottomSheet(context, false);
            },
            child: Row(
              children: [
                Image.asset('assets/icon_filter.png'),
                Text('Single Course',
                    style: primaryTextStyle.copyWith(fontWeight: bold))
              ],
            ),
          ),
          SizedBox(width: 16),
          InkWell(
            onTap: () {
              _showBottomSheet(context, true);
            },
            child: Row(
              children: [
                Image.asset('assets/icon_filter.png'),
                Text('Semua Level',
                    style: primaryTextStyle.copyWith(fontWeight: bold))
              ],
            ),
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
        future: showBundle
            ? bundleProvider.getBundles()
            : (selectedTag == 'all'
                ? courseProvider.getCourses('all')
                : filterActive
                    ? courseProvider.searchCourses(_searchController.text)
                    : filterByLevel
                        ? courseProvider.searchbyCourses(null, selectedTag)
                        : courseProvider.searchbyCourses(selectedTag, null)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return GridView(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 13,
                childAspectRatio: 0.64,
              ),
              children: showBundle
                  ? (bundleProvider.bundle
                      .map((bundle) => CardCourse(
                            bundle: bundle,
                            isBundle: true,
                          ))
                      .toList())
                  : (courseProvider.courses
                      .map((course) => CardCourse(
                            course: course,
                          ))
                      .toList()),
            );
          } else {
            return GridView.builder(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 13,
                childAspectRatio: 0.64,
              ),
              itemCount: 6, // Number of shimmer items you want to show
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child:
                      CardCourseShimmer(), // Create a CardCourseShimmer widget for shimmer effect
                );
              },
            );
          }
        },
      );
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
                        tagItCourse(courseProvider.tagsIT),
                        SizedBox(height: 18),
                        dropdownFilter(),
                        SizedBox(height: 16),
                        gridCourse()
                      ],
                    ),
                  ),
                  // Isi konten tab Engineering
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: ListView(
                      children: [
                        tagItCourse(courseProvider.tags),
                        SizedBox(height: 18),
                        dropdownFilter(),
                        SizedBox(height: 16),
                        gridCourse()
                      ],
                    ),
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
