import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaCertificationsView extends StatefulWidget {
  const AmaCertificationsView({super.key});

  @override
  State<AmaCertificationsView> createState() => _AmaCertificationsViewState();
}

class _AmaCertificationsViewState extends State<AmaCertificationsView> {
  List certifications = [
    {
      "id": 1,
      "title": "Organic Farming Certification",
      "issuer": "Organic Certification Board",
      "type": "Professional",
      "status": "Active",
      "issue_date": "2023-06-15",
      "expiry_date": "2025-06-15",
      "certificate_number": "ORG-2023-001234",
      "validity_period": "2 years",
      "requirements": ["Soil health assessment", "Pest management training", "Record keeping"],
      "benefits": ["Premium pricing", "Market access", "Consumer trust"],
      "renewal_cost": 250.0,
      "color": successColor,
      "icon": Icons.eco,
      "progress": 85,
    },
    {
      "id": 2,
      "title": "Integrated Pest Management",
      "issuer": "Agricultural Extension Service",
      "type": "Technical",
      "status": "Pending Renewal",
      "issue_date": "2022-03-10",
      "expiry_date": "2024-03-10",
      "certificate_number": "IPM-2022-005678",
      "validity_period": "2 years",
      "requirements": ["IPM training course", "Field demonstration", "Practical assessment"],
      "benefits": ["Reduced pesticide use", "Cost savings", "Environmental protection"],
      "renewal_cost": 150.0,
      "color": warningColor,
      "icon": Icons.bug_report,
      "progress": 30,
    },
    {
      "id": 3,
      "title": "Sustainable Agriculture Practices",
      "issuer": "Environmental Protection Agency",
      "type": "Environmental",
      "status": "Expired",
      "issue_date": "2021-09-20",
      "expiry_date": "2023-09-20",
      "certificate_number": "SAP-2021-009876",
      "validity_period": "2 years",
      "requirements": ["Sustainability workshop", "Carbon footprint assessment", "Water conservation plan"],
      "benefits": ["Tax incentives", "Grant eligibility", "Brand enhancement"],
      "renewal_cost": 300.0,
      "color": dangerColor,
      "icon": Icons.nature,
      "progress": 0,
    },
    {
      "id": 4,
      "title": "Food Safety Certification",
      "issuer": "Food Safety Authority",
      "type": "Safety",
      "status": "Active",
      "issue_date": "2023-11-05",
      "expiry_date": "2024-11-05",
      "certificate_number": "FSA-2023-112233",
      "validity_period": "1 year",
      "requirements": ["HACCP training", "Facility inspection", "Documentation review"],
      "benefits": ["Export certification", "Consumer confidence", "Compliance assurance"],
      "renewal_cost": 200.0,
      "color": primaryColor,
      "icon": Icons.health_and_safety,
      "progress": 95,
    },
    {
      "id": 5,
      "title": "Water Management Certification",
      "issuer": "Water Resources Department",
      "type": "Resource",
      "status": "In Progress",
      "issue_date": null,
      "expiry_date": null,
      "certificate_number": null,
      "validity_period": "3 years",
      "requirements": ["Water audit", "Irrigation efficiency test", "Conservation plan"],
      "benefits": ["Water subsidies", "Drought resilience", "Reduced costs"],
      "renewal_cost": 180.0,
      "color": infoColor,
      "icon": Icons.water_drop,
      "progress": 60,
    },
    {
      "id": 6,
      "title": "Soil Health Certification",
      "issuer": "Soil Conservation Service",
      "type": "Environmental",
      "status": "Active",
      "issue_date": "2023-08-12",
      "expiry_date": "2026-08-12",
      "certificate_number": "SHC-2023-445566",
      "validity_period": "3 years",
      "requirements": ["Soil testing", "Erosion control plan", "Nutrient management"],
      "benefits": ["Improved yields", "Long-term sustainability", "Cost efficiency"],
      "renewal_cost": 220.0,
      "color": secondaryColor,
      "icon": Icons.landscape,
      "progress": 100,
    },
  ];

  String selectedType = "All";
  String selectedStatus = "All";
  List<String> types = ["All", "Professional", "Technical", "Environmental", "Safety", "Resource"];
  List<String> statuses = ["All", "Active", "Pending Renewal", "Expired", "In Progress"];

