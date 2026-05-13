import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaInspectionReportView extends StatefulWidget {
  const ReaInspectionReportView({super.key});

  @override
  State<ReaInspectionReportView> createState() => _ReaInspectionReportViewState();
}

class _ReaInspectionReportViewState extends State<ReaInspectionReportView> {
  int selectedTab = 0;
  
  Map<String, dynamic> inspectionData = {
    "property": {
      "address": "123 Oak Street, Downtown",
      "type": "Apartment",
      "area": "1,200 sq ft",
      "inspectionDate": "2024-06-10",
      "inspector": "John Smith",
      "licenseNo": "HI-12345",
    },
    "overallRating": "Good",
    "overallScore": 82,
    "totalIssues": 12,
    "criticalIssues": 2,
    "minorIssues": 10,
  };

  List<Map<String, dynamic>> inspectionSections = [
    {
      "category": "Structural",
      "score": 85,
      "status": "Good",
      "issues": 2,
      "icon": Icons.foundation,
      "color": "success",
    },
    {
      "category": "Electrical",
      "score": 78,
      "status": "Fair",
      "issues": 3,
      "icon": Icons.electrical_services,
      "color": "warning",
    },
    {
      "category": "Plumbing",
      "score": 88,
      "status": "Good",
      "issues": 1,
      "icon": Icons.plumbing,
      "color": "success",
    },
    {
      "category": "HVAC",
      "score": 72,
      "status": "Fair",
      "issues": 2,
      "icon": Icons.ac_unit,
      "color": "warning",
    },
    {
      "category": "Roofing",
      "score": 90,
      "status": "Excellent",
      "issues": 0,
      "icon": Icons.roofing,
      "color": "success",
    },
    {
      "category": "Interior",
      "score": 80,
      "status": "Good",
      "issues": 3,
      "icon": Icons.home,
      "color": "primary",
    },
    {
      "category": "Exterior",
      "score": 75,
      "status": "Fair",
      "issues": 1,
      "icon": Icons.landscape,
      "color": "warning",
    },
  ];

  List<Map<String, dynamic>> criticalIssues = [
    {
      "category": "Electrical",
      "issue": "Outdated electrical panel",
      "severity": "High",
      "description": "Main electrical panel is 30+ years old and should be upgraded for safety",
      "estimatedCost": 2500,
      "priority": "Immediate",
      "images": ["electrical_panel.jpg"],
    },
    {
      "category": "Plumbing",
      "issue": "Water pressure issues",
      "severity": "Medium",
      "description": "Low water pressure in master bathroom shower, may indicate pipe blockage",
      "estimatedCost": 800,
      "priority": "Within 30 days",
      "images": ["bathroom_shower.jpg"],
    },
  ];

