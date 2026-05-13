import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmDashboardView extends StatefulWidget {
  const EcmDashboardView({super.key});

  @override
  State<EcmDashboardView> createState() => _EcmDashboardViewState();
}

class _EcmDashboardViewState extends State<EcmDashboardView> {
  List<Map<String, dynamic>> quickStats = [
    {"title": "Active Events", "value": "12", "icon": Icons.event_available, "color": primaryColor, "change": "+3"},
    {"title": "This Month", "value": "8", "icon": Icons.calendar_month, "color": infoColor, "change": "+2"},
    {"title": "Revenue", "value": "\$45.2K", "icon": Icons.monetization_on, "color": successColor, "change": "+15%"},
    {"title": "Clients", "value": "127", "icon": Icons.people, "color": warningColor, "change": "+8"},
  ];
  
  List<Map<String, dynamic>> recentEvents = [
    {
      "name": "Annual Tech Conference 2024",
      "date": "Dec 25, 2024",
      "time": "09:00 AM",
      "status": "live",
      "attendees": 450,
      "location": "Convention Center",
      "type": "Conference"
    },
    {
      "name": "Corporate Holiday Party",
      "date": "Dec 23, 2024",
      "time": "06:00 PM",
      "status": "upcoming",
      "attendees": 200,
      "location": "Grand Hotel",
      "type": "Corporate"
    },
    {
      "name": "Product Launch Event",
      "date": "Dec 20, 2024",
      "time": "02:00 PM",
      "status": "completed",
      "attendees": 300,
      "location": "Innovation Hub",
      "type": "Launch"
    },
  ];
  
  List<Map<String, dynamic>> upcomingTasks = [
    {"task": "Finalize catering menu for Tech Conference", "due": "Today", "priority": "high"},
    {"task": "Send invitations for Holiday Party", "due": "Tomorrow", "priority": "medium"},
    {"task": "Confirm venue for Product Launch", "due": "Dec 22", "priority": "high"},
    {"task": "Update event timeline", "due": "Dec 23", "priority": "low"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        actions: [
          GestureDetector(
            onTap: () {
              si("Notifications clicked");
            },
            child: Container(
              padding: EdgeInsets.all(spSm),
              child: Stack(
                children: [
                  Icon(Icons.notifications, size: 24, color: primaryColor),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: dangerColor,
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Center(
                        child: Text(
                          "3",
                          style: TextStyle(
                            fontSize: 8,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              // ss('Next page'));
            },
            child: Container(
              padding: EdgeInsets.all(spSm),
              child: Icon(Icons.person, size: 24, color: primaryColor),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(200)],
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
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome back, Sarah!",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "You have 3 events today and 5 upcoming this week",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(40),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          Icons.dashboard,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Create New Event",
                      size: bs.md,
                      onPressed: () {
                        // ss('Next page'));
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),
            
            // Quick stats
            Text(
              "Quick Stats",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 150,
              children: quickStats.map((stat) {
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: (stat["color"] as Color).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusMd),
                            ),
                            child: Icon(
                              stat["icon"] as IconData,
                              color: stat["color"] as Color,
                              size: 20,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Text(
                              "${stat["change"]}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spMd),
                      Text(
                        "${stat["value"]}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${stat["title"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: spLg),
            
            // Recent events
            Text(
              "Recent Events",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: recentEvents.length,
              itemBuilder: (context, index) {
                final event = recentEvents[index];
                Color statusColor = primaryColor;
                if (event["status"] == "live") statusColor = successColor;
                if (event["status"] == "completed") statusColor = disabledBoldColor;
                if (event["status"] == "upcoming") statusColor = warningColor;
                
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
                        color: statusColor,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: statusColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Icon(
                          Icons.event,
                          color: statusColor,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${event["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(Icons.access_time, size: 14, color: disabledBoldColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${event["date"]} at ${event["time"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(Icons.location_on, size: 14, color: disabledBoldColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${event["location"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${event["attendees"]} attendees",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: spMd),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: statusColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Text(
                              "${event["status"]}".toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: statusColor,
                              ),
                            ),
                          ),
                          SizedBox(height: spSm),
                          GestureDetector(
                            onTap: () {
                              si("View event details");
                            },
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
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
            SizedBox(height: spLg),
            
            // Upcoming tasks
            Text(
              "Upcoming Tasks",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: upcomingTasks.length,
              itemBuilder: (context, index) {
                final task = upcomingTasks[index];
                Color priorityColor = infoColor;
                if (task["priority"] == "high") priorityColor = dangerColor;
                if (task["priority"] == "medium") priorityColor = warningColor;
                if (task["priority"] == "low") priorityColor = successColor;
                
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
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: priorityColor,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${task["task"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Due: ${task["due"]}",
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
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: priorityColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Text(
                          "${task["priority"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: priorityColor,
                          ),
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
    );
  }
}
