import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaLossPreventionView extends StatefulWidget {
  const AmaLossPreventionView({super.key});

  @override
  State<AmaLossPreventionView> createState() => _AmaLossPreventionViewState();
}

class _AmaLossPreventionViewState extends State<AmaLossPreventionView> {
  String selectedCategory = "All";
  String selectedRiskLevel = "All";
  String selectedTimeframe = "This Month";
  
  List<Map<String, dynamic>> lossReports = [
    {
      "id": "LP001",
      "type": "Pest Damage",
      "category": "Crops",
      "product": "Tomato Harvest",
      "estimatedLoss": 15000.00,
      "actualLoss": 12500.00,
      "quantity": "2.5 tons",
      "riskLevel": "High",
      "reportDate": "2024-03-15",
      "location": "Field A-Section 3",
      "cause": "Aphid infestation",
      "prevention": [
        "Increase monitoring frequency",
        "Apply organic pesticide",
        "Install pest traps",
        "Introduce beneficial insects"
      ],
      "status": "Active",
      "inspector": "Maria Santos",
      "weatherFactor": "High humidity contributing factor",
      "timeline": "Detected on March 10, escalated March 12",
      "mitigation": "Applied emergency treatment, 70% crop saved",
    },
    {
      "id": "LP002",
      "type": "Storage Loss",
      "category": "Inventory",
      "product": "Wheat Seeds",
      "estimatedLoss": 8500.00,
      "actualLoss": 8500.00,
      "quantity": "340 kg",
      "riskLevel": "Medium",
      "reportDate": "2024-03-14",
      "location": "Warehouse B",
      "cause": "Moisture damage",
      "prevention": [
        "Improve ventilation system",
        "Install humidity monitors",
        "Regular moisture checks",
        "Better storage containers"
      ],
      "status": "Resolved",
      "inspector": "John Miller",
      "weatherFactor": "Extended rainy season",
      "timeline": "Damage discovered March 12, assessment March 13",
      "mitigation": "Isolated affected batches, improved storage conditions",
    },
    {
      "id": "LP003",
      "type": "Equipment Failure",
      "category": "Machinery",
      "product": "Irrigation System",
      "estimatedLoss": 25000.00,
      "actualLoss": 18000.00,
      "quantity": "50 hectares affected",
      "riskLevel": "Critical",
      "reportDate": "2024-03-13",
      "location": "Irrigation Zone 2",
      "cause": "Pump motor failure",
      "prevention": [
        "Implement preventive maintenance",
        "Install backup pumps",
        "Real-time monitoring system",
        "Emergency response protocol"
      ],
      "status": "Under Investigation",
      "inspector": "David Chen",
      "weatherFactor": "No weather impact",
      "timeline": "Failure occurred March 11, temporary fix March 12",
      "mitigation": "Emergency pump installed, partial irrigation restored",
    },
    {
      "id": "LP004",
      "type": "Weather Damage",
      "category": "Crops",
      "product": "Corn Plantation",
      "estimatedLoss": 35000.00,
      "actualLoss": 28000.00,
      "quantity": "8 hectares",
      "riskLevel": "Critical",
      "reportDate": "2024-03-12",
      "location": "North Field",
      "cause": "Severe hailstorm",
      "prevention": [
        "Install hail nets",
        "Weather monitoring system",
        "Crop insurance coverage",
        "Early warning alerts"
      ],
      "status": "Resolved",
      "inspector": "Sarah Wilson",
      "weatherFactor": "Unexpected severe weather event",
      "timeline": "Storm occurred March 10, assessment completed March 11",
      "mitigation": "Emergency harvest of undamaged crops, replanting scheduled",
    },
    {
      "id": "LP005",
      "type": "Quality Degradation",
      "category": "Produce",
      "product": "Fresh Vegetables",
      "estimatedLoss": 6500.00,
      "actualLoss": 6500.00,
      "quantity": "1.2 tons",
      "riskLevel": "Medium",
      "reportDate": "2024-03-11",
      "location": "Cold Storage Unit 1",
      "cause": "Temperature fluctuation",
      "prevention": [
        "Backup cooling system",
        "Temperature monitoring",
        "Regular maintenance",
        "Quality check protocols"
      ],
      "status": "Active",
      "inspector": "Lisa Garcia",
      "weatherFactor": "Power outage during heat wave",
      "timeline": "Temperature spike detected March 9, product degraded March 10",
      "mitigation": "Immediate sale of partially affected produce at reduced price",
    },
  ];

