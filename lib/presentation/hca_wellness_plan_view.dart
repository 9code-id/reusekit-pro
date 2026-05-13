import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaWellnessPlanView extends StatefulWidget {
  const HcaWellnessPlanView({super.key});

  @override
  State<HcaWellnessPlanView> createState() => _HcaWellnessPlanViewState();
}

class _HcaWellnessPlanViewState extends State<HcaWellnessPlanView> {
  String planName = "";
  String planDescription = "";
  String planType = "";
  String duration = "";
  String startDate = "";
  String endDate = "";
  String targetGoal = "";
  String currentPhase = "";
  bool isActive = false;
  bool loading = false;

  List<Map<String, dynamic>> planTypes = [
    {"label": "Weight Loss Plan", "value": "weight_loss"},
    {"label": "Fitness Plan", "value": "fitness"},
    {"label": "Nutrition Plan", "value": "nutrition"},
    {"label": "Mental Wellness Plan", "value": "mental"},
    {"label": "Chronic Disease Management", "value": "chronic"},
    {"label": "Preventive Care Plan", "value": "preventive"},
    {"label": "Recovery Plan", "value": "recovery"},
    {"label": "Maintenance Plan", "value": "maintenance"},
  ];

  List<Map<String, dynamic>> durations = [
    {"label": "1 Month", "value": "1_month"},
    {"label": "3 Months", "value": "3_months"},
    {"label": "6 Months", "value": "6_months"},
    {"label": "1 Year", "value": "1_year"},
    {"label": "Ongoing", "value": "ongoing"},
  ];

  List<Map<String, dynamic>> wellnessPlans = [
    {
      "id": 1,
      "name": "Spring Fitness Challenge",
      "type": "Fitness Plan",
      "description": "12-week comprehensive fitness program focusing on strength and cardio",
      "duration": "3 months",
      "startDate": "2024-03-01",
      "endDate": "2024-05-31",
      "progress": 65,
      "status": "Active",
      "phase": "Week 8 - Strength Focus",
      "goal": "Lose 15 lbs and build muscle",
      "activities": [
        {"name": "Morning Cardio", "frequency": "5x/week", "duration": "30 min", "completed": 85},
        {"name": "Strength Training", "frequency": "3x/week", "duration": "45 min", "completed": 78},
        {"name": "Stretching", "frequency": "Daily", "duration": "15 min", "completed": 92},
      ],
      "milestones": [
        {"name": "Complete Week 4", "date": "2024-03-29", "achieved": true},
        {"name": "Lose 5 lbs", "date": "2024-04-15", "achieved": true},
        {"name": "Increase weights by 20%", "date": "2024-05-01", "achieved": false},
      ],
    },
    {
      "id": 2,
      "name": "Heart Healthy Lifestyle",
      "type": "Chronic Disease Management",
      "description": "Comprehensive plan to manage high blood pressure and cholesterol",
      "duration": "6 months",
      "startDate": "2024-01-15",
      "endDate": "2024-07-15",
      "progress": 40,
      "status": "Active",
      "phase": "Month 3 - Medication Adjustment",
      "goal": "Reduce BP to 120/80 and cholesterol to 180",
      "activities": [
        {"name": "Blood Pressure Monitoring", "frequency": "2x/day", "duration": "5 min", "completed": 95},
        {"name": "DASH Diet", "frequency": "Daily", "duration": "All meals", "completed": 88},
        {"name": "Walking", "frequency": "5x/week", "duration": "30 min", "completed": 70},
      ],
      "milestones": [
        {"name": "Reduce sodium intake", "date": "2024-02-01", "achieved": true},
        {"name": "BP below 140/90", "date": "2024-03-15", "achieved": true},
        {"name": "BP below 130/85", "date": "2024-05-01", "achieved": false},
      ],
    },
    {
      "id": 3,
      "name": "Mindful Living Program",
      "type": "Mental Wellness Plan",
      "description": "8-week program to reduce stress and improve mental clarity",
      "duration": "2 months",
      "startDate": "2024-02-01",
      "endDate": "2024-03-31",
      "progress": 90,
      "status": "Completed",
      "phase": "Program Completed",
      "goal": "Reduce stress levels and improve sleep quality",
      "activities": [
        {"name": "Meditation", "frequency": "Daily", "duration": "20 min", "completed": 94},
        {"name": "Journaling", "frequency": "Daily", "duration": "10 min", "completed": 87},
        {"name": "Breathing Exercises", "frequency": "3x/day", "duration": "5 min", "completed": 91},
      ],
      "milestones": [
        {"name": "Establish daily routine", "date": "2024-02-15", "achieved": true},
        {"name": "Reduce stress score by 30%", "date": "2024-03-01", "achieved": true},
        {"name": "Improve sleep quality", "date": "2024-03-31", "achieved": true},
      ],
    },
  ];

