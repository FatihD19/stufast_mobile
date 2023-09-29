// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stufast_mobile/providers/faq_provider.dart';

import '../../providers/user_course_provider.dart';
import '../../theme.dart';

class FaqPage extends StatefulWidget {
  const FaqPage({super.key});

  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<FaqProvider>(context, listen: false).getFaq();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget faqTile(String question, String answer) {
      return Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text('$question',
              style: primaryTextStyle.copyWith(fontWeight: bold)),
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Text(
                '$answer',
                style: secondaryTextStyle,
              ),
            )
          ],
        ),
      );
    }

    Widget listFaq() {
      return context.watch<FaqProvider>().loading == true
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: context
                  .watch<FaqProvider>()
                  .faq
                  .map((faq) => faqTile('${faq.question}', '${faq.answer}'))
                  .toList(),
            );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'FAQ',
          style: primaryTextStyle.copyWith(fontWeight: semiBold),
        ),
        elevation: 0, // Menghilangkan shadow
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        centerTitle: false,
      ),
      body: Container(
        padding: EdgeInsets.all(24),
        child: listFaq(),
      ),
    );
  }
}
