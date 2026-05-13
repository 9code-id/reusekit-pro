import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaWomensHealthView extends StatefulWidget {
  const HcaWomensHealthView({super.key});

  @override
  State<HcaWomensHealthView> createState() => _HcaWomensHealthViewState();
}

class _HcaWomensHealthViewState extends State<HcaWomensHealthView> {
  int currentTab = 0;
  String cycleLength = "28";
  String periodLength = "5";
  String lastPeriodDate = "2024-06-01";
  String symptoms = "";
  String contraception = "None";
  String mood = "Good";
  bool pregnancyTracking = false;

  List<Map<String, dynamic>> cycleLengthItems = [
    {"label": "21 days", "value": "21"},
    {"label": "28 days", "value": "28"},
    {"label": "30 days", "value": "30"},
    {"label": "35 days", "value": "35"},
    {"label": "Irregular", "value": "Irregular"},
  ];

  List<Map<String, dynamic>> contraceptionItems = [
    {"label": "None", "value": "None"},
    {"label": "Birth Control Pills", "value": "Birth Control Pills"},
    {"label": "IUD", "value": "IUD"},
    {"label": "Implant", "value": "Implant"},
    {"label": "Condoms", "value": "Condoms"},
    {"label": "Other", "value": "Other"},
  ];

  List<Map<String, dynamic>> moodItems = [
    {"label": "Excellent", "value": "Excellent"},
    {"label": "Good", "value": "Good"},
    {"label": "Fair", "value": "Fair"},
    {"label": "Poor", "value": "Poor"},
    {"label": "Very Poor", "value": "Very Poor"},
  ];

  List<Map<String, dynamic>> menstrualHistory = [
    {
      "id": "1",
      "date": "2024-06-01",
      "flow": "Heavy",
      "duration": "5 days",
      "symptoms": "Cramps, Bloating",
      "mood": "Fair",
      "notes": "More painful than usual",
    },
    {
      "id": "2",
      "date": "2024-05-03",
      "flow": "Normal",
      "duration": "4 days",
      "symptoms": "Mild cramps",
      "mood": "Good",
      "notes": "Normal cycle",
    },
    {
      "id": "3",
      "date": "2024-04-05",
      "flow": "Light",
      "duration": "3 days",
      "symptoms": "Headache",
      "mood": "Good",
      "notes": "Shorter than usual",
    },
  ];

  List<Map<String, dynamic>> upcomingAppointments = [
    {
      "type": "Annual Gynecological Exam",
      "date": "2024-07-15",
      "time": "10:00 AM",
      "doctor": "Dr. Sarah Johnson",
      "facility": "Women's Health Center",
      "notes": "Annual check-up and pap smear",
    },
    {
      "type": "Mammogram",
      "date": "2024-08-20",
      "time": "2:30 PM",
      "doctor": "Radiology Team",
      "facility": "Imaging Center",
      "notes": "Annual breast cancer screening",
    },
  ];

  List<Map<String, dynamic>> healthTips = [
    {
      "title": "Menstrual Health",
      "description": "Track your cycle to understand patterns and identify irregularities",
      "icon": Icons.calendar_today,
      "category": "Cycle",
    },
    {
      "title": "Breast Health",
      "description": "Perform monthly self-exams and get regular mammograms",
      "icon": Icons.favorite,
      "category": "Screening",
    },
    {
      "title": "Bone Health",
      "description": "Ensure adequate calcium and vitamin D intake",
      "icon": Icons.accessibility_new,
      "category": "Nutrition",
    },
    {
      "title": "Heart Health",
      "description": "Women have unique heart disease risks - know the signs",
      "icon": Icons.monitor_heart,
      "category": "Cardiovascular",
    },
    {
      "title": "Mental Health",
      "description": "Hormonal changes can affect mood - seek support when needed",
      "icon": Icons.psychology,
      "category": "Mental",
    },
  ];

  List<Map<String, dynamic>> pregnancyMilestones = [
    {
      "week": 8,
      "title": "First Prenatal Visit",
      "description": "Confirm pregnancy and establish care",
      "completed": true,
    },
    {
      "week": 12,
      "title": "First Trimester Screening",
      "description": "Blood tests and ultrasound",
      "completed": true,
    },
    {
      "week": 20,
      "title": "Anatomy Scan",
      "description": "Detailed ultrasound examination",
      "completed": false,
    },
    {
      "week": 28,
      "title": "Glucose Screening",
      "description": "Test for gestational diabetes",
      "completed": false,
    },
    {
      "week": 36,
      "title": "Group B Strep Test",
      "description": "Screening for bacterial infection",
      "completed": false,
    },
  ];

