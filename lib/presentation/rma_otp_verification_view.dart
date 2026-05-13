import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaOtpVerificationView extends StatefulWidget {
  const RmaOtpVerificationView({super.key});

  @override
  State<RmaOtpVerificationView> createState() => _RmaOtpVerificationViewState();
}

class _RmaOtpVerificationViewState extends State<RmaOtpVerificationView> {
  String otpCode = "";
  String email = "owner@restaurant.com";
  String phone = "+1 (555) 123-4567";
  bool loading = false;
  int remainingTime = 60;
  bool canResend = false;
  String verificationType = "email"; // email, phone, both

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    Future.delayed(Duration(seconds: 1), () {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
        });
        _startTimer();
      } else {
        setState(() {
          canResend = true;
        });
      }
    });
  }

  Future<void> _verifyOtp() async {
    if (otpCode.length != 6) {
      se("Please enter the complete 6-digit code");
      return;
    }
    
    loading = true;
    setState(() {});
    
    showLoading();
    
    // Simulate OTP verification
    await Future.delayed(Duration(seconds: 2));
    
    hideLoading();
    
    loading = false;
    setState(() {});
    
    if (otpCode == "123456") {
      ss("Verification successful! Account activated");
      //navigateTo('RmaRestaurantSetupView')
    } else {
      se("Invalid verification code. Please try again");
      otpCode = "";
      setState(() {});
    }
  }

  Future<void> _resendCode() async {
    loading = true;
    setState(() {});
    
    showLoading();
    
    // Simulate resending code
    await Future.delayed(Duration(seconds: 1));
    
    hideLoading();
    
    loading = false;
    canResend = false;
    remainingTime = 60;
    setState(() {});
    
    _startTimer();
    
    ss("Verification code sent successfully!");
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spSm,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: successColor.withAlpha(10),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.verified_user,
              size: 50,
              color: successColor,
            ),
          ),
          Text(
            "Verify Your Account",
            style: TextStyle(
              fontSize: fsH2,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "We've sent a 6-digit verification code to your registered contact methods",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Text(
            "Verification Code Sent To:",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.email,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Email Address",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        email,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.check_circle,
                  color: successColor,
                  size: 20,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: infoColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.sms,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Phone Number",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        phone,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.check_circle,
                  color: successColor,
                  size: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtpInput() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
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
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, (index) {
                return Container(
                  width: 45,
                  height: 55,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: otpCode.length > index 
                          ? primaryColor 
                          : disabledOutlineBorderColor,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(radiusSm),
                    color: otpCode.length > index 
                        ? primaryColor.withAlpha(10) 
                        : Colors.white,
                  ),
                  child: Center(
                    child: Text(
                      otpCode.length > index ? otpCode[index] : "",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          QTextField(
            label: "6-Digit Code",
            value: otpCode,
            hint: "Enter the 6-digit verification code",
            onChanged: (value) {
              if (value.length <= 6) {
                otpCode = value;
                setState(() {});
                
                if (value.length == 6) {
                  _verifyOtp();
                }
              }
            },
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Verify Code",
              size: bs.md,
              onPressed: _verifyOtp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResendSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          if (!canResend) ...[
            Text(
              "Didn't receive the code?",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
            Text(
              "You can request a new code in ${remainingTime}s",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.access_time,
                    color: warningColor,
                    size: 16,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Please wait ${remainingTime} seconds before requesting a new code",
                      style: TextStyle(
                        fontSize: 12,
                        color: warningColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            Text(
              "Didn't receive the code?",
              style: TextStyle(
                fontSize: 14,
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Resend Email",
                    icon: Icons.email,
                    color: primaryColor,
                    size: bs.sm,
                    onPressed: _resendCode,
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Resend SMS",
                    icon: Icons.sms,
                    color: infoColor,
                    size: bs.sm,
                    onPressed: _resendCode,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildHelpSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Text(
            "Need Help?",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "Tips for successful verification:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "• Check your spam/junk folder for the email",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "• Ensure your phone has signal for SMS",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "• Try the demo code: 123456",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Contact Support",
              icon: Icons.support_agent,
              color: disabledBoldColor,
              size: bs.sm,
              onPressed: () {
                si("Contacting support team");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackButton() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Want to use a different email? ",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          GestureDetector(
            onTap: () {
              //navigateTo('RmaRegisterView')
            },
            child: Text(
              "Go Back",
              style: TextStyle(
                fontSize: 14,
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account Verification"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildHeader(),
            _buildContactInfo(),
            _buildOtpInput(),
            _buildResendSection(),
            _buildHelpSection(),
            _buildBackButton(),
          ],
        ),
      ),
    );
  }
}
