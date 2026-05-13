import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaLogoutView extends StatefulWidget {
  const BfaLogoutView({super.key});

  @override
  State<BfaLogoutView> createState() => _BfaLogoutViewState();
}

class _BfaLogoutViewState extends State<BfaLogoutView> {
  bool confirmLogout = false;
  bool clearLocalData = false;
  bool rememberMe = true;
  String selectedOption = "logout_only";

  List<Map<String, dynamic>> logoutOptions = [
    {
      "id": "logout_only",
      "title": "Logout Only",
      "description": "Keep your data and preferences for next login",
      "icon": Icons.logout,
      "color": infoColor,
    },
    {
      "id": "logout_clear",
      "title": "Logout & Clear Data",
      "description": "Remove all local data, downloads, and cache",
      "icon": Icons.clear_all,
      "color": warningColor,
    },
    {
      "id": "logout_switch",
      "title": "Switch Account",
      "description": "Logout and switch to a different account",
      "icon": Icons.switch_account,
      "color": primaryColor,
    },
  ];

  List<Map<String, dynamic>> accountInfo = [
    {"label": "Email", "value": "john.doe@example.com"},
    {"label": "Account Type", "value": "Premium User"},
    {"label": "Last Login", "value": "December 20, 2024"},
    {"label": "Device Count", "value": "3 devices"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Logout"),
        actions: [
          Icon(
            Icons.logout,
            color: dangerColor,
          ),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // User Info Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.person,
                      color: primaryColor,
                      size: 40,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "John Doe",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "john.doe@example.com",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spSm,
                      vertical: spXs,
                    ),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "Premium User",
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

            // Account Information
            Container(
              width: double.infinity,
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
                    "Account Information",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  ...accountInfo.map((info) {
                    return Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            "${info["label"]}:",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            "${info["value"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),

            // Logout Options
            Container(
              width: double.infinity,
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
                    "Logout Options",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  ...logoutOptions.map((option) {
                    bool isSelected = selectedOption == option["id"];
                    Color optionColor = option["color"] as Color;
                    
                    return GestureDetector(
                      onTap: () {
                        selectedOption = option["id"] as String;
                        setState(() {});
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(bottom: spSm),
                        decoration: BoxDecoration(
                          color: isSelected ? optionColor.withAlpha(20) : Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: isSelected ? optionColor : Colors.grey[300]!,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: optionColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                option["icon"] as IconData,
                                color: optionColor,
                                size: 20,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${option["title"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: isSelected ? optionColor : primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${option["description"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: isSelected ? optionColor : disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (isSelected)
                              Icon(
                                Icons.check_circle,
                                color: optionColor,
                              ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Additional Options
            if (selectedOption == "logout_clear")
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: warningColor.withAlpha(40)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.warning,
                          color: warningColor,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Warning: Data Will Be Cleared",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "The following data will be permanently removed from this device:",
                      style: TextStyle(
                        fontSize: 14,
                        color: warningColor,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "• Downloaded files and media",
                        "• Cached data and temporary files",
                        "• Saved preferences and settings",
                        "• Offline data and sync queue",
                        "• Login credentials and tokens"
                      ].map((item) {
                        return Text(
                          item,
                          style: TextStyle(
                            fontSize: 14,
                            color: warningColor,
                          ),
                        );
                      }).toList(),
                    ),
                    Text(
                      "Your account data on our servers will remain safe and can be accessed when you log in again.",
                      style: TextStyle(
                        fontSize: 14,
                        color: warningColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

            // Settings
            Container(
              width: double.infinity,
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
                    "Logout Settings",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  QSwitch(
                    items: [
                      {
                        "label": "Remember me for faster login",
                        "value": true,
                        "checked": rememberMe,
                      }
                    ],
                    value: [
                      if (rememberMe)
                        {
                          "label": "Remember me for faster login",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      rememberMe = values.isNotEmpty;
                      setState(() {});
                    },
                  ),

                  QSwitch(
                    items: [
                      {
                        "label": "I confirm I want to logout",
                        "value": true,
                        "checked": confirmLogout,
                      }
                    ],
                    value: [
                      if (confirmLogout)
                        {
                          "label": "I confirm I want to logout",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      confirmLogout = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Quick Actions Before Logout
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Before You Go...",
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
                          label: "Backup Data",
                          icon: Icons.backup,
                          size: bs.sm,
                          onPressed: () {
                            // Handle backup
                            si("Creating backup...");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Sync Now",
                          icon: Icons.sync,
                          size: bs.sm,
                          onPressed: () {
                            // Handle sync
                            si("Syncing data...");
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Security Notice
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(40)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.security,
                        color: infoColor,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Security Notice",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "For your security, always logout when using shared or public devices. Your session will be terminated on all devices.",
                    style: TextStyle(
                      fontSize: 14,
                      color: infoColor,
                    ),
                  ),
                ],
              ),
            ),

            // Logout Button
            Container(
              width: double.infinity,
              child: QButton(
                label: _getLogoutButtonText(),
                icon: _getLogoutButtonIcon(),
                size: bs.md,
                onPressed: confirmLogout ? () {
                  _handleLogout();
                } : null,
              ),
            ),

            // Cancel Option
            Center(
              child: GestureDetector(
                onTap: () {
                  back();
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    fontSize: 16,
                    color: disabledBoldColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getLogoutButtonText() {
    if (!confirmLogout) return "Please Confirm to Continue";
    
    switch (selectedOption) {
      case "logout_clear":
        return "Logout & Clear Data";
      case "logout_switch":
        return "Switch Account";
      default:
        return "Logout";
    }
  }

  IconData _getLogoutButtonIcon() {
    if (!confirmLogout) return Icons.warning;
    
    switch (selectedOption) {
      case "logout_clear":
        return Icons.clear_all;
      case "logout_switch":
        return Icons.switch_account;
      default:
        return Icons.logout;
    }
  }

  void _handleLogout() async {
    showLoading();
    
    try {
      // Simulate logout process
      await Future.delayed(Duration(seconds: 2));
      
      switch (selectedOption) {
        case "logout_clear":
          // Clear local data
          ss("Logged out and data cleared successfully");
          break;
        case "logout_switch":
          // Switch to login with account selection
          ss("Switching account...");
          // navigateTo(LoginView)
          break;
        default:
          // Regular logout
          ss("Logged out successfully");
          break;
      }
      
      hideLoading();
      // Navigate to login screen
      // offAll(LoginView)
      
    } catch (e) {
      hideLoading();
      se("Logout failed. Please try again.");
    }
  }
}
