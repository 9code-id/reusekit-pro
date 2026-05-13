import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaRiskAssessmentView extends StatefulWidget {
  const MhaRiskAssessmentView({super.key});

  @override
  State<MhaRiskAssessmentView> createState() => _MhaRiskAssessmentViewState();
}

class _MhaRiskAssessmentViewState extends State<MhaRiskAssessmentView> {
  String selectedRiskType = "";
  Map<String, dynamic> assessmentResults = {};

  List<Map<String, dynamic>> riskTypes = [
    {
      "id": "cardiovascular",
      "title": "Cardiovascular Risk",
      "description": "Assess your risk for heart disease and stroke",
      "duration": "5-8 minutes",
      "factors": ["Age", "Blood Pressure", "Cholesterol", "Smoking", "Family History"],
      "icon": Icons.favorite,
      "color": 0xFFE91E63,
      "riskLevels": ["Low", "Moderate", "High", "Very High"],
    },
    {
      "id": "diabetes",
      "title": "Diabetes Risk",
      "description": "Evaluate your risk of developing type 2 diabetes",
      "duration": "4-6 minutes",
      "factors": ["BMI", "Age", "Physical Activity", "Family History", "Blood Sugar"],
      "icon": Icons.water_drop,
      "color": 0xFF2196F3,
      "riskLevels": ["Low", "Moderate", "High"],
    },
    {
      "id": "cancer",
      "title": "Cancer Risk",
      "description": "General cancer risk assessment based on lifestyle",
      "duration": "6-10 minutes",
      "factors": ["Age", "Smoking", "Diet", "Exercise", "Environmental Exposure"],
      "icon": Icons.healing,
      "color": 0xFF9C27B0,
      "riskLevels": ["Average", "Above Average", "High"],
    },
    {
      "id": "mental_health",
      "title": "Mental Health Risk",
      "description": "Assess risk factors for depression and anxiety",
      "duration": "8-12 minutes",
      "factors": ["Stress", "Sleep", "Social Support", "Life Events", "Family History"],
      "icon": Icons.psychology,
      "color": 0xFFFF9800,
      "riskLevels": ["Low", "Moderate", "High"],
    },
    {
      "id": "osteoporosis",
      "title": "Osteoporosis Risk",
      "description": "Evaluate your bone health and fracture risk",
      "duration": "3-5 minutes",
      "factors": ["Age", "Gender", "Calcium Intake", "Exercise", "Family History"],
      "icon": Icons.accessibility,
      "color": 0xFF607D8B,
      "riskLevels": ["Low", "Moderate", "High"],
    },
    {
      "id": "stroke",
      "title": "Stroke Risk",
      "description": "Assess your risk factors for stroke",
      "duration": "4-7 minutes",
      "factors": ["Blood Pressure", "Atrial Fibrillation", "Smoking", "Diabetes", "Age"],
      "icon": Icons.medical_services,
      "color": 0xFFFF5722,
      "riskLevels": ["Low", "Moderate", "High", "Very High"],
    },
  ];

  List<Map<String, dynamic>> previousAssessments = [
    {
      "id": 1,
      "type": "cardiovascular",
      "title": "Cardiovascular Risk",
      "date": "2024-05-15",
      "riskLevel": "Moderate",
      "score": 65,
      "recommendations": 3,
      "color": 0xFFE91E63,
    },
    {
      "id": 2,
      "type": "diabetes",
      "title": "Diabetes Risk",
      "date": "2024-04-20",
      "riskLevel": "Low",
      "score": 25,
      "recommendations": 2,
      "color": 0xFF2196F3,
    },
    {
      "id": 3,
      "type": "mental_health",
      "title": "Mental Health Risk",
      "date": "2024-03-10",
      "riskLevel": "High",
      "score": 78,
      "recommendations": 5,
      "color": 0xFFFF9800,
    },
  ];

