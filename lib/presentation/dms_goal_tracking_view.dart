import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsGoalTrackingView extends StatefulWidget {
  const DmsGoalTrackingView({super.key});

  @override
  State<DmsGoalTrackingView> createState() => _DmsGoalTrackingViewState();
}

class _DmsGoalTrackingViewState extends State<DmsGoalTrackingView> {
  int currentTab = 0;
  String selectedTimeframe = "This Month";
  String selectedGoalStatus = "All";
  String selectedCategory = "All";
  bool showCompletedGoals = true;

  List<Map<String, dynamic>> timeframeOptions = [
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
    {"label": "Custom Range", "value": "Custom Range"},
  ];

  List<Map<String, dynamic>> goalStatusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "Completed", "value": "Completed"},
    {"label": "Paused", "value": "Paused"},
    {"label": "Overdue", "value": "Overdue"},
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All", "value": "All"},
    {"label": "Sales", "value": "Sales"},
    {"label": "Marketing", "value": "Marketing"},
    {"label": "Content", "value": "Content"},
    {"label": "Support", "value": "Support"},
  ];

  List<Map<String, dynamic>> goalMetrics = [
    {
      "title": "Total Goals",
      "value": 24,
      "change": 8.5,
      "icon": Icons.flag,
      "color": primaryColor,
    },
    {
      "title": "Completed",
      "value": 18,
      "change": 12.3,
      "icon": Icons.check_circle,
      "color": successColor,
    },
    {
      "title": "In Progress",
      "value": 6,
      "change": -2.1,
      "icon": Icons.pending,
      "color": warningColor,
    },
    {
      "title": "Success Rate",
      "value": 75.0,
      "change": 5.2,
      "icon": Icons.trending_up,
      "color": infoColor,
      "suffix": "%",
    },
  ];

  List<Map<String, dynamic>> activeGoals = [
    {
      "id": "G001",
      "title": "Increase Email Open Rate",
      "description": "Improve email campaign open rates to 25%",
      "category": "Marketing",
      "target": 25.0,
      "current": 22.3,
      "progress": 89.2,
      "deadline": "2024-02-15",
      "status": "Active",
      "priority": "High",
      "owner": "Sarah Johnson",
      "created_date": "2024-01-01",
    },
    {
      "id": "G002", 
      "title": "Monthly Sales Target",
      "description": "Achieve \$50,000 in monthly sales revenue",
      "category": "Sales",
      "target": 50000.0,
      "current": 42500.0,
      "progress": 85.0,
      "deadline": "2024-01-31",
      "status": "Active",
      "priority": "Critical",
      "owner": "Mike Chen",
      "created_date": "2024-01-01",
    },
    {
      "id": "G003",
      "title": "Website Traffic Growth",
      "description": "Increase organic website traffic by 30%",
      "category": "Marketing",
      "target": 10000.0,
      "current": 8750.0,
      "progress": 87.5,
      "deadline": "2024-02-29",
      "status": "Active",
      "priority": "Medium",
      "owner": "Emma Davis",
      "created_date": "2024-01-15",
    },
    {
      "id": "G004",
      "title": "Customer Support Response Time",
      "description": "Reduce average response time to under 2 hours",
      "category": "Support",
      "target": 2.0,
      "current": 1.8,
      "progress": 90.0,
      "deadline": "2024-01-20",
      "status": "Active",
      "priority": "High",
      "owner": "Alex Rodriguez",
      "created_date": "2024-01-05",
    },
  ];

  List<Map<String, dynamic>> completedGoals = [
    {
      "id": "G005",
      "title": "Q4 Content Strategy",
      "description": "Publish 20 high-quality blog posts in Q4",
      "category": "Content",
      "target": 20.0,
      "current": 22.0,
      "progress": 110.0,
      "deadline": "2023-12-31",
      "status": "Completed",
      "priority": "Medium",
      "owner": "Lisa Wang",
      "completed_date": "2023-12-28",
      "completion_time": "3 days early",
    },
    {
      "id": "G006",
      "title": "Lead Generation Campaign",
      "description": "Generate 500 qualified leads",
      "category": "Marketing", 
      "target": 500.0,
      "current": 623.0,
      "progress": 124.6,
      "deadline": "2023-12-15",
      "status": "Completed",
      "priority": "High",
      "owner": "John Smith",
      "completed_date": "2023-12-10",
      "completion_time": "5 days early",
    },
  ];

  List<Map<String, dynamic>> goalCategories = [
    {
      "category": "Sales",
      "total_goals": 8,
      "completed": 6,
      "success_rate": 75.0,
      "avg_completion_time": "28 days",
      "color": successColor,
    },
    {
      "category": "Marketing",
      "total_goals": 12,
      "completed": 9,
      "success_rate": 75.0,
      "avg_completion_time": "32 days",
      "color": primaryColor,
    },
    {
      "category": "Content",
      "total_goals": 6,
      "completed": 5,
      "success_rate": 83.3,
      "avg_completion_time": "25 days",
      "color": infoColor,
    },
    {
      "category": "Support",
      "total_goals": 4,
      "completed": 3,
      "success_rate": 75.0,
      "avg_completion_time": "15 days",
      "color": warningColor,
    },
  ];

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Filters
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Timeframe",
                  items: timeframeOptions,
                  value: selectedTimeframe,
                  onChanged: (value, label) {
                    selectedTimeframe = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: goalStatusOptions,
                  value: selectedGoalStatus,
                  onChanged: (value, label) {
                    selectedGoalStatus = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          // Metrics Overview
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: goalMetrics.map((metric) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: (metric["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            metric["icon"] as IconData,
                            color: metric["color"] as Color,
                            size: 24,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: (metric["change"] as double) >= 0 ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${(metric["change"] as double) >= 0 ? '+' : ''}${(metric["change"] as double).toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: (metric["change"] as double) >= 0 ? successColor : dangerColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      metric["title"] as String,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${metric["value"]}${metric["suffix"] ?? ''}",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          // Goal Categories Performance
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Performance by Category",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                ...goalCategories.map((category) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          width: 4,
                          color: category["color"] as Color,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                category["category"] as String,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Avg completion: ${category["avg_completion_time"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "${category["completed"]}/${category["total_goals"]} Goals",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${(category["success_rate"] as double).toStringAsFixed(1)}% Success Rate",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: successColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveGoalsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Filters
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: categoryOptions,
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Add Goal",
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {
                  ss("Add goal functionality");
                },
              ),
            ],
          ),

          // Active Goals List
          ...activeGoals.map((goal) {
            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  goal["id"] as String,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: goal["priority"] == "Critical" 
                                        ? dangerColor.withAlpha(20)
                                        : goal["priority"] == "High"
                                            ? warningColor.withAlpha(20)
                                            : primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    goal["priority"] as String,
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: goal["priority"] == "Critical" 
                                          ? dangerColor
                                          : goal["priority"] == "High"
                                              ? warningColor
                                              : primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              goal["title"] as String,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              goal["description"] as String,
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      QButton(
                        icon: Icons.more_vert,
                        size: bs.sm,
                        onPressed: () {
                          ss("Goal options");
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  // Progress Bar
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Progress: ${(goal["progress"] as double).toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${goal["current"]} / ${goal["target"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Container(
                        height: 8,
                        decoration: BoxDecoration(
                          color: disabledColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: (goal["progress"] as double) / 100,
                          child: Container(
                            decoration: BoxDecoration(
                              color: (goal["progress"] as double) >= 90
                                  ? successColor
                                  : (goal["progress"] as double) >= 70
                                      ? warningColor
                                      : primaryColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Goal Details
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Owner",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              goal["owner"] as String,
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
                              "Deadline",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              goal["deadline"] as String,
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
                              "Category",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              goal["category"] as String,
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
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildCompletedGoalsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Toggle Switch
          QSwitch(
            items: [
              {
                "label": "Show Completed Goals",
                "value": true,
                "checked": showCompletedGoals,
              }
            ],
            value: [
              if (showCompletedGoals)
                {
                  "label": "Show Completed Goals",
                  "value": true,
                  "checked": true
                }
            ],
            onChanged: (values, ids) {
              showCompletedGoals = values.isNotEmpty;
              setState(() {});
            },
          ),

          if (showCompletedGoals)
            ...completedGoals.map((goal) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: successColor,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: successColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                goal["title"] as String,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                goal["description"] as String,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "Completed",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: successColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    
                    // Achievement Details
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Achieved",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${goal["current"]} / ${goal["target"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: successColor,
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
                                "Completion",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                goal["completion_time"] as String,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: successColor,
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
                                "Owner",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                goal["owner"] as String,
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
              );
            }).toList(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Goal Tracking",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Active Goals", icon: Icon(Icons.flag)),
        Tab(text: "Completed", icon: Icon(Icons.check_circle)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildActiveGoalsTab(), 
        _buildCompletedGoalsTab(),
      ],
      onInit: (tabController) {},
    );
  }
}
