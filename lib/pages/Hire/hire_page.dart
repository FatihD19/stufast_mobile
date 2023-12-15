import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stufast_mobile/pages/Hire/detail_hire_page.dart';
import 'package:stufast_mobile/pages/home/home_page.dart';
import 'package:stufast_mobile/pages/home/main_page.dart';
import 'package:stufast_mobile/providers/hire_provider.dart';
import 'package:stufast_mobile/theme.dart';
import 'package:stufast_mobile/widget/hire_tile.dart';

class HirePage extends StatefulWidget {
  const HirePage({super.key});

  @override
  State<HirePage> createState() => _HirePageState();
}

class _HirePageState extends State<HirePage> {
  @override
  void initState() {
    // TODO: implement initState
    getHireOffer();
    super.initState();
  }

  getHireOffer() async {
    await Provider.of<HireProvider>(context, listen: false).getHire();
  }

  String selectedTag = 'pending';
  @override
  Widget build(BuildContext context) {
    HireProvider hireProvider = Provider.of<HireProvider>(context);
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

    Widget filterTag() {
      return Row(
        children: [
          tagView('pending'),
          tagView('accept'),
          tagView('deny'),
        ],
      );
    }

    Widget hireList() {
      return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: hireProvider.hires.length,
          itemBuilder: (context, index) {
            final hire = hireProvider.hires[index];
            if (hire.result == selectedTag) {
              return HireTile(hire);
            } else {
              return Container();
            }
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Daftar Tawaran',
          style: primaryTextStyle.copyWith(fontWeight: semiBold, fontSize: 18),
        ),
        elevation: 0, // Menghilangkan shadow
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MainPage(navIndex: 3)));
          },
        ),
        backgroundColor: Colors.white,
        centerTitle: false,
      ),
      body: Container(
        padding: EdgeInsets.all(24),
        child: ListView(
          shrinkWrap: true,
          children: [
            filterTag(),
            SizedBox(height: 20),
            hireList(),
          ],
        ),
      ),
    );
  }
}
