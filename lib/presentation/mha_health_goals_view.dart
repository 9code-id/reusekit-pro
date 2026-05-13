import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaHealthGoalsView extends StatefulWidget {
  const MhaHealthGoalsView({super.key});

  @override
  State<MhaHealthGoalsView> createState() => _MhaHealthGoalsViewState();
}

class _MhaHealthGoalsViewState extends State<MhaHealthGoalsView> {
  List<Map<String, dynamic>> healthGoals = [
    {
      "id": 1,
      "title": "Daily Steps Goal",
      "description": "Walk 10,000 steps every day",
      "category": "Fitness",
      "targetValue": 10000,
      "currentValue": 7500,
      "unit": "steps",
      "progress": 0.75,
      "deadline": "2024-12-31",
      "frequency": "Daily",
      "isActive": true,
      "createdDate": "2024-12-01",
      "icon": "directions_walk",
      "color": "blue",
    },
    {
      "id": 2,
      "title": "Weight Loss",
      "description": "Lose 15 pounds in 3 months",
      "category": "Weight Management",
      "targetValue": 15,
      "currentValue": 8,
      "unit": "lbs",
      "progress": 0.53,
      "deadline": "2025-03-01",
      "frequency": "Weekly",
      "isActive": true,
      "createdDate": "2024-12-01",
      "icon": "monitor_weight",
      "color": "green",
    },
    {
      "id": 3,
      "title": "Water Intake",
      "description": "Drink 8 glasses of water daily",
      "category": "Nutrition",
      "targetValue": 8,
      "currentValue": 6,
      "unit": "glasses",
      "progress": 0.75,
      "deadline": "2024-12-31",
      "frequency": "Daily",
      "isActive": true,
      "createdDate": "2024-11-15",
      "icon": "local_drink",
      "color": "cyan",
    },
    {
      "id": 4,
      "title": "Sleep Schedule",
      "description": "Sleep 8 hours every night",
      "category": "Sleep",
      "targetValue": 8,
      "currentValue": 6.5,
      "unit": "hours",
      "progress": 0.81,
      "deadline": "2024-12-31",
      "frequency": "Daily",
      "isActive": true,
      "createdDate": "2024-11-20",
      "icon": "bedtime",
      "color": "purple",
    },
    {
      "id": 5,
      "title": "Blood Pressure Control",
      "description": "Maintain BP below 120/80",
      "category": "Health Monitoring",
      "targetValue": 120,
      "currentValue": 125,
      "unit": "mmHg",
      "progress": 0.96,
      "deadline": "2025-06-01",
      "frequency": "Weekly",
      "isActive": true,
      "createdDate": "2024-10-01",
      "icon": "monitor_heart",
      "color": "red",
    },
  ];

