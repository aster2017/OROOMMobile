import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orb/src/core/constants/colors.dart';
import 'package:orb/src/features/hotelDetail/views/room_detail.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EsewaEpay extends StatefulWidget {
  const EsewaEpay(
      {super.key, required this.price, required this.id, required this.pid});
  final String price;
  final String id;
  final String pid;

  @override
  EsewaEpayState createState() => EsewaEpayState();
}

class EsewaEpayState extends State<EsewaEpay> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  final String url = "https://esewa.com.np/epay/main";
  String? postData;
  final box = GetStorage();
  String scd = "NP-ES-BOOKANDFLY";

  String su = "https://bookandflytours.com/payment-success";
  String fu = "https://bookandflytours.com/payment-failed";
  @override
  void initState() {
    super.initState();
    postData =
        "tAmt=${widget.price}&amt=${widget.price}&txAmt=0&psc=0&pdc=0&scd=$scd&pid=${widget.pid}&su=$su&fu=$fu";
  }

  final _key = UniqueKey();

  bool isLoading = false;
  bool loading = true;
  bool isError = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: textPrimary),
        title: Text(
          "Pay using eSewa",
          style: GoogleFonts.mulish(
              color: textPrimary, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body:
          //   loading == true ? Center(child: CircularProgressIndicator(),) :
          Stack(children: [
        WebView(
          key: _key,
          initialUrl: "https://www.bookandflytours.com/initializing-payment",
          javascriptMode: JavascriptMode.unrestricted,
          onWebResourceError: (error) {
            // if (error.errorCode == 500 ||
            //     error.errorCode == 403 ||
            //     error.errorCode == 401) {
            //   setState(() {
            //     isError = true;
            //   });
            // }
          },
          onPageStarted: (String url) async {},
          onPageFinished: (String url) {
            print(url);
            bookingController.bookingGuID.value = widget.id;
            if (url.contains(su)) {
              final uriData = Uri.parse(url);
              final oid = uriData.queryParameters['oid'];
              final amt = uriData.queryParameters['amt'].toString();
              final refId = uriData.queryParameters['refId'];
              print(amt.runtimeType);
              bookingController.bookRoomPayment(
                  provider: "ESEWA",
                  currency: "NPR",
                  amount: amt,
                  amountInPaisa: amt.split('.').first,
                  mobile: "9865211211",
                  idx: refId,
                  productIdentity: oid,
                  productName: "asd",
                  productUrl: oid,
                  token: "string");
              bookingController.bookRoomPost();
              Get.back();
            }
            if (url.contains(fu)) {
              Navigator.pop(context);
            }
          },
          onWebViewCreated: (WebViewController webViewController) async {
            _controller.complete(webViewController);
            await _loadHtmlFromAssets(webViewController);
          },
        ),
      ]),
    );
  }

  Future<void> _loadHtmlFromAssets(WebViewController webViewController) async {
    String script = '''
      const form = document.createElement('form');
      form.method = 'POST';
      form.action = '$url';
      const postData = '$postData';
      const params = postData.split('&');
      for (let i = 0; i < params.length; i++) {
        const keyValuePair = params[i].split('=');
        const key = decodeURIComponent(keyValuePair[0]);
        const value = decodeURIComponent(keyValuePair[1]);
        const input = document.createElement('input');
        input.type = 'hidden';
        input.name = key;
        input.value = value;
        form.appendChild(input);
      }
      document.body.appendChild(form);
      form.submit();
    ''';
    if (Platform.isAndroid) {
      setState(() {
        isLoading = true;
      });
      Future.delayed(Duration(seconds: 2), () async {
        await webViewController.runJavascript(script);
        setState(() {
          isLoading = false;
        });
      });
    } else {
      await webViewController.runJavascript(script);
    }
    // await webViewController.runJavascript(script);
  }
}
