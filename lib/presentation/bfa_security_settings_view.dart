import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaSecuritySettingsView extends StatefulWidget {
  const BfaSecuritySettingsView({super.key});

  @override
  State<BfaSecuritySettingsView> createState() => _BfaSecuritySettingsViewState();
}

class _BfaSecuritySettingsViewState extends State<BfaSecuritySettingsView> {
  bool biometricEnabled = true;
  bool twoFactorEnabled = false;
  bool loginNotifications = true;
  bool transactionAlerts = true;
  bool accountLockEnabled = false;
  
  String currentPin = "";
  String newPin = "";
  String confirmPin = "";
  String securityQuestion = "What is your mother's maiden name?";
  String securityAnswer = "";

  List<Map<String, dynamic>> securityQuestions = [
    {"label": "What is your mother's maiden name?", "value": "mothers_maiden_name"},
    {"label": "What was the name of your first pet?", "value": "first_pet_name"},
    {"label": "What city were you born in?", "value": "birth_city"},
    {"label": "What is your favorite book?", "value": "favorite_book"},
    {"label": "What was your first car?", "value": "first_car"},
  ];

  List<Map<String, dynamic>> recentSecurityActivity = [
    {
      "action": "Password Changed",
      "date": "2024-06-14",
      "time": "10:30 AM",
      "device": "iPhone 15 Pro",
      "location": "New York, NY",
      "status": "success"
    },
    {
      "action": "Login Attempt",
      "date": "2024-06-13",
      "time": "09:15 AM",
      "device": "Windows PC",
      "location": "New York, NY",
      "status": "success"
    },
    {
      "action": "Failed Login",
      "date": "2024-06-12",
      "time": "11:45 PM",
      "device": "Unknown Device",
      "location": "Los Angeles, CA",
      "status": "failed"
    },
    {
      "action": "Two-Factor Setup",
      "date": "2024-06-10",
      "time": "02:20 PM",
      "device": "iPhone 15 Pro",
      "location": "New York, NY",
      "status": "success"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Security Settings"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              _showSecurityActivity();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spLg,
          children: [
            _buildSecurityOptions(),
            _buildPinSettings(),
            _buildSecurityQuestion(),
            _buildDeviceManagement(),
            _buildSecurityActions(),
          ],
        ),
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
            "Security Options",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Row(
            children: [
              Icon(Icons.fingerprint, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Biometric Authentication",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Use fingerprint or face ID for quick access",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: biometricEnabled,
                onChanged: (value) {
                  biometricEnabled = value;
                  setState(() {});
                },
              ),
            ],
          ),

          Divider(color: disabledColor),

          Row(
            children: [
              Icon(Icons.security, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Two-Factor Authentication",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Add extra security with SMS or authenticator app",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: twoFactorEnabled,
                onChanged: (value) {
                  twoFactorEnabled = value;
                  setState(() {});
                  if (value) {
                    _setupTwoFactor();
                  }
                },
              ),
            ],
          ),

          Divider(color: disabledColor),

          Row(
            children: [
              Icon(Icons.notifications_active, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Login Notifications",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Get notified of new login attempts",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: loginNotifications,
                onChanged: (value) {
                  loginNotifications = value;
                  setState(() {});
                },
              ),
            ],
          ),

          Divider(color: disabledColor),

          Row(
            children: [
              Icon(Icons.lock, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Auto Account Lock",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Lock account after 5 failed login attempts",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: accountLockEnabled,
                onChanged: (value) {
                  accountLockEnabled = value;
                  setState(() {});
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPinSettings() {
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
              Icon(Icons.pin, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Transaction PIN",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),

          QTextField(
            label: "Current PIN",
            value: currentPin,
            obscureText: true,
            hint: "Enter your current PIN",
            onChanged: (value) {
              currentPin = value;
              setState(() {});
            },
          ),

          QTextField(
            label: "New PIN",
            value: newPin,
            obscureText: true,
            hint: "Enter new 6-digit PIN",
            onChanged: (value) {
              newPin = value;
              setState(() {});
            },
          ),

          QTextField(
            label: "Confirm New PIN",
            value: confirmPin,
            obscureText: true,
            hint: "Confirm your new PIN",
            onChanged: (value) {
              confirmPin = value;
              setState(() {});
            },
          ),

          Container(
            width: double.infinity,
            child: QButton(
              label: "Update PIN",
              size: bs.md,
              onPressed: () {
                _updatePin();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityQuestion() {
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
              Icon(Icons.help_outline, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Security Question",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),

          QDropdownField(
            label: "Security Question",
            items: securityQuestions,
            value: securityQuestion,
            onChanged: (value, label) {
              securityQuestion = value;
              setState(() {});
            },
          ),

          QTextField(
            label: "Answer",
            value: securityAnswer,
            hint: "Enter your answer",
            onChanged: (value) {
              securityAnswer = value;
              setState(() {});
            },
          ),

          Container(
            width: double.infinity,
            child: QButton(
              label: "Update Security Question",
              size: bs.md,
              onPressed: () {
                _updateSecurityQuestion();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeviceManagement() {
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
              Icon(Icons.devices, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Trusted Devices",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),

          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(Icons.phone_iphone, color: successColor, size: 20),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "iPhone 15 Pro",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Current device • Added June 1, 2024",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: successColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "ACTIVE",
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Manage Devices",
                  size: bs.sm,
                  onPressed: () {
                    // Navigate to device management
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: dangerColor),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: QButton(
                    label: "Remove All",
                    size: bs.sm,
                    onPressed: () async {
                      bool isConfirmed = await confirm("Remove all trusted devices? You'll need to verify your identity on next login.");
                      if (isConfirmed) {
                        _removeAllDevices();
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityActions() {
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
            "Security Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Change Password",
                  size: bs.md,
                  icon: Icons.password,
                  onPressed: () {
                    _changePassword();
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Security Activity",
                  size: bs.md,
                  icon: Icons.history,
                  onPressed: () {
                    _showSecurityActivity();
                  },
                ),
              ),
            ],
          ),

          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: dangerColor),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: QButton(
              label: "Lock Account Temporarily",
              size: bs.md,
              icon: Icons.lock_clock,
              onPressed: () async {
                bool isConfirmed = await confirm("Lock your account temporarily? You can unlock it anytime with your security question.");
                if (isConfirmed) {
                  _lockAccount();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _setupTwoFactor() {
    // Navigate to two-factor setup
  }

  void _updatePin() {
    if (currentPin.isEmpty || newPin.isEmpty || confirmPin.isEmpty) {
      se("Please fill all PIN fields");
      return;
    }
    
    if (newPin != confirmPin) {
      se("New PIN and confirmation don't match");
      return;
    }
    
    if (newPin.length != 6) {
      se("PIN must be 6 digits");
      return;
    }

    showLoading();
    
    // Simulate API call
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("Transaction PIN updated successfully");
      currentPin = "";
      newPin = "";
      confirmPin = "";
      setState(() {});
    });
  }

  void _updateSecurityQuestion() {
    if (securityAnswer.isEmpty) {
      se("Please provide an answer to the security question");
      return;
    }

    showLoading();
    
    // Simulate API call
    Future.delayed(Duration(seconds: 1), () {
      hideLoading();
      ss("Security question updated successfully");
    });
  }

  void _changePassword() {
    // Navigate to change password view
  }

  void _showSecurityActivity() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Security Activity",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            SizedBox(height: spMd),
            Expanded(
              child: ListView.builder(
                itemCount: recentSecurityActivity.length,
                itemBuilder: (context, index) {
                  final activity = recentSecurityActivity[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              activity["status"] == "success" ? Icons.check_circle : Icons.error,
                              color: activity["status"] == "success" ? successColor : dangerColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "${activity["action"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Text(
                              "${activity["date"]} ${activity["time"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Device: ${activity["device"]} • ${activity["location"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _removeAllDevices() {
    showLoading();
    
    // Simulate API call
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("All trusted devices removed successfully");
    });
  }

  void _lockAccount() {
    showLoading();
    
    // Simulate API call
    Future.delayed(Duration(seconds: 1), () {
      hideLoading();
      ss("Account locked temporarily. You can unlock it with your security question.");
    });
  }
}
