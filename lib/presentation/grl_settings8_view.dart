import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSettings8View extends StatefulWidget {
  @override
  State<GrlSettings8View> createState() => _GrlSettings8ViewState();
}

class _GrlSettings8ViewState extends State<GrlSettings8View> {
  String appVersion = "2.1.4";
  String buildNumber = "245";
  bool betaUpdates = false;
  bool autoUpdate = true;
  bool downloadOverWifiOnly = true;
  
  List<Map<String, dynamic>> updateHistory = [
    {
      "version": "2.1.4",
      "date": "Dec 20, 2023",
      "size": "45.2 MB",
      "type": "Security Update",
      "status": "Installed",
      "description": "Critical security fixes and performance improvements"
    },
    {
      "version": "2.1.3",
      "date": "Dec 15, 2023",
      "size": "38.7 MB",
      "type": "Feature Update",
      "status": "Installed",
      "description": "New messaging features and bug fixes"
    },
    {
      "version": "2.1.2",
      "date": "Dec 10, 2023",
      "size": "42.1 MB",
      "type": "Bug Fix",
      "status": "Installed",
      "description": "Performance improvements and stability fixes"
    },
    {
      "version": "2.1.1",
      "date": "Dec 1, 2023",
      "size": "51.3 MB",
      "type": "Major Update",
      "status": "Installed",
      "description": "New dashboard design and enhanced user interface"
    },
  ];

  List<Map<String, dynamic>> systemInfo = [
    {
      "label": "App Version",
      "value": "2.1.4 (245)",
      "icon": Icons.info
    },
    {
      "label": "Platform",
      "value": "iOS 17.2",
      "icon": Icons.phone_iphone
    },
    {
      "label": "Device",
      "value": "iPhone 14 Pro",
      "icon": Icons.smartphone
    },
    {
      "label": "Storage Used",
      "value": "156.7 MB",
      "icon": Icons.storage
    },
    {
      "label": "Last Update",
      "value": "Dec 20, 2023",
      "icon": Icons.update
    },
    {
      "label": "Install Date",
      "value": "Nov 15, 2023",
      "icon": Icons.download
    },
  ];

  List<Map<String, dynamic>> appFeatures = [
    {
      "name": "Dark Mode",
      "description": "Enhanced dark theme support",
      "version": "2.1.0",
      "status": "Available"
    },
    {
      "name": "Advanced Analytics",
      "description": "Detailed usage statistics",
      "version": "2.1.2",
      "status": "Available"
    },
    {
      "name": "Offline Mode",
      "description": "Work without internet connection",
      "version": "2.1.3",
      "status": "Available"
    },
    {
      "name": "Voice Commands",
      "description": "Control app with voice",
      "version": "2.2.0",
      "status": "Coming Soon"
    },
    {
      "name": "AI Assistant",
      "description": "Smart help and suggestions",
      "version": "2.3.0",
      "status": "Coming Soon"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About & Updates"),
        actions: [
          QButton(
            icon: Icons.system_update,
            size: bs.sm,
            onPressed: () {
              _checkForUpdates();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // App Info Card
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(200)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(spLg),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusXl),
                    ),
                    child: Icon(
                      Icons.apps,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "ReuseKit App",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Version ${appVersion} (${buildNumber})",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withAlpha(200),
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: _buildAppStat("Released", "Dec 20, 2023"),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildAppStat("Size", "156.7 MB"),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildAppStat("Rating", "4.8 ⭐"),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Update Settings
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
                        Icons.system_update,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Update Settings",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  _buildUpdateToggle(
                    Icons.autorenew,
                    "Automatic Updates",
                    "Install updates automatically",
                    autoUpdate,
                    (value) {
                      autoUpdate = value;
                      setState(() {});
                      if (value) {
                        ss("Automatic updates enabled");
                      } else {
                        sw("Automatic updates disabled");
                      }
                    },
                  ),
                  
                  Divider(height: spLg),
                  
                  _buildUpdateToggle(
                    Icons.wifi,
                    "WiFi Only Downloads",
                    "Download updates only on WiFi",
                    downloadOverWifiOnly,
                    (value) {
                      downloadOverWifiOnly = value;
                      setState(() {});
                    },
                  ),
                  
                  Divider(height: spLg),
                  
                  _buildUpdateToggle(
                    Icons.science,
                    "Beta Updates",
                    "Receive pre-release versions",
                    betaUpdates,
                    (value) {
                      betaUpdates = value;
                      setState(() {});
                      if (value) {
                        sw("Beta updates enabled - May contain bugs");
                      }
                    },
                  ),
                ],
              ),
            ),

