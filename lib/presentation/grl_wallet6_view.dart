import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlWallet6View extends StatefulWidget {
  @override
  State<GrlWallet6View> createState() => _GrlWallet6ViewState();
}

class _GrlWallet6ViewState extends State<GrlWallet6View> {
  List<Map<String, dynamic>> goals = [
    {
      "id": "1",
      "title": "New Car",
      "targetAmount": 25000.0,
      "currentAmount": 18500.0,
      "deadline": "2024-12-31",
      "monthlyTarget": 1200.0,
      "category": "Transportation",
      "icon": Icons.directions_car,
      "color": Colors.blue,
      "priority": "High"
    },
    {
      "id": "2",
      "title": "Vacation to Europe",
      "targetAmount": 8000.0,
      "currentAmount": 3200.0,
      "deadline": "2024-08-15",
      "monthlyTarget": 800.0,
      "category": "Travel",
      "icon": Icons.flight,
      "color": Colors.orange,
      "priority": "Medium"
    },
    {
      "id": "3",
      "title": "Emergency Fund",
      "targetAmount": 15000.0,
      "currentAmount": 9800.0,
      "deadline": "2024-10-30",
      "monthlyTarget": 1000.0,
      "category": "Savings",
      "icon": Icons.security,
      "color": Colors.green,
      "priority": "High"
    },
    {
      "id": "4",
      "title": "Home Down Payment",
      "targetAmount": 50000.0,
      "currentAmount": 22000.0,
      "deadline": "2025-06-30",
      "monthlyTarget": 2000.0,
      "category": "Real Estate",
      "icon": Icons.home,
      "color": Colors.purple,
      "priority": "High"
    },
    {
      "id": "5",
      "title": "Investment Portfolio",
      "targetAmount": 30000.0,
      "currentAmount": 12500.0,
      "deadline": "2025-01-31",
      "monthlyTarget": 1500.0,
      "category": "Investment",
      "icon": Icons.trending_up,
      "color": Colors.teal,
      "priority": "Medium"
    }
  ];

  String selectedFilter = "All";
  List<String> filters = ["All", "High Priority", "Medium Priority", "Near Deadline"];

  List<Map<String, dynamic>> get filteredGoals {
    if (selectedFilter == "All") return goals;
    if (selectedFilter == "High Priority") {
      return goals.where((goal) => goal["priority"] == "High").toList();
    }
    if (selectedFilter == "Medium Priority") {
      return goals.where((goal) => goal["priority"] == "Medium").toList();
    }
    if (selectedFilter == "Near Deadline") {
      return goals.where((goal) {
        DateTime deadline = DateTime.parse(goal["deadline"]);
        DateTime now = DateTime.now();
        return deadline.difference(now).inDays <= 90;
      }).toList();
    }
    return goals;
  }

  double get totalSavingsTarget {
    return goals.fold(0.0, (sum, goal) => sum + (goal["targetAmount"] as double));
  }

  double get totalCurrentSavings {
    return goals.fold(0.0, (sum, goal) => sum + (goal["currentAmount"] as double));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Savings Goals"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Overall Progress
            Container(
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, secondaryColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Text(
                    "Total Savings Progress",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "\$${totalCurrentSavings.currency}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "of \$${totalSavingsTarget.currency} target",
                    style: TextStyle(
                      color: Colors.white.withAlpha(200),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(100),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: (totalCurrentSavings / totalSavingsTarget).clamp(0.0, 1.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "${((totalCurrentSavings / totalSavingsTarget) * 100).toStringAsFixed(1)}% Complete",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            // Filter Options
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: QDropdownField(
                label: "Filter Goals",
                items: filters.map((filter) => {
                  "label": filter,
                  "value": filter,
                }).toList(),
                value: selectedFilter,
                onChanged: (value, label) {
                  selectedFilter = value;
                  setState(() {});
                },
              ),
            ),

            // Quick Stats
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    "Active Goals",
                    "${goals.length}",
                    Icons.flag,
                    primaryColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildStatCard(
                    "Near Deadline",
                    "${goals.where((g) => DateTime.parse(g["deadline"]).difference(DateTime.now()).inDays <= 90).length}",
                    Icons.schedule,
                    warningColor,
                  ),
                ),
              ],
            ),

            // Goals List
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredGoals.length,
              itemBuilder: (context, index) {
                final goal = filteredGoals[index];
                return _buildGoalCard(goal);
              },
            ),

            // Add New Goal Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Create New Goal",
                icon: Icons.add_task,
                size: bs.md,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spXs,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
              color: color,
              size: 22,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildGoalCard(Map<String, dynamic> goal) {
    double progress = (goal["currentAmount"] as double) / (goal["targetAmount"] as double);
    DateTime deadline = DateTime.parse(goal["deadline"]);
    int daysLeft = deadline.difference(DateTime.now()).inDays;
    Color goalColor = goal["color"] as Color;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spSm,
        children: [
          // Header
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: goalColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  goal["icon"] as IconData,
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
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: goal["priority"] == "High" 
                                ? dangerColor.withAlpha(30)
                                : warningColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${goal["priority"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: goal["priority"] == "High" 
                                  ? dangerColor
                                  : warningColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${goal["category"]}",
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

          // Progress
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "\$${(goal["currentAmount"] as double).currency}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          " / \$${(goal["targetAmount"] as double).currency}",
                          style: TextStyle(
                            fontSize: 16,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: goalColor.withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: progress.clamp(0.0, 1.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: goalColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "${(progress * 100).toStringAsFixed(1)}%",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: goalColor,
                ),
              ),
            ],
          ),

          // Details
          Row(
            children: [
              Expanded(
                child: _buildDetailItem(
                  "Monthly Target",
                  "\$${(goal["monthlyTarget"] as double).currency}",
                  Icons.calendar_month,
                ),
              ),
              Expanded(
                child: _buildDetailItem(
                  "Days Left",
                  "$daysLeft days",
                  Icons.schedule,
                ),
              ),
              Expanded(
                child: _buildDetailItem(
                  "Remaining",
                  "\$${((goal["targetAmount"] as double) - (goal["currentAmount"] as double)).currency}",
                  Icons.attach_money,
                ),
              ),
            ],
          ),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Add Money",
                  icon: Icons.add,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "View Details",
                  icon: Icons.visibility,
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

  Widget _buildDetailItem(String title, String value, IconData icon) {
    return Column(
      spacing: spXs,
      children: [
        Icon(
          icon,
          size: 16,
          color: disabledBoldColor,
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
