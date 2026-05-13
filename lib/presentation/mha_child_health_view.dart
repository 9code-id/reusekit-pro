import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaChildHealthView extends StatefulWidget {
  const MhaChildHealthView({super.key});

  @override
  State<MhaChildHealthView> createState() => _MhaChildHealthViewState();
}

class _MhaChildHealthViewState extends State<MhaChildHealthView> {
  int selectedTab = 0;
  String selectedChild = "1";
  
  List<Map<String, dynamic>> children = [
    {
      "id": "1",
      "name": "Emma Johnson",
      "age": 12,
      "gender": "Female",
      "dateOfBirth": "2012-03-15",
      "avatar": "https://picsum.photos/80/80?random=1&keyword=girl",
      "bloodType": "O+",
      "height": 152.0,
      "weight": 42.0,
      "allergies": [],
      "vaccinations": 95,
      "lastCheckup": "2024-03-10",
      "pediatrician": "Dr. Sarah Wilson",
      "growthPercentile": {
        "height": 75,
        "weight": 68
      },
      "milestones": [
        {"milestone": "Walking", "achieved": true, "ageAchieved": "12 months"},
        {"milestone": "First Words", "achieved": true, "ageAchieved": "10 months"},
        {"milestone": "Potty Training", "achieved": true, "ageAchieved": "3 years"},
        {"milestone": "Reading", "achieved": true, "ageAchieved": "6 years"},
        {"milestone": "Riding Bike", "achieved": true, "ageAchieved": "7 years"}
      ]
    },
    {
      "id": "2",
      "name": "James Johnson", 
      "age": 8,
      "gender": "Male",
      "dateOfBirth": "2016-07-22",
      "avatar": "https://picsum.photos/80/80?random=2&keyword=boy",
      "bloodType": "A+",
      "height": 130.0,
      "weight": 28.5,
      "allergies": ["Cats"],
      "vaccinations": 92,
      "lastCheckup": "2024-03-10",
      "pediatrician": "Dr. Sarah Wilson",
      "growthPercentile": {
        "height": 65,
        "weight": 72
      },
      "conditions": ["Asthma"],
      "milestones": [
        {"milestone": "Walking", "achieved": true, "ageAchieved": "14 months"},
        {"milestone": "First Words", "achieved": true, "ageAchieved": "11 months"},
        {"milestone": "Potty Training", "achieved": true, "ageAchieved": "3.5 years"},
        {"milestone": "Reading", "achieved": false, "expectedAge": "6-7 years"},
        {"milestone": "Riding Bike", "achieved": false, "expectedAge": "7-8 years"}
      ]
    }
  ];

  List<Map<String, dynamic>> vaccinationSchedule = [
    {
      "vaccine": "MMR Booster",
      "dueDate": "2024-07-15",
      "status": "Due Soon",
      "child": "Emma Johnson"
    },
    {
      "vaccine": "Tdap",
      "dueDate": "2024-08-20", 
      "status": "Scheduled",
      "child": "James Johnson"
    },
    {
      "vaccine": "HPV (1st dose)",
      "dueDate": "2024-09-10",
      "status": "Upcoming",
      "child": "Emma Johnson"
    }
  ];

