import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaOtpVerificationView extends StatefulWidget {
  const ReaOtpVerificationView({super.key});

  @override
  State<ReaOtpVerificationView> createState() => _ReaOtpVerificationViewState();
}

class _ReaOtpVerificationViewState extends State<ReaOtpVerificationView> {
  String otp1 = "";
  String otp2 = "";
  String otp3 = "";
  String otp4 = "";
  String otp5 = "";
  String otp6 = "";
  bool isResending = false;
  int countdown = 60;

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  void startCountdown() {
    Future.delayed(Duration(seconds: 1), () {
      if (countdown > 0) {
        countdown--;
        setState(() {});
        startCountdown();
      }
    });
  }

  String get fullOtp => otp1 + otp2 + otp3 + otp4 + otp5 + otp6;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify Account"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: spLg),
            Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(50),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.security,
                  size: 50,
                  color: primaryColor,
                ),
              ),
            ),
            SizedBox(height: spLg),
            Text(
              "Verification Code",
              style: TextStyle(
                fontSize: fsH2,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: spMd),
            Text(
              "We've sent a 6-digit verification code to your email address. Please enter the code below to verify your account.",
              style: TextStyle(
                fontSize: fsH6,
                color: disabledBoldColor,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: spXl),
            Row(
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
            SizedBox(height: spXl),
            QButton(
              label: "Verify Code",
              size: bs.md,
              onPressed: fullOtp.length == 6 ? () {
                if (fullOtp == "123456") {
                  ss("Account verified successfully");
                  // --
                } else {
                  se("Invalid verification code");
                }
              } : null,
            ),
            SizedBox(height: spLg),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Didn't receive the code? ",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                if (countdown > 0) ...[
                  Text(
                    "Resend in ${countdown}s",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ] else ...[
                  GestureDetector(
                    onTap: () {
                      countdown = 60;
                      startCountdown();
                      ss("Verification code sent again");
                      setState(() {});
                    },
                    child: Text(
                      "Resend Code",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            SizedBox(height: spXl),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: warningColor.withAlpha(100)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: warningColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Verification Tips",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Check your email spam/junk folder\n• Code expires in 10 minutes\n• Use demo code: 123456",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.4,
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
          width: 2,
        ),
        borderRadius: BorderRadius.circular(radiusSm),
        color: value.isNotEmpty ? primaryColor.withAlpha(20) : Colors.transparent,
      ),
      child: Center(
        child: TextField(
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            counterText: "",
          ),
          onChanged: (val) {
            onChanged(val);
            if (val.isNotEmpty) {
              FocusScope.of(context).nextFocus();
            }
          },
        ),
      ),
    );
  }
}
