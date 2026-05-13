import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaQualityAssessmentView extends StatefulWidget {
  const AmaQualityAssessmentView({super.key});

  @override
  State<AmaQualityAssessmentView> createState() => _AmaQualityAssessmentViewState();
}

class _AmaQualityAssessmentViewState extends State<AmaQualityAssessmentView> {
  String selectedCrop = "All Crops";
  String selectedGrade = "All Grades";
  String selectedBatch = "All Batches";
  int currentTab = 0;

  List<Map<String, dynamic>> qualityAssessments = [
    {
      "id": "QA001",
      "batchId": "BATCH2024001",
      "cropName": "Wheat",
      "variety": "Winter Wheat",
      "harvestDate": DateTime(2024, 6, 15),
      "assessmentDate": DateTime(2024, 6, 16),
      "quantity": 2500,
      "grade": "Premium A",
      "overallScore": 94,
      "moistureContent": 12.5,
      "proteinContent": 14.2,
      "glutenContent": 32.8,
      "testWeight": 78.5,
      "foreignMatter": 0.8,
      "damagedKernels": 1.2,
      "color": "Golden",
      "odor": "Normal",
      "texture": "Firm",
      "assessor": "Dr. Sarah Johnson",
      "certificationStatus": "Certified",
      "marketValue": 450.0,
      "notes": "Excellent quality wheat, meets premium standards",
      "image": "https://picsum.photos/300/200?random=1&keyword=wheat"
    },
    {
      "id": "QA002",
      "batchId": "BATCH2024002",
      "cropName": "Corn",
      "variety": "Sweet Corn",
      "harvestDate": DateTime(2024, 6, 18),
      "assessmentDate": DateTime(2024, 6, 19),
      "quantity": 3200,
      "grade": "Grade A",
      "overallScore": 88,
      "moistureContent": 15.2,
      "proteinContent": 9.8,
      "starchContent": 72.4,
      "testWeight": 56.2,
      "foreignMatter": 1.5,
      "damagedKernels": 2.1,
      "color": "Bright Yellow",
      "odor": "Sweet",
      "texture": "Crisp",
      "assessor": "Mike Thompson",
      "certificationStatus": "Pending",
      "marketValue": 380.0,
      "notes": "Good quality corn, slight moisture content variation",
      "image": "https://picsum.photos/300/200?random=2&keyword=corn"
    },
    {
      "id": "QA003",
      "batchId": "BATCH2024003",
      "cropName": "Rice",
      "variety": "Basmati",
      "harvestDate": DateTime(2024, 6, 20),
      "assessmentDate": DateTime(2024, 6, 21),
      "quantity": 4500,
      "grade": "Premium A+",
      "overallScore": 96,
      "moistureContent": 14.0,
      "proteinContent": 7.5,
      "amyloseContent": 25.2,
      "testWeight": 82.1,
      "foreignMatter": 0.5,
      "brokenGrains": 3.2,
      "color": "Pearl White",
      "odor": "Aromatic",
      "texture": "Long Grain",
      "assessor": "Dr. Raj Patel",
      "certificationStatus": "Certified",
      "marketValue": 620.0,
      "notes": "Exceptional aromatic rice, export quality",
      "image": "https://picsum.photos/300/200?random=3&keyword=rice"
    },
    {
      "id": "QA004",
      "batchId": "BATCH2024004",
      "cropName": "Soybeans",
      "variety": "Non-GMO",
      "harvestDate": DateTime(2024, 6, 22),
      "assessmentDate": DateTime(2024, 6, 23),
      "quantity": 1800,
      "grade": "Grade B",
      "overallScore": 82,
      "moistureContent": 13.8,
      "proteinContent": 38.5,
      "oilContent": 19.2,
      "testWeight": 58.9,
      "foreignMatter": 2.1,
      "damagedBeans": 3.5,
      "color": "Light Yellow",
      "odor": "Mild",
      "texture": "Round",
      "assessor": "Lisa Chen",
      "certificationStatus": "Re-assessment",
      "marketValue": 340.0,
      "notes": "Minor quality issues, requires sorting for premium grade",
      "image": "https://picsum.photos/300/200?random=4&keyword=soybeans"
    },
    {
      "id": "QA005",
      "batchId": "BATCH2024005",
      "cropName": "Barley",
      "variety": "Malting Barley",
      "harvestDate": DateTime(2024, 6, 25),
      "assessmentDate": DateTime(2024, 6, 26),
      "quantity": 2100,
      "grade": "Malting Grade",
      "overallScore": 91,
      "moistureContent": 12.2,
      "proteinContent": 11.8,
      "extractContent": 82.5,
      "testWeight": 65.4,
      "foreignMatter": 0.9,
      "skinned": 2.8,
      "color": "Pale Gold",
      "odor": "Fresh",
      "texture": "Plump",
      "assessor": "James Wilson",
      "certificationStatus": "Certified",
      "marketValue": 420.0,
      "notes": "Excellent malting potential, brewery grade",
      "image": "https://picsum.photos/300/200?random=5&keyword=barley"
    }
  ];

