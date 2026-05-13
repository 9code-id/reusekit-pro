import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaDiseaseInfoView extends StatefulWidget {
  const MhaDiseaseInfoView({super.key});

  @override
  State<MhaDiseaseInfoView> createState() => _MhaDiseaseInfoViewState();
}

class _MhaDiseaseInfoViewState extends State<MhaDiseaseInfoView> {
  List<Map<String, dynamic>> diseases = [
    {
      "id": 1,
      "name": "Diabetes Type 2",
      "category": "Metabolic Disorders",
      "severity": "Moderate",
      "description": "A chronic condition that affects the way your body metabolizes sugar (glucose).",
      "symptoms": [
        "Increased thirst",
        "Frequent urination",
        "Blurred vision",
        "Fatigue",
        "Slow-healing sores",
        "Frequent infections"
      ],
      "causes": [
        "Insulin resistance",
        "Genetic factors",
        "Obesity",
        "Sedentary lifestyle",
        "Age (over 45)",
        "High blood pressure"
      ],
      "prevention": [
        "Maintain healthy weight",
        "Exercise regularly",
        "Eat a balanced diet",
        "Limit processed foods",
        "Regular health screenings",
        "Manage stress"
      ],
      "treatment": [
        "Blood sugar monitoring",
        "Medication (Metformin)",
        "Insulin therapy",
        "Lifestyle changes",
        "Regular check-ups",
        "Diet management"
      ],
      "prevalence": "422 million people worldwide",
      "riskFactors": "High",
      "isCommon": true,
      "image": "https://picsum.photos/300/200?random=1&keyword=diabetes",
      "lastUpdated": "2024-12-15",
    },
    {
      "id": 2,
      "name": "Hypertension",
      "category": "Cardiovascular",
      "severity": "High",
      "description": "High blood pressure that can lead to serious health complications if left untreated.",
      "symptoms": [
        "Headaches",
        "Dizziness",
        "Shortness of breath",
        "Chest pain",
        "Nosebleeds",
        "Often no symptoms"
      ],
      "causes": [
        "Genetics",
        "High sodium intake",
        "Lack of exercise",
        "Obesity",
        "Smoking",
        "Excessive alcohol"
      ],
      "prevention": [
        "Low-sodium diet",
        "Regular exercise",
        "Maintain healthy weight",
        "Limit alcohol",
        "Quit smoking",
        "Manage stress"
      ],
      "treatment": [
        "ACE inhibitors",
        "Beta-blockers",
        "Diuretics",
        "Lifestyle changes",
        "Regular monitoring",
        "Calcium channel blockers"
      ],
      "prevalence": "1.28 billion adults worldwide",
      "riskFactors": "Very High",
      "isCommon": true,
      "image": "https://picsum.photos/300/200?random=2&keyword=blood",
      "lastUpdated": "2024-12-14",
    },
    {
      "id": 3,
      "name": "Depression",
      "category": "Mental Health",
      "severity": "Moderate",
      "description": "A common mental health disorder characterized by persistent sadness and loss of interest.",
      "symptoms": [
        "Persistent sadness",
        "Loss of interest",
        "Fatigue",
        "Sleep disturbances",
        "Appetite changes",
        "Difficulty concentrating"
      ],
      "causes": [
        "Brain chemistry",
        "Genetics",
        "Life events",
        "Medical conditions",
        "Medications",
        "Substance abuse"
      ],
      "prevention": [
        "Regular exercise",
        "Social connections",
        "Stress management",
        "Adequate sleep",
        "Healthy diet",
        "Limit alcohol"
      ],
      "treatment": [
        "Psychotherapy",
        "Antidepressants",
        "Cognitive behavioral therapy",
        "Support groups",
        "Lifestyle changes",
        "Electroconvulsive therapy"
      ],
      "prevalence": "280 million people worldwide",
      "riskFactors": "Moderate",
      "isCommon": true,
      "image": "https://picsum.photos/300/200?random=3&keyword=mental",
      "lastUpdated": "2024-12-13",
    },
    {
      "id": 4,
      "name": "Osteoporosis",
      "category": "Bone Health",
      "severity": "Moderate",
      "description": "A condition where bones become weak and brittle, increasing fracture risk.",
      "symptoms": [
        "Back pain",
        "Loss of height",
        "Stooped posture",
        "Bone fractures",
        "Often no symptoms",
        "Weak grip strength"
      ],
      "causes": [
        "Age",
        "Menopause",
        "Genetics",
        "Low calcium intake",
        "Sedentary lifestyle",
        "Smoking"
      ],
      "prevention": [
        "Calcium-rich diet",
        "Vitamin D supplementation",
        "Weight-bearing exercise",
        "Avoid smoking",
        "Limit alcohol",
        "Fall prevention"
      ],
      "treatment": [
        "Bisphosphonates",
        "Hormone therapy",
        "Calcium supplements",
        "Vitamin D",
        "Exercise program",
        "Fall prevention"
      ],
      "prevalence": "200 million women worldwide",
      "riskFactors": "Moderate",
      "isCommon": false,
      "image": "https://picsum.photos/300/200?random=4&keyword=bone",
      "lastUpdated": "2024-12-12",
    },
    {
      "id": 5,
      "name": "Asthma",
      "category": "Respiratory",
      "severity": "Moderate",
      "description": "A chronic respiratory condition where airways become inflamed and narrow.",
      "symptoms": [
        "Wheezing",
        "Shortness of breath",
        "Chest tightness",
        "Coughing",
        "Difficulty sleeping",
        "Fatigue"
      ],
      "causes": [
        "Genetics",
        "Environmental allergens",
        "Air pollution",
        "Respiratory infections",
        "Weather changes",
        "Exercise"
      ],
      "prevention": [
        "Avoid triggers",
        "Use air filters",
        "Regular check-ups",
        "Vaccination",
        "Maintain healthy weight",
        "Monitor air quality"
      ],
      "treatment": [
        "Quick-relief inhalers",
        "Long-term control medications",
        "Allergy medications",
        "Bronchodilators",
        "Anti-inflammatory drugs",
        "Immunotherapy"
      ],
      "prevalence": "339 million people worldwide",
      "riskFactors": "Moderate",
      "isCommon": true,
      "image": "https://picsum.photos/300/200?random=5&keyword=lungs",
      "lastUpdated": "2024-12-11",
    },
    {
      "id": 6,
      "name": "Migraine",
      "category": "Neurological",
      "severity": "Moderate",
      "description": "A neurological condition characterized by intense, recurring headaches.",
      "symptoms": [
        "Severe headache",
        "Nausea",
        "Vomiting",
        "Light sensitivity",
        "Sound sensitivity",
        "Visual disturbances"
      ],
      "causes": [
        "Genetics",
        "Hormonal changes",
        "Stress",
        "Certain foods",
        "Sleep changes",
        "Environmental factors"
      ],
      "prevention": [
        "Identify triggers",
        "Regular sleep schedule",
        "Stress management",
        "Stay hydrated",
        "Regular meals",
        "Limit alcohol"
      ],
      "treatment": [
        "Pain relievers",
        "Triptans",
        "Preventive medications",
        "Botox injections",
        "Lifestyle modifications",
        "Alternative therapies"
      ],
      "prevalence": "1 billion people worldwide",
      "riskFactors": "Moderate",
      "isCommon": true,
      "image": "https://picsum.photos/300/200?random=6&keyword=headache",
      "lastUpdated": "2024-12-10",
    },
  ];

