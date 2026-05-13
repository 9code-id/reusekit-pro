import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaReportingAnalyticsView extends StatefulWidget {
  const HhaReportingAnalyticsView({super.key});

  @override
  State<HhaReportingAnalyticsView> createState() => _HhaReportingAnalyticsViewState();
}

class _HhaReportingAnalyticsViewState extends State<HhaReportingAnalyticsView> {
  String selectedPeriod = "This Month";
  String selectedReportType = "All";
  bool loading = false;
  int currentTab = 0;

  List<Map<String, dynamic>> periodOptions = [
    {"label": "Today", "value": "Today"},
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
    {"label": "Custom Range", "value": "Custom Range"},
  ];

  List<Map<String, dynamic>> reportTypeOptions = [
    {"label": "All Reports", "value": "All"},
    {"label": "Financial", "value": "Financial"},
    {"label": "Operational", "value": "Operational"},
    {"label": "Guest Satisfaction", "value": "Guest Satisfaction"},
    {"label": "Staff Performance", "value": "Staff Performance"},
  ];

  List<Map<String, dynamic>> analyticsData = [
    {
      "title": "Total Revenue",
      "value": 145678.50,
      "change": 12.5,
      "period": "vs last month",
      "icon": Icons.attach_money,
      "color": 0xFF4CAF50,
    },
    {
      "title": "Occupancy Rate",
      "value": 87.3,
      "change": 5.2,
      "period": "vs last month",
      "icon": Icons.hotel,
      "color": 0xFF2196F3,
      "isPercentage": true,
    },
    {
      "title": "Guest Satisfaction",
      "value": 94.8,
      "change": -1.2,
      "period": "vs last month",
      "icon": Icons.star,
      "color": 0xFFFF9800,
      "isPercentage": true,
    },
    {
      "title": "Staff Efficiency",
      "value": 89.1,
      "change": 3.7,
      "period": "vs last month",
      "icon": Icons.people,
      "color": 0xFF9C27B0,
      "isPercentage": true,
    },
  ];

  List<Map<String, dynamic>> recentReports = [
    {
      "id": "1",
      "title": "Monthly Revenue Report",
      "type": "Financial",
      "generatedBy": "Sarah Johnson",
      "generatedAt": "2024-03-15T14:30:00Z",
      "status": "Completed",
      "views": 24,
      "downloads": 8,
      "fileSize": "2.4 MB",
    },
    {
      "id": "2",
      "title": "Guest Satisfaction Analysis",
      "type": "Guest Satisfaction",
      "generatedBy": "Michael Chen",
      "generatedAt": "2024-03-14T09:15:00Z",
      "status": "Completed",
      "views": 18,
      "downloads": 12,
      "fileSize": "1.8 MB",
    },
    {
      "id": "3",
      "title": "Operational Efficiency Report",
      "type": "Operational",
      "generatedBy": "Emma Wilson",
      "generatedAt": "2024-03-13T16:45:00Z",
      "status": "Processing",
      "views": 6,
      "downloads": 0,
      "fileSize": "Processing...",
    },
    {
      "id": "4",
      "title": "Staff Performance Review",
      "type": "Staff Performance",
      "generatedBy": "David Rodriguez",
      "generatedAt": "2024-03-12T11:20:00Z",
      "status": "Completed",
      "views": 31,
      "downloads": 15,
      "fileSize": "3.2 MB",
    },
  ];

