import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class KhaltiPaymentApp extends StatefulWidget {
  const KhaltiPaymentApp({super.key, required this.pid});

  final dynamic pid;

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<KhaltiPaymentApp> {
  String su = "https://bookandflytours.com/payment-success";
  String fu = "https://bookandflytours.com/payment-failed";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pay using Khalti",
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: WebView(
              initialUrl:
                  widget.pid['khalti_initiate']['payment_url'].toString(),
              javascriptMode: JavascriptMode.unrestricted,
              onPageStarted: (String url) async {},
              onPageFinished: (url) {
                if (url.contains(su)) {}
                if (url.contains(fu)) {}
              },
            ),
          ),
        ],
      ),
    );
  }
}
