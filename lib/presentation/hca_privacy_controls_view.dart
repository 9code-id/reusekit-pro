import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaPrivacyControlsView extends StatefulWidget {
  const HcaPrivacyControlsView({super.key});

  @override
  State<HcaPrivacyControlsView> createState() => _HcaPrivacyControlsViewState();
}

class _HcaPrivacyControlsViewState extends State<HcaPrivacyControlsView> {
  int currentTab = 0;
  
  // Privacy Settings
  bool shareWithDoctors = true;
  bool shareWithFamily = false;
  bool shareWithResearchers = false;
  bool allowDataAnalytics = true;
  bool allowNotifications = true;
  bool allowLocationTracking = false;
  bool biometricLogin = true;
  bool autoLock = true;
  String autoLockTime = "5";
  String dataRetention = "7";
  
  // Data Categories
  List<Map<String, dynamic>> dataCategories = [
    {"name": "Medical Records", "enabled": true, "sensitive": true},
    {"name": "Vital Signs", "enabled": true, "sensitive": false},
    {"name": "Medication History", "enabled": true, "sensitive": true},
    {"name": "Lab Results", "enabled": false, "sensitive": true},
    {"name": "Mental Health", "enabled": false, "sensitive": true},
    {"name": "Fitness Data", "enabled": true, "sensitive": false},
    {"name": "Sleep Patterns", "enabled": true, "sensitive": false},
    {"name": "Location Data", "enabled": false, "sensitive": true},
  ];
  
  // Sharing Permissions
  List<Map<String, dynamic>> sharingPermissions = [
    {
      "contact": "Dr. Sarah Wilson",
      "type": "Primary Care",
      "permissions": ["Medical Records", "Lab Results", "Medications"],
      "lastAccess": "2024-01-15 09:30",
      "status": "Active"
    },
    {
      "contact": "Dr. Michael Chen",
      "type": "Cardiologist",
      "permissions": ["Vital Signs", "Medical Records"],
      "lastAccess": "2024-01-12 14:20",
      "status": "Active"
    },
    {
      "contact": "Emergency Contact - John Doe",
      "type": "Family",
      "permissions": ["Emergency Info", "Allergies"],
      "lastAccess": "Never",
      "status": "Inactive"
    },
  ];
  
  // Audit Log
  List<Map<String, dynamic>> auditLog = [
    {
      "action": "Data Access",
      "entity": "Dr. Sarah Wilson",
      "timestamp": "2024-01-15 09:30:15",
      "details": "Accessed medical records",
      "dataType": "Medical Records"
    },
    {
      "action": "Privacy Setting Changed",
      "entity": "User",
      "timestamp": "2024-01-14 16:45:22",
      "details": "Disabled location tracking",
      "dataType": "Location Data"
    },
    {
      "action": "Data Export",
      "entity": "User",
      "timestamp": "2024-01-12 11:20:08",
      "details": "Exported health summary",
      "dataType": "All Data"
    },
  ];

  List<Map<String, dynamic>> autoLockItems = [
    {"label": "1 minute", "value": "1"},
    {"label": "5 minutes", "value": "5"},
    {"label": "15 minutes", "value": "15"},
    {"label": "30 minutes", "value": "30"},
    {"label": "Never", "value": "never"},
  ];

  List<Map<String, dynamic>> retentionItems = [
    {"label": "1 year", "value": "1"},
    {"label": "3 years", "value": "3"},
    {"label": "5 years", "value": "5"},
    {"label": "7 years", "value": "7"},
    {"label": "Forever", "value": "forever"},
  ];

