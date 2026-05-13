import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlVerification6View extends StatefulWidget {
  @override
  State<GrlVerification6View> createState() => _GrlVerification6ViewState();
}

class _GrlVerification6ViewState extends State<GrlVerification6View> {
  String email = "";
  String currentPassword = "";
  String newPassword = "";
  String confirmPassword = "";
  String securityQuestion = "";
  String securityAnswer = "";
  bool twoFactorEnabled = false;
  bool emailNotifications = true;
  bool smsNotifications = false;
  
  final formKey = GlobalKey<FormState>();
  
  List<Map<String, dynamic>> securityQuestions = [
    {"label": "What is your mother's maiden name?", "value": "maiden_name"},
    {"label": "What was the name of your first pet?", "value": "first_pet"},
    {"label": "What city were you born in?", "value": "birth_city"},
    {"label": "What is your favorite book?", "value": "favorite_book"},
    {"label": "What was your childhood nickname?", "value": "childhood_nickname"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Security Settings"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Security Status Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [successColor, successColor.withAlpha(180)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(40),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Icon(
                        Icons.verified_user,
                        size: 32,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Security Score: 85%",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Good security level",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.trending_up,
                      color: Colors.white,
                      size: 24,
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spLg),
              
              // Account Information
              Text(
                "Account Information",
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
                hint: "Enter your email address",
                validator: Validator.email,
                onChanged: (value) {
                  email = value;
                  setState(() {});
                },
              ),
              
              SizedBox(height: spLg),
              
              // Password Settings
              Text(
                "Password Settings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              SizedBox(height: spMd),
              
              QTextField(
                label: "Current Password",
                value: currentPassword,
                hint: "Enter current password",
                obscureText: true,
                validator: Validator.required,
                onChanged: (value) {
                  currentPassword = value;
                  setState(() {});
                },
              ),
              
              SizedBox(height: spMd),
              
              QTextField(
                label: "New Password",
                value: newPassword,
                hint: "Enter new password",
                obscureText: true,
                validator: Validator.required,
                onChanged: (value) {
                  newPassword = value;
                  setState(() {});
                },
              ),
              
              SizedBox(height: spMd),
              
              QTextField(
                label: "Confirm New Password",
                value: confirmPassword,
                hint: "Confirm new password",
                obscureText: true,
                validator: Validator.required,
                onChanged: (value) {
                  confirmPassword = value;
                  setState(() {});
                },
              ),
              
              SizedBox(height: spMd),
              
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Password Strength",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Strong",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 4,
                            decoration: BoxDecoration(
                              color: successColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                          ),
                        ),
                        SizedBox(width: 2),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 4,
                            decoration: BoxDecoration(
                              color: disabledColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spLg),
              
              // Security Question
              Text(
                "Security Question",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              SizedBox(height: spMd),
              
              QDropdownField(
                label: "Select Security Question",
                items: securityQuestions,
                value: securityQuestion,
                onChanged: (value, label) {
                  securityQuestion = value;
                  setState(() {});
                },
              ),
              
              SizedBox(height: spMd),
              
              QTextField(
                label: "Security Answer",
                value: securityAnswer,
                hint: "Enter your answer",
                validator: Validator.required,
                onChanged: (value) {
                  securityAnswer = value;
                  setState(() {});
                },
              ),
              
              SizedBox(height: spLg),
              
              // Two-Factor Authentication
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
                        SizedBox(width: spMd),
                        Expanded(
                          child: Text(
                            "Two-Factor Authentication",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Add an extra layer of security to your account by enabling two-factor authentication.",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    QSwitch(
                      items: [
                        {
                          "label": "Enable Two-Factor Authentication",
                          "value": true,
                          "checked": twoFactorEnabled,
                        }
                      ],
                      value: [
                        if (twoFactorEnabled)
                          {"label": "Enable Two-Factor Authentication", "value": true, "checked": true}
                      ],
                      onChanged: (values, ids) {
                        twoFactorEnabled = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spMd),
              
              // Notification Settings
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
                          Icons.notifications,
                          color: primaryColor,
                          size: 24,
                        ),
                        SizedBox(width: spMd),
                        Text(
                          "Security Notifications",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    QSwitch(
                      items: [
                        {
                          "label": "Email Notifications",
                          "value": "email",
                          "checked": emailNotifications,
                        },
                        {
                          "label": "SMS Notifications",
                          "value": "sms",
                          "checked": smsNotifications,
                        },
                      ],
                      value: [
                        if (emailNotifications)
                          {"label": "Email Notifications", "value": "email", "checked": true},
                        if (smsNotifications)
                          {"label": "SMS Notifications", "value": "sms", "checked": true},
                      ],
                      onChanged: (values, ids) {
                        emailNotifications = values.any((v) => v["value"] == "email");
                        smsNotifications = values.any((v) => v["value"] == "sms");
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spLg),
              
              // Recent Security Activity
              Text(
                "Recent Security Activity",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              SizedBox(height: spMd),
              
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    _buildActivityItem(
                      "Password Changed",
                      "2 days ago",
                      Icons.lock,
                      successColor,
                    ),
                    Divider(height: 1, color: disabledColor),
                    _buildActivityItem(
                      "Login from New Device",
                      "1 week ago",
                      Icons.devices,
                      warningColor,
                    ),
                    Divider(height: 1, color: disabledColor),
                    _buildActivityItem(
                      "Security Question Updated",
                      "2 weeks ago",
                      Icons.help,
                      infoColor,
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spXl),
              
              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Save Changes",
                      size: bs.md,
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          showLoading();
                          
                          // Simulate API call
                          await Future.delayed(Duration(seconds: 2));
                          
                          hideLoading();
                          ss("Security settings updated successfully!");
                        }
                      },
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: QButton(
                      label: "Reset Settings",
                      size: bs.md,
                      onPressed: () async {
                        bool isConfirmed = await confirm("Are you sure you want to reset all security settings?");
                        if (isConfirmed) {
                          email = "";
                          currentPassword = "";
                          newPassword = "";
                          confirmPassword = "";
                          securityQuestion = "";
                          securityAnswer = "";
                          twoFactorEnabled = false;
                          emailNotifications = true;
                          smsNotifications = false;
                          setState(() {});
                          ss("Security settings reset successfully!");
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityItem(String title, String time, IconData icon, Color color) {
    return Padding(
      padding: EdgeInsets.all(spMd),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
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
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: disabledBoldColor,
            size: 20,
          ),
        ],
      ),
    );
  }
}
