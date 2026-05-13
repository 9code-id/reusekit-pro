import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsChangePasswordView extends StatefulWidget {
  const BrsChangePasswordView({super.key});

  @override
  State<BrsChangePasswordView> createState() => _BrsChangePasswordViewState();
}

class _BrsChangePasswordViewState extends State<BrsChangePasswordView> {
  final formKey = GlobalKey<FormState>();
  String currentPassword = "";
  String newPassword = "";
  String confirmPassword = "";
  bool obscureCurrentPassword = true;
  bool obscureNewPassword = true;
  bool obscureConfirmPassword = true;
  bool enableBiometric = false;

  List<Map<String, dynamic>> passwordRequirements = [
    {"text": "At least 8 characters long", "met": false},
    {"text": "Contains uppercase letter", "met": false},
    {"text": "Contains lowercase letter", "met": false},
    {"text": "Contains number", "met": false},
    {"text": "Contains special character", "met": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Password"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(
                    color: infoColor.withAlpha(50),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: infoColor,
                      size: 24,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "For security, you'll need to enter your current password to set a new one.",
                        style: TextStyle(
                          fontSize: 14,
                          color: infoColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: spLg),
              
              Text(
                "Current Password",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              QTextField(
                label: "Enter current password",
                value: currentPassword,
                obscureText: obscureCurrentPassword,
                validator: Validator.required,
                onChanged: (value) {
                  currentPassword = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spXs),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    obscureCurrentPassword = !obscureCurrentPassword;
                    setState(() {});
                  },
                  child: Text(
                    obscureCurrentPassword ? "Show" : "Hide",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              
              SizedBox(height: spLg),
              Text(
                "New Password",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              QTextField(
                label: "Enter new password",
                value: newPassword,
                obscureText: obscureNewPassword,
                validator: Validator.required,
                onChanged: (value) {
                  newPassword = value;
                  _checkPasswordRequirements(value);
                  setState(() {});
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
              
              SizedBox(height: spMd),
              Text(
                "Password Requirements",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              ...passwordRequirements.map((requirement) {
                return Container(
                  margin: EdgeInsets.only(bottom: spXs),
                  child: Row(
                    children: [
                      Icon(
                        (requirement["met"] as bool) ? Icons.check_circle : Icons.radio_button_unchecked,
                        color: (requirement["met"] as bool) ? successColor : disabledBoldColor,
                        size: 16,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "${requirement["text"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: (requirement["met"] as bool) ? successColor : disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              
              SizedBox(height: spLg),
              Text(
                "Confirm New Password",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              QTextField(
                label: "Confirm new password",
                value: confirmPassword,
                obscureText: obscureConfirmPassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please confirm your password";
                  }
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
              
              if (newPassword.isNotEmpty && confirmPassword.isNotEmpty)
                Container(
                  margin: EdgeInsets.only(top: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: newPassword == confirmPassword ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: newPassword == confirmPassword ? successColor : dangerColor,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        newPassword == confirmPassword ? Icons.check_circle : Icons.error,
                        color: newPassword == confirmPassword ? successColor : dangerColor,
                        size: 16,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        newPassword == confirmPassword ? "Passwords match" : "Passwords do not match",
                        style: TextStyle(
                          fontSize: 12,
                          color: newPassword == confirmPassword ? successColor : dangerColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              
              SizedBox(height: spLg),
              Container(
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
                      "Additional Security",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Enable Biometric Login",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "Use fingerprint or face recognition",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: enableBiometric,
                          onChanged: (value) {
                            enableBiometric = value;
                            setState(() {});
                          },
                          activeColor: primaryColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spXl),
              QButton(
                label: "Update Password",
                size: bs.md,
                onPressed: _allRequirementsMet() ? () {
                  if (formKey.currentState!.validate()) {
                    _updatePassword();
                  }
                } : null,
              ),
              
              SizedBox(height: spMd),
              Center(
                child: GestureDetector(
                  onTap: () {
                    //navigateTo('forgot_password')
                  },
                  child: Text(
                    "Forgot your current password?",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
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

  void _checkPasswordRequirements(String password) {
    passwordRequirements[0]["met"] = password.length >= 8;
    passwordRequirements[1]["met"] = password.contains(RegExp(r'[A-Z]'));
    passwordRequirements[2]["met"] = password.contains(RegExp(r'[a-z]'));
    passwordRequirements[3]["met"] = password.contains(RegExp(r'[0-9]'));
    passwordRequirements[4]["met"] = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  }

  bool _allRequirementsMet() {
    return passwordRequirements.every((req) => req["met"] as bool) && 
           currentPassword.isNotEmpty && 
           newPassword == confirmPassword;
  }

  void _updatePassword() async {
    showLoading();
    
    // Simulate API call
    await Future.delayed(Duration(seconds: 2));
    
    hideLoading();
    ss("Password updated successfully");
    back();
  }
}
