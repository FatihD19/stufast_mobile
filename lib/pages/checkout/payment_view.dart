import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stufast_mobile/pages/succsess_page.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../theme.dart';

class PaymentView extends StatefulWidget {
  String? tokenPay;
  PaymentView(this.tokenPay);

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  void dispose() {
    // Membersihkan WebView

    super.dispose();
  }

  Future<bool> showExitPopup() async {
    return await showDialog(
          //show confirm dialogue
          //the return value will be from "Yes" or "No" options
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Exit App'),
            content: Text('Selesaikan Pembayaran Sekarang ?'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
                //return false when click on "NO"
                child: Text('Nanti'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            PaymentView("${widget.tokenPay}")),
                  );
                },
                child: Text('Sekarang'),
              ),
            ],
          ),
        ) ??
        false; //if showDialouge had returned null, then return false
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: WebView(
            initialUrl:
                'https://dev.stufast.id/api/order/web-view?token=${widget.tokenPay}',
            // onWebViewCreated: (WebViewController webViewController) {
            //   _controller.complete(webViewController);
            // },
            javascriptMode: JavascriptMode.unrestricted,
            navigationDelegate: (NavigationRequest request) {
              if (request.url
                  .startsWith('https://dev.stufast.id/snap/sukses')) {
                // Navigasi ke halaman SuccessPage jika URL sesuai
                Navigator.pushNamed(context, '/user-course');
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => SuccsessPage(
                //             titleMess: "Selamat Pembayaran anda Berhasil",
                //             mess: "silahkan buka course di halaman My Course",
                //             pay: true,
                //           )),
                // );
                return NavigationDecision.prevent;
              } else if (request.url
                  .startsWith('https://dev.stufast.id/snap/batal')) {
                showExitPopup();
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
          ),
        ),
      ),
    );
  }
}
