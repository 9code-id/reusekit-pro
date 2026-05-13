import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaMensHealthView extends StatefulWidget {
  const HcaMensHealthView({super.key});

  @override
  State<HcaMensHealthView> createState() => _HcaMensHealthViewState();
}

class _HcaMensHealthViewState extends State<HcaMensHealthView> {
  int currentTab = 0;
  String testosteroneLevel = "";
  String psaLevel = "";
  String bloodPressure = "";
  String symptoms = "";
  String exerciseFrequency = "3-4 times per week";
  String stressLevel = "Moderate";

  List<Map<String, dynamic>> exerciseOptions = [
    {"label": "Daily", "value": "Daily"},
    {"label": "5-6 times per week", "value": "5-6 times per week"},
    {"label": "3-4 times per week", "value": "3-4 times per week"},
    {"label": "1-2 times per week", "value": "1-2 times per week"},
    {"label": "Rarely", "value": "Rarely"},
  ];

  List<Map<String, dynamic>> stressOptions = [
    {"label": "Low", "value": "Low"},
    {"label": "Moderate", "value": "Moderate"},
    {"label": "High", "value": "High"},
    {"label": "Very High", "value": "Very High"},
  ];

  List<Map<String, dynamic>> healthMetrics = [
    {
      "id": "1",
      "date": "2024-06-15",
      "testosterone": "520",
      "psa": "1.2",
      "bloodPressure": "128/82",
      "weight": "185",
      "notes": "Regular checkup - all levels within normal range",
    },
    {
      "id": "2",
      "date": "2024-03-15",
      "testosterone": "495",
      "psa": "1.1",
      "bloodPressure": "125/80",
      "weight": "188",
      "notes": "Slight weight increase, recommend more cardio",
    },
    {
      "id": "3",
      "date": "2023-12-15",
      "testosterone": "510",
      "psa": "1.0",
      "bloodPressure": "122/78",
      "weight": "183",
      "notes": "Excellent health markers across the board",
    },
  ];

  List<Map<String, dynamic>> upcomingScreenings = [
    {
      "type": "Prostate Exam",
      "dueDate": "2024-12-15",
      "frequency": "Annual",
      "priority": "High",
      "description": "Digital rectal exam and PSA blood test",
    },
    {
      "type": "Cardiovascular Screening",
      "dueDate": "2024-09-01",
      "frequency": "Annual",
      "priority": "Medium",
      "description": "EKG and cholesterol panel",
    },
    {
      "type": "Testosterone Level Check",
      "dueDate": "2024-08-15",
      "frequency": "Bi-annual",
      "priority": "Medium",
      "description": "Morning blood draw for hormone levels",
    },
    {
      "type": "Colonoscopy",
      "dueDate": "2025-06-15",
      "frequency": "Every 10 years",
      "priority": "Medium",
      "description": "Colorectal cancer screening",
    },
  ];

  List<Map<String, dynamic>> healthTips = [
    {
      "title": "Prostate Health",
      "description": "Regular screening and awareness of symptoms are crucial for early detection",
      "icon": Icons.health_and_safety,
      "category": "Screening",
    },
    {
      "title": "Cardiovascular Health",
      "description": "Men are at higher risk for heart disease - monitor blood pressure and cholesterol",
      "icon": Icons.monitor_heart,
      "category": "Heart",
    },
    {
      "title": "Mental Health",
      "description": "Depression and anxiety in men often go undiagnosed - seek help when needed",
      "icon": Icons.psychology,
      "category": "Mental",
    },
    {
      "title": "Testosterone Health",
      "description": "Low testosterone can affect mood, energy, and muscle mass",
      "icon": Icons.fitness_center,
      "category": "Hormonal",
    },
    {
      "title": "Testicular Health",
      "description": "Perform monthly self-exams and be aware of changes",
      "icon": Icons.medical_services,
      "category": "Screening",
    },
    {
      "title": "Weight Management",
      "description": "Maintain healthy weight through diet and exercise",
      "icon": Icons.monitor_weight,
      "category": "Lifestyle",
    },
  ];

