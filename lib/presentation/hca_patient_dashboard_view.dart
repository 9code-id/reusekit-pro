import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaPatientDashboardView extends StatefulWidget {
  const HcaPatientDashboardView({super.key});

  @override
  State<HcaPatientDashboardView> createState() => _HcaPatientDashboardViewState();
}

class _HcaPatientDashboardViewState extends State<HcaPatientDashboardView> {
  String selectedPeriod = "This Week";
  
  final List<String> periods = ["Today", "This Week", "This Month", "This Year"];

  final Map<String, dynamic> patientData = {
    "name": "Sarah Johnson",
    "age": 34,
    "patientId": "HCA-2024-001578",
    "bloodType": "A+",
    "allergies": ["Penicillin", "Shellfish"],
    "emergencyContact": "John Johnson (Husband)",
    "emergencyPhone": "+1 (555) 123-4567",
    "insuranceProvider": "Blue Cross Blue Shield",
    "primaryPhysician": "Dr. Michael Chen",
    "lastVisit": "2024-12-15",
    "nextAppointment": "2024-12-28",
  };

  final List<Map<String, dynamic>> upcomingAppointments = [
    {
      "date": "2024-12-28",
      "time": "10:30 AM",
      "doctor": "Dr. Michael Chen",
      "specialty": "Cardiology",
      "type": "Follow-up",
      "location": "Building A, Room 205",
      "status": "Confirmed",
      "color": primaryColor,
    },
    {
      "date": "2025-01-05",
      "time": "2:15 PM",
      "doctor": "Dr. Lisa Park",
      "specialty": "Dermatology",
      "type": "Consultation",
      "location": "Building B, Room 301",
      "status": "Confirmed",
      "color": successColor,
    },
    {
      "date": "2025-01-12",
      "time": "9:00 AM",
      "doctor": "Dr. James Wilson",
      "specialty": "Laboratory",
      "type": "Blood Test",
      "location": "Lab Center, Level 1",
      "status": "Pending",
      "color": warningColor,
    },
  ];

  final List<Map<String, dynamic>> healthMetrics = [
    {
      "title": "Blood Pressure",
      "value": "120/80",
      "unit": "mmHg",
      "status": "Normal",
      "color": successColor,
      "icon": Icons.favorite,
      "trend": "stable",
      "lastUpdate": "Dec 15, 2024",
    },
    {
      "title": "Heart Rate",
      "value": "72",
      "unit": "bpm",
      "status": "Normal",
      "color": successColor,
      "icon": Icons.monitor_heart,
      "trend": "stable",
      "lastUpdate": "Dec 15, 2024",
    },
    {
      "title": "Weight",
      "value": "68.5",
      "unit": "kg",
      "status": "Healthy",
      "color": infoColor,
      "icon": Icons.scale,
      "trend": "down",
      "lastUpdate": "Dec 20, 2024",
    },
    {
      "title": "BMI",
      "value": "22.4",
      "unit": "",
      "status": "Normal",
      "color": successColor,
      "icon": Icons.calculate,
      "trend": "stable",
      "lastUpdate": "Dec 20, 2024",
    },
  ];

  final List<Map<String, dynamic>> recentActivities = [
    {
      "title": "Lab Results Available",
      "description": "Blood work results from Dec 15 visit",
      "time": "2 hours ago",
      "type": "lab_result",
      "icon": Icons.science,
      "color": infoColor,
    },
    {
      "title": "Prescription Refill",
      "description": "Lisinopril prescription ready for pickup",
      "time": "1 day ago",
      "type": "prescription",
      "icon": Icons.medication,
      "color": successColor,
    },
    {
      "title": "Appointment Reminder",
      "description": "Cardiology follow-up on Dec 28",
      "time": "3 days ago",
      "type": "reminder",
      "icon": Icons.calendar_today,
      "color": warningColor,
    },
    {
      "title": "Health Survey",
      "description": "Please complete your monthly health assessment",
      "time": "5 days ago",
      "type": "survey",
      "icon": Icons.assignment,
      "color": primaryColor,
    },
  ];