            // System Information
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
                        Icons.info,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "System Information",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  ...systemInfo.map((info) => _buildSystemInfoItem(info)),
                ],
              ),
            ),

            // Update History
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
                      Expanded(
                        child: Text(
                          "Update History",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      QButton(
                        label: "View All",
                        size: bs.sm,
                        onPressed: () {
                          si("Full update history coming soon");
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  ...updateHistory.take(3).map((update) => _buildUpdateHistoryItem(update)),
                ],
              ),
            ),

            // Features & Roadmap
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
                        Icons.new_releases,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Features & Roadmap",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  ...appFeatures.map((feature) => _buildFeatureItem(feature)),
                ],
              ),
            ),

            // Support & Legal
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.support,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Support & Legal",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  _buildSupportOption(
                    Icons.help,
                    "Help Center",
                    "Get answers to common questions",
                    () {
                      si("Help center coming soon");
                    },
                  ),
                  
                  _buildSupportOption(
                    Icons.bug_report,
                    "Report a Bug",
                    "Let us know about issues you've found",
                    () {
                      si("Bug reporting coming soon");
                    },
                  ),
                  
                  _buildSupportOption(
                    Icons.feedback,
                    "Send Feedback",
                    "Share your thoughts and suggestions",
                    () {
                      si("Feedback feature coming soon");
                    },
                  ),
                  
                  _buildSupportOption(
                    Icons.gavel,
                    "Terms of Service",
                    "Read our terms and conditions",
                    () {
                      si("Terms of service coming soon");
                    },
                  ),
                  
                  _buildSupportOption(
                    Icons.privacy_tip,
                    "Privacy Policy",
                    "Learn how we protect your data",
                    () {
                      si("Privacy policy coming soon");
                    },
                  ),
                  
                  _buildSupportOption(
                    Icons.info,
                    "Open Source Licenses",
                    "View third-party license information",
                    () {
                      si("License information coming soon");
                    },
                  ),
                ],
              ),
            ),

            // Action Buttons
            Column(
              spacing: spSm,
              children: [
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Check for Updates",
                    size: bs.md,
                    onPressed: () {
                      _checkForUpdates();
                    },
                  ),
                ),
                
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Rate This App",
                    size: bs.md,
                    onPressed: () {
                      si("App rating feature coming soon");
                    },
                  ),
                ),
                
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Share App",
                    size: bs.md,
                    onPressed: () {
                      si("App sharing feature coming soon");
                    },
                  ),
                ),
              ],
            ),

            // Copyright Footer
            Container(
              padding: EdgeInsets.all(spMd),
              child: Column(
                children: [
                  Text(
                    "© 2023 ReuseKit Technologies",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Made with ❤️ for developers",
                    textAlign: TextAlign.center,
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
    );
  }

  Widget _buildAppStat(String label, String value) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: spXs, horizontal: spSm),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(30),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withAlpha(200),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpdateToggle(IconData icon, String title, String subtitle, bool value, Function(bool) onChanged) {
    return Row(
      children: [
        Icon(
          icon,
          color: primaryColor,
          size: 20,
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildSystemInfoItem(Map<String, dynamic> info) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Icon(
            info["icon"],
            color: primaryColor,
            size: 20,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              "${info["label"]}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ),
          Text(
            "${info["value"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpdateHistoryItem(Map<String, dynamic> update) {
    Color typeColor = primaryColor;
    if (update["type"] == "Security Update") typeColor = dangerColor;
    if (update["type"] == "Feature Update") typeColor = successColor;
    if (update["type"] == "Bug Fix") typeColor = warningColor;
    if (update["type"] == "Major Update") typeColor = infoColor;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Version ${update["version"]}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(width: spXs),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: typeColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${update["type"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: typeColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Spacer(),
              Icon(
                Icons.check_circle,
                color: successColor,
                size: 16,
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            "${update["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "${update["date"]} • ${update["size"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(Map<String, dynamic> feature) {
    Color statusColor = primaryColor;
    if (feature["status"] == "Available") statusColor = successColor;
    if (feature["status"] == "Coming Soon") statusColor = warningColor;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${feature["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${feature["status"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: statusColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "${feature["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "v${feature["version"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSupportOption(IconData icon, String title, String subtitle, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: spSm),
        child: Row(
          children: [
            Icon(
              icon,
              color: primaryColor,
              size: 20,
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: disabledBoldColor,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  void _checkForUpdates() {
    showLoading();
    
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      si("You're running the latest version");
    });
  }
}
