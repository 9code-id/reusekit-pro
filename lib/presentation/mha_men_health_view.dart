import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaMenHealthView extends StatefulWidget {
  const MhaMenHealthView({super.key});

  @override
  State<MhaMenHealthView> createState() => _MhaMenHealthViewState();
}

class _MhaMenHealthViewState extends State<MhaMenHealthView> {
  int selectedTab = 0;

  Map<String, dynamic> userProfile = {
    "name": "Michael Johnson",
    "age": 38,
    "avatar": "https://picsum.photos/80/80?random=1&keyword=man",
    "height": 178,
    "weight": 75.2,
    "bloodType": "A+",
    "lastCheckup": "2024-04-20",
    "smokingStatus": "Non-smoker",
    "drinkingStatus": "Occasional",
    "exerciseFrequency": "3-4 times/week"
  };

  List<Map<String, dynamic>> healthScreenings = [
    {
      "screening": "Prostate Exam",
      "lastDate": "2024-01-15",
      "nextDue": "2025-01-15",
      "status": "Current",
      "frequency": "Annual (after 40)",
      "icon": Icons.medical_services,
      "ageRecommendation": "40+"
    },
    {
      "screening": "Colonoscopy",
      "lastDate": "2022-06-10",
      "nextDue": "2025-06-10",
      "status": "Due Soon",
      "frequency": "Every 3 years",
      "icon": Icons.health_and_safety,
      "ageRecommendation": "45+"
    },
    {
      "screening": "Blood Pressure",
      "lastDate": "2024-04-20",
      "nextDue": "2024-10-20",
      "status": "Current",
      "frequency": "Every 6 months",
      "icon": Icons.monitor_heart,
      "ageRecommendation": "All ages"
    },
    {
      "screening": "Cholesterol",
      "lastDate": "2024-02-28",
      "nextDue": "2025-02-28",
      "status": "Current",
      "frequency": "Annual",
      "icon": Icons.bloodtype,
      "ageRecommendation": "35+"
    },
    {
      "screening": "Testicular Self-Exam",
      "lastDate": "2024-05-01",
      "nextDue": "2024-06-01",
      "status": "Due Soon",
      "frequency": "Monthly",
      "icon": Icons.self_improvement,
      "ageRecommendation": "15-35"
    }
  ];

  List<Map<String, dynamic>> fitnessMetrics = [
    {
      "metric": "Cardiovascular",
      "current": 78,
      "target": 85,
      "unit": "score",
      "status": "Good",
      "icon": Icons.favorite,
      "color": "success"
    },
    {
      "metric": "Muscle Mass",
      "current": 42.5,
      "target": 45.0,
      "unit": "kg",
      "status": "Below Target",
      "icon": Icons.fitness_center,
      "color": "warning"
    },
    {
      "metric": "Body Fat",
      "current": 18.2,
      "target": 15.0,
      "unit": "%",
      "status": "Above Target",
      "icon": Icons.monitor_weight,
      "color": "danger"
    },
    {
      "metric": "Flexibility",
      "current": 70,
      "target": 80,
      "unit": "score",
      "status": "Fair",
      "icon": Icons.accessibility_new,
      "color": "info"
    }
  ];

  List<Map<String, dynamic>> nutritionGuidelines = [
    {
      "category": "Protein",
      "recommendation": "1.2-1.6g per kg body weight",
      "current": "90g/day",
      "sources": ["Lean meats", "Fish", "Eggs", "Legumes"],
      "icon": Icons.restaurant,
      "color": "primary"
    },
    {
      "category": "Healthy Fats",
      "recommendation": "20-35% of total calories",
      "current": "28%",
      "sources": ["Olive oil", "Nuts", "Avocado", "Fatty fish"],
      "icon": Icons.eco,
      "color": "success"
    },
    {
      "category": "Fiber",
      "recommendation": "38g per day",
      "current": "32g/day",
      "sources": ["Whole grains", "Vegetables", "Fruits", "Beans"],
      "icon": Icons.grass,
      "color": "warning"
    },
    {
      "category": "Water",
      "recommendation": "3.7L per day",
      "current": "3.2L/day",
      "sources": ["Water", "Herbal teas", "Fresh juices"],
      "icon": Icons.water_drop,
      "color": "info"
    }
  ];

