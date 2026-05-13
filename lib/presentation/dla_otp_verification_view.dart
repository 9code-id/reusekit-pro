import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaOtpVerificationView extends StatefulWidget {
  const DlaOtpVerificationView({super.key});

  @override
  State<DlaOtpVerificationView> createState() => _DlaOtpVerificationViewState();
}

class _DlaOtpVerificationViewState extends State<DlaOtpVerificationView> {
  List<TextEditingController> otpControllers = List.generate(6, (index) => TextEditingController());
  List<FocusNode> otpFocusNodes = List.generate(6, (index) => FocusNode());
  
  String phoneNumber = "+1 (555) 123-4567";
  int resendTimer = 60;
  bool canResend = false;
  
  @override
  void initState() {
    super.initState();
    startTimer();
  }
  
  void startTimer() {
    resendTimer = 60;
    canResend = false;
    
    Future.doWhile(() async {
      await Future.delayed(Duration(seconds: 1));
      if (mounted) {
        setState(() {
          resendTimer--;
        });
        
        if (resendTimer <= 0) {
          canResend = true;
          return false;
        }
        return true;
      }
      return false;
    });
  }
  
  void verifyOTP() {
    String otp = otpControllers.map((controller) => controller.text).join();
    if (otp.length == 6) {
      // Handle OTP verification
      ss("Phone number verified successfully!");
      // Navigate to next screen
    } else {
      se("Please enter the complete verification code");
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify Phone"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            SizedBox(height: sp2xl),
            
            // Header Section
            Column(
              spacing: spMd,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXl),
                  ),
                  child: Icon(
                    Icons.sms,
                    size: 50,
                    color: primaryColor,
                  ),
                ),
                
                Text(
                  "Verification Code",
                  style: TextStyle(
                    fontSize: fsH2,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                Text(
                  "We've sent a 6-digit verification code to",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: disabledBoldColor,
                  ),
                ),
                
                Text(
                  phoneNumber,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: sp3xl),
            
            // OTP Input Fields
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, (index) {
                return Container(
                  width: 50,
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: otpControllers[index].text.isNotEmpty 
                        ? primaryColor 
                        : disabledOutlineBorderColor,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: TextField(
                    controller: otpControllers[index],
                    focusNode: otpFocusNodes[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      counterText: "",
                    ),
                    onChanged: (value) {
                      setState(() {});
                      
                      if (value.isNotEmpty && index < 5) {
                        otpFocusNodes[index + 1].requestFocus();
                      } else if (value.isEmpty && index > 0) {
                        otpFocusNodes[index - 1].requestFocus();
                      }
                      
                      // Auto verify when all fields are filled
                      if (index == 5 && value.isNotEmpty) {
                        String otp = otpControllers.map((controller) => controller.text).join();
                        if (otp.length == 6) {
                          verifyOTP();
                        }
                      }
                    },
                  ),
                );
              }),
            ),
            
            SizedBox(height: sp2xl),
            
            // Verify Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Verify Code",
                size: bs.md,
                onPressed: verifyOTP,
              ),
            ),
            
            SizedBox(height: spXl),
            
            // Resend Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Text(
                    "Didn't receive the code?",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  
                  if (!canResend) ...[
                    Text(
                      "Resend code in ${resendTimer}s",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ] else ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Resend OTP
                            ss("Verification code sent again");
                            startTimer();
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
                        
                        Text(
                          " or ",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        
                        GestureDetector(
                          onTap: () {
                            // Call instead
                            ss("Calling your phone number...");
                          },
                          child: Text(
                            "Call Me",
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
                ],
              ),
            ),
            
            SizedBox(height: spXl),
            
            // Change Phone Number
            GestureDetector(
              onTap: () {
                back();
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
            
            SizedBox(height: sp3xl),
            
            // Security Notice
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: warningColor.withAlpha(30)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.security,
                    color: warningColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "For your security, never share this verification code with anyone.",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
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
  
  @override
  void dispose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var node in otpFocusNodes) {
      node.dispose();
    }
    super.dispose();
  }
}
