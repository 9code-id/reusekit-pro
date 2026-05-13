import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaOtpVerificationView extends StatefulWidget {
  const FwaOtpVerificationView({super.key});

  @override
  State<FwaOtpVerificationView> createState() => _FwaOtpVerificationViewState();
}

class _FwaOtpVerificationViewState extends State<FwaOtpVerificationView> {
  List<String> otpDigits = ["", "", "", "", "", ""];
  List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());
  bool loading = false;
  int resendCooldown = 0;
  String email = "user@example.com";

  @override
  void initState() {
    super.initState();
    _startResendCooldown();
  }

  void _startResendCooldown() {
    resendCooldown = 60;
    setState(() {});
    
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (resendCooldown > 0) {
        resendCooldown--;
        setState(() {});
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> _handleVerifyOTP() async {
    String otp = otpDigits.join();
    
    if (otp.length != 6) {
      se("Please enter complete OTP code");
      return;
    }

    loading = true;
    setState(() {});

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    loading = false;
    setState(() {});

    ss("Email verified successfully!");
    // navigateTo(FwaProfileSetupView());
  }

  Future<void> _handleResendOTP() async {
    if (resendCooldown > 0) {
      return;
    }

    loading = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 1));

    loading = false;
    setState(() {});

    ss("OTP code resent successfully!");
    _startResendCooldown();
    
    // Clear current OTP
    otpDigits = ["", "", "", "", "", ""];
    setState(() {});
  }

  void _onOTPChanged(String value, int index) {
    otpDigits[index] = value;
    setState(() {});

    if (value.isNotEmpty && index < 5) {
      focusNodes[index + 1].requestFocus();
    }

    // Auto verify when all digits are entered
    if (otpDigits.every((digit) => digit.isNotEmpty)) {
      _handleVerifyOTP();
    }
  }

  void _onBackspace(int index) {
    if (otpDigits[index].isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }
  }

  @override
  void dispose() {
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back Button
              GestureDetector(
                onTap: () {
                  back();
                },
                child: Icon(
                  Icons.arrow_back,
                  color: primaryColor,
                  size: 24,
                ),
              ),

              SizedBox(height: spXl),

              // Header Section
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Illustration
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusXl),
                      ),
                      child: Icon(
                        Icons.verified_user,
                        color: primaryColor,
                        size: 60,
                      ),
                    ),

                    SizedBox(height: spMd),

                    Text(
                      "Verify Your Email",
                      style: TextStyle(
                        fontSize: fsH2,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),

                    SizedBox(height: spSm),

                    Text(
                      "We've sent a 6-digit verification code to",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: disabledBoldColor,
                      ),
                    ),

                    SizedBox(height: spXs),

                    Text(
                      email,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: spXl),

              // OTP Input Section
              Column(
                children: [
                  Text(
                    "Enter verification code",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  SizedBox(height: spMd),

                  // OTP Input Fields
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(6, (index) {
                      return Container(
                        width: 50,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: otpDigits[index].isNotEmpty 
                                ? primaryColor 
                                : disabledOutlineBorderColor,
                            width: 2,
                          ),
                          boxShadow: [shadowSm],
                        ),
                        child: TextField(
                          focusNode: focusNodes[index],
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                          decoration: InputDecoration(
                            counterText: "",
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            _onOTPChanged(value, index);
                          },
                          onTap: () {
                            // Clear the field when tapped
                            otpDigits[index] = "";
                            setState(() {});
                          },
                        ),
                      );
                    }),
                  ),

                  SizedBox(height: spLg),

                  // Verify Button
                  Container(
                    width: double.infinity,
                    child: loading
                        ? Container(
                            height: 50,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : QButton(
                            label: "Verify Code",
                            size: bs.md,
                            onPressed: _handleVerifyOTP,
                          ),
                  ),

                  SizedBox(height: spLg),

                  // Resend Section
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Didn't receive the code?",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),

                        SizedBox(height: spSm),

                        if (resendCooldown > 0) ...[
                          Text(
                            "Resend code in ${resendCooldown}s",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ] else ...[
                          GestureDetector(
                            onTap: _handleResendOTP,
                            child: Text(
                              "Resend Code",
                              style: TextStyle(
                                fontSize: 16,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  SizedBox(height: spLg),

                  // Help Section
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: infoColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "Tips for verification:",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "• Check your spam or junk folder\n• Make sure you have internet connection\n• Code expires in 10 minutes\n• Contact support if you continue having issues",
                          style: TextStyle(
                            fontSize: 13,
                            color: disabledBoldColor,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: spLg),

                  // Change Email Option
                  GestureDetector(
                    onTap: () {
                      back();
                    },
                    child: Text(
                      "Wrong email address? Change it",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
