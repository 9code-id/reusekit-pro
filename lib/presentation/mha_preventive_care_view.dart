import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaPreventiveCareView extends StatefulWidget {
  const MhaPreventiveCareView({super.key});

  @override
  State<MhaPreventiveCareView> createState() => _MhaPreventiveCareViewState();
}

class _MhaPreventiveCareViewState extends State<MhaPreventiveCareView> {
  String selectedCategory = "All";
  String selectedAgeGroup = "All";
  bool loading = false;

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Screenings", "value": "Screenings"},
    {"label": "Vaccinations", "value": "Vaccinations"},
    {"label": "Lifestyle", "value": "Lifestyle"},
    {"label": "Nutrition", "value": "Nutrition"},
    {"label": "Exercise", "value": "Exercise"},
    {"label": "Mental Health", "value": "Mental Health"},
  ];

  List<Map<String, dynamic>> ageGroups = [
    {"label": "All", "value": "All"},
    {"label": "Children (0-17)", "value": "Children"},
    {"label": "Adults (18-64)", "value": "Adults"},
    {"label": "Seniors (65+)", "value": "Seniors"},
  ];

  List<Map<String, dynamic>> preventiveCare = [
    {
      "id": "1",
      "title": "Annual Physical Examination",
      "category": "Screenings",
      "ageGroup": "Adults",
      "frequency": "Annually",
      "description": "Comprehensive health assessment to detect and prevent health problems early",
      "importance": "Establishes baseline health metrics and identifies risk factors before symptoms appear",
      "includes": [
        "Vital signs measurement",
        "Blood pressure check",
        "Weight and BMI assessment",
        "Physical examination",
        "Family history review",
        "Medication review"
      ],
      "preparation": [
        "Bring current medications list",
        "Prepare family medical history",
        "List current symptoms or concerns",
        "Wear comfortable, loose clothing"
      ],
      "coverage": "Most insurance plans cover 100%",
      "reminders": "Schedule next appointment before leaving",
      "image": "https://picsum.photos/300/200?random=1&keyword=checkup",
      "priority": "Essential",
      "recommendedBy": ["AMA", "CDC", "USPSTF"],
      "benefits": [
        "Early disease detection",
        "Preventive counseling",
        "Vaccination updates",
        "Health risk assessment"
      ],
    },
    {
      "id": "2",
      "title": "Mammography Screening",
      "category": "Screenings",
      "ageGroup": "Adults",
      "frequency": "Every 1-2 years (age 40-74)",
      "description": "X-ray examination of the breast to detect breast cancer early",
      "importance": "Breast cancer screening can reduce mortality by detecting cancer before symptoms appear",
      "includes": [
        "Bilateral breast imaging",
        "Radiologist interpretation",
        "Follow-up recommendations",
        "Results notification"
      ],
      "preparation": [
        "Schedule for week after menstrual period",
        "Avoid deodorant and lotions",
        "Wear two-piece outfit",
        "Bring previous mammogram results"
      ],
      "coverage": "Covered by most insurance plans",
      "reminders": "Results typically available within 1-2 weeks",
      "image": "https://picsum.photos/300/200?random=2&keyword=mammogram",
      "priority": "Essential",
      "recommendedBy": ["American Cancer Society", "USPSTF"],
      "benefits": [
        "Early cancer detection",
        "Reduced mortality risk",
        "Peace of mind",
        "Treatment options when early"
      ],
    },
    {
      "id": "3",
      "title": "Influenza Vaccination",
      "category": "Vaccinations",
      "ageGroup": "All",
      "frequency": "Annually",
      "description": "Annual vaccine to protect against seasonal influenza viruses",
      "importance": "Prevents serious illness, hospitalization, and death from influenza",
      "includes": [
        "Current year flu vaccine",
        "Pre-vaccination screening",
        "Post-vaccination observation",
        "Vaccination record update"
      ],
      "preparation": [
        "Inform about allergies",
        "Bring vaccination records",
        "Report current illness",
        "Schedule during flu season"
      ],
      "coverage": "Covered by most insurance plans",
      "reminders": "Get vaccinated by October each year",
      "image": "https://picsum.photos/300/200?random=3&keyword=vaccination",
      "priority": "Recommended",
      "recommendedBy": ["CDC", "WHO", "AAP"],
      "benefits": [
        "Flu prevention",
        "Reduced severity if infected",
        "Community immunity",
        "Workplace productivity"
      ],
    },
    {
      "id": "4",
      "title": "Regular Exercise Program",
      "category": "Exercise",
      "ageGroup": "All",
      "frequency": "150 minutes per week",
      "description": "Structured physical activity to maintain health and prevent chronic diseases",
      "importance": "Regular exercise reduces risk of heart disease, diabetes, and mental health issues",
      "includes": [
        "Aerobic activity (walking, swimming)",
        "Strength training (2+ days/week)",
        "Flexibility exercises",
        "Balance training (seniors)"
      ],
      "preparation": [
        "Consult doctor before starting",
        "Start slowly and progress gradually",
        "Choose enjoyable activities",
        "Set realistic goals"
      ],
      "coverage": "Some insurance plans offer fitness benefits",
      "reminders": "Track activity with apps or logs",
      "image": "https://picsum.photos/300/200?random=4&keyword=exercise",
      "priority": "Essential",
      "recommendedBy": ["AHA", "CDC", "WHO"],
      "benefits": [
        "Cardiovascular health",
        "Weight management",
        "Mental health improvement",
        "Bone strength"
      ],
    },
    {
      "id": "5",
      "title": "Healthy Diet Planning",
      "category": "Nutrition",
      "ageGroup": "All",
      "frequency": "Daily",
      "description": "Balanced nutrition plan to prevent chronic diseases and maintain optimal health",
      "importance": "Proper nutrition prevents obesity, diabetes, heart disease, and certain cancers",
      "includes": [
        "5+ servings fruits/vegetables daily",
        "Whole grains over refined",
        "Lean proteins",
        "Limited processed foods"
      ],
      "preparation": [
        "Plan meals in advance",
        "Read nutrition labels",
        "Cook more meals at home",
        "Stay hydrated"
      ],
      "coverage": "Nutrition counseling may be covered",
      "reminders": "Consult registered dietitian if needed",
      "image": "https://picsum.photos/300/200?random=5&keyword=nutrition",
      "priority": "Essential",
      "recommendedBy": ["AHA", "ADA", "USDA"],
      "benefits": [
        "Disease prevention",
        "Energy maintenance",
        "Weight control",
        "Mental clarity"
      ],
    },
    {
      "id": "6",
      "title": "Mental Health Check-ins",
      "category": "Mental Health",
      "ageGroup": "All",
      "frequency": "As needed, minimum annually",
      "description": "Regular assessment of mental and emotional wellbeing",
      "importance": "Early detection and treatment of mental health issues improves outcomes",
      "includes": [
        "Mood assessment",
        "Stress level evaluation",
        "Sleep quality review",
        "Coping strategies discussion"
      ],
      "preparation": [
        "Reflect on recent mood changes",
        "Note stress triggers",
        "Prepare questions or concerns",
        "Consider life changes"
      ],
      "coverage": "Mental health services covered by most plans",
      "reminders": "Seek help if symptoms persist > 2 weeks",
      "image": "https://picsum.photos/300/200?random=6&keyword=mentalhealth",
      "priority": "Important",
      "recommendedBy": ["APA", "NIMH", "WHO"],
      "benefits": [
        "Early intervention",
        "Improved quality of life",
        "Better relationships",
        "Increased productivity"
      ],
    },
  ];

  List<Map<String, dynamic>> get filteredCare {
    List<Map<String, dynamic>> filtered = preventiveCare;

    if (selectedCategory != "All") {
      filtered = filtered.where((care) => care["category"] == selectedCategory).toList();
    }

    if (selectedAgeGroup != "All") {
      filtered = filtered.where((care) => 
          care["ageGroup"] == selectedAgeGroup || care["ageGroup"] == "All").toList();
    }

    return filtered;
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Essential":
        return dangerColor;
      case "Recommended":
        return warningColor;
      case "Important":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildCareCard(Map<String, dynamic> care) {
    Color priorityColor = _getPriorityColor(care["priority"]);

    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Care Image
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radiusLg),
              topRight: Radius.circular(radiusLg),
            ),
            child: Stack(
              children: [
                Image.network(
                  "${care["image"]}",
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: spSm,
                  left: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: priorityColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${care["priority"]}",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: spSm,
                  right: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${care["frequency"]}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category and Age Group
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${care["category"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${care["ageGroup"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: infoColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: spSm),

                // Title
                Text(
                  "${care["title"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),

                SizedBox(height: spXs),

                // Description
                Text(
                  "${care["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    height: 1.4,
                  ),
                ),

                SizedBox(height: spMd),

                // Importance
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.lightbulb,
                            size: 16,
                            color: successColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Why it's important:",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${care["importance"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: spMd),

                // Quick Stats
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.schedule,
                              size: 18,
                              color: primaryColor,
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${care["frequency"]}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "Frequency",
                              style: TextStyle(
                                fontSize: 9,
                                color: disabledBoldColor,
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
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.check_circle,
                              size: 18,
                              color: successColor,
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${(care["benefits"] as List).length}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Benefits",
                              style: TextStyle(
                                fontSize: 9,
                                color: disabledBoldColor,
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
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.attach_money,
                              size: 18,
                              color: infoColor,
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${care["coverage"]}".contains("100%") ? "Covered" : "Partial",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "Coverage",
                              style: TextStyle(
                                fontSize: 9,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: spMd),

                // Recommended By
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: (care["recommendedBy"] as List).map((org) => Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "$org",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )).toList(),
                ),

                SizedBox(height: spMd),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Learn More",
                        size: bs.sm,
                        onPressed: () {
                          // Navigate to detailed view
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.calendar_today,
                      size: bs.sm,
                      onPressed: () {
                        // Schedule reminder
                        ss("Reminder scheduled for ${care["title"]}");
                      },
                    ),
                  ],
                ),

                SizedBox(height: spSm),

                // Coverage Info
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info,
                        size: 16,
                        color: infoColor,
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "${care["coverage"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: infoColor,
                            fontWeight: FontWeight.w600,
                          ),
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Preventive Care"),
        actions: [
          IconButton(
            onPressed: () {
              // Navigate to reminders
            },
            icon: Icon(Icons.notifications),
          ),
          IconButton(
            onPressed: () {
              // Navigate to calendar
            },
            icon: Icon(Icons.calendar_today),
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      Icon(
                        Icons.shield,
                        color: primaryColor,
                        size: 28,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Preventive Care",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Stay healthy with evidence-based preventive measures",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: spLg),

                  // Benefits Summary
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.favorite,
                              color: successColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Preventive Care Benefits",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "70%",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
                                    ),
                                  ),
                                  Text(
                                    "of diseases are preventable",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: successColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "50%",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
                                    ),
                                  ),
                                  Text(
                                    "lower healthcare costs",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: successColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "10+",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
                                    ),
                                  ),
                                  Text(
                                    "years added to life",
                                    textAlign: TextAlign.center,
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
                      ],
                    ),
                  ),

                  SizedBox(height: spLg),

                  // Filters
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Category",
                          items: categories,
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
                          label: "Age Group",
                          items: ageGroups,
                          value: selectedAgeGroup,
                          onChanged: (value, label) {
                            selectedAgeGroup = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: spLg),

                  // Preventive Care List
                  if (filteredCare.isEmpty) ...[
                    Container(
                      padding: EdgeInsets.all(spLg),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 48,
                            color: disabledBoldColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "No preventive care found",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Try adjusting your filters",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ] else ...[
                    Row(
                      children: [
                        Text(
                          "${filteredCare.length} preventive measures found",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.verified,
                                size: 12,
                                color: primaryColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Evidence-Based",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: spMd),

                    ...filteredCare.map((care) => _buildCareCard(care)).toList(),
                  ],
                ],
              ),
            ),
    );
  }
}
