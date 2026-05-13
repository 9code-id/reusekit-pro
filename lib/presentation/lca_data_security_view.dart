import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaDataSecurityView extends StatefulWidget {
  const LcaDataSecurityView({super.key});

  @override
  State<LcaDataSecurityView> createState() => _LcaDataSecurityViewState();
}

class _LcaDataSecurityViewState extends State<LcaDataSecurityView> {
  int currentTab = 0;

  final List<Map<String, dynamic>> securityMetrics = [
    {
      "title": "Security Score",
      "value": "98%",
      "icon": Icons.security,
      "color": "#10B981",
      "trend": "+2%",
      "status": "Excellent"
    },
    {
      "title": "Vulnerabilities",
      "value": "3",
      "icon": Icons.warning,
      "color": "#F59E0B",
      "trend": "-5",
      "status": "Low Risk"
    },
    {
      "title": "Compliance Rate",
      "value": "100%",
      "icon": Icons.verified_user,
      "color": "#10B981",
      "trend": "0%",
      "status": "Compliant"
    },
    {
      "title": "Access Violations",
      "value": "0",
      "icon": Icons.shield,
      "color": "#10B981",
      "trend": "-2",
      "status": "Secure"
    }
  ];

  final List<Map<String, dynamic>> securityPolicies = [
    {
      "name": "Data Encryption Policy",
      "status": "Active",
      "compliance": 100,
      "lastUpdated": "2024-06-15",
      "type": "Encryption",
      "priority": "Critical"
    },
    {
      "name": "Access Control Policy",
      "status": "Active",
      "compliance": 98,
      "lastUpdated": "2024-06-14",
      "type": "Access Control",
      "priority": "High"
    },
    {
      "name": "Data Retention Policy",
      "status": "Active",
      "compliance": 95,
      "lastUpdated": "2024-06-13",
      "type": "Data Management",
      "priority": "Medium"
    },
    {
      "name": "Backup Security Policy",
      "status": "Review",
      "compliance": 92,
      "lastUpdated": "2024-06-12",
      "type": "Backup",
      "priority": "High"
    }
  ];

  final List<Map<String, dynamic>> vulnerabilities = [
    {
      "id": "VUL-001",
      "title": "Weak Password Policy",
      "severity": "Medium",
      "status": "In Progress",
      "assigned": "Security Team",
      "dueDate": "2024-06-25",
      "description": "Password requirements need strengthening"
    },
    {
      "id": "VUL-002",
      "title": "Outdated SSL Certificate",
      "severity": "High",
      "status": "Open",
      "assigned": "IT Team",
      "dueDate": "2024-06-20",
      "description": "SSL certificate expiring soon"
    },
    {
      "id": "VUL-003",
      "title": "Excessive User Permissions",
      "severity": "Low",
      "status": "Resolved",
      "assigned": "Admin Team",
      "dueDate": "2024-06-18",
      "description": "Some users have unnecessary permissions"
    }
  ];

