import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaScreeningScheduleView extends StatefulWidget {
  const HcaScreeningScheduleView({super.key});

  @override
  State<HcaScreeningScheduleView> createState() => _HcaScreeningScheduleViewState();
}

class _HcaScreeningScheduleViewState extends State<HcaScreeningScheduleView> {
  bool loading = false;
  int selectedTab = 0;
  String selectedFilter = "All";
  DateTime selectedDate = DateTime.now();
  
  List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "All"},
    {"label": "Scheduled", "value": "Scheduled"},
    {"label": "Completed", "value": "Completed"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Cancelled", "value": "Cancelled"},
  ];

  List<Map<String, dynamic>> screenings = [
    {
      "id": 1,
      "title": "Annual Mammography",
      "type": "Breast Cancer Screening",
      "date": "2024-02-15",
      "time": "10:00 AM",
      "provider": "Regional Imaging Center",
      "doctor": "Dr. Sarah Wilson",
      "location": "123 Medical Plaza, Suite 200",
      "phone": "(555) 123-4567",
      "status": "Scheduled",
      "preparation": [
        "Avoid deodorant or powder on the day",
        "Wear a two-piece outfit",
        "Schedule for the week after your period",
        "Bring previous mammography results if available"
      ],
      "duration": "30 minutes",
      "cost": "Covered by insurance",
      "instructions": "Arrive 15 minutes early for check-in",
      "category": "Cancer Screening",
      "priority": "High",
      "reminder": "2 days before",
    },
    {
      "id": 2,
      "title": "Colonoscopy",
      "type": "Colorectal Cancer Screening",
      "date": "2024-03-20",
      "time": "8:00 AM",
      "provider": "Gastroenterology Associates",
      "doctor": "Dr. Michael Chen",
      "location": "456 Health Center Drive",
      "phone": "(555) 987-6543",
      "status": "Scheduled",
      "preparation": [
        "Begin bowel preparation 2 days before",
        "Follow clear liquid diet 24 hours before",
        "Take prescribed laxatives as directed",
        "Arrange transportation (cannot drive after sedation)"
      ],
      "duration": "60 minutes",
      "cost": "\$1,200 (pre-insurance)",
      "instructions": "Fast for 8 hours before procedure",
      "category": "Cancer Screening",
      "priority": "High",
      "reminder": "1 week before",
    },
    {
      "id": 3,
      "title": "Comprehensive Blood Panel",
      "type": "Cholesterol & Diabetes Screening",
      "date": "2024-02-28",
      "time": "7:30 AM",
      "provider": "LabCorp Diagnostics",
      "doctor": "Lab Technician",
      "location": "789 Lab Plaza",
      "phone": "(555) 456-7890",
      "status": "Scheduled",
      "preparation": [
        "Fast for 12 hours before test",
        "Drink plenty of water",
        "Continue taking medications unless advised otherwise",
        "Wear short sleeves or loose sleeves"
      ],
      "duration": "15 minutes",
      "cost": "Covered by insurance",
      "instructions": "Bring insurance card and photo ID",
      "category": "Metabolic Screening",
      "priority": "Medium",
      "reminder": "1 day before",
    },
    {
      "id": 4,
      "title": "Bone Density Scan (DEXA)",
      "type": "Osteoporosis Screening",
      "date": "2024-01-15",
      "time": "2:00 PM",
      "provider": "Bone Health Center",
      "doctor": "Dr. Lisa Anderson",
      "location": "321 Wellness Boulevard",
      "phone": "(555) 234-5678",
      "status": "Completed",
      "preparation": [
        "Avoid calcium supplements 24 hours before",
        "Wear comfortable clothing without metal",
        "Remove jewelry and metal objects",
        "Inform staff if pregnant or possibly pregnant"
      ],
      "duration": "20 minutes",
      "cost": "\$300",
      "instructions": "Results available in 3-5 business days",
      "category": "Bone Health",
      "priority": "Medium",
      "reminder": "N/A",
      "results": {
        "tScore": -1.2,
        "interpretation": "Osteopenia",
        "recommendation": "Calcium and Vitamin D supplements, weight-bearing exercise"
      }
    },
    {
      "id": 5,
      "title": "Pap Smear",
      "type": "Cervical Cancer Screening",
      "date": "2024-04-10",
      "time": "11:00 AM",
      "provider": "Women's Health Clinic",
      "doctor": "Dr. Emily Rodriguez",
      "location": "555 Women's Health Way",
      "phone": "(555) 345-6789",
      "status": "Pending",
      "preparation": [
        "Schedule between menstrual periods",
        "Avoid douching 48 hours before",
        "No sexual intercourse 24 hours before",
        "Avoid vaginal medications unless prescribed"
      ],
      "duration": "10 minutes",
      "cost": "Covered by insurance",
      "instructions": "Annual screening recommended",
      "category": "Cancer Screening",
      "priority": "High",
      "reminder": "3 days before",
    },
    {
      "id": 6,
      "title": "Comprehensive Eye Exam",
      "type": "Vision & Glaucoma Screening",
      "date": "2024-01-20",
      "time": "3:30 PM",
      "provider": "Valley Eye Care",
      "doctor": "Dr. Robert Taylor",
      "location": "888 Vision Street",
      "phone": "(555) 567-8901",
      "status": "Completed",
      "preparation": [
        "Bring current glasses or contacts",
        "List current medications",
        "Sunglasses recommended for after exam",
        "Arrange transportation if dilation needed"
      ],
      "duration": "45 minutes",
      "cost": "\$200",
      "instructions": "Pupils may be dilated",
      "category": "Vision Screening",
      "priority": "Medium",
      "reminder": "N/A",
      "results": {
        "vision": "20/20 with correction",
        "pressure": "Normal (14 mmHg)",
        "recommendation": "Continue annual exams"
      }
    },
  ];

  List<Map<String, dynamic>> upcomingScreenings = [];
  List<Map<String, dynamic>> completedScreenings = [];

  @override
  void initState() {
    super.initState();
    _filterScreenings();
  }

  void _filterScreenings() {
    upcomingScreenings = screenings.where((s) => s["status"] == "Scheduled" || s["status"] == "Pending").toList();
    completedScreenings = screenings.where((s) => s["status"] == "Completed").toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Screening Schedule",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Schedule", icon: Icon(Icons.calendar_today)),
        Tab(text: "Upcoming", icon: Icon(Icons.upcoming)),
        Tab(text: "Results", icon: Icon(Icons.assignment_turned_in)),
      ],
      tabChildren: [
        _buildScheduleTab(),
        _buildUpcomingTab(),
        _buildResultsTab(),
      ],
    );
  }

  Widget _buildScheduleTab() {
    List<Map<String, dynamic>> filteredScreenings = screenings;
    if (selectedFilter != "All") {
      filteredScreenings = screenings.where((s) => s["status"] == selectedFilter).toList();
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Quick Stats
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 120,
            children: [
              _buildStatCard("Total Screenings", "${screenings.length}", Icons.assignment, primaryColor),
              _buildStatCard("Scheduled", "${screenings.where((s) => s["status"] == "Scheduled").length}", Icons.schedule, successColor),
              _buildStatCard("Pending", "${screenings.where((s) => s["status"] == "Pending").length}", Icons.pending, warningColor),
              _buildStatCard("Completed", "${screenings.where((s) => s["status"] == "Completed").length}", Icons.check_circle, infoColor),
            ],
          ),

          // Filter Options
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Filter by Status",
                  items: filterOptions,
                  value: selectedFilter,
                  onChanged: (value, label) {
                    selectedFilter = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {
                  _scheduleNewScreening();
                },
              ),
            ],
          ),

          // Calendar View (Simplified)
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Calendar View",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_month,
                          size: 48,
                          color: primaryColor,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Interactive Calendar",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "View all screenings by date",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Screenings List
          Text(
            "All Screenings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          ...filteredScreenings.map((screening) => _buildScreeningCard(screening)),
        ],
      ),
    );
  }

  Widget _buildScreeningCard(Map<String, dynamic> screening) {
    Color statusColor = _getStatusColor(screening["status"] as String);
    Color priorityColor = _getPriorityColor(screening["priority"] as String);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
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
                      "${screening["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${screening["type"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${screening["category"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${screening["status"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: priorityColor.withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${screening["priority"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: priorityColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spSm),
          
          // Date and Time
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                color: disabledBoldColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                "${screening["date"]} at ${screening["time"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          
          // Provider Info
          Row(
            children: [
              Icon(
                Icons.local_hospital,
                color: disabledBoldColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${screening["provider"]} • ${screening["doctor"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          
          // Duration and Cost
          Row(
            children: [
              Icon(
                Icons.access_time,
                color: disabledBoldColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                "${screening["duration"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spSm),
              Icon(
                Icons.attach_money,
                color: disabledBoldColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                "${screening["cost"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          
          // Results (if completed)
          if (screening.containsKey("results")) ...[
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Results Available",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${(screening["results"] as Map)["interpretation"] ?? "Results ready for review"}",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
          
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {
                    _viewScreeningDetails(screening);
                  },
                ),
              ),
              SizedBox(width: spSm),
              if (screening["status"] == "Scheduled" || screening["status"] == "Pending")
                Expanded(
                  child: QButton(
                    label: "Reschedule",
                    size: bs.sm,
                    onPressed: () {
                      _rescheduleScreening(screening);
                    },
                  ),
                )
              else if (screening["status"] == "Completed" && screening.containsKey("results"))
                Expanded(
                  child: QButton(
                    label: "View Results",
                    size: bs.sm,
                    onPressed: () {
                      _viewResults(screening);
                    },
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Next Screening Alert
          if (upcomingScreenings.isNotEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.notifications_active,
                    color: primaryColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Next Screening",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${upcomingScreenings[0]["title"]} on ${upcomingScreenings[0]["date"]}",
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
            ),

          Text(
            "Upcoming Screenings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          if (upcomingScreenings.isEmpty)
            Container(
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.event_available,
                    size: 48,
                    color: disabledColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "No upcoming screenings",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  QButton(
                    label: "Schedule Screening",
                    size: bs.sm,
                    onPressed: () {
                      _scheduleNewScreening();
                    },
                  ),
                ],
              ),
            )
          else
            ...upcomingScreenings.map((screening) => _buildUpcomingScreeningCard(screening)),

          // Preparation Reminders
          if (upcomingScreenings.isNotEmpty) ...[
            Text(
              "Preparation Reminders",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Preparation for ${upcomingScreenings[0]["title"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ...(upcomingScreenings[0]["preparation"] as List<String>).map((prep) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spXs),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 6),
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              prep,
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
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
        ],
      ),
    );
  }

  Widget _buildUpcomingScreeningCard(Map<String, dynamic> screening) {
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
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              Icons.event,
              color: primaryColor,
              size: 24,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${screening["title"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${screening["date"]} at ${screening["time"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${screening["provider"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            icon: Icons.info,
            size: bs.sm,
            onPressed: () {
              _viewScreeningDetails(screening);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildResultsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Screening Results",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          if (completedScreenings.isEmpty)
            Container(
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.assignment_outlined,
                    size: 48,
                    color: disabledColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "No completed screenings yet",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            )
          else
            ...completedScreenings.map((screening) => _buildResultCard(screening)),
        ],
      ),
    );
  }

  Widget _buildResultCard(Map<String, dynamic> screening) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${screening["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Completed: ${screening["date"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${screening["provider"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: successColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "Completed",
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          
          if (screening.containsKey("results")) ...[
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Results",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  ...(screening["results"] as Map).entries.map((entry) {
                    if (entry.key != "recommendation") {
                      return Text(
                        "${entry.key}: ${entry.value}",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                        ),
                      );
                    }
                    return Container();
                  }),
                  if ((screening["results"] as Map).containsKey("recommendation")) ...[
                    SizedBox(height: spXs),
                    Text(
                      "Recommendation: ${(screening["results"] as Map)["recommendation"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
          
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Download Report",
                  size: bs.sm,
                  onPressed: () {
                    _downloadReport(screening);
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Share Results",
                  size: bs.sm,
                  onPressed: () {
                    _shareResults(screening);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
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
              Icon(
                icon,
                color: color,
                size: 20,
              ),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Scheduled":
        return successColor;
      case "Pending":
        return warningColor;
      case "Completed":
        return infoColor;
      case "Cancelled":
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return primaryColor;
    }
  }

  void _scheduleNewScreening() {
    // Navigate to screening scheduling
    ss("Opening screening scheduler");
  }

  void _viewScreeningDetails(Map<String, dynamic> screening) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: disabledColor,
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
              ),
              SizedBox(height: spMd),
              Text(
                "${screening["title"]}",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "${screening["type"]}",
                style: TextStyle(
                  fontSize: 16,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spMd),
              
              // Appointment Details
              _buildDetailSection("Appointment Details", [
                "Date: ${screening["date"]}",
                "Time: ${screening["time"]}",
                "Duration: ${screening["duration"]}",
                "Provider: ${screening["provider"]}",
                "Doctor: ${screening["doctor"]}",
                "Location: ${screening["location"]}",
                "Phone: ${screening["phone"]}",
                "Cost: ${screening["cost"]}",
              ]),
              
              // Preparation Instructions
              _buildDetailSection("Preparation Instructions", screening["preparation"] as List<String>),
              
              // Instructions
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Special Instructions:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${screening["instructions"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spMd),
              if (screening["status"] == "Scheduled" || screening["status"] == "Pending")
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Reschedule",
                        size: bs.md,
                        onPressed: () {
                          back();
                          _rescheduleScreening(screening);
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Cancel",
                        size: bs.md,
                        onPressed: () {
                          back();
                          _cancelScreening(screening);
                        },
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, List<String> items) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...items.map((item) => Container(
            margin: EdgeInsets.only(bottom: spXs),
            child: Text(
              "• $item",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          )),
        ],
      ),
    );
  }

  void _rescheduleScreening(Map<String, dynamic> screening) {
    ss("Rescheduling ${screening["title"]}");
  }

  void _cancelScreening(Map<String, dynamic> screening) async {
    bool confirmed = await confirm("Are you sure you want to cancel this screening?");
    if (confirmed) {
      ss("Screening cancelled");
    }
  }

  void _viewResults(Map<String, dynamic> screening) {
    setState(() {
      selectedTab = 2;
    });
  }

  void _downloadReport(Map<String, dynamic> screening) {
    ss("Downloading report for ${screening["title"]}");
  }

  void _shareResults(Map<String, dynamic> screening) {
    ss("Sharing results for ${screening["title"]}");
  }
}