  List<Map<String, dynamic>> recommendations = [
    {
      "type": "Immediate",
      "title": "Electrical Panel Upgrade",
      "description": "Replace outdated electrical panel to meet current safety standards",
      "cost": 2500,
      "timeframe": "1-2 weeks",
      "contractor": "Licensed Electrician",
    },
    {
      "type": "Short Term",
      "title": "HVAC System Maintenance",
      "description": "Service HVAC system and replace air filters",
      "cost": 300,
      "timeframe": "1 week",
      "contractor": "HVAC Technician",
    },
    {
      "type": "Long Term",
      "title": "Interior Paint Refresh",
      "description": "Repaint common areas and bedrooms for better appearance",
      "cost": 1500,
      "timeframe": "1 month",
      "contractor": "Painting Contractor",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inspection Report"),
        actions: [
          QButton(
            icon: Icons.download,
            size: bs.sm,
            onPressed: () {
              ss("Inspection report downloaded");
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildPropertyInfoCard(),
            _buildOverallRatingCard(),
            _buildTabSection(),
            if (selectedTab == 0) _buildSectionScoresCard(),
            if (selectedTab == 1) _buildCriticalIssuesCard(),
            if (selectedTab == 2) _buildRecommendationsCard(),
            if (selectedTab == 3) _buildInspectorInfoCard(),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildPropertyInfoCard() {
    return Container(
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
          Row(
            children: [
              Icon(
                Icons.home_work,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Property Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: 1,
            color: disabledColor,
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "Address",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${inspectionData["property"]["address"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "Property Type",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${inspectionData["property"]["type"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "Area",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${inspectionData["property"]["area"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "Inspection Date",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${DateTime.parse(inspectionData["property"]["inspectionDate"]).dMMMy}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "Inspector",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${inspectionData["property"]["inspector"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverallRatingCard() {
    Color ratingColor = _getRatingColor(inspectionData["overallRating"]);
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(
                Icons.assessment,
                color: ratingColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Overall Assessment",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spLg),
            decoration: BoxDecoration(
              color: ratingColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(
                color: ratingColor.withValues(alpha: 0.3),
                width: 2,
              ),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Text(
                  "${inspectionData["overallScore"]}/100",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: ratingColor,
                  ),
                ),
                Text(
                  "${inspectionData["overallRating"]} Condition",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: ratingColor,
                  ),
                ),
              ],
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildMetricCard(
                "Total Issues",
                "${inspectionData["totalIssues"]}",
                Icons.warning,
                warningColor,
              ),
              _buildMetricCard(
                "Critical Issues",
                "${inspectionData["criticalIssues"]}",
                Icons.error,
                dangerColor,
              ),
              _buildMetricCard(
                "Minor Issues",
                "${inspectionData["minorIssues"]}",
                Icons.info,
                infoColor,
              ),
              _buildMetricCard(
                "Overall Rating",
                "${inspectionData["overallRating"]}",
                Icons.star,
                ratingColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: disabledColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = 0;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: selectedTab == 0 ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "Sections",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: selectedTab == 0 ? Colors.white : disabledBoldColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = 1;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: selectedTab == 1 ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "Issues",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: selectedTab == 1 ? Colors.white : disabledBoldColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = 2;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: selectedTab == 2 ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "Actions",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: selectedTab == 2 ? Colors.white : disabledBoldColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = 3;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: selectedTab == 3 ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "Inspector",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: selectedTab == 3 ? Colors.white : disabledBoldColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionScoresCard() {
    return Container(
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
            "Section Breakdown",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...inspectionSections.map((section) {
            Color sectionColor = _getSectionColor(section["color"]);
            
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: sectionColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(radiusXs),
                border: Border.all(
                  color: sectionColor.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    section["icon"] as IconData,
                    color: sectionColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${section["category"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${section["score"]}/100",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: sectionColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${section["status"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: sectionColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${section["issues"]} issue${section["issues"] != 1 ? 's' : ''}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 4,
                          decoration: BoxDecoration(
                            color: disabledColor.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: (section["score"] as int) / 100,
                            child: Container(
                              decoration: BoxDecoration(
                                color: sectionColor,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
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
    );
  }

  Widget _buildCriticalIssuesCard() {
    return Container(
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
          Row(
            children: [
              Icon(
                Icons.warning,
                color: dangerColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Critical Issues Found",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...criticalIssues.map((issue) {
            Color severityColor = issue["severity"] == "High" 
                ? dangerColor 
                : issue["severity"] == "Medium" 
                    ? warningColor 
                    : infoColor;
            
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: severityColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(radiusXs),
                border: Border.all(
                  color: severityColor.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "${issue["issue"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: severityColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${issue["severity"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${issue["description"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Est. Cost: \$${(issue["estimatedCost"] as num).currency}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "Priority: ${issue["priority"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: severityColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Category: ${issue["category"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "View Photos",
                        icon: Icons.photo_library,
                        size: bs.sm,
                        onPressed: () {
                          ss("Opening issue photos");
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info,
                  color: infoColor,
                  size: 16,
                ),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "Total estimated repair cost: \$${criticalIssues.fold(0, (sum, issue) => sum + (issue["estimatedCost"] as int)).currency}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationsCard() {
    return Container(
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
          Row(
            children: [
              Icon(
                Icons.recommend,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Recommended Actions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...recommendations.map((rec) {
            Color typeColor = rec["type"] == "Immediate" 
                ? dangerColor 
                : rec["type"] == "Short Term" 
                    ? warningColor 
                    : successColor;
            
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: typeColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(radiusXs),
                border: Border.all(
                  color: typeColor.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: typeColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${rec["type"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        "\$${(rec["cost"] as num).currency}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: typeColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${rec["title"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "${rec["description"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Timeline: ${rec["timeframe"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                      Text(
                        "${rec["contractor"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: typeColor,
                          fontWeight: FontWeight.w600,
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
    );
  }

  Widget _buildInspectorInfoCard() {
    return Container(
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
          Row(
            children: [
              Icon(
                Icons.person,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Inspector Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: disabledColor.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Inspector Name:",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${inspectionData["property"]["inspector"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "License Number:",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${inspectionData["property"]["licenseNo"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Inspection Date:",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${DateTime.parse(inspectionData["property"]["inspectionDate"]).dMMMy}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Certification:",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Certified Professional",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "Inspector Notes:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Property is in good overall condition with some minor maintenance items that should be addressed. The critical electrical panel issue requires immediate attention for safety compliance.",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Contact Inspector",
                  icon: Icons.phone,
                  size: bs.sm,
                  onPressed: () {
                    ss("Calling inspector");
                  },
                ),
              ),
              Expanded(
                child: QButton(
                  label: "View Credentials",
                  icon: Icons.verified,
                  size: bs.sm,
                  onPressed: () {
                    ss("Viewing inspector credentials");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      spacing: spSm,
      children: [
        Expanded(
          child: QButton(
            label: "Schedule Re-inspection",
            icon: Icons.calendar_today,
            size: bs.md,
            onPressed: () {
              ss("Opening re-inspection scheduler");
            },
          ),
        ),
        Expanded(
          child: QButton(
            label: "Find Contractors",
            icon: Icons.construction,
            size: bs.md,
            onPressed: () {
              ss("Opening contractor directory");
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Color _getRatingColor(String rating) {
    switch (rating.toLowerCase()) {
      case "excellent":
        return successColor;
      case "good":
        return primaryColor;
      case "fair":
        return warningColor;
      case "poor":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getSectionColor(String colorType) {
    switch (colorType) {
      case "success":
        return successColor;
      case "warning":
        return warningColor;
      case "danger":
        return dangerColor;
      case "info":
        return infoColor;
      default:
        return primaryColor;
    }
  }
}
