import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmCertificationManagementView extends StatefulWidget {
  const EcmCertificationManagementView({super.key});

  @override
  State<EcmCertificationManagementView> createState() => _EcmCertificationManagementViewState();
}

class _EcmCertificationManagementViewState extends State<EcmCertificationManagementView> {
  int currentTab = 0;
  
  // Certificate Management
  String certificationName = "";
  String certificationBody = "";
  String certificationLevel = "Associate";
  String certificationStatus = "Active";
  String validityPeriod = "3 years";
  String reminderFrequency = "30 days";
  bool autoRenewal = true;
  bool emailReminders = true;
  
  List<Map<String, dynamic>> certificationLevels = [
    {"label": "Associate", "value": "Associate"},
    {"label": "Professional", "value": "Professional"},
    {"label": "Expert", "value": "Expert"},
    {"label": "Master", "value": "Master"},
  ];
  
  List<Map<String, dynamic>> statusOptions = [
    {"label": "Active", "value": "Active"},
    {"label": "Expired", "value": "Expired"},
    {"label": "Pending Renewal", "value": "Pending Renewal"},
    {"label": "Under Review", "value": "Under Review"},
  ];
  
  List<Map<String, dynamic>> validityOptions = [
    {"label": "1 year", "value": "1 year"},
    {"label": "2 years", "value": "2 years"},
    {"label": "3 years", "value": "3 years"},
    {"label": "5 years", "value": "5 years"},
    {"label": "Lifetime", "value": "Lifetime"},
  ];
  
  List<Map<String, dynamic>> reminderOptions = [
    {"label": "7 days", "value": "7 days"},
    {"label": "14 days", "value": "14 days"},
    {"label": "30 days", "value": "30 days"},
    {"label": "60 days", "value": "60 days"},
    {"label": "90 days", "value": "90 days"},
  ];

  List<Map<String, dynamic>> myCertifications = [
    {
      "id": "cert_001",
      "name": "AWS Solutions Architect",
      "body": "Amazon Web Services",
      "level": "Professional",
      "status": "Active",
      "issueDate": "2023-06-15",
      "expiryDate": "2026-06-15",
      "credentialId": "AWS-SAP-2023-001",
      "progress": 85,
      "cpeRequired": 40,
      "cpeEarned": 34,
    },
    {
      "id": "cert_002",
      "name": "Google Cloud Platform",
      "body": "Google Cloud",
      "level": "Associate",
      "status": "Pending Renewal",
      "issueDate": "2022-03-20",
      "expiryDate": "2024-03-20",
      "credentialId": "GCP-ACE-2022-002",
      "progress": 45,
      "cpeRequired": 30,
      "cpeEarned": 14,
    },
    {
      "id": "cert_003",
      "name": "Microsoft Azure Administrator",
      "body": "Microsoft",
      "level": "Associate",
      "status": "Active",
      "issueDate": "2023-09-10",
      "expiryDate": "2025-09-10",
      "credentialId": "AZ-104-2023-003",
      "progress": 70,
      "cpeRequired": 35,
      "cpeEarned": 25,
    },
  ];

  List<Map<String, dynamic>> certificationBodies = [
    {
      "id": "aws",
      "name": "Amazon Web Services",
      "logo": "https://picsum.photos/60/60?random=1&keyword=aws",
      "totalCerts": 15,
      "activeCerts": 12,
      "status": "Partner",
    },
    {
      "id": "google",
      "name": "Google Cloud",
      "logo": "https://picsum.photos/60/60?random=2&keyword=google",
      "totalCerts": 8,
      "activeCerts": 6,
      "status": "Certified",
    },
    {
      "id": "microsoft",
      "name": "Microsoft",
      "logo": "https://picsum.photos/60/60?random=3&keyword=microsoft",
      "totalCerts": 12,
      "activeCerts": 10,
      "status": "Gold Partner",
    },
    {
      "id": "cisco",
      "name": "Cisco Systems",
      "logo": "https://picsum.photos/60/60?random=4&keyword=cisco",
      "totalCerts": 6,
      "activeCerts": 4,
      "status": "Silver",
    },
  ];

  List<Map<String, dynamic>> renewalAlerts = [
    {
      "id": "alert_001",
      "certification": "Google Cloud Platform",
      "expiryDate": "2024-03-20",
      "daysLeft": 45,
      "priority": "High",
      "action": "Renewal Required",
    },
    {
      "id": "alert_002",
      "certification": "CompTIA Security+",
      "expiryDate": "2024-05-15",
      "daysLeft": 103,
      "priority": "Medium",
      "action": "CPE Credits Needed",
    },
    {
      "id": "alert_003",
      "certification": "Project Management Professional",
      "expiryDate": "2024-08-30",
      "daysLeft": 210,
      "priority": "Low",
      "action": "Documentation Review",
    },
  ];

  void _addCertification() {
    ss("New certification added successfully");
  }

  void _renewCertification(String certId) {
    ss("Certification renewal initiated");
  }

  void _uploadDocument(String certId) {
    ss("Document uploaded successfully");
  }

