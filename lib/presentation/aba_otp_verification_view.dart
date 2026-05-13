import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaOtpVerificationView extends StatefulWidget {
  const AbaOtpVerificationView({super.key});

  @override
  State<AbaOtpVerificationView> createState() => _AbaOtpVerificationViewState();
}

class _AbaOtpVerificationViewState extends State<AbaOtpVerificationView> {
  String otp1 = "";
  String otp2 = "";
  String otp3 = "";
  String otp4 = "";
  String otp5 = "";
  String otp6 = "";
  
  String email = "user@example.com";
  int countdown = 60;
  bool canResend = false;

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  void startCountdown() {
    setState(() {
      countdown = 60;
      canResend = false;
    });
    
    // Simulate countdown
    Future.delayed(Duration(seconds: 1), () {
      if (countdown > 0) {
        setState(() {
          countdown--;
        });
        if (countdown > 0) {
          startCountdown();
        } else {
          setState(() {
            canResend = true;
          });
        }
      }
    });
  }

  String get otpCode => otp1 + otp2 + otp3 + otp4 + otp5 + otp6;
  bool get isOtpComplete => otpCode.length == 6;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify Your Account"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: spLg),
            
            // Header
            Center(
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      Icons.security,
                      color: successColor,
                      size: 50,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Enter Verification Code",
                    style: TextStyle(
                      fontSize: fsH2,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
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
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spXl),
            
            // OTP Input Fields
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
            
            SizedBox(height: spLg),
            
            // Verify Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Verify Account",
                size: bs.md,
                onPressed: isOtpComplete ? () {
                  if (otpCode == "123456") {
                    ss("Account verified successfully!");
                    //navigateTo('AbaBusinessSetupView')
                  } else {
                    se("Invalid verification code. Please try again.");
                  }
                } : null,
              ),
            ),
            
            SizedBox(height: spMd),
            
            // OTP Status
            if (isOtpComplete)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: successColor.withAlpha(100)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: successColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Verification code entered",
                      style: TextStyle(
                        fontSize: 14,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            
            SizedBox(height: spLg),
            
            // Resend Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: Border.all(color: disabledOutlineBorderColor),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                children: [
                  Text(
                    "Didn't receive the code?",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  
                  if (canResend) ...[
                    GestureDetector(
                      onTap: () {
                        startCountdown();
                        ss("Verification code resent to your email");
                      },
                      child: Text(
                        "Resend Code",
                        style: TextStyle(
                          fontSize: 16,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ] else ...[
                    Text(
                      "Resend code in ${countdown}s",
                      style: TextStyle(
                        fontSize: 16,
                        color: warningColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Alternative Options
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: infoColor.withAlpha(100)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.help_outline, color: infoColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Having trouble?",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Column(
                    spacing: spXs,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("• ", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                          Expanded(
                            child: Text(
                              "Check your spam or junk folder",
                              style: TextStyle(fontSize: 12, color: disabledBoldColor),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("• ", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                          Expanded(
                            child: Text(
                              "Make sure you entered the correct email address",
                              style: TextStyle(fontSize: 12, color: disabledBoldColor),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("• ", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                          Expanded(
                            child: Text(
                              "Wait a few minutes for the code to arrive",
                              style: TextStyle(fontSize: 12, color: disabledBoldColor),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Change Email Option
            Center(
              child: GestureDetector(
                onTap: () {
                  //navigateTo('AbaRegisterView')
                },
                child: Text(
                  "Use Different Email Address",
                  style: TextStyle(
                    fontSize: 16,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            
            SizedBox(height: spMd),
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
      ),
      child: Center(
        child: TextFormField(
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
            hintText: "0",
            hintStyle: TextStyle(
              color: disabledColor,
              fontSize: 20,
            ),
          ),
          onChanged: (val) {
            if (val.isNotEmpty) {
              onChanged(val);
              FocusScope.of(context).nextFocus();
            } else {
              onChanged("");
            }
          },
        ),
      ),
    );
  }
}
