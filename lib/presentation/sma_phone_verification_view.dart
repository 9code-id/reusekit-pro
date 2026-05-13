import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaPhoneVerificationView extends StatefulWidget {
  const SmaPhoneVerificationView({super.key});

  @override
  State<SmaPhoneVerificationView> createState() => _SmaPhoneVerificationViewState();
}

class _SmaPhoneVerificationViewState extends State<SmaPhoneVerificationView> {
  String phoneNumber = "";
  String verificationCode = "";
  bool codeSent = false;
  int remainingTime = 60;

  @override
  void initState() {
    super.initState();
    if (codeSent) {
      _startTimer();
    }
  }

  void _startTimer() {
    Future.delayed(Duration(seconds: 1), () {
      if (remainingTime > 0 && mounted) {
        setState(() {
          remainingTime--;
        });
        _startTimer();
      }
    });
  }

  void _sendVerificationCode() async {
    if (phoneNumber.isNotEmpty) {
      // Simulate sending code
      await Future.delayed(Duration(seconds: 2));
      codeSent = true;
      remainingTime = 60;
      _startTimer();
      setState(() {});
      ss("Verification code sent to ${phoneNumber}");
    }
  }

  void _resendCode() async {
    if (remainingTime == 0) {
      remainingTime = 60;
      _startTimer();
      setState(() {});
      ss("Verification code resent");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phone Verification"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            SizedBox(height: spMd),

            // Header
            Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(radiusLg),
                    border: Border.all(
                      color: primaryColor.withValues(alpha: 0.3),
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    Icons.phone_android,
                    size: 40,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                Text(
                  !codeSent ? "Verify Your Phone" : "Enter Verification Code",
                  style: TextStyle(
                    fontSize: fsH3,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  !codeSent 
                      ? "We'll send you a verification code to confirm your phone number"
                      : "Enter the 6-digit code we sent to ${phoneNumber}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),

            SizedBox(height: spXl),

            if (!codeSent) ...[
              // Phone Number Input
              Column(
                spacing: spMd,
                children: [
                  QTextField(
                    label: "Phone Number",
                    value: phoneNumber,
                    hint: "Enter your phone number",
                    onChanged: (value) {
                      phoneNumber = value;
                      setState(() {});
                    },
                  ),

                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: infoColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: infoColor.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 16,
                          color: infoColor,
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "We'll send a 6-digit verification code via SMS to verify your phone number.",
                            style: TextStyle(
                              fontSize: 12,
                              color: infoColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: spMd),

                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Send Verification Code",
                      size: bs.md,
                      onPressed: phoneNumber.isNotEmpty ? _sendVerificationCode : null,
                    ),
                  ),
                ],
              ),
            ] else ...[
              // Verification Code Input
              Column(
                spacing: spMd,
                children: [
                  QTextField(
                    label: "Verification Code",
                    value: verificationCode,
                    hint: "Enter 6-digit code",
                    onChanged: (value) {
                      verificationCode = value;
                      setState(() {});
                    },
                  ),

                  // Timer and Resend
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        remainingTime > 0 
                            ? "Resend code in ${remainingTime}s"
                            : "Didn't receive the code?",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: remainingTime == 0 ? _resendCode : null,
                        child: Text(
                          "Resend Code",
                          style: TextStyle(
                            fontSize: 14,
                            color: remainingTime == 0 ? primaryColor : disabledColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: spMd),

                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Verify Phone Number",
                      size: bs.md,
                      onPressed: verificationCode.length == 6 ? () {
                        // Handle verification
                        // ss('Next page'));
                      } : null,
                    ),
                  ),

                  SizedBox(height: spMd),

                  // Change Number
                  GestureDetector(
                    onTap: () {
                      codeSent = false;
                      verificationCode = "";
                      remainingTime = 60;
                      setState(() {});
                    },
                    child: Text(
                      "Change Phone Number",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],

            SizedBox(height: spXl),

            // Security Info
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: successColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: successColor.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.security,
                        size: 20,
                        color: successColor,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Why verify your phone?",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Phone verification helps us keep your account secure and allows you to recover your account if you forget your password.",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Skip for Now
            GestureDetector(
              onTap: () {
                // Skip verification
                // ss('Next page'));
              },
              child: Text(
                "Skip for now",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