  int selectedPlanId = 0;
  int currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wellness Plans"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showCreatePlanDialog(),
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : QTabBar(
              selectedIndex: currentTabIndex,
              withoutAppBar: true,
              tabs: [
                Tab(text: "Active Plans", icon: Icon(Icons.play_arrow)),
                Tab(text: "Completed", icon: Icon(Icons.check_circle)),
                Tab(text: "Templates", icon: Icon(Icons.library_books)),
              ],
              tabChildren: [
                _buildActivePlansTab(),
                _buildCompletedPlansTab(),
                _buildTemplatesTab(),
              ],
            ),
    );
  }

  Widget _buildActivePlansTab() {
    List<Map<String, dynamic>> activePlans = wellnessPlans
        .where((plan) => plan["status"] == "Active")
        .toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          _buildPlansOverview(),
          _buildQuickActions(),
          if (activePlans.isNotEmpty) ...[
            Text(
              "Active Plans",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            ...activePlans.map((plan) => _buildPlanCard(plan)),
          ] else
            _buildEmptyState(),
        ],
      ),
    );
  }

  Widget _buildCompletedPlansTab() {
    List<Map<String, dynamic>> completedPlans = wellnessPlans
        .where((plan) => plan["status"] == "Completed")
        .toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          _buildCompletedStats(),
          if (completedPlans.isNotEmpty) ...[
            Text(
              "Completed Plans",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            ...completedPlans.map((plan) => _buildPlanCard(plan)),
          ] else
            _buildEmptyCompletedState(),
        ],
      ),
    );
  }

  Widget _buildTemplatesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Wellness Plan Templates",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Choose from our curated wellness plan templates to get started quickly.",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: _buildTemplateCards(),
          ),
        ],
      ),
    );
  }

  Widget _buildPlansOverview() {
    int totalPlans = wellnessPlans.length;
    int activePlans = wellnessPlans.where((plan) => plan["status"] == "Active").length;
    int completedPlans = wellnessPlans.where((plan) => plan["status"] == "Completed").length;
    double avgProgress = wellnessPlans.isEmpty ? 0 : 
        wellnessPlans.map((plan) => plan["progress"] as int).reduce((a, b) => a + b) / wellnessPlans.length;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: primaryColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Wellness Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    spacing: spXs,
                    children: [
                      Text(
                        "$totalPlans",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Total Plans",
                        style: TextStyle(
                          fontSize: 12,
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    spacing: spXs,
                    children: [
                      Text(
                        "$activePlans",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Active",
                        style: TextStyle(
                          fontSize: 12,
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    spacing: spXs,
                    children: [
                      Text(
                        "${avgProgress.toInt()}%",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Avg Progress",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Quick Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Log Activity",
                  size: bs.sm,
                  icon: Icons.add_circle,
                  onPressed: () => _logActivity(),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "View Progress",
                  size: bs.sm,
                  icon: Icons.analytics,
                  onPressed: () => _viewProgress(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlanCard(Map<String, dynamic> plan) {
    Color statusColor = _getStatusColor(plan["status"]);
    double progress = (plan["progress"] as int).toDouble() / 100;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "${plan["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${plan["type"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${plan["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "${plan["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          if (plan["status"] == "Active") ...[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Progress",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${plan["progress"]}%",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: statusColor,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: disabledColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: progress,
                    child: Container(
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.calendar_today, size: 16, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          "Start: ${plan["startDate"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.timer, size: 16, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          "Duration: ${plan["duration"]}",
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          "End: ${plan["endDate"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.my_location, size: 16, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "${plan["phase"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(Icons.flag, size: 16, color: infoColor),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "Goal: ${plan["goal"]}",
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
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () => _viewPlanDetails(plan),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: plan["status"] == "Active" ? "Update" : "Restart",
                  size: bs.sm,
                  onPressed: () => _updatePlan(plan),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCompletedStats() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: successColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: successColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(Icons.emoji_events, color: successColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Achievements",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  spacing: spXs,
                  children: [
                    Text(
                      "1",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Completed Plans",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  spacing: spXs,
                  children: [
                    Text(
                      "8",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Weeks Completed",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  spacing: spXs,
                  children: [
                    Text(
                      "90%",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Success Rate",
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
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        children: [
          Icon(Icons.spa, size: 64, color: disabledColor),
          Text(
            "No Active Plans",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: disabledBoldColor,
            ),
          ),
          Text(
            "Start your wellness journey by creating a personalized plan.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
          QButton(
            label: "Create Your First Plan",
            onPressed: () => _showCreatePlanDialog(),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyCompletedState() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        children: [
          Icon(Icons.check_circle_outline, size: 64, color: disabledColor),
          Text(
            "No Completed Plans Yet",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: disabledBoldColor,
            ),
          ),
          Text(
            "Complete your first wellness plan to see your achievements here.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildTemplateCards() {
    List<Map<String, dynamic>> templates = [
      {
        "name": "Beginner Fitness",
        "description": "4-week starter fitness program",
        "duration": "4 weeks",
        "difficulty": "Beginner",
        "icon": Icons.fitness_center,
        "color": successColor,
      },
      {
        "name": "Weight Loss",
        "description": "12-week comprehensive weight loss plan",
        "duration": "12 weeks",
        "difficulty": "Intermediate",
        "icon": Icons.monitor_weight,
        "color": warningColor,
      },
      {
        "name": "Stress Management",
        "description": "8-week mindfulness and stress reduction",
        "duration": "8 weeks",
        "difficulty": "Beginner",
        "icon": Icons.psychology,
        "color": infoColor,
      },
      {
        "name": "Heart Health",
        "description": "6-month cardiovascular wellness plan",
        "duration": "6 months",
        "difficulty": "Intermediate",
        "icon": Icons.favorite,
        "color": dangerColor,
      },
    ];

    return templates.map((template) {
      return Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusLg),
          boxShadow: [shadowSm],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: template["color"].withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Icon(
                    template["icon"],
                    color: template["color"],
                    size: 24,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        template["name"],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        template["difficulty"],
                        style: TextStyle(
                          fontSize: 12,
                          color: template["color"],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Text(
              template["description"],
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
            Row(
              children: [
                Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                SizedBox(width: spXs),
                Text(
                  template["duration"],
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Use Template",
                size: bs.sm,
                onPressed: () => _useTemplate(template),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Completed":
        return infoColor;
      case "Paused":
        return warningColor;
      case "Cancelled":
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  void _showCreatePlanDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Create Wellness Plan"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              QTextField(
                label: "Plan Name",
                value: planName,
                onChanged: (value) {
                  planName = value;
                  setState(() {});
                },
              ),
              QDropdownField(
                label: "Plan Type",
                items: planTypes,
                value: planType,
                onChanged: (value, label) {
                  planType = value;
                  setState(() {});
                },
              ),
              QDropdownField(
                label: "Duration",
                items: durations,
                value: duration,
                onChanged: (value, label) {
                  duration = value;
                  setState(() {});
                },
              ),
              QTextField(
                label: "Target Goal",
                value: targetGoal,
                onChanged: (value) {
                  targetGoal = value;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _createPlan();
            },
            child: Text("Create Plan"),
          ),
        ],
      ),
    );
  }

  void _viewPlanDetails(Map<String, dynamic> plan) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${plan["name"]}"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Text("Type: ${plan["type"]}"),
              Text("Status: ${plan["status"]}"),
              Text("Progress: ${plan["progress"]}%"),
              Text("Duration: ${plan["duration"]}"),
              Text("Goal: ${plan["goal"]}"),
              Text("Current Phase: ${plan["phase"]}"),
              SizedBox(height: spSm),
              Text(
                "Activities:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              ...(plan["activities"] as List).map((activity) {
                return Text(
                  "• ${activity["name"]} - ${activity["frequency"]} (${activity["completed"]}% completed)",
                  style: TextStyle(fontSize: 12),
                );
              }).toList(),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }

  void _updatePlan(Map<String, dynamic> plan) {
    si("Plan update feature coming soon");
  }

  void _useTemplate(Map<String, dynamic> template) {
    si("Using template: ${template["name"]}");
  }

  void _createPlan() {
    if (planName.isEmpty || planType.isEmpty) {
      se("Please fill in all required fields");
      return;
    }

    ss("Wellness plan created successfully");
    // Reset form
    planName = "";
    planType = "";
    duration = "";
    targetGoal = "";
    setState(() {});
  }

  void _logActivity() {
    si("Activity logging feature coming soon");
  }

  void _viewProgress() {
    si("Progress analytics feature coming soon");
  }
}
