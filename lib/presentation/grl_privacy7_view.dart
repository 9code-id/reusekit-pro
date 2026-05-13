import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlPrivacy7View extends StatefulWidget {
  @override
  State<GrlPrivacy7View> createState() => _GrlPrivacy7ViewState();
}

class _GrlPrivacy7ViewState extends State<GrlPrivacy7View> {
  String selectedCompliance = "";
  bool consentManagementEnabled = true;
  bool cookieTrackingEnabled = false;
  bool dataMinimizationEnabled = true;
  bool rightToErasureEnabled = true;
  bool dataPortabilityEnabled = true;
  bool privacyByDesignEnabled = true;
  
  List<Map<String, dynamic>> complianceFrameworks = [
    {"label": "GDPR - European Union", "value": "gdpr"},
    {"label": "CCPA - California", "value": "ccpa"},
    {"label": "PIPEDA - Canada", "value": "pipeda"},
    {"label": "LGPD - Brazil", "value": "lgpd"},
    {"label": "PDPA - Singapore", "value": "pdpa"},
    {"label": "Multiple Jurisdictions", "value": "multiple"},
  ];

  List<Map<String, dynamic>> complianceFeatures = [
    {
      "title": "Consent Management",
      "description": "Granular consent controls and withdrawal mechanisms",
      "icon": Icons.handshake,
      "enabled": true,
      "required": ["GDPR", "CCPA", "LGPD"],
      "status": "compliant",
    },
    {
      "title": "Cookie Tracking Controls",
      "description": "Cookie consent banners and tracking preferences",
      "icon": Icons.cookie,
      "enabled": false,
      "required": ["GDPR", "CCPA"],
      "status": "needs_attention",
    },
    {
      "title": "Data Minimization",
      "description": "Collect only necessary data for specified purposes",
      "icon": Icons.minimize,
      "enabled": true,
      "required": ["GDPR", "PIPEDA", "LGPD"],
      "status": "compliant",
    },
    {
      "title": "Right to Erasure",
      "description": "Allow users to request data deletion",
      "icon": Icons.delete_forever,
      "enabled": true,
      "required": ["GDPR", "CCPA", "LGPD"],
      "status": "compliant",
    },
    {
      "title": "Data Portability",
      "description": "Enable data export in machine-readable format",
      "icon": Icons.import_export,
      "enabled": true,
      "required": ["GDPR", "CCPA"],
      "status": "compliant",
    },
    {
      "title": "Privacy by Design",
      "description": "Built-in privacy protections from development start",
      "icon": Icons.security,
      "enabled": true,
      "required": ["GDPR", "PIPEDA"],
      "status": "compliant",
    },
  ];

  List<Map<String, dynamic>> complianceStatus = [
    {
      "framework": "GDPR",
      "fullName": "General Data Protection Regulation",
      "region": "European Union",
      "compliance": 85,
      "lastAudit": DateTime.now().subtract(Duration(days: 30)),
      "nextAudit": DateTime.now().add(Duration(days: 90)),
      "status": "mostly_compliant",
      "criticalIssues": 2,
      "minorIssues": 5,
    },
    {
      "framework": "CCPA",
      "fullName": "California Consumer Privacy Act",
      "region": "California, USA",
      "compliance": 92,
      "lastAudit": DateTime.now().subtract(Duration(days: 45)),
      "nextAudit": DateTime.now().add(Duration(days: 75)),
      "status": "compliant",
      "criticalIssues": 0,
      "minorIssues": 3,
    },
    {
      "framework": "PIPEDA",
      "fullName": "Personal Information Protection and Electronic Documents Act",
      "region": "Canada",
      "compliance": 78,
      "lastAudit": DateTime.now().subtract(Duration(days: 60)),
      "nextAudit": DateTime.now().add(Duration(days: 60)),
      "status": "needs_improvement",
      "criticalIssues": 1,
      "minorIssues": 8,
    },
  ];

