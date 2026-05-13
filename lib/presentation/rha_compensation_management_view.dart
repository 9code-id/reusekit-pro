import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaCompensationManagementView extends StatefulWidget {
  const RhaCompensationManagementView({super.key});

  @override
  State<RhaCompensationManagementView> createState() => _RhaCompensationManagementViewState();
}

class _RhaCompensationManagementViewState extends State<RhaCompensationManagementView> {
  int currentTab = 0;
  String selectedDepartment = "all";
  String selectedLevel = "all";
  String selectedType = "all";
  String searchQuery = "";

  List<Map<String, dynamic>> compensationData = [
    {
      "id": "COMP001",
      "employee": "Sarah Johnson",
      "employeeId": "EMP001",
      "department": "Engineering",
      "position": "Senior Developer",
      "level": "L5",
      "baseSalary": 95000.0,
      "bonus": 15000.0,
      "equity": 25000.0,
      "benefits": 18000.0,
      "totalCompensation": 153000.0,
      "currency": "USD",
      "effectiveDate": "2024-01-01",
      "lastReview": "2024-06-15",
      "nextReview": "2024-12-15",
      "performanceRating": 4.5,
      "marketPercentile": 75,
      "avatar": "https://picsum.photos/80/80?random=1&keyword=woman",
      "history": [
        {"date": "2024-06-15", "type": "Merit Increase", "amount": 8000, "reason": "Excellent performance"},
        {"date": "2024-01-01", "type": "Promotion", "amount": 15000, "reason": "Promoted to Senior Developer"},
      ]
    },
    {
      "id": "COMP002",
      "employee": "Michael Chen",
      "employeeId": "EMP002",
      "department": "Marketing",
      "position": "Marketing Manager",
      "level": "M3",
      "baseSalary": 78000.0,
      "bonus": 12000.0,
      "equity": 15000.0,
      "benefits": 15600.0,
      "totalCompensation": 120600.0,
      "currency": "USD",
      "effectiveDate": "2024-03-01",
      "lastReview": "2024-09-15",
      "nextReview": "2025-03-15",
      "performanceRating": 4.2,
      "marketPercentile": 68,
      "avatar": "https://picsum.photos/80/80?random=2&keyword=man",
      "history": [
        {"date": "2024-09-15", "type": "Merit Increase", "amount": 5000, "reason": "Strong campaign results"},
        {"date": "2024-03-01", "type": "Base Adjustment", "amount": 3000, "reason": "Market adjustment"},
      ]
    },
    {
      "id": "COMP003",
      "employee": "Emily Rodriguez",
      "employeeId": "EMP003",
      "department": "Design",
      "position": "UI/UX Designer",
      "level": "D4",
      "baseSalary": 72000.0,
      "bonus": 8000.0,
      "equity": 12000.0,
      "benefits": 14400.0,
      "totalCompensation": 106400.0,
      "currency": "USD",
      "effectiveDate": "2024-02-01",
      "lastReview": "2024-08-15",
      "nextReview": "2025-02-15",
      "performanceRating": 4.0,
      "marketPercentile": 60,
      "avatar": "https://picsum.photos/80/80?random=3&keyword=woman",
      "history": [
        {"date": "2024-08-15", "type": "Merit Increase", "amount": 4000, "reason": "Good performance"},
        {"date": "2024-02-01", "type": "Starting Salary", "amount": 68000, "reason": "New hire"},
      ]
    }
  ];

  List<Map<String, dynamic>> marketData = [
    {
      "position": "Senior Developer",
      "level": "L5",
      "p25": 85000,
      "p50": 95000,
      "p75": 110000,
      "p90": 125000,
      "targetRatio": 1.0,
      "currentAvg": 95000,
    },
    {
      "position": "Marketing Manager",
      "level": "M3",
      "p25": 70000,
      "p50": 80000,
      "p75": 90000,
      "p90": 105000,
      "targetRatio": 0.95,
      "currentAvg": 78000,
    },
    {
      "position": "UI/UX Designer",
      "level": "D4",
      "p25": 65000,
      "p50": 75000,
      "p75": 85000,
      "p90": 95000,
      "targetRatio": 0.90,
      "currentAvg": 72000,
    }
  ];

