import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:number_auth_task/auth_controller.dart';
import 'package:number_auth_task/pages/home_page.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

class CodeVerificationPage extends StatelessWidget {
  const CodeVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Expanded(
          child: OTPTextField(
            width: MediaQuery.of(context).size.width,
            length: 6,
            textFieldAlignment: MainAxisAlignment.spaceAround,
            fieldWidth: 45,
            fieldStyle: FieldStyle.box,
            outlineBorderRadius: 15,
            
            // otpFieldStyle: OtpFieldStyle(
            //   enabledBorderColor: Colors.yellow,
            //   disabledBorderColor: Colors.black,
            // ),
            onChanged: (v) {},
            onCompleted: (value) async {
              bool isVerified = await Get.find<AuthController>().verifyOTP(value);
              isVerified ? Get.offAll(() => const HomePage()) : Get.back();
            },
          ),
        ),
      ),
    );
  }
}