  final List<Map<String, dynamic>> securityReports = [
    {
      "title": "Monthly Security Assessment",
      "type": "Assessment",
      "date": "2024-06-15",
      "status": "Completed",
      "findings": 12,
      "score": 98
    },
    {
      "title": "Penetration Test Report",
      "type": "Testing",
      "date": "2024-06-10",
      "status": "In Review",
      "findings": 5,
      "score": 95
    },
    {
      "title": "Compliance Audit Report",
      "type": "Audit",
      "date": "2024-06-05",
      "status": "Approved",
      "findings": 8,
      "score": 92
    },
    {
      "title": "Risk Assessment Report",
      "type": "Risk Analysis",
      "date": "2024-06-01",
      "status": "Completed",
      "findings": 15,
      "score": 88
    }
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Data Security",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Policies", icon: Icon(Icons.policy)),
        Tab(text: "Vulnerabilities", icon: Icon(Icons.bug_report)),
        Tab(text: "Reports", icon: Icon(Icons.assessment)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildPoliciesTab(),
        _buildVulnerabilitiesTab(),
        _buildReportsTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Icon(
                  Icons.security,
                  size: 48,
                  color: Colors.white,
                ),
                Text(
                  "Security Status",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "All systems secure and compliant",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withAlpha(180),
                  ),
                ),
              ],
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: securityMetrics.map((metric) {
              return Container(
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
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: Color(int.parse("0xFF${metric["color"].substring(1)}")),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            metric["icon"],
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: (metric["trend"].toString().contains('+') ? successColor : dangerColor).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${metric["trend"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: metric["trend"].toString().contains('+') ? successColor : dangerColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${metric["title"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${metric["value"]}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${metric["status"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(int.parse("0xFF${metric["color"].substring(1)}")),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
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
                  "Recent Security Events",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...List.generate(4, (index) {
                  final events = [
                    "Failed login attempt blocked - IP: 192.168.1.100",
                    "SSL certificate renewed successfully",
                    "Security policy updated - Data Encryption",
                    "Vulnerability scan completed - 3 issues found"
                  ];
                  final times = ["2 min ago", "1 hour ago", "3 hours ago", "6 hours ago"];
                  
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: index == 0 ? dangerColor : successColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                events[index],
                                style: TextStyle(
                                  fontSize: 14,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                times[index],
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
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPoliciesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search policies...",
                  value: "",
                  onChanged: (value) {},
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "New Policy",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          ...securityPolicies.map((policy) {
            return Container(
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
                      Expanded(
                        child: Text(
                          "${policy["name"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: policy["status"] == "Active" ? successColor.withAlpha(20) : warningColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${policy["status"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: policy["status"] == "Active" ? successColor : warningColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${policy["type"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: policy["priority"] == "Critical" 
                              ? dangerColor.withAlpha(20)
                              : policy["priority"] == "High"
                                  ? warningColor.withAlpha(20)
                                  : infoColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${policy["priority"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: policy["priority"] == "Critical" 
                                ? dangerColor
                                : policy["priority"] == "High"
                                    ? warningColor
                                    : infoColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(5),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      spacing: spXs,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Compliance Rate",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${policy["compliance"]}%",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 4,
                          decoration: BoxDecoration(
                            color: disabledColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: (policy["compliance"] as int) / 100,
                            child: Container(
                              decoration: BoxDecoration(
                                color: successColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Last Updated: ${policy["lastUpdated"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Row(
                        children: [
                          QButton(
                            icon: Icons.edit,
                            size: bs.sm,
                            onPressed: () {},
                          ),
                          SizedBox(width: spXs),
                          QButton(
                            icon: Icons.more_vert,
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildVulnerabilitiesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search vulnerabilities...",
                  value: "",
                  onChanged: (value) {},
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Scan Now",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: dangerColor,
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Icon(
                      Icons.error,
                      size: 32,
                      color: Colors.white,
                    ),
                    Text(
                      "High Risk",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "1",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: warningColor,
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Icon(
                      Icons.warning,
                      size: 32,
                      color: Colors.white,
                    ),
                    Text(
                      "Medium Risk",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "1",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: infoColor,
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Icon(
                      Icons.info,
                      size: 32,
                      color: Colors.white,
                    ),
                    Text(
                      "Low Risk",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "1",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          ...vulnerabilities.map((vulnerability) {
            return Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: vulnerability["severity"] == "High" 
                        ? dangerColor
                        : vulnerability["severity"] == "Medium"
                            ? warningColor
                            : infoColor,
                  ),
                ),
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${vulnerability["id"]} - ${vulnerability["title"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${vulnerability["description"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: vulnerability["severity"] == "High" 
                              ? dangerColor.withAlpha(20)
                              : vulnerability["severity"] == "Medium"
                                  ? warningColor.withAlpha(20)
                                  : infoColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${vulnerability["severity"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: vulnerability["severity"] == "High" 
                                ? dangerColor
                                : vulnerability["severity"] == "Medium"
                                    ? warningColor
                                    : infoColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        size: 16,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Assigned to: ${vulnerability["assigned"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.schedule,
                        size: 16,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Due: ${vulnerability["dueDate"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: vulnerability["status"] == "Resolved" 
                              ? successColor.withAlpha(20)
                              : vulnerability["status"] == "In Progress"
                                  ? warningColor.withAlpha(20)
                                  : dangerColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${vulnerability["status"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: vulnerability["status"] == "Resolved" 
                                ? successColor
                                : vulnerability["status"] == "In Progress"
                                    ? warningColor
                                    : dangerColor,
                          ),
                        ),
                      ),
                      QButton(
                        label: "View Details",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search reports...",
                  value: "",
                  onChanged: (value) {},
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Generate Report",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: securityReports.map((report) {
              return Container(
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
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.description,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: report["status"] == "Completed" || report["status"] == "Approved"
                                ? successColor.withAlpha(20)
                                : warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${report["status"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: report["status"] == "Completed" || report["status"] == "Approved"
                                  ? successColor
                                  : warningColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${report["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${report["type"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        spacing: spXs,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Security Score",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${report["score"]}%",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Findings",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${report["findings"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${report["date"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        QButton(
                          label: "Download",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
