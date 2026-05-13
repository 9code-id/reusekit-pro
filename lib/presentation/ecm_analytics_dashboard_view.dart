import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmAnalyticsDashboardView extends StatefulWidget {
  const EcmAnalyticsDashboardView({super.key});

  @override
  State<EcmAnalyticsDashboardView> createState() => _EcmAnalyticsDashboardViewState();
}

class _EcmAnalyticsDashboardViewState extends State<EcmAnalyticsDashboardView> {
  int selectedTab = 0;
  String selectedTimeframe = "event";
  
  Map<String, dynamic> dashboardData = {
    "overview": {
      "totalRegistrations": 1456,
      "totalAttendees": 1247,
      "attendanceRate": 85.6,
      "averageRating": 4.3,
      "npsScore": 67,
      "totalSessions": 28,
      "totalSpeakers": 18,
      "networkingConnections": 2834
    },
    "registrationTrend": [
      {"period": "Week 1", "registrations": 123, "attendees": 98},
      {"period": "Week 2", "registrations": 245, "attendees": 203},
      {"period": "Week 3", "registrations": 398, "attendees": 332},
      {"period": "Week 4", "registrations": 567, "attendees": 478},
      {"period": "Event Week", "registrations": 123, "attendees": 136},
    ],
    "sessionPerformance": [
      {
        "session": "AI Marketing Strategies",
        "attendance": 89,
        "capacity": 100,
        "rating": 4.7,
        "feedback": 67,
        "engagement": 85
      },
      {
        "session": "Digital Transformation Keynote",
        "attendance": 234,
        "capacity": 250,
        "rating": 4.5,
        "feedback": 189,
        "engagement": 78
      },
      {
        "session": "Future of E-commerce",
        "attendance": 156,
        "capacity": 150,
        "rating": 4.6,
        "feedback": 134,
        "engagement": 92
      },
      {
        "session": "Social Media Analytics",
        "attendance": 78,
        "capacity": 100,
        "rating": 4.2,
        "feedback": 58,
        "engagement": 67
      },
      {
        "session": "Brand Building Workshop",
        "attendance": 95,
        "capacity": 80,
        "rating": 4.9,
        "feedback": 78,
        "engagement": 96
      }
    ],
    "demographicData": {
      "ageGroups": [
        {"range": "18-25", "count": 187, "percentage": 15.0},
        {"range": "26-35", "count": 436, "percentage": 35.0},
        {"range": "36-45", "count": 374, "percentage": 30.0},
        {"range": "46-55", "count": 187, "percentage": 15.0},
        {"range": "55+", "count": 63, "percentage": 5.0},
      ],
      "industries": [
        {"name": "Technology", "count": 298, "percentage": 23.9},
        {"name": "Marketing", "count": 249, "percentage": 20.0},
        {"name": "Finance", "count": 187, "percentage": 15.0},
        {"name": "Healthcare", "count": 156, "percentage": 12.5},
        {"name": "Education", "count": 125, "percentage": 10.0},
        {"name": "Other", "count": 232, "percentage": 18.6},
      ],
      "geography": [
        {"region": "North America", "count": 623, "percentage": 50.0},
        {"region": "Europe", "count": 312, "percentage": 25.0},
        {"region": "Asia Pacific", "count": 187, "percentage": 15.0},
        {"region": "Latin America", "count": 75, "percentage": 6.0},
        {"region": "Other", "count": 50, "percentage": 4.0},
      ]
    },
    "revenueData": {
      "totalRevenue": 487500,
      "ticketsSold": 1456,
      "averageTicketPrice": 335,
      "sponsorshipRevenue": 125000,
      "merchandiseRevenue": 12300,
      "byTicketType": [
        {"type": "Early Bird", "sold": 345, "revenue": 86250, "price": 250},
        {"type": "Regular", "sold": 678, "revenue": 271200, "price": 400},
        {"type": "VIP", "sold": 289, "revenue": 173400, "price": 600},
        {"type": "Student", "sold": 144, "revenue": 21600, "price": 150},
      ]
    }
  };
  
