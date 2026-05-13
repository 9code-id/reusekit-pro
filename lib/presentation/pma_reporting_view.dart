import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaReportingView extends StatefulWidget {
  const PmaReportingView({super.key});

  @override
  State<PmaReportingView> createState() => _PmaReportingViewState();
}

class _PmaReportingViewState extends State<PmaReportingView> {
  int currentTab = 0;
  String selectedProject = "All Projects";
  String selectedTimeRange = "Last 30 Days";
  String selectedReportType = "Summary Report";
  bool isGenerating = false;

  List<Map<String, dynamic>> projects = [
    {"label": "All Projects", "value": "all"},
    {"label": "Mobile App Development", "value": "mobile"},
    {"label": "Web Platform", "value": "web"},
    {"label": "API Integration", "value": "api"},
    {"label": "UI/UX Design", "value": "design"},
  ];

  List<Map<String, dynamic>> timeRanges = [
    {"label": "Last 7 Days", "value": "7d"},
    {"label": "Last 30 Days", "value": "30d"},
    {"label": "Last 3 Months", "value": "3m"},
    {"label": "Last 6 Months", "value": "6m"},
    {"label": "Custom Range", "value": "custom"},
  ];

  List<Map<String, dynamic>> reportTypes = [
    {"label": "Summary Report", "value": "summary"},
    {"label": "Detailed Analysis", "value": "detailed"},
    {"label": "Performance Report", "value": "performance"},
    {"label": "Time Tracking Report", "value": "time"},
    {"label": "Resource Utilization", "value": "resource"},
  ];

  List<Map<String, dynamic>> recentReports = [
    {
      "title": "Monthly Performance Report",
      "type": "Performance Report",
      "date": "2025-06-18",
      "status": "Ready",
      "size": "2.4 MB",
      "downloads": 15,
    },
    {
      "title": "Team Productivity Analysis",
      "type": "Summary Report",
      "date": "2025-06-17",
      "status": "Processing",
      "size": "1.8 MB",
      "downloads": 8,
    },
    {
      "title": "Q2 Project Summary",
      "type": "Detailed Analysis",
      "date": "2025-06-15",
      "status": "Ready",
      "size": "5.2 MB",
      "downloads": 23,
    },
    {
      "title": "Resource Allocation Report",
      "type": "Resource Utilization",
      "date": "2025-06-14",
      "status": "Ready",
      "size": "3.1 MB",
      "downloads": 12,
    },
  ];

  List<Map<String, dynamic>> reportSchedules = [
    {
      "name": "Weekly Team Report",
      "frequency": "Weekly",
      "nextRun": "2025-06-22",
      "recipients": 5,
      "enabled": true,
    },
    {
      "name": "Monthly Dashboard",
      "frequency": "Monthly",
      "nextRun": "2025-07-01",
      "recipients": 8,
      "enabled": true,
    },
    {
      "name": "Quarterly Analysis",
      "frequency": "Quarterly",
      "nextRun": "2025-09-01",
      "recipients": 3,
      "enabled": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Reporting Center",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Generate", icon: Icon(Icons.add_chart)),
        Tab(text: "Recent", icon: Icon(Icons.history)),
        Tab(text: "Scheduled", icon: Icon(Icons.schedule)),
      ],
      tabChildren: [
        _buildGenerateTab(),
        _buildRecentTab(),
        _buildScheduledTab(),
      ],
    );
  }

  Widget _buildGenerateTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Generate New Report",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          
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
                  "Report Configuration",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                
                QDropdownField(
                  label: "Project",
                  items: projects,
                  value: selectedProject,
                  onChanged: (value, label) {
                    selectedProject = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: spSm),
                
                QDropdownField(
                  label: "Time Range",
                  items: timeRanges,
                  value: selectedTimeRange,
                  onChanged: (value, label) {
                    selectedTimeRange = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: spSm),
                
                QDropdownField(
                  label: "Report Type",
                  items: reportTypes,
                  value: selectedReportType,
                  onChanged: (value, label) {
                    selectedReportType = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: spMd),
                
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: isGenerating ? "Generating..." : "Generate Report",
                    size: bs.md,
                    onPressed: isGenerating ? null : _generateReport,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),
          
          Text(
            "Quick Reports",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildQuickReportCard(
                "Team Performance",
                "Last 7 days overview",
                Icons.people,
                primaryColor,
              ),
              _buildQuickReportCard(
                "Project Status",
                "Current project health",
                Icons.assignment,
                successColor,
              ),
              _buildQuickReportCard(
                "Time Analysis",
                "Time tracking summary",
                Icons.access_time,
                warningColor,
              ),
              _buildQuickReportCard(
                "Resource Usage",
                "Resource allocation report",
                Icons.bar_chart,
                infoColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Recent Reports",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                icon: Icons.refresh,
                size: bs.sm,
                onPressed: () {
                  setState(() {});
                },
              ),
            ],
          ),
          SizedBox(height: spMd),
          
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
                          child: Text(
                            "${report["title"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: report["status"] == "Ready" 
                                ? successColor.withAlpha(20)
                                : warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${report["status"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: report["status"] == "Ready" 
                                  ? successColor
                                  : warningColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${report["type"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${report["date"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Icon(
                          Icons.file_download,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${(report["downloads"] as int)} downloads",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${report["size"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Download",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.share,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.more_vert,
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

  Widget _buildScheduledTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Scheduled Reports",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                label: "New Schedule",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: spMd),
          
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: reportSchedules.length,
            itemBuilder: (context, index) {
              final schedule = reportSchedules[index];
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
                          child: Text(
                            "${schedule["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        QSwitch(
                          items: [
                            {
                              "label": "Enabled",
                              "value": true,
                              "checked": schedule["enabled"],
                            }
                          ],
                          value: [
                            if (schedule["enabled"])
                              {
                                "label": "Enabled",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            setState(() {
                              schedule["enabled"] = values.isNotEmpty;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${schedule["frequency"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Icon(
                          Icons.people,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${(schedule["recipients"] as int)} recipients",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Text(
                          "Next run: ",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${schedule["nextRun"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          label: "Edit",
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

  Widget _buildQuickReportCard(
    String title,
    String description,
    IconData icon,
    Color color,
  ) {
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
              QButton(
                icon: Icons.arrow_forward,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  void _generateReport() async {
    isGenerating = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 3));
    
    isGenerating = false;
    setState(() {});
    
    ss("Report generated successfully!");
  }
}
