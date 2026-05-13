import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaDashboardView extends StatefulWidget {
  const EmaDashboardView({super.key});

  @override
  State<EmaDashboardView> createState() => _EmaDashboardViewState();
}

class _EmaDashboardViewState extends State<EmaDashboardView> {
  int currentTab = 0;
  String selectedPeriod = "monthly";

  List<Map<String, dynamic>> periodOptions = [
    {"label": "Weekly", "value": "weekly"},
    {"label": "Monthly", "value": "monthly"},
    {"label": "Yearly", "value": "yearly"},
  ];

  List<Map<String, dynamic>> dashboardStats = [
    {
      "title": "Total Events",
      "value": 125,
      "change": 12.5,
      "icon": Icons.event,
      "color": Colors.blue,
    },
    {
      "title": "Total Attendees",
      "value": 8420,
      "change": 8.3,
      "icon": Icons.people,
      "color": Colors.green,
    },
    {
      "title": "Revenue",
      "value": 45680.0,
      "change": -2.1,
      "icon": Icons.attach_money,
      "color": Colors.orange,
    },
    {
      "title": "Active Organizers",
      "value": 67,
      "change": 15.2,
      "icon": Icons.person_pin,
      "color": Colors.purple,
    },
  ];

  List<Map<String, dynamic>> recentEvents = [
    {
      "id": "event1",
      "title": "Tech Conference 2024",
      "date": "2024-06-25",
      "attendees": 250,
      "revenue": 37500.0,
      "status": "Active",
      "category": "Technology",
    },
    {
      "id": "event2",
      "title": "Summer Music Festival",
      "date": "2024-07-01",
      "attendees": 500,
      "revenue": 37500.0,
      "status": "Upcoming",
      "category": "Music",
    },
    {
      "id": "event3",
      "title": "Food & Wine Expo",
      "date": "2024-06-28",
      "attendees": 180,
      "revenue": 15300.0,
      "status": "Active",
      "category": "Food",
    },
    {
      "id": "event4",
      "title": "Art Gallery Opening",
      "date": "2024-06-15",
      "attendees": 95,
      "revenue": 4750.0,
      "status": "Completed",
      "category": "Arts",
    },
  ];

  List<Map<String, dynamic>> topCategories = [
    {"name": "Technology", "events": 35, "percentage": 28.0, "color": Colors.blue},
    {"name": "Music", "events": 28, "percentage": 22.4, "color": Colors.purple},
    {"name": "Food & Drinks", "events": 22, "percentage": 17.6, "color": Colors.orange},
    {"name": "Arts & Culture", "events": 18, "percentage": 14.4, "color": Colors.pink},
    {"name": "Sports", "events": 15, "percentage": 12.0, "color": Colors.green},
    {"name": "Business", "events": 7, "percentage": 5.6, "color": Colors.teal},
  ];