  List<Map<String, dynamic>> qualityStandards = [
    {
      "parameter": "Moisture Content",
      "wheatMin": 10.0,
      "wheatMax": 14.0,
      "cornMin": 14.0,
      "cornMax": 16.0,
      "riceMin": 12.0,
      "riceMax": 15.0,
      "unit": "%"
    },
    {
      "parameter": "Protein Content",
      "wheatMin": 12.0,
      "wheatMax": 16.0,
      "cornMin": 8.0,
      "cornMax": 12.0,
      "riceMin": 6.0,
      "riceMax": 9.0,
      "unit": "%"
    },
    {
      "parameter": "Foreign Matter",
      "wheatMin": 0.0,
      "wheatMax": 2.0,
      "cornMin": 0.0,
      "cornMax": 3.0,
      "riceMin": 0.0,
      "riceMax": 1.5,
      "unit": "%"
    },
    {
      "parameter": "Test Weight",
      "wheatMin": 75.0,
      "wheatMax": 85.0,
      "cornMin": 54.0,
      "cornMax": 58.0,
      "riceMin": 80.0,
      "riceMax": 85.0,
      "unit": "kg/hl"
    }
  ];

  List<Map<String, dynamic>> recentTests = [
    {
      "batchId": "BATCH2024006",
      "cropName": "Wheat",
      "testDate": DateTime.now().subtract(Duration(hours: 2)),
      "status": "In Progress",
      "assessor": "Dr. Sarah Johnson"
    },
    {
      "batchId": "BATCH2024007",
      "cropName": "Corn",
      "testDate": DateTime.now().subtract(Duration(hours: 5)),
      "status": "Completed",
      "assessor": "Mike Thompson"
    },
    {
      "batchId": "BATCH2024008",
      "cropName": "Rice",
      "testDate": DateTime.now().subtract(Duration(days: 1)),
      "status": "Scheduled",
      "assessor": "Dr. Raj Patel"
    }
  ];

  List<Map<String, dynamic>> cropOptions = [
    {"label": "All Crops", "value": "All Crops"},
    {"label": "Wheat", "value": "Wheat"},
    {"label": "Corn", "value": "Corn"},
    {"label": "Rice", "value": "Rice"},
    {"label": "Soybeans", "value": "Soybeans"},
    {"label": "Barley", "value": "Barley"}
  ];

  List<Map<String, dynamic>> gradeOptions = [
    {"label": "All Grades", "value": "All Grades"},
    {"label": "Premium A+", "value": "Premium A+"},
    {"label": "Premium A", "value": "Premium A"},
    {"label": "Grade A", "value": "Grade A"},
    {"label": "Grade B", "value": "Grade B"},
    {"label": "Malting Grade", "value": "Malting Grade"}
  ];

  List<Map<String, dynamic>> batchOptions = [
    {"label": "All Batches", "value": "All Batches"},
    {"label": "BATCH2024001", "value": "BATCH2024001"},
    {"label": "BATCH2024002", "value": "BATCH2024002"},
    {"label": "BATCH2024003", "value": "BATCH2024003"},
    {"label": "BATCH2024004", "value": "BATCH2024004"},
    {"label": "BATCH2024005", "value": "BATCH2024005"}
  ];

  List<Map<String, dynamic>> get filteredAssessments {
    return qualityAssessments.where((assessment) {
      bool cropMatch = selectedCrop == "All Crops" || assessment["cropName"] == selectedCrop;
      bool gradeMatch = selectedGrade == "All Grades" || assessment["grade"] == selectedGrade;
      bool batchMatch = selectedBatch == "All Batches" || assessment["batchId"] == selectedBatch;
      return cropMatch && gradeMatch && batchMatch;
    }).toList();
  }