  void _scheduleExam(String certId) {
    ss("Exam scheduled successfully");
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Expired":
        return dangerColor;
      case "Pending Renewal":
        return warningColor;
      case "Under Review":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildCertificationCard(Map<String, dynamic> cert) {
    return Container(
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
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.verified,
                  color: primaryColor,
                  size: 24,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${cert["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${cert["body"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor("${cert["status"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${cert["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: _getStatusColor("${cert["status"]}"),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Level: ${cert["level"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "ID: ${cert["credentialId"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Expires: ${cert["expiryDate"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "CPE: ${cert["cpeEarned"]}/${cert["cpeRequired"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            height: 4,
            decoration: BoxDecoration(
              color: disabledColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: (cert["progress"] as num) / 100,
              child: Container(
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Renew",
                  size: bs.sm,
                  onPressed: () => _renewCertification("${cert["id"]}"),
                ),
              ),
              SizedBox(width: spXs),
              Expanded(
                child: QButton(
                  label: "Upload",
                  size: bs.sm,
                  onPressed: () => _uploadDocument("${cert["id"]}"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCertificationBodyCard(Map<String, dynamic> body) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusSm),
              image: DecorationImage(
                image: NetworkImage("${body["logo"]}"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "${body["name"]}",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "${body["status"]}",
            style: TextStyle(
              fontSize: 12,
              color: successColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    "${body["activeCerts"]}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Active",
                    style: TextStyle(
                      fontSize: 10,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "${body["totalCerts"]}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Total",
                    style: TextStyle(
                      fontSize: 10,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRenewalAlertCard(Map<String, dynamic> alert) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getPriorityColor("${alert["priority"]}"),
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _getPriorityColor("${alert["priority"]}").withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              Icons.schedule,
              color: _getPriorityColor("${alert["priority"]}"),
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${alert["certification"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${alert["action"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "Expires: ${alert["expiryDate"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: _getPriorityColor("${alert["priority"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${alert["priority"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: _getPriorityColor("${alert["priority"]}"),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "${alert["daysLeft"]} days",
                style: TextStyle(
                  fontSize: 12,
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Certification Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "My Certs", icon: Icon(Icons.verified)),
        Tab(text: "Providers", icon: Icon(Icons.business)),
        Tab(text: "Alerts", icon: Icon(Icons.notifications_active)),
        Tab(text: "Add New", icon: Icon(Icons.add_circle)),
      ],
      tabChildren: [
        // Overview Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.verified,
                            color: Colors.white,
                            size: 32,
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "12",
                            style: TextStyle(
                              fontSize: fsH2,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Active Certifications",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: warningColor,
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.schedule,
                            color: Colors.white,
                            size: 32,
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "3",
                            style: TextStyle(
                              fontSize: fsH2,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Expiring Soon",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: infoColor,
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.school,
                            color: Colors.white,
                            size: 32,
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "156",
                            style: TextStyle(
                              fontSize: fsH2,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "CPE Credits",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: successColor,
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.trending_up,
                            color: Colors.white,
                            size: 32,
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "94%",
                            style: TextStyle(
                              fontSize: fsH2,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Compliance Rate",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              Text(
                "Recent Activity",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: successColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "AWS Solutions Architect renewed successfully",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Text(
                          "2 hours ago",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: infoColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "CPE credits submitted for Google Cloud",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Text(
                          "1 day ago",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: warningColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Microsoft Azure certificate expires in 45 days",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Text(
                          "3 days ago",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        
        // My Certifications Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            children: myCertifications.map((cert) => _buildCertificationCard(cert)).toList(),
          ),
        ),
        
        // Certification Bodies Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: certificationBodies.map((body) => _buildCertificationBodyCard(body)).toList(),
          ),
        ),
        
        // Renewal Alerts Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            children: renewalAlerts.map((alert) => _buildRenewalAlertCard(alert)).toList(),
          ),
        ),
        
        // Add New Certification Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Text(
                "Add New Certification",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              QTextField(
                label: "Certification Name",
                value: certificationName,
                hint: "Enter certification name",
                onChanged: (value) {
                  certificationName = value;
                  setState(() {});
                },
              ),
              QTextField(
                label: "Certification Body",
                value: certificationBody,
                hint: "Enter issuing organization",
                onChanged: (value) {
                  certificationBody = value;
                  setState(() {});
                },
              ),
              QDropdownField(
                label: "Certification Level",
                items: certificationLevels,
                value: certificationLevel,
                onChanged: (value, label) {
                  certificationLevel = value;
                  setState(() {});
                },
              ),
              QDropdownField(
                label: "Current Status",
                items: statusOptions,
                value: certificationStatus,
                onChanged: (value, label) {
                  certificationStatus = value;
                  setState(() {});
                },
              ),
              QDropdownField(
                label: "Validity Period",
                items: validityOptions,
                value: validityPeriod,
                onChanged: (value, label) {
                  validityPeriod = value;
                  setState(() {});
                },
              ),
              QDropdownField(
                label: "Reminder Frequency",
                items: reminderOptions,
                value: reminderFrequency,
                onChanged: (value, label) {
                  reminderFrequency = value;
                  setState(() {});
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: QSwitch(
                      items: [
                        {
                          "label": "Auto Renewal",
                          "value": true,
                          "checked": autoRenewal,
                        }
                      ],
                      value: [
                        if (autoRenewal)
                          {
                            "label": "Auto Renewal",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        autoRenewal = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: QSwitch(
                      items: [
                        {
                          "label": "Email Reminders",
                          "value": true,
                          "checked": emailReminders,
                        }
                      ],
                      value: [
                        if (emailReminders)
                          {
                            "label": "Email Reminders",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        emailReminders = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Add Certification",
                  onPressed: _addCertification,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