  List<Map<String, dynamic>> departmentOptions = [
    {"label": "All Departments", "value": "all"},
    {"label": "Engineering", "value": "engineering"},
    {"label": "Marketing", "value": "marketing"},
    {"label": "Design", "value": "design"},
    {"label": "Sales", "value": "sales"},
  ];

  List<Map<String, dynamic>> levelOptions = [
    {"label": "All Levels", "value": "all"},
    {"label": "Entry (L1-L2)", "value": "entry"},
    {"label": "Mid (L3-L4)", "value": "mid"},
    {"label": "Senior (L5-L6)", "value": "senior"},
    {"label": "Staff (L7+)", "value": "staff"},
  ];

  List<Map<String, dynamic>> typeOptions = [
    {"label": "All Components", "value": "all"},
    {"label": "Base Salary", "value": "base"},
    {"label": "Bonus", "value": "bonus"},
    {"label": "Equity", "value": "equity"},
    {"label": "Benefits", "value": "benefits"},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Compensation Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Employees", icon: Icon(Icons.people)),
        Tab(text: "Market Data", icon: Icon(Icons.trending_up)),
        Tab(text: "Analysis", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildEmployeesTab(),
        _buildMarketDataTab(),
        _buildAnalysisTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Summary Stats
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStatCard("Total Compensation", "\$3.8M", Icons.attach_money, primaryColor),
              _buildStatCard("Average Total Comp", "\$126K", Icons.trending_up, successColor),
              _buildStatCard("Merit Increase Budget", "\$380K", Icons.savings, infoColor),
              _buildStatCard("Market Competitiveness", "72%", Icons.speed, warningColor),
            ],
          ),

