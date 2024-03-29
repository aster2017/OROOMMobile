import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orb/src/core/controller/auth_controller.dart';
import 'package:orb/src/core/ui/loading.dart';
import 'package:orb/src/core/ui/textfield.dart';

import '../../../core/constants/colors.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final AuthController authController = Get.find<AuthController>();
  final TextEditingController firstname = TextEditingController();
  final TextEditingController lastname = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstname.text = authController.user.value!.firstName ?? "";
    lastname.text = authController.user.value!.lastName ?? "";
    phone.text = authController.user.value!.phoneNumber ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: textPrimary),
        title: Text(
          "Edit Profile",
          style: GoogleFonts.mulish(
              color: textPrimary, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => Stack(
          children: [
            bodyWidget(),
            authController.isLoading.value ? LoadingOverlay() : Container()
          ],
        ),
      ),
    );
  }

  Column bodyWidget() {
    return Column(children: [
      Divider(
        height: 2,
        color: Color(0xfff2f2f2),
      ),
      Expanded(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Form(
            key: formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  KTextFormField(
                    label: "First name",
                    isFilled: true,
                    controller: firstname,
                    hint: "Firstname",
                    validator: (value) {
                      RegExp regex = RegExp(r"^[a-zA-Z]{2,}$");
                      return regex.hasMatch(value!.trim())
                          ? null
                          : "Enter valid First Name";
                    },
                  ),
                  KTextFormField(
                    label: "Last name",
                    isFilled: true,
                    controller: lastname,
                    hint: "Lastname",
                    validator: (value) {
                      RegExp regex = RegExp(r"^[a-zA-Z]{2,}$");
                      return regex.hasMatch(value!.trim())
                          ? null
                          : "Enter valid Last Name";
                    },
                  ),
                  KTextFormField(
                    label: "Email",
                    isFilled: true,
                    enabled: false,
                    hint: authController.user.value?.email ?? "",
                  ),
                  KTextFormField(
                    label: "Phone number",
                    isFilled: true,
                    controller: phone,
                    hint: "98 **** ****",
                  ),
                  Expanded(child: Container()),
                  GestureDetector(
                    onTap: () async {
                      if (!formKey.currentState!.validate()) {
                        return;
                      }
                      FocusScope.of(context).unfocus();
                      await authController.editUser(
                          firstName: firstname.text,
                          lastName: lastname.text,
                          phoneNo: phone.text);
                    },
                    child: Container(
                      width: 170.w,
                      height: 44.h,
                      margin: EdgeInsets.only(bottom: 20.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.w),
                          color: primaryColor),
                      child: Center(
                        child: Text(
                          "Update",
                          style: GoogleFonts.mulish(
                              color: whiteColor, height: 1.4, fontSize: 16.sp),
                        ),
                      ),
                    ),
                  )
                ]),
          ),
        ),
      )
    ]);
  }
}
