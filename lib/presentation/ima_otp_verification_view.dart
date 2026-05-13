import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaOtpVerificationView extends StatefulWidget {
  const ImaOtpVerificationView({super.key});

  @override
  State<ImaOtpVerificationView> createState() => _ImaOtpVerificationViewState();
}

class _ImaOtpVerificationViewState extends State<ImaOtpVerificationView> {
  String otp = "";
  String email = "john.doe@company.com";
  String phoneNumber = "+1 (555) 123-4567";
  String verificationType = "email"; // email or phone
  int countdown = 60;
  bool canResend = false;
  bool isVerifying = false;
  
  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    countdown = 60;
    canResend = false;
    setState(() {});
    
    Future.doWhile(() async {
      await Future.delayed(Duration(seconds: 1));
      if (mounted) {
        countdown--;
        if (countdown <= 0) {
          canResend = true;
        }
        setState(() {});
        return countdown > 0;
      }
      return false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify Your Account"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // navigateTo('LoginView')
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: spMd,
          children: [
            SizedBox(height: spXl),
            
            // Header Icon
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radius3xl),
              ),
              child: Icon(
                verificationType == "email" ? Icons.email : Icons.phone,
                size: 60,
                color: primaryColor,
              ),
            ),

            SizedBox(height: spLg),

            // Title and Description
            Text(
              "Verification Code",
              style: TextStyle(
                fontSize: fsH2,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
              textAlign: TextAlign.center,
            ),

            Text(
              verificationType == "email"
                  ? "We've sent a 6-digit code to your email address"
                  : "We've sent a 6-digit code to your phone number",
              style: TextStyle(
                fontSize: 16,
                color: disabledBoldColor,
              ),
              textAlign: TextAlign.center,
            ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Text(
                verificationType == "email" ? email : phoneNumber,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ),

            SizedBox(height: spLg),

            // OTP Input
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                children: [
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
                        width: 50,
                        height: 60,
                        decoration: BoxDecoration(
                          color: otp.length > index 
                              ? primaryColor.withAlpha(10) 
                              : Colors.grey.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: otp.length > index 
                                ? primaryColor 
                                : disabledOutlineBorderColor,
                            width: otp.length > index ? 2 : 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            otp.length > index ? otp[index] : "",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),

                  // Hidden TextField for input
                  Container(
                    height: 0,
                    child: TextField(
                      autofocus: true,
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      onChanged: (value) {
                        otp = value;
                        setState(() {});
                        
                        if (value.length == 6) {
                          _verifyOtp();
                        }
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        counterText: "",
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Verification Status
            if (otp.length == 6 && !isVerifying)
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(15),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: successColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Code entered successfully",
                      style: TextStyle(
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

            if (isVerifying)
              Container(
                padding: EdgeInsets.all(spSm),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Verifying code...",
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

            SizedBox(height: spLg),

            // Resend Code Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Text(
                    "Didn't receive the code?",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                    ),
                  ),
                  
                  if (!canResend)
                    Text(
                      "Resend code in ${countdown}s",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),

                  if (canResend)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _resendCode();
                          },
                          child: Text(
                            "Resend Code",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(width: spMd),
                        Text("•", style: TextStyle(color: disabledBoldColor)),
                        SizedBox(width: spMd),
                        GestureDetector(
                          onTap: () {
                            _switchVerificationMethod();
                          },
                          child: Text(
                            verificationType == "email" 
                                ? "Use SMS instead" 
                                : "Use email instead",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Manual Verify Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Verify Code",
                size: bs.md,
                onPressed: otp.length == 6 ? () => _verifyOtp() : null,
              ),
            ),

            SizedBox(height: spMd),

            // Help Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(30)),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.help_outline,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Need Help?",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "• Check your spam/junk folder for the email\n• Make sure you have signal for SMS\n• The code expires in 10 minutes\n• Contact support if you continue having issues",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: spSm),
                  GestureDetector(
                    onTap: () {
                      // navigateTo('ContactSupportView')
                    },
                    child: Text(
                      "Contact Support",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Change Contact Info
            Container(
              width: double.infinity,
              child: QButton(
                label: "Change ${verificationType == "email" ? "Email" : "Phone Number"}",
                size: bs.sm,
                onPressed: () {
                  // navigateTo('ChangeContactView')
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _verifyOtp() async {
    if (otp.length != 6) return;
    
    isVerifying = true;
    setState(() {});
    
    // Simulate verification API call
    await Future.delayed(Duration(seconds: 2));
    
    isVerifying = false;
    setState(() {});
    
    // Check if OTP is correct (in real app, this would be from API response)
    if (otp == "123456") {
      ss("Account verified successfully!");
      // navigateTo('ProfileSetupView')
    } else {
      se("Invalid verification code. Please try again.");
      otp = "";
      setState(() {});
    }
  }

  void _resendCode() {
    ss("Verification code sent to ${verificationType == "email" ? email : phoneNumber}");
    _startCountdown();
  }

  void _switchVerificationMethod() {
    verificationType = verificationType == "email" ? "phone" : "email";
    otp = "";
    ss("Verification code sent to ${verificationType == "email" ? email : phoneNumber}");
    _startCountdown();
    setState(() {});
  }
}