  List<Map<String, dynamic>> chartData = [
    {"month": "Jan", "revenue": 120000, "occupancy": 78.5, "satisfaction": 92.1},
    {"month": "Feb", "revenue": 135000, "occupancy": 82.3, "satisfaction": 93.4},
    {"month": "Mar", "revenue": 145000, "occupancy": 87.1, "satisfaction": 94.8},
    {"month": "Apr", "revenue": 152000, "occupancy": 89.2, "satisfaction": 95.2},
    {"month": "May", "revenue": 168000, "occupancy": 91.5, "satisfaction": 96.1},
    {"month": "Jun", "revenue": 175000, "occupancy": 93.8, "satisfaction": 95.7},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Reporting & Analytics",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Dashboard", icon: Icon(Icons.dashboard)),
        Tab(text: "Reports", icon: Icon(Icons.description)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildDashboardTab(),
        _buildReportsTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildDashboardTab() {
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

          // Analytics Cards
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
            children: analyticsData.map((data) {
              final isPositive = (data["change"] as double) >= 0;
              
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
                            color: Color(data["color"] as int).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            data["icon"] as IconData,
                            color: Color(data["color"] as int),
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "${data["title"]}",
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
                      data["isPercentage"] == true 
                        ? "${(data["value"] as double).toStringAsFixed(1)}%"
                        : "\$${((data["value"] as double)).currency}",
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
                          "${isPositive ? '+' : ''}${(data["change"] as double).toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 12,
                            color: isPositive ? successColor : dangerColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${data["period"]}",
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
            }).toList(),
          ),
          SizedBox(height: spLg),

          // Chart Preview
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
                      "Revenue Trend",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "View Details",
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                
                Container(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: chartData.length,
                    itemBuilder: (context, index) {
                      final data = chartData[index];
                      final revenue = (data["revenue"] as int).toDouble();
                      final maxRevenue = chartData.map((d) => d["revenue"] as int).reduce((a, b) => a > b ? a : b).toDouble();
                      final height = (revenue / maxRevenue) * 150;
                      
                      return Container(
                        width: 60,
                        margin: EdgeInsets.only(right: spSm),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "\$${(revenue / 1000).toStringAsFixed(0)}K",
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
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${data["month"]}",
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
        ],
      ),
    );
  }

  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search and Filter
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Report Type",
                  items: reportTypeOptions,
                  value: selectedReportType,
                  onChanged: (value, label) {
                    selectedReportType = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Generate New",
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {
                  // navigateTo(HhaGenerateReportView());
                },
              ),
            ],
          ),
          SizedBox(height: spLg),

          // Recent Reports
          Text(
            "Recent Reports",
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
            itemCount: recentReports.length,
            itemBuilder: (context, index) {
              final report = recentReports[index];
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
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
                              Text(
                                "${report["title"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: infoColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${report["type"]}",
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
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: report["status"] == "Completed" 
                              ? successColor.withAlpha(20)
                              : warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${report["status"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: report["status"] == "Completed" 
                                ? successColor
                                : warningColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    
                    Row(
                      children: [
                        Text(
                          "By ${report["generatedBy"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          " • ${DateTime.parse(report["generatedAt"] as String).dMMMy}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    
                    Row(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.visibility, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "${report["views"]} views",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: spMd),
                        Row(
                          children: [
                            Icon(Icons.download, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "${report["downloads"]} downloads",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: spMd),
                        Text(
                          "${report["fileSize"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        if (report["status"] == "Completed")
                          QButton(
                            label: "Download",
                            icon: Icons.download,
                            size: bs.sm,
                            onPressed: () {},
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

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Analytics Categories
          Text(
            "Analytics Categories",
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
            children: [
              _buildAnalyticsCard(
                "Revenue Analytics",
                "Track revenue trends, forecasts, and comparisons",
                Icons.trending_up,
                primaryColor,
              ),
              _buildAnalyticsCard(
                "Guest Analytics",
                "Analyze guest behavior, satisfaction, and preferences",
                Icons.people_alt,
                successColor,
              ),
              _buildAnalyticsCard(
                "Operational Analytics",
                "Monitor operations efficiency and performance",
                Icons.assessment,
                warningColor,
              ),
              _buildAnalyticsCard(
                "Market Analytics",
                "Competitive analysis and market positioning",
                Icons.business_center,
                infoColor,
              ),
            ],
          ),
          SizedBox(height: spLg),

          // Insights
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
                  "AI-Powered Insights",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                
                _buildInsightItem(
                  "Revenue is trending upward by 12.5% this month",
                  "Based on booking patterns and seasonal trends",
                  Icons.trending_up,
                  successColor,
                ),
                _buildInsightItem(
                  "Guest satisfaction dipped slightly in breakfast service",
                  "Consider reviewing breakfast menu and service timing",
                  Icons.restaurant,
                  warningColor,
                ),
                _buildInsightItem(
                  "Weekend occupancy consistently outperforms weekdays",
                  "Opportunity to implement weekend premium pricing",
                  Icons.weekend,
                  infoColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsCard(String title, String description, IconData icon, Color color) {
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
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              height: 1.4,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            child: QButton(
              label: "View Analytics",
              size: bs.sm,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightItem(String title, String description, IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  description,
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
    );
  }
}
