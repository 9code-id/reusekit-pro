import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaEyeHealthView extends StatefulWidget {
  const HcaEyeHealthView({super.key});

  @override
  State<HcaEyeHealthView> createState() => _HcaEyeHealthViewState();
}

class _HcaEyeHealthViewState extends State<HcaEyeHealthView> {
  int currentTab = 0;

  // Eye Exams Data
  List<Map<String, dynamic>> eyeExams = [
    {
      "id": 1,
      "type": "Comprehensive Eye Exam",
      "date": "2024-01-15",
      "doctor": "Dr. Sarah Wilson",
      "vision_od": "20/20",
      "vision_os": "20/25",
      "pressure_od": 14,
      "pressure_os": 15,
      "notes": "Slight myopia in left eye, recommend glasses for reading",
      "next_visit": "2025-01-15"
    },
    {
      "id": 2,
      "type": "Diabetic Eye Screening",
      "date": "2023-12-10",
      "doctor": "Dr. Michael Chen",
      "vision_od": "20/25",
      "vision_os": "20/30",
      "pressure_od": 16,
      "pressure_os": 17,
      "notes": "No diabetic retinopathy detected, continue monitoring",
      "next_visit": "2024-12-10"
    },
    {
      "id": 3,
      "type": "Glaucoma Screening",
      "date": "2023-11-20",
      "doctor": "Dr. Emily Rodriguez",
      "vision_od": "20/20",
      "vision_os": "20/20",
      "pressure_od": 18,
      "pressure_os": 19,
      "notes": "Elevated eye pressure, monitor closely",
      "next_visit": "2024-05-20"
    }
  ];

  // Symptoms Data
  List<Map<String, dynamic>> symptoms = [
    {
      "id": 1,
      "symptom": "Dry Eyes",
      "severity": "Moderate",
      "date": "2024-01-20",
      "duration": "3 hours",
      "triggers": "Computer work, dry weather",
      "treatment": "Eye drops every 2 hours"
    },
    {
      "id": 2,
      "symptom": "Eye Strain",
      "severity": "Mild",
      "date": "2024-01-18",
      "duration": "2 hours",
      "triggers": "Long screen time",
      "treatment": "20-20-20 rule, blue light glasses"
    },
    {
      "id": 3,
      "symptom": "Blurred Vision",
      "severity": "Severe",
      "date": "2024-01-15",
      "duration": "30 minutes",
      "triggers": "Reading in dim light",
      "treatment": "Rest eyes, adjust lighting"
    }
  ];

  // Analytics Data
  Map<String, dynamic> analyticsData = {
    "vision_trend": "Stable",
    "pressure_trend": "Slightly Increasing",
    "symptom_frequency": 8,
    "last_exam": "45 days ago",
    "next_exam": "320 days",
    "risk_level": "Low",
    "compliance_rate": 85
  };

  // Form Data
  String examType = "";
  String examDate = "";
  String examTime = "";
  String doctorName = "";
  String visionOD = "";
  String visionOS = "";
  String pressureOD = "";
  String pressureOS = "";
  String examNotes = "";
  String nextVisitDate = "";