  @override
  Widget build(BuildContext context) {
    List filteredCertifications = certifications.where((cert) {
      bool typeMatch = selectedType == "All" || cert["type"] == selectedType;
      bool statusMatch = selectedStatus == "All" || cert["status"] == selectedStatus;
      return typeMatch && statusMatch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Certifications"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Apply for new certification
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Certification Overview
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.verified,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Certification Status",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
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
                              "${certifications.where((c) => c["status"] == "Active").length}",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Active Certs",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${certifications.where((c) => c["status"] == "Pending Renewal").length}",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Need Renewal",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${certifications.where((c) => c["status"] == "In Progress").length}",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "In Progress",
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
            
            SizedBox(height: spLg),
            
            // Quick Actions
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Apply New Cert",
                    icon: Icons.add_circle,
                    size: bs.sm,
                    onPressed: () {
                      // Apply for new certification
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Renewal Alerts",
                    icon: Icons.notification_important,
                    size: bs.sm,
                    onPressed: () {
                      // Show renewal alerts
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Type",
                    items: types.map((type) => {
                      "label": type,
                      "value": type,
                    }).toList(),
                    value: selectedType,
                    onChanged: (value, label) {
                      selectedType = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Status",
                    items: statuses.map((status) => {
                      "label": status,
                      "value": status,
                    }).toList(),
                    value: selectedStatus,
                    onChanged: (value, label) {
                      selectedStatus = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Certifications List
            Text(
              "My Certifications (${filteredCertifications.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredCertifications.length,
              itemBuilder: (context, index) {
                final cert = filteredCertifications[index];
                
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: cert["color"] as Color,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: (cert["color"] as Color).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                cert["icon"] as IconData,
                                color: cert["color"] as Color,
                                size: 24,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${cert["title"]}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${cert["issuer"]}",
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
                                color: _getStatusColor(cert["status"]).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${cert["status"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: _getStatusColor(cert["status"]),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: spSm),
                        
                        // Progress Bar (for In Progress certifications)
                        if (cert["status"] == "In Progress") ...[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Progress",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${cert["progress"]}%",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: cert["color"] as Color,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              LinearProgressIndicator(
                                value: (cert["progress"] as int) / 100,
                                backgroundColor: disabledColor,
                                valueColor: AlwaysStoppedAnimation(cert["color"] as Color),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                        ],
                        
                        // Certificate Details
                        if (cert["certificate_number"] != null) ...[
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: disabledColor.withAlpha(50),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.confirmation_number,
                                      size: 16,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "Certificate #: ${cert["certificate_number"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.calendar_today,
                                            size: 14,
                                            color: disabledBoldColor,
                                          ),
                                          SizedBox(width: spXs),
                                          Text(
                                            "Issued: ${cert["issue_date"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.event,
                                            size: 14,
                                            color: disabledBoldColor,
                                          ),
                                          SizedBox(width: spXs),
                                          Text(
                                            "Expires: ${cert["expiry_date"]}",
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
                              ],
                            ),
                          ),
                          SizedBox(height: spSm),
                        ],
                        
                        // Requirements
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Requirements:",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            ...(cert["requirements"] as List).map((req) => 
                              Padding(
                                padding: EdgeInsets.only(bottom: spXs),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      size: 16,
                                      color: successColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Expanded(
                                      child: Text(
                                        "$req",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: spSm),
                        
                        // Benefits
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Benefits:",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            ...(cert["benefits"] as List).map((benefit) => 
                              Padding(
                                padding: EdgeInsets.only(bottom: spXs),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 16,
                                      color: warningColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Expanded(
                                      child: Text(
                                        "$benefit",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: spSm),
                        
                        // Renewal Cost
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.monetization_on,
                                size: 16,
                                color: warningColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Renewal Cost: \$${(cert["renewal_cost"] as double).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: warningColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        SizedBox(height: spSm),
                        
                        // Actions
                        Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: cert["status"] == "Expired" ? "Renew" : "View Details",
                                size: bs.sm,
                                onPressed: () {
                                  // View details or renew
                                },
                              ),
                            ),
                            if (cert["certificate_number"] != null) ...[
                              SizedBox(width: spSm),
                              QButton(
                                label: "Download",
                                icon: Icons.download,
                                size: bs.sm,
                                onPressed: () {
                                  // Download certificate
                                },
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Pending Renewal":
        return warningColor;
      case "Expired":
        return dangerColor;
      case "In Progress":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }
}