  String selectedCategory = "All";
  String selectedSeverity = "All";
  String searchQuery = "";
  bool showCommonOnly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Disease Information"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildSearchAndFilter(),
            _buildQuickStats(),
            _buildDiseasesList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Column(
      spacing: spSm,
      children: [
        Row(
          children: [
            Expanded(
              child: QTextField(
                label: "Search diseases...",
                value: searchQuery,
                hint: "Type disease name or symptoms",
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
              onPressed: () {
                // Perform search
              },
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: QDropdownField(
                label: "Category",
                items: [
                  {"label": "All Categories", "value": "All"},
                  {"label": "Cardiovascular", "value": "Cardiovascular"},
                  {"label": "Metabolic Disorders", "value": "Metabolic Disorders"},
                  {"label": "Mental Health", "value": "Mental Health"},
                  {"label": "Respiratory", "value": "Respiratory"},
                  {"label": "Bone Health", "value": "Bone Health"},
                  {"label": "Neurological", "value": "Neurological"},
                ],
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
                label: "Severity",
                items: [
                  {"label": "All Levels", "value": "All"},
                  {"label": "Low", "value": "Low"},
                  {"label": "Moderate", "value": "Moderate"},
                  {"label": "High", "value": "High"},
                ],
                value: selectedSeverity,
                onChanged: (value, label) {
                  selectedSeverity = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        QSwitch(
          items: [
            {
              "label": "Show Common Diseases Only",
              "value": true,
              "checked": showCommonOnly,
            }
          ],
          value: [if (showCommonOnly) {"label": "Show Common Diseases Only", "value": true, "checked": true}],
          onChanged: (values, ids) {
            showCommonOnly = values.isNotEmpty;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildQuickStats() {
    var totalDiseases = diseases.length;
    var commonDiseases = diseases.where((disease) => disease["isCommon"] == true).length;
    var highSeverity = diseases.where((disease) => disease["severity"] == "High").length;

    return Container(
      padding: EdgeInsets.all(spSm),
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
            "Disease Database Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  "Total Diseases",
                  "$totalDiseases",
                  Icons.medical_information,
                  primaryColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard(
                  "Common Diseases",
                  "$commonDiseases",
                  Icons.trending_up,
                  successColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard(
                  "High Severity",
                  "$highSeverity",
                  Icons.warning,
                  dangerColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(40)),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDiseasesList() {
    var filteredDiseases = diseases;
    
    if (selectedCategory != "All") {
      filteredDiseases = diseases.where((disease) => disease["category"] == selectedCategory).toList();
    }
    
    if (selectedSeverity != "All") {
      filteredDiseases = filteredDiseases.where((disease) => disease["severity"] == selectedSeverity).toList();
    }
    
    if (showCommonOnly) {
      filteredDiseases = filteredDiseases.where((disease) => disease["isCommon"] == true).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filteredDiseases = filteredDiseases.where((disease) => 
        disease["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
        disease["description"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
        (disease["symptoms"] as List).any((symptom) => symptom.toString().toLowerCase().contains(searchQuery.toLowerCase()))
      ).toList();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Disease Information",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...filteredDiseases.map((disease) => _buildDiseaseItem(disease)).toList(),
      ],
    );
  }

  Widget _buildDiseaseItem(Map<String, dynamic> disease) {
    Color categoryColor = _getCategoryColor(disease["category"]);
    Color severityColor = _getSeverityColor(disease["severity"]);

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: severityColor,
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${disease["image"]}",
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${disease["name"]}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        if (disease["isCommon"] == true)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: warningColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "COMMON",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: categoryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${disease["category"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: categoryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: severityColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${disease["severity"]} Risk",
                            style: TextStyle(
                              fontSize: 12,
                              color: severityColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${disease["description"]}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Prevalence",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${disease["prevalence"]}",
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
                            "Risk Factors",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${disease["riskFactors"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: severityColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Text(
                  "Common Symptoms: ${(disease["symptoms"] as List).take(3).join(", ")}${(disease["symptoms"] as List).length > 3 ? "..." : ""}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "View Detailed Information",
              size: bs.sm,
              onPressed: () => _showDiseaseDetail(disease),
            ),
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Cardiovascular": return dangerColor;
      case "Metabolic Disorders": return warningColor;
      case "Mental Health": return infoColor;
      case "Respiratory": return Color(0xFF9C27B0);
      case "Bone Health": return Color(0xFF795548);
      case "Neurological": return primaryColor;
      default: return primaryColor;
    }
  }

  Color _getSeverityColor(String severity) {
    switch (severity) {
      case "Low": return successColor;
      case "Moderate": return warningColor;
      case "High": return dangerColor;
      default: return primaryColor;
    }
  }

  void _showDiseaseDetail(Map<String, dynamic> disease) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spSm,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(radiusMd),
              child: Image.network(
                "${disease["image"]}",
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              "${disease["name"]}",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Text(
              "${disease["description"]}",
              style: TextStyle(
                fontSize: 16,
                color: disabledBoldColor,
                height: 1.4,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    _buildDetailSection("Symptoms", disease["symptoms"] as List, Icons.healing),
                    _buildDetailSection("Causes", disease["causes"] as List, Icons.error),
                    _buildDetailSection("Prevention", disease["prevention"] as List, Icons.shield),
                    _buildDetailSection("Treatment", disease["treatment"] as List, Icons.medication),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: warningColor.withAlpha(40)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.info, color: warningColor, size: 20),
                              SizedBox(width: spSm),
                              Text(
                                "Important Information",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "This information is for educational purposes only. Always consult with healthcare professionals for proper diagnosis and treatment. Last updated: ${disease["lastUpdated"]}",
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
            ),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Find Nearby Doctors",
                size: bs.md,
                onPressed: () {
                  ss("Finding doctors for ${disease["name"]}...");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, List items, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(icon, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...items.map((item) => Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 6),
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "$item",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          )).toList(),
        ],
      ),
    );
  }
}