  List<Map<String, dynamic>> examTypeItems = [
    {"label": "Comprehensive Eye Exam", "value": "comprehensive"},
    {"label": "Diabetic Eye Screening", "value": "diabetic"},
    {"label": "Glaucoma Screening", "value": "glaucoma"},
    {"label": "Contact Lens Fitting", "value": "contact"},
    {"label": "Emergency Visit", "value": "emergency"}
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Eye Health Tracker",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Exams", icon: Icon(Icons.visibility)),
        Tab(text: "Symptoms", icon: Icon(Icons.remove_red_eye)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "Log Exam", icon: Icon(Icons.add_circle))
      ],
      tabChildren: [
        _buildExamsTab(),
        _buildSymptomsTab(),
        _buildAnalyticsTab(),
        _buildLogExamTab()
      ],
    );
  }

  Widget _buildExamsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildExamsSummaryCard(),
          _buildExamsFilterSection(),
          _buildExamsList()
        ],
      ),
    );
  }

  Widget _buildExamsSummaryCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Text(
            "Eye Health Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 120,
            children: [
              _buildSummaryItem("Total Exams", "${eyeExams.length}", Icons.visibility, primaryColor),
              _buildSummaryItem("Last Vision", "20/20 OD", Icons.remove_red_eye, successColor),
              _buildSummaryItem("Eye Pressure", "15 mmHg", Icons.speed, warningColor),
              _buildSummaryItem("Next Exam", "320 days", Icons.schedule, infoColor)
            ],
          )
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Icon(icon, color: color, size: 24),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildExamsFilterSection() {
    return Row(
      children: [
        Expanded(
          child: QTextField(
            label: "Search exams...",
            value: "",
            onChanged: (value) {},
          ),
        ),
        SizedBox(width: spSm),
        QButton(
          icon: Icons.filter_list,
          size: bs.sm,
          onPressed: () {},
        )
      ],
    );
  }

  Widget _buildExamsList() {
    return Column(
      spacing: spSm,
      children: eyeExams.map((exam) {
        return Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            spacing: spSm,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${exam["type"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    "${DateTime.parse(exam["date"]).dMMMy}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Icon(Icons.person, color: primaryColor, size: 16),
                  SizedBox(width: spXs),
                  Text(
                    "${exam["doctor"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  )
                ],
              ),
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 100,
                children: [
                  _buildExamDetail("Vision OD", "${exam["vision_od"]}"),
                  _buildExamDetail("Vision OS", "${exam["vision_os"]}"),
                  _buildExamDetail("Pressure OD", "${exam["pressure_od"]} mmHg"),
                  _buildExamDetail("Pressure OS", "${exam["pressure_os"]} mmHg")
                ],
              ),
              if (exam["notes"] != null && exam["notes"].toString().isNotEmpty)
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${exam["notes"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
              Row(
                children: [
                  Icon(Icons.schedule, color: warningColor, size: 16),
                  SizedBox(width: spXs),
                  Text(
                    "Next visit: ${DateTime.parse(exam["next_visit"]).dMMMy}",
                    style: TextStyle(
                      fontSize: 14,
                      color: warningColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  QButton(
                    label: "View Details",
                    size: bs.sm,
                    onPressed: () {},
                  )
                ],
              )
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildExamDetail(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spXs,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        )
      ],
    );
  }

  Widget _buildSymptomsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildSymptomsFilterSection(),
          _buildSymptomsList()
        ],
      ),
    );
  }

  Widget _buildSymptomsFilterSection() {
    return Row(
      children: [
        Expanded(
          child: QTextField(
            label: "Search symptoms...",
            value: "",
            onChanged: (value) {},
          ),
        ),
        SizedBox(width: spSm),
        QButton(
          icon: Icons.add,
          size: bs.sm,
          onPressed: () {},
        )
      ],
    );
  }

  Widget _buildSymptomsList() {
    return Column(
      spacing: spSm,
      children: symptoms.map((symptom) {
        Color severityColor = symptom["severity"] == "Severe" 
            ? dangerColor 
            : symptom["severity"] == "Moderate" 
                ? warningColor 
                : successColor;

        return Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            spacing: spSm,
            children: [
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: severityColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "${symptom["symptom"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: severityColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${symptom["severity"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: severityColor,
                      ),
                    ),
                  )
                ],
              ),
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 120,
                children: [
                  _buildSymptomDetail("Date", "${DateTime.parse(symptom["date"]).dMMMy}"),
                  _buildSymptomDetail("Duration", "${symptom["duration"]}"),
                  _buildSymptomDetail("Triggers", "${symptom["triggers"]}"),
                  _buildSymptomDetail("Treatment", "${symptom["treatment"]}")
                ],
              )
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSymptomDetail(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spXs,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: primaryColor,
          ),
        )
      ],
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildAnalyticsOverview(),
          _buildTrendsAnalysis(),
          _buildRecommendations()
        ],
      ),
    );
  }

  Widget _buildAnalyticsOverview() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Text(
            "Eye Health Analytics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: [
              _buildAnalyticsCard("Vision Trend", "${analyticsData["vision_trend"]}", Icons.trending_up, successColor),
              _buildAnalyticsCard("Pressure Trend", "${analyticsData["pressure_trend"]}", Icons.trending_up, warningColor),
              _buildAnalyticsCard("Symptom Frequency", "${analyticsData["symptom_frequency"]}/month", Icons.warning, dangerColor),
              _buildAnalyticsCard("Risk Level", "${analyticsData["risk_level"]}", Icons.security, successColor)
            ],
          )
        ],
      ),
    );
  }

  Widget _buildAnalyticsCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Icon(icon, color: color, size: 24),
          Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTrendsAnalysis() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Text(
            "Health Trends",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildTrendItem("Last Eye Exam", "${analyticsData["last_exam"]}", successColor),
          _buildTrendItem("Next Exam Due", "${analyticsData["next_exam"]}", warningColor),
          _buildTrendItem("Treatment Compliance", "${analyticsData["compliance_rate"]}%", primaryColor)
        ],
      ),
    );
  }

  Widget _buildTrendItem(String label, String value, Color color) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: spSm),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        )
      ],
    );
  }

  Widget _buildRecommendations() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Text(
            "Recommendations",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildRecommendationItem("Schedule annual comprehensive eye exam", Icons.event, primaryColor),
          _buildRecommendationItem("Use artificial tears for dry eyes", Icons.remove_red_eye, infoColor),
          _buildRecommendationItem("Follow 20-20-20 rule for screen time", Icons.computer, warningColor),
          _buildRecommendationItem("Monitor eye pressure regularly", Icons.speed, dangerColor)
        ],
      ),
    );
  }

  Widget _buildRecommendationItem(String text, IconData icon, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        SizedBox(width: spSm),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildLogExamTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Text(
            "Log New Eye Exam",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildExamForm()
        ],
      ),
    );
  }

  Widget _buildExamForm() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          QDropdownField(
            label: "Exam Type",
            items: examTypeItems,
            value: examType,
            onChanged: (value, label) {
              examType = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDatePicker(
                  label: "Exam Date",
                  value: examDate.isNotEmpty ? DateTime.parse(examDate) : DateTime.now(),
                  onChanged: (value) {
                    examDate = value.toString();
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTimePicker(
                  label: "Exam Time",
                  value: examTime.isNotEmpty ? examTime.timeOfDay : TimeOfDay.now(),
                  onChanged: (value) {
                    examTime = value!.kkmm;
                    setState(() {});
                  },
                ),
              )
            ],
          ),
          QTextField(
            label: "Doctor Name",
            value: doctorName,
            onChanged: (value) {
              doctorName = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Vision OD",
                  value: visionOD,
                  hint: "e.g., 20/20",
                  onChanged: (value) {
                    visionOD = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Vision OS",
                  value: visionOS,
                  hint: "e.g., 20/25",
                  onChanged: (value) {
                    visionOS = value;
                    setState(() {});
                  },
                ),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QNumberField(
                  label: "Pressure OD (mmHg)",
                  value: pressureOD,
                  onChanged: (value) {
                    pressureOD = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QNumberField(
                  label: "Pressure OS (mmHg)",
                  value: pressureOS,
                  onChanged: (value) {
                    pressureOS = value;
                    setState(() {});
                  },
                ),
              )
            ],
          ),
          QMemoField(
            label: "Exam Notes",
            value: examNotes,
            hint: "Enter any findings or observations...",
            onChanged: (value) {
              examNotes = value;
              setState(() {});
            },
          ),
          QDatePicker(
            label: "Next Visit Date",
            value: nextVisitDate.isNotEmpty ? DateTime.parse(nextVisitDate) : DateTime.now().add(Duration(days: 365)),
            onChanged: (value) {
              nextVisitDate = value.toString();
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Save Eye Exam",
              size: bs.md,
              onPressed: () {
                ss("Eye exam logged successfully!");
              },
            ),
          )
        ],
      ),
    );
  }
}
