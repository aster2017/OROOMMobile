import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orb/src/core/ui/textfield.dart';
import 'package:phone_number/phone_number.dart';

import '../../../core/constants/colors.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm(
      {Key? key,
      required this.formKey,
      required this.phoneCtrl,
      required this.phoneCode,
      required this.passCtrl,
      required this.onChangedCountry,
      required this.confirmPassCtrl,
      required this.emailCtrl,
      required this.nameCtrl})
      : super(key: key);
  final GlobalKey formKey;
  final TextEditingController phoneCtrl;
  final TextEditingController passCtrl;
  final TextEditingController confirmPassCtrl;
  final TextEditingController emailCtrl;
  final TextEditingController nameCtrl;
  final String phoneCode;
  final void Function(String?) onChangedCountry;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool errorPhone = true;
  Future<bool> validatePhone(String val) async {
    bool isValid = await PhoneNumberUtil().validate(val);

    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.formKey,
        child: Column(
          children: [
            KTextFormField(
              controller: widget.nameCtrl,
              label: "Full name",
              hint: "Full name",
              prefix: FlutterRemix.user_3_fill,
              validator: (value) {
                RegExp regex = RegExp(r"^[a-zA-Z]{2,}(?: [a-zA-Z]+){0,2}$");
                return regex.hasMatch(value!.trim())
                    ? null
                    : "Enter valid Name";
              },
            ),
            KTextFormField(
              controller: widget.emailCtrl,
              label: "Email",
              hint: "Email",
              keyboardType: TextInputType.emailAddress,
              prefix: FlutterRemix.mail_fill,
              validator: (value) {
                return RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value!)
                    ? null
                    : "Enter valid Email";
              },
            ),
            Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Mobile Number",
                    style: GoogleFonts.mulish(
                        color: textPrimary,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        height: 1.2),
                  ),
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 8.h,
                        ),
                        Container(
                          // padding: EdgeInsets.symmetric(
                          //     horizontal: 20.w, vertical: 14.h),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.h),
                              border: Border.all(color: textPrimary)),
                          margin: EdgeInsets.only(bottom: 10.h + 12.sp),
                          child: CountryCodePicker(
                            dialogBackgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            onChanged: (value) {
                              widget.onChangedCountry.call(value.dialCode);
                            },
                            builder: (countryCode) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.w, vertical: 16.h),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      countryCode!.flagUri!,
                                      package: 'country_code_picker',
                                      width: 17.sp,
                                      height: 17.sp,
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      countryCode.dialCode ?? "+977",
                                      style: GoogleFonts.workSans(
                                          color: textPrimary,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          height: 1.2),
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Icon(
                                      FlutterRemix.arrow_down_s_line,
                                      size: 14.w,
                                      color: textPrimary,
                                    )
                                  ],
                                ),
                              );
                            },
                            hideMainText: false,
                            showFlagMain: true,
                            showFlag: true,
                            hideSearch: false,
                            initialSelection: widget.phoneCode,
                            showOnlyCountryWhenClosed: false,
                            alignLeft: true,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    Expanded(
                      child: KTextFormField(
                        controller: widget.phoneCtrl,
                        keyboardType: TextInputType.phone,
                        label: "",
                        hint: "Mobile Number",
                        inputFormatter: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        prefix: FlutterRemix.phone_line,
                        onChanged: (p0) {
                          validatePhone(widget.phoneCode + p0!).then((value) {
                            setState(() {
                              errorPhone = !value;
                            });
                          });
                        },
                        validator: (val) {
                          // if (val == null || val.isEmpty) {
                          //   return "Enter a Phone Number";
                          // } else {

                          // }

                          return errorPhone ? "Enter valid Phone number" : null;
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            KTextFormField(
              controller: widget.passCtrl,
              label: "Password",
              hint: "Password",
              obscureText: true,
              prefix: FlutterRemix.key_2_line,
              validator: (value) {
                RegExp regex = RegExp(
                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[,.*?!@#$&*~_+:;\-/=\"\(\)\{}\[\]<>]).{8,}$');
                if (value!.isEmpty) {
                  return 'Please enter password';
                } else {
                  if (!regex.hasMatch(value)) {
                    return "Password length must be 8 characters and at least one uppercase letter, one number and one symbol";
                  } else {
                    return null;
                  }
                }
              },
            ),
            KTextFormField(
              controller: widget.confirmPassCtrl,
              label: "Confirm Password",
              hint: "Confirm Password",
              marginBottom: false,
              obscureText: true,
              prefix: FlutterRemix.key_2_line,
              validator: (value) {
                if (value == widget.passCtrl.text) {
                  return null;
                } else {
                  return "Password should match.";
                }
              },
            )
          ],
        ));
  }
}