          // Quick Actions
          Container(
            padding: EdgeInsets.all(spMd),
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
                    color: primaryColor,
                  ),
                ),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Merit Increase Cycle",
                        icon: Icons.trending_up,
                        size: bs.sm,
                        onPressed: () => _startMeritCycle(),
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "Market Analysis",
                        icon: Icons.analytics,
                        size: bs.sm,
                        onPressed: () => _runMarketAnalysis(),
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Budget Planning",
                        icon: Icons.calculate,
                        size: bs.sm,
                        onPressed: () => _openBudgetPlanning(),
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "Export Report",
                        icon: Icons.download,
                        size: bs.sm,
                        onPressed: () => _exportCompensationReport(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Compensation Distribution
          Container(
            padding: EdgeInsets.all(spMd),
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
                  "Compensation Distribution",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...List.generate(4, (index) {
                  final ranges = [
                    {"range": "\$80K - \$100K", "count": 8, "percentage": 33, "color": primaryColor},
                    {"range": "\$100K - \$120K", "count": 6, "percentage": 25, "color": successColor},
                    {"range": "\$120K - \$150K", "count": 7, "percentage": 29, "color": infoColor},
                    {"range": "\$150K+", "count": 3, "percentage": 13, "color": warningColor},
                  ];
                  final range = ranges[index];
                  
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 4,
                          height: 40,
                          decoration: BoxDecoration(
                            color: range["color"] as Color,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${range["range"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${range["count"]} employees",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "${range["percentage"]}%",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: range["color"] as Color,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),

          // Recent Changes
          Container(
            padding: EdgeInsets.all(spMd),
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
                  "Recent Compensation Changes",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...List.generate(3, (index) {
                  final changes = [
                    {"employee": "Sarah Johnson", "type": "Merit Increase", "amount": 8000, "date": "2024-06-15"},
                    {"employee": "Michael Chen", "type": "Merit Increase", "amount": 5000, "date": "2024-09-15"},
                    {"employee": "Emily Rodriguez", "type": "Merit Increase", "amount": 4000, "date": "2024-08-15"},
                  ];
                  final change = changes[index];
                  
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.trending_up,
                          color: successColor,
                          size: 16,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${change["employee"]} - ${change["type"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "${change["date"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "+\$${((change["amount"] as num).toDouble()).currency}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmployeesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Filters
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search employees...",
                        value: searchQuery,
                        hint: "Name or position",
                        onChanged: (value) {
                          searchQuery = value;
                          setState(() {});
                        },
                      ),
                    ),
                    QButton(
                      icon: Icons.search,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Department",
                        items: departmentOptions,
                        value: selectedDepartment,
                        onChanged: (value, label) {
                          selectedDepartment = value;
                          setState(() {});
                        },
                      ),
                    ),
                    Expanded(
                      child: QDropdownField(
                        label: "Level",
                        items: levelOptions,
                        value: selectedLevel,
                        onChanged: (value, label) {
                          selectedLevel = value;
                          setState(() {});
                        },
                      ),
                    ),
                    Expanded(
                      child: QDropdownField(
                        label: "Component",
                        items: typeOptions,
                        value: selectedType,
                        onChanged: (value, label) {
                          selectedType = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Employee Compensation Cards
          ...compensationData.map((compensation) => _buildCompensationCard(compensation)),
        ],
      ),
    );
  }

  Widget _buildMarketDataTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Market Data Overview
          Container(
            padding: EdgeInsets.all(spMd),
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
                    Text(
                      "Market Benchmarking",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "Update Data",
                      icon: Icons.refresh,
                      size: bs.sm,
                      onPressed: () => _updateMarketData(),
                    ),
                  ],
                ),
                Text(
                  "Last updated: December 15, 2024 • Source: Compensation Data Corp",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),

          // Market Data Table
          ...marketData.map((market) => _buildMarketDataCard(market)),
        ],
      ),
    );
  }

  Widget _buildAnalysisTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Analysis Cards
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildAnalyticsCard("Pay Equity Score", "87%", "+3% vs last quarter", successColor),
              _buildAnalyticsCard("Compa-Ratio", "0.98", "Within target range", successColor),
              _buildAnalyticsCard("Turnover Risk", "12%", "-5% vs last quarter", successColor),
              _buildAnalyticsCard("Budget Utilization", "76%", "24% remaining", infoColor),
            ],
          ),

          // Pay Equity Analysis
          Container(
            padding: EdgeInsets.all(spMd),
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
                  "Pay Equity Analysis",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...List.generate(3, (index) {
                  final demographics = [
                    {"category": "Gender", "variance": 2.3, "status": "Within Range", "color": successColor},
                    {"category": "Ethnicity", "variance": 1.8, "status": "Within Range", "color": successColor},
                    {"category": "Experience Level", "variance": 4.1, "status": "Needs Review", "color": warningColor},
                  ];
                  final demo = demographics[index];
                  
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: (demo["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.people,
                            color: demo["color"] as Color,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${demo["category"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${demo["status"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: demo["color"] as Color,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "${demo["variance"]}%",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: demo["color"] as Color,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),

          // Performance vs. Compensation
          Container(
            padding: EdgeInsets.all(spMd),
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
                  "Performance vs. Compensation Correlation",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...List.generate(4, (index) {
                  final performers = [
                    {"rating": "Exceeds (4.5+)", "avgComp": 145000, "count": 3, "color": successColor},
                    {"rating": "Meets+ (4.0-4.4)", "avgComp": 118000, "count": 8, "color": primaryColor},
                    {"rating": "Meets (3.5-3.9)", "avgComp": 102000, "count": 10, "color": infoColor},
                    {"rating": "Below (3.0-3.4)", "avgComp": 89000, "count": 3, "color": warningColor},
                  ];
                  final performer = performers[index];
                  
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 4,
                          height: 40,
                          decoration: BoxDecoration(
                            color: performer["color"] as Color,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${performer["rating"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${performer["count"]} employees",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "\$${((performer["avgComp"] as num) / 1000).toInt()}K",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: performer["color"] as Color,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
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
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              Spacer(),
              Icon(
                Icons.trending_up,
                color: successColor,
                size: 16,
              ),
            ],
          ),
          SizedBox(height: spSm),
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
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsCard(String title, String value, String change, Color changeColor) {
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
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            change,
            style: TextStyle(
              fontSize: 12,
              color: changeColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompensationCard(Map<String, dynamic> compensation) {
    double compaRatio = (compensation["baseSalary"] as num) / 95000.0; // Using market median as example
    Color compaColor = compaRatio >= 0.95 && compaRatio <= 1.05 ? successColor : 
                      compaRatio < 0.95 ? warningColor : dangerColor;

    return Container(
      padding: EdgeInsets.all(spMd),
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
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage("${compensation["avatar"]}"),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${compensation["employee"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${compensation["department"]} • ${compensation["position"]} • ${compensation["level"]}",
                      style: TextStyle(
                        fontSize: 14,
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
                    "\$${((compensation["totalCompensation"] as num) / 1000).toInt()}K",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Total Comp",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          // Compensation Breakdown
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Text("Base Salary:", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                    Spacer(),
                    Text("\$${((compensation["baseSalary"] as num).toDouble()).currency}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                  ],
                ),
                Row(
                  children: [
                    Text("Bonus:", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                    Spacer(),
                    Text("\$${((compensation["bonus"] as num).toDouble()).currency}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                  ],
                ),
                Row(
                  children: [
                    Text("Equity:", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                    Spacer(),
                    Text("\$${((compensation["equity"] as num).toDouble()).currency}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                  ],
                ),
                Row(
                  children: [
                    Text("Benefits:", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                    Spacer(),
                    Text("\$${((compensation["benefits"] as num).toDouble()).currency}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                  ],
                ),
              ],
            ),
          ),

          // Performance & Market Data
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Performance",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      children: [
                        ...List.generate(5, (index) => Icon(
                          index < (compensation["performanceRating"] as num).floor() ? Icons.star : Icons.star_border,
                          color: warningColor,
                          size: 16,
                        )),
                        SizedBox(width: spXs),
                        Text(
                          "${compensation["performanceRating"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
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
                  children: [
                    Text(
                      "Market Position",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${compensation["marketPercentile"]}th percentile",
                      style: TextStyle(
                        fontSize: 12,
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
                      "Compa-Ratio",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${compaRatio.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: compaColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () => _viewCompensationDetails(compensation),
                ),
              ),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () => _editCompensation(compensation),
              ),
              QButton(
                icon: Icons.history,
                size: bs.sm,
                onPressed: () => _viewCompensationHistory(compensation),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMarketDataCard(Map<String, dynamic> market) {
    return Container(
      padding: EdgeInsets.all(spMd),
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${market["position"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Level ${market["level"]}",
                      style: TextStyle(
                        fontSize: 14,
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
                    "\$${((market["currentAvg"] as num) / 1000).toInt()}K",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Current Avg",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          // Market Percentiles
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Text("25th Percentile:", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                    Spacer(),
                    Text("\$${((market["p25"] as num).toDouble()).currency}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                  ],
                ),
                Row(
                  children: [
                    Text("50th Percentile (Median):", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                    Spacer(),
                    Text("\$${((market["p50"] as num).toDouble()).currency}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                  ],
                ),
                Row(
                  children: [
                    Text("75th Percentile:", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                    Spacer(),
                    Text("\$${((market["p75"] as num).toDouble()).currency}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                  ],
                ),
                Row(
                  children: [
                    Text("90th Percentile:", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                    Spacer(),
                    Text("\$${((market["p90"] as num).toDouble()).currency}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                  ],
                ),
              ],
            ),
          ),

          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Target Ratio",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${market["targetRatio"]}",
                      style: TextStyle(
                        fontSize: 14,
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
                      "Competitiveness",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${((market["currentAvg"] as num) / (market["p50"] as num) * 100).toInt()}%",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ),
              QButton(
                label: "View Details",
                size: bs.sm,
                onPressed: () => _viewMarketDetails(market),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _startMeritCycle() {
    // Navigate to merit increase cycle planning
  }

  void _runMarketAnalysis() {
    // Navigate to market analysis tools
  }

  void _openBudgetPlanning() {
    // Navigate to budget planning tools
  }

  void _exportCompensationReport() {
    // Navigate to export compensation report
  }

  void _updateMarketData() {
    // Navigate to update market data functionality
  }

  void _viewCompensationDetails(Map<String, dynamic> compensation) {
    // Navigate to detailed compensation view
  }

  void _editCompensation(Map<String, dynamic> compensation) {
    // Navigate to edit compensation form
  }

  void _viewCompensationHistory(Map<String, dynamic> compensation) {
    // Navigate to compensation history view
  }

  void _viewMarketDetails(Map<String, dynamic> market) {
    // Navigate to detailed market data view
  }
}
