import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaPreventiveCareView extends StatefulWidget {
  const HcaPreventiveCareView({super.key});

  @override
  State<HcaPreventiveCareView> createState() => _HcaPreventiveCareViewState();
}

class _HcaPreventiveCareViewState extends State<HcaPreventiveCareView> {
  bool loading = false;
  int selectedTab = 0;
  String selectedCategory = "All";
  
  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Screenings", "value": "Screenings"},
    {"label": "Vaccinations", "value": "Vaccinations"},
    {"label": "Wellness Checks", "value": "Wellness Checks"},
    {"label": "Lifestyle", "value": "Lifestyle"},
  ];

  List<Map<String, dynamic>> preventiveCareItems = [
    {
      "id": 1,
      "title": "Annual Physical Exam",
      "category": "Wellness Checks",
      "description": "Comprehensive health evaluation including vital signs, physical examination, and health history review",
      "frequency": "Annually",
      "ageGroup": "18+",
      "lastCompleted": "2023-12-15",
      "nextDue": "2024-12-15",
      "status": "Upcoming",
      "importance": "High",
      "estimatedDuration": "45-60 minutes",
      "preparation": ["Bring list of current medications", "Prepare questions for doctor", "Fast for 8-12 hours if blood work ordered"],
      "benefits": ["Early disease detection", "Preventive care planning", "Health risk assessment"],
      "icon": Icons.health_and_safety,
      "color": Colors.blue,
    },
    {
      "id": 2,
      "title": "Mammography Screening",
      "category": "Screenings",
      "description": "X-ray examination of breasts to screen for breast cancer",
      "frequency": "Every 1-2 years",
      "ageGroup": "40+",
      "lastCompleted": null,
      "nextDue": "2024-02-01",
      "status": "Overdue",
      "importance": "High",
      "estimatedDuration": "20-30 minutes",
      "preparation": ["Avoid deodorant/powder", "Schedule for week after menstrual period", "Wear two-piece outfit"],
      "benefits": ["Early breast cancer detection", "Reduced mortality risk", "Peace of mind"],
      "icon": Icons.favorite,
      "color": Colors.pink,
    },
    {
      "id": 3,
      "title": "Colonoscopy",
      "category": "Screenings",
      "description": "Examination of the large intestine to screen for colorectal cancer",
      "frequency": "Every 10 years",
      "ageGroup": "45+",
      "lastCompleted": "2019-08-20",
      "nextDue": "2029-08-20",
      "status": "Not Due",
      "importance": "High",
      "estimatedDuration": "30-60 minutes",
      "preparation": ["Bowel preparation 1-2 days before", "Clear liquid diet", "Arrange transportation"],
      "benefits": ["Colorectal cancer prevention", "Polyp removal", "Early cancer detection"],
      "icon": Icons.biotech,
      "color": Colors.orange,
    },
    {
      "id": 4,
      "title": "Blood Pressure Check",
      "category": "Wellness Checks",
      "description": "Regular monitoring of blood pressure to detect hypertension",
      "frequency": "Every 2 years (normal), Annually (elevated)",
      "ageGroup": "18+",
      "lastCompleted": "2024-01-10",
      "nextDue": "2026-01-10",
      "status": "Current",
      "importance": "Medium",
      "estimatedDuration": "5-10 minutes",
      "preparation": ["Avoid caffeine 30 minutes before", "Rest for 5 minutes before measurement", "Wear loose-fitting clothing"],
      "benefits": ["Hypertension detection", "Cardiovascular risk assessment", "Treatment monitoring"],
      "icon": Icons.monitor_heart,
      "color": Colors.red,
    },
    {
      "id": 5,
      "title": "Cholesterol Screening",
      "category": "Screenings",
      "description": "Blood test to measure cholesterol levels and assess cardiovascular risk",
      "frequency": "Every 4-6 years (normal), More frequently if elevated",
      "ageGroup": "20+",
      "lastCompleted": "2023-06-15",
      "nextDue": "2024-06-15",
      "status": "Due Soon",
      "importance": "High",
      "estimatedDuration": "10-15 minutes",
      "preparation": ["Fast for 9-12 hours", "Avoid alcohol 24 hours before", "Continue regular medications unless advised otherwise"],
      "benefits": ["Heart disease risk assessment", "Stroke prevention", "Treatment guidance"],
      "icon": Icons.bloodtype,
      "color": Colors.purple,
    },
    {
      "id": 6,
      "title": "Influenza Vaccination",
      "category": "Vaccinations",
      "description": "Annual flu shot to protect against seasonal influenza",
      "frequency": "Annually (Fall season)",
      "ageGroup": "6 months+",
      "lastCompleted": "2023-10-15",
      "nextDue": "2024-10-01",
      "status": "Upcoming",
      "importance": "Medium",
      "estimatedDuration": "15-20 minutes",
      "preparation": ["Inform about allergies", "Feel well on vaccination day", "Wear short sleeves"],
      "benefits": ["Flu prevention", "Reduced severity if infected", "Community protection"],
      "icon": Icons.vaccines,
      "color": Colors.green,
    },
    {
      "id": 7,
      "title": "Diabetes Screening",
      "category": "Screenings",
      "description": "Blood glucose test to screen for diabetes and prediabetes",
      "frequency": "Every 3 years (normal), More frequently if risk factors present",
      "ageGroup": "35+",
      "lastCompleted": "2023-03-20",
      "nextDue": "2026-03-20",
      "status": "Current",
      "importance": "High",
      "estimatedDuration": "10-15 minutes",
      "preparation": ["Fast for 8-12 hours", "Continue regular medications", "Stay hydrated"],
      "benefits": ["Early diabetes detection", "Prediabetes identification", "Prevention strategies"],
      "icon": Icons.water_drop,
      "color": Colors.teal,
    },
    {
      "id": 8,
      "title": "Dental Cleaning & Exam",
      "category": "Wellness Checks",
      "description": "Professional teeth cleaning and oral health examination",
      "frequency": "Every 6 months",
      "ageGroup": "All ages",
      "lastCompleted": "2024-01-05",
      "nextDue": "2024-07-05",
      "status": "Due Soon",
      "importance": "Medium",
      "estimatedDuration": "60-90 minutes",
      "preparation": ["Brush teeth before appointment", "List current medications", "Inform about health changes"],
      "benefits": ["Cavity prevention", "Gum disease prevention", "Oral cancer screening"],
      "icon": Icons.medical_services,
      "color": Colors.indigo,
    },
  ];

  List<Map<String, dynamic>> upcomingReminders = [
    {
      "title": "Annual Physical Exam",
      "dueDate": "2024-12-15",
      "daysUntilDue": 330,
      "priority": "High",
      "provider": "Dr. Sarah Johnson",
    },
    {
      "title": "Cholesterol Screening",
      "dueDate": "2024-06-15",
      "daysUntilDue": 147,
      "priority": "High",
      "provider": "LabCorp",
    },
    {
      "title": "Dental Cleaning",
      "dueDate": "2024-07-05",
      "daysUntilDue": 167,
      "priority": "Medium",
      "provider": "Dr. Mike Chen",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Preventive Care",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Care Items", icon: Icon(Icons.health_and_safety)),
        Tab(text: "Schedule", icon: Icon(Icons.calendar_today)),
        Tab(text: "Reminders", icon: Icon(Icons.notifications)),
      ],
      tabChildren: [
        _buildCareItemsTab(),
        _buildScheduleTab(),
        _buildRemindersTab(),
      ],
    );
  }

  Widget _buildCareItemsTab() {
    List<Map<String, dynamic>> filteredItems = preventiveCareItems;
    if (selectedCategory != "All") {
      filteredItems = preventiveCareItems.where((item) => item["category"] == selectedCategory).toList();
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Header Info
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info,
                  color: primaryColor,
                  size: 24,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Preventive Care Guide",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Stay on top of your health with recommended screenings and check-ups.",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Stats Overview
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 120,
            children: [
              _buildStatCard("Total Items", "${preventiveCareItems.length}", Icons.health_and_safety, primaryColor),
              _buildStatCard("Overdue", "${preventiveCareItems.where((item) => item["status"] == "Overdue").length}", Icons.warning, dangerColor),
              _buildStatCard("Due Soon", "${preventiveCareItems.where((item) => item["status"] == "Due Soon").length}", Icons.schedule, warningColor),
              _buildStatCard("Current", "${preventiveCareItems.where((item) => item["status"] == "Current").length}", Icons.check_circle, successColor),
            ],
          ),

          // Category Filter
          Text(
            "Filter by Category",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QCategoryPicker(
            items: categories,
            value: selectedCategory,
            onChanged: (index, label, value, item) {
              selectedCategory = value;
              setState(() {});
            },
          ),

          // Care Items List
          Text(
            "${selectedCategory == "All" ? "All" : selectedCategory} Preventive Care",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          ...filteredItems.map((item) => _buildCareItemCard(item)),
        ],
      ),
    );
  }

  Widget _buildCareItemCard(Map<String, dynamic> item) {
    Color statusColor = _getStatusColor(item["status"] as String);
    Color importanceColor = _getImportanceColor(item["importance"] as String);
    
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
            color: item["color"] as Color,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: (item["color"] as Color).withAlpha(50),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  item["icon"] as IconData,
                  color: item["color"] as Color,
                  size: 24,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${item["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${item["category"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: item["color"] as Color,
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
                      "${item["status"]}",
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
                      color: importanceColor.withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${item["importance"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: importanceColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${item["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          
          // Details Grid
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 120,
            children: [
              _buildDetailItem("Frequency", "${item["frequency"]}", Icons.repeat),
              _buildDetailItem("Age Group", "${item["ageGroup"]}", Icons.people),
              _buildDetailItem("Duration", "${item["estimatedDuration"]}", Icons.access_time),
              _buildDetailItem("Next Due", "${item["nextDue"]}", Icons.calendar_today),
            ],
          ),
          
          if (item["lastCompleted"] != null) ...[
            SizedBox(height: spXs),
            Text(
              "Last Completed: ${item["lastCompleted"]}",
              style: TextStyle(
                fontSize: 12,
                color: successColor,
                fontWeight: FontWeight.w600,
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
                    _viewCareItemDetails(item);
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Schedule",
                  size: bs.sm,
                  onPressed: () {
                    _scheduleCareItem(item);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: disabledBoldColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              color: primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Preventive Care Schedule",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          // Calendar View Placeholder
          Container(
            height: 200,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
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
                  "Calendar View",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Visual calendar showing all your preventive care appointments",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),

          // Upcoming Items by Status
          Text(
            "Items by Status",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          // Overdue Items
          _buildStatusSection("Overdue Items", preventiveCareItems.where((item) => item["status"] == "Overdue").toList(), dangerColor),

          // Due Soon Items
          _buildStatusSection("Due Soon", preventiveCareItems.where((item) => item["status"] == "Due Soon").toList(), warningColor),

          // Upcoming Items
          _buildStatusSection("Upcoming", preventiveCareItems.where((item) => item["status"] == "Upcoming").toList(), primaryColor),
        ],
      ),
    );
  }

  Widget _buildStatusSection(String title, List<Map<String, dynamic>> items, Color color) {
    if (items.isEmpty) return Container();
    
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
            color: color,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title (${items.length})",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spSm),
          ...items.map((item) => Container(
            margin: EdgeInsets.only(bottom: spXs),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "${item["title"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                    ),
                  ),
                ),
                Text(
                  "${item["nextDue"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildRemindersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Upcoming Reminders",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          // Reminder Settings
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
                  "Reminder Preferences",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                QSwitch(
                  items: [
                    {
                      "label": "Email reminders",
                      "value": true,
                      "checked": true,
                    }
                  ],
                  value: [{"label": "Email reminders", "value": true, "checked": true}],
                  onChanged: (values, ids) {},
                ),
                QSwitch(
                  items: [
                    {
                      "label": "Push notifications",
                      "value": true,
                      "checked": true,
                    }
                  ],
                  value: [{"label": "Push notifications", "value": true, "checked": true}],
                  onChanged: (values, ids) {},
                ),
                QSwitch(
                  items: [
                    {
                      "label": "SMS reminders",
                      "value": true,
                      "checked": false,
                    }
                  ],
                  value: [],
                  onChanged: (values, ids) {},
                ),
              ],
            ),
          ),

          // Upcoming Reminders List
          ...upcomingReminders.map((reminder) => _buildReminderCard(reminder)),

          // Set Custom Reminder
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
                  "Set Custom Reminder",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "Create personalized reminders for any health-related activity.",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                QButton(
                  label: "Add Custom Reminder",
                  size: bs.sm,
                  onPressed: () {
                    _addCustomReminder();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReminderCard(Map<String, dynamic> reminder) {
    Color priorityColor = _getPriorityColor(reminder["priority"] as String);
    
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
            color: priorityColor,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: priorityColor.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              Icons.notifications,
              color: priorityColor,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${reminder["title"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Due: ${reminder["dueDate"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "Provider: ${reminder["provider"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
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
                  color: priorityColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${reminder["priority"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "${reminder["daysUntilDue"]} days",
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
      case "Overdue":
        return dangerColor;
      case "Due Soon":
        return warningColor;
      case "Current":
        return successColor;
      case "Upcoming":
        return primaryColor;
      case "Not Due":
        return disabledColor;
      default:
        return primaryColor;
    }
  }

  Color _getImportanceColor(String importance) {
    switch (importance) {
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

  void _viewCareItemDetails(Map<String, dynamic> item) {
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
                "${item["title"]}",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "Preparation Instructions:",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              ...(item["preparation"] as List<String>).map((prep) => Text("• $prep", style: TextStyle(fontSize: 14, color: disabledBoldColor))),
              SizedBox(height: spSm),
              Text(
                "Benefits:",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              ...(item["benefits"] as List<String>).map((benefit) => Text("• $benefit", style: TextStyle(fontSize: 14, color: disabledBoldColor))),
              SizedBox(height: spMd),
              QButton(
                label: "Schedule Appointment",
                size: bs.md,
                onPressed: () {
                  back();
                  _scheduleCareItem(item);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _scheduleCareItem(Map<String, dynamic> item) {
    ss("Scheduling ${item["title"]}");
  }

  void _addCustomReminder() {
    // Navigate to custom reminder creation
  }
}
