import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:stufast_mobile/models/talent_hub_model.dart';
import 'package:stufast_mobile/providers/talentHub_provider.dart';
import 'package:stufast_mobile/theme.dart';
import 'package:stufast_mobile/widget/talent_card.dart';

class TalentHubPage extends StatefulWidget {
  const TalentHubPage({super.key});

  @override
  State<TalentHubPage> createState() => _TalentHubPageState();
}

class _TalentHubPageState extends State<TalentHubPage> {
  final _scrollController = ScrollController();
  int totalTalentCount = 10;
  int _currentPage = 1;
  bool error = false;
  int currentIndex = 0;

  bool? useFilter;

  void _loadMore() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _currentPage++;
      try {
        setState(() {
          loading = false;
        });
        Provider.of<TalentHubProvider>(context, listen: false)
            .getTalentHub(index: _currentPage);
        setState(() {
          loading = true;
        });
      } catch (e) {
        setState(() {
          error = true;
        });
      }
    }
  }

  List item = [
    'assets/img_promo_talent2.png',
    'assets/img_promo_talent.png',
  ];

  @override
  void initState() {
    // TODO: implement initState\
    _scrollController.addListener(_loadMore);
    getTalentByIndex();
    // Provider.of<TalentHubProvider>(context, listen: false).fetchTalentData();

    // _scrollController.addListener(() {
    //   if (_scrollController.position.pixels ==
    //       _scrollController.position.maxScrollExtent) {
    //     if (totalTalentCount >
    //         Provider.of<TalentHubProvider>(context, listen: false)
    //             .talent
    //             .length) {
    //       setState(() {
    //         totalTalentCount += 10;
    //       });
    //       print('on bottom');

    //     } else {
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         SnackBar(
    //           backgroundColor: Colors.green,
    //           content: Text(
    //             'berhasil tambah ke chart',
    //             textAlign: TextAlign.center,
    //           ),
    //         ),
    //       );
    //     }
    //   }
    // });
    super.initState();
  }

  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _sortBy = '';

  bool loading = false;

  getTalentByIndex() async {
    await Provider.of<TalentHubProvider>(context, listen: false)
        .getTalentHub(index: _currentPage);
  }

  getInit() async {
    setState(() {
      loading = true;
      useFilter = true;
    });

    await Provider.of<TalentHubProvider>(context, listen: false)
        .getTalentFilter(
            userFilter: true, searchQuery: _searchQuery, sortBy: _sortBy);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    TalentHubProvider talentHubProvider =
        Provider.of<TalentHubProvider>(context);

    void _showBottomSheet(BuildContext context) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 237,
            padding: EdgeInsets.fromLTRB(24, 24, 24, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Urutkan berdasarkan',
                        style: primaryTextStyle.copyWith(
                            fontWeight: bold, fontSize: 18)),
                    InkWell(
                        onTap: () {
                          setState(() {
                            _searchController.text = '';
                            _searchQuery = '';
                            _sortBy = '';
                            useFilter = false;
                            getTalentByIndex();
                            Navigator.pop(context);
                          });
                        },
                        child: Text('Reset',
                            style: thirdTextStyle.copyWith(fontSize: 14)))
                  ],
                ),
                SizedBox(height: 24),
                Container(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            _searchController.text = '';
                            _searchQuery = '';
                            _sortBy = '';
                            getInit();
                            Navigator.pop(context);
                          });

                          // Tutup bottom sheet setelah dipilih
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Nilai Tertinggi',
                                style: _sortBy == 'average_score'
                                    ? thirdTextStyle.copyWith(fontSize: 18)
                                    : secondaryTextStyle.copyWith(
                                        fontSize: 18)),
                            Divider(
                              height: 20,
                              thickness: 1,
                              indent: 3,
                              endIndent: 3,
                              color: _sortBy == 'average_score'
                                  ? primaryColor
                                  : secondaryColor,
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _searchController.text = '';
                            _searchQuery = '';
                            _sortBy = 'total_course';
                            getInit();
                            Navigator.pop(context);
                          });

                          // Tutup bottom sheet setelah dipilih
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Jumlah Course',
                                style: _sortBy == 'total_course'
                                    ? thirdTextStyle.copyWith(fontSize: 18)
                                    : secondaryTextStyle.copyWith(
                                        fontSize: 18)),
                            Divider(
                              height: 20,
                              thickness: 1,
                              indent: 3,
                              endIndent: 3,
                              color: _sortBy == 'total_course'
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
                        hintText: 'Cari Talent',
                        border: InputBorder.none,
                      ),
                      // onChanged: (value) {
                      //   setState(() {
                      //     _sortBy = '';
                      //     _searchQuery = value;
                      //     getInit();
                      //   });
                      // },
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _searchQuery = _searchController.text;
                        getInit();
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
          SizedBox(width: 16),
          Container(
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                _showBottomSheet(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.sort, size: 16),
                  SizedBox(width: 3),
                  Text(
                    'Urutkan',
                    style: buttonTextStyle.copyWith(
                        fontWeight: bold, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 72),
        ],
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

    Widget promoTalent() {
      int index = -1;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Column(
          children: [
            SizedBox(height: 10),
            CarouselSlider(
              items: item.map((e) {
                index++;
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage(e),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }).toList(),
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
              children: item.map((e) {
                index++;
                return indicator(index);
              }).toList(),
            ),
            SizedBox(height: 10),
          ],
        ),
      );
    }

    Widget gridTalent() {
      return talentHubProvider.loading == true
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: talentHubProvider.talent.length,
              // + (loading ? 1 : 0),
              itemBuilder: (context, index) {
                final talent = talentHubProvider.talent[index];
                if (index == talentHubProvider.talent.length - 1) {
                  return Center(child: CircularProgressIndicator());
                } else if (talentHubProvider.error == true) {
                  Center(child: Text('error'));
                } else {
                  return TalentCard(talent);
                }
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 1,
                mainAxisSpacing: 4,
                childAspectRatio: 0.655,
              ));
      // children: talentHubProvider.talent
      //     .map((talent) => TalentCard(talent))
      //     .take(totalTalentCount)
      //     .toList());
    }

    Widget gridTalentFilter() {
      return loading == true
          ? Column(
              children: [
                SizedBox(height: 50),
                Center(child: CircularProgressIndicator()),
              ],
            )
          : GridView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4,
                mainAxisSpacing: 8,
                childAspectRatio: 0.5893,
              ),
              itemCount: talentHubProvider.talentPage.length,
              itemBuilder: (context, index) {
                final talent = talentHubProvider.talentPage[index];
                return TalentCard(talent);
              },
            );
    }

    return
        // TalentHubScreen();
        Scaffold(
            appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                centerTitle: false,
                leadingWidth: 0,
                title: Container(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(
                    'Talent Hub',
                    style: primaryTextStyle.copyWith(
                        fontWeight: bold, fontSize: 18),
                  ),
                )),
            body: Container(
              margin: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  searchBar(),
                  Expanded(
                    child: useFilter == true
                        ? ListView(
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            children: [promoTalent(), gridTalentFilter()],
                          )
                        : ListView(
                            controller: _scrollController,
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            children: [promoTalent(), gridTalent()],
                          ),
                  ),
                ],
              ),
            ));
  }
}
