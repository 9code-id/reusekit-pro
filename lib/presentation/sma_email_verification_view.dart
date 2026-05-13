import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaEmailVerificationView extends StatefulWidget {
  const SmaEmailVerificationView({super.key});

  @override
  State<SmaEmailVerificationView> createState() => _SmaEmailVerificationViewState();
}

class _SmaEmailVerificationViewState extends State<SmaEmailVerificationView> {
  String userEmail = "john.doe@example.com"; // This would come from registration
  bool emailSent = true;
  int remainingTime = 300; // 5 minutes
  bool isVerified = false;

  @override
  void initState() {
    super.initState();
    if (emailSent) {
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

  void _resendEmail() async {
    remainingTime = 300;
    _startTimer();
    setState(() {});
    ss("Verification email sent to ${userEmail}");
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Email Verification"),
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
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: isVerified 
                        ? successColor.withValues(alpha: 0.1)
                        : warningColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(radiusLg),
                    border: Border.all(
                      color: isVerified 
                          ? successColor.withValues(alpha: 0.3)
                          : warningColor.withValues(alpha: 0.3),
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    isVerified ? Icons.check_circle : Icons.email,
                    size: 50,
                    color: isVerified ? successColor : warningColor,
                  ),
                ),
                SizedBox(height: spMd),
                Text(
                  isVerified ? "Email Verified!" : "Check Your Email",
                  style: TextStyle(
                    fontSize: fsH3,
                    fontWeight: FontWeight.bold,
                    color: isVerified ? successColor : primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  isVerified 
                      ? "Your email has been successfully verified"
                      : "We've sent a verification link to",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                if (!isVerified) ...[
                  SizedBox(height: spXs),
                  Text(
                    userEmail,
                    style: TextStyle(
                      fontSize: 16,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),

            SizedBox(height: spXl),

            if (!isVerified) ...[
              // Instructions
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: infoColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(
                    color: infoColor.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 20,
                          color: infoColor,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "How to verify your email:",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "1. Check your email inbox (and spam folder)\n2. Click the verification link in the email\n3. Come back to this app\n4. Tap 'I've Verified My Email' below",
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

              // Timer
              if (remainingTime > 0)
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: warningColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: warningColor.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.timer,
                        size: 16,
                        color: warningColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Link expires in ${_formatTime(remainingTime)}",
                        style: TextStyle(
                          fontSize: 12,
                          color: warningColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

              SizedBox(height: spMd),

              // Action Buttons
              Column(
                spacing: spSm,
                children: [
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "I've Verified My Email",
                      size: bs.md,
                      onPressed: () {
                        // Check verification status
                        isVerified = true;
                        setState(() {});
                        ss("Email verified successfully!");
                        
                        // After a delay, proceed to next step
                        Future.delayed(Duration(seconds: 2), () {
                          // ss('Next page'));
                        });
                      },
                    ),
                  ),

                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Resend Verification Email",
                      size: bs.md,
                      onPressed: remainingTime == 0 ? _resendEmail : null,
                    ),
                  ),
                ],
              ),

              SizedBox(height: spMd),

              // Change Email
              GestureDetector(
                onTap: () {
                  // Allow user to change email
                  showDialog(
                    context: context,
                    builder: (context) => _buildChangeEmailDialog(),
                  );
                },
                child: Text(
                  "Use a different email address",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ] else ...[
              // Verified State
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
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
                    Icon(
                      Icons.check_circle,
                      size: 60,
                      color: successColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "Great! Your email is now verified",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: successColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "You can now receive important notifications and recover your account if needed.",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        height: 1.3,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              SizedBox(height: spMd),

              Container(
                width: double.infinity,
                child: QButton(
                  label: "Continue to Profile Setup",
                  size: bs.md,
                  onPressed: () {
                    // Navigate to profile setup
                    // ss('Next page'));
                  },
                ),
              ),
            ],

            SizedBox(height: spXl),

            // Skip Option
            if (!isVerified)
              GestureDetector(
                onTap: () {
                  // Skip email verification
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

  Widget _buildChangeEmailDialog() {
    String newEmail = "";
    
    return Dialog(
      child: Container(
        width: 400,
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Change Email Address",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            
            QTextField(
              label: "New Email",
              value: newEmail,
              hint: "Enter new email address",
              validator: Validator.email,
              onChanged: (value) {
                newEmail = value;
              },
            ),
            SizedBox(height: spMd),
            
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Cancel",
                    size: bs.sm,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Update",
                    size: bs.sm,
                    onPressed: () {
                      if (newEmail.isNotEmpty) {
                        userEmail = newEmail;
                        remainingTime = 300;
                        _startTimer();
                        setState(() {});
                        Navigator.of(context).pop();
                        ss("Verification email sent to ${newEmail}");
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