  List<Map<String, dynamic>> revenueData = [
    {"month": "Jan", "revenue": 32000},
    {"month": "Feb", "revenue": 38000},
    {"month": "Mar", "revenue": 42000},
    {"month": "Apr", "revenue": 39000},
    {"month": "May", "revenue": 45000},
    {"month": "Jun", "revenue": 48000},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Event Dashboard",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "Events", icon: Icon(Icons.event)),
        Tab(text: "Reports", icon: Icon(Icons.assessment)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildAnalyticsTab(),
        _buildEventsTab(),
        _buildReportsTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spLg),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Dashboard Overview",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Event management insights",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withAlpha(220),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Icon(
                        Icons.refresh,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spLg),
                Row(
                  children: [
                    Text(
                      "Last updated: ",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                    Text(
                      "2 minutes ago",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: spLg),

          // Period Filter
          Row(
            children: [
              Text(
                "Statistics",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                width: 150,
                child: QDropdownField(
                  label: "",
                  items: periodOptions,
                  value: selectedPeriod,
                  onChanged: (value, label) {
                    selectedPeriod = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          SizedBox(height: spMd),

          // Stats Grid
          ResponsiveGridView(
            padding: EdgeInsets.all(0),
            minItemWidth: 200,
            children: dashboardStats.map((stat) => _buildStatCard(stat)).toList(),
          ),

          SizedBox(height: spLg),

          // Recent Events
          Text(
            "Recent Events",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),

          Column(
            children: recentEvents.take(3).map((event) => _buildRecentEventCard(event)).toList(),
          ),

          SizedBox(height: spMd),

          Container(
            width: double.infinity,
            child: QButton(
              label: "View All Events",
              size: bs.md,
              onPressed: () {
                //navigateTo('EmaEventListView')
              },
            ),
          ),

          SizedBox(height: spLg),

          // Top Categories
          Text(
            "Top Categories",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: topCategories.take(4).map((category) => _buildCategoryItem(category)).toList(),
            ),
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
          Text(
            "Revenue Analytics",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),

          Container(
            width: double.infinity,
            height: 250,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Text(
                  "Monthly Revenue Trend",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: revenueData.map((data) => _buildRevenueBar(data)).toList(),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: spLg),

          Text(
            "Event Performance",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),

          ResponsiveGridView(
            padding: EdgeInsets.all(0),
            minItemWidth: 200,
            children: [
              _buildPerformanceCard("Most Popular", "Tech Conference 2024", "250 attendees", Icons.trending_up, successColor),
              _buildPerformanceCard("Highest Revenue", "Summer Music Festival", "\$37,500", Icons.attach_money, warningColor),
              _buildPerformanceCard("Best Rating", "Food & Wine Expo", "4.9 stars", Icons.star, infoColor),
              _buildPerformanceCard("Upcoming", "Art Gallery Opening", "Jun 28", Icons.schedule, primaryColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEventsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "All Events",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Create Event",
                size: bs.sm,
                onPressed: () {
                  //navigateTo('EmaCreateEventView')
                },
              ),
            ],
          ),
          SizedBox(height: spMd),

          Column(
            children: recentEvents.map((event) => _buildEventManagementCard(event)).toList(),
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
          Text(
            "Reports & Insights",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),

          ResponsiveGridView(
            padding: EdgeInsets.all(0),
            minItemWidth: 200,
            children: [
              _buildReportCard("Event Summary", "Monthly overview of all events", Icons.summarize, primaryColor),
              _buildReportCard("Revenue Report", "Financial performance analysis", Icons.trending_up, successColor),
              _buildReportCard("Attendee Analytics", "Participant demographics", Icons.people, infoColor),
              _buildReportCard("Category Performance", "Category-wise insights", Icons.category, warningColor),
            ],
          ),

          SizedBox(height: spLg),

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: primaryColor.withAlpha(100)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.insights,
                      color: primaryColor,
                      size: 24,
                    ),
                    SizedBox(width: spMd),
                    Text(
                      "Quick Insights",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Text(
                  "• Technology events show highest attendance rates",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "• Weekend events generate 40% more revenue",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "• Average event satisfaction rating: 4.7/5",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(Map<String, dynamic> stat) {
    bool isPositive = (stat["change"] as double) >= 0;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
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
                  color: (stat["color"] as Color).withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Icon(
                  stat["icon"] as IconData,
                  color: stat["color"] as Color,
                  size: 24,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                decoration: BoxDecoration(
                  color: isPositive ? successColor.withAlpha(25) : dangerColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isPositive ? Icons.trending_up : Icons.trending_down,
                      color: isPositive ? successColor : dangerColor,
                      size: 12,
                    ),
                    SizedBox(width: 2),
                    Text(
                      "${(stat["change"] as double).abs().toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: isPositive ? successColor : dangerColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            stat["title"] == "Revenue" 
                ? "\$${((stat["value"] as num).toDouble()).currency}"
                : "${stat["value"]}",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "${stat["title"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentEventCard(Map<String, dynamic> event) {
    Color statusColor = event["status"] == "Active" 
        ? successColor 
        : event["status"] == "Completed" 
            ? primaryColor 
            : warningColor;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${event["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${event["status"]}",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "${event["date"]} • ${event["category"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Text(
                      "${event["attendees"]} attendees",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Text(
                      "\$${((event["revenue"] as double).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: disabledBoldColor,
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(Map<String, dynamic> category) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: category["color"] as Color,
              borderRadius: BorderRadius.circular(radiusLg),
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Text(
              "${category["name"]}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ),
          Text(
            "${category["events"]} events",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(width: spMd),
          Text(
            "${(category["percentage"] as double).toStringAsFixed(1)}%",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRevenueBar(Map<String, dynamic> data) {
    double maxRevenue = 50000;
    double height = ((data["revenue"] as int) / maxRevenue) * 150;
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 24,
          height: height,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusSm)),
          ),
        ),
        SizedBox(height: spSm),
        Text(
          "${data["month"]}",
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildPerformanceCard(String title, String subtitle, String value, IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
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
                  color: color.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              Spacer(),
              Icon(
                Icons.more_vert,
                color: disabledBoldColor,
                size: 20,
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventManagementCard(Map<String, dynamic> event) {
    Color statusColor = event["status"] == "Active" 
        ? successColor 
        : event["status"] == "Completed" 
            ? primaryColor 
            : warningColor;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: spMd),
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
                child: Text(
                  "${event["title"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${event["status"]}",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Icon(
                Icons.more_vert,
                color: disabledBoldColor,
                size: 20,
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Date: ${event["date"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Category: ${event["category"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
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
                      "Attendees: ${event["attendees"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Revenue: \$${((event["revenue"] as double).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Edit",
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo('EmaEditEventView', eventId: event["id"])
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo('EmaEventDetailView', eventId: event["id"])
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReportCard(String title, String description, IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
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
              color: color.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          SizedBox(height: spMd),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spMd),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Generate",
              size: bs.sm,
              onPressed: () {
                ss("Generating ${title.toLowerCase()}...");
              },
            ),
          ),
        ],
      ),
    );
  }
}
