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
  final _scrollController = ScrollController();
  bool isLoading = false;
  String? selectedTag;
  String? sortBy;
  String? selectedLevel;
  bool filterActive = false;
  bool showBundle = false;

  bool filterByLevel = false;

  int _currentPage = 1;

  void _loadMore() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _currentPage++;
      try {
        getCoursePag();
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _scrollController.addListener(_loadMore);
    getCoursePag();
    getCourseBundle();
    super.initState();
  }

  getCourseBundle() async {
    setState(() {
      isLoading = true;
    });
    await Provider.of<BundleProvider>(context, listen: false).getBundles();
    setState(() {
      isLoading = false;
    });
  }

  getCoursePag() async {
    await Provider.of<CourseProvider>(context, listen: false).getFilterCourses(
      index: _currentPage,
      tag: selectedTag,
      category: selectedLevel,
      sort: sortBy,
      search: _searchController.text,
    );
  }

  resetFilter() {
    setState(() {
      selectedTag = null;
      selectedLevel = null;
      sortBy = null;
      _searchController.text = '';
    });
  }

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
                        _currentPage = 1;
                      });
                      courseProvider.resetCoursePagination();
                      getCoursePag();
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
                    resetFilter();
                    courseProvider.resetCoursePagination();
                    getCoursePag();
                    _currentPage = 1;
                    setState(() {});
                    // setState(() {
                    //   isLoading = true;
                    //   selectedTag = 'all'; // Set the selectedTag to 'all'
                    // });

                    // // await Provider.of<CourseProvider>(context, listen: false)
                    // //     .getCourses('all'); // Get all courses

                    // setState(() {
                    //   isLoading = false;
                    // });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    margin: EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Color(0xffF3F3F3), // Warna garis tepi
                      ),
                      color: selectedTag == null
                          ? Color(
                              0xffE9F2EC) // Change color if selectedTag is 'all'
                          : Color(0xffFAFAFA),
                    ),
                    child: Text(
                      'Semua Course',
                      style: secondaryTextStyle.copyWith(
                        color: selectedTag == null ? Colors.green : null,
                      ),
                    ),
                  ),
                ),
                ...tags.map((tag) {
                  bool isSelected = selectedTag == tag.name;

                  return InkWell(
                    onTap: () async {
                      setState(() {
                        selectedTag = tag.name;
                        _currentPage = 1;
                      });
                      courseProvider.resetCoursePagination();
                      getCoursePag();
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
              value: sortBy,
              items: <String>['Single Course', 'Bundling'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  sortBy = newValue!;
                  sortBy == 'Bundling' ? showBundle = true : showBundle = false;
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
            height: 255,
            padding: EdgeInsets.fromLTRB(24, 24, 24, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(isLevel ? 'Level' : 'Jenis Course',
                        style: primaryTextStyle.copyWith(
                            fontWeight: bold, fontSize: 18)),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            resetFilter();
                            _currentPage = 1;
                          });
                          courseProvider.resetCoursePagination();
                          getCoursePag();
                          Navigator.pop(context);
                        },
                        child: Text('Reset',
                            style: thirdTextStyle.copyWith(fontSize: 14)))
                  ],
                ),
                SizedBox(height: 24),
                isLevel
                    ? Container(
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selectedLevel = 'Basic';
                                  _currentPage = 1;
                                });
                                courseProvider.resetCoursePagination();
                                getCoursePag();
                                Navigator.pop(context);

                                // Tutup bottom sheet setelah dipilih
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Basic',
                                      style: selectedLevel == 'Basic'
                                          ? thirdTextStyle.copyWith(
                                              fontSize: 18)
                                          : secondaryTextStyle.copyWith(
                                              fontSize: 18)),
                                  Divider(
                                    height: 20,
                                    thickness: 1,
                                    indent: 3,
                                    endIndent: 3,
                                    color: selectedLevel == 'Basic'
                                        ? primaryColor
                                        : secondaryColor,
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selectedLevel = 'Intermediate';
                                  _currentPage = 1;
                                });
                                courseProvider.resetCoursePagination();
                                getCoursePag();
                                Navigator.pop(context);
                                // Tutup bottom sheet setelah dipilih
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Intermediate',
                                      style: selectedLevel == 'Intermediate'
                                          ? thirdTextStyle.copyWith(
                                              fontSize: 18)
                                          : secondaryTextStyle.copyWith(
                                              fontSize: 18)),
                                  Divider(
                                    height: 20,
                                    thickness: 1,
                                    indent: 3,
                                    endIndent: 3,
                                    color: selectedLevel == 'Intermediate'
                                        ? primaryColor
                                        : secondaryColor,
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selectedLevel = 'Advanced';
                                  _currentPage = 1;
                                });
                                courseProvider.resetCoursePagination();
                                getCoursePag();
                                Navigator.pop(context);

                                // Tutup bottom sheet setelah dipilih
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Advanced',
                                      style: selectedLevel == 'Advanced'
                                          ? thirdTextStyle.copyWith(
                                              fontSize: 18)
                                          : secondaryTextStyle.copyWith(
                                              fontSize: 18)),
                                  Divider(
                                    height: 20,
                                    thickness: 1,
                                    indent: 3,
                                    endIndent: 3,
                                    color: selectedLevel == 'Advanced'
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
                                  sortBy = 'asc';
                                  _currentPage = 1;
                                });
                                courseProvider.resetCoursePagination();
                                getCoursePag();
                                Navigator.pop(context);
                                // Tutup bottom sheet setelah dipilih
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Termurah',
                                      style: sortBy == 'asc'
                                          ? thirdTextStyle.copyWith(
                                              fontSize: 18)
                                          : secondaryTextStyle.copyWith(
                                              fontSize: 18)),
                                  Divider(
                                    height: 20,
                                    thickness: 1,
                                    indent: 3,
                                    endIndent: 3,
                                    color: sortBy == 'asc'
                                        ? primaryColor
                                        : secondaryColor,
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  sortBy = 'desc';
                                  _currentPage = 1;
                                });
                                courseProvider.resetCoursePagination();
                                getCoursePag();
                                Navigator.pop(context);
                                // Tutup bottom sheet setelah dipilih
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Termahal',
                                      style: sortBy == 'desc'
                                          ? thirdTextStyle.copyWith(
                                              fontSize: 18)
                                          : secondaryTextStyle.copyWith(
                                              fontSize: 18)),
                                  Divider(
                                    height: 20,
                                    thickness: 1,
                                    indent: 3,
                                    endIndent: 3,
                                    color: sortBy == 'desc'
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  _showBottomSheet(context, false);
                },
                child: Row(
                  children: [
                    Image.asset('assets/icon_filter.png'),
                    Text(
                        sortBy == null
                            ? 'Urutkan'
                            : (sortBy == 'asc' ? 'Termurah' : 'Termahal'),
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
                    Text(
                        selectedLevel == null ? 'Filter Level' : selectedLevel!,
                        style: primaryTextStyle.copyWith(fontWeight: bold))
                  ],
                ),
              )
            ],
          ),
          selectedTag != null ||
                  selectedLevel != null ||
                  sortBy != null ||
                  _searchController.text.isNotEmpty
              ? TextButton(
                  onPressed: () {
                    setState(() {
                      resetFilter();
                      _currentPage = 1;
                    });
                    courseProvider.resetCoursePagination();
                    getCoursePag();
                  },
                  child: Text('Reset Filter',
                      style: thirdTextStyle.copyWith(fontWeight: semiBold)))
              : SizedBox()
        ],
      );
    }

    Widget shimmerGrid() {
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

    Widget gridCoursePagination() {
      return courseProvider.loadingPagination == true
          ? shimmerGrid()
          : GridView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: courseProvider.coursesList.length,
              // + (loading ? 1 : 0),
              itemBuilder: (context, index) {
                final courseFilter = courseProvider.coursesList[index];
                if (index == courseProvider.coursesList.length) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return CardCourse(course: courseFilter);
                }
              },

              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 3,
                mainAxisSpacing: 6,
                childAspectRatio: 0.72,
              ),
            );
    }

    Widget gridBundle() {
      return isLoading
          ? shimmerGrid()
          : GridView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: bundleProvider.bundle.length,
              // + (loading ? 1 : 0),
              itemBuilder: (context, index) {
                final bundle = bundleProvider.bundle[index];
                return CardCourse(bundle: bundle, isBundle: true);
              },

              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 2,
                mainAxisSpacing: 12,
                childAspectRatio: 0.62,
              ),
            );
    }

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
                    text: 'Kursus',
                  ),
                  Tab(
                    text: 'Bundle',
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        tagItCourse(courseProvider.tags),
                        SizedBox(height: 10),
                        dropdownFilter(),
                        SizedBox(height: 8),
                        Expanded(
                          child: ListView(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            controller: _scrollController,
                            children: [
                              gridCoursePagination(),
                              // Text(
                              //     '${courseProvider.totalItemCourse},${courseProvider.coursesList.length}'),
                              courseProvider.totalItemCourse <= 1 ||
                                      courseProvider.totalItemCourse ==
                                          courseProvider.coursesList.length
                                  ? SizedBox()
                                  //  Center(
                                  //     child: Text('Kursus tidak ditemukan',
                                  //         style: primaryTextStyle.copyWith(
                                  //             fontWeight: bold)),
                                  //   )
                                  : Center(
                                      child: CircularProgressIndicator(),
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Isi konten tab Engineering
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: ListView(
                      children: [
                        // tagItCourse(courseProvider.tags),
                        // SizedBox(height: 18),
                        // dropdownFilter(),
                        SizedBox(height: 16),
                        gridBundle()
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
                  Navigator.pushReplacementNamed(context, '/home');
                },
              ),
              backgroundColor: Colors.white,
              centerTitle: false,
              title: searchBar()),
        ),
      ),
      body: Container(child: tabCourse()),
    );
  }
}