  List<Map<String, dynamic>> mentalHealthResources = [
    {
      "topic": "Stress Management",
      "description": "Techniques for managing work and life stress effectively",
      "techniques": ["Deep breathing", "Meditation", "Exercise", "Time management"],
      "icon": Icons.psychology,
      "color": "primary"
    },
    {
      "topic": "Work-Life Balance",
      "description": "Strategies for maintaining healthy boundaries",
      "techniques": ["Set boundaries", "Regular breaks", "Hobbies", "Family time"],
      "icon": Icons.balance,
      "color": "success"
    },
    {
      "topic": "Sleep Hygiene",
      "description": "Improving sleep quality for better mental health",
      "techniques": ["Consistent schedule", "Dark room", "No screens", "Relaxation"],
      "icon": Icons.bedtime,
      "color": "info"
    },
    {
      "topic": "Social Connections",
      "description": "Building and maintaining meaningful relationships",
      "techniques": ["Regular socializing", "Join groups", "Open communication", "Support network"],
      "icon": Icons.people,
      "color": "warning"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Men's Health",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.male)),
        Tab(text: "Screenings", icon: Icon(Icons.health_and_safety)),
        Tab(text: "Fitness", icon: Icon(Icons.fitness_center)),
        Tab(text: "Nutrition", icon: Icon(Icons.restaurant)),
        Tab(text: "Mental Health", icon: Icon(Icons.psychology)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildScreeningsTab(),
        _buildFitnessTab(),
        _buildNutritionTab(),
        _buildMentalHealthTab(),
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
                        "${userProfile["age"]} years old • ${userProfile["height"]} cm",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "Blood Type: ${userProfile["bloodType"]}",
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
                        "Weight",
                        "${userProfile["weight"]} kg",
                        Icons.monitor_weight,
                        primaryColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildSummaryCard(
                        "BMI",
                        "${_calculateBMI()}",
                        Icons.analytics,
                        successColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildSummaryCard(
                        "Last Checkup",
                        "${userProfile["lastCheckup"]}",
                        Icons.medical_information,
                        infoColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildSummaryCard(
                        "Exercise",
                        "${userProfile["exerciseFrequency"]}",
                        Icons.directions_run,
                        warningColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Lifestyle Factors
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
                  "Lifestyle Factors",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildLifestyleFactor(
                  "Smoking Status",
                  "${userProfile["smokingStatus"]}",
                  Icons.smoke_free,
                  successColor,
                ),
                _buildLifestyleFactor(
                  "Alcohol Consumption",
                  "${userProfile["drinkingStatus"]}",
                  Icons.local_bar,
                  warningColor,
                ),
                _buildLifestyleFactor(
                  "Exercise Frequency",
                  "${userProfile["exerciseFrequency"]}",
                  Icons.fitness_center,
                  primaryColor,
                ),
              ],
            ),
          ),

          // Health Alerts
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
                    Icon(Icons.warning, color: warningColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Health Reminders",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "• Colonoscopy screening due in 3 months\n• Monthly testicular self-exam reminder\n• Consider increasing protein intake\n• Schedule annual physical exam",
                  style: TextStyle(
                    color: warningColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // Daily Health Tips
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
                  "Aim for 3.7L of water daily for optimal performance",
                  Icons.water_drop,
                  infoColor,
                ),
                _buildHealthTip(
                  "Strength Training",
                  "Include resistance training 2-3 times per week",
                  Icons.fitness_center,
                  primaryColor,
                ),
                _buildHealthTip(
                  "Heart Health",
                  "Monitor blood pressure and cholesterol regularly",
                  Icons.favorite,
                  dangerColor,
                ),
                _buildHealthTip(
                  "Mental Wellness",
                  "Practice stress management and seek support when needed",
                  Icons.psychology,
                  successColor,
                ),
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
            "Health Screenings for Men",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),

          ...healthScreenings.map((screening) => _buildScreeningCard(screening)),

          // Age-Based Guidelines
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
                  "Age-Based Screening Guidelines",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildAgeGuideline("20s-30s", "Blood pressure, cholesterol, STD testing"),
                _buildAgeGuideline("40s", "Start prostate screening, diabetes testing"),
                _buildAgeGuideline("50s+", "Colonoscopy, bone density, heart disease screening"),
                _buildAgeGuideline("All Ages", "Annual physical exam, dental checkups"),
              ],
            ),
          ),

