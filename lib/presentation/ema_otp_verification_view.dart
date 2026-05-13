import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaOtpVerificationView extends StatefulWidget {
  const EmaOtpVerificationView({super.key});

  @override
  State<EmaOtpVerificationView> createState() => _EmaOtpVerificationViewState();
}

class _EmaOtpVerificationViewState extends State<EmaOtpVerificationView> {
  List<TextEditingController> otpControllers = List.generate(6, (index) => TextEditingController());
  List<FocusNode> otpFocusNodes = List.generate(6, (index) => FocusNode());
  String email = "john.doe@example.com";
  bool isLoading = false;
  bool canResend = false;
  int resendTimer = 60;
  
  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }
  
  @override
  void dispose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var focusNode in otpFocusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }
  
  void _startResendTimer() {
    canResend = false;
    resendTimer = 60;
    setState(() {});
    
    Future.doWhile(() async {
      await Future.delayed(Duration(seconds: 1));
      if (mounted) {
        resendTimer--;
        setState(() {});
        if (resendTimer <= 0) {
          canResend = true;
          setState(() {});
          return false;
        }
        return true;
      }
      return false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify Email"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: spLg),
              
              // Header Section
              Column(
                children: [
                  // Icon
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [infoColor, infoColor.withAlpha(180)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(radius2xl),
                      boxShadow: [shadowMd],
                    ),
                    child: Icon(
                      Icons.mark_email_read,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  
                  SizedBox(height: spLg),
                  
                  // Title
                  Text(
                    "Verify Your Email",
                    style: TextStyle(
                      fontSize: fsH2,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Description
                  Text(
                    "We've sent a 6-digit verification code to:",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  SizedBox(height: spSm),
                  
                  // Email Display
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Text(
                      email,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: sp2xl),
              
              // OTP Input Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  children: [
                    Text(
                      "Enter Verification Code",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    SizedBox(height: spLg),
                    
                    // OTP Input Fields
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(6, (index) => _buildOtpField(index)),
                    ),
                    
                    SizedBox(height: spLg),
                    
                    // Verify Button
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Verify Code",
                        size: bs.md,
                        onPressed: isLoading ? null : _handleVerifyOtp,
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
                  color: warningColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: warningColor.withAlpha(100)),
                ),
                child: Column(
                  children: [
                    Text(
                      "Didn't receive the code?",
                      style: TextStyle(
                        fontSize: 14,
                        color: warningColor,
                      ),
                    ),
                    
                    SizedBox(height: spSm),
                    
                    if (canResend) ...[
                      GestureDetector(
                        onTap: _handleResendOtp,
                        child: Text(
                          "Resend Code",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ] else ...[
                      Text(
                        "Resend code in ${resendTimer}s",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              
              SizedBox(height: spLg),
              
              // Alternative Actions
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Having Trouble?",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    
                    _buildHelpOption(
                      Icons.refresh,
                      "Use Different Email",
                      "Change the email address for verification",
                      () => _handleChangeEmail(),
                    ),
                    
                    _buildHelpOption(
                      Icons.sms,
                      "Send via SMS",
                      "Receive verification code via text message",
                      () => _handleSmsVerification(),
                    ),
                    
                    _buildHelpOption(
                      Icons.support_agent,
                      "Contact Support",
                      "Get help from our support team",
                      () => ss("Opening contact support"),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spLg),
              
              // Security Info
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: infoColor.withAlpha(100)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.security,
                      color: infoColor,
                      size: 20,
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Security Notice",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: infoColor,
                            ),
                          ),
                          Text(
                            "Verification codes expire after 10 minutes for security reasons.",
                            style: TextStyle(
                              fontSize: 12,
                              color: infoColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spLg),
              
              // Tips Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: successColor.withAlpha(100)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.lightbulb,
                          color: successColor,
                          size: 20,
                        ),
                        SizedBox(width: spMd),
                        Text(
                          "Tips",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    _buildTip("Check your spam/junk folder"),
                    _buildTip("Ensure stable internet connection"),
                    _buildTip("Code is case-sensitive"),
                    _buildTip("Don't share your verification code"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildOtpField(int index) {
    return Container(
      width: 45,
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(
          color: otpControllers[index].text.isNotEmpty ? primaryColor : disabledOutlineBorderColor,
          width: 2,
        ),
        boxShadow: [shadowSm],
      ),
      child: TextField(
        controller: otpControllers[index],
        focusNode: otpFocusNodes[index],
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: "",
          border: InputBorder.none,
        ),
        onChanged: (value) {
          if (value.isNotEmpty) {
            if (index < 5) {
              otpFocusNodes[index + 1].requestFocus();
            } else {
              otpFocusNodes[index].unfocus();
            }
          } else {
            if (index > 0) {
              otpFocusNodes[index - 1].requestFocus();
            }
          }
          setState(() {});
        },
      ),
    );
  }
  
  Widget _buildHelpOption(IconData icon, String title, String description, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: spSm),
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: primaryColor.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: primaryColor,
              size: 20,
            ),
            SizedBox(width: spMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: primaryColor,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildTip(String tip) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            color: successColor,
            size: 16,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              tip,
              style: TextStyle(
                fontSize: 12,
                color: successColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  String _getOtpCode() {
    return otpControllers.map((controller) => controller.text).join();
  }
  
  void _handleVerifyOtp() async {
    String code = _getOtpCode();
    if (code.length != 6) {
      se("Please enter the complete 6-digit code");
      return;
    }
    
    isLoading = true;
    setState(() {});
    
    // Simulate verification process
    await Future.delayed(Duration(seconds: 2));
    
    isLoading = false;
    setState(() {});
    
    // Mock verification - in real app, validate against server
    if (code == "123456") {
      ss("Email verified successfully!");
    } else {
      se("Invalid verification code. Please try again.");
      // Clear OTP fields
      for (var controller in otpControllers) {
        controller.clear();
      }
      otpFocusNodes[0].requestFocus();
    }
  }
  
  void _handleResendOtp() {
    ss("Verification code resent successfully");
    _startResendTimer();
  }
  
  void _handleChangeEmail() {
    ss("Navigate to change email screen");
  }
  
  void _handleSmsVerification() {
    ss("Navigate to SMS verification option");
  }
}
