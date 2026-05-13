import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSecurity8View extends StatefulWidget {
  @override
  State<GrlSecurity8View> createState() => _GrlSecurity8ViewState();
}

class _GrlSecurity8ViewState extends State<GrlSecurity8View> {
  String selectedTab = 'permissions';
  
  List<Map<String, dynamic>> appPermissions = [
    {
      "name": "Camera",
      "description": "Take photos and record videos",
      "icon": Icons.camera_alt,
      "granted": true,
      "required": true,
      "category": "media",
    },
    {
      "name": "Microphone",
      "description": "Record audio and voice messages",
      "icon": Icons.mic,
      "granted": true,
      "required": true,
      "category": "media",
    },
    {
      "name": "Location",
      "description": "Access your current location",
      "icon": Icons.location_on,
      "granted": true,
      "required": false,
      "category": "location",
    },
    {
      "name": "Contacts",
      "description": "Read and modify your contacts",
      "icon": Icons.contacts,
      "granted": false,
      "required": false,  
      "category": "personal",
    },
    {
      "name": "Storage",
      "description": "Read and write files on device",
      "icon": Icons.storage,
      "granted": true,
      "required": true,
      "category": "storage",
    },
    {
      "name": "Notifications",
      "description": "Send push notifications",
      "icon": Icons.notifications,
      "granted": true,
      "required": false,
      "category": "communication",
    },
    {
      "name": "Phone",
      "description": "Make and manage phone calls",
      "icon": Icons.phone,
      "granted": false,
      "required": false,
      "category": "communication",
    },
    {
      "name": "Calendar",
      "description": "Read and modify calendar events",
      "icon": Icons.calendar_today,
      "granted": true,
      "required": false,
      "category": "personal",
    },
  ];

  List<Map<String, dynamic>> privacySettings = [
    {
      "title": "Data Collection",
      "description": "Allow app to collect usage analytics",
      "enabled": true,
      "icon": Icons.analytics,
    },
    {
      "title": "Crash Reports",
      "description": "Send crash reports to improve app",
      "enabled": true,
      "icon": Icons.bug_report,
    },
    {
      "title": "Location History",
      "description": "Store location data for better experience",
      "enabled": false,
      "icon": Icons.location_history,
    },
    {
      "title": "Personalized Ads",
      "description": "Show ads based on your interests",
      "enabled": false,
      "icon": Icons.ads_click,
    },
    {
      "title": "Third-party Sharing",
      "description": "Share data with trusted partners",
      "enabled": false,
      "icon": Icons.share,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy & Permissions"),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab Selector
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = 'permissions';
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: selectedTab == 'permissions' ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Text(
                        "App Permissions",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: selectedTab == 'permissions' ? Colors.white : disabledBoldColor,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = 'privacy';
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: selectedTab == 'privacy' ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Text(
                        "Privacy Settings",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: selectedTab == 'privacy' ? Colors.white : disabledBoldColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Content
          Expanded(
            child: selectedTab == 'permissions' ? _buildPermissionsView() : _buildPrivacyView(),
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionsView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Permission Status Summary
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${appPermissions.where((p) => p["granted"] as bool).length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Granted",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${appPermissions.where((p) => p["required"] as bool).length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Required",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          
          // Categories
          Text(
            "Permission Categories",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Group permissions by category
          ..._groupPermissionsByCategory().entries.map((entry) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  entry.key.toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              SizedBox(height: spSm),
              ...entry.value.map((permission) => Container(
                margin: EdgeInsets.only(bottom: spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                  border: permission["required"] as bool
                      ? Border.all(color: warningColor.withAlpha(102), width: 1)
                      : null,
                ),
                child: Padding(
                  padding: EdgeInsets.all(spMd),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: (permission["granted"] as bool ? successColor : disabledColor).withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          permission["icon"] as IconData,
                          color: permission["granted"] as bool ? successColor : disabledBoldColor,
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
                                  "${permission["name"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (permission["required"] as bool) ...[
                                  SizedBox(width: spXs),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: warningColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "REQUIRED",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${permission["description"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: permission["granted"] as bool,
                        onChanged: permission["required"] as bool 
                            ? null 
                            : (value) {
                                permission["granted"] = value;
                                setState(() {});
                                if (value) {
                                  ss("${permission["name"]} permission granted");
                                } else {
                                  sw("${permission["name"]} permission revoked");
                                }
                              },
                        activeColor: successColor,
                      ),
                    ],
                  ),
                ),
              )).toList(),
              SizedBox(height: spMd),
            ],
          )).toList(),
          
          // System Settings Link
          Container(
            width: double.infinity,
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
                      Icons.settings,
                      color: infoColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "System Permissions",
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
                  "Some permissions may need to be changed in your device's system settings.",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spMd),
                QButton(
                  label: "Open System Settings",
                  size: bs.sm,
                  onPressed: () {
                    si("Opening system settings...");
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacyView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Privacy Score
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.privacy_tip,
                      color: Colors.white,
                      size: 28,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Privacy Score",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "EXCELLENT",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Your privacy settings are optimized",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(51),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Text(
                        "85%",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Privacy Settings
          Text(
            "Privacy Controls",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spMd),
          
          ...privacySettings.map((setting) => Container(
            margin: EdgeInsets.only(bottom: spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Padding(
              padding: EdgeInsets.all(spMd),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(51),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      setting["icon"] as IconData,
                      color: primaryColor,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${setting["title"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${setting["description"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: setting["enabled"] as bool,
                    onChanged: (value) {
                      setting["enabled"] = value;
                      setState(() {});
                      if (value) {
                        ss("${setting["title"]} enabled");
                      } else {
                        sw("${setting["title"]} disabled");
                      }
                    },
                    activeColor: successColor,
                  ),
                ],
              ),
            ),
          )).toList(),
          
          SizedBox(height: spMd),
          
          // Data Export
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
                      Icons.download,
                      color: primaryColor,
                      size: 24,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Your Data",
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
                  "Download a copy of your data or delete your account",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Download Data",
                        size: bs.sm,
                        onPressed: () {
                          ss("Data export started. You'll receive an email when ready.");
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: dangerColor),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: QButton(
                          label: "Delete Account",
                          size: bs.sm,
                          onPressed: () async {
                            bool isConfirmed = await confirm("This will permanently delete your account and all data. This action cannot be undone. Continue?");
                            if (isConfirmed) {
                              se("Account deletion process initiated");
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Legal Information
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
                  "Legal & Policies",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                _buildLegalLink("Privacy Policy", Icons.policy),
                SizedBox(height: spSm),
                _buildLegalLink("Terms of Service", Icons.description),
                SizedBox(height: spSm),
                _buildLegalLink("Cookie Policy", Icons.cookie),
                SizedBox(height: spSm),
                _buildLegalLink("Data Usage Guidelines", Icons.data_usage),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegalLink(String title, IconData icon) {
    return GestureDetector(
      onTap: () {
        si("Opening $title...");
      },
      child: Row(
        children: [
          Icon(
            icon,
            color: primaryColor,
            size: 20,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: disabledBoldColor,
            size: 16,
          ),
        ],
      ),
    );
  }

  Map<String, List<Map<String, dynamic>>> _groupPermissionsByCategory() {
    Map<String, List<Map<String, dynamic>>> grouped = {};
    for (var permission in appPermissions) {
      String category = permission["category"] as String;
      if (!grouped.containsKey(category)) {
        grouped[category] = [];
      }
      grouped[category]!.add(permission);
    }
    return grouped;
  }
}