  List<Map<String, dynamic>> preventionStrategies = [
    {
      "category": "Pest Management",
      "strategies": [
        "Integrated Pest Management (IPM)",
        "Biological control agents",
        "Crop rotation scheduling",
        "Monitoring trap networks",
      ],
      "effectiveness": 85,
      "cost": "Low to Medium",
      "implementation": "Ongoing",
    },
    {
      "category": "Weather Protection",
      "strategies": [
        "Greenhouse cultivation",
        "Protective covering systems",
        "Weather forecasting tools",
        "Diversified planting schedule",
      ],
      "effectiveness": 78,
      "cost": "Medium to High",
      "implementation": "Seasonal",
    },
    {
      "category": "Storage Optimization",
      "strategies": [
        "Climate-controlled storage",
        "Proper packaging methods",
        "FIFO inventory management",
        "Regular quality assessments",
      ],
      "effectiveness": 92,
      "cost": "Medium",
      "implementation": "Continuous",
    },
    {
      "category": "Equipment Maintenance",
      "strategies": [
        "Preventive maintenance schedules",
        "Equipment redundancy",
        "Real-time monitoring systems",
        "Staff training programs",
      ],
      "effectiveness": 88,
      "cost": "Medium",
      "implementation": "Scheduled",
    },
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All", "value": "All"},
    {"label": "Crops", "value": "Crops"},
    {"label": "Inventory", "value": "Inventory"},
    {"label": "Machinery", "value": "Machinery"},
    {"label": "Produce", "value": "Produce"},
  ];

  List<Map<String, dynamic>> riskLevelOptions = [
    {"label": "All", "value": "All"},
    {"label": "Critical", "value": "Critical"},
    {"label": "High", "value": "High"},
    {"label": "Medium", "value": "Medium"},
    {"label": "Low", "value": "Low"},
  ];

