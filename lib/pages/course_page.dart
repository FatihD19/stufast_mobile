// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class CoursePage extends StatelessWidget {
  const CoursePage({super.key});

  @override
  Widget build(BuildContext context) {
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
            ),
          ),
        ],
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
                    text: 'IT',
                  ),
                  Tab(
                    text: 'Engineering',
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Isi konten tab IT
                  Center(
                    child: Text('Tab IT Content'),
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
