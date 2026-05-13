import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaPlantHealthView extends StatefulWidget {
  const AmaPlantHealthView({super.key});

  @override
  State<AmaPlantHealthView> createState() => _AmaPlantHealthViewState();
}

class _AmaPlantHealthViewState extends State<AmaPlantHealthView> {
  String selectedField = "Main Field A";
  String assessmentPeriod = "Last 7 Days";
  String healthFilter = "All";
  
  List<Map<String, dynamic>> fieldOptions = [
    {"label": "Main Field A", "value": "Main Field A"},
    {"label": "South Pasture", "value": "South Pasture"},
    {"label": "East Garden", "value": "East Garden"},
    {"label": "North Field", "value": "North Field"},
    {"label": "West Orchard", "value": "West Orchard"},
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "Last 24 Hours", "value": "Last 24 Hours"},
    {"label": "Last 7 Days", "value": "Last 7 Days"},
    {"label": "Last 30 Days", "value": "Last 30 Days"},
    {"label": "Current Season", "value": "Current Season"},
  ];

  List<Map<String, dynamic>> healthFilterOptions = [
    {"label": "All Plants", "value": "All"},
    {"label": "Healthy", "value": "Healthy"},
    {"label": "Stressed", "value": "Stressed"},
    {"label": "Diseased", "value": "Diseased"},
    {"label": "Pest Damage", "value": "Pest Damage"},
  ];

  Map<String, dynamic> overallHealthData = {
    "totalPlants": 15420,
    "healthyPlants": 13878,
    "stressedPlants": 1234,
    "diseasedPlants": 308,
    "overallScore": 89,
    "lastAssessment": "2 hours ago",
  };

  List<Map<String, dynamic>> healthMetrics = [
    {
      "metric": "Leaf Color Index",
      "current": 8.7,
      "target": 8.5,
      "unit": "/10",
      "status": "Excellent",
      "trend": "up",
      "description": "Deep green coloration indicates good nitrogen uptake",
    },
    {
      "metric": "Plant Height",
      "current": 47,
      "target": 45,
      "unit": "cm",
      "status": "Above Target",
      "trend": "up",
      "description": "Consistent growth pattern observed",
    },
    {
      "metric": "Leaf Density",
      "current": 92,
      "target": 85,
      "unit": "%",
      "status": "Excellent",
      "trend": "stable",
      "description": "Optimal leaf coverage for photosynthesis",
    },
    {
      "metric": "Disease Pressure",
      "current": 2,
      "target": 3,
      "unit": "/10",
      "status": "Low",
      "trend": "down",
      "description": "Minimal disease symptoms detected",
    },
  ];

  List<Map<String, dynamic>> healthIssues = [
    {
      "id": 1,
      "type": "Disease",
      "severity": "Medium",
      "issue": "Leaf Spot",
      "affected": "120 plants",
      "location": "Southeast section",
      "detected": "Yesterday",
      "status": "Under Treatment",
      "treatment": "Fungicide application",
      "image": "https://picsum.photos/80/80?random=10&keyword=plant",
    },
    {
      "id": 2,
      "type": "Pest",
      "severity": "Low",
      "issue": "Aphids",
      "affected": "45 plants",
      "location": "Northwest corner",
      "detected": "2 days ago",
      "status": "Monitoring",
      "treatment": "Natural predators released",
      "image": "https://picsum.photos/80/80?random=11&keyword=insect",
    },
    {
      "id": 3,
      "type": "Nutrient",
      "severity": "Low",
      "issue": "Nitrogen Deficiency",
      "affected": "78 plants",
      "location": "Central area",
      "detected": "3 days ago",
      "status": "Treated",
      "treatment": "Fertilizer application completed",
      "image": "https://picsum.photos/80/80?random=12&keyword=leaf",
    },
  ];

  List<Map<String, dynamic>> treatmentHistory = [
    {
      "date": "2024-06-14",
      "treatment": "Fungicide Spray",
      "area": "Southeast Section",
      "reason": "Leaf spot prevention",
      "result": "Successful",
      "cost": "\$245",
    },
    {
      "date": "2024-06-12",
      "treatment": "Fertilizer Application",
      "area": "Central Area",
      "reason": "Nitrogen deficiency",
      "result": "Successful",
      "cost": "\$180",
    },
    {
      "date": "2024-06-10",
      "treatment": "Pest Control",
      "area": "Northwest Corner",
      "reason": "Aphid infestation",
      "result": "In Progress",
      "cost": "\$95",
    },
  ];

  List<Map<String, dynamic>> healthRecommendations = [
    {
      "priority": "High",
      "action": "Apply Preventive Fungicide",
      "reason": "High humidity forecast increases disease risk",
      "timeframe": "Within 24 hours",
      "cost": "Low",
    },
    {
      "priority": "Medium",
      "action": "Increase Irrigation Frequency",
      "reason": "Soil moisture below optimal in east section",
      "timeframe": "This week",
      "cost": "Medium",
    },
    {
      "priority": "Low",
      "action": "Scout for Early Pest Signs",
      "reason": "Seasonal pest activity typically increases",
      "timeframe": "Ongoing",
      "cost": "Low",
    },
  ];

  Color getSeverityColor(String severity) {
    switch (severity.toLowerCase()) {
      case 'high':
        return dangerColor;
      case 'medium':
        return warningColor;
      case 'low':
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'excellent':
      case 'above target':
      case 'treated':
      case 'successful':
        return successColor;
      case 'good':
      case 'under treatment':
      case 'in progress':
        return primaryColor;
      case 'fair':
      case 'monitoring':
        return warningColor;
      case 'poor':
      case 'critical':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return dangerColor;
      case 'medium':
        return warningColor;
      case 'low':
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Icon getTrendIcon(String trend) {
    switch (trend.toLowerCase()) {
      case 'up':
        return Icon(Icons.trending_up, color: successColor, size: 16);
      case 'down':
        return Icon(Icons.trending_down, color: dangerColor, size: 16);
      case 'stable':
        return Icon(Icons.trending_flat, color: disabledBoldColor, size: 16);
      default:
        return Icon(Icons.help_outline, color: disabledBoldColor, size: 16);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Plant Health"),
        actions: [
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () {
              si("Take health assessment photos");
            },
          ),
          IconButton(
            icon: Icon(Icons.medical_services),
            onPressed: () {
              si("Add treatment record");
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
            // Field Selection and Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Select Field",
                    items: fieldOptions,
                    value: selectedField,
                    onChanged: (value, label) {
                      selectedField = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Period",
                    items: periodOptions,
                    value: assessmentPeriod,
                    onChanged: (value, label) {
                      assessmentPeriod = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            QCategoryPicker(
              label: "Health Status Filter",
              items: healthFilterOptions,
              value: healthFilter,
              onChanged: (index, label, value, item) {
                healthFilter = value;
                setState(() {});
              },
            ),

            // Overall Health Score
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [successColor, successColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Overall Plant Health",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${selectedField}",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "Last assessment: ${overallHealthData["lastAssessment"]}",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${overallHealthData["overallScore"]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fsH2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Health Score",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: _buildHealthStat(
                          "${((overallHealthData["healthyPlants"] as int) / (overallHealthData["totalPlants"] as int) * 100).toInt()}%",
                          "Healthy Plants",
                        ),
                      ),
                      Expanded(
                        child: _buildHealthStat(
                          "${overallHealthData["stressedPlants"]}",
                          "Stressed",
                        ),
                      ),
                      Expanded(
                        child: _buildHealthStat(
                          "${overallHealthData["diseasedPlants"]}",
                          "Diseased",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Health Metrics
            Text(
              "Health Metrics",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: healthMetrics.map((metric) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${metric["metric"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          getTrendIcon(metric["trend"]),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${metric["current"]}",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: getStatusColor(metric["status"]),
                            ),
                          ),
                          Text(
                            "${metric["unit"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Target: ${metric["target"]}${metric["unit"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: getStatusColor(metric["status"]).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${metric["status"]}",
                          style: TextStyle(
                            color: getStatusColor(metric["status"]),
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${metric["description"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Health Issues
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Current Health Issues",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QButton(
                  label: "Report Issue",
                  size: bs.sm,
                  onPressed: () {
                    si("Open issue reporting form");
                  },
                ),
              ],
            ),

            if (healthIssues.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: successColor.withAlpha(50)),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: successColor,
                      size: 48,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No Health Issues Detected",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "All plants appear to be in good health",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              )
            else
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: List.generate(healthIssues.length, (index) {
                    final issue = healthIssues[index];
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        border: index > 0 ? Border(
                          top: BorderSide(
                            color: disabledOutlineBorderColor,
                            width: 1,
                          ),
                        ) : null,
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusSm),
                            child: Image.network(
                              "${issue["image"]}",
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${issue["issue"]}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: getSeverityColor(issue["severity"]).withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${issue["severity"]}",
                                        style: TextStyle(
                                          color: getSeverityColor(issue["severity"]),
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "${issue["type"]} • ${issue["affected"]} affected",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "Location: ${issue["location"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: getStatusColor(issue["status"]).withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${issue["status"]}",
                                        style: TextStyle(
                                          color: getStatusColor(issue["status"]),
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${issue["treatment"]}",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),

            // Health Recommendations
            Text(
              "Health Recommendations",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: List.generate(healthRecommendations.length, (index) {
                  final recommendation = healthRecommendations[index];
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: index > 0 ? Border(
                        top: BorderSide(
                          color: disabledOutlineBorderColor,
                          width: 1,
                        ),
                      ) : null,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: getPriorityColor(recommendation["priority"]),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${recommendation["action"]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "${recommendation["priority"]} Priority",
                                    style: TextStyle(
                                      color: getPriorityColor(recommendation["priority"]),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${recommendation["reason"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Timeline: ${recommendation["timeframe"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 11,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "Cost: ${recommendation["cost"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        QButton(
                          label: "Apply",
                          size: bs.sm,
                          onPressed: () {
                            si("Apply recommendation: ${recommendation["action"]}");
                          },
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),

            // Treatment History
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recent Treatments",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QButton(
                  label: "View All",
                  size: bs.sm,
                  onPressed: () {
                    si("View complete treatment history");
                  },
                ),
              ],
            ),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: List.generate(treatmentHistory.length.clamp(0, 3), (index) {
                  final treatment = treatmentHistory[index];
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: index > 0 ? Border(
                        top: BorderSide(
                          color: disabledOutlineBorderColor,
                          width: 1,
                        ),
                      ) : null,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: getStatusColor(treatment["result"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.medical_services,
                            color: getStatusColor(treatment["result"]),
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${treatment["treatment"]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "${treatment["cost"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${treatment["area"]} • ${treatment["reason"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${treatment["date"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 11,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 1,
                                    ),
                                    decoration: BoxDecoration(
                                      color: getStatusColor(treatment["result"]).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${treatment["result"]}",
                                      style: TextStyle(
                                        color: getStatusColor(treatment["result"]),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHealthStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withAlpha(200),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
