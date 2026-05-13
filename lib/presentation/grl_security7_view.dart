import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSecurity7View extends StatefulWidget {
  @override
  State<GrlSecurity7View> createState() => _GrlSecurity7ViewState();
}

class _GrlSecurity7ViewState extends State<GrlSecurity7View> {
  String currentPassword = '';
  String newPassword = '';
  String confirmPassword = '';
  bool showCurrentPassword = false;
  bool showNewPassword = false;
  bool showConfirmPassword = false;
  
  List<Map<String, dynamic>> passwordRequirements = [
    {
      "text": "At least 8 characters long",
      "met": false,
      "icon": Icons.check_circle,
    },
    {
      "text": "Contains uppercase letter",
      "met": false,
      "icon": Icons.check_circle,
    },
    {
      "text": "Contains lowercase letter", 
      "met": false,
      "icon": Icons.check_circle,
    },
    {
      "text": "Contains number",
      "met": false,
      "icon": Icons.check_circle,
    },
    {
      "text": "Contains special character",
      "met": false,
      "icon": Icons.check_circle,
    },
  ];

  List<Map<String, dynamic>> passwordHistory = [
    {
      "date": "March 15, 2024",
      "time": "2:30 PM",
      "device": "iPhone 14 Pro",
      "location": "New York, NY",
    },
    {
      "date": "January 8, 2024",
      "time": "9:15 AM",
      "device": "MacBook Pro",
      "location": "New York, NY",
    },
    {
      "date": "October 22, 2023",
      "time": "4:45 PM", 
      "device": "Windows PC",
      "location": "Chicago, IL",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Password"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Password Strength Indicator
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.security,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Password Strength",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  // Strength Bar
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 8,
                          decoration: BoxDecoration(
                            color: disabledColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: _getPasswordStrength(),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: _getStrengthColor(),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 4 - _getPasswordStrength(),
                                child: Container(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Text(
                        _getStrengthText(),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: _getStrengthColor(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Current Password
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
                    "Current Password",
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
                        child: QTextField(
                          label: "Enter current password",
                          value: currentPassword,
                          obscureText: !showCurrentPassword,
                          onChanged: (value) {
                            currentPassword = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      GestureDetector(
                        onTap: () {
                          showCurrentPassword = !showCurrentPassword;
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Icon(
                            showCurrentPassword ? Icons.visibility_off : Icons.visibility,
                            color: primaryColor,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // New Password
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
                    "New Password",
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
                        child: QTextField(
                          label: "Enter new password",
                          value: newPassword,
                          obscureText: !showNewPassword,
                          onChanged: (value) {
                            newPassword = value;
                            _checkPasswordRequirements(value);
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      GestureDetector(
                        onTap: () {
                          showNewPassword = !showNewPassword;
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Icon(
                            showNewPassword ? Icons.visibility_off : Icons.visibility,
                            color: primaryColor,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Confirm Password
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
                    "Confirm New Password",
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
                        child: QTextField(
                          label: "Confirm new password",
                          value: confirmPassword,
                          obscureText: !showConfirmPassword,
                          onChanged: (value) {
                            confirmPassword = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      GestureDetector(
                        onTap: () {
                          showConfirmPassword = !showConfirmPassword;
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Icon(
                            showConfirmPassword ? Icons.visibility_off : Icons.visibility,
                            color: primaryColor,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (confirmPassword.isNotEmpty && newPassword != confirmPassword) ...[
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Icon(
                          Icons.error,
                          color: dangerColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Passwords don't match",
                          style: TextStyle(
                            fontSize: 14,
                            color: dangerColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Password Requirements
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
                    "Password Requirements",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  ...passwordRequirements.map((req) => Padding(
                    padding: EdgeInsets.only(bottom: spSm),
                    child: Row(
                      children: [
                        Icon(
                          req["met"] as bool ? Icons.check_circle : Icons.radio_button_unchecked,
                          color: req["met"] as bool ? successColor : disabledBoldColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "${req["text"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: req["met"] as bool ? successColor : disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  )).toList(),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Change Password Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Update Password",
                size: bs.md,
                onPressed: _canUpdatePassword() ? () async {
                  showLoading();
                  await Future.delayed(Duration(seconds: 2));
                  hideLoading();
                  ss("Password updated successfully");
                  // navigateTo(SecuritySettingsView());
                } : null,
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Password History
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
                  Row(
                    children: [
                      Icon(
                        Icons.history,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Password History",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Recent password changes on your account",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  ...passwordHistory.map((history) => Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: disabledColor),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(51),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(
                            Icons.lock,
                            color: primaryColor,
                            size: 16,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${history["date"]} at ${history["time"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${history["device"]} • ${history["location"]}",
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
                  )).toList(),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Security Tips
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
                        Icons.lightbulb,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Password Security Tips",
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
                    "• Use a unique password for this account\n• Consider using a password manager\n• Don't share your password with anyone\n• Change your password regularly\n• Use two-factor authentication for extra security",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.5,
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

  void _checkPasswordRequirements(String password) {
    passwordRequirements[0]["met"] = password.length >= 8;
    passwordRequirements[1]["met"] = password.contains(RegExp(r'[A-Z]'));
    passwordRequirements[2]["met"] = password.contains(RegExp(r'[a-z]'));
    passwordRequirements[3]["met"] = password.contains(RegExp(r'[0-9]'));
    passwordRequirements[4]["met"] = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  }

  int _getPasswordStrength() {
    int strength = 0;
    for (var req in passwordRequirements) {
      if (req["met"] as bool) strength++;
    }
    return strength;
  }

  Color _getStrengthColor() {
    int strength = _getPasswordStrength();
    if (strength <= 2) return dangerColor;
    if (strength <= 3) return warningColor;
    if (strength <= 4) return infoColor;
    return successColor;
  }

  String _getStrengthText() {
    int strength = _getPasswordStrength();
    if (strength <= 2) return "Weak";
    if (strength <= 3) return "Fair";
    if (strength <= 4) return "Good";
    return "Strong";
  }

  bool _canUpdatePassword() {
    return currentPassword.isNotEmpty &&
           newPassword.isNotEmpty &&
           confirmPassword.isNotEmpty &&
           newPassword == confirmPassword &&
           _getPasswordStrength() >= 3;
  }
}