  List<Map<String, dynamic>> timeframeOptions = [
    {"label": "Entire Event", "value": "event"},
    {"label": "Daily", "value": "daily"},
    {"label": "Weekly", "value": "weekly"},
    {"label": "Real-time", "value": "realtime"},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Analytics Dashboard",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Attendance", icon: Icon(Icons.people)),
        Tab(text: "Sessions", icon: Icon(Icons.event)),
        Tab(text: "Revenue", icon: Icon(Icons.attach_money)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildAttendanceTab(),
        _buildSessionsTab(),
        _buildRevenueTab(),
      ],
    );
  }
  
  Widget _buildOverviewTab() {
    final overview = dashboardData["overview"] as Map<String, dynamic>;
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeframe selector
          QDropdownField(
            label: "Timeframe",
            items: timeframeOptions,
            value: selectedTimeframe,
            onChanged: (value, label) {
              selectedTimeframe = value;
              setState(() {});
            },
          ),
          
          // Key metrics
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildMetricCard(
                "Total Registrations",
                "${overview["totalRegistrations"]}",
                Icons.how_to_reg,
                primaryColor,
                "+12.5% vs last event",
              ),
              _buildMetricCard(
                "Total Attendees",
                "${overview["totalAttendees"]}",
                Icons.people,
                successColor,
                "${(overview["attendanceRate"] as double).toStringAsFixed(1)}% attendance rate",
              ),
              _buildMetricCard(
                "Average Rating",
                "${(overview["averageRating"] as double).toStringAsFixed(1)}/5",
                Icons.star,
                warningColor,
                "Across all sessions",
              ),
              _buildMetricCard(
                "NPS Score",
                "${overview["npsScore"]}",
                Icons.sentiment_satisfied,
                infoColor,
                "Great performance",
              ),
            ],
          ),
          
          // Registration trend
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowMd],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Registration vs Attendance Trend",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                ...(dashboardData["registrationTrend"] as List).map((trend) {
                  final registrationRate = ((trend["attendees"] as int) / (trend["registrations"] as int) * 100);
                  
                  return Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spXs),
                    margin: EdgeInsets.only(bottom: spXs),
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 80,
                          child: Text(
                            "${trend["period"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            spacing: 2,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: trend["registrations"] as int,
                                    child: Container(
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: primaryColor.withAlpha(150),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    "${trend["registrations"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: trend["attendees"] as int,
                                    child: Container(
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: successColor,
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    "${trend["attendees"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: successColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "${registrationRate.toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: registrationRate >= 80 ? successColor : 
                                   registrationRate >= 60 ? warningColor : dangerColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
          
          // Quick stats
          Row(
            children: [
              Expanded(
                child: _buildQuickStat("Sessions", "${overview["totalSessions"]}", Icons.event),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildQuickStat("Speakers", "${overview["totalSpeakers"]}", Icons.person),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildQuickStat("Connections", "${overview["networkingConnections"]}", Icons.network_check),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildAttendanceTab() {
    final demographic = dashboardData["demographicData"] as Map<String, dynamic>;
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Age distribution
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowMd],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Age Distribution",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                ...(demographic["ageGroups"] as List).map((age) {
                  return _buildDemographicBar(
                    "${age["range"]}",
                    age["count"] as int,
                    (age["percentage"] as double),
                    primaryColor,
                  );
                }).toList(),
              ],
            ),
          ),
          
          // Industry distribution
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowMd],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Industry Distribution",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                ...(demographic["industries"] as List).map((industry) {
                  return _buildDemographicBar(
                    "${industry["name"]}",
                    industry["count"] as int,
                    (industry["percentage"] as double),
                    successColor,
                  );
                }).toList(),
              ],
            ),
          ),
          
          // Geographic distribution
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowMd],
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Geographic Distribution",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                ...(demographic["geography"] as List).map((geo) {
                  return _buildDemographicBar(
                    "${geo["region"]}",
                    geo["count"] as int,
                    (geo["percentage"] as double),
                    infoColor,
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSessionsTab() {
    final sessions = dashboardData["sessionPerformance"] as List;
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Session Performance",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          ...sessions.map((session) {
            final attendanceRate = ((session["attendance"] as int) / (session["capacity"] as int) * 100);
            
            return Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: spSm),
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
                      Expanded(
                        child: Text(
                          "${session["session"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, size: 16, color: warningColor),
                          SizedBox(width: 4),
                          Text(
                            "${(session["rating"] as double).toStringAsFixed(1)}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 150,
                    children: [
                      _buildSessionMetric(
                        "Attendance",
                        "${session["attendance"]}/${session["capacity"]}",
                        "${attendanceRate.toStringAsFixed(1)}%",
                        attendanceRate >= 80 ? successColor : 
                        attendanceRate >= 60 ? warningColor : dangerColor,
                      ),
                      _buildSessionMetric(
                        "Feedback",
                        "${session["feedback"]}",
                        "responses",
                        infoColor,
                      ),
                      _buildSessionMetric(
                        "Engagement",
                        "${session["engagement"]}%",
                        "score",
                        (session["engagement"] as int) >= 80 ? successColor : 
                        (session["engagement"] as int) >= 60 ? warningColor : dangerColor,
                      ),
                    ],
                  ),
                  
                  // Progress bar for attendance
                  Column(
                    spacing: spXs,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Capacity Utilization",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Container(
                        height: 8,
                        decoration: BoxDecoration(
                          color: disabledColor.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: attendanceRate / 100,
                          child: Container(
                            decoration: BoxDecoration(
                              color: attendanceRate >= 80 ? successColor : 
                                     attendanceRate >= 60 ? warningColor : dangerColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                          ),
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
  
  Widget _buildRevenueTab() {
    final revenue = dashboardData["revenueData"] as Map<String, dynamic>;
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Revenue overview
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [successColor, successColor.withAlpha(200)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowLg],
            ),
            child: Column(
              spacing: spSm,
              children: [
              Text(
                "Total Revenue",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Text(
                "\$${((revenue["totalRevenue"] as int).toDouble()).currency}",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        "${revenue["ticketsSold"]}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Tickets Sold",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "\$${revenue["averageTicketPrice"]}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Avg Price",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        
        // Revenue breakdown
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: [
            _buildRevenueCard(
              "Ticket Sales",
              "\$${((revenue["totalRevenue"] as int) - (revenue["sponsorshipRevenue"] as int) - (revenue["merchandiseRevenue"] as int)).currency}",
              Icons.confirmation_number,
              primaryColor,
            ),
            _buildRevenueCard(
              "Sponsorship",
              "\$${((revenue["sponsorshipRevenue"] as int).toDouble()).currency}",
              Icons.handshake,
              warningColor,
            ),
            _buildRevenueCard(
              "Merchandise",
              "\$${((revenue["merchandiseRevenue"] as int).toDouble()).currency}",
              Icons.shopping_bag,
              infoColor,
            ),
          ],
        ),
        
        // Ticket type breakdown
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowMd],
          ),
          child: Column(
            spacing: spSm,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Revenue by Ticket Type",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              
              ...(revenue["byTicketType"] as List).map((ticket) {
                final percentage = ((ticket["revenue"] as int) / (revenue["totalRevenue"] as int) * 100);
                
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spSm),
                  margin: EdgeInsets.only(bottom: spXs),
                  decoration: BoxDecoration(
                    color: disabledColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    spacing: spXs,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${ticket["type"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Text(
                            "\$${((ticket["revenue"] as int).toDouble()).currency}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "${ticket["sold"]} tickets × \$${ticket["price"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${percentage.toStringAsFixed(1)}% of total",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 6,
                        decoration: BoxDecoration(
                          color: disabledColor.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: percentage / 100,
                          child: Container(
                            decoration: BoxDecoration(
                              color: _getTicketTypeColor("${ticket["type"]}"),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                          ),
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

Widget _buildMetricCard(String title, String value, IconData icon, Color color, String subtitle) {
  return Container(
    padding: EdgeInsets.all(spSm),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(radiusMd),
      boxShadow: [shadowMd],
    ),
    child: Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 24),
            SizedBox(width: spXs),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ),
          ],
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    ),
  );
}

Widget _buildQuickStat(String label, String value, IconData icon) {
  return Container(
    padding: EdgeInsets.all(spSm),
    decoration: BoxDecoration(
      color: primaryColor.withAlpha(20),
      borderRadius: BorderRadius.circular(radiusMd),
      border: Border.all(color: primaryColor.withAlpha(50)),
    ),
    child: Column(
      children: [
        Icon(icon, color: primaryColor, size: 20),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    ),
  );
}

Widget _buildDemographicBar(String label, int count, double percentage, Color color) {
  return Column(
    spacing: spXs,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ),
          Text(
            "$count (${percentage.toStringAsFixed(1)}%)",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
      Container(
        height: 8,
        decoration: BoxDecoration(
          color: disabledColor.withAlpha(50),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: FractionallySizedBox(
          alignment: Alignment.centerLeft,
          widthFactor: percentage / 100,
          child: Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _buildSessionMetric(String label, String value, String subtitle, Color color) {
  return Container(
    padding: EdgeInsets.all(spXs),
    decoration: BoxDecoration(
      color: color.withAlpha(20),
      borderRadius: BorderRadius.circular(radiusSm),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
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

Widget _buildRevenueCard(String title, String amount, IconData icon, Color color) {
  return Container(
    padding: EdgeInsets.all(spSm),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(radiusMd),
      boxShadow: [shadowSm],
    ),
    child: Column(
      spacing: spXs,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 20),
            SizedBox(width: spXs),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ),
          ],
        ),
        Text(
          amount,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    ),
  );
}

Color _getTicketTypeColor(String type) {
  switch (type.toLowerCase()) {
    case 'early bird':
      return successColor;
    case 'regular':
      return primaryColor;
    case 'vip':
      return warningColor;
    case 'student':
      return infoColor;
    default:
      return disabledBoldColor;
  }
}
}
