import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaProjectOverviewView extends StatefulWidget {
  const ComaProjectOverviewView({super.key});

  @override
  State<ComaProjectOverviewView> createState() => _ComaProjectOverviewViewState();
}

class _ComaProjectOverviewViewState extends State<ComaProjectOverviewView> {
  String selectedProject = "downtown_office";
  
  List<Map<String, dynamic>> projects = [
    {"label": "Downtown Office Complex", "value": "downtown_office"},
    {"label": "Residential Villa Project", "value": "residential_villa"},
    {"label": "Shopping Mall Renovation", "value": "mall_renovation"},
  ];

  Map<String, dynamic> currentProject = {
    "name": "Downtown Office Complex",
    "status": "In Progress",
    "progress": 65,
    "budget": 2500000,
    "spent": 1625000,
    "startDate": "Aug 15, 2024",
    "endDate": "Dec 15, 2024",
    "teamSize": 12,
    "location": "Downtown Seattle, WA",
    "client": "Metropolitan Holdings",
    "description": "Construction of a modern 25-story office complex with retail space on ground floors. Features sustainable design elements and smart building technology.",
  };

  @override
  Widget build(BuildContext context) {
    double budgetUsed = (currentProject["spent"] as int) / (currentProject["budget"] as int);
    int remainingBudget = (currentProject["budget"] as int) - (currentProject["spent"] as int);

    return Scaffold(
      appBar: AppBar(
        title: Text("Project Overview"),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Edit project
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // More options
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Project Selector
            QDropdownField(
              label: "Select Project",
              items: projects,
              value: selectedProject,
              onChanged: (value, label) {
                selectedProject = value;
                setState(() {});
              },
            ),

            // Project Header
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
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
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${currentProject["name"]}",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "${currentProject["location"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${currentProject["status"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${currentProject["description"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withAlpha(200),
                    ),
                  ),
                ],
              ),
            ),

            // Key Information Cards
            ResponsiveGridView(
              padding: EdgeInsets.all(0),
              minItemWidth: 200,
              children: [
                _buildInfoCard(
                  "Project Progress",
                  "${currentProject["progress"]}%",
                  Icons.trending_up,
                  primaryColor,
                  progress: (currentProject["progress"] as int) / 100,
                ),
                _buildInfoCard(
                  "Budget Used",
                  "${(budgetUsed * 100).toInt()}%",
                  Icons.account_balance_wallet,
                  budgetUsed > 0.8 ? dangerColor : budgetUsed > 0.6 ? warningColor : successColor,
                  progress: budgetUsed,
                ),
                _buildInfoCard(
                  "Team Size",
                  "${currentProject["teamSize"]} members",
                  Icons.people,
                  infoColor,
                ),
                _buildInfoCard(
                  "Days Active",
                  "87 days",
                  Icons.schedule,
                  successColor,
                ),
              ],
            ),

            // Budget Breakdown
            Container(
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
                      Icon(
                        Icons.monetization_on,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Budget Overview",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total Budget",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "\$${((currentProject["budget"] as int).toDouble()).currency}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
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
                              "Amount Spent",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "\$${((currentProject["spent"] as int).toDouble()).currency}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
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
                              "Remaining",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "\$${(remainingBudget.toDouble()).currency}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  LinearProgressIndicator(
                    value: budgetUsed,
                    backgroundColor: disabledColor,
                    valueColor: AlwaysStoppedAnimation(
                      budgetUsed > 0.8 ? dangerColor : budgetUsed > 0.6 ? warningColor : successColor,
                    ),
                  ),
                ],
              ),
            ),

            // Timeline
            Container(
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
                      Icon(
                        Icons.timeline,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Project Timeline",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Start Date",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${currentProject["startDate"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: disabledBoldColor,
                        size: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "End Date",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${currentProject["endDate"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
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

            // Client Information
            Container(
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
                      Icon(
                        Icons.business,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Client Information",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Client Name",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${currentProject["client"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      QButton(
                        label: "Contact",
                        icon: Icons.phone,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
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
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                          label: "View Tasks",
                          icon: Icons.task,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Site Status",
                          icon: Icons.location_on,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Team",
                          icon: Icons.people,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Reports",
                          icon: Icons.assessment,
                          size: bs.sm,
                          onPressed: () {},
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

  Widget _buildInfoCard(String title, String value, IconData icon, Color color, {double? progress}) {
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
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              Spacer(),
              if (progress != null)
                Text(
                  "${(progress * 100).toInt()}%",
                  style: TextStyle(
                    fontSize: 12,
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          if (progress != null)
            LinearProgressIndicator(
              value: progress,
              backgroundColor: disabledColor,
              valueColor: AlwaysStoppedAnimation(color),
            ),
        ],
      ),
    );
  }
}
