import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaChangePasswordView extends StatefulWidget {
  const SpaChangePasswordView({super.key});

  @override
  State<SpaChangePasswordView> createState() => _SpaChangePasswordViewState();
}

class _SpaChangePasswordViewState extends State<SpaChangePasswordView> {
  String currentPassword = "";
  String newPassword = "";
  String confirmPassword = "";
  
  bool obscureCurrentPassword = true;
  bool obscureNewPassword = true;
  bool obscureConfirmPassword = true;
  
  bool requireTwoFactorAuth = false;
  bool logoutAllDevices = true;
  bool sendNotification = true;
  
  String twoFactorCode = "";
  bool isVerifying2FA = false;
  
  final formKey = GlobalKey<FormState>();
  
  List<Map<String, dynamic>> passwordRequirements = [
    {
      "requirement": "At least 8 characters long",
      "met": false,
      "icon": Icons.check_circle,
    },
    {
      "requirement": "Contains uppercase letter",
      "met": false,
      "icon": Icons.check_circle,
    },
    {
      "requirement": "Contains lowercase letter",
      "met": false,
      "icon": Icons.check_circle,
    },
    {
      "requirement": "Contains number",
      "met": false,
      "icon": Icons.check_circle,
    },
    {
      "requirement": "Contains special character",
      "met": false,
      "icon": Icons.check_circle,
    },
    {
      "requirement": "Different from current password",
      "met": false,
      "icon": Icons.check_circle,
    },
  ];