  Color _getFlowColor(String flow) {
    switch (flow) {
      case "Light":
        return successColor;
      case "Normal":
        return infoColor;
      case "Heavy":
        return warningColor;
      case "Very Heavy":
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  Color _getMoodColor(String mood) {
    switch (mood) {
      case "Excellent":
        return successColor;
      case "Good":
        return infoColor;
      case "Fair":
        return warningColor;
      case "Poor":
      case "Very Poor":
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Women's Health",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Cycle", icon: Icon(Icons.calendar_today)),
        Tab(text: "Health", icon: Icon(Icons.health_and_safety)),
        Tab(text: "Pregnancy", icon: Icon(Icons.pregnant_woman)),
        Tab(text: "Resources", icon: Icon(Icons.info)),
      ],
      tabChildren: [
        _buildCycleTab(),
        _buildHealthTab(),
        _buildPregnancyTab(),
        _buildResourcesTab(),
      ],
      onInit: (tabController) {
        // TabController initialization if needed
      },
    );
  }

  Widget _buildCycleTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cycle Tracking
          Container(
            width: double.infinity,
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
                    Icon(Icons.calendar_month, color: primaryColor, size: 24),
                    SizedBox(width: spSm),
                    Text(
                      "Menstrual Cycle Tracking",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                QDropdownField(
                  label: "Cycle Length",
                  items: cycleLengthItems,
                  value: cycleLength,
                  onChanged: (value, label) {
                    cycleLength = value;
                    setState(() {});
                  },
                ),
                QNumberField(
                  label: "Period Length (days)",
                  value: periodLength,
                  onChanged: (value) {
                    periodLength = value;
                    setState(() {});
                  },
                ),
                QDatePicker(
                  label: "Last Period Start Date",
                  value: DateTime.parse(lastPeriodDate),
                  onChanged: (value) {
                    lastPeriodDate = value.toString().split(' ')[0];
                    setState(() {});
                  },
                ),
                QMemoField(
                  label: "Current Symptoms",
                  value: symptoms,
                  hint: "Cramps, bloating, mood changes, etc.",
                  onChanged: (value) {
                    symptoms = value;
                    setState(() {});
                  },
                ),
                QDropdownField(
                  label: "Mood Today",
                  items: moodItems,
                  value: mood,
                  onChanged: (value, label) {
                    mood = value;
                    setState(() {});
                  },
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Log Entry",
                    size: bs.md,
                    onPressed: () {
                      ss("Cycle data logged successfully");
                    },
                  ),
                ),
              ],
            ),
          ),

          // Cycle Predictions
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: infoColor.withAlpha(50)),
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.analytics, color: infoColor, size: 20),
                    SizedBox(width: spSm),
                    Text(
                      "Cycle Predictions",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Next Period",
                          style: TextStyle(
                            color: infoColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "June 29, 2024",
                          style: TextStyle(
                            color: infoColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Fertile Window",
                          style: TextStyle(
                            color: infoColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "June 15-20",
                          style: TextStyle(
                            color: infoColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Menstrual History
          Text(
            "Recent Cycles",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...menstrualHistory.map((cycle) {
            return Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: _getFlowColor("${cycle["flow"]}"),
                  ),
                ),
              ),
              child: Column(
                spacing: spXs,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${cycle["date"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getFlowColor("${cycle["flow"]}").withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${cycle["flow"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: _getFlowColor("${cycle["flow"]}"),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(width: spXs),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getMoodColor("${cycle["mood"]}").withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${cycle["mood"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: _getMoodColor("${cycle["mood"]}"),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    "Duration: ${cycle["duration"]}",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "Symptoms: ${cycle["symptoms"]}",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
                    ),
                  ),
                  if (cycle["notes"] != null)
                    Text(
                      "${cycle["notes"]}",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildHealthTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Health Settings
          Container(
            width: double.infinity,
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
                    Icon(Icons.health_and_safety, color: primaryColor, size: 24),
                    SizedBox(width: spSm),
                    Text(
                      "Health Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                QDropdownField(
                  label: "Current Contraception",
                  items: contraceptionItems,
                  value: contraception,
                  onChanged: (value, label) {
                    contraception = value;
                    setState(() {});
                  },
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Update Health Profile",
                    size: bs.md,
                    onPressed: () {
                      ss("Health profile updated");
                    },
                  ),
                ),
              ],
            ),
          ),

          // Upcoming Appointments
          Text(
            "Upcoming Appointments",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...upcomingAppointments.map((appointment) {
            return Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spXs,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${appointment["type"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.schedule, color: disabledBoldColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "${appointment["date"]} at ${appointment["time"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.person, color: disabledBoldColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "${appointment["doctor"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: disabledBoldColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "${appointment["facility"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  if (appointment["notes"] != null)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: Colors.grey.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${appointment["notes"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Reschedule",
                          size: bs.sm,
                          onPressed: () {
                            ss("Appointment rescheduled");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Cancel",
                          size: bs.sm,
                          onPressed: () {
                            sw("Appointment cancelled");
                          },
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

  Widget _buildPregnancyTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Pregnancy Tracking Toggle
          Container(
            width: double.infinity,
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
                    Icon(Icons.pregnant_woman, color: primaryColor, size: 24),
                    SizedBox(width: spSm),
                    Text(
                      "Pregnancy Tracking",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                QSwitch(
                  items: [
                    {
                      "label": "Enable pregnancy tracking",
                      "value": true,
                      "checked": pregnancyTracking,
                    }
                  ],
                  value: [if (pregnancyTracking) {"label": "Enable pregnancy tracking", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    pregnancyTracking = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          if (pregnancyTracking) ...[
            // Current Pregnancy Info
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: successColor.withAlpha(50)),
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.baby_changing_station, color: successColor, size: 20),
                      SizedBox(width: spSm),
                      Text(
                        "Current Pregnancy",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Week 16",
                            style: TextStyle(
                              color: successColor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Second Trimester",
                            style: TextStyle(
                              color: successColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Due Date",
                            style: TextStyle(
                              color: successColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "Dec 15, 2024",
                            style: TextStyle(
                              color: successColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    height: 8,
                    child: LinearProgressIndicator(
                      value: 16 / 40,
                      backgroundColor: successColor.withAlpha(100),
                      valueColor: AlwaysStoppedAnimation<Color>(successColor),
                    ),
                  ),
                ],
              ),
            ),

            // Pregnancy Milestones
            Text(
              "Pregnancy Milestones",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            ...pregnancyMilestones.map((milestone) {
              return Container(
                width: double.infinity,
                padding: EdgeInsets.all(spSm),
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: (milestone["completed"] as bool) ? successColor : disabledColor,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: (milestone["completed"] as bool) 
                          ? successColor.withAlpha(20) 
                          : disabledColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Center(
                        child: Text(
                          "${milestone["week"]}w",
                          style: TextStyle(
                            color: (milestone["completed"] as bool) ? successColor : disabledBoldColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${milestone["title"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              if (milestone["completed"] as bool)
                                Icon(Icons.check_circle, color: successColor, size: 20),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${milestone["description"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ] else ...[
            // Pregnancy Planning Info
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info, color: infoColor, size: 20),
                      SizedBox(width: spSm),
                      Text(
                        "Pregnancy Planning",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Enable pregnancy tracking to:\n• Monitor pregnancy milestones\n• Track symptoms and appointments\n• Get personalized health tips\n• Plan for prenatal care",
                    style: TextStyle(
                      color: infoColor,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildResourcesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Women's Health Tips",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...healthTips.map((tip) {
            return Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      tip["icon"],
                      color: primaryColor,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${tip["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${tip["category"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${tip["description"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),

          // Emergency Contacts
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: dangerColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: dangerColor.withAlpha(50)),
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.emergency, color: dangerColor, size: 20),
                    SizedBox(width: spSm),
                    Text(
                      "Emergency Contacts",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "OB/GYN Emergency: (555) 123-4567\nPregnancy Crisis Line: (555) 987-6543\nWomen's Health Hotline: (555) 456-7890",
                  style: TextStyle(
                    color: dangerColor,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),

          // Educational Resources
          Container(
            width: double.infinity,
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
                    Icon(Icons.school, color: primaryColor, size: 24),
                    SizedBox(width: spSm),
                    Text(
                      "Educational Resources",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Column(
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.link, color: disabledBoldColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "American College of Obstetricians and Gynecologists",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.link, color: disabledBoldColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "Women's Health.gov",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.link, color: disabledBoldColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "Planned Parenthood Resources",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
