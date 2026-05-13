import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaQualityControlView extends StatefulWidget {
  const AmaQualityControlView({super.key});

  @override
  State<AmaQualityControlView> createState() => _AmaQualityControlViewState();
}

class _AmaQualityControlViewState extends State<AmaQualityControlView> {
  String selectedCategory = "All";
  String selectedStatus = "All";
  String selectedPriority = "All";
  
  List<Map<String, dynamic>> qualityChecks = [
    {
      "id": "QC001",
      "productName": "Organic Wheat",
      "batchNumber": "OW-2024-001",
      "category": "Grains",
      "checkDate": "2024-03-15",
      "inspector": "Sarah Wilson",
      "status": "Passed",
      "priority": "High",
      "overallScore": 95,
      "parameters": {
        "moisture": {"value": 12.5, "standard": "≤13%", "status": "Pass"},
        "protein": {"value": 14.2, "standard": "≥13%", "status": "Pass"},
        "purity": {"value": 98.5, "standard": "≥98%", "status": "Pass"},
        "germination": {"value": 92, "standard": "≥90%", "status": "Pass"},
        "foreign_matter": {"value": 0.8, "standard": "≤1%", "status": "Pass"},
      },
      "notes": "Excellent quality batch meeting all organic standards",
      "nextCheck": "2024-03-22",
      "certifications": ["Organic", "Non-GMO"],
      "defects": [],
    },
    {
      "id": "QC002",
      "productName": "NPK Fertilizer",
      "batchNumber": "NPK-2024-002",
      "category": "Fertilizers",
      "checkDate": "2024-03-14",
      "inspector": "Mike Chen",
      "status": "Failed",
      "priority": "Critical",
      "overallScore": 72,
      "parameters": {
        "nitrogen": {"value": 18.5, "standard": "20±1%", "status": "Fail"},
        "phosphorus": {"value": 19.8, "standard": "20±1%", "status": "Pass"},
        "potassium": {"value": 20.2, "standard": "20±1%", "status": "Pass"},
        "moisture": {"value": 2.1, "standard": "≤2%", "status": "Fail"},
        "granule_size": {"value": 3.2, "standard": "2-4mm", "status": "Pass"},
      },
      "notes": "Nitrogen content below specification, moisture level too high",
      "nextCheck": "2024-03-16",
      "certifications": [],
      "defects": ["Low nitrogen content", "Excess moisture"],
    },
    {
      "id": "QC003",
      "productName": "Pesticide Solution",
      "batchNumber": "PS-2024-003",
      "category": "Chemicals",
      "checkDate": "2024-03-13",
      "inspector": "Jennifer Lee",
      "status": "Under Review",
      "priority": "Medium",
      "overallScore": 88,
      "parameters": {
        "active_ingredient": {"value": 24.8, "standard": "25±0.5%", "status": "Borderline"},
        "ph_level": {"value": 7.2, "standard": "6.5-7.5", "status": "Pass"},
        "viscosity": {"value": 45, "standard": "40-50 cP", "status": "Pass"},
        "stability": {"value": 95, "standard": "≥90%", "status": "Pass"},
        "impurities": {"value": 0.3, "standard": "≤0.5%", "status": "Pass"},
      },
      "notes": "Active ingredient slightly below target, requires further testing",
      "nextCheck": "2024-03-17",
      "certifications": ["EPA Approved"],
      "defects": ["Active ingredient borderline"],
    },
    {
      "id": "QC004",
      "productName": "Fresh Tomatoes",
      "batchNumber": "FT-2024-004",
      "category": "Produce",
      "checkDate": "2024-03-16",
      "inspector": "David Brown",
      "status": "Passed",
      "priority": "High",
      "overallScore": 92,
      "parameters": {
        "brix_level": {"value": 4.8, "standard": "≥4.5", "status": "Pass"},
        "firmness": {"value": 8.5, "standard": "7-10", "status": "Pass"},
        "color": {"value": 9, "standard": "7-10", "status": "Pass"},
        "size_uniformity": {"value": 85, "standard": "≥80%", "status": "Pass"},
        "defect_rate": {"value": 2, "standard": "≤5%", "status": "Pass"},
      },
      "notes": "Premium quality tomatoes suitable for export",
      "nextCheck": "2024-03-18",
      "certifications": ["Export Grade", "Pesticide Free"],
      "defects": [],
    },
    {
      "id": "QC005",
      "productName": "Corn Seeds",
      "batchNumber": "CS-2024-005",
      "category": "Seeds",
      "checkDate": "2024-03-12",
      "inspector": "Lisa Garcia",
      "status": "Passed",
      "priority": "Medium",
      "overallScore": 89,
      "parameters": {
        "germination": {"value": 88, "standard": "≥85%", "status": "Pass"},
        "purity": {"value": 99.2, "standard": "≥99%", "status": "Pass"},
        "moisture": {"value": 10.5, "standard": "≤12%", "status": "Pass"},
        "vigor": {"value": 82, "standard": "≥80%", "status": "Pass"},
        "foreign_seeds": {"value": 0.1, "standard": "≤0.2%", "status": "Pass"},
      },
      "notes": "Good quality seeds meeting industry standards",
      "nextCheck": "2024-03-19",
      "certifications": ["Certified Seeds"],
      "defects": [],
    },
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All", "value": "All"},
    {"label": "Grains", "value": "Grains"},
    {"label": "Seeds", "value": "Seeds"},
    {"label": "Fertilizers", "value": "Fertilizers"},
    {"label": "Chemicals", "value": "Chemicals"},
    {"label": "Produce", "value": "Produce"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Passed", "value": "Passed"},
    {"label": "Failed", "value": "Failed"},
    {"label": "Under Review", "value": "Under Review"},
  ];

  List<Map<String, dynamic>> priorityOptions = [
    {"label": "All", "value": "All"},
    {"label": "Critical", "value": "Critical"},
    {"label": "High", "value": "High"},
    {"label": "Medium", "value": "Medium"},
    {"label": "Low", "value": "Low"},
  ];

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'passed':
        return successColor;
      case 'failed':
        return dangerColor;
      case 'under review':
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'critical':
        return dangerColor;
      case 'high':
        return warningColor;
      case 'medium':
        return infoColor;
      case 'low':
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getParameterStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pass':
        return successColor;
      case 'fail':
        return dangerColor;
      case 'borderline':
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getScoreColor(int score) {
    if (score >= 90) return successColor;
    if (score >= 80) return warningColor;
    return dangerColor;
  }

  List<Map<String, dynamic>> get filteredChecks {
    return qualityChecks.where((check) {
      bool matchesCategory = selectedCategory == "All" || "${check["category"]}" == selectedCategory;
      bool matchesStatus = selectedStatus == "All" || "${check["status"]}" == selectedStatus;
      bool matchesPriority = selectedPriority == "All" || "${check["priority"]}" == selectedPriority;
      
      return matchesCategory && matchesStatus && matchesPriority;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    // Calculate summary stats
    int passedCount = filteredChecks.where((check) => "${check["status"]}" == "Passed").length;
    int failedCount = filteredChecks.where((check) => "${check["status"]}" == "Failed").length;
    int reviewCount = filteredChecks.where((check) => "${check["status"]}" == "Under Review").length;
    double avgScore = filteredChecks.isEmpty ? 0 : 
                     filteredChecks.fold(0.0, (sum, check) => sum + (check["overallScore"] as int)) / filteredChecks.length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Quality Control"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Add new quality check
            },
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              // Quality analytics
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Summary Cards
            Row(
              children: [
                Expanded(
                  child: Container(
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
                            Icon(
                              Icons.check_circle,
                              color: successColor,
                              size: 20,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Passed",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "$passedCount",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.cancel,
                              color: dangerColor,
                              size: 20,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Failed",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "$failedCount",
                          style: TextStyle(
                            fontSize: fsH4,
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

            // Average Score and Review Count
            Row(
              children: [
                Expanded(
                  child: Container(
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
                            Icon(
                              Icons.analytics,
                              color: primaryColor,
                              size: 20,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Avg Score",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${avgScore.toInt()}%",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: _getScoreColor(avgScore.toInt()),
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.pending,
                              color: warningColor,
                              size: 20,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Under Review",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "$reviewCount",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Filters
            Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Category",
                        items: categoryOptions,
                        value: selectedCategory,
                        onChanged: (value, label) {
                          selectedCategory = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Status",
                        items: statusOptions,
                        value: selectedStatus,
                        onChanged: (value, label) {
                          selectedStatus = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Priority",
                        items: priorityOptions,
                        value: selectedPriority,
                        onChanged: (value, label) {
                          selectedPriority = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Reset Filters",
                        size: bs.sm,
                        onPressed: () {
                          selectedCategory = "All";
                          selectedStatus = "All";
                          selectedPriority = "All";
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // Quality Checks List
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredChecks.length,
              separatorBuilder: (context, index) => SizedBox(height: spMd),
              itemBuilder: (context, index) {
                final check = filteredChecks[index];
                final parameters = check["parameters"] as Map;
                final certifications = check["certifications"] as List;
                final defects = check["defects"] as List;
                
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              width: 4,
                              color: _getStatusColor("${check["status"]}"),
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${check["productName"]}",
                                        style: TextStyle(
                                          fontSize: fsH6,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "Batch: ${check["batchNumber"]} • ID: ${check["id"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spSm,
                                        vertical: spXs,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _getPriorityColor("${check["priority"]}").withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Text(
                                        "${check["priority"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: _getPriorityColor("${check["priority"]}"),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spSm,
                                        vertical: spXs,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _getStatusColor("${check["status"]}").withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Text(
                                        "${check["status"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: _getStatusColor("${check["status"]}"),
                                        ),
                                      ),
                                    ),
                                  ],
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
                                        "Score",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${check["overallScore"]}%",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: _getScoreColor(check["overallScore"] as int),
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
                                        "Inspector",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${check["inspector"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
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
                                        "Check Date",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${check["checkDate"]}",
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
                          ],
                        ),
                      ),

                      // Quality Parameters
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Quality Parameters",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Column(
                              children: parameters.entries.map<Widget>((entry) {
                                final param = entry.value as Map;
                                return Container(
                                  margin: EdgeInsets.only(bottom: spSm),
                                  padding: EdgeInsets.all(spSm),
                                  decoration: BoxDecoration(
                                    color: _getParameterStatusColor("${param["status"]}").withAlpha(10),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                    border: Border.all(
                                      color: _getParameterStatusColor("${param["status"]}").withAlpha(50),
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          "${entry.key}".replaceAll('_', ' ').toUpperCase(),
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "${param["value"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: _getParameterStatusColor("${param["status"]}"),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "${param["standard"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _getParameterStatusColor("${param["status"]}").withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${param["status"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: _getParameterStatusColor("${param["status"]}"),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),

                      // Certifications and Defects
                      if (certifications.isNotEmpty || defects.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (certifications.isNotEmpty) ...[
                                Text(
                                  "Certifications",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Wrap(
                                  spacing: spXs,
                                  runSpacing: spXs,
                                  children: certifications.map<Widget>((cert) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spSm,
                                        vertical: spXs,
                                      ),
                                      decoration: BoxDecoration(
                                        color: successColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Text(
                                        "$cert",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: successColor,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                                SizedBox(height: spSm),
                              ],
                              if (defects.isNotEmpty) ...[
                                Text(
                                  "Defects Found",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: dangerColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Column(
                                  children: defects.map<Widget>((defect) {
                                    return Container(
                                      margin: EdgeInsets.only(bottom: spXs),
                                      padding: EdgeInsets.all(spSm),
                                      decoration: BoxDecoration(
                                        color: dangerColor.withAlpha(10),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                        border: Border.all(
                                          color: dangerColor.withAlpha(50),
                                          width: 1,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.error,
                                            color: dangerColor,
                                            size: 16,
                                          ),
                                          SizedBox(width: spSm),
                                          Expanded(
                                            child: Text(
                                              "$defect",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: dangerColor,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ],
                          ),
                        ),

                      // Notes
                      if ("${check["notes"]}".isNotEmpty)
                        Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Notes",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(5),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  border: Border.all(
                                    color: disabledOutlineBorderColor,
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  "${check["notes"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      // Action Buttons
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: "View Report",
                                size: bs.sm,
                                onPressed: () {
                                  // View detailed report
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QButton(
                                label: "Re-test",
                                size: bs.sm,
                                onPressed: () {
                                  // Schedule re-test
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
