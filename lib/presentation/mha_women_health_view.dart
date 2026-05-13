import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaWomenHealthView extends StatefulWidget {
  const MhaWomenHealthView({super.key});

  @override
  State<MhaWomenHealthView> createState() => _MhaWomenHealthViewState();
}

class _MhaWomenHealthViewState extends State<MhaWomenHealthView> {
  int selectedTab = 0;
  String selectedCycle = "current";
  
  Map<String, dynamic> userProfile = {
    "name": "Sarah Johnson",
    "age": 32,
    "avatar": "https://picsum.photos/80/80?random=1&keyword=woman",
    "lastPeriod": "2024-05-15",
    "cycleLength": 28,
    "periodLength": 5,
    "contraceptionMethod": "Birth Control Pills",
    "pregnancyStatus": "Not Pregnant"
  };

  List<Map<String, dynamic>> cycleHistory = [
    {
      "month": "May 2024",
      "startDate": "2024-05-15",
      "endDate": "2024-05-19",
      "cycleLength": 28,
      "flow": "Medium",
      "symptoms": ["Cramps", "Headache"]
    },
    {
      "month": "April 2024", 
      "startDate": "2024-04-17",
      "endDate": "2024-04-21",
      "cycleLength": 29,
      "flow": "Heavy",
      "symptoms": ["Cramps", "Bloating", "Mood Swings"]
    },
    {
      "month": "March 2024",
      "startDate": "2024-03-20",
      "endDate": "2024-03-24",
      "cycleLength": 27,
      "flow": "Light",
      "symptoms": ["Mild Cramps"]
    }
  ];

  List<Map<String, dynamic>> healthScreenings = [
    {
      "screening": "Mammogram",
      "lastDate": "2024-01-15",
      "nextDue": "2025-01-15",
      "status": "Up to Date",
      "frequency": "Annual",
      "icon": Icons.medical_services
    },
    {
      "screening": "Pap Smear",
      "lastDate": "2023-08-20",
      "nextDue": "2024-08-20",
      "status": "Due Soon",
      "frequency": "Every 3 years",
      "icon": Icons.health_and_safety
    },
    {
      "screening": "Bone Density",
      "lastDate": "2023-03-10",
      "nextDue": "2025-03-10",
      "status": "Current",
      "frequency": "Every 2 years",
      "icon": Icons.accessibility_new
    },
    {
      "screening": "Blood Work",
      "lastDate": "2024-03-05",
      "nextDue": "2025-03-05",
      "status": "Current",
      "frequency": "Annual",
      "icon": Icons.bloodtype
    }
  ];

  List<Map<String, dynamic>> pregnancyInfo = [
    {
      "week": "Week 1-4",
      "title": "Early Pregnancy",
      "description": "Folic acid is crucial for neural tube development",
      "tips": ["Take prenatal vitamins", "Avoid alcohol", "Get adequate rest"]
    },
    {
      "week": "Week 5-12",
      "title": "First Trimester",
      "description": "Morning sickness may occur, focus on nutrition",
      "tips": ["Eat small frequent meals", "Stay hydrated", "Gentle exercise"]
    },
    {
      "week": "Week 13-27",
      "title": "Second Trimester",
      "description": "Energy returns, continue healthy habits",
      "tips": ["Monitor weight gain", "Stay active", "Track baby movements"]
    },
    {
      "week": "Week 28-40",
      "title": "Third Trimester",
      "description": "Prepare for delivery, monitor closely",
      "tips": ["Birth plan preparation", "Hospital bag ready", "Regular checkups"]
    }
  ];