  Color _getGradeColor(String grade) {
    if (grade.contains("Premium")) {
      return successColor;
    } else if (grade.contains("Grade A")) {
      return infoColor;
    } else if (grade.contains("Grade B")) {
      return warningColor;
    } else if (grade.contains("Malting")) {
      return primaryColor;
    }
    return disabledBoldColor;
  }

  Color _getScoreColor(int score) {
    if (score >= 90) {
      return successColor;
    } else if (score >= 80) {
      return infoColor;
    } else if (score >= 70) {
      return warningColor;
    }
    return dangerColor;
  }

  Color _getCertificationColor(String status) {
    switch (status) {
      case "Certified":
        return successColor;
      case "Pending":
        return warningColor;
      case "Re-assessment":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getTestStatusColor(String status) {
    switch (status) {
      case "Completed":
        return successColor;
      case "In Progress":
        return infoColor;
      case "Scheduled":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  void _viewDetailedReport(Map<String, dynamic> assessment) {
    ss("Viewing detailed report for ${assessment["batchId"]}");
  }

  void _scheduleRetest(Map<String, dynamic> assessment) {
    ss("Retest scheduled for ${assessment["batchId"]}");
  }

  Widget _buildDashboardTab() {
    int totalAssessments = qualityAssessments.length;
    int certifiedBatches = qualityAssessments.where((a) => a["certificationStatus"] == "Certified").length;
    int pendingAssessments = qualityAssessments.where((a) => a["certificationStatus"] == "Pending").length;
    
    double averageScore = qualityAssessments
        .map((a) => a["overallScore"] as int)
        .fold(0.0, (sum, score) => sum + score.toDouble()) / totalAssessments;

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Summary Cards
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: Container(
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
                        children: [
                          Icon(Icons.assessment, color: primaryColor, size: 24),
                          SizedBox(width: spSm),
                          Text(
                            "Assessments",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "$totalAssessments",
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
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
                        children: [
                          Icon(Icons.verified, color: successColor, size: 24),
                          SizedBox(width: spSm),
                          Text(
                            "Certified",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "$certifiedBatches",
                        style: TextStyle(
                          fontSize: fsH3,
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

          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: Container(
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
                        children: [
                          Icon(Icons.pending_actions, color: warningColor, size: 24),
                          SizedBox(width: spSm),
                          Text(
                            "Pending",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "$pendingAssessments",
                        style: TextStyle(
                          fontSize: fsH3,
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
                        children: [
                          Icon(Icons.stars, color: infoColor, size: 24),
                          SizedBox(width: spSm),
                          Text(
                            "Avg Score",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${averageScore.toStringAsFixed(1)}",
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Recent Tests
          Container(
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
                  children: [
                    Icon(Icons.science, color: primaryColor, size: 24),
                    SizedBox(width: spSm),
                    Text(
                      "Recent Tests",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                ...recentTests.map((test) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    margin: EdgeInsets.only(bottom: spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(5),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${test["batchId"]} - ${test["cropName"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Assessor: ${test["assessor"]}",
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
                            color: _getTestStatusColor(test["status"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${test["status"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: _getTestStatusColor(test["status"]),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),

          // Grade Distribution
          Container(
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
                  children: [
                    Icon(Icons.pie_chart, color: primaryColor, size: 24),
                    SizedBox(width: spSm),
                    Text(
                      "Grade Distribution",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Center(
                    child: Text(
                      "Grade Distribution Chart",
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
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

  Widget _buildAssessmentsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Filters
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Crop",
                  items: cropOptions,
                  value: selectedCrop,
                  onChanged: (value, label) {
                    selectedCrop = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QDropdownField(
                  label: "Grade",
                  items: gradeOptions,
                  value: selectedGrade,
                  onChanged: (value, label) {
                    selectedGrade = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          QDropdownField(
            label: "Batch",
            items: batchOptions,
            value: selectedBatch,
            onChanged: (value, label) {
              selectedBatch = value;
              setState(() {});
            },
          ),

          // Assessment List
          ...filteredAssessments.map((assessment) {
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
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusSm),
                        child: Image.network(
                          "${assessment["image"]}",
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${assessment["cropName"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getGradeColor(assessment["grade"]).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${assessment["grade"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: _getGradeColor(assessment["grade"]),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${assessment["variety"]} • Batch: ${assessment["batchId"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Icon(Icons.calendar_today, size: 16, color: disabledBoldColor),
                                SizedBox(width: spXs),
                                Text(
                                  "Assessed: ${(assessment["assessmentDate"] as DateTime).dMMMy}",
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

                  SizedBox(height: spMd),

                  // Overall Score
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: _getScoreColor(assessment["overallScore"]).withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.stars,
                          color: _getScoreColor(assessment["overallScore"]),
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Overall Score: ${assessment["overallScore"]}/100",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: _getScoreColor(assessment["overallScore"]),
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: _getCertificationColor(assessment["certificationStatus"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${assessment["certificationStatus"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: _getCertificationColor(assessment["certificationStatus"]),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: spMd),

                  // Key Parameters
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Moisture",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${assessment["moistureContent"]}%",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
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
                              "Protein",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${assessment["proteinContent"]}%",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
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
                              "Foreign Matter",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${assessment["foreignMatter"]}%",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: spMd),

                  // Physical Properties
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(5),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Physical Properties",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Color: ${assessment["color"]}",
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "Odor: ${assessment["odor"]}",
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "Texture: ${assessment["texture"]}",
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: spMd),

                  // Market Information
                  Row(
                    children: [
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
                              "${assessment["quantity"]} kg",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
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
                              "Market Value",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "\$${(assessment["marketValue"] as double).currency}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: successColor,
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
                              "Assessor",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${assessment["assessor"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  if (assessment["notes"] != null && (assessment["notes"] as String).isNotEmpty) ...[
                    SizedBox(height: spMd),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.notes, size: 16, color: infoColor),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "${assessment["notes"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: infoColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  SizedBox(height: spMd),

                  // Action Buttons
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QButton(
                          label: "View Report",
                          size: bs.sm,
                          onPressed: () => _viewDetailedReport(assessment),
                        ),
                      ),
                      if (assessment["certificationStatus"] != "Certified") ...[
                        Expanded(
                          child: QButton(
                            label: "Schedule Retest",
                            size: bs.sm,
                            onPressed: () => _scheduleRetest(assessment),
                          ),
                        ),
                      ],
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

  Widget _buildStandardsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Quality Standards Table
          Container(
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
                  children: [
                    Icon(Icons.rule, color: primaryColor, size: 24),
                    SizedBox(width: spSm),
                    Text(
                      "Quality Standards",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                ...qualityStandards.map((standard) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    margin: EdgeInsets.only(bottom: spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(5),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${standard["parameter"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "Wheat",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "${standard["wheatMin"]}-${standard["wheatMax"]} ${standard["unit"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "Corn",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "${standard["cornMin"]}-${standard["cornMax"]} ${standard["unit"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "Rice",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "${standard["riceMin"]}-${standard["riceMax"]} ${standard["unit"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
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
                }).toList(),
              ],
            ),
          ),

          // Grading Criteria
          Container(
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
                  children: [
                    Icon(Icons.grade, color: primaryColor, size: 24),
                    SizedBox(width: spSm),
                    Text(
                      "Grading Criteria",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: successColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Premium Grade (90-100)",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Exceptional quality, export grade, premium pricing",
                              style: TextStyle(
                                fontSize: 12,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: spSm),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: infoColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Grade A (80-89)",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                            Text(
                              "Good quality, meets commercial standards",
                              style: TextStyle(
                                fontSize: 12,
                                color: infoColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: spSm),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: warningColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Grade B (70-79)",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "Fair quality, may require processing",
                              style: TextStyle(
                                fontSize: 12,
                                color: warningColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: spSm),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: dangerColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: dangerColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Below Grade (<70)",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                              ),
                            ),
                            Text(
                              "Poor quality, feed grade or rejection",
                              style: TextStyle(
                                fontSize: 12,
                                color: dangerColor,
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
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Quality Assessment",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Dashboard", icon: Icon(Icons.dashboard)),
        Tab(text: "Assessments", icon: Icon(Icons.assessment)),
        Tab(text: "Standards", icon: Icon(Icons.rule)),
      ],
      tabChildren: [
        _buildDashboardTab(),
        _buildAssessmentsTab(),
        _buildStandardsTab(),
      ],
      onInit: (tabController) {},
    );
  }
}
