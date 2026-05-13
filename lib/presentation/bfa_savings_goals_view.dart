import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaSavingsGoalsView extends StatefulWidget {
  const BfaSavingsGoalsView({super.key});

  @override
  State<BfaSavingsGoalsView> createState() => _BfaSavingsGoalsViewState();
}

class _BfaSavingsGoalsViewState extends State<BfaSavingsGoalsView> {
  String selectedGoalType = "Emergency Fund";
  List<Map<String, dynamic>> savingsGoals = [
    {
      "id": 1,
      "title": "Emergency Fund",
      "targetAmount": 50000.0,
      "currentAmount": 32500.0,
      "deadline": "2025-12-31",
      "category": "Emergency",
      "icon": Icons.security,
      "color": dangerColor,
      "monthlyContribution": 2500.0,
      "priority": "High",
    },
    {
      "id": 2,
      "title": "Vacation to Europe",
      "targetAmount": 25000.0,
      "currentAmount": 18750.0,
      "deadline": "2025-08-15",
      "category": "Travel",
      "icon": Icons.flight,
      "color": primaryColor,
      "monthlyContribution": 1500.0,
      "priority": "Medium",
    },
    {
      "id": 3,
      "title": "New Car",
      "targetAmount": 150000.0,
      "currentAmount": 45000.0,
      "deadline": "2026-06-30",
      "category": "Vehicle",
      "icon": Icons.directions_car,
      "color": successColor,
      "monthlyContribution": 5000.0,
      "priority": "High",
    },
    {
      "id": 4,
      "title": "Wedding Fund",
      "targetAmount": 75000.0,
      "currentAmount": 22500.0,
      "deadline": "2025-10-20",
      "category": "Life Event",
      "icon": Icons.favorite,
      "color": warningColor,
      "monthlyContribution": 3000.0,
      "priority": "High",
    },
    {
      "id": 5,
      "title": "Home Down Payment",
      "targetAmount": 200000.0,
      "currentAmount": 85000.0,
      "deadline": "2027-03-01",
      "category": "Property",
      "icon": Icons.home,
      "color": infoColor,
      "monthlyContribution": 6000.0,
      "priority": "Medium",
    },
  ];

  List<Map<String, dynamic>> goalCategories = [
    {"label": "All Goals", "value": "All"},
    {"label": "Emergency", "value": "Emergency"},
    {"label": "Travel", "value": "Travel"},
    {"label": "Vehicle", "value": "Vehicle"},
    {"label": "Life Event", "value": "Life Event"},
    {"label": "Property", "value": "Property"},
  ];

  String selectedCategory = "All";
  bool showCompleted = false;

  double getTotalSavings() {
    return savingsGoals.fold(0.0, (sum, goal) => sum + (goal["currentAmount"] as double));
  }

  double getTotalTargets() {
    return savingsGoals.fold(0.0, (sum, goal) => sum + (goal["targetAmount"] as double));
  }

  List<Map<String, dynamic>> getFilteredGoals() {
    List<Map<String, dynamic>> filtered = savingsGoals;
    
    if (selectedCategory != "All") {
      filtered = filtered.where((goal) => goal["category"] == selectedCategory).toList();
    }
    
    return filtered;
  }

  double getGoalProgress(Map<String, dynamic> goal) {
    double current = goal["currentAmount"] as double;
    double target = goal["targetAmount"] as double;
    return (current / target * 100).clamp(0.0, 100.0);
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredGoals = getFilteredGoals();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Savings Goals"),
        actions: [
          IconButton(
            onPressed: () {
              // Add new goal
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Overview Cards
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.savings,
                              color: primaryColor,
                              size: 20,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Total Saved",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "\$${getTotalSavings().currency}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
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
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.track_changes,
                              color: successColor,
                              size: 20,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Total Target",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "\$${getTotalTargets().currency}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Progress Overview
            Container(
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
                  Row(
                    children: [
                      Icon(
                        Icons.trending_up,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Overall Progress",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 8,
                          decoration: BoxDecoration(
                            color: disabledColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: (getTotalSavings() / getTotalTargets()).clamp(0.0, 1.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "${((getTotalSavings() / getTotalTargets()) * 100).toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Filter
            QDropdownField(
              label: "Category Filter",
              items: goalCategories,
              value: selectedCategory,
              onChanged: (value, label) {
                selectedCategory = value;
                setState(() {});
              },
            ),

            // Goals List
            Text(
              "Your Goals (${filteredGoals.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            Column(
              spacing: spSm,
              children: filteredGoals.map((goal) {
                double progress = getGoalProgress(goal);
                DateTime deadline = DateTime.parse(goal["deadline"]);
                int daysLeft = deadline.difference(DateTime.now()).inDays;
                
                return Container(
                  padding: EdgeInsets.all(spSm),
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
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: (goal["color"] as Color).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              goal["icon"] as IconData,
                              color: goal["color"] as Color,
                              size: 24,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${goal["title"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${goal["category"]} • ${goal["priority"]} Priority",
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
                              Text(
                                "\$${(goal["currentAmount"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: goal["color"] as Color,
                                ),
                              ),
                              Text(
                                "of \$${(goal["targetAmount"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 8,
                              decoration: BoxDecoration(
                                color: disabledColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: (progress / 100).clamp(0.0, 1.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: goal["color"] as Color,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "${progress.toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: goal["color"] as Color,
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  size: 16,
                                  color: daysLeft < 30 ? dangerColor : disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "$daysLeft days left",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: daysLeft < 30 ? dangerColor : disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.trending_up,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "\$${(goal["monthlyContribution"] as double).currency}/month",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "Add Money",
                              icon: Icons.add,
                              size: bs.sm,
                              onPressed: () {
                                // Add contribution
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QButton(
                              label: "View Details",
                              icon: Icons.visibility,
                              size: bs.sm,
                              onPressed: () {
                                // View goal details
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Quick Actions
            Container(
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
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Create New Goal",
                          icon: Icons.add_circle,
                          size: bs.sm,
                          onPressed: () {
                            // Create new goal
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Auto Save Settings",
                          icon: Icons.settings,
                          size: bs.sm,
                          onPressed: () {
                            // Auto save settings
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