  List<Map<String, dynamic>> menopauseInfo = [
    {
      "stage": "Perimenopause",
      "ageRange": "40-50s",
      "symptoms": ["Irregular periods", "Hot flashes", "Sleep changes"],
      "management": ["Hormone therapy", "Lifestyle changes", "Regular exercise"]
    },
    {
      "stage": "Menopause",
      "ageRange": "50s",
      "symptoms": ["No periods for 12 months", "Night sweats", "Mood changes"],
      "management": ["Calcium supplements", "Heart health focus", "Bone density monitoring"]
    },
    {
      "stage": "Postmenopause",
      "ageRange": "After menopause",
      "symptoms": ["Vaginal dryness", "Joint aches", "Weight changes"],
      "management": ["Regular screenings", "Hormone replacement", "Healthy lifestyle"]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Women's Health",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.female)),
        Tab(text: "Cycle", icon: Icon(Icons.event_repeat)),
        Tab(text: "Screenings", icon: Icon(Icons.health_and_safety)),
        Tab(text: "Pregnancy", icon: Icon(Icons.pregnant_woman)),
        Tab(text: "Menopause", icon: Icon(Icons.elderly_woman)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildCycleTab(),
        _buildScreeningsTab(),
        _buildPregnancyTab(),
        _buildMenopauseTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Profile
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage("${userProfile["avatar"]}"),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${userProfile["name"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${userProfile["age"]} years old",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "${userProfile["pregnancyStatus"]}",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                QButton(
                  icon: Icons.edit,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
          ),

          // Health Summary
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spMd,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Health Summary",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildSummaryCard(
                        "Cycle Length",
                        "${userProfile["cycleLength"]} days",
                        Icons.calendar_month,
                        primaryColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildSummaryCard(
                        "Period Length",
                        "${userProfile["periodLength"]} days",
                        Icons.event,
                        successColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildSummaryCard(
                        "Last Period",
                        "${userProfile["lastPeriod"]}",
                        Icons.event_note,
                        infoColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildSummaryCard(
                        "Contraception",
                        "${userProfile["contraceptionMethod"]}",
                        Icons.medical_information,
                        warningColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Current Cycle Status
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor.withAlpha(25), primaryColor.withAlpha(50)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.favorite, color: primaryColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Current Cycle Status",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Day 15 of your cycle",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Ovulation phase - You may experience increased energy and mood improvements",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 14,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text("Next period in: 13 days", style: TextStyle(color: primaryColor, fontSize: 12)),
                    ),
                    Text("Fertile window: Now", style: TextStyle(color: primaryColor, fontSize: 12, fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          ),

          // Health Tips
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spMd,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Daily Health Tips",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildHealthTip(
                  "Stay Hydrated",
                  "Drink 8-10 glasses of water daily for hormonal balance",
                  Icons.water_drop,
                  infoColor,
                ),
                _buildHealthTip(
                  "Regular Exercise",
                  "30 minutes of moderate exercise can help with cycle regularity",
                  Icons.fitness_center,
                  successColor,
                ),
                _buildHealthTip(
                  "Stress Management",
                  "Practice meditation or yoga to maintain hormonal balance",
                  Icons.self_improvement,
                  warningColor,
                ),
                _buildHealthTip(
                  "Nutrition Focus",
                  "Include iron-rich foods and calcium in your daily diet",
                  Icons.restaurant,
                  primaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCycleTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cycle Tracker
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spMd,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Cycle Tracker",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    QButton(
                      label: "Log Period",
                      icon: Icons.add,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(12),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.calendar_month, size: 48, color: primaryColor),
                      SizedBox(height: spSm),
                      Text(
                        "Cycle Calendar",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Track your menstrual cycle",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Cycle Insights
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spMd,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Cycle Insights",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildInsightCard(
                        "Average Cycle",
                        "28.3 days",
                        "Very Regular",
                        successColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildInsightCard(
                        "Cycle Variation", 
                        "±2 days",
                        "Normal Range",
                        infoColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildInsightCard(
                        "Period Length",
                        "5.2 days",
                        "Consistent",
                        primaryColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildInsightCard(
                        "Flow Pattern",
                        "Medium",
                        "Healthy",
                        warningColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Cycle History
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spMd,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Recent Cycles",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ...cycleHistory.map((cycle) => _buildCycleHistoryItem(cycle)),
              ],
            ),
          ),

          // Symptoms Tracker
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spMd,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Symptoms Tracker",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    QButton(
                      label: "Log Today",
                      icon: Icons.add_circle,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
                _buildSymptomRow("Cramps", "Moderate", Icons.medical_services, dangerColor),
                _buildSymptomRow("Mood", "Good", Icons.sentiment_satisfied, successColor),
                _buildSymptomRow("Energy", "High", Icons.battery_full, primaryColor),
                _buildSymptomRow("Sleep", "Normal", Icons.bedtime, infoColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScreeningsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Health Screenings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),

          ...healthScreenings.map((screening) => _buildScreeningCard(screening)),

          // Screening Reminders
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: warningColor.withAlpha(76)),
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.schedule, color: warningColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Upcoming Reminders",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "• Pap smear due in 2 months\n• Schedule mammogram appointment\n• Update vaccination records",
                  style: TextStyle(
                    color: warningColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // Health Guidelines
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spMd,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Screening Guidelines",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildGuidelineItem("Ages 20-39", "Annual wellness visits, breast self-exams"),
                _buildGuidelineItem("Ages 40-49", "Annual mammograms, consider genetic testing"),
                _buildGuidelineItem("Ages 50+", "Colonoscopy every 10 years, bone density testing"),
                _buildGuidelineItem("All Ages", "Regular pap smears, STD testing as appropriate"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPregnancyTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Pregnancy Planning
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spMd,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Pregnancy Planning",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Start Planning",
                        icon: Icons.baby_changing_station,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Ovulation Tracker",
                        icon: Icons.event_repeat,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                _buildPregnancyTip(
                  "Pre-conception Health",
                  "Start taking folic acid 3 months before trying to conceive",
                  Icons.medical_information,
                  primaryColor,
                ),
                _buildPregnancyTip(
                  "Healthy Lifestyle",
                  "Maintain healthy weight, exercise regularly, avoid alcohol",
                  Icons.fitness_center,
                  successColor,
                ),
                _buildPregnancyTip(
                  "Medical Checkup",
                  "Schedule preconception counseling with your healthcare provider",
                  Icons.local_hospital,
                  infoColor,
                ),
              ],
            ),
          ),

          // Pregnancy Stages
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spMd,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Pregnancy Stages Guide",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ...pregnancyInfo.map((info) => _buildPregnancyStageCard(info)),
              ],
            ),
          ),

          // Pregnancy Checklist
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: successColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: successColor.withAlpha(76)),
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.checklist, color: successColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Pregnancy Checklist",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "✓ Start prenatal vitamins with folic acid\n✓ Schedule first prenatal appointment\n✓ Begin tracking weight and symptoms\n✓ Review medications with doctor\n✓ Plan for lifestyle modifications",
                  style: TextStyle(
                    color: successColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenopauseTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Menopause Health",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),

          ...menopauseInfo.map((info) => _buildMenopauseCard(info)),

          // Menopause Management
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spMd,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Managing Menopause",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildManagementTip(
                  "Hot Flash Relief",
                  "Dress in layers, keep rooms cool, practice deep breathing",
                  Icons.thermostat,
                  dangerColor,
                ),
                _buildManagementTip(
                  "Bone Health",
                  "Increase calcium and vitamin D intake, weight-bearing exercises",
                  Icons.accessibility_new,
                  primaryColor,
                ),
                _buildManagementTip(
                  "Heart Health",
                  "Regular cardio exercise, healthy diet, monitor blood pressure",
                  Icons.favorite,
                  successColor,
                ),
                _buildManagementTip(
                  "Sleep Quality",
                  "Regular sleep schedule, cool bedroom, avoid caffeine",
                  Icons.bedtime,
                  infoColor,
                ),
              ],
            ),
          ),

          // Hormone Therapy Info
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: infoColor.withAlpha(76)),
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.info, color: infoColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Hormone Therapy Options",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Discuss with your healthcare provider about hormone replacement therapy options, benefits, and risks based on your individual health profile.",
                  style: TextStyle(
                    color: infoColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              color: disabledBoldColor,
            ),
          ),
          Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHealthTip(String title, String description, IconData icon, Color color) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color.withAlpha(25),
            borderRadius: BorderRadius.circular(radiusXs),
          ),
          child: Icon(icon, color: color, size: 16),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              Text(
                description,
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInsightCard(String title, String value, String status, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              color: disabledBoldColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            status,
            style: TextStyle(
              fontSize: 10,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCycleHistoryItem(Map<String, dynamic> cycle) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(12),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${cycle["month"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  "${cycle["startDate"]} - ${cycle["endDate"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${cycle["cycleLength"]} days",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                  fontSize: 14,
                ),
              ),
              Text(
                "${cycle["flow"]} flow",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSymptomRow(String symptom, String level, IconData icon, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        SizedBox(width: spSm),
        Expanded(
          child: Text(
            symptom,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
          decoration: BoxDecoration(
            color: color.withAlpha(25),
            borderRadius: BorderRadius.circular(radiusXs),
          ),
          child: Text(
            level,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildScreeningCard(Map<String, dynamic> screening) {
    Color statusColor = screening["status"] == "Due Soon" ? dangerColor :
                       screening["status"] == "Current" || screening["status"] == "Up to Date" ? successColor : warningColor;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: statusColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(screening["icon"], color: statusColor, size: 24),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${screening["screening"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Last: ${screening["lastDate"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
                Text(
                  "Next due: ${screening["nextDue"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
                Text(
                  "${screening["frequency"]}",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: statusColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "${screening["status"]}",
              style: TextStyle(
                color: statusColor,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGuidelineItem(String ageGroup, String guideline) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 6,
          height: 6,
          margin: EdgeInsets.only(top: 6),
          decoration: BoxDecoration(
            color: primaryColor,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ageGroup,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: primaryColor,
                ),
              ),
              Text(
                guideline,
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPregnancyTip(String title, String description, IconData icon, Color color) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color.withAlpha(25),
            borderRadius: BorderRadius.circular(radiusXs),
          ),
          child: Icon(icon, color: color, size: 16),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              Text(
                description,
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPregnancyStageCard(Map<String, dynamic> info) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(12),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "${info["week"]}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                  fontSize: 14,
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "${info["title"]}",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            "${info["description"]}",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 12,
            ),
          ),
          SizedBox(height: spXs),
          Wrap(
            spacing: spXs,
            children: (info["tips"] as List).map((tip) => 
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "$tip",
                  style: TextStyle(
                    fontSize: 10,
                    color: successColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMenopauseCard(Map<String, dynamic> info) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
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
              Text(
                "${info["stage"]}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(width: spSm),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${info["ageRange"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: infoColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "Common Symptoms:",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
          Wrap(
            spacing: spXs,
            children: (info["symptoms"] as List).map((symptom) => 
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "$symptom",
                  style: TextStyle(
                    fontSize: 10,
                    color: warningColor,
                  ),
                ),
              ),
            ).toList(),
          ),
          Text(
            "Management:",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
          Wrap(
            spacing: spXs,
            children: (info["management"] as List).map((management) => 
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "$management",
                  style: TextStyle(
                    fontSize: 10,
                    color: successColor,
                  ),
                ),
              ),
            ).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildManagementTip(String title, String description, IconData icon, Color color) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color.withAlpha(25),
            borderRadius: BorderRadius.circular(radiusXs),
          ),
          child: Icon(icon, color: color, size: 16),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              Text(
                description,
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