  final List<Map<String, dynamic>> quickActions = [
    {
      "title": "Book Appointment",
      "description": "Schedule with your doctor",
      "icon": Icons.calendar_month,
      "color": primaryColor,
    },
    {
      "title": "View Lab Results",
      "description": "Check recent test results",
      "icon": Icons.science,
      "color": infoColor,
    },
    {
      "title": "Prescription Refills",
      "description": "Manage medications",
      "icon": Icons.medication,
      "color": successColor,
    },
    {
      "title": "Message Doctor",
      "description": "Send secure message",
      "icon": Icons.message,
      "color": warningColor,
    },
    {
      "title": "Insurance Info",
      "description": "View coverage details",
      "icon": Icons.card_membership,
      "color": dangerColor,
    },
    {
      "title": "Emergency Contact",
      "description": "Call emergency line",
      "icon": Icons.emergency,
      "color": dangerColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Patient Dashboard"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              si("3 new notifications");
            },
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              si("Opening profile...");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    primaryColor.withAlpha(20),
                    primaryColor.withAlpha(5),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.person,
                      size: 30,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome back, ${patientData["name"]}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Patient ID: ${patientData["patientId"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "Next appointment: ${patientData["nextAppointment"]}",
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
            ),

            SizedBox(height: spLg),

            // Quick Actions
            Text(
              "Quick Actions",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: quickActions.map((action) {
                return GestureDetector(
                  onTap: () {
                    ss("${action["title"]} opened");
                  },
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: (action["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusMd),
                          ),
                          child: Icon(
                            action["icon"] as IconData,
                            color: action["color"] as Color,
                            size: 24,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${action["title"]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${action["description"]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: spLg),

            // Health Metrics
            Text(
              "Health Metrics",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: healthMetrics.map((metric) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            metric["icon"] as IconData,
                            color: metric["color"] as Color,
                            size: 24,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "${metric["title"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Icon(
                            metric["trend"] == "up" ? Icons.trending_up :
                            metric["trend"] == "down" ? Icons.trending_down :
                            Icons.trending_flat,
                            color: metric["trend"] == "up" ? successColor :
                                   metric["trend"] == "down" ? warningColor :
                                   disabledBoldColor,
                            size: 20,
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Text(
                            "${metric["value"]}",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: metric["color"] as Color,
                            ),
                          ),
                          if (metric["unit"].isNotEmpty) ...[
                            SizedBox(width: spXs),
                            Text(
                              "${metric["unit"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ],
                      ),
                      SizedBox(height: spXs),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: (metric["color"] as Color).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${metric["status"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: metric["color"] as Color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Updated: ${metric["lastUpdate"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: spLg),

            // Upcoming Appointments
            Row(
              children: [
                Text(
                  "Upcoming Appointments",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    si("Opening all appointments...");
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
            SizedBox(height: spSm),

            Column(
              children: upcomingAppointments.map((appointment) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: appointment["color"] as Color,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            "${appointment["date"]}".split('-')[2],
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: appointment["color"] as Color,
                            ),
                          ),
                          Text(
                            "${appointment["date"]}".split('-')[1] == "12" ? "Dec" : "Jan",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${appointment["doctor"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: (appointment["color"] as Color).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${appointment["status"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: appointment["color"] as Color,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${appointment["specialty"]} - ${appointment["type"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
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
                                  "${appointment["time"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Icon(
                                  Icons.location_on,
                                  size: 14,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    "${appointment["location"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: spSm),
                      Column(
                        children: [
                          QButton(
                            label: "Reschedule",
                            size: bs.sm,
                            onPressed: () {
                              si("Rescheduling appointment...");
                            },
                          ),
                          SizedBox(height: spXs),
                          GestureDetector(
                            onTap: () {
                              sw("This will cancel your appointment");
                            },
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                fontSize: 12,
                                color: dangerColor,
                                fontWeight: FontWeight.w600,
                              ),
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

            // Recent Activities
            Row(
              children: [
                Text(
                  "Recent Activities",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    si("Opening activity history...");
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
            SizedBox(height: spSm),

            Column(
              children: recentActivities.map((activity) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
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
                          color: (activity["color"] as Color).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Icon(
                          activity["icon"] as IconData,
                          color: activity["color"] as Color,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${activity["title"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${activity["description"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "${activity["time"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: spLg),

            // Emergency Contact
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: dangerColor.withAlpha(30),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.emergency,
                    size: 40,
                    color: dangerColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Emergency Contact",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: dangerColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "In case of medical emergency, call 911 or contact your emergency contact",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Call 911",
                          size: bs.md,
                          onPressed: () {
                            sw("Calling emergency services...");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Call Emergency Contact",
                          size: bs.md,
                          onPressed: () {
                            si("Calling ${patientData["emergencyContact"]}...");
                          },
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
}
