import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaHomeView extends StatefulWidget {
  const MhaHomeView({super.key});

  @override
  State<MhaHomeView> createState() => _MhaHomeViewState();
}

class _MhaHomeViewState extends State<MhaHomeView> {
  String userName = "John Doe";
  String userImage = "https://picsum.photos/200/200?random=1&keyword=person";
  
  final List<Map<String, dynamic>> quickActions = [
    {
      "title": "Book Appointment",
      "icon": Icons.calendar_today,
      "color": primaryColor,
    },
    {
      "title": "Telemedicine",
      "icon": Icons.video_call,
      "color": successColor,
    },
    {
      "title": "Lab Tests",
      "icon": Icons.science,
      "color": warningColor,
    },
    {
      "title": "Pharmacy",
      "icon": Icons.medication,
      "color": infoColor,
    },
  ];

  final List<Map<String, dynamic>> healthMetrics = [
    {
      "title": "Heart Rate",
      "value": "72",
      "unit": "bpm",
      "icon": Icons.favorite,
      "color": dangerColor,
      "status": "Normal",
    },
    {
      "title": "Blood Pressure",
      "value": "120/80",
      "unit": "mmHg",
      "icon": Icons.speed,
      "color": successColor,
      "status": "Normal",
    },
    {
      "title": "Weight",
      "value": "68.5",
      "unit": "kg",
      "icon": Icons.monitor_weight,
      "color": infoColor,
      "status": "Healthy",
    },
    {
      "title": "Steps Today",
      "value": "8,245",
      "unit": "steps",
      "icon": Icons.directions_walk,
      "color": warningColor,
      "status": "Active",
    },
  ];

  final List<Map<String, dynamic>> upcomingAppointments = [
    {
      "doctor": "Dr. Sarah Wilson",
      "specialty": "Cardiologist",
      "date": "Today, 2:30 PM",
      "type": "Consultation",
      "image": "https://picsum.photos/200/200?random=2&keyword=doctor",
    },
    {
      "doctor": "Dr. Michael Brown",
      "specialty": "General Physician",
      "date": "Tomorrow, 10:00 AM",
      "type": "Check-up",
      "image": "https://picsum.photos/200/200?random=3&keyword=doctor",
    },
  ];

  final List<Map<String, dynamic>> healthTips = [
    {
      "title": "Stay Hydrated",
      "description": "Drink at least 8 glasses of water daily for optimal health",
      "image": "https://picsum.photos/300/200?random=4&keyword=water",
    },
    {
      "title": "Exercise Regularly",
      "description": "30 minutes of moderate exercise can boost your immune system",
      "image": "https://picsum.photos/300/200?random=5&keyword=exercise",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: spLg),
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(radiusLg),
                    child: Image.network(
                      userImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome back,",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        userName,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(radiusMd),
                      onTap: () {
                        // navigateTo(MhaNotificationView());
                      },
                      child: Icon(
                        Icons.notifications,
                        color: primaryColor,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spXl),
            Text(
              "Quick Actions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            Row(
              children: quickActions.map((action) {
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: spSm),
                    child: GestureDetector(
                      onTap: () {
                        si("Opening ${action["title"]}");
                      },
                      child: Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: (action["color"] as Color).withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusMd),
                          border: Border.all(
                            color: (action["color"] as Color).withAlpha(100),
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              action["icon"] as IconData,
                              size: 28,
                              color: action["color"] as Color,
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${action["title"]}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: action["color"] as Color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: spXl),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Health Metrics",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // navigateTo(MhaHealthRecordsView());
                  },
                  child: Text(
                    "View All",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            ResponsiveGridView(
              minItemWidth: 150,
              children: healthMetrics.map((metric) {
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
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              color: (metric["color"] as Color).withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              metric["icon"] as IconData,
                              size: 18,
                              color: metric["color"] as Color,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: (metric["color"] as Color).withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${metric["status"]}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: metric["color"] as Color,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spMd),
                      Text(
                        "${metric["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${metric["value"]}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${metric["unit"]}",
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
            SizedBox(height: spXl),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Upcoming Appointments",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // navigateTo(MhaAppointmentHistoryView());
                  },
                  child: Text(
                    "View All",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            Column(
              children: upcomingAppointments.map((appointment) {
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(radiusMd),
                          child: Image.network(
                            "${appointment["image"]}",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${appointment["doctor"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${appointment["specialty"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  size: 14,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${appointment["date"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      QButton(
                        label: "Join",
                        size: bs.sm,
                        onPressed: () {
                          si("Joining appointment with ${appointment["doctor"]}");
                        },
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: spXl),
            Text(
              "Health Tips",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            QHorizontalScroll(
              children: healthTips.map((tip) {
                return Container(
                  width: 280,
                  margin: EdgeInsets.only(right: spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radiusMd),
                            topRight: Radius.circular(radiusMd),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radiusMd),
                            topRight: Radius.circular(radiusMd),
                          ),
                          child: Image.network(
                            "${tip["image"]}",
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${tip["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${tip["description"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
