import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaReportsView extends StatefulWidget {
  const ImaReportsView({super.key});

  @override
  State<ImaReportsView> createState() => _ImaReportsViewState();
}

class _ImaReportsViewState extends State<ImaReportsView> {
  int currentTab = 0;
  String selectedPeriod = "This Month";
  String selectedCategory = "";
  String selectedLocation = "";
  DateTime selectedDate = DateTime.now();
  
  List<Map<String, dynamic>> periodList = [
    {"label": "Today", "value": "Today"},
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
    {"label": "Custom Range", "value": "Custom"},
  ];
  
  List<Map<String, dynamic>> categoryList = [
    {"label": "All Categories", "value": ""},
    {"label": "Electronics", "value": "ELEC"},
    {"label": "Computer Hardware", "value": "COMP"},
    {"label": "Accessories", "value": "ACC"},
    {"label": "Peripherals", "value": "PER"},
  ];
  
  List<Map<String, dynamic>> locationList = [
    {"label": "All Locations", "value": ""},
    {"label": "Main Warehouse", "value": "WH001"},
    {"label": "Secondary Warehouse", "value": "WH002"},
    {"label": "Retail Store A", "value": "ST001"},
    {"label": "Retail Store B", "value": "ST002"},
  ];
  
  List<Map<String, dynamic>> reportTemplates = [
    {
      "name": "Inventory Valuation Report",
      "description": "Current value of all inventory items",
      "icon": Icons.attach_money,
      "type": "valuation",
      "lastGenerated": DateTime.now().subtract(Duration(hours: 2)),
    },
    {
      "name": "Stock Movement Report",
      "description": "Detailed record of inventory movements",
      "icon": Icons.swap_horiz,
      "type": "movement",
      "lastGenerated": DateTime.now().subtract(Duration(days: 1)),
    },
    {
      "name": "ABC Analysis Report",
      "description": "Classification of items by value and volume",
      "icon": Icons.analytics,
      "type": "abc",
      "lastGenerated": DateTime.now().subtract(Duration(days: 3)),
    },
    {
      "name": "Dead Stock Report",
      "description": "Items with no movement for extended periods",
      "icon": Icons.warning,
      "type": "deadstock",
      "lastGenerated": DateTime.now().subtract(Duration(days: 5)),
    },
    {
      "name": "Reorder Level Report",
      "description": "Items approaching or below reorder levels",
      "icon": Icons.shopping_cart,
      "type": "reorder",
      "lastGenerated": DateTime.now().subtract(Duration(hours: 6)),
    },
    {
      "name": "Cycle Count Report",
      "description": "Physical count vs system inventory",
      "icon": Icons.fact_check,
      "type": "cyclecount",
      "lastGenerated": DateTime.now().subtract(Duration(days: 7)),
    },
  ];
  