  List<Map<String, dynamic>> timeframeOptions = [
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "Last 3 Months", "value": "Last 3 Months"},
    {"label": "This Year", "value": "This Year"},
  ];

  Color _getRiskLevelColor(String riskLevel) {
    switch (riskLevel.toLowerCase()) {
      case 'critical':
        return dangerColor;
      case 'high':
        return warningColor;
      case 'medium':
        return infoColor;
      case 'low':
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'resolved':
        return successColor;
      case 'active':
        return warningColor;
      case 'under investigation':
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getEffectivenessColor(int effectiveness) {
    if (effectiveness >= 90) return successColor;
    if (effectiveness >= 80) return infoColor;
    if (effectiveness >= 70) return warningColor;
    return dangerColor;
  }

  List<Map<String, dynamic>> get filteredReports {
    return lossReports.where((report) {
      bool matchesCategory = selectedCategory == "All" || "${report["category"]}" == selectedCategory;
      bool matchesRiskLevel = selectedRiskLevel == "All" || "${report["riskLevel"]}" == selectedRiskLevel;
      
      return matchesCategory && matchesRiskLevel;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    // Calculate summary stats
    double totalEstimatedLoss = filteredReports.fold(0.0, (sum, report) => sum + (report["estimatedLoss"] as double));
    double totalActualLoss = filteredReports.fold(0.0, (sum, report) => sum + (report["actualLoss"] as double));
    double preventionSavings = totalEstimatedLoss - totalActualLoss;
    int activeIncidents = filteredReports.where((report) => "${report["status"]}" == "Active").length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Loss Prevention"),
        actions: [
          IconButton(
            icon: Icon(Icons.add_alert),
            onPressed: () {
              // Add new loss report
            },
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              // Loss analytics
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
                              Icons.trending_down,
                              color: dangerColor,
                              size: 20,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Total Loss",
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
                          "\$${totalActualLoss.currency}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
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
                              Icons.savings,
                              color: successColor,
                              size: 20,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Prevented",
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
                          "\$${preventionSavings.currency}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Active Incidents and Prevention Rate
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
                              Icons.warning,
                              color: warningColor,
                              size: 20,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Active Incidents",
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
                          "$activeIncidents",
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
                              Icons.shield,
                              color: primaryColor,
                              size: 20,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Prevention Rate",
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
                          "${totalEstimatedLoss > 0 ? ((preventionSavings / totalEstimatedLoss) * 100).toInt() : 0}%",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
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
                        label: "Risk Level",
                        items: riskLevelOptions,
                        value: selectedRiskLevel,
                        onChanged: (value, label) {
                          selectedRiskLevel = value;
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
                        label: "Timeframe",
                        items: timeframeOptions,
                        value: selectedTimeframe,
                        onChanged: (value, label) {
                          selectedTimeframe = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Generate Report",
                        size: bs.sm,
                        onPressed: () {
                          // Generate loss prevention report
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // Prevention Strategies Overview
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spSm),
                    child: Text(
                      "Prevention Strategies",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  Divider(height: 1),
                  Column(
                    children: preventionStrategies.map<Widget>((strategy) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${strategy["category"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getEffectivenessColor(strategy["effectiveness"] as int).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${strategy["effectiveness"]}% Effective",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: _getEffectivenessColor(strategy["effectiveness"] as int),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Column(
                              children: (strategy["strategies"] as List).map<Widget>((item) {
                                return Container(
                                  margin: EdgeInsets.only(bottom: spXs),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.check_circle,
                                        color: successColor,
                                        size: 16,
                                      ),
                                      SizedBox(width: spSm),
                                      Expanded(
                                        child: Text(
                                          "$item",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Cost: ${strategy["cost"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                                Text(
                                  "Status: ${strategy["implementation"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                            if (preventionStrategies.indexOf(strategy) < preventionStrategies.length - 1)
                              Divider(height: spMd),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Loss Reports List
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredReports.length,
              separatorBuilder: (context, index) => SizedBox(height: spMd),
              itemBuilder: (context, index) {
                final report = filteredReports[index];
                final prevention = report["prevention"] as List;
                
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
                              color: _getRiskLevelColor("${report["riskLevel"]}"),
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
                                        "${report["type"]} - ${report["product"]}",
                                        style: TextStyle(
                                          fontSize: fsH6,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "ID: ${report["id"]} • ${report["location"]}",
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
                                        color: _getRiskLevelColor("${report["riskLevel"]}").withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Text(
                                        "${report["riskLevel"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: _getRiskLevelColor("${report["riskLevel"]}"),
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
                                        color: _getStatusColor("${report["status"]}").withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Text(
                                        "${report["status"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: _getStatusColor("${report["status"]}"),
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
                                        "Estimated Loss",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "\$${(report["estimatedLoss"] as double).currency}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: warningColor,
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
                                        "Actual Loss",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "\$${(report["actualLoss"] as double).currency}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: dangerColor,
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
                                        "Quantity",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${report["quantity"]}",
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

                      // Cause and Details
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Cause: ${report["cause"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Inspector: ${report["inspector"]} • Date: ${report["reportDate"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            if ("${report["weatherFactor"]}".isNotEmpty) ...[
                              SizedBox(height: spXs),
                              Text(
                                "Weather Factor: ${report["weatherFactor"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),

                      // Prevention Measures
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Prevention Measures",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Column(
                              children: prevention.map<Widget>((measure) {
                                return Container(
                                  margin: EdgeInsets.only(bottom: spXs),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.lightbulb,
                                        color: infoColor,
                                        size: 16,
                                      ),
                                      SizedBox(width: spSm),
                                      Expanded(
                                        child: Text(
                                          "$measure",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
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

                      // Timeline and Mitigation
                      if ("${report["timeline"]}".isNotEmpty || "${report["mitigation"]}".isNotEmpty)
                        Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if ("${report["timeline"]}".isNotEmpty) ...[
                                Text(
                                  "Timeline",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${report["timeline"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(height: spSm),
                              ],
                              if ("${report["mitigation"]}".isNotEmpty) ...[
                                Text(
                                  "Mitigation Action",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                ),
                                Text(
                                  "${report["mitigation"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
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
                                label: "View Details",
                                size: bs.sm,
                                onPressed: () {
                                  // View detailed report
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: QButton(
                                label: "Update Status",
                                size: bs.sm,
                                onPressed: () {
                                  // Update incident status
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
