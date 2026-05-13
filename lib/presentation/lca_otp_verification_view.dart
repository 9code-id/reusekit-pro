import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaOtpVerificationView extends StatefulWidget {
  const LcaOtpVerificationView({Key? key}) : super(key: key);

  @override
  State<LcaOtpVerificationView> createState() => _LcaOtpVerificationViewState();
}

class _LcaOtpVerificationViewState extends State<LcaOtpVerificationView> {
  String otp = "";
  String phoneNumber = "+1 (555) 123-4567";
  String email = "lawyer@lawfirm.com";
  int countdown = 120; // 2 minutes
  bool canResend = false;
  String verificationMethod = "sms";

  List<String> otpDigits = ["", "", "", "", "", ""];
  List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());
  List<TextEditingController> controllers = List.generate(6, (index) => TextEditingController());

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  void dispose() {
    for (var node in focusNodes) {
      node.dispose();
    }
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _startCountdown() {
    Future.delayed(Duration(seconds: 1), () {
      if (mounted && countdown > 0) {
        setState(() {
          countdown--;
        });
        _startCountdown();
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
        title: Text("OTP Verification"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            SizedBox(height: spLg),
            _buildVerificationInfo(),
            SizedBox(height: spLg),
            _buildOtpInput(),
            SizedBox(height: spLg),
            _buildResendSection(),
            SizedBox(height: spLg),
            _buildAlternativeMethod(),
            SizedBox(height: spLg),
            _buildSecurityInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: primaryColor.withAlpha(50)),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spLg),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Icon(
              Icons.security,
              color: primaryColor,
              size: 48,
            ),
          ),
          SizedBox(height: spMd),
          Text(
            "Verify Your Identity",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: spSm),
          Text(
            "Legal Case Assistant Security Verification",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildVerificationInfo() {
    return Container(
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
            "Verification Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          _buildInfoRow(
            Icons.phone_android,
            "SMS Verification",
            "Code sent to $phoneNumber",
            verificationMethod == "sms",
          ),
          SizedBox(height: spSm),
          _buildInfoRow(
            Icons.email,
            "Email Verification",
            "Code sent to $email",
            verificationMethod == "email",
          ),
          SizedBox(height: spMd),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: warningColor.withAlpha(50)),
            ),
            child: Row(
              children: [
                Icon(Icons.timer, color: warningColor, size: 16),
                SizedBox(width: spSm),
                Text(
                  "Code expires in ${_formatTime(countdown)}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: warningColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String subtitle, bool isActive) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: isActive ? successColor.withAlpha(10) : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(
          color: isActive ? successColor.withAlpha(50) : disabledOutlineBorderColor,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: isActive ? successColor.withAlpha(20) : disabledColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
              color: isActive ? successColor : disabledBoldColor,
              size: 16,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isActive ? successColor : disabledBoldColor,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          if (isActive)
            Icon(Icons.check_circle, color: successColor, size: 16),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Enter Verification Code",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(6, (index) => _buildOtpDigit(index)),
          ),
          SizedBox(height: spMd),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Verify Code",
              size: bs.md,
              onPressed: () => _verifyOtp(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtpDigit(int index) {
    return Container(
      width: 45,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(
          color: otpDigits[index].isNotEmpty ? primaryColor : disabledOutlineBorderColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
        color: otpDigits[index].isNotEmpty ? primaryColor.withAlpha(10) : Colors.white,
      ),
      child: TextField(
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
          counterText: "",
          border: InputBorder.none,
        ),
        onChanged: (value) {
          otpDigits[index] = value;
          setState(() {});
          
          if (value.isNotEmpty && index < 5) {
            focusNodes[index + 1].requestFocus();
          } else if (value.isEmpty && index > 0) {
            focusNodes[index - 1].requestFocus();
          }
          
          // Auto verify when all digits are filled
          if (otpDigits.every((digit) => digit.isNotEmpty)) {
            _verifyOtp();
          }
        },
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Didn't receive the code?",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: canResend ? "Resend SMS" : "Resend in ${_formatTime(countdown)}",
                  size: bs.sm,
                  onPressed: canResend ? () => _resendCode("sms") : null,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: canResend ? "Resend Email" : "Resend in ${_formatTime(countdown)}",
                  size: bs.sm,
                  onPressed: canResend ? () => _resendCode("email") : null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAlternativeMethod() {
    return Container(
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
            "Alternative Verification",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          _buildAlternativeOption(
            Icons.call,
            "Voice Call",
            "Receive code via automated call",
            () => _requestVoiceCall(),
          ),
          SizedBox(height: spSm),
          _buildAlternativeOption(
            Icons.support_agent,
            "Contact Support",
            "Get help from our security team",
            () => _contactSupport(),
          ),
          SizedBox(height: spSm),
          _buildAlternativeOption(
            Icons.security,
            "Recovery Code",
            "Use your backup recovery codes",
            () => _useRecoveryCode(),
          ),
        ],
      ),
    );
  }

  Widget _buildAlternativeOption(IconData icon, String title, String description, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(radiusMd),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Icon(icon, color: infoColor, size: 20),
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
            Icon(Icons.arrow_forward_ios, size: 16, color: disabledBoldColor),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityInfo() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: dangerColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: dangerColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.warning, color: dangerColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Security Notice",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: dangerColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "• Never share your verification code with anyone\n• LCA staff will never ask for your code\n• Report suspicious activity to security team\n• This verification is required for legal data access\n• Session will expire after multiple failed attempts",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}";
  }

  void _verifyOtp() {
    String fullOtp = otpDigits.join("");
    
    if (fullOtp.length != 6) {
      se("Please enter complete 6-digit code");
      return;
    }

    showLoading();
    // Simulate API call
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      
      if (fullOtp == "123456") {
        ss("Verification successful");
        // Navigate to next screen
        //navigateTo('');
      } else {
        se("Invalid verification code");
        // Clear OTP inputs
        for (int i = 0; i < 6; i++) {
          otpDigits[i] = "";
          controllers[i].clear();
        }
        setState(() {});
        focusNodes[0].requestFocus();
      }
    });
  }

  void _resendCode(String method) {
    showLoading();
    // Simulate API call
    Future.delayed(Duration(seconds: 1), () {
      hideLoading();
      setState(() {
        verificationMethod = method;
        countdown = 120;
        canResend = false;
      });
      _startCountdown();
      
      if (method == "sms") {
        ss("New SMS code sent to $phoneNumber");
      } else {
        ss("New email code sent to $email");
      }
    });
  }

  void _requestVoiceCall() {
    showLoading();
    // Simulate API call
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("Voice call initiated to $phoneNumber");
    });
  }

  void _contactSupport() {
    si("Connecting to security support team");
    // Navigate to support screen
    //navigateTo('');
  }

  void _useRecoveryCode() {
    si("Opening recovery code verification");
    // Navigate to recovery code screen
    //navigateTo('');
  }
}
