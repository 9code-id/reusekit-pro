import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlForgotPassword9View extends StatefulWidget {
  @override
  State<GrlForgotPassword9View> createState() => _GrlForgotPassword9ViewState();
}

class _GrlForgotPassword9ViewState extends State<GrlForgotPassword9View> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  String newPassword = "";
  String confirmPassword = "";
  bool obscureNewPassword = true;
  bool obscureConfirmPassword = true;
  bool loading = false;
  bool resetSuccessful = false;
  
  // Password strength indicators
  bool hasMinLength = false;
  bool hasUppercase = false;
  bool hasLowercase = false;
  bool hasNumber = false;
  bool hasSpecialChar = false;

  void checkPasswordStrength(String password) {
    hasMinLength = password.length >= 8;
    hasUppercase = password.contains(RegExp(r'[A-Z]'));
    hasLowercase = password.contains(RegExp(r'[a-z]'));
    hasNumber = password.contains(RegExp(r'[0-9]'));
    hasSpecialChar = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    setState(() {});
  }

  bool get isPasswordStrong {
    return hasMinLength && hasUppercase && hasLowercase && hasNumber && hasSpecialChar;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create New Password"),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Form(
                key: formKey,
                child: Column(
                  spacing: spMd,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: spMd),
                    
                    if (!resetSuccessful) ...[
                      // Password Reset Form
                      
                      // Header
                      Center(
                        child: Column(
                          spacing: spMd,
                          children: [
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    primaryColor.withAlpha(20),
                                    primaryColor.withAlpha(5),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(radius3xl),
                              ),
                              child: Icon(
                                Icons.lock_reset,
                                size: 60,
                                color: primaryColor,
                              ),
                            ),
                            
                            Column(
                              spacing: spSm,
                              children: [
                                Text(
                                  "Almost Done!",
                                  style: TextStyle(
                                    fontSize: fsH2,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "Create a strong password to secure your account. Make sure it meets all the requirements below.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: sp2xl),
                      
                      // Email Confirmation
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(5),
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(
                            color: successColor.withAlpha(20),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.verified_user,
                              color: successColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Identity Verified",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: successColor,
                                    ),
                                  ),
                                  Text(
                                    "Resetting password for: john.doe@example.com",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: spMd),
                      
                      // New Password Section
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          spacing: spMd,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.lock_outline,
                                  color: primaryColor,
                                  size: 24,
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "New Password",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            
                            // New Password Input
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                QTextField(
                                  label: "New Password",
                                  value: newPassword,
                                  obscureText: obscureNewPassword,
                                  hint: "Enter your new password",
                                  validator: Validator.required,
                                  onChanged: (value) {
                                    newPassword = value;
                                    checkPasswordStrength(value);
                                  },
                                ),
                                SizedBox(height: spXs),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      obscureNewPassword = !obscureNewPassword;
                                      setState(() {});
                                    },
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
                              ],
                            ),
                            
                            // Confirm Password Input
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                QTextField(
                                  label: "Confirm Password",
                                  value: confirmPassword,
                                  obscureText: obscureConfirmPassword,
                                  hint: "Confirm your new password",
                                  validator: Validator.required,
                                  onChanged: (value) {
                                    confirmPassword = value;
                                    setState(() {});
                                  },
                                ),
                                SizedBox(height: spXs),
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
                                        color: primaryColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: spMd),
                      
                      // Password Strength Indicators
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          spacing: spMd,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.security,
                                  color: isPasswordStrong ? successColor : warningColor,
                                  size: 24,
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "Password Strength",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: isPasswordStrong ? successColor : warningColor,
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isPasswordStrong 
                                        ? successColor.withAlpha(10) 
                                        : warningColor.withAlpha(10),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    isPasswordStrong ? "Strong" : "Weak",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: isPasswordStrong ? successColor : warningColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            Column(
                              spacing: spSm,
                              children: [
                                _buildRequirementItem("At least 8 characters", hasMinLength),
                                _buildRequirementItem("Uppercase letter (A-Z)", hasUppercase),
                                _buildRequirementItem("Lowercase letter (a-z)", hasLowercase),
                                _buildRequirementItem("Number (0-9)", hasNumber),
                                _buildRequirementItem("Special character (!@#\$%^&*)", hasSpecialChar),
                              ],
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: spMd),
                      
                      // Password Match Check
                      if (confirmPassword.isNotEmpty)
                        Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: newPassword == confirmPassword 
                                ? successColor.withAlpha(5) 
                                : dangerColor.withAlpha(5),
                            borderRadius: BorderRadius.circular(radiusLg),
                            border: Border.all(
                              color: newPassword == confirmPassword 
                                  ? successColor.withAlpha(20) 
                                  : dangerColor.withAlpha(20),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                newPassword == confirmPassword ? Icons.check_circle : Icons.error,
                                color: newPassword == confirmPassword ? successColor : dangerColor,
                                size: 20,
                              ),
                              SizedBox(width: spSm),
                              Text(
                                newPassword == confirmPassword 
                                    ? "Passwords match" 
                                    : "Passwords don't match",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: newPassword == confirmPassword ? successColor : dangerColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      
                      SizedBox(height: spXl),
                      
                      // Reset Button
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "Reset Password",
                          size: bs.md,
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              if (newPassword != confirmPassword) {
                                se("Passwords do not match!");
                                return;
                              }
                              if (!isPasswordStrong) {
                                sw("Please create a stronger password that meets all requirements");
                                return;
                              }
                              
                              loading = true;
                              setState(() {});
                              
                              // Simulate password reset
                              await Future.delayed(Duration(seconds: 3));
                              
                              loading = false;
                              resetSuccessful = true;
                              setState(() {});
                            }
                          },
                        ),
                      ),
                    ] else ...[
                      // Success State
                      
                      Center(
                        child: Column(
                          spacing: spLg,
                          children: [
                            // Success Animation
                            Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                gradient: RadialGradient(
                                  colors: [
                                    successColor.withAlpha(20),
                                    successColor.withAlpha(5),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(radius3xl),
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: successColor,
                                      borderRadius: BorderRadius.circular(radius2xl),
                                    ),
                                    child: Icon(
                                      Icons.check,
                                      size: 60,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            Column(
                              spacing: spSm,
                              children: [
                                Text(
                                  "Password Reset Complete!",
                                  style: TextStyle(
                                    fontSize: fsH2,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                                Text(
                                  "Your password has been successfully reset. You can now sign in with your new credentials.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: sp2xl),
                      
                      // Security Tips
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          spacing: spMd,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.tips_and_updates,
                                  color: infoColor,
                                  size: 24,
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "Security Tips",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: infoColor,
                                  ),
                                ),
                              ],
                            ),
                            
                            Text(
                              "• Keep your password private and secure\n• Use a unique password for this account\n• Consider using a password manager\n• Enable two-factor authentication if available\n• Sign out from shared or public devices",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: spXl),
                      
                      // Sign In Button
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "Sign In Now",
                          size: bs.md,
                          onPressed: () {
                            // navigateTo(LoginView());
                            ss("Redirecting to login...");
                          },
                        ),
                      ),
                    ],
                    
                    SizedBox(height: spMd),
                    
                    // Back to Login (only if not successful)
                    if (!resetSuccessful)
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            back();
                          },
                          child: Text(
                            "Back to Login",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildRequirementItem(String text, bool isMet) {
    return Row(
      children: [
        Icon(
          isMet ? Icons.check_circle : Icons.radio_button_unchecked,
          color: isMet ? successColor : disabledColor,
          size: 16,
        ),
        SizedBox(width: spSm),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: isMet ? successColor : disabledBoldColor,
            fontWeight: isMet ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
