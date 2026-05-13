import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaPerformanceMetricsView extends StatefulWidget {
  const HhaPerformanceMetricsView({super.key});

  @override
  State<HhaPerformanceMetricsView> createState() => _HhaPerformanceMetricsViewState();
}

class _HhaPerformanceMetricsViewState extends State<HhaPerformanceMetricsView> {
  String selectedPeriod = "This Month";
  String selectedDepartment = "All";
  bool loading = false;
  int currentTab = 0;

  List<Map<String, dynamic>> periodOptions = [
    {"label": "Last 7 Days", "value": "Last 7 Days"},
    {"label": "This Month", "value": "This Month"},
    {"label": "Last Month", "value": "Last Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
  ];

  List<Map<String, dynamic>> departmentOptions = [
    {"label": "All Departments", "value": "All"},
    {"label": "Front Office", "value": "Front Office"},
    {"label": "Housekeeping", "value": "Housekeeping"},
    {"label": "Food & Beverage", "value": "F&B"},
    {"label": "Maintenance", "value": "Maintenance"},
    {"label": "Guest Services", "value": "Guest Services"},
  ];

  List<Map<String, dynamic>> kpiMetrics = [
    {
      "title": "Overall Performance Score",
      "value": 87.5,
      "change": 5.2,
      "target": 85.0,
      "icon": Icons.trending_up,
      "color": 0xFF4CAF50,
      "unit": "%",
    },
    {
      "title": "Guest Satisfaction Score",
      "value": 94.8,
      "change": 2.1,
      "target": 90.0,
      "icon": Icons.star,
      "color": 0xFFFF9800,
      "unit": "%",
    },
    {
      "title": "Staff Efficiency Rating",
      "value": 89.3,
      "change": 3.7,
      "target": 85.0,
      "icon": Icons.people,
      "color": 0xFF2196F3,
      "unit": "%",
    },
    {
      "title": "Revenue Per Guest",
      "value": 245.67,
      "change": 8.9,
      "target": 220.0,
      "icon": Icons.attach_money,
      "color": 0xFF9C27B0,
      "unit": "\$",
    },
  ];

  List<Map<String, dynamic>> departmentPerformance = [
    {
      "department": "Front Office",
      "score": 92.5,
      "change": 4.2,
      "staff": 12,
      "tasks": 156,
      "completed": 144,
      "efficiency": 92.3,
      "color": 0xFF2196F3,
      "icon": Icons.hotel,
    },
    {
      "department": "Housekeeping",
      "score": 89.8,
      "change": 2.8,
      "staff": 18,
      "tasks": 234,
      "completed": 210,
      "efficiency": 89.7,
      "color": 0xFF4CAF50,
      "icon": Icons.cleaning_services,
    },
    {
      "department": "Food & Beverage",
      "score": 85.4,
      "change": 6.1,
      "staff": 24,
      "tasks": 189,
      "completed": 161,
      "efficiency": 85.2,
      "color": 0xFFFF9800,
      "icon": Icons.restaurant,
    },
    {
      "department": "Maintenance",
      "score": 91.2,
      "change": 8.3,
      "staff": 8,
      "tasks": 78,
      "completed": 71,
      "efficiency": 91.0,
      "color": 0xFF9C27B0,
      "icon": Icons.build,
    },
    {
      "department": "Guest Services",
      "score": 88.7,
      "change": 3.5,
      "staff": 6,
      "tasks": 95,
      "completed": 84,
      "efficiency": 88.4,
      "color": 0xFFE91E63,
      "icon": Icons.support_agent,
    },
  ];

  List<Map<String, dynamic>> performanceTrends = [
    {"week": "Week 1", "score": 83.2, "satisfaction": 92.1, "efficiency": 85.4},
    {"week": "Week 2", "score": 85.7, "satisfaction": 93.5, "efficiency": 87.2},
    {"week": "Week 3", "score": 86.9, "satisfaction": 94.2, "efficiency": 88.8},
    {"week": "Week 4", "score": 87.5, "satisfaction": 94.8, "efficiency": 89.3},
  ];

  List<Map<String, dynamic>> topPerformers = [
    {
      "name": "Sarah Johnson",
      "department": "Front Office",
      "score": 96.8,
      "tasks": 45,
      "completed": 44,
      "rating": 4.9,
    },
    {
      "name": "Michael Chen",
      "department": "Housekeeping",
      "score": 94.5,
      "tasks": 52,
      "completed": 49,
      "rating": 4.8,
    },
    {
      "name": "Emma Rodriguez",
      "department": "F&B",
      "score": 93.2,
      "tasks": 38,
      "completed": 36,
      "rating": 4.7,
    },
    {
      "name": "David Wilson",
      "department": "Maintenance",
      "score": 95.1,
      "tasks": 28,
      "completed": 27,
      "rating": 4.9,
    },
    {
      "name": "Lisa Thompson",
      "department": "Guest Services",
      "score": 92.8,
      "tasks": 31,
      "completed": 29,
      "rating": 4.6,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Performance Metrics",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Departments", icon: Icon(Icons.business)),
        Tab(text: "Staff", icon: Icon(Icons.people)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildDepartmentsTab(),
        _buildStaffTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Period Filter
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Time Period",
                  items: periodOptions,
                  value: selectedPeriod,
                  onChanged: (value, label) {
                    selectedPeriod = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Export",
                icon: Icons.download,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: spLg),

          // KPI Metrics
          Text(
            "Key Performance Indicators",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: kpiMetrics.map((metric) {
              final isPositive = (metric["change"] as double) >= 0;
              final isOnTarget = (metric["value"] as double) >= (metric["target"] as double);
              
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
                            color: Color(metric["color"] as int).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            metric["icon"] as IconData,
                            color: Color(metric["color"] as int),
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "${metric["title"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    
                    Text(
                      "${metric["unit"] == "\$" ? "\$" : ""}${(metric["value"] as double).toStringAsFixed(metric["unit"] == "\$" ? 2 : 1)}${metric["unit"] == "%" ? "%" : ""}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    
                    Row(
                      children: [
                        Icon(
                          isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                          color: isPositive ? successColor : dangerColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${isPositive ? '+' : ''}${(metric["change"] as double).toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 12,
                            color: isPositive ? successColor : dangerColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Icon(
                          isOnTarget ? Icons.check_circle : Icons.error,
                          color: isOnTarget ? successColor : warningColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          isOnTarget ? "On Target" : "Below Target",
                          style: TextStyle(
                            fontSize: 12,
                            color: isOnTarget ? successColor : warningColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          SizedBox(height: spLg),

          // Performance Trends Chart
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
                  "Performance Trends",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                
                Container(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: performanceTrends.length,
                    itemBuilder: (context, index) {
                      final trend = performanceTrends[index];
                      final score = (trend["score"] as double);
                      final height = (score / 100) * 150;
                      
                      return Container(
                        width: 80,
                        margin: EdgeInsets.only(right: spMd),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "${score.toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Container(
                              width: 30,
                              height: height,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    primaryColor,
                                    primaryColor.withAlpha(150),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${trend["week"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spLg),

          // Top Performers Preview
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
                Row(
                  children: [
                    Text(
                      "Top Performers This Month",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "View All",
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    final performer = topPerformers[index];
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: index == 0 
                          ? Color(0xFFFFD700).withAlpha(20)
                          : index == 1 
                          ? Color(0xFFC0C0C0).withAlpha(20)
                          : Color(0xFFCD7F32).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: index == 0 
                            ? Color(0xFFFFD700).withAlpha(50)
                            : index == 1 
                            ? Color(0xFFC0C0C0).withAlpha(50)
                            : Color(0xFFCD7F32).withAlpha(50),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: index == 0 
                                ? Color(0xFFFFD700)
                                : index == 1 
                                ? Color(0xFFC0C0C0)
                                : Color(0xFFCD7F32),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                "${index + 1}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${performer["name"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${performer["department"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          Text(
                            "${(performer["score"] as double).toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDepartmentsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Department Filter
          QDropdownField(
            label: "Department",
            items: departmentOptions,
            value: selectedDepartment,
            onChanged: (value, label) {
              selectedDepartment = value;
              setState(() {});
            },
          ),
          SizedBox(height: spLg),

          // Department Performance
          Text(
            "Department Performance",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: departmentPerformance.length,
            itemBuilder: (context, index) {
              final dept = departmentPerformance[index];
              final score = (dept["score"] as double);
              final efficiency = (dept["efficiency"] as double);
              final completed = (dept["completed"] as int);
              final total = (dept["tasks"] as int);
              final completionRate = (completed / total) * 100;
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: Color(dept["color"] as int),
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Color(dept["color"] as int).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            dept["icon"] as IconData,
                            color: Color(dept["color"] as int),
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spSm),
                        
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${dept["department"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${dept["staff"]} staff members",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spMd,
                            vertical: spSm,
                          ),
                          decoration: BoxDecoration(
                            color: score >= 90 
                              ? successColor.withAlpha(20)
                              : score >= 75 
                              ? warningColor.withAlpha(20)
                              : dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${score.toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: score >= 90 
                                ? successColor
                                : score >= 75 
                                ? warningColor
                                : dangerColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    
                    ResponsiveGridView(
                      padding: EdgeInsets.zero,
                      minItemWidth: 200,
                      children: [
                        _buildMetricCard("Task Completion", "${completionRate.toStringAsFixed(1)}%", "$completed/$total tasks"),
                        _buildMetricCard("Efficiency Rating", "${efficiency.toStringAsFixed(1)}%", "vs ${(efficiency - 5).toStringAsFixed(1)}% last month"),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStaffTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Staff Performance Rankings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: topPerformers.length,
            itemBuilder: (context, index) {
              final staff = topPerformers[index];
              final score = (staff["score"] as double);
              final completed = (staff["completed"] as int);
              final total = (staff["tasks"] as int);
              final completionRate = (completed / total) * 100;
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: index < 3 
                          ? (index == 0 ? Color(0xFFFFD700) : index == 1 ? Color(0xFFC0C0C0) : Color(0xFFCD7F32))
                          : primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          "${index + 1}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${staff["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${staff["department"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          
                          Row(
                            children: [
                              Text(
                                "Tasks: $completed/$total",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spMd),
                              Row(
                                children: [
                                  Icon(Icons.star, color: warningColor, size: 16),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${(staff["rating"] as double).toStringAsFixed(1)}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "${score.toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: score >= 95 ? successColor : 
                                   score >= 90 ? warningColor : primaryColor,
                          ),
                        ),
                        Text(
                          "${completionRate.toStringAsFixed(0)}% completion",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, String subtitle) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: primaryColor.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }
}
