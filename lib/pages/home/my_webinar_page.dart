import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stufast_mobile/providers/webinar_provider.dart';
import 'package:stufast_mobile/widget/webinar_card.dart';

import '../../theme.dart';

class WebinarPage extends StatefulWidget {
  const WebinarPage({super.key});

  @override
  State<WebinarPage> createState() => _WebinarPageState();
}

class _WebinarPageState extends State<WebinarPage> {
  bool? loading;
  @override
  void initState() {
    // TODO: implement initState
    getInit();
    Provider.of<WebinarProvider>(context, listen: false).getWebinar(true);
    super.initState();
  }

  getInit() async {
    setState(() {
      loading = true;
    });
    await Provider.of<WebinarProvider>(context, listen: false).getWebinar(true);

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget useWebinar() {
      return context.watch<WebinarProvider>().loading
          ? CircularProgressIndicator()
          : ListView(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              children: context
                  .watch<WebinarProvider>()
                  .userWebinar
                  .map((webinar) => WebinarCard(webinar, true))
                  .toList(),
            );
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          // margin: EdgeInsets.only(top: 24),
          child: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              centerTitle: false,
              leadingWidth: 0,
              title: Container(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  'My Webinar',
                  style:
                      primaryTextStyle.copyWith(fontWeight: bold, fontSize: 18),
                ),
              )),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: useWebinar(),
      ),
    );
  }
}
