import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaHealthGoalsView extends StatefulWidget {
  const HcaHealthGoalsView({super.key});

  @override
  State<HcaHealthGoalsView> createState() => _HcaHealthGoalsViewState();
}

class _HcaHealthGoalsViewState extends State<HcaHealthGoalsView> {
  String goalTitle = "";
  String goalDescription = "";
  String goalCategory = "";
  String targetValue = "";
  String currentValue = "";
  String targetDate = "";
  String frequency = "";
  String motivation = "";
  bool isCompleted = false;
  bool loading = false;

  List<Map<String, dynamic>> goalCategories = [
    {"label": "Weight Management", "value": "weight"},
    {"label": "Fitness & Exercise", "value": "fitness"},
    {"label": "Nutrition", "value": "nutrition"},
    {"label": "Mental Health", "value": "mental"},
    {"label": "Sleep", "value": "sleep"},
    {"label": "Chronic Disease", "value": "chronic"},
    {"label": "Preventive Care", "value": "preventive"},
    {"label": "Habits", "value": "habits"},
  ];

  List<Map<String, dynamic>> frequencies = [
    {"label": "Daily", "value": "daily"},
    {"label": "Weekly", "value": "weekly"},
    {"label": "Monthly", "value": "monthly"},
    {"label": "Quarterly", "value": "quarterly"},
    {"label": "Yearly", "value": "yearly"},
  ];

  List<Map<String, dynamic>> healthGoals = [
    {
      "id": 1,
      "title": "Lose 15 pounds",
      "category": "Weight Management",
      "target": "165 lbs",
      "current": "180 lbs",
      "progress": 60,
      "deadline": "2024-06-30",
      "frequency": "Weekly",
      "status": "In Progress",
      "motivation": "Improve overall health and energy levels",
      "milestones": [
        {"target": "175 lbs", "date": "2024-03-15", "achieved": true},
        {"target": "170 lbs", "date": "2024-04-15", "achieved": true},
        {"target": "165 lbs", "date": "2024-06-30", "achieved": false},
      ],
    },
    {
      "id": 2,
      "title": "Exercise 5 times per week",
      "category": "Fitness & Exercise",
      "target": "5 sessions",
      "current": "3 sessions",
      "progress": 40,
      "deadline": "2024-12-31",
      "frequency": "Weekly",
      "status": "In Progress",
      "motivation": "Build strength and cardiovascular health",
      "milestones": [
        {"target": "3 sessions", "date": "2024-02-01", "achieved": true},
        {"target": "4 sessions", "date": "2024-04-01", "achieved": false},
        {"target": "5 sessions", "date": "2024-06-01", "achieved": false},
      ],
    },
    {
      "id": 3,
      "title": "Reduce blood pressure",
      "category": "Chronic Disease",
      "target": "120/80 mmHg",
      "current": "140/90 mmHg",
      "progress": 70,
      "deadline": "2024-08-15",
      "frequency": "Daily",
      "status": "In Progress",
      "motivation": "Prevent cardiovascular complications",
      "milestones": [
        {"target": "135/85 mmHg", "date": "2024-03-01", "achieved": true},
        {"target": "130/82 mmHg", "date": "2024-05-01", "achieved": true},
        {"target": "120/80 mmHg", "date": "2024-08-15", "achieved": false},
      ],
    },
    {
      "id": 4,
      "title": "Sleep 8 hours nightly",
      "category": "Sleep",
      "target": "8 hours",
      "current": "6.5 hours",
      "progress": 25,
      "deadline": "2024-05-01",
      "frequency": "Daily",
      "status": "Needs Attention",
      "motivation": "Improve energy and mental clarity",
      "milestones": [
        {"target": "7 hours", "date": "2024-03-01", "achieved": false},
        {"target": "7.5 hours", "date": "2024-04-01", "achieved": false},
        {"target": "8 hours", "date": "2024-05-01", "achieved": false},
      ],
    },
  ];