  List<Map<String, dynamic>> recentPasswords = [
    {
      "id": 1,
      "changeDate": "2024-01-15T10:30:00Z",
      "reason": "Scheduled update",
      "device": "iPhone 14 Pro",
      "location": "New York, NY",
    },
    {
      "id": 2,
      "changeDate": "2023-10-20T14:45:00Z",
      "reason": "Security concern",
      "device": "MacBook Pro",
      "location": "New York, NY",
    },
    {
      "id": 3,
      "changeDate": "2023-07-08T09:15:00Z",
      "reason": "Regular update",
      "device": "iPhone 14 Pro",
      "location": "Los Angeles, CA",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Password"),
        actions: [
          QButton(
            icon: Icons.info,
            size: bs.sm,
            onPressed: () {
              _showPasswordTips();
            },
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              _buildPasswordHeader(),
              _buildCurrentPasswordSection(),
              _buildNewPasswordSection(),
              _buildPasswordRequirements(),
              _buildSecurityOptions(),
              if (requireTwoFactorAuth && isVerifying2FA) _build2FAVerification(),
              _buildPasswordHistory(),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(180)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(51),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.lock_reset,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Update Your Password",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Create a strong password to keep your spa account secure",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(200),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(51),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: Colors.white.withAlpha(100), width: 1),
            ),
            child: Row(
              children: [
                Icon(Icons.security, color: Colors.white, size: 18),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Your password was last changed on ${recentPasswords.isNotEmpty ? DateTime.parse(recentPasswords[0]["changeDate"]).dMMMy : 'N/A'}",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white,
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

  Widget _buildCurrentPasswordSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(Icons.lock, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Current Password",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          
          Stack(
            children: [
              QTextField(
                label: "Enter Current Password",
                value: currentPassword,
                obscureText: obscureCurrentPassword,
                validator: Validator.required,
                onChanged: (value) {
                  currentPassword = value;
                  setState(() {});
                },
              ),
              Positioned(
                right: spSm,
                top: 12,
                child: GestureDetector(
                  onTap: () {
                    obscureCurrentPassword = !obscureCurrentPassword;
                    setState(() {});
                  },
                  child: Icon(
                    obscureCurrentPassword ? Icons.visibility : Icons.visibility_off,
                    color: disabledBoldColor,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          
          Container(
            width: double.infinity,
            child: QButton(
              label: "Forgot Current Password?",
              size: bs.sm,
              onPressed: () {
                _forgotPassword();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewPasswordSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(Icons.lock_open, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "New Password",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          
          Stack(
            children: [
              QTextField(
                label: "Enter New Password",
                value: newPassword,
                obscureText: obscureNewPassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "New password is required";
                  }
                  if (value.length < 8) {
                    return "Password must be at least 8 characters";
                  }
                  return null;
                },
                onChanged: (value) {
                  newPassword = value;
                  _checkPasswordRequirements();
                },
              ),
              Positioned(
                right: spSm,
                top: 12,
                child: GestureDetector(
                  onTap: () {
                    obscureNewPassword = !obscureNewPassword;
                    setState(() {});
                  },
                  child: Icon(
                    obscureNewPassword ? Icons.visibility : Icons.visibility_off,
                    color: disabledBoldColor,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          
          Stack(
            children: [
              QTextField(
                label: "Confirm New Password",
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
              Positioned(
                right: spSm,
                top: 12,
                child: GestureDetector(
                  onTap: () {
                    obscureConfirmPassword = !obscureConfirmPassword;
                    setState(() {});
                  },
                  child: Icon(
                    obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
                    color: disabledBoldColor,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Generate Strong Password",
                  size: bs.sm,
                  onPressed: () {
                    _generatePassword();
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Check Strength",
                  size: bs.sm,
                  onPressed: () {
                    _checkPasswordStrength();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordRequirements() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Password Requirements",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Your new password must meet these criteria:",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          
          ...passwordRequirements.map((req) {
            final isMet = req["met"] as bool;
            return Container(
              padding: EdgeInsets.symmetric(vertical: spXs),
              child: Row(
                children: [
                  Icon(
                    isMet ? Icons.check_circle : Icons.radio_button_unchecked,
                    color: isMet ? successColor : disabledColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "${req["requirement"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: isMet ? successColor : disabledBoldColor,
                        decoration: isMet ? TextDecoration.lineThrough : null,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: infoColor, width: 1),
            ),
            child: Row(
              children: [
                Icon(Icons.lightbulb, color: infoColor, size: 18),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Tip: Use a mix of words, numbers, and symbols that are meaningful to you but hard for others to guess.",
                    style: TextStyle(
                      fontSize: 13,
                      color: infoColor,
                      height: 1.3,
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

  Widget _buildSecurityOptions() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Additional Security Options",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          QSwitch(
            items: [
              {
                "label": "Require two-factor authentication to change password",
                "value": true,
                "checked": requireTwoFactorAuth,
              }
            ],
            value: [if (requireTwoFactorAuth) {"label": "Require two-factor authentication to change password", "value": true, "checked": true}],
            onChanged: (values, ids) {
              requireTwoFactorAuth = values.isNotEmpty;
              setState(() {});
            },
          ),
          
          QSwitch(
            items: [
              {
                "label": "Sign out all devices after password change",
                "value": true,
                "checked": logoutAllDevices,
              }
            ],
            value: [if (logoutAllDevices) {"label": "Sign out all devices after password change", "value": true, "checked": true}],
            onChanged: (values, ids) {
              logoutAllDevices = values.isNotEmpty;
              setState(() {});
            },
          ),
          
          QSwitch(
            items: [
              {
                "label": "Send notification about password change",
                "value": true,
                "checked": sendNotification,
              }
            ],
            value: [if (sendNotification) {"label": "Send notification about password change", "value": true, "checked": true}],
            onChanged: (values, ids) {
              sendNotification = values.isNotEmpty;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _build2FAVerification() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: warningColor, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(Icons.security, color: warningColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Two-Factor Authentication Required",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: warningColor,
                ),
              ),
            ],
          ),
          Text(
            "Enter the verification code from your authenticator app or SMS",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          
          QTextField(
            label: "Verification Code",
            value: twoFactorCode,
            onChanged: (value) {
              twoFactorCode = value;
              setState(() {});
            },
          ),
          
          Container(
            width: double.infinity,
            child: QButton(
              label: "Resend Code",
              size: bs.sm,
              onPressed: () {
                _resend2FACode();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordHistory() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(Icons.history, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Recent Password Changes",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Text(
            "Your password change history for security monitoring",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          
          ...recentPasswords.take(3).map((change) {
            final changeDate = DateTime.parse(change["changeDate"]);
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.key, color: Colors.white, size: 16),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Password changed - ${change["reason"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${changeDate.dMMMy} • ${change["device"]} • ${change["location"]}",
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
            );
          }).toList(),
          
          if (recentPasswords.length > 3) ...[
            Container(
              width: double.infinity,
              child: QButton(
                label: "View Full History",
                size: bs.sm,
                onPressed: () {
                  _viewFullHistory();
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    final allRequirementsMet = passwordRequirements.every((req) => req["met"]);
    
    return Column(
      spacing: spMd,
      children: [
        Container(
          width: double.infinity,
          child: QButton(
            label: requireTwoFactorAuth && !isVerifying2FA 
                ? "Verify Identity & Change Password"
                : "Change Password",
            size: bs.md,
            onPressed: (allRequirementsMet && currentPassword.isNotEmpty && 
                      newPassword == confirmPassword) ? () {
              _changePassword();
            } : null,
          ),
        ),
        
        Container(
          width: double.infinity,
          child: QButton(
            label: "Cancel",
            size: bs.sm,
            onPressed: () {
              _cancelPasswordChange();
            },
          ),
        ),
      ],
    );
  }

  void _checkPasswordRequirements() {
    setState(() {
      passwordRequirements[0]["met"] = newPassword.length >= 8;
      passwordRequirements[1]["met"] = newPassword.contains(RegExp(r'[A-Z]'));
      passwordRequirements[2]["met"] = newPassword.contains(RegExp(r'[a-z]'));
      passwordRequirements[3]["met"] = newPassword.contains(RegExp(r'[0-9]'));
      passwordRequirements[4]["met"] = newPassword.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
      passwordRequirements[5]["met"] = newPassword != currentPassword && newPassword.isNotEmpty;
    });
  }

  void _generatePassword() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#\$%^&*';
    newPassword = List.generate(12, (index) => chars[(DateTime.now().millisecondsSinceEpoch + index) % chars.length]).join();
    confirmPassword = newPassword;
    _checkPasswordRequirements();
    ss("Strong password generated");
  }

  void _checkPasswordStrength() {
    if (newPassword.length < 8) {
      se("Password is too weak - add more characters");
    } else if (passwordRequirements.where((req) => req["met"]).length < 4) {
      sw("Password strength is moderate");
    } else {
      ss("Password strength is strong!");
    }
  }

  void _forgotPassword() {
    ss("Forgot password assistance");
    //navigateTo ( ForgotPasswordView )
  }

  void _changePassword() {
    if (formKey.currentState!.validate()) {
      if (requireTwoFactorAuth && !isVerifying2FA) {
        isVerifying2FA = true;
        setState(() {});
        ss("Two-factor authentication required");
        return;
      }
      
      if (requireTwoFactorAuth && twoFactorCode.length < 6) {
        se("Please enter a valid verification code");
        return;
      }
      
      // Simulate password change
      ss("Password changed successfully!");
      //navigateTo ( previous view or dashboard )
    }
  }

  void _resend2FACode() {
    ss("Verification code sent");
  }

  void _viewFullHistory() {
    ss("Viewing full password history");
    //navigateTo ( PasswordHistoryView )
  }

  void _showPasswordTips() {
    ss("Showing password security tips");
    //navigateTo ( PasswordTipsView )
  }

  void _cancelPasswordChange() {
    ss("Password change cancelled");
    //navigateTo ( previous view )
  }
}