  Widget _buildGeneralPrivacyTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "General Privacy Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                _buildSwitchRow("Share with Doctors", shareWithDoctors, (value) {
                  shareWithDoctors = value;
                  setState(() {});
                }),
                _buildSwitchRow("Share with Family", shareWithFamily, (value) {
                  shareWithFamily = value;
                  setState(() {});
                }),
                _buildSwitchRow("Share with Researchers", shareWithResearchers, (value) {
                  shareWithResearchers = value;
                  setState(() {});
                }),
                _buildSwitchRow("Allow Data Analytics", allowDataAnalytics, (value) {
                  allowDataAnalytics = value;
                  setState(() {});
                }),
                _buildSwitchRow("Allow Notifications", allowNotifications, (value) {
                  allowNotifications = value;
                  setState(() {});
                }),
                _buildSwitchRow("Allow Location Tracking", allowLocationTracking, (value) {
                  allowLocationTracking = value;
                  setState(() {});
                }),
              ],
            ),
          ),
          
          Text(
            "Security Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                _buildSwitchRow("Biometric Login", biometricLogin, (value) {
                  biometricLogin = value;
                  setState(() {});
                }),
                _buildSwitchRow("Auto Lock", autoLock, (value) {
                  autoLock = value;
                  setState(() {});
                }),
                QDropdownField(
                  label: "Auto Lock Time",
                  items: autoLockItems,
                  value: autoLockTime,
                  onChanged: (value, label) {
                    autoLockTime = value;
                    setState(() {});
                  },
                ),
                QDropdownField(
                  label: "Data Retention Period",
                  items: retentionItems,
                  value: dataRetention,
                  onChanged: (value, label) {
                    dataRetention = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataControlsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Data Categories",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          ...dataCategories.map((category) => Container(
            margin: EdgeInsets.only(bottom: spXs),
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
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
                            "${category["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          if (category["sensitive"] as bool) ...[
                            SizedBox(width: spXs),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: dangerColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "Sensitive",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: dangerColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        category["enabled"] as bool ? "Data sharing enabled" : "Data sharing disabled",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: category["enabled"] as bool,
                  onChanged: (value) {
                    category["enabled"] = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          )).toList(),
          
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Export All Data",
              size: bs.md,
              onPressed: () {
                // Export data
                ss("Data export initiated");
              },
            ),
          ),
          
          Container(
            width: double.infinity,
            child: QButton(
              label: "Delete All Data",
              size: bs.md,
              onPressed: () async {
                bool isConfirmed = await confirm("Are you sure you want to delete all data? This action cannot be undone.");
                if (isConfirmed) {
                  se("Data deletion initiated");
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSharingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Sharing Permissions",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {
                  // Add new sharing permission
                },
              ),
            ],
          ),
          
          ...sharingPermissions.map((permission) => Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: primaryColor.withAlpha(20),
                      child: Icon(
                        permission["type"] == "Family" ? Icons.family_restroom : Icons.medical_services,
                        color: primaryColor,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${permission["contact"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${permission["type"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                      decoration: BoxDecoration(
                        color: permission["status"] == "Active" ? successColor.withAlpha(20) : disabledColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${permission["status"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: permission["status"] == "Active" ? successColor : disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "Permissions:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: (permission["permissions"] as List).map((perm) => Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "$perm",
                      style: TextStyle(
                        fontSize: 10,
                        color: infoColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )).toList(),
                ),
                SizedBox(height: spSm),
                Text(
                  "Last Access: ${permission["lastAccess"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Edit",
                        size: bs.sm,
                        onPressed: () {
                          // Edit permission
                        },
                      ),
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: QButton(
                        label: "Revoke",
                        size: bs.sm,
                        onPressed: () async {
                          bool isConfirmed = await confirm("Revoke access for ${permission["contact"]}?");
                          if (isConfirmed) {
                            sw("Access revoked");
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildAuditTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Privacy Audit Log",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          ...auditLog.map((log) => Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _getActionColor(log["action"] as String).withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    _getActionIcon(log["action"] as String),
                    color: _getActionColor(log["action"] as String),
                    size: 20,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${log["action"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "By: ${log["entity"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${log["details"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${log["timestamp"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${log["dataType"]}",
                    style: TextStyle(
                      fontSize: 10,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildSwitchRow(String title, bool value, Function(bool) onChanged) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: primaryColor,
            ),
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Color _getActionColor(String action) {
    switch (action) {
      case "Data Access":
        return infoColor;
      case "Privacy Setting Changed":
        return warningColor;
      case "Data Export":
        return successColor;
      default:
        return primaryColor;
    }
  }

  IconData _getActionIcon(String action) {
    switch (action) {
      case "Data Access":
        return Icons.visibility;
      case "Privacy Setting Changed":
        return Icons.settings;
      case "Data Export":
        return Icons.download;
      default:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Privacy Controls",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "General", icon: Icon(Icons.security)),
        Tab(text: "Data Controls", icon: Icon(Icons.data_usage)),
        Tab(text: "Sharing", icon: Icon(Icons.share)),
        Tab(text: "Audit Log", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        _buildGeneralPrivacyTab(),
        _buildDataControlsTab(),
        _buildSharingTab(),
        _buildAuditTab(),
      ],
    );
  }
}