  String goalTitle = "";
  String goalDescription = "";
  String selectedCategory = "Fitness";
  String targetValue = "";
  String unit = "";
  String selectedFrequency = "Daily";
  String deadline = "";
  String selectedFilter = "All";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Health Goals"),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildProgressOverview(),
            _buildFilterSection(),
            _buildGoalsList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddGoalModal();
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildProgressOverview() {
    var activeGoals = healthGoals.where((goal) => goal["isActive"] == true).length;
    var completedGoals = healthGoals.where((goal) => (goal["progress"] as double) >= 1.0).length;
    var avgProgress = healthGoals.map((goal) => goal["progress"] as double).reduce((a, b) => a + b) / healthGoals.length;

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
                child: _buildOverviewCard(
                  "Active Goals",
                  "$activeGoals",
                  Icons.track_changes,
                  primaryColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildOverviewCard(
                  "Completed",
                  "$completedGoals",
                  Icons.check_circle,
                  successColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildOverviewCard(
                  "Avg Progress",
                  "${(avgProgress * 100).toInt()}%",
                  Icons.trending_up,
                  infoColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(String title, String value, IconData icon, Color color) {
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

  Widget _buildFilterSection() {
    return QDropdownField(
      label: "Filter Goals",
      items: [
        {"label": "All Goals", "value": "All"},
        {"label": "Active", "value": "Active"},
        {"label": "Completed", "value": "Completed"},
        {"label": "Fitness", "value": "Fitness"},
        {"label": "Nutrition", "value": "Nutrition"},
        {"label": "Sleep", "value": "Sleep"},
      ],
      value: selectedFilter,
      onChanged: (value, label) {
        selectedFilter = value;
        setState(() {});
      },
    );
  }

  Widget _buildGoalsList() {
    var filteredGoals = healthGoals;
    
    if (selectedFilter != "All") {
      if (selectedFilter == "Active") {
        filteredGoals = healthGoals.where((goal) => goal["isActive"] == true).toList();
      } else if (selectedFilter == "Completed") {
        filteredGoals = healthGoals.where((goal) => (goal["progress"] as double) >= 1.0).toList();
      } else {
        filteredGoals = healthGoals.where((goal) => goal["category"] == selectedFilter).toList();
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Your Health Goals",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...filteredGoals.map((goal) => _buildGoalItem(goal)).toList(),
      ],
    );
  }

  Widget _buildGoalItem(Map<String, dynamic> goal) {
    Color goalColor = _getGoalColor(goal["color"]);
    IconData goalIcon = _getGoalIcon(goal["icon"]);
    bool isCompleted = (goal["progress"] as double) >= 1.0;

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
            color: goalColor,
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: goalColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  goalIcon,
                  color: goalColor,
                  size: 24,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${goal["title"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        if (isCompleted)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: successColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "COMPLETED",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    Text(
                      "${goal["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: goalColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${goal["category"]} • ${goal["frequency"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: goalColor,
                          fontWeight: FontWeight.w600,
                        ),
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
                            "Progress",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${((goal["progress"] as double) * 100).toInt()}%",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: goalColor,
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
                            "Current / Target",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${goal["currentValue"]} / ${goal["targetValue"]} ${goal["unit"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: disabledColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: goal["progress"] as double,
                    child: Container(
                      decoration: BoxDecoration(
                        color: goalColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Deadline",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${goal["deadline"]}",
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
                            "Created",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${goal["createdDate"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
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
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Update Progress",
                  size: bs.sm,
                  onPressed: () {
                    _showUpdateProgressModal(goal);
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Edit Goal",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getGoalColor(String colorName) {
    switch (colorName) {
      case "blue": return primaryColor;
      case "green": return successColor;
      case "cyan": return infoColor;
      case "purple": return Color(0xFF9C27B0);
      case "red": return dangerColor;
      default: return primaryColor;
    }
  }

  IconData _getGoalIcon(String iconName) {
    switch (iconName) {
      case "directions_walk": return Icons.directions_walk;
      case "monitor_weight": return Icons.monitor_weight;
      case "local_drink": return Icons.local_drink;
      case "bedtime": return Icons.bedtime;
      case "monitor_heart": return Icons.monitor_heart;
      default: return Icons.track_changes;
    }
  }

  void _showAddGoalModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
              Text(
                "Add New Health Goal",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              QTextField(
                label: "Goal Title",
                value: goalTitle,
                hint: "e.g., Daily Exercise",
                onChanged: (value) {
                  goalTitle = value;
                  setState(() {});
                },
              ),
              QTextField(
                label: "Description",
                value: goalDescription,
                hint: "Describe your goal in detail",
                onChanged: (value) {
                  goalDescription = value;
                  setState(() {});
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Category",
                      items: [
                        {"label": "Fitness", "value": "Fitness"},
                        {"label": "Nutrition", "value": "Nutrition"},
                        {"label": "Sleep", "value": "Sleep"},
                        {"label": "Weight Management", "value": "Weight Management"},
                        {"label": "Health Monitoring", "value": "Health Monitoring"},
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
                      label: "Frequency",
                      items: [
                        {"label": "Daily", "value": "Daily"},
                        {"label": "Weekly", "value": "Weekly"},
                        {"label": "Monthly", "value": "Monthly"},
                      ],
                      value: selectedFrequency,
                      onChanged: (value, label) {
                        selectedFrequency = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: QNumberField(
                      label: "Target Value",
                      value: targetValue,
                      onChanged: (value) {
                        targetValue = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QTextField(
                      label: "Unit",
                      value: unit,
                      hint: "steps, lbs, hours, etc.",
                      onChanged: (value) {
                        unit = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              QDatePicker(
                label: "Deadline",
                value: deadline.isNotEmpty ? DateTime.parse(deadline) : DateTime.now().add(Duration(days: 30)),
                onChanged: (value) {
                  deadline = value.toString().substring(0, 10);
                  setState(() {});
                },
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Create Goal",
                  size: bs.md,
                  onPressed: () {
                    _addGoal();
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showUpdateProgressModal(Map<String, dynamic> goal) {
    String newProgress = goal["currentValue"].toString();
    
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
            Text(
              "Update Progress",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Text(
              "${goal["title"]}",
              style: TextStyle(
                fontSize: 16,
                color: disabledBoldColor,
              ),
            ),
            QNumberField(
              label: "Current Progress (${goal["unit"]})",
              value: newProgress,
              onChanged: (value) {
                newProgress = value;
              },
            ),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Update",
                size: bs.md,
                onPressed: () {
                  if (newProgress.isNotEmpty) {
                    double currentValue = double.tryParse(newProgress) ?? 0;
                    double targetValue = (goal["targetValue"] as num).toDouble();
                    
                    goal["currentValue"] = currentValue;
                    goal["progress"] = currentValue / targetValue;
                    
                    setState(() {});
                    Navigator.pop(context);
                    ss("Progress updated successfully");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addGoal() {
    if (goalTitle.isNotEmpty && targetValue.isNotEmpty && unit.isNotEmpty) {
      healthGoals.insert(0, {
        "id": DateTime.now().millisecondsSinceEpoch,
        "title": goalTitle,
        "description": goalDescription,
        "category": selectedCategory,
        "targetValue": double.tryParse(targetValue) ?? 0,
        "currentValue": 0.0,
        "unit": unit,
        "progress": 0.0,
        "deadline": deadline.isNotEmpty ? deadline : DateTime.now().add(Duration(days: 30)).toString().substring(0, 10),
        "frequency": selectedFrequency,
        "isActive": true,
        "createdDate": DateTime.now().toString().substring(0, 10),
        "icon": "track_changes",
        "color": "blue",
      });

      goalTitle = "";
      goalDescription = "";
      targetValue = "";
      unit = "";
      deadline = "";
      setState(() {});
      ss("Health goal created successfully");
    } else {
      se("Please fill in all required fields");
    }
  }
}