  List<Map<String, dynamic>> growthData = [
    {"age": "6 months", "height": 65.0, "weight": 7.2},
    {"age": "12 months", "height": 75.0, "weight": 9.8},
    {"age": "18 months", "height": 82.0, "weight": 11.5},
    {"age": "2 years", "height": 87.0, "weight": 13.2},
    {"age": "3 years", "height": 95.0, "weight": 15.8},
    {"age": "4 years", "height": 103.0, "weight": 18.5},
    {"age": "5 years", "height": 110.0, "weight": 21.2},
    {"age": "6 years", "height": 117.0, "weight": 24.0},
    {"age": "7 years", "height": 123.0, "weight": 26.5},
    {"age": "8 years", "height": 130.0, "weight": 28.5}
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Child Health",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.child_care)),
        Tab(text: "Growth", icon: Icon(Icons.trending_up)),
        Tab(text: "Vaccines", icon: Icon(Icons.vaccines)),
        Tab(text: "Milestones", icon: Icon(Icons.emoji_events)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildGrowthTab(),
        _buildVaccinesTab(),
        _buildMilestonesTab(),
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
          Text(
            "Children Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),

          ...children.map((child) => _buildChildOverviewCard(child)),

          // Health Tips for Children
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
                  children: [
                    Icon(Icons.lightbulb, color: warningColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Child Health Tips",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                _buildHealthTip(
                  "Nutrition",
                  "Ensure balanced diet with fruits, vegetables, and whole grains",
                  Icons.restaurant,
                  successColor,
                ),
                _buildHealthTip(
                  "Physical Activity",
                  "Children need at least 60 minutes of physical activity daily",
                  Icons.directions_run,
                  primaryColor,
                ),
                _buildHealthTip(
                  "Sleep Schedule",
                  "School-age children need 9-11 hours of sleep per night",
                  Icons.bedtime,
                  infoColor,
                ),
                _buildHealthTip(
                  "Screen Time",
                  "Limit recreational screen time to 2 hours per day",
                  Icons.screen_lock_portrait,
                  warningColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGrowthTab() {
    final selectedChildData = children.firstWhere(
      (child) => child["id"] == selectedChild,
      orElse: () => children[0],
    );

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Growth Tracking",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),

          // Child Selector
          QDropdownField(
            label: "Select Child",
            items: children.map((child) => {
              "label": "${child["name"]} (${child["age"]} years)",
              "value": child["id"],
            }).toList(),
            value: selectedChild,
            onChanged: (value, label) {
              selectedChild = value;
              setState(() {});
            },
          ),

          // Current Growth Stats
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
                  "Current Measurements",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildGrowthStat(
                        "Height",
                        "${selectedChildData["height"]} cm",
                        "${selectedChildData["growthPercentile"]["height"]}th percentile",
                        Icons.height,
                        primaryColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildGrowthStat(
                        "Weight", 
                        "${selectedChildData["weight"]} kg",
                        "${selectedChildData["growthPercentile"]["weight"]}th percentile",
                        Icons.monitor_weight,
                        successColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildGrowthStat(
                        "Age",
                        "${selectedChildData["age"]} years",
                        "Born ${selectedChildData["dateOfBirth"]}",
                        Icons.cake,
                        infoColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildGrowthStat(
                        "BMI",
                        "${_calculateBMI(selectedChildData["height"], selectedChildData["weight"])}",
                        "Normal range",
                        Icons.fitness_center,
                        warningColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Growth Chart
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
                  "Growth Chart",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.show_chart, size: 48, color: disabledBoldColor),
                      SizedBox(height: spSm),
                      Text(
                        "Growth Chart Visualization",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Track height and weight progress over time",
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

          // Growth History
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
                  "Growth History",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ...growthData.take(5).map((data) => _buildGrowthHistoryItem(data)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVaccinesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Vaccination Summary
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
                  "Vaccination Status",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ...children.map((child) => _buildVaccinationStatus(child)),
              ],
            ),
          ),

          // Upcoming Vaccinations
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
                  "Upcoming Vaccinations",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ...vaccinationSchedule.map((vaccine) => _buildVaccineScheduleItem(vaccine)),
              ],
            ),
          ),

          // Vaccination Reminders
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
                    Icon(Icons.notification_important, color: warningColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Vaccination Reminders",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "• Emma's MMR booster is due in 2 weeks\n• James needs Tdap vaccination next month\n• Schedule Emma's HPV vaccine series",
                  style: TextStyle(
                    color: warningColor,
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

  Widget _buildMilestonesTab() {
    final selectedChildData = children.firstWhere(
      (child) => child["id"] == selectedChild,
      orElse: () => children[0],
    );

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Developmental Milestones",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),

          // Child Selector
          QDropdownField(
            label: "Select Child",
            items: children.map((child) => {
              "label": "${child["name"]} (${child["age"]} years)",
              "value": child["id"],
            }).toList(),
            value: selectedChild,
            onChanged: (value, label) {
              selectedChild = value;
              setState(() {});
            },
          ),

          // Milestones Progress
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
                  "Milestone Progress",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ...(selectedChildData["milestones"] as List).map((milestone) => 
                  _buildMilestoneItem(milestone)
                ),
              ],
            ),
          ),

          // Age-Appropriate Activities
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
                  "Recommended Activities (Age ${selectedChildData["age"]})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildActivityRecommendation(
                  "Physical Development",
                  "Swimming, team sports, bike riding",
                  Icons.directions_run,
                  primaryColor,
                ),
                _buildActivityRecommendation(
                  "Cognitive Development", 
                  "Reading books, puzzles, board games",
                  Icons.psychology,
                  successColor,
                ),
                _buildActivityRecommendation(
                  "Social Development",
                  "Group activities, playdates, team projects",
                  Icons.people,
                  infoColor,
                ),
                _buildActivityRecommendation(
                  "Creative Development",
                  "Art projects, music lessons, creative writing",
                  Icons.palette,
                  warningColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChildOverviewCard(Map<String, dynamic> child) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage("${child["avatar"]}"),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${child["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${child["age"]} years old • ${child["gender"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "Dr. ${child["pediatrician"]}",
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
                icon: Icons.medical_information,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildChildStat("Height", "${child["height"]} cm"),
              ),
              Expanded(
                child: _buildChildStat("Weight", "${child["weight"]} kg"),
              ),
              Expanded(
                child: _buildChildStat("Blood Type", "${child["bloodType"]}"),
              ),
              Expanded(
                child: _buildChildStat("Vaccines", "${child["vaccinations"]}%"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChildStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
      ],
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

  Widget _buildGrowthStat(String label, String value, String subtitle, IconData icon, Color color) {
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
            label,
            style: TextStyle(
              fontSize: 11,
              color: disabledBoldColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 9,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGrowthHistoryItem(Map<String, dynamic> data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "${data["age"]}",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        Text(
          "${data["height"]} cm",
          style: TextStyle(
            color: primaryColor,
            fontSize: 14,
          ),
        ),
        Text(
          "${data["weight"]} kg",
          style: TextStyle(
            color: successColor,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildVaccinationStatus(Map<String, dynamic> child) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage("${child["avatar"]}"),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${child["name"]}",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              Text(
                "Vaccination: ${child["vaccinations"]}% complete",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
          decoration: BoxDecoration(
            color: (child["vaccinations"] >= 90) ? successColor.withAlpha(25) : warningColor.withAlpha(25),
            borderRadius: BorderRadius.circular(radiusXs),
          ),
          child: Text(
            "${child["vaccinations"]}%",
            style: TextStyle(
              color: (child["vaccinations"] >= 90) ? successColor : warningColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVaccineScheduleItem(Map<String, dynamic> vaccine) {
    Color statusColor = vaccine["status"] == "Due Soon" ? dangerColor :
                       vaccine["status"] == "Scheduled" ? warningColor : successColor;

    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: statusColor.withAlpha(25),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Icon(Icons.vaccines, color: statusColor, size: 20),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${vaccine["vaccine"]}",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              Text(
                "${vaccine["child"]} • Due: ${vaccine["dueDate"]}",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 12,
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
            "${vaccine["status"]}",
            style: TextStyle(
              color: statusColor,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMilestoneItem(Map<String, dynamic> milestone) {
    bool achieved = milestone["achieved"] ?? false;
    Color statusColor = achieved ? successColor : warningColor;
    IconData statusIcon = achieved ? Icons.check_circle : Icons.schedule;

    return Row(
      children: [
        Icon(statusIcon, color: statusColor, size: 20),
        SizedBox(width: spSm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${milestone["milestone"]}",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              Text(
                achieved 
                  ? "Achieved at ${milestone["ageAchieved"]}"
                  : "Expected: ${milestone["expectedAge"] ?? "Not specified"}",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 12,
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
            achieved ? "Achieved" : "Pending",
            style: TextStyle(
              color: statusColor,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActivityRecommendation(String title, String activities, IconData icon, Color color) {
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
                activities,
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

  String _calculateBMI(double height, double weight) {
    double heightInMeters = height / 100;
    double bmi = weight / (heightInMeters * heightInMeters);
    return bmi.toStringAsFixed(1);
  }
}
