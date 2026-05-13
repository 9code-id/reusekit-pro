import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaOtpVerificationView extends StatefulWidget {
  const CmaOtpVerificationView({super.key});

  @override
  State<CmaOtpVerificationView> createState() => _CmaOtpVerificationViewState();
}

class _CmaOtpVerificationViewState extends State<CmaOtpVerificationView> {
  List<String> otpCode = ["", "", "", "", "", ""];
  List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());
  List<TextEditingController> controllers = List.generate(6, (index) => TextEditingController());
  
  String email = "john.doe@example.com";
  int resendCountdown = 30;
  bool isVerifying = false;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _startCountdown() {
    Future.doWhile(() async {
      await Future.delayed(Duration(seconds: 1));
      if (mounted && resendCountdown > 0) {
        setState(() {
          resendCountdown--;
        });
        return resendCountdown > 0;
      }
      return false;
    });
  }

  void _onOtpChanged(String value, int index) {
    setState(() {
      otpCode[index] = value;
    });

    if (value.isNotEmpty && index < 5) {
      // Move to next field
      focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      // Move to previous field
      focusNodes[index - 1].requestFocus();
    }

    // Auto-verify when all fields are filled
    if (otpCode.every((digit) => digit.isNotEmpty)) {
      _verifyOtp();
    }
  }

  void _verifyOtp() async {
    String fullOtp = otpCode.join();
    
    if (fullOtp.length != 6) {
      se("Please enter the complete 6-digit verification code");
      return;
    }

    setState(() {
      isVerifying = true;
    });

    showLoading();
    
    // Simulate OTP verification
    await Future.delayed(Duration(seconds: 2));
    
    hideLoading();
    
    setState(() {
      isVerifying = false;
    });

    // Check if OTP is correct (demo purposes)
    if (fullOtp == "123456") {
      ss("Email verified successfully!");
      // ss('Next page'));
    } else {
      se("Invalid verification code. Please try again.");
      _clearOtp();
    }
  }

  void _clearOtp() {
    setState(() {
      otpCode = ["", "", "", "", "", ""];
      for (var controller in controllers) {
        controller.clear();
      }
    });
    focusNodes[0].requestFocus();
  }

  void _resendOtp() async {
    if (resendCountdown > 0) return;

    showLoading();
    
    // Simulate resending OTP
    await Future.delayed(Duration(seconds: 1));
    
    hideLoading();
    
    setState(() {
      resendCountdown = 30;
    });
    
    _startCountdown();
    _clearOtp();
    ss("Verification code resent to $email");
  }

  void _changeEmail() {
    back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify Email"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            SizedBox(height: spLg),

            // Icon and Title
            Center(
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.mark_email_read,
                      size: 50,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Verify Your Email",
                    style: TextStyle(
                      fontSize: fsH3,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "We've sent a 6-digit verification code to:",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    email,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // OTP Input Fields
            Text(
              "Enter Verification Code",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, (index) {
                return Container(
                  width: 45,
                  height: 55,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: otpCode[index].isNotEmpty 
                        ? primaryColor 
                        : focusNodes[index].hasFocus 
                          ? primaryColor
                          : disabledColor,
                      width: otpCode[index].isNotEmpty || focusNodes[index].hasFocus ? 2 : 1,
                    ),
                    borderRadius: BorderRadius.circular(radiusSm),
                    color: otpCode[index].isNotEmpty 
                      ? primaryColor.withAlpha(10) 
                      : Colors.white,
                  ),
                  child: TextFormField(
                    controller: controllers[index],
                    focusNode: focusNodes[index],
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
                    onChanged: (value) {
                      if (value.length <= 1) {
                        _onOtpChanged(value, index);
                      }
                    },
                  ),
                );
              }),
            ),

            // Helper Text
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusXs),
                border: Border.all(color: infoColor.withAlpha(30)),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: infoColor, size: 20),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Enter the 6-digit code we sent to your email. The code will automatically verify when complete.",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Manual Verify Button
            Container(
              width: double.infinity,
              child: QButton(
                label: isVerifying ? "Verifying..." : "Verify Code",
                size: bs.md,
                onPressed: isVerifying ? null : _verifyOtp,
              ),
            ),

            SizedBox(height: spMd),

            // Resend Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusSm),
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
                  if (resendCountdown > 0) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.timer, color: warningColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Resend in ${resendCountdown}s",
                          style: TextStyle(
                            fontSize: 14,
                            color: warningColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ] else ...[
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: primaryColor),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: InkWell(
                        onTap: _resendOtp,
                        borderRadius: BorderRadius.circular(radiusSm),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.refresh, color: primaryColor, size: 20),
                            SizedBox(width: spSm),
                            Text(
                              "Resend Code",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Change Email Option
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                border: Border.all(color: disabledColor),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: InkWell(
                onTap: _changeEmail,
                borderRadius: BorderRadius.circular(radiusSm),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.edit, color: disabledBoldColor, size: 20),
                      SizedBox(width: spSm),
                      Text(
                        "Change Email Address",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: spLg),

            // Security Info
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: successColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: successColor.withAlpha(30)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.security, color: successColor, size: 24),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Secure Verification",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "This verification step helps secure your account and ensures that only you can access your CMA Business dashboard.",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Demo Info (Remove in production)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusXs),
                border: Border.all(color: warningColor.withAlpha(30)),
              ),
              child: Row(
                children: [
                  Icon(Icons.code, color: warningColor, size: 16),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Demo: Use code '123456' to verify",
                      style: TextStyle(
                        fontSize: 10,
                        color: warningColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),
          ],
        ),
      ),
    );
  }
}