  List<Map<String, dynamic>> fitnessGoals = [
    {
      "title": "Strength Training",
      "current": 3,
      "target": 4,
      "unit": "days/week",
      "progress": 0.75,
    },
    {
      "title": "Cardio Exercise",
      "current": 150,
      "target": 180,
      "unit": "minutes/week",
      "progress": 0.83,
    },
    {
      "title": "Weight Goal",
      "current": 185,
      "target": 180,
      "unit": "lbs",
      "progress": 0.72,
    },
    {
      "title": "Daily Steps",
      "current": 8500,
      "target": 10000,
      "unit": "steps",
      "progress": 0.85,
    },
  ];

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return primaryColor;
    }
  }

  Color _getStressColor(String stress) {
    switch (stress) {
      case "Low":
        return successColor;
      case "Moderate":
        return warningColor;
      case "High":
      case "Very High":
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Men's Health",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Health", icon: Icon(Icons.health_and_safety)),
        Tab(text: "Screening", icon: Icon(Icons.medical_services)),
        Tab(text: "Fitness", icon: Icon(Icons.fitness_center)),
        Tab(text: "Resources", icon: Icon(Icons.info)),
      ],
      tabChildren: [
        _buildHealthTab(),
        _buildScreeningTab(),
        _buildFitnessTab(),
        _buildResourcesTab(),
      ],
      onInit: (tabController) {
        // TabController initialization if needed
      },
    );
  }

  Widget _buildHealthTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Health Metrics Entry
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.health_and_safety, color: primaryColor, size: 24),
                    SizedBox(width: spSm),
                    Text(
                      "Health Metrics",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                QNumberField(
                  label: "Testosterone Level (ng/dL)",
                  value: testosteroneLevel,
                  hint: "Normal range: 300-1000",
                  onChanged: (value) {
                    testosteroneLevel = value;
                    setState(() {});
                  },
                ),
                QNumberField(
                  label: "PSA Level (ng/mL)",
                  value: psaLevel,
                  hint: "Normal range: 0-4.0",
                  onChanged: (value) {
                    psaLevel = value;
                    setState(() {});
                  },
                ),
                QTextField(
                  label: "Blood Pressure",
                  value: bloodPressure,
                  hint: "e.g., 120/80",
                  onChanged: (value) {
                    bloodPressure = value;
                    setState(() {});
                  },
                ),
                QDropdownField(
                  label: "Stress Level",
                  items: stressOptions,
                  value: stressLevel,
                  onChanged: (value, label) {
                    stressLevel = value;
                    setState(() {});
                  },
                ),
                QMemoField(
                  label: "Health Symptoms/Notes",
                  value: symptoms,
                  hint: "Any symptoms or health concerns...",
                  onChanged: (value) {
                    symptoms = value;
                    setState(() {});
                  },
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Log Health Data",
                    size: bs.md,
                    onPressed: () {
                      ss("Health data logged successfully");
                    },
                  ),
                ),
              ],
            ),
          ),

          // Recent Health Data
          Text(
            "Recent Health Data",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...healthMetrics.map((metric) {
            return Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${metric["date"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${metric["weight"]} lbs",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: [
                      _buildMetricCard("Testosterone", "${metric["testosterone"]} ng/dL", successColor),
                      _buildMetricCard("PSA", "${metric["psa"]} ng/mL", infoColor),
                      _buildMetricCard("Blood Pressure", "${metric["bloodPressure"]}", warningColor),
                    ],
                  ),
                  if (metric["notes"] != null)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: Colors.grey.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${metric["notes"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                        ),
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

  Widget _buildMetricCard(String title, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScreeningTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recommended Screenings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...upcomingScreenings.map((screening) {
            return Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: _getPriorityColor("${screening["priority"]}"),
                  ),
                ),
              ),
              child: Column(
                spacing: spXs,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${screening["type"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getPriorityColor("${screening["priority"]}").withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${screening["priority"]} Priority",
                          style: TextStyle(
                            fontSize: 12,
                            color: _getPriorityColor("${screening["priority"]}"),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.schedule, color: disabledBoldColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "Due: ${screening["dueDate"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.repeat, color: disabledBoldColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "Frequency: ${screening["frequency"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${screening["description"]}",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Schedule",
                          size: bs.sm,
                          onPressed: () {
                            ss("Screening scheduled");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Learn More",
                          size: bs.sm,
                          onPressed: () {
                            si("Information displayed");
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),

          // Screening Guidelines
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: infoColor.withAlpha(50)),
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.info, color: infoColor, size: 20),
                    SizedBox(width: spSm),
                    Text(
                      "Screening Guidelines by Age",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "40+: Annual prostate screening\n45+: Cardiovascular screening\n50+: Colonoscopy every 10 years\n65+: Abdominal aortic aneurysm screening",
                  style: TextStyle(
                    color: infoColor,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFitnessTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Fitness Tracking
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.fitness_center, color: primaryColor, size: 24),
                    SizedBox(width: spSm),
                    Text(
                      "Fitness Tracking",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                QDropdownField(
                  label: "Exercise Frequency",
                  items: exerciseOptions,
                  value: exerciseFrequency,
                  onChanged: (value, label) {
                    exerciseFrequency = value;
                    setState(() {});
                  },
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Update Fitness Profile",
                    size: bs.md,
                    onPressed: () {
                      ss("Fitness profile updated");
                    },
                  ),
                ),
              ],
            ),
          ),

          // Fitness Goals
          Text(
            "Fitness Goals",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: fitnessGoals.map((goal) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${goal["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${goal["current"]} ${goal["unit"]}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "/ ${goal["target"]}",
                          style: TextStyle(
                            fontSize: 16,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      height: 8,
                      child: LinearProgressIndicator(
                        value: goal["progress"] as double,
                        backgroundColor: disabledColor,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          (goal["progress"] as double) >= 0.8 ? successColor :
                          (goal["progress"] as double) >= 0.6 ? warningColor : dangerColor,
                        ),
                      ),
                    ),
                    Text(
                      "${((goal["progress"] as double) * 100).toInt()}% Complete",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          // Workout Suggestions
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.sports_gymnastics, color: primaryColor, size: 24),
                    SizedBox(width: spSm),
                    Text(
                      "Recommended Workouts",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Column(
                  spacing: spXs,
                  children: [
                    _buildWorkoutItem("Strength Training", "3-4 times per week", Icons.fitness_center),
                    _buildWorkoutItem("Cardiovascular Exercise", "150 minutes per week", Icons.directions_run),
                    _buildWorkoutItem("Flexibility/Stretching", "Daily", Icons.self_improvement),
                    _buildWorkoutItem("Balance Training", "2-3 times per week", Icons.accessibility_new),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkoutItem(String title, String frequency, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Icon(icon, color: primaryColor, size: 20),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  frequency,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResourcesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Men's Health Tips",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...healthTips.map((tip) {
            return Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      tip["icon"],
                      color: primaryColor,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${tip["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${tip["category"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${tip["description"]}",
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
            );
          }).toList(),

          // Mental Health Resources
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: warningColor.withAlpha(50)),
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.psychology, color: warningColor, size: 20),
                    SizedBox(width: spSm),
                    Text(
                      "Mental Health Resources",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Men's Mental Health Crisis Line: 988\nMen's Health Hotline: (555) 123-4567\nNational Suicide Prevention Lifeline: 988",
                  style: TextStyle(
                    color: warningColor,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),

          // Educational Resources
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.school, color: primaryColor, size: 24),
                    SizedBox(width: spSm),
                    Text(
                      "Educational Resources",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Column(
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.link, color: disabledBoldColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "Men's Health Network",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.link, color: disabledBoldColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "American Urological Association",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.link, color: disabledBoldColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "Movember Foundation",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
