import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlVerification2View extends StatefulWidget {
  @override
  State<GrlVerification2View> createState() => _GrlVerification2ViewState();
}

class _GrlVerification2ViewState extends State<GrlVerification2View> {
  String code1 = '';
  String code2 = '';
  String code3 = '';
  String code4 = '';
  String code5 = '';
  String code6 = '';
  
  bool isLoading = false;
  bool canResend = false;
  int resendCountdown = 60;
  String phoneNumber = "+1 (555) 123-4567";
  
  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  void _startResendTimer() {
    Future.delayed(Duration(seconds: 1), () {
      if (mounted && resendCountdown > 0) {
        setState(() {
          resendCountdown--;
        });
        _startResendTimer();
      } else if (mounted) {
        setState(() {
          canResend = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verification Code"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Header Illustration
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [successColor, successColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(51),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      Icons.sms,
                      color: Colors.white,
                      size: 48,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Enter Verification Code",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "We've sent a 6-digit code to",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  Text(
                    phoneNumber,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Code Input Fields
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Enter Code",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildCodeField(code1, (value) {
                        code1 = value;
                        setState(() {});
                      }),
                      _buildCodeField(code2, (value) {
                        code2 = value;
                        setState(() {});
                      }),
                      _buildCodeField(code3, (value) {
                        code3 = value;
                        setState(() {});
                      }),
                      _buildCodeField(code4, (value) {
                        code4 = value;
                        setState(() {});
                      }),
                      _buildCodeField(code5, (value) {
                        code5 = value;
                        setState(() {});
                      }),
                      _buildCodeField(code6, (value) {
                        code6 = value;
                        setState(() {});
                      }),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Auto-detect message
                  if (_isCodeComplete()) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: successColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Code entered completely",
                          style: TextStyle(
                            fontSize: 14,
                            color: successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ] else ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.info,
                          color: infoColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Enter the 6-digit code sent to your phone",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Resend Code Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
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
                  SizedBox(height: spMd),
                  
                  if (canResend) ...[
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Resend Code",
                            size: bs.sm,
                            onPressed: _resendCode,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: primaryColor),
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: QButton(
                              label: "Call Me",
                              size: bs.sm,
                              onPressed: _requestCall,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ] else ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.timer,
                          color: warningColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Resend available in ${resendCountdown}s",
                          style: TextStyle(
                            fontSize: 14,
                            color: warningColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Verify Button
            Container(
              width: double.infinity,
              child: QButton(
                label: isLoading ? "Verifying..." : "Verify Code",
                size: bs.md,
                onPressed: _isCodeComplete() && !isLoading ? _verifyCode : null,
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Help Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: infoColor.withAlpha(102)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                        "Having Trouble?",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Check your SMS messages\n• Make sure you have cellular signal\n• Code expires in 10 minutes\n• Contact support if issues persist",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: spMd),
                  GestureDetector(
                    onTap: () {
                      si("Opening support...");
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.support_agent,
                          color: infoColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Contact Support",
                          style: TextStyle(
                            fontSize: 14,
                            color: infoColor,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Change Phone Number
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Text(
                    "Wrong phone number?",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: disabledBoldColor),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: QButton(
                      label: "Change Phone Number",
                      size: bs.sm,
                      onPressed: () {
                        back();
                      },
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

  Widget _buildCodeField(String value, Function(String) onChanged) {
    return Container(
      width: 45,
      height: 55,
      decoration: BoxDecoration(
        border: Border.all(
          color: value.isNotEmpty ? primaryColor : disabledColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
        color: value.isNotEmpty ? primaryColor.withAlpha(20) : Colors.white,
      ),
      child: TextField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: TextStyle(
          fontSize: fsH5,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
        decoration: InputDecoration(
          counterText: '',
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
        onChanged: (val) {
          onChanged(val);
          if (val.isNotEmpty) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }

  bool _isCodeComplete() {
    return code1.isNotEmpty && 
           code2.isNotEmpty && 
           code3.isNotEmpty && 
           code4.isNotEmpty && 
           code5.isNotEmpty && 
           code6.isNotEmpty;
  }

  void _verifyCode() async {
    setState(() {
      isLoading = true;
    });
    
    String fullCode = code1 + code2 + code3 + code4 + code5 + code6;
    
    // Simulate API call
    await Future.delayed(Duration(seconds: 2));
    
    setState(() {
      isLoading = false;
    });
    
    // Check if code is correct (for demo purposes, accept 123456)
    if (fullCode == "123456") {
      ss("Phone number verified successfully!");
      // navigateTo(VerificationSuccessView());
    } else {
      se("Invalid verification code. Please try again.");
      // Clear all fields
      code1 = code2 = code3 = code4 = code5 = code6 = '';
      setState(() {});
    }
  }

  void _resendCode() async {
    setState(() {
      canResend = false;
      resendCountdown = 60;
    });
    
    _startResendTimer();
    
    // Simulate API call
    await Future.delayed(Duration(seconds: 1));
    
    ss("Verification code resent to $phoneNumber");
  }

  void _requestCall() async {
    showLoading();
    
    // Simulate API call
    await Future.delayed(Duration(seconds: 2));
    
    hideLoading();
    ss("You will receive a call with the verification code within 2 minutes");
  }
}
