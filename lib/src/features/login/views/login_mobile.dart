import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orb/src/core/ui/textfield.dart';

import '../../../core/constants/colors.dart';

class MobileLogin extends StatelessWidget {
  const MobileLogin(
      {Key? key,
      required this.formKey,
      required this.phoneCtrl,
      required this.phoneCode,
      required this.passCtrl,
      required this.onChangedCountry})
      : super(key: key);
  final GlobalKey formKey;
  final TextEditingController phoneCtrl;
  final TextEditingController passCtrl;
  final String phoneCode;
  final void Function(String?) onChangedCountry;
  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(
          children: [
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
                          margin: EdgeInsets.only(bottom: 16.h),
                          child: CountryCodePicker(
                            dialogBackgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            onChanged: (value) {
                              onChangedCountry.call(value.dialCode);
                            },
                            builder: (countryCode) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.w, vertical: 14.h),
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
                            initialSelection: phoneCode,
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
                        controller: phoneCtrl,
                        label: "",
                        hint: "Mobile Number",
                        prefix: FlutterRemix.phone_line,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            KTextFormField(
              controller: passCtrl,
              label: "Password",
              hint: "Password",
              marginBottom: false,
              prefix: FlutterRemix.key_2_line,
            )
          ],
        ));
  }
}
