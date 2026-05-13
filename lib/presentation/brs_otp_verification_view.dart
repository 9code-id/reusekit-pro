import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsOtpVerificationView extends StatefulWidget {
  const BrsOtpVerificationView({super.key});

  @override
  State<BrsOtpVerificationView> createState() => _BrsOtpVerificationViewState();
}

class _BrsOtpVerificationViewState extends State<BrsOtpVerificationView> {
  String otp1 = "";
  String otp2 = "";
  String otp3 = "";
  String otp4 = "";
  String otp5 = "";
  String otp6 = "";
  int remainingTime = 120;
  bool canResend = false;

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  void startCountdown() {
    Future.doWhile(() async {
      await Future.delayed(Duration(seconds: 1));
      if (mounted) {
        setState(() {
          remainingTime--;
          if (remainingTime <= 0) {
            canResend = true;
          }
        });
      }
      return remainingTime > 0 && mounted;
    });
  }

  String get otpCode => otp1 + otp2 + otp3 + otp4 + otp5 + otp6;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify OTP"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            Container(
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(30),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.security,
                      size: 50,
                      color: infoColor,
                    ),
                  ),
                  SizedBox(height: spLg),
                  Text(
                    "Verification Code",
                    style: TextStyle(
                      fontSize: fsH3,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "We've sent a 6-digit verification code to",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "example@email.com",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              child: Column(
                children: [
                  Text(
                    "Enter verification code",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    spacing: spSm,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildOtpField(otp1, (value) {
                        otp1 = value;
                        setState(() {});
                      }),
                      _buildOtpField(otp2, (value) {
                        otp2 = value;
                        setState(() {});
                      }),
                      _buildOtpField(otp3, (value) {
                        otp3 = value;
                        setState(() {});
                      }),
                      _buildOtpField(otp4, (value) {
                        otp4 = value;
                        setState(() {});
                      }),
                      _buildOtpField(otp5, (value) {
                        otp5 = value;
                        setState(() {});
                      }),
                      _buildOtpField(otp6, (value) {
                        otp6 = value;
                        setState(() {});
                      }),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Verify Code",
                size: bs.md,
                onPressed: otpCode.length == 6
                    ? () async {
                        showLoading();
                        await Future.delayed(Duration(seconds: 2));
                        hideLoading();
                        if (otpCode == "123456") {
                          ss("Verification successful!");
                          await offAll(BrsHomeView());
                        } else {
                          se("Invalid verification code");
                        }
                      }
                    : null,
              ),
            ),
            Container(
              width: double.infinity,
              child: Column(
                children: [
                  if (!canResend) ...[
                    Text(
                      "Resend code in ${remainingTime}s",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ] else ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Didn't receive the code? ",
                          style: TextStyle(
                            color: disabledBoldColor,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              remainingTime = 120;
                              canResend = false;
                            });
                            startCountdown();
                            ss("Verification code sent again!");
                          },
                          child: Text(
                            "Resend",
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: warningColor.withAlpha(50)),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.info,
                    color: warningColor,
                    size: 20,
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Security Notice",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: warningColor,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Never share your verification code with anyone. Our team will never ask for your code.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOtpField(String value, Function(String) onChanged) {
    return Container(
      width: 45,
      height: 55,
      decoration: BoxDecoration(
        border: Border.all(
          color: value.isNotEmpty ? primaryColor : disabledOutlineBorderColor,
          width: value.isNotEmpty ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(radiusSm),
        color: value.isNotEmpty ? primaryColor.withAlpha(10) : Colors.transparent,
      ),
      child: TextField(
        textAlign: TextAlign.center,
        maxLength: 1,
        keyboardType: TextInputType.number,
        style: TextStyle(
          fontSize: fsH5,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          counterText: "",
        ),
        onChanged: (val) {
          if (val.length <= 1) {
            onChanged(val);
            if (val.length == 1) {
              FocusScope.of(context).nextFocus();
            }
          }
        },
      ),
    );
  }
}
