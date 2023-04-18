import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:orb/src/core/ui/textfield.dart';

class EmailLogin extends StatelessWidget {
  const EmailLogin({
    Key? key,
    required this.formKey,
    required this.emailCtrl,
    required this.passCtrl,
  }) : super(key: key);
  final GlobalKey formKey;
  final TextEditingController emailCtrl;
  final TextEditingController passCtrl;
  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(
          children: [
            KTextFormField(
              controller: emailCtrl,
              keyboardType: TextInputType.emailAddress,
              label: "Email",
              hint: "youremailaddress@example.com",
              prefix: FlutterRemix.mail_fill,
            ),
            KTextFormField(
              controller: passCtrl,
              label: "Password",
              hint: "Password",
              marginBottom: false,
              obscureText: true,
              prefix: FlutterRemix.key_2_line,
            )
          ],
        ));
  }
}