  Color getComplianceColor(double compliance) {
    if (compliance >= 90) return successColor;
    if (compliance >= 75) return warningColor;
    return dangerColor;
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'compliant':
        return successColor;
      case 'mostly_compliant':
        return warningColor;
      case 'needs_improvement':
      case 'needs_attention':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy Compliance"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    primaryColor,
                    primaryColor.withAlpha(180),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(40),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.verified,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Privacy Compliance Dashboard",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Monitor and manage regulatory compliance",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Compliance Framework Selection
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.gavel,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Compliance Framework",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  
                  Text(
                    "Select your primary privacy regulation jurisdiction",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  
                  QDropdownField(
                    label: "Primary Framework",
                    items: complianceFrameworks,
                    value: selectedCompliance,
                    onChanged: (value, label) {
                      selectedCompliance = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            
            // Compliance Status Overview
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.assessment,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Compliance Status",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  
                  ...complianceStatus.map((status) {
                    double compliance = (status["compliance"] as num).toDouble();
                    Color complianceColor = getComplianceColor(compliance);
                    Color statusColor = getStatusColor(status["status"]);
                    DateTime lastAudit = status["lastAudit"] as DateTime;
                    DateTime nextAudit = status["nextAudit"] as DateTime;
                    
                    return Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        border: Border.all(color: complianceColor.withAlpha(60)),
                        borderRadius: BorderRadius.circular(radiusSm),
                        color: complianceColor.withAlpha(10),
                      ),
                      child: Column(
                        spacing: spSm,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: complianceColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${status["framework"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: complianceColor,
                                  ),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${status["fullName"]}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "${status["region"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: statusColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${compliance.toInt()}%",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: statusColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          
                          // Progress Bar
                          Container(
                            width: double.infinity,
                            height: 8,
                            decoration: BoxDecoration(
                              color: disabledColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: compliance / 100,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: complianceColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                              ),
                            ),
                          ),
                          
                          // Issues Summary
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.error,
                                      size: 16,
                                      color: dangerColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${status["criticalIssues"]} Critical",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: dangerColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.warning,
                                      size: 16,
                                      color: warningColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${status["minorIssues"]} Minor",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: warningColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          
                          // Audit Information
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: disabledColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Last Audit",
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "${lastAudit.dMMMy}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 1,
                                  height: 20,
                                  color: disabledColor,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Next Audit",
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "${nextAudit.dMMMy}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
            
            // Compliance Features
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.checklist,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Compliance Features",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  
                  Text(
                    "Enable or disable privacy compliance features",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  
                  ...complianceFeatures.map((feature) {
                    bool isEnabled = feature["enabled"] as bool;
                    Color statusColor = getStatusColor(feature["status"]);
                    List<String> requiredFrameworks = feature["required"] as List<String>;
                    
                    return Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isEnabled 
                              ? statusColor.withAlpha(60) 
                              : disabledColor,
                        ),
                        borderRadius: BorderRadius.circular(radiusSm),
                        color: isEnabled 
                            ? statusColor.withAlpha(10) 
                            : disabledColor.withAlpha(10),
                      ),
                      child: Column(
                        spacing: spSm,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: isEnabled 
                                      ? statusColor.withAlpha(20) 
                                      : disabledColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  feature["icon"] as IconData,
                                  color: isEnabled ? statusColor : disabledBoldColor,
                                  size: 20,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${feature["title"]}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Switch(
                                    value: isEnabled,
                                    onChanged: (value) {
                                      // Update the feature status based on title
                                      switch (feature["title"]) {
                                        case "Consent Management":
                                          consentManagementEnabled = value;
                                          break;
                                        case "Cookie Tracking Controls":
                                          cookieTrackingEnabled = value;
                                          break;
                                        case "Data Minimization":
                                          dataMinimizationEnabled = value;
                                          break;
                                        case "Right to Erasure":
                                          rightToErasureEnabled = value;
                                          break;
                                        case "Data Portability":  
                                          dataPortabilityEnabled = value;
                                          break;
                                        case "Privacy by Design":
                                          privacyByDesignEnabled = value;
                                          break;
                                      }
                                      setState(() {});
                                    },
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: statusColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${feature["status"]}".replaceAll("_", " "),
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: statusColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          
                          // Required Frameworks
                          if (requiredFrameworks.isNotEmpty)
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: infoColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Column(
                                spacing: spXs,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Required by:",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: infoColor,
                                    ),
                                  ),
                                  Wrap(
                                    spacing: spXs,
                                    children: requiredFrameworks.map((framework) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spSm,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: infoColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          framework,
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: infoColor,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    );
                  }).toList(),
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
                    label: "Save Compliance Settings",
                    size: bs.md,
                    onPressed: () {
                      ss("Privacy compliance settings saved successfully");
                    },
                  ),
                ),
                
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Generate Compliance Report",
                    size: bs.md,
                    onPressed: () {
                      si("Compliance report generation started. You'll receive it via email.");
                    },
                  ),
                ),
                
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Schedule Audit",
                    size: bs.md,
                    onPressed: () {
                      si("Audit scheduling request submitted");
                    },
                  ),
                ),
              ],
            ),
            
            // Compliance Help
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: warningColor.withAlpha(40),
                ),
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: warningColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Compliance Assistance",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Need help with privacy compliance? Our legal team can provide guidance on implementing the right privacy controls for your jurisdiction.",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.5,
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
