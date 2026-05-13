import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPrivacy3View extends StatefulWidget {
  @override
  State<GrlPrivacy3View> createState() => _GrlPrivacy3ViewState();
}

class _GrlPrivacy3ViewState extends State<GrlPrivacy3View> {
  bool allowAnalytics = true;
  bool allowMarketing = false;
  bool allowPersonalization = true;
  bool allowThirdParty = false;
  bool allowLocationTracking = false;
  bool allowNotifications = true;

  List<Map<String, dynamic>> privacySettings = [
    {
      "title": "Analytics & Performance",
      "description": "Help us improve our services by sharing usage data and performance metrics",
      "icon": Icons.analytics,
      "category": "Essential",
      "value": "analytics",
    },
    {
      "title": "Marketing Communications",
      "description": "Receive promotional emails, newsletters, and special offers",
      "icon": Icons.campaign,
      "category": "Optional",
      "value": "marketing",
    },
    {
      "title": "Personalization",
      "description": "Customize content and recommendations based on your preferences",
      "icon": Icons.person,
      "category": "Recommended",
      "value": "personalization",
    },
    {
      "title": "Third-Party Integrations",
      "description": "Allow data sharing with trusted partners for enhanced features",
      "icon": Icons.share,
      "category": "Optional",
      "value": "thirdParty",
    },
    {
      "title": "Location Tracking",
      "description": "Use your location to provide relevant content and services",
      "icon": Icons.location_on,
      "category": "Optional",
      "value": "location",
    },
    {
      "title": "Push Notifications",
      "description": "Receive important updates and alerts on your device",
      "icon": Icons.notifications,
      "category": "Recommended",
      "value": "notifications",
    },
  ];

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Essential":
        return successColor;
      case "Recommended":
        return primaryColor;
      case "Optional":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  bool _getSettingValue(String value) {
    switch (value) {
      case "analytics":
        return allowAnalytics;
      case "marketing":
        return allowMarketing;
      case "personalization":
        return allowPersonalization;
      case "thirdParty":
        return allowThirdParty;
      case "location":
        return allowLocationTracking;
      case "notifications":
        return allowNotifications;
      default:
        return false;
    }
  }

  void _updateSetting(String value, bool newValue) {
    setState(() {
      switch (value) {
        case "analytics":
          allowAnalytics = newValue;
          break;
        case "marketing":
          allowMarketing = newValue;
          break;
        case "personalization":
          allowPersonalization = newValue;
          break;
        case "thirdParty":
          allowThirdParty = newValue;
          break;
        case "location":
          allowLocationTracking = newValue;
          break;
        case "notifications":
          allowNotifications = newValue;
          break;
      }
    });
  }

  void _saveSettings() async {
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    ss("Privacy settings updated successfully");
  }

  void _resetToDefaults() async {
    bool isConfirmed = await confirm("Reset all privacy settings to default values?");
    if (isConfirmed) {
      setState(() {
        allowAnalytics = true;
        allowMarketing = false;
        allowPersonalization = true;
        allowThirdParty = false;
        allowLocationTracking = false;
        allowNotifications = true;
      });
      ss("Settings reset to defaults");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy Settings"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetToDefaults,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    primaryColor.withAlpha(30),
                    primaryColor.withAlpha(10),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.tune,
                    size: 48,
                    color: primaryColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Customize Your Experience",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Control how your data is used to enhance your experience with our services",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),

            // Quick Actions
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.shield_outlined,
                          color: successColor,
                          size: 32,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Privacy Protected",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: successColor,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "Your data is secure",
                          style: TextStyle(
                            color: successColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.visibility_outlined,
                          color: infoColor,
                          size: 32,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Full Transparency",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "Complete control",
                          style: TextStyle(
                            color: infoColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Settings List
            Text(
              "Privacy Controls",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...privacySettings.map((setting) {
              final isEnabled = _getSettingValue(setting["value"]);
              final categoryColor = _getCategoryColor(setting["category"]);
              
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                  border: Border.all(
                    color: isEnabled ? primaryColor.withAlpha(50) : disabledColor,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: (setting["icon"] as IconData == Icons.analytics
                                    ? successColor
                                    : setting["icon"] as IconData == Icons.campaign
                                        ? warningColor
                                        : primaryColor)
                                .withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            setting["icon"] as IconData,
                            color: setting["icon"] as IconData == Icons.analytics
                                ? successColor
                                : setting["icon"] as IconData == Icons.campaign
                                    ? warningColor
                                    : primaryColor,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${setting["title"]}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: categoryColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXl),
                                    ),
                                    child: Text(
                                      "${setting["category"]}",
                                      style: TextStyle(
                                        color: categoryColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${setting["description"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: isEnabled,
                          onChanged: (value) => _updateSetting(setting["value"], value),
                          activeColor: primaryColor,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),

            // Data Management Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: warningColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.data_usage,
                        color: warningColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Data Management",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Request a copy of your data, delete your account, or export your information. These actions may take up to 30 days to complete.",
                    style: TextStyle(
                      color: warningColor,
                      height: 1.4,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Export Data",
                          size: bs.sm,
                          onPressed: () {
                            si("Data export request submitted");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Delete Account",
                          size: bs.sm,
                          onPressed: () async {
                            bool isConfirmed = await confirm(
                              "Are you sure you want to delete your account? This action cannot be undone.",
                            );
                            if (isConfirmed) {
                              se("Account deletion is not available in demo mode");
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Save Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Save Privacy Settings",
                size: bs.md,
                icon: Icons.save,
                onPressed: _saveSettings,
              ),
            ),

            // Footer Note
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: infoColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Changes to privacy settings take effect immediately. Some changes may require you to log out and back in.",
                      style: TextStyle(
                        color: infoColor,
                        fontSize: 12,
                      ),
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
}