  int selectedGoalId = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Health Goals"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showAddGoalDialog(),
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  _buildGoalsOverview(),
                  _buildGoalCategories(),
                  _buildActiveGoals(),
                  _buildGoalInsights(),
                ],
              ),
            ),
    );
  }

  Widget _buildGoalsOverview() {
    int totalGoals = healthGoals.length;
    int inProgressGoals = healthGoals.where((goal) => goal["status"] == "In Progress").length;
    int completedGoals = healthGoals.where((goal) => goal["status"] == "Completed").length;
    int needsAttentionGoals = healthGoals.where((goal) => goal["status"] == "Needs Attention").length;

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
            "Goals Overview",
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
                        "$totalGoals",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Total Goals",
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
                        "$inProgressGoals",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "In Progress",
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
                        "$needsAttentionGoals",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Need Focus",
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

  Widget _buildGoalCategories() {
    Map<String, int> categoryCount = {};
    for (var goal in healthGoals) {
      String category = goal["category"];
      categoryCount[category] = (categoryCount[category] ?? 0) + 1;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Goal Categories",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        QHorizontalScroll(
          children: categoryCount.entries.map((entry) {
            return Container(
              width: 120,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spXs,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      _getCategoryIcon(entry.key),
                      color: primaryColor,
                      size: 20,
                    ),
                  ),
                  Text(
                    entry.key,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "${entry.value} goals",
                    style: TextStyle(
                      fontSize: 10,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildActiveGoals() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Active Goals",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...healthGoals.map((goal) => _buildGoalCard(goal)),
      ],
    );
  }

  Widget _buildGoalCard(Map<String, dynamic> goal) {
    Color statusColor = _getStatusColor(goal["status"]);
    double progress = (goal["progress"] as int).toDouble() / 100;

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
                      "${goal["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${goal["category"]}",
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
                  "${goal["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
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
                    "${goal["progress"]}%",
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
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.track_changes, size: 16, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          "Current: ${goal["current"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.flag, size: 16, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          "Target: ${goal["target"]}",
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
                        Icon(Icons.calendar_today, size: 16, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          "Due: ${goal["deadline"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.repeat, size: 16, color: disabledBoldColor),
                        SizedBox(width: spXs),
                        Text(
                          "${goal["frequency"]}",
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
          if (goal["motivation"] != null && goal["motivation"].isNotEmpty) ...[
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.psychology, size: 16, color: infoColor),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "${goal["motivation"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: infoColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () => _viewGoalDetails(goal),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Update Progress",
                  size: bs.sm,
                  onPressed: () => _updateProgress(goal),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGoalInsights() {
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
              Icon(Icons.insights, color: successColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Goal Insights",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              _buildInsightItem(
                "Most Active Category",
                "Weight Management",
                "3 active goals",
                Icons.trending_up,
              ),
              _buildInsightItem(
                "Next Milestone",
                "Reach 170 lbs",
                "Due in 2 weeks",
                Icons.flag,
              ),
              _buildInsightItem(
                "Success Rate",
                "75%",
                "Above average",
                Icons.stars,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInsightItem(String title, String value, String subtitle, IconData icon) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(spXs),
          decoration: BoxDecoration(
            color: successColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Icon(icon, size: 16, color: successColor),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: successColor,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "Weight Management":
        return Icons.monitor_weight;
      case "Fitness & Exercise":
        return Icons.fitness_center;
      case "Nutrition":
        return Icons.restaurant;
      case "Mental Health":
        return Icons.psychology;
      case "Sleep":
        return Icons.bedtime;
      case "Chronic Disease":
        return Icons.medical_services;
      case "Preventive Care":
        return Icons.health_and_safety;
      case "Habits":
        return Icons.auto_awesome;
      default:
        return Icons.flag;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Completed":
        return successColor;
      case "In Progress":
        return infoColor;
      case "Needs Attention":
        return warningColor;
      case "Overdue":
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  void _showAddGoalDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add New Health Goal"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              QTextField(
                label: "Goal Title",
                value: goalTitle,
                onChanged: (value) {
                  goalTitle = value;
                  setState(() {});
                },
              ),
              QDropdownField(
                label: "Category",
                items: goalCategories,
                value: goalCategory,
                onChanged: (value, label) {
                  goalCategory = value;
                  setState(() {});
                },
              ),
              QTextField(
                label: "Target Value",
                value: targetValue,
                onChanged: (value) {
                  targetValue = value;
                  setState(() {});
                },
              ),
              QDatePicker(
                label: "Target Date",
                value: targetDate.isNotEmpty ? DateTime.parse(targetDate) : DateTime.now(),
                onChanged: (value) {
                  targetDate = value.toString();
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
              _addGoal();
            },
            child: Text("Add Goal"),
          ),
        ],
      ),
    );
  }

  void _viewGoalDetails(Map<String, dynamic> goal) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${goal["title"]}"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Text("Category: ${goal["category"]}"),
              Text("Status: ${goal["status"]}"),
              Text("Current: ${goal["current"]}"),
              Text("Target: ${goal["target"]}"),
              Text("Progress: ${goal["progress"]}%"),
              Text("Deadline: ${goal["deadline"]}"),
              Text("Frequency: ${goal["frequency"]}"),
              if (goal["motivation"] != null)
                Text("Motivation: ${goal["motivation"]}"),
              SizedBox(height: spSm),
              Text(
                "Milestones:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              ...(goal["milestones"] as List).map((milestone) {
                return Row(
                  children: [
                    Icon(
                      milestone["achieved"] ? Icons.check_circle : Icons.radio_button_unchecked,
                      color: milestone["achieved"] ? successColor : disabledColor,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${milestone["target"]} by ${milestone["date"]}",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
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

  void _updateProgress(Map<String, dynamic> goal) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Update Progress"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QTextField(
              label: "Current Value",
              value: currentValue,
              onChanged: (value) {
                currentValue = value;
                setState(() {});
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _saveProgress(goal);
            },
            child: Text("Update"),
          ),
        ],
      ),
    );
  }

  void _addGoal() {
    if (goalTitle.isEmpty || goalCategory.isEmpty) {
      se("Please fill in all required fields");
      return;
    }

    ss("Health goal added successfully");
    // Reset form
    goalTitle = "";
    goalCategory = "";
    targetValue = "";
    targetDate = "";
    setState(() {});
  }

  void _saveProgress(Map<String, dynamic> goal) {
    if (currentValue.isEmpty) {
      se("Please enter current value");
      return;
    }

    ss("Progress updated successfully");
    currentValue = "";
    setState(() {});
  }
}
