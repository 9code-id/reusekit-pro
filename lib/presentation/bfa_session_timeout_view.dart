import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaSessionTimeoutView extends StatefulWidget {
  const BfaSessionTimeoutView({super.key});

  @override
  State<BfaSessionTimeoutView> createState() => _BfaSessionTimeoutViewState();
}

class _BfaSessionTimeoutViewState extends State<BfaSessionTimeoutView> {
  int remainingTime = 300; // 5 minutes in seconds
  bool autoExtendEnabled = false;
  String password = "";
  bool showPasswordField = false;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    Future.doWhile(() async {
      await Future.delayed(Duration(seconds: 1));
      if (mounted) {
        remainingTime--;
        if (remainingTime <= 0) {
          _handleSessionExpired();
          return false;
        }
        setState(() {});
        return true;
      }
      return false;
    });
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}";
  }

  Color _getTimeColor() {
    if (remainingTime <= 60) return dangerColor; // Last minute
    if (remainingTime <= 120) return warningColor; // Last 2 minutes
    return primaryColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withAlpha(200),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            constraints: BoxConstraints(maxWidth: 400),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowMd],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: spMd,
              children: [
                // Warning Icon
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(20),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.access_time,
                    color: warningColor,
                    size: 40,
                  ),
                ),

                // Title
                Text(
                  "Session Timeout Warning",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),

                // Countdown Timer
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: _getTimeColor().withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: _getTimeColor().withAlpha(40)),
                  ),
                  child: Column(
                    spacing: spSm,
                    children: [
                      Text(
                        "Session expires in:",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: _getTimeColor(),
                        ),
                      ),
                      Text(
                        _formatTime(remainingTime),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: _getTimeColor(),
                          fontFeatures: [FontFeature.tabularFigures()],
                        ),
                      ),
                    ],
                  ),
                ),

                // Warning Message
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "Your session will expire due to inactivity. Any unsaved changes will be lost. Please choose an option below to continue.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.5,
                    ),
                  ),
                ),

                // Action Buttons
                if (!showPasswordField)
                  Column(
                    spacing: spSm,
                    children: [
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "Continue Session",
                          icon: Icons.refresh,
                          size: bs.md,
                          onPressed: () {
                            _extendSession();
                          },
                        ),
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "Save & Logout",
                              icon: Icons.save,
                              size: bs.sm,
                              onPressed: () {
                                _saveAndLogout();
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QButton(
                              label: "Logout Now",
                              icon: Icons.logout,
                              size: bs.sm,
                              onPressed: () {
                                _logoutNow();
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                // Password Verification (if needed)
                if (showPasswordField)
                  Column(
                    spacing: spSm,
                    children: [
                      Text(
                        "Please verify your password to continue",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),

                      QTextField(
                        label: "Password",
                        value: password,
                        obscureText: true,
                        hint: "Enter your password",
                        onChanged: (value) {
                          password = value;
                          setState(() {});
                        },
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "Cancel",
                              icon: Icons.cancel,
                              size: bs.sm,
                              onPressed: () {
                                showPasswordField = false;
                                setState(() {});
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QButton(
                              label: "Verify",
                              icon: Icons.check,
                              size: bs.sm,
                              onPressed: password.isNotEmpty ? () {
                                _verifyPassword();
                              } : null,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                // Auto-extend option
                QSwitch(
                  items: [
                    {
                      "label": "Automatically extend sessions when active",
                      "value": true,
                      "checked": autoExtendEnabled,
                    }
                  ],
                  value: [
                    if (autoExtendEnabled)
                      {
                        "label": "Automatically extend sessions when active",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    autoExtendEnabled = values.isNotEmpty;
                    setState(() {});
                  },
                ),

                // Session Info
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.info,
                            color: infoColor,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Session Information",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: infoColor,
                            ),
                          ),
                        ],
                      ),
                      _buildInfoRow("User", "john.doe@example.com"),
                      _buildInfoRow("Device", "iPhone 12 Pro"),
                      _buildInfoRow("Started", "2:30 PM"),
                      _buildInfoRow("Location", "New York, NY"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        Text(
          "$label:",
          style: TextStyle(
            fontSize: 12,
            color: infoColor,
          ),
        ),
        SizedBox(width: spXs),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: infoColor,
            ),
          ),
        ),
      ],
    );
  }

  void _extendSession() {
    // For security-sensitive actions, require password verification
    if (remainingTime <= 60) {
      showPasswordField = true;
      setState(() {});
      return;
    }

    // Extend session
    remainingTime = 1800; // Reset to 30 minutes
    setState(() {});
    ss("Session extended for 30 minutes");
    back();
  }

  void _verifyPassword() async {
    if (password.isEmpty) {
      se("Please enter your password");
      return;
    }

    showLoading();

    try {
      // Simulate password verification
      await Future.delayed(Duration(seconds: 1));

      // In real app, verify against server
      if (password == "password123") {
        hideLoading();
        remainingTime = 1800; // Reset to 30 minutes
        setState(() {});
        ss("Password verified. Session extended!");
        back();
      } else {
        hideLoading();
        se("Incorrect password. Please try again.");
        password = "";
        setState(() {});
      }
    } catch (e) {
      hideLoading();
      se("Verification failed. Please try again.");
    }
  }

  void _saveAndLogout() async {
    showLoading();
    
    try {
      // Simulate saving data
      await Future.delayed(Duration(seconds: 2));
      hideLoading();
      ss("Data saved successfully. Logging out...");
      
      // Navigate to login
      await Future.delayed(Duration(seconds: 1));
      // offAll(LoginView)
      
    } catch (e) {
      hideLoading();
      se("Failed to save data. Please try again.");
    }
  }

  void _logoutNow() {
    // Immediate logout without saving
    si("Logging out immediately...");
    // offAll(LoginView)
  }

  void _handleSessionExpired() {
    // Session has expired
    se("Session expired. Please log in again.");
    // offAll(LoginView)
  }

  @override
  void dispose() {
    super.dispose();
  }
}