  @override
  Widget build(BuildContext context) {
    if (selectedRiskType.isNotEmpty) {
      return _buildAssessmentView();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Risk Assessment"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              _showAssessmentHistory();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Header Info
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.warning_amber,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Health Risk Assessment",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Identify potential health risks and get personalized recommendations for prevention",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            // Quick Stats
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 150,
              children: [
                _buildStatCard(
                  "Total Assessments",
                  "${previousAssessments.length}",
                  Icons.assessment,
                  primaryColor,
                ),
                _buildStatCard(
                  "Low Risk",
                  "${previousAssessments.where((a) => a["riskLevel"] == "Low").length}",
                  Icons.check_circle,
                  successColor,
                ),
                _buildStatCard(
                  "Moderate Risk",
                  "${previousAssessments.where((a) => a["riskLevel"] == "Moderate").length}",
                  Icons.warning,
                  warningColor,
                ),
                _buildStatCard(
                  "High Risk",
                  "${previousAssessments.where((a) => a["riskLevel"] == "High").length}",
                  Icons.error,
                  dangerColor,
                ),
              ],
            ),

            // Available Assessments
            Text(
              "Available Risk Assessments",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...riskTypes.map((riskType) => _buildRiskTypeCard(riskType)),

            // Recent Assessments
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recent Assessments",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _showAssessmentHistory();
                  },
                  child: Text(
                    "View All",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            ...previousAssessments.take(3).map((assessment) => _buildAssessmentHistoryCard(assessment)),

            // Important Information
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Important Disclaimer",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "• Risk assessments are estimates based on known risk factors\n• Results do not guarantee you will or will not develop a condition\n• Always consult healthcare professionals for proper evaluation\n• Regular health screenings are recommended regardless of risk level",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
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

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRiskTypeCard(Map<String, dynamic> riskType) {
    return GestureDetector(
      onTap: () {
        selectedRiskType = riskType["id"];
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
          border: Border.all(color: disabledOutlineBorderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Color(riskType["color"] as int).withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Icon(
                    riskType["icon"] as IconData,
                    color: Color(riskType["color"] as int),
                    size: 32,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Text(
                        "${riskType["title"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${riskType["description"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            color: disabledBoldColor,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${riskType["duration"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: disabledBoldColor,
                  size: 16,
                ),
              ],
            ),

            // Risk Factors
            Wrap(
              spacing: spXs,
              runSpacing: spXs,
              children: (riskType["factors"] as List<String>).map((factor) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: Color(riskType["color"] as int).withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusLg),
                    border: Border.all(
                      color: Color(riskType["color"] as int).withAlpha(30),
                    ),
                  ),
                  child: Text(
                    factor,
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(riskType["color"] as int),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAssessmentHistoryCard(Map<String, dynamic> assessment) {
    Color riskColor = successColor;
    IconData riskIcon = Icons.check_circle;

    switch (assessment["riskLevel"]) {
      case "Low":
        riskColor = successColor;
        riskIcon = Icons.check_circle;
        break;
      case "Moderate":
        riskColor = warningColor;
        riskIcon = Icons.warning;
        break;
      case "High":
        riskColor = dangerColor;
        riskIcon = Icons.error;
        break;
      case "Very High":
        riskColor = dangerColor;
        riskIcon = Icons.dangerous;
        break;
    }

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: riskColor,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Color(assessment["color"] as int).withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              _getRiskTypeIcon(assessment["type"]),
              color: Color(assessment["color"] as int),
              size: 24,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "${assessment["title"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Completed on ${(DateTime.parse(assessment["date"] as String)).dMMMy}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: riskColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            riskIcon,
                            color: riskColor,
                            size: 12,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${assessment["riskLevel"]} Risk",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: riskColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Score: ${assessment["score"]}",
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
          QButton(
            icon: Icons.arrow_forward,
            size: bs.sm,
            onPressed: () {
              _viewAssessmentResults(assessment);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAssessmentView() {
    Map<String, dynamic> riskType = riskTypes.firstWhere((type) => type["id"] == selectedRiskType);

    return Scaffold(
      appBar: AppBar(
        title: Text("${riskType["title"]}"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            selectedRiskType = "";
            setState(() {});
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Assessment Info
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Color(riskType["color"] as int).withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: Color(riskType["color"] as int).withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        riskType["icon"] as IconData,
                        color: Color(riskType["color"] as int),
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "${riskType["title"]} Assessment",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: Color(riskType["color"] as int),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${riskType["description"]}",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: disabledBoldColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Estimated time: ${riskType["duration"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Risk Factors
            Text(
              "Assessment Factors",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "This assessment will evaluate:",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  ...(riskType["factors"] as List<String>).map((factor) {
                    return Row(
                      children: [
                        Icon(
                          Icons.check,
                          color: successColor,
                          size: 16,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          factor,
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),

            // Risk Levels
            Text(
              "Possible Risk Levels",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
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
                children: (riskType["riskLevels"] as List<String>).map((level) {
                  Color levelColor = _getRiskLevelColor(level);
                  IconData levelIcon = _getRiskLevelIcon(level);

                  return Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: levelColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Icon(
                        levelIcon,
                        color: levelColor,
                        size: 16,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "$level Risk",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: levelColor,
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),

            // Start Assessment Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Start ${riskType["title"]} Assessment",
                icon: Icons.play_arrow,
                size: bs.md,
                onPressed: () {
                  _startAssessment(riskType);
                },
              ),
            ),

            // Disclaimer
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: warningColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.warning_amber,
                        color: warningColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Medical Disclaimer",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "This assessment is for educational purposes only and does not replace professional medical advice. Please consult your healthcare provider for proper diagnosis and treatment.",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
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

  void _showAssessmentHistory() {
    // Show assessment history modal or navigate to history page
  }

  void _viewAssessmentResults(Map<String, dynamic> assessment) {
    // Navigate to detailed assessment results
  }

  void _startAssessment(Map<String, dynamic> riskType) {
    // Navigate to assessment questions
    ss("Starting ${riskType["title"]} assessment...");
  }

  IconData _getRiskTypeIcon(String type) {
    switch (type) {
      case "cardiovascular":
        return Icons.favorite;
      case "diabetes":
        return Icons.water_drop;
      case "cancer":
        return Icons.healing;
      case "mental_health":
        return Icons.psychology;
      case "osteoporosis":
        return Icons.accessibility;
      case "stroke":
        return Icons.medical_services;
      default:
        return Icons.assessment;
    }
  }

  Color _getRiskLevelColor(String level) {
    switch (level.toLowerCase()) {
      case "low":
      case "average":
        return successColor;
      case "moderate":
      case "above average":
        return warningColor;
      case "high":
      case "very high":
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  IconData _getRiskLevelIcon(String level) {
    switch (level.toLowerCase()) {
      case "low":
      case "average":
        return Icons.check_circle;
      case "moderate":
      case "above average":
        return Icons.warning;
      case "high":
      case "very high":
        return Icons.error;
      default:
        return Icons.info;
    }
  }
}
