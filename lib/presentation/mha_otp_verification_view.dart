import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaOtpVerificationView extends StatefulWidget {
  const MhaOtpVerificationView({super.key});

  @override
  State<MhaOtpVerificationView> createState() => _MhaOtpVerificationViewState();
}

class _MhaOtpVerificationViewState extends State<MhaOtpVerificationView> {
  String otp = "";
  String email = "john.doe@example.com";
  bool loading = false;
  int resendTimer = 60;
  bool canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    Future.delayed(Duration(seconds: 1), () {
      if (resendTimer > 0) {
        resendTimer--;
        setState(() {});
        _startTimer();
      } else {
        canResend = true;
        setState(() {});
      }
    });
  }

  void _verifyOtp() async {
    if (otp.length != 6) {
      se("Please enter complete OTP");
      return;
    }

    loading = true;
    setState(() {});
    
    // Simulate OTP verification
    await Future.delayed(Duration(seconds: 2));
    
    loading = false;
    setState(() {});
    
    ss("OTP verified successfully!");
    // navigateTo(MhaHomeView());
  }

  void _resendOtp() async {
    if (!canResend) return;
    
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    
    resendTimer = 60;
    canResend = false;
    setState(() {});
    _startTimer();
    
    ss("OTP resent successfully!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify OTP"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: spLg),
            Center(
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Icon(
                  Icons.verified_user,
                  size: 40,
                  color: primaryColor,
                ),
              ),
            ),
            SizedBox(height: spLg),
            Text(
              "Verify Your Account",
              style: TextStyle(
                fontSize: fsH3,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "We've sent a 6-digit verification code to:",
              style: TextStyle(
                fontSize: 16,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              email,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spXl),
            Text(
              "Enter Verification Code",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, (index) {
                return Container(
                  width: 50,
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: otp.length > index ? primaryColor : disabledColor,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(radiusMd),
                    color: otp.length > index ? primaryColor.withAlpha(20) : Colors.transparent,
                  ),
                  child: Center(
                    child: Text(
                      otp.length > index ? otp[index] : "",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: spMd),
            Container(
              height: 60,
              child: TextField(
                keyboardType: TextInputType.number,
                maxLength: 6,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  letterSpacing: 8,
                  color: Colors.transparent,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  counterText: "",
                ),
                onChanged: (value) {
                  otp = value;
                  setState(() {});
                  if (value.length == 6) {
                    _verifyOtp();
                  }
                },
              ),
            ),
            SizedBox(height: spXl),
            if (loading)
              Center(child: CircularProgressIndicator())
            else
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Verify Code",
                  size: bs.md,
                  onPressed: _verifyOtp,
                ),
              ),
            SizedBox(height: spLg),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Didn't receive the code? ",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
                GestureDetector(
                  onTap: canResend ? _resendOtp : null,
                  child: Text(
                    canResend ? "Resend" : "Resend in ${resendTimer}s",
                    style: TextStyle(
                      color: canResend ? primaryColor : disabledBoldColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spXl),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Verification Tips",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Check your email inbox and spam folder\n• Code expires in 10 minutes\n• Enter all 6 digits to auto-verify\n• Contact support if you don't receive the code",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Wrong email? ",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    back();
                  },
                  child: Text(
                    "Change Email",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
