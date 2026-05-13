import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaForgotPasswordView extends StatefulWidget {
  const PmaForgotPasswordView({super.key});

  @override
  State<PmaForgotPasswordView> createState() => _PmaForgotPasswordViewState();
}

class _PmaForgotPasswordViewState extends State<PmaForgotPasswordView> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  String resetCode = "";
  String newPassword = "";
  String confirmPassword = "";
  bool obscureNewPassword = true;
  bool obscureConfirmPassword = true;
  bool loading = false;
  int currentStep = 0; // 0: email, 1: verification, 2: new password, 3: success

  List<Map<String, dynamic>> resetMethods = [
    {
      "title": "Email Verification",
      "description": "Receive a reset code via email",
      "icon": Icons.email,
      "value": "email"
    },
    {
      "title": "SMS Verification",
      "description": "Receive a reset code via SMS",
      "icon": Icons.sms,
      "value": "sms"
    },
    {
      "title": "Security Questions",
      "description": "Answer your security questions",
      "icon": Icons.quiz,
      "value": "security"
    }
  ];

  String selectedResetMethod = "email";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: _goBack,
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              infoColor,
              infoColor.withAlpha(200),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              spacing: spLg,
              children: [
                _buildHeader(),
                _buildProgressIndicator(),
                _buildStepContent(),
                _buildNavigationButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      spacing: spMd,
      children: [
        SizedBox(height: spLg),
        
        // Icon
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(30),
                blurRadius: 20,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Center(
            child: Icon(
              Icons.lock_reset,
              size: 40,
              color: infoColor,
            ),
          ),
        ),
        
        // Title and description
        Column(
          spacing: spSm,
          children: [
            Text(
              _getStepTitle(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              _getStepDescription(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withAlpha(200),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(30),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(
          color: Colors.white.withAlpha(50),
          width: 1,
        ),
      ),
      child: Row(
        children: List.generate(4, (index) {
          bool isActive = index <= currentStep;
          bool isCurrent = index == currentStep;
          
          return Expanded(
            child: Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: isActive ? Colors.white : Colors.white.withAlpha(100),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isCurrent ? Colors.white : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "${index + 1}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isActive ? infoColor : Colors.white,
                      ),
                    ),
                  ),
                ),
                if (index < 3)
                  Expanded(
                    child: Container(
                      height: 2,
                      margin: EdgeInsets.symmetric(horizontal: spXs),
                      decoration: BoxDecoration(
                        color: isActive ? Colors.white : Colors.white.withAlpha(100),
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildStepContent() {
    return Container(
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowLg],
      ),
      child: _getStepWidget(),
    );
  }

  Widget _getStepWidget() {
    switch (currentStep) {
      case 0:
        return _buildEmailStep();
      case 1:
        return _buildVerificationStep();
      case 2:
        return _buildNewPasswordStep();
      case 3:
        return _buildSuccessStep();
      default:
        return _buildEmailStep();
    }
  }

  Widget _buildEmailStep() {
    return Form(
      key: formKey,
      child: Column(
        spacing: spMd,
        children: [
          Text(
            "Reset Password",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: infoColor,
            ),
          ),
          
          SizedBox(height: spSm),
          
          // Reset method selection
          Text(
            "Choose your reset method:",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          
          ...resetMethods.map((method) => _buildResetMethodOption(method)),
          
          SizedBox(height: spSm),
          
          // Email input
          QTextField(
            label: selectedResetMethod == "email" ? "Email Address" : 
                   selectedResetMethod == "sms" ? "Phone Number" : "Username",
            value: email,
            hint: selectedResetMethod == "email" ? "Enter your email address" : 
                  selectedResetMethod == "sms" ? "Enter your phone number" : "Enter your username",
            validator: selectedResetMethod == "email" ? Validator.email : Validator.required,
            onChanged: (value) {
              email = value;
              setState(() {});
            },
          ),
          
          // Security info
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: infoColor.withAlpha(30)),
            ),
            child: Row(
              children: [
                Icon(Icons.security, color: infoColor, size: 16),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "We'll send you a secure reset code to verify your identity",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResetMethodOption(Map<String, dynamic> method) {
    bool isSelected = method["value"] == selectedResetMethod;

    return GestureDetector(
      onTap: () {
        selectedResetMethod = method["value"] as String;
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.all(spSm),
        margin: EdgeInsets.only(bottom: spXs),
        decoration: BoxDecoration(
          color: isSelected ? infoColor.withAlpha(20) : Colors.transparent,
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: isSelected ? infoColor : disabledColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              method["icon"] as IconData,
              color: isSelected ? infoColor : disabledBoldColor,
              size: 20,
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Column(
                spacing: spXs,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${method["title"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? infoColor : disabledBoldColor,
                    ),
                  ),
                  Text(
                    "${method["description"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: infoColor,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildVerificationStep() {
    return Column(
      spacing: spMd,
      children: [
        Text(
          "Enter Verification Code",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: infoColor,
          ),
        ),
        
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: successColor.withAlpha(10),
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: successColor.withAlpha(30)),
          ),
          child: Row(
            children: [
              Icon(Icons.check_circle, color: successColor, size: 16),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  selectedResetMethod == "email" 
                      ? "Reset code sent to $email"
                      : "Reset code sent to your ${selectedResetMethod}",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        
        SizedBox(height: spSm),
        
        QTextField(
          label: "Verification Code",
          value: resetCode,
          hint: "Enter 6-digit code",
          validator: Validator.required,
          onChanged: (value) {
            resetCode = value;
            setState(() {});
          },
        ),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Didn't receive the code?",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
            GestureDetector(
              onTap: _resendCode,
              child: Text(
                "Resend Code",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: infoColor,
                ),
              ),
            ),
          ],
        ),
        
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: warningColor.withAlpha(10),
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: warningColor.withAlpha(30)),
          ),
          child: Row(
            children: [
              Icon(Icons.timer, color: warningColor, size: 16),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "Code expires in 10 minutes",
                  style: TextStyle(
                    fontSize: 12,
                    color: warningColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNewPasswordStep() {
    return Form(
      key: formKey,
      child: Column(
        spacing: spMd,
        children: [
          Text(
            "Create New Password",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: infoColor,
            ),
          ),
          
          SizedBox(height: spSm),
          
          // New password field
          Column(
            spacing: spXs,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              QTextField(
                label: "New Password",
                value: newPassword,
                hint: "Create a strong password",
                obscureText: obscureNewPassword,
                validator: Validator.required,
                onChanged: (value) {
                  newPassword = value;
                  setState(() {});
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "At least 8 characters with numbers and symbols",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      obscureNewPassword = !obscureNewPassword;
                      setState(() {});
                    },
                    child: Text(
                      obscureNewPassword ? "Show" : "Hide",
                      style: TextStyle(
                        color: infoColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          // Confirm password field
          Column(
            spacing: spXs,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              QTextField(
                label: "Confirm New Password",
                value: confirmPassword,
                hint: "Re-enter your new password",
                obscureText: obscureConfirmPassword,
                validator: (value) {
                  if (value != newPassword) {
                    return "Passwords do not match";
                  }
                  return null;
                },
                onChanged: (value) {
                  confirmPassword = value;
                  setState(() {});
                },
              ),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    obscureConfirmPassword = !obscureConfirmPassword;
                    setState(() {});
                  },
                  child: Text(
                    obscureConfirmPassword ? "Show" : "Hide",
                    style: TextStyle(
                      color: infoColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          // Password strength indicator
          _buildPasswordStrength(),
          
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: infoColor.withAlpha(30)),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: infoColor, size: 16),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "Choose a password that you haven't used before",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessStep() {
    return Column(
      spacing: spMd,
      children: [
        Icon(
          Icons.check_circle,
          size: 80,
          color: successColor,
        ),
        
        Text(
          "Password Reset Successful!",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: successColor,
          ),
        ),
        
        Text(
          "Your password has been successfully reset. You can now sign in with your new password.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
            height: 1.5,
          ),
        ),
        
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: successColor.withAlpha(10),
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: successColor.withAlpha(30)),
          ),
          child: Column(
            spacing: spXs,
            children: [
              Row(
                children: [
                  Icon(Icons.security, color: successColor, size: 16),
                  SizedBox(width: spXs),
                  Text(
                    "Security Tips:",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: successColor,
                    ),
                  ),
                ],
              ),
              _buildSecurityTip("• Keep your password private and secure"),
              _buildSecurityTip("• Use unique passwords for different accounts"),
              _buildSecurityTip("• Enable two-factor authentication"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSecurityTip(String tip) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        tip,
        style: TextStyle(
          fontSize: 12,
          color: successColor,
        ),
      ),
    );
  }

  Widget _buildPasswordStrength() {
    double strength = _calculatePasswordStrength(newPassword);
    Color strengthColor = strength < 0.3 ? dangerColor : 
                         strength < 0.7 ? warningColor : successColor;
    String strengthText = strength < 0.3 ? "Weak" : 
                         strength < 0.7 ? "Medium" : "Strong";

    return Column(
      spacing: spXs,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Password Strength: ",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
            Text(
              strengthText,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: strengthColor,
              ),
            ),
          ],
        ),
        Container(
          height: 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radiusXs),
            color: disabledColor,
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: strength,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusXs),
                color: strengthColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationButtons() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spSm,
        children: [
          if (currentStep < 3)
            Container(
              width: double.infinity,
              child: QButton(
                label: loading ? "Processing..." : _getButtonText(),
                icon: _getButtonIcon(),
                size: bs.md,
                onPressed: loading ? null : _handleNextStep,
              ),
            ),
          
          if (currentStep == 3)
            Container(
              width: double.infinity,
              child: QButton(
                label: "Go to Sign In",
                icon: Icons.login,
                size: bs.md,
                onPressed: _goToLogin,
              ),
            ),
          
          if (currentStep > 0 && currentStep < 3)
            Container(
              width: double.infinity,
              child: QButton(
                label: "Back",
                icon: Icons.arrow_back,
                size: bs.sm,
                onPressed: _goToPreviousStep,
              ),
            ),
        ],
      ),
    );
  }

  String _getStepTitle() {
    switch (currentStep) {
      case 0: return "Forgot Password?";
      case 1: return "Check Your ${selectedResetMethod == 'email' ? 'Email' : selectedResetMethod.toUpperCase()}";
      case 2: return "Create New Password";
      case 3: return "All Set!";
      default: return "Reset Password";
    }
  }

  String _getStepDescription() {
    switch (currentStep) {
      case 0: return "Don't worry, we'll help you reset it";
      case 1: return "Enter the verification code we sent you";
      case 2: return "Choose a strong and secure password";
      case 3: return "Your password has been successfully reset";
      default: return "";
    }
  }

  String _getButtonText() {
    switch (currentStep) {
      case 0: return "Send Reset Code";
      case 1: return "Verify Code";
      case 2: return "Reset Password";
      default: return "Continue";
    }
  }

  IconData _getButtonIcon() {
    switch (currentStep) {
      case 0: return Icons.send;
      case 1: return Icons.verified;
      case 2: return Icons.lock_reset;
      default: return Icons.arrow_forward;
    }
  }

  double _calculatePasswordStrength(String password) {
    if (password.isEmpty) return 0.0;
    
    double strength = 0.0;
    if (password.length >= 8) strength += 0.25;
    if (password.length >= 12) strength += 0.15;
    if (password.contains(RegExp(r'[a-z]'))) strength += 0.15;
    if (password.contains(RegExp(r'[A-Z]'))) strength += 0.15;
    if (password.contains(RegExp(r'[0-9]'))) strength += 0.15;
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) strength += 0.15;
    
    return strength.clamp(0.0, 1.0);
  }

  void _handleNextStep() async {
    if (currentStep < 2) {
      if (!formKey.currentState!.validate()) return;
    }

    loading = true;
    setState(() {});

    // Simulate processing
    await Future.delayed(Duration(seconds: 2));

    loading = false;
    currentStep++;
    setState(() {});

    if (currentStep == 1) {
      si("Reset code sent successfully");
    } else if (currentStep == 2) {
      ss("Code verified successfully");
    } else if (currentStep == 3) {
      ss("Password reset completed!");
    }
  }

  void _goToPreviousStep() {
    if (currentStep > 0) {
      currentStep--;
      setState(() {});
    }
  }

  void _resendCode() {
    si("Reset code resent");
  }

  void _goToLogin() {
    // Navigate to login
    si("Redirecting to login...");
  }

  void _goBack() {
    if (currentStep > 0) {
      _goToPreviousStep();
    } else {
      // Navigate back to login
      si("Going back to login...");
    }
  }
}
