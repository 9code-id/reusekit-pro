import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaTreatmentGuideView extends StatefulWidget {
  const MhaTreatmentGuideView({super.key});

  @override
  State<MhaTreatmentGuideView> createState() => _MhaTreatmentGuideViewState();
}

class _MhaTreatmentGuideViewState extends State<MhaTreatmentGuideView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedType = "All Types";
  String selectedLevel = "All Levels";
  bool loading = false;

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Medications", "value": "Medications"},
    {"label": "Therapy", "value": "Therapy"},
    {"label": "Surgery", "value": "Surgery"},
    {"label": "Lifestyle", "value": "Lifestyle"},
    {"label": "Alternative", "value": "Alternative"},
    {"label": "Emergency", "value": "Emergency"},
    {"label": "Rehabilitation", "value": "Rehabilitation"},
  ];

  List<Map<String, dynamic>> treatmentTypes = [
    {"label": "All Types", "value": "All Types"},
    {"label": "Prescription", "value": "Prescription"},
    {"label": "Over-the-Counter", "value": "OTC"},
    {"label": "Non-Drug", "value": "Non-Drug"},
    {"label": "Invasive", "value": "Invasive"},
    {"label": "Non-Invasive", "value": "Non-Invasive"},
  ];

  List<Map<String, dynamic>> complexityLevels = [
    {"label": "All Levels", "value": "All Levels"},
    {"label": "Basic", "value": "Basic"},
    {"label": "Intermediate", "value": "Intermediate"},
    {"label": "Advanced", "value": "Advanced"},
    {"label": "Expert", "value": "Expert"},
  ];

  List<Map<String, dynamic>> treatmentGuides = [
    {
      "id": "1",
      "title": "Hypertension Management Protocol",
      "category": "Medications",
      "type": "Prescription",
      "level": "Intermediate",
      "condition": "High Blood Pressure",
      "description": "Comprehensive guide for managing hypertension through medication and lifestyle modifications",
      "steps": [
        {
          "step": 1,
          "title": "Initial Assessment",
          "description": "Conduct thorough blood pressure monitoring",
          "duration": "1-2 weeks",
          "instructions": [
            "Take multiple BP readings at different times",
            "Record readings in log book",
            "Note any symptoms or triggers",
            "Review family history and risk factors"
          ]
        },
        {
          "step": 2,
          "title": "Lifestyle Modifications",
          "description": "Implement dietary and exercise changes",
          "duration": "4-6 weeks",
          "instructions": [
            "Reduce sodium intake to <2300mg daily",
            "Increase potassium-rich foods",
            "Engage in 150 minutes moderate exercise weekly",
            "Limit alcohol consumption",
            "Maintain healthy weight"
          ]
        },
        {
          "step": 3,
          "title": "Medication Initiation",
          "description": "Start appropriate antihypertensive therapy",
          "duration": "Ongoing",
          "instructions": [
            "Begin with ACE inhibitor or thiazide diuretic",
            "Start with low dose and titrate up",
            "Monitor for side effects",
            "Check BP weekly for first month"
          ]
        },
        {
          "step": 4,
          "title": "Monitoring and Adjustment",
          "description": "Regular follow-up and medication optimization",
          "duration": "Lifelong",
          "instructions": [
            "Monthly BP checks initially",
            "Adjust medications as needed",
            "Monitor kidney function",
            "Annual cardiovascular risk assessment"
          ]
        }
      ],
      "medications": [
        {
          "name": "Lisinopril",
          "type": "ACE Inhibitor",
          "dosage": "5-40mg daily",
          "timing": "Morning",
          "sideEffects": ["Dry cough", "Dizziness", "Fatigue"]
        },
        {
          "name": "Hydrochlorothiazide",
          "type": "Thiazide Diuretic",
          "dosage": "12.5-50mg daily",
          "timing": "Morning",
          "sideEffects": ["Increased urination", "Low potassium", "Dehydration"]
        }
      ],
      "contraindications": [
        "Pregnancy",
        "Severe kidney disease",
        "Known allergies to medications",
        "Severe heart block"
      ],
      "warnings": [
        "Monitor blood pressure regularly",
        "Do not stop medications abruptly",
        "Report severe side effects immediately",
        "Avoid NSAIDs without doctor approval"
      ],
      "effectiveness": "85%",
      "duration": "Lifelong management",
      "cost": "Low to Moderate",
      "image": "https://picsum.photos/400/250?random=1&keyword=blood-pressure",
      "icon": Icons.favorite,
      "color": dangerColor,
      "lastUpdated": DateTime.now().subtract(Duration(days: 2)),
      "rating": 4.8,
      "reviews": 245,
      "difficulty": "Moderate",
    },
    {
      "id": "2",
      "title": "Type 2 Diabetes Treatment Plan",
      "category": "Medications",
      "type": "Prescription",
      "level": "Intermediate",
      "condition": "Type 2 Diabetes",
      "description": "Evidence-based approach to managing type 2 diabetes with medications and lifestyle changes",
      "steps": [
        {
          "step": 1,
          "title": "Baseline Testing",
          "description": "Comprehensive diabetes assessment",
          "duration": "1 week",
          "instructions": [
            "HbA1c test",
            "Fasting glucose test",
            "Lipid panel",
            "Kidney function tests",
            "Eye examination"
          ]
        },
        {
          "step": 2,
          "title": "Metformin Initiation",
          "description": "Start first-line diabetes medication",
          "duration": "2-4 weeks",
          "instructions": [
            "Begin with 500mg twice daily",
            "Take with meals to reduce GI upset",
            "Gradually increase to maximum tolerated dose",
            "Monitor blood glucose levels"
          ]
        },
        {
          "step": 3,
          "title": "Lifestyle Counseling",
          "description": "Implement diabetes management plan",
          "duration": "Ongoing",
          "instructions": [
            "Carbohydrate counting education",
            "Regular physical activity plan",
            "Weight management strategies",
            "Blood glucose monitoring technique"
          ]
        },
        {
          "step": 4,
          "title": "Combination Therapy",
          "description": "Add second-line medications if needed",
          "duration": "As required",
          "instructions": [
            "Consider insulin if HbA1c >9%",
            "Add GLP-1 agonist for weight loss",
            "Use SGLT2 inhibitors for cardiovascular protection",
            "Regular medication review and adjustment"
          ]
        }
      ],
      "medications": [
        {
          "name": "Metformin",
          "type": "Biguanide",
          "dosage": "500-2000mg daily",
          "timing": "With meals",
          "sideEffects": ["Nausea", "Diarrhea", "Metallic taste"]
        },
        {
          "name": "Glipizide",
          "type": "Sulfonylurea",
          "dosage": "2.5-20mg daily",
          "timing": "Before meals",
          "sideEffects": ["Hypoglycemia", "Weight gain", "Skin reactions"]
        }
      ],
      "contraindications": [
        "Severe kidney disease",
        "Diabetic ketoacidosis",
        "Type 1 diabetes",
        "Severe liver disease"
      ],
      "warnings": [
        "Monitor for hypoglycemia",
        "Regular kidney function monitoring",
        "Discontinue before contrast procedures",
        "Check vitamin B12 levels annually"
      ],
      "effectiveness": "78%",
      "duration": "Lifelong management",
      "cost": "Low",
      "image": "https://picsum.photos/400/250?random=2&keyword=diabetes",
      "icon": Icons.water_drop,
      "color": warningColor,
      "lastUpdated": DateTime.now().subtract(Duration(days: 1)),
      "rating": 4.6,
      "reviews": 189,
      "difficulty": "Moderate",
    },
    {
      "id": "3",
      "title": "Cognitive Behavioral Therapy for Depression",
      "category": "Therapy",
      "type": "Non-Drug",
      "level": "Intermediate",
      "condition": "Major Depression",
      "description": "Structured psychotherapy approach to treat depression through cognitive and behavioral techniques",
      "steps": [
        {
          "step": 1,
          "title": "Assessment and Goal Setting",
          "description": "Initial evaluation and treatment planning",
          "duration": "1-2 sessions",
          "instructions": [
            "Complete depression screening tools",
            "Identify specific symptoms and triggers",
            "Set realistic treatment goals",
            "Establish therapeutic rapport"
          ]
        },
        {
          "step": 2,
          "title": "Psychoeducation",
          "description": "Understanding depression and CBT principles",
          "duration": "2-3 sessions",
          "instructions": [
            "Learn about cognitive model of depression",
            "Understand thought-feeling-behavior connections",
            "Identify negative thought patterns",
            "Introduction to mood monitoring"
          ]
        },
        {
          "step": 3,
          "title": "Cognitive Restructuring",
          "description": "Challenge and modify negative thoughts",
          "duration": "4-6 sessions",
          "instructions": [
            "Identify cognitive distortions",
            "Practice thought challenging techniques",
            "Develop balanced thinking patterns",
            "Use thought record worksheets"
          ]
        },
        {
          "step": 4,
          "title": "Behavioral Activation",
          "description": "Increase pleasant and meaningful activities",
          "duration": "4-6 sessions",
          "instructions": [
            "Schedule pleasant activities",
            "Gradually increase activity level",
            "Set achievable behavioral goals",
            "Monitor mood-activity relationships"
          ]
        }
      ],
      "medications": [],
      "contraindications": [
        "Active psychosis",
        "Severe cognitive impairment",
        "Active substance abuse",
        "Suicidal ideation requiring hospitalization"
      ],
      "warnings": [
        "May temporarily increase emotional distress",
        "Requires commitment to homework assignments",
        "Progress may be gradual",
        "Suicidal ideation should be monitored"
      ],
      "effectiveness": "65%",
      "duration": "12-20 sessions",
      "cost": "Moderate",
      "image": "https://picsum.photos/400/250?random=3&keyword=therapy",
      "icon": Icons.psychology,
      "color": infoColor,
      "lastUpdated": DateTime.now().subtract(Duration(days: 3)),
      "rating": 4.7,
      "reviews": 156,
      "difficulty": "Moderate",
    },
    {
      "id": "4",
      "title": "Asthma Action Plan",
      "category": "Medications",
      "type": "Prescription",
      "level": "Basic",
      "condition": "Asthma",
      "description": "Step-by-step guide for managing asthma symptoms and preventing attacks",
      "steps": [
        {
          "step": 1,
          "title": "Green Zone - Good Control",
          "description": "Daily management when asthma is well controlled",
          "duration": "Daily",
          "instructions": [
            "Take controller medication as prescribed",
            "Monitor peak flow readings",
            "Avoid known triggers",
            "Maintain normal activity levels"
          ]
        },
        {
          "step": 2,
          "title": "Yellow Zone - Caution",
          "description": "Early warning signs of worsening asthma",
          "duration": "As needed",
          "instructions": [
            "Increase controller medication if prescribed",
            "Use rescue inhaler for symptoms",
            "Avoid triggers more strictly",
            "Contact healthcare provider if symptoms persist"
          ]
        },
        {
          "step": 3,
          "title": "Red Zone - Emergency",
          "description": "Severe asthma symptoms requiring immediate action",
          "duration": "Emergency",
          "instructions": [
            "Use rescue inhaler immediately",
            "Take oral corticosteroids if prescribed",
            "Seek emergency medical care",
            "Call 911 if unable to speak in sentences"
          ]
        }
      ],
      "medications": [
        {
          "name": "Albuterol",
          "type": "Short-acting bronchodilator",
          "dosage": "2 puffs every 4-6 hours as needed",
          "timing": "As needed for symptoms",
          "sideEffects": ["Tremor", "Rapid heartbeat", "Nervousness"]
        },
        {
          "name": "Fluticasone",
          "type": "Inhaled corticosteroid",
          "dosage": "2 puffs twice daily",
          "timing": "Morning and evening",
          "sideEffects": ["Thrush", "Hoarse voice", "Cough"]
        }
      ],
      "contraindications": [
        "Known allergy to medications",
        "Severe milk protein allergy (some inhalers)",
        "Severe heart rhythm disorders"
      ],
      "warnings": [
        "Rinse mouth after using inhaled steroids",
        "Do not exceed rescue inhaler use",
        "Seek emergency care for severe symptoms",
        "Keep rescue inhaler accessible at all times"
      ],
      "effectiveness": "90%",
      "duration": "Lifelong management",
      "cost": "Moderate",
      "image": "https://picsum.photos/400/250?random=4&keyword=inhaler",
      "icon": Icons.air,
      "color": infoColor,
      "lastUpdated": DateTime.now().subtract(Duration(days: 5)),
      "rating": 4.9,
      "reviews": 298,
      "difficulty": "Easy",
    },
    {
      "id": "5",
      "title": "Cardiac Rehabilitation Program",
      "category": "Rehabilitation",
      "type": "Non-Drug",
      "level": "Advanced",
      "condition": "Post-Heart Attack",
      "description": "Comprehensive rehabilitation program for patients recovering from cardiac events",
      "steps": [
        {
          "step": 1,
          "title": "Phase I - Inpatient",
          "description": "Early mobilization in hospital setting",
          "duration": "2-5 days",
          "instructions": [
            "Bedside range of motion exercises",
            "Progressive sitting and standing",
            "Short walking distances",
            "Heart rate and blood pressure monitoring"
          ]
        },
        {
          "step": 2,
          "title": "Phase II - Supervised Outpatient",
          "description": "Structured exercise program with monitoring",
          "duration": "8-12 weeks",
          "instructions": [
            "3 sessions per week supervised exercise",
            "Continuous ECG monitoring",
            "Progressive aerobic training",
            "Strength training introduction"
          ]
        },
        {
          "step": 3,
          "title": "Phase III - Maintenance",
          "description": "Long-term supervised exercise program",
          "duration": "Ongoing",
          "instructions": [
            "2-3 sessions per week",
            "Intermittent monitoring",
            "Advanced exercise protocols",
            "Independent exercise planning"
          ]
        },
        {
          "step": 4,
          "title": "Phase IV - Community-Based",
          "description": "Self-directed lifelong exercise program",
          "duration": "Lifelong",
          "instructions": [
            "Independent exercise routine",
            "Annual fitness assessments",
            "Ongoing lifestyle counseling",
            "Peer support groups"
          ]
        }
      ],
      "medications": [],
      "contraindications": [
        "Unstable angina",
        "Uncontrolled heart rhythm disorders",
        "Severe heart failure",
        "Recent cardiac procedures"
      ],
      "warnings": [
        "Exercise must be medically supervised initially",
        "Stop exercise if chest pain occurs",
        "Monitor heart rate and blood pressure",
        "Progress gradually to avoid overexertion"
      ],
      "effectiveness": "85%",
      "duration": "12 weeks initial program",
      "cost": "High",
      "image": "https://picsum.photos/400/250?random=5&keyword=cardiac-rehab",
      "icon": Icons.fitness_center,
      "color": successColor,
      "lastUpdated": DateTime.now().subtract(Duration(days: 4)),
      "rating": 4.8,
      "reviews": 134,
      "difficulty": "Advanced",
    },
  ];

  List<Map<String, dynamic>> get filteredGuides {
    return treatmentGuides.where((guide) {
      bool matchesSearch = searchQuery.isEmpty ||
          (guide["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (guide["description"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (guide["condition"] as String).toLowerCase().contains(searchQuery.toLowerCase());

      bool matchesCategory = selectedCategory == "All" || guide["category"] == selectedCategory;
      bool matchesType = selectedType == "All Types" || guide["type"] == selectedType;
      bool matchesLevel = selectedLevel == "All Levels" || guide["level"] == selectedLevel;

      return matchesSearch && matchesCategory && matchesType && matchesLevel;
    }).toList();
  }

  Color _getLevelColor(String level) {
    switch (level) {
      case "Basic":
        return successColor;
      case "Intermediate":
        return warningColor;
      case "Advanced":
        return dangerColor;
      case "Expert":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Treatment Guides"),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.bookmark_border,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(width: spSm),
          GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.download,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search Bar
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search treatment guides...",
                          value: searchQuery,
                          hint: "Enter condition, treatment type, or category",
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.search,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),

                  SizedBox(height: spMd),

                  // Filter Options
                  Column(
                    spacing: spSm,
                    children: [
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
                              label: "Type",
                              items: treatmentTypes,
                              value: selectedType,
                              onChanged: (value, label) {
                                selectedType = value;
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                      QDropdownField(
                        label: "Complexity Level",
                        items: complexityLevels,
                        value: selectedLevel,
                        onChanged: (value, label) {
                          selectedLevel = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),

                  SizedBox(height: spMd),

                  // Quick Categories
                  Text(
                    "Treatment Categories",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  SizedBox(height: spSm),

                  QHorizontalScroll(
                    children: categories.where((cat) => cat["value"] != "All").map((category) {
                      int guideCount = treatmentGuides.where((g) => g["category"] == category["value"]).length;
                      return Container(
                        width: 120,
                        margin: EdgeInsets.only(right: spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          boxShadow: [shadowSm],
                          border: selectedCategory == category["value"]
                              ? Border.all(color: primaryColor, width: 2)
                              : null,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            selectedCategory = category["value"];
                            setState(() {});
                          },
                          child: Padding(
                            padding: EdgeInsets.all(spSm),
                            child: Column(
                              children: [
                                Icon(
                                  _getCategoryIcon(category["value"]),
                                  color: selectedCategory == category["value"] 
                                      ? primaryColor 
                                      : disabledBoldColor,
                                  size: 28,
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${category["label"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: selectedCategory == category["value"] 
                                        ? primaryColor 
                                        : primaryColor,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                ),
                                Text(
                                  "$guideCount guides",
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  SizedBox(height: spMd),

                  // Results Header
                  Row(
                    children: [
                      Text(
                        "Treatment Guides",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${filteredGuides.length} guides found",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: spSm),

                  // Treatment Guide List
                  Column(
                    spacing: spSm,
                    children: filteredGuides.map((guide) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Guide Header
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: (guide["color"] as Color).withAlpha(50),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(radiusMd),
                                  topRight: Radius.circular(radiusMd),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    guide["icon"] as IconData,
                                    color: guide["color"] as Color,
                                    size: 24,
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${guide["title"]}",
                                          style: TextStyle(
                                            fontSize: fsH6,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                        Text(
                                          "For ${guide["condition"]}",
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
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _getLevelColor(guide["level"]),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${guide["level"]}",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 2),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.star,
                                            size: 12,
                                            color: warningColor,
                                          ),
                                          SizedBox(width: 2),
                                          Text(
                                            "${guide["rating"]}",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                              color: primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            // Guide Content
                            Padding(
                              padding: EdgeInsets.all(spSm),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${guide["description"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: primaryColor,
                                    ),
                                  ),

                                  SizedBox(height: spSm),

                                  // Quick Info Grid
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _buildInfoCard(
                                          "Effectiveness",
                                          "${guide["effectiveness"]}",
                                          Icons.trending_up,
                                          successColor,
                                        ),
                                      ),
                                      SizedBox(width: spXs),
                                      Expanded(
                                        child: _buildInfoCard(
                                          "Duration",
                                          "${guide["duration"]}",
                                          Icons.access_time,
                                          infoColor,
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: spXs),

                                  Row(
                                    children: [
                                      Expanded(
                                        child: _buildInfoCard(
                                          "Cost",
                                          "${guide["cost"]}",
                                          Icons.attach_money,
                                          warningColor,
                                        ),
                                      ),
                                      SizedBox(width: spXs),
                                      Expanded(
                                        child: _buildInfoCard(
                                          "Reviews",
                                          "${guide["reviews"]}",
                                          Icons.reviews,
                                          primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: spSm),

                                  // Treatment Steps Preview
                                  Text(
                                    "Treatment Steps (${(guide["steps"] as List).length} steps)",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),

                                  SizedBox(height: spXs),

                                  Column(
                                    children: (guide["steps"] as List)
                                        .take(3)
                                        .map((step) => Padding(
                                              padding: EdgeInsets.only(bottom: spXs),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 20,
                                                    height: 20,
                                                    decoration: BoxDecoration(
                                                      color: primaryColor,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "${step["step"]}",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 10,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: spXs),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          "${step["title"]}",
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w600,
                                                            color: primaryColor,
                                                          ),
                                                        ),
                                                        Text(
                                                          "${step["description"]}",
                                                          style: TextStyle(
                                                            fontSize: 11,
                                                            color: disabledBoldColor,
                                                          ),
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Text(
                                                    "${step["duration"]}",
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color: disabledBoldColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ))
                                        .toList(),
                                  ),

                                  if ((guide["steps"] as List).length > 3)
                                    Text(
                                      "+${(guide["steps"] as List).length - 3} more steps",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: primaryColor,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),

                                  SizedBox(height: spSm),

                                  // Key Warnings
                                  if ((guide["warnings"] as List).isNotEmpty)
                                    Container(
                                      padding: EdgeInsets.all(spXs),
                                      decoration: BoxDecoration(
                                        color: warningColor.withAlpha(50),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.warning,
                                            size: 16,
                                            color: warningColor,
                                          ),
                                          SizedBox(width: spXs),
                                          Expanded(
                                            child: Text(
                                              "${(guide["warnings"] as List).first}",
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: warningColor,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                  SizedBox(height: spSm),

                                  // Action Buttons
                                  Row(
                                    children: [
                                      Expanded(
                                        child: QButton(
                                          label: "View Full Guide",
                                          size: bs.sm,
                                          onPressed: () {},
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      QButton(
                                        icon: Icons.download,
                                        size: bs.sm,
                                        onPressed: () {},
                                      ),
                                      SizedBox(width: spXs),
                                      QButton(
                                        icon: Icons.bookmark_border,
                                        size: bs.sm,
                                        onPressed: () {},
                                      ),
                                      SizedBox(width: spXs),
                                      QButton(
                                        icon: Icons.share,
                                        size: bs.sm,
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: spXs),

                                  // Last Updated
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.update,
                                        size: 12,
                                        color: disabledBoldColor,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "Updated ${(guide["lastUpdated"] as DateTime).timeAgo}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "${guide["category"]} • ${guide["type"]}",
                                        style: TextStyle(
                                          fontSize: 10,
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
                      );
                    }).toList(),
                  ),

                  if (filteredGuides.isEmpty)
                    Container(
                      padding: EdgeInsets.all(spLg),
                      child: Column(
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 64,
                            color: disabledColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "No treatment guides found",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Try adjusting your search criteria",
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
            ),
    );
  }

  Widget _buildInfoCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        color: color.withAlpha(50),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 14,
            color: color,
          ),
          SizedBox(width: spXs),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 9,
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 10,
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "Medications":
        return Icons.medication;
      case "Therapy":
        return Icons.psychology;
      case "Surgery":
        return Icons.medical_services;
      case "Lifestyle":
        return Icons.fitness_center;
      case "Alternative":
        return Icons.nature;
      case "Emergency":
        return Icons.emergency;
      case "Rehabilitation":
        return Icons.healing;
      default:
        return Icons.medical_information;
    }
  }
}