          // Self-Examination Guide
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: primaryColor.withAlpha(76)),
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.self_improvement, color: primaryColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Self-Examination Guide",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Testicular Self-Exam: Monthly examination after warm shower, check for lumps, changes in size, or unusual pain. Contact healthcare provider if any abnormalities are found.",
                  style: TextStyle(
                    color: primaryColor,
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

  Widget _buildFitnessTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Fitness Metrics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),

          // Fitness Metrics Grid
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: fitnessMetrics.map((metric) {
              Color metricColor = _getColorFromString(metric["color"]);
              return _buildFitnessMetricCard(metric, metricColor);
            }).toList(),
          ),

          // Workout Recommendations
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
                  "Recommended Workouts",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildWorkoutRecommendation(
                  "Strength Training",
                  "2-3 sessions per week, focus on compound movements",
                  ["Squats", "Deadlifts", "Bench Press", "Pull-ups"],
                  Icons.fitness_center,
                  primaryColor,
                ),
                _buildWorkoutRecommendation(
                  "Cardiovascular",
                  "150 minutes moderate or 75 minutes vigorous per week",
                  ["Running", "Cycling", "Swimming", "HIIT"],
                  Icons.directions_run,
                  successColor,
                ),
                _buildWorkoutRecommendation(
                  "Flexibility",
                  "Daily stretching and mobility work",
                  ["Yoga", "Dynamic stretching", "Foam rolling", "Mobility drills"],
                  Icons.accessibility_new,
                  infoColor,
                ),
              ],
            ),
          ),

          // Fitness Goals
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
                      "Fitness Goals",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    QButton(
                      label: "Set Goals",
                      icon: Icons.flag,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
                _buildGoalItem("Increase muscle mass by 2.5kg", "Target: June 2024", 65),
                _buildGoalItem("Reduce body fat to 15%", "Target: August 2024", 40),
                _buildGoalItem("Complete marathon", "Target: October 2024", 80),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Nutrition Guidelines for Men",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),

          ...nutritionGuidelines.map((guideline) => _buildNutritionCard(guideline)),

          // Meal Planning
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
                  "Daily Meal Planning",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildMealPlan("Breakfast", "Oatmeal with berries, Greek yogurt, nuts", "7:00 AM"),
                _buildMealPlan("Mid-Morning", "Protein shake with banana", "10:00 AM"),
                _buildMealPlan("Lunch", "Grilled chicken salad with quinoa", "12:30 PM"),
                _buildMealPlan("Afternoon", "Apple with almond butter", "3:00 PM"),
                _buildMealPlan("Dinner", "Salmon with sweet potato and broccoli", "7:00 PM"),
                _buildMealPlan("Evening", "Casein protein or cottage cheese", "9:00 PM"),
              ],
            ),
          ),

          // Supplements
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
                  "Recommended Supplements",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildSupplementCard("Multivitamin", "Daily comprehensive nutrition support", "Once daily with breakfast"),
                _buildSupplementCard("Vitamin D3", "Bone health and immune function", "2000-4000 IU daily"),
                _buildSupplementCard("Omega-3", "Heart and brain health", "1-2g daily with meals"),
                _buildSupplementCard("Magnesium", "Muscle function and sleep quality", "400mg before bed"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMentalHealthTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Men's Mental Health",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),

          ...mentalHealthResources.map((resource) => _buildMentalHealthCard(resource)),

          // Mental Health Assessment
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
                  "Mental Health Assessment",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildAssessmentItem("Stress Level", "Moderate", warningColor),
                _buildAssessmentItem("Sleep Quality", "Good", successColor),
                _buildAssessmentItem("Energy Level", "High", primaryColor),
                _buildAssessmentItem("Mood Stability", "Stable", successColor),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Take Assessment",
                        icon: Icons.quiz,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Find Therapist",
                        icon: Icons.psychology,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Crisis Resources
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: dangerColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: dangerColor.withAlpha(76)),
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.emergency, color: dangerColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Crisis Resources",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "If you're experiencing thoughts of self-harm or suicide, please reach out immediately:",
                  style: TextStyle(
                    color: dangerColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "• National Suicide Prevention Lifeline: 988\n• Crisis Text Line: Text HOME to 741741\n• Emergency Services: 911",
                  style: TextStyle(
                    color: dangerColor,
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

  Widget _buildLifestyleFactor(String title, String value, IconData icon, Color color) {
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
                value,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
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

  Widget _buildScreeningCard(Map<String, dynamic> screening) {
    Color statusColor = screening["status"] == "Due Soon" ? dangerColor :
                       screening["status"] == "Current" ? successColor : warningColor;

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
                Row(
                  children: [
                    Text(
                      "${screening["frequency"]}",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${screening["ageRecommendation"]}",
                        style: TextStyle(
                          fontSize: 9,
                          color: infoColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
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

  Widget _buildAgeGuideline(String ageGroup, String guideline) {
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

  Widget _buildFitnessMetricCard(Map<String, dynamic> metric, Color color) {
    double progress = ((metric["current"] as num) / (metric["target"] as num)).clamp(0.0, 1.0);
    
    return Container(
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
              Icon(metric["icon"], color: color, size: 20),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${metric["metric"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "${metric["current"]} ${metric["unit"]}",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            "Target: ${metric["target"]} ${metric["unit"]}",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 12,
            ),
          ),
          Container(
            width: double.infinity,
            height: 6,
            decoration: BoxDecoration(
              color: color.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: FractionallySizedBox(
              widthFactor: progress,
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ),
          ),
          Text(
            "${metric["status"]}",
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkoutRecommendation(String title, String description, List<String> exercises, IconData icon, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
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
        ),
        SizedBox(height: spXs),
        Wrap(
          spacing: spXs,
          children: exercises.map((exercise) => 
            Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              decoration: BoxDecoration(
                color: color.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Text(
                exercise,
                style: TextStyle(
                  fontSize: 10,
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ).toList(),
        ),
      ],
    );
  }

  Widget _buildGoalItem(String goal, String target, int progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                goal,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
            Text(
              "$progress%",
              style: TextStyle(
                color: primaryColor,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: spXs),
        Container(
          width: double.infinity,
          height: 6,
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(25),
            borderRadius: BorderRadius.circular(radiusXs),
          ),
          child: FractionallySizedBox(
            widthFactor: progress / 100,
            alignment: Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(radiusXs),
              ),
            ),
          ),
        ),
        SizedBox(height: spXs),
        Text(
          target,
          style: TextStyle(
            color: disabledBoldColor,
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  Widget _buildNutritionCard(Map<String, dynamic> guideline) {
    Color color = _getColorFromString(guideline["color"]);
    
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
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(guideline["icon"], color: color, size: 20),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${guideline["category"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Current: ${guideline["current"]}",
                      style: TextStyle(
                        color: color,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text(
            "Recommendation: ${guideline["recommendation"]}",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 13,
            ),
          ),
          Wrap(
            spacing: spXs,
            children: (guideline["sources"] as List).map((source) => 
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "$source",
                  style: TextStyle(
                    fontSize: 10,
                    color: color,
                  ),
                ),
              ),
            ).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMealPlan(String meal, String food, String time) {
    return Row(
      children: [
        Container(
          width: 60,
          padding: EdgeInsets.symmetric(vertical: spXs),
          child: Text(
            time,
            style: TextStyle(
              color: primaryColor,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                meal,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              Text(
                food,
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

  Widget _buildSupplementCard(String name, String benefit, String dosage) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(25),
            borderRadius: BorderRadius.circular(radiusXs),
          ),
          child: Icon(Icons.medication, color: primaryColor, size: 16),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              Text(
                benefit,
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 11,
                ),
              ),
              Text(
                dosage,
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMentalHealthCard(Map<String, dynamic> resource) {
    Color color = _getColorFromString(resource["color"]);
    
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
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(resource["icon"], color: color, size: 20),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "${resource["topic"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "${resource["description"]}",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 13,
            ),
          ),
          Wrap(
            spacing: spXs,
            children: (resource["techniques"] as List).map((technique) => 
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "$technique",
                  style: TextStyle(
                    fontSize: 10,
                    color: color,
                  ),
                ),
              ),
            ).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAssessmentItem(String category, String status, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          category,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
          decoration: BoxDecoration(
            color: color.withAlpha(25),
            borderRadius: BorderRadius.circular(radiusXs),
          ),
          child: Text(
            status,
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

  String _calculateBMI() {
    double heightInMeters = (userProfile["height"] as int) / 100;
    double bmi = (userProfile["weight"] as double) / (heightInMeters * heightInMeters);
    return bmi.toStringAsFixed(1);
  }

  Color _getColorFromString(String colorString) {
    switch (colorString) {
      case "primary": return primaryColor;
      case "success": return successColor;
      case "warning": return warningColor;
      case "danger": return dangerColor;
      case "info": return infoColor;
      default: return primaryColor;
    }
  }
}
