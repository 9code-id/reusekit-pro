import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaForgotPasswordView extends StatefulWidget {
  const LcaForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<LcaForgotPasswordView> createState() => _LcaForgotPasswordViewState();
}

class _LcaForgotPasswordViewState extends State<LcaForgotPasswordView> {
  String email = "";
  bool emailSent = false;
  String verificationCode = "";
  String newPassword = "";
  String confirmPassword = "";
  bool obscureNewPassword = true;
  bool obscureConfirmPassword = true;
  int currentStep = 0;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reset Password"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            SizedBox(height: spLg),
            _buildProgressIndicator(),
            SizedBox(height: spLg),
            _buildCurrentStep(),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(Icons.lock_reset, color: primaryColor, size: 24),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Legal Case Assistant",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Password Recovery",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            currentStep == 0 
                ? "Enter your registered email address to receive a password reset code."
                : currentStep == 1
                    ? "Enter the verification code sent to your email."
                    : "Create a new secure password for your account.",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
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
            "Recovery Steps",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              _buildStepIndicator(0, "Email", Icons.email),
              Expanded(
                child: Container(
                  height: 2,
                  color: currentStep > 0 ? primaryColor : disabledColor,
                ),
              ),
              _buildStepIndicator(1, "Code", Icons.security),
              Expanded(
                child: Container(
                  height: 2,
                  color: currentStep > 1 ? primaryColor : disabledColor,
                ),
              ),
              _buildStepIndicator(2, "Password", Icons.lock),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStepIndicator(int step, String label, IconData icon) {
    bool isActive = currentStep >= step;
    bool isCurrent = currentStep == step;
    
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isActive ? primaryColor : disabledColor,
            borderRadius: BorderRadius.circular(radiusLg),
            border: isCurrent ? Border.all(color: primaryColor, width: 3) : null,
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
        ),
        SizedBox(height: spXs),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
            color: isActive ? primaryColor : disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildCurrentStep() {
    switch (currentStep) {
      case 0:
        return _buildEmailStep();
      case 1:
        return _buildVerificationStep();
      case 2:
        return _buildPasswordStep();
      default:
        return _buildEmailStep();
    }
  }

  Widget _buildEmailStep() {
    return Form(
      key: formKey,
      child: Column(
        children: [
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
                  "Enter Email Address",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                QTextField(
                  label: "Email Address",
                  value: email,
                  hint: "Enter your registered email",
                  validator: Validator.email,
                  onChanged: (value) {
                    email = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: spMd),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Send Reset Code",
                    size: bs.md,
                    onPressed: () => _sendResetCode(),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),
          _buildSecurityTips(),
        ],
      ),
    );
  }

  Widget _buildVerificationStep() {
    return Column(
      children: [
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
                "Verification Code",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: successColor.withAlpha(50)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.email, color: successColor, size: 16),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "Code sent to ${email}",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: spMd),
              QTextField(
                label: "Verification Code",
                value: verificationCode,
                hint: "Enter 6-digit code",
                validator: Validator.required,
                onChanged: (value) {
                  verificationCode = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spMd),
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Verify Code",
                      size: bs.md,
                      onPressed: () => _verifyCode(),
                    ),
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    label: "Resend",
                    size: bs.md,
                    onPressed: () => _resendCode(),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: spMd),
        _buildCodeInstructions(),
      ],
    );
  }

  Widget _buildPasswordStep() {
    return Column(
      children: [
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
                "Create New Password",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              QTextField(
                label: "New Password",
                value: newPassword,
                hint: "Enter new password",
                obscureText: obscureNewPassword,
                validator: Validator.required,
                onChanged: (value) {
                  newPassword = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spXs),
              GestureDetector(
                onTap: () {
                  obscureNewPassword = !obscureNewPassword;
                  setState(() {});
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    obscureNewPassword ? "Show" : "Hide",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: spMd),
              QTextField(
                label: "Confirm Password",
                value: confirmPassword,
                hint: "Confirm new password",
                obscureText: obscureConfirmPassword,
                validator: Validator.required,
                onChanged: (value) {
                  confirmPassword = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spXs),
              GestureDetector(
                onTap: () {
                  obscureConfirmPassword = !obscureConfirmPassword;
                  setState(() {});
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    obscureConfirmPassword ? "Show" : "Hide",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: spMd),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Reset Password",
                  size: bs.md,
                  onPressed: () => _resetPassword(),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: spMd),
        _buildPasswordRequirements(),
      ],
    );
  }

  Widget _buildSecurityTips() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: infoColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: infoColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info, color: infoColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Security Information",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: infoColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "• Reset code will be valid for 15 minutes\n• Code can only be used once\n• If you don't receive the email, check your spam folder\n• Contact admin if you continue to have issues",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCodeInstructions() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: warningColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: warningColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.timer, color: warningColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Code Expires in 14:23",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: warningColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "Enter the 6-digit code sent to your email. The code is case-sensitive and expires in 15 minutes.",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordRequirements() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: successColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: successColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.security, color: successColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Password Requirements",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "• At least 8 characters long\n• Include uppercase and lowercase letters\n• Include at least one number\n• Include at least one special character\n• Must match confirmation password",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  void _sendResetCode() {
    if (formKey.currentState!.validate()) {
      showLoading();
      // Simulate API call
      Future.delayed(Duration(seconds: 2), () {
        hideLoading();
        currentStep = 1;
        emailSent = true;
        setState(() {});
        ss("Reset code sent to $email");
      });
    }
  }

  void _verifyCode() {
    if (verificationCode.isNotEmpty) {
      showLoading();
      // Simulate API call
      Future.delayed(Duration(seconds: 1), () {
        hideLoading();
        if (verificationCode == "123456") {
          currentStep = 2;
          setState(() {});
          ss("Code verified successfully");
        } else {
          se("Invalid verification code");
        }
      });
    } else {
      se("Please enter verification code");
    }
  }

  void _resendCode() {
    showLoading();
    // Simulate API call
    Future.delayed(Duration(seconds: 1), () {
      hideLoading();
      ss("New code sent to $email");
    });
  }

  void _resetPassword() {
    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      se("Please fill in all password fields");
      return;
    }
    
    if (newPassword != confirmPassword) {
      se("Passwords do not match");
      return;
    }
    
    if (newPassword.length < 8) {
      se("Password must be at least 8 characters");
      return;
    }

    showLoading();
    // Simulate API call
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("Password reset successfully");
      // Navigate back to login
      back();
    });
  }
}
