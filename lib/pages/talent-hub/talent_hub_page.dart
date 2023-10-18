import 'package:flutter/material.dart';
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
  ScrollController _scrollController = ScrollController();
  int totalTalentCount = 10;

  @override
  void initState() {
    // TODO: implement initState\

    Provider.of<TalentHubProvider>(context, listen: false)
        .getTalentHub(searchQuery: _searchQuery);

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

  bool? loading;

  getInit() async {
    setState(() {
      loading = true;
    });

    await Provider.of<TalentHubProvider>(context, listen: false)
        .getTalentHub(searchQuery: _searchQuery, sortBy: _sortBy);
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
                Text('Urutkan berdasarkan',
                    style: primaryTextStyle.copyWith(
                        fontWeight: bold, fontSize: 18)),
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
                      onChanged: (value) {
                        setState(() {
                          _sortBy = '';
                          _searchQuery = value;
                          getInit();
                        });
                      },
                    ),
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     setState(() {
                  //       _searchQuery = _searchController.text;
                  //       getInit();
                  //     });
                  //   },
                  //   child: Padding(
                  //     padding: EdgeInsets.all(8),
                  //     child: Image.asset('assets/icon_search.png'),
                  //   ),
                  // ),
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
        ],
      );
    }

    Widget gridTalent() {
      return talentHubProvider.loading == true
          ? Center(child: CircularProgressIndicator())
          : GridView(
              controller: _scrollController,
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4,
                mainAxisSpacing: 8,
                childAspectRatio: 0.5893,
              ),
              children: talentHubProvider.talent
                  .map((talent) => TalentCard(talent))
                  .take(totalTalentCount)
                  .toList());
    }
    // Widget gridTalent() {
    //   return GridView.builder(
    //     shrinkWrap: true,
    //     physics: ScrollPhysics(),
    //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //       crossAxisCount: 2,
    //       crossAxisSpacing: 4,
    //       mainAxisSpacing: 8,
    //       childAspectRatio: 0.5893,
    //     ),
    //     itemCount: talentList.length,
    //     itemBuilder: (context, index) {
    //       final talent = talentList[index];
    //       return TalentCard(talent);
    //     },
    //   );
    // }

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
                  SizedBox(height: 16),
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        loading == true
                            ? Center(child: CircularProgressIndicator())
                            : gridTalent()
                      ],
                    ),
                  ),
                ],
              ),
            ));
  }
}