  List<Map<String, dynamic>> recentReports = [
    {
      "name": "Monthly Inventory Valuation",
      "type": "Valuation Report",
      "generatedDate": DateTime.now().subtract(Duration(hours: 2)),
      "generatedBy": "John Smith",
      "format": "PDF",
      "status": "Completed",
      "fileSize": "2.3 MB",
    },
    {
      "name": "Weekly Stock Movement",
      "type": "Movement Report",
      "generatedDate": DateTime.now().subtract(Duration(days: 1)),
      "generatedBy": "Sarah Johnson",
      "format": "Excel",
      "status": "Completed",
      "fileSize": "1.8 MB",
    },
    {
      "name": "Q1 ABC Analysis",
      "type": "ABC Analysis",
      "generatedDate": DateTime.now().subtract(Duration(days: 3)),
      "generatedBy": "Mike Chen",
      "format": "PDF",
      "status": "Completed",
      "fileSize": "3.1 MB",
    },
    {
      "name": "Dead Stock Review",
      "type": "Dead Stock Report",
      "generatedDate": DateTime.now().subtract(Duration(days: 5)),
      "generatedBy": "Lisa Wang",
      "format": "Excel",
      "status": "Processing",
      "fileSize": "0.5 MB",
    },
  ];
  
  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Inventory Reports",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Report Templates", icon: Icon(Icons.description)),
        Tab(text: "Recent Reports", icon: Icon(Icons.history)),
        Tab(text: "Scheduled Reports", icon: Icon(Icons.schedule)),
      ],
      tabChildren: [
        _buildReportTemplatesTab(),
        _buildRecentReportsTab(),
        _buildScheduledReportsTab(),
      ],
      onInit: (tabController) {
        // Tab controller initialization
      },
    );
  }
  
  Widget _buildReportTemplatesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFilterSection(),
          _buildQuickStatsCards(),
          _buildReportTemplatesGrid(),
        ],
      ),
    );
  }
  
  Widget _buildFilterSection() {
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
          Text(
            "Report Filters",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Time Period",
                  items: periodList,
                  value: selectedPeriod,
                  onChanged: (value, label) {
                    selectedPeriod = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: categoryList,
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Location",
                  items: locationList,
                  value: selectedLocation,
                  onChanged: (value, label) {
                    selectedLocation = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildQuickStatsCards() {
    return ResponsiveGridView(
      minItemWidth: 200,
      children: [
        _buildStatsCard(
          "Total Reports",
          "${reportTemplates.length}",
          Icons.description,
          primaryColor,
        ),
        _buildStatsCard(
          "Generated Today",
          "12",
          Icons.today,
          successColor,
        ),
        _buildStatsCard(
          "Scheduled Reports",
          "8",
          Icons.schedule,
          infoColor,
        ),
        _buildStatsCard(
          "Processing",
          "3",
          Icons.hourglass_empty,
          warningColor,
        ),
      ],
    );
  }
  
  Widget _buildStatsCard(String title, String value, IconData icon, Color color) {
    return Container(
      width: double.infinity,
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
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              Spacer(),
              Icon(
                Icons.trending_up,
                color: disabledBoldColor,
                size: 16,
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildReportTemplatesGrid() {
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
          Text(
            "Available Report Templates",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            minItemWidth: 200,
            children: reportTemplates.map((template) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            template["icon"],
                            color: primaryColor,
                            size: 24,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            _generateReport(template);
                          },
                          child: Icon(
                            Icons.play_arrow,
                            color: successColor,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "${template["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${template["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "Last Generated: ${(template["lastGenerated"] as DateTime).dMMMy}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Generate Report",
                        size: bs.sm,
                        onPressed: () {
                          _generateReport(template);
                        },
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
  
  Widget _buildRecentReportsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRecentReportsHeader(),
          _buildRecentReportsList(),
        ],
      ),
    );
  }
  
  Widget _buildRecentReportsHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Recent Reports",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Generated reports in the last 30 days",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            label: "Export All",
            size: bs.sm,
            icon: Icons.download,
            onPressed: () {
              _exportAllReports();
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildRecentReportsList() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: recentReports.length,
        itemBuilder: (context, index) {
          final report = recentReports[index];
          return Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: disabledOutlineBorderColor),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: _getFormatColor(report["format"]).withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    _getFormatIcon(report["format"]),
                    color: _getFormatColor(report["format"]),
                    size: 24,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${report["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: _getStatusColor(report["status"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${report["status"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: _getStatusColor(report["status"]),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${report["type"]} • Generated by ${report["generatedBy"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Text(
                            "${(report["generatedDate"] as DateTime).dMMMy}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(width: spMd),
                          Text(
                            "${report["format"]} • ${report["fileSize"]}",
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
                SizedBox(width: spMd),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _downloadReport(report);
                      },
                      child: Icon(
                        Icons.download,
                        color: primaryColor,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: spSm),
                    GestureDetector(
                      onTap: () {
                        _shareReport(report);
                      },
                      child: Icon(
                        Icons.share,
                        color: infoColor,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
  
  Widget _buildScheduledReportsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildScheduledReportsHeader(),
          _buildSchedulesList(),
        ],
      ),
    );
  }
  
  Widget _buildScheduledReportsHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Scheduled Reports",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Automated report generation schedules",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            label: "Add Schedule",
            size: bs.sm,
            icon: Icons.add,
            onPressed: () {
              _addSchedule();
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildSchedulesList() {
    List<Map<String, dynamic>> schedules = [
      {
        "name": "Daily Stock Report",
        "reportType": "Stock Movement",
        "frequency": "Daily",
        "time": "09:00 AM",
        "recipients": "warehouse@company.com",
        "nextRun": DateTime.now().add(Duration(days: 1)),
        "status": "Active",
      },
      {
        "name": "Weekly Inventory Valuation",
        "reportType": "Valuation Report",
        "frequency": "Weekly",
        "time": "Monday 08:00 AM",
        "recipients": "finance@company.com",
        "nextRun": DateTime.now().add(Duration(days: 5)),
        "status": "Active",
      },
      {
        "name": "Monthly ABC Analysis",
        "reportType": "ABC Analysis",
        "frequency": "Monthly",
        "time": "1st Day 10:00 AM",
        "recipients": "management@company.com",
        "nextRun": DateTime.now().add(Duration(days: 28)),
        "status": "Paused",
      },
    ];
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: schedules.length,
        itemBuilder: (context, index) {
          final schedule = schedules[index];
          return Container(
            margin: EdgeInsets.only(bottom: spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: disabledOutlineBorderColor),
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
                            "${schedule["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${schedule["reportType"]} • ${schedule["frequency"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: schedule["status"] == "Active" ? successColor.withAlpha(20) : warningColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${schedule["status"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: schedule["status"] == "Active" ? successColor : warningColor,
                        ),
                      ),
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
                            "Schedule Time",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${schedule["time"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
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
                            "Next Run",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${(schedule["nextRun"] as DateTime).dMMMy}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: warningColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "Recipients: ${schedule["recipients"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    QButton(
                      label: schedule["status"] == "Active" ? "Pause" : "Resume",
                      size: bs.sm,
                      onPressed: () {
                        _toggleSchedule(schedule);
                      },
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      label: "Edit",
                      size: bs.sm,
                      onPressed: () {
                        _editSchedule(schedule);
                      },
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        _deleteSchedule(schedule);
                      },
                      child: Icon(
                        Icons.delete,
                        color: dangerColor,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
  
  Color _getFormatColor(String format) {
    switch (format) {
      case "PDF":
        return dangerColor;
      case "Excel":
        return successColor;
      default:
        return primaryColor;
    }
  }
  
  IconData _getFormatIcon(String format) {
    switch (format) {
      case "PDF":
        return Icons.picture_as_pdf;
      case "Excel":
        return Icons.table_chart;
      default:
        return Icons.description;
    }
  }
  
  Color _getStatusColor(String status) {
    switch (status) {
      case "Completed":
        return successColor;
      case "Processing":
        return warningColor;
      case "Failed":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }
  
  void _generateReport(Map<String, dynamic> template) {
    showLoading();
    
    // Simulate report generation
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("Report generation started successfully");
    });
  }
  
  void _exportAllReports() {
    ss("All reports exported successfully");
  }
  
  void _downloadReport(Map<String, dynamic> report) {
    ss("Report downloaded: ${report["name"]}");
  }
  
  void _shareReport(Map<String, dynamic> report) {
    ss("Report shared: ${report["name"]}");
  }
  
  void _addSchedule() {
    ss("Schedule added successfully");
  }
  
  void _editSchedule(Map<String, dynamic> schedule) {
    ss("Schedule updated: ${schedule["name"]}");
  }
  
  void _toggleSchedule(Map<String, dynamic> schedule) {
    String action = schedule["status"] == "Active" ? "paused" : "resumed";
    ss("Schedule $action: ${schedule["name"]}");
  }
  
  void _deleteSchedule(Map<String, dynamic> schedule) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this schedule?");
    if (isConfirmed) {
      ss("Schedule deleted: ${schedule["name"]}");
    }
  }
}
