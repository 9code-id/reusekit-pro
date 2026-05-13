import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaSecurityManagementView extends StatefulWidget {
  const FmaSecurityManagementView({super.key});

  @override
  State<FmaSecurityManagementView> createState() => _FmaSecurityManagementViewState();
}

class _FmaSecurityManagementViewState extends State<FmaSecurityManagementView> {
  bool twoFactorEnabled = true;
  bool passwordPolicyEnabled = true;
  bool sessionTimeoutEnabled = true;
  bool ipWhitelistEnabled = false;
  bool auditLoggingEnabled = true;
  String sessionTimeout = "30";
  String passwordMinLength = "8";
  String maxLoginAttempts = "5";
  
  List<Map<String, dynamic>> securityEvents = [
    {
      "id": "sec_001",
      "type": "Login Attempt",
      "user": "admin@company.com",
      "timestamp": "2025-06-19T14:30:00Z",
      "ip": "192.168.1.100",
      "status": "Success",
      "severity": "Info"
    },
    {
      "id": "sec_002",
      "type": "Failed Login",
      "user": "unknown@test.com",
      "timestamp": "2025-06-19T14:25:00Z",
      "ip": "203.0.113.1",
      "status": "Blocked",
      "severity": "Warning"
    },
    {
      "id": "sec_003",
      "type": "Password Change",
      "user": "manager@company.com",
      "timestamp": "2025-06-19T13:45:00Z",
      "ip": "192.168.1.105",
      "status": "Success",
      "severity": "Info"
    },
    {
      "id": "sec_004",
      "type": "Multiple Failed Logins",
      "user": "test@malicious.com",
      "timestamp": "2025-06-19T12:30:00Z",
      "ip": "198.51.100.1",
      "status": "Blocked",
      "severity": "Critical"
    }
  ];

  List<Map<String, dynamic>> timeoutOptions = [
    {"label": "15 Minutes", "value": "15"},
    {"label": "30 Minutes", "value": "30"},
    {"label": "1 Hour", "value": "60"},
    {"label": "2 Hours", "value": "120"}
  ];

  List<Map<String, dynamic>> passwordLengthOptions = [
    {"label": "6 Characters", "value": "6"},
    {"label": "8 Characters", "value": "8"},
    {"label": "10 Characters", "value": "10"},
    {"label": "12 Characters", "value": "12"}
  ];

  List<Map<String, dynamic>> attemptOptions = [
    {"label": "3 Attempts", "value": "3"},
    {"label": "5 Attempts", "value": "5"},
    {"label": "10 Attempts", "value": "10"}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Security Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.security),
            onPressed: () {
              ss("Security scan initiated");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Security Overview Cards
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border(
                        left: BorderSide(
                          width: 3,
                          color: successColor,
                        ),
                      ),
                    ),
                    child: Column(
                      spacing: spXs,
                      children: [
                        Icon(
                          Icons.verified_user,
                          color: successColor,
                          size: 24,
                        ),
                        Text(
                          "Security Score",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "95%",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border(
                        left: BorderSide(
                          width: 3,
                          color: warningColor,
                        ),
                      ),
                    ),
                    child: Column(
                      spacing: spXs,
                      children: [
                        Icon(
                          Icons.warning,
                          color: warningColor,
                          size: 24,
                        ),
                        Text(
                          "Active Threats",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "3",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: dangerColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border(
                        left: BorderSide(
                          width: 3,
                          color: dangerColor,
                        ),
                      ),
                    ),
                    child: Column(
                      spacing: spXs,
                      children: [
                        Icon(
                          Icons.block,
                          color: dangerColor,
                          size: 24,
                        ),
                        Text(
                          "Blocked IPs",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "12",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Security Settings
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Security Settings",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Two-Factor Authentication Required",
                        "value": true,
                        "checked": twoFactorEnabled,
                      }
                    ],
                    value: [
                      if (twoFactorEnabled)
                        {
                          "label": "Two-Factor Authentication Required",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      twoFactorEnabled = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Password Policy Enforcement",
                        "value": true,
                        "checked": passwordPolicyEnabled,
                      }
                    ],
                    value: [
                      if (passwordPolicyEnabled)
                        {
                          "label": "Password Policy Enforcement",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      passwordPolicyEnabled = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QDropdownField(
                    label: "Minimum Password Length",
                    items: passwordLengthOptions,
                    value: passwordMinLength,
                    onChanged: (value, label) {
                      passwordMinLength = value;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Session Timeout",
                        "value": true,
                        "checked": sessionTimeoutEnabled,
                      }
                    ],
                    value: [
                      if (sessionTimeoutEnabled)
                        {
                          "label": "Session Timeout",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      sessionTimeoutEnabled = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QDropdownField(
                    label: "Session Timeout Duration",
                    items: timeoutOptions,
                    value: sessionTimeout,
                    onChanged: (value, label) {
                      sessionTimeout = value;
                      setState(() {});
                    },
                  ),
                  QDropdownField(
                    label: "Max Login Attempts",
                    items: attemptOptions,
                    value: maxLoginAttempts,
                    onChanged: (value, label) {
                      maxLoginAttempts = value;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "IP Whitelist Protection",
                        "value": true,
                        "checked": ipWhitelistEnabled,
                      }
                    ],
                    value: [
                      if (ipWhitelistEnabled)
                        {
                          "label": "IP Whitelist Protection",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      ipWhitelistEnabled = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Audit Logging",
                        "value": true,
                        "checked": auditLoggingEnabled,
                      }
                    ],
                    value: [
                      if (auditLoggingEnabled)
                        {
                          "label": "Audit Logging",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      auditLoggingEnabled = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Action Buttons
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Run Security Scan",
                    onPressed: () {
                      ss("Security scan completed");
                    },
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Export Security Report",
                    onPressed: () {
                      ss("Security report exported");
                    },
                  ),
                ),
              ],
            ),

            // Security Events Log
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Recent Security Events",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "View All",
                        size: bs.sm,
                        onPressed: () {
                          // navigateTo('SecurityEventsListView')
                        },
                      ),
                    ],
                  ),
                  ...securityEvents.map((event) {
                    Color severityColor;
                    switch (event["severity"]) {
                      case "Critical":
                        severityColor = dangerColor;
                        break;
                      case "Warning":
                        severityColor = warningColor;
                        break;
                      default:
                        severityColor = infoColor;
                    }
                    
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: severityColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border(
                          left: BorderSide(
                            width: 3,
                            color: severityColor,
                          ),
                        ),
                      ),
                      child: Column(
                        spacing: spXs,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${event["type"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: severityColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${event["severity"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "User: ${event["user"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "IP: ${event["ip"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "${DateTime.parse(event["timestamp"] as String).dMMMykkss}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
