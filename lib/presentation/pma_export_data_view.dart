import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaExportDataView extends StatefulWidget {
  const PmaExportDataView({super.key});

  @override
  State<PmaExportDataView> createState() => _PmaExportDataViewState();
}

class _PmaExportDataViewState extends State<PmaExportDataView> {
  int currentTab = 0;
  String selectedDataType = "project_data";
  String selectedFormat = "excel";
  String selectedCompression = "none";
  String selectedDateRange = "last_30_days";
  List<String> selectedFields = [];
  bool includeDeleted = false;
  bool includeArchived = false;
  bool includeMetadata = true;
  String exportName = "";

  final List<Map<String, dynamic>> dataTypes = [
    {"label": "Project Data", "value": "project_data", "description": "All project information, tasks, and milestones"},
    {"label": "Team Data", "value": "team_data", "description": "Team members, roles, and assignments"},
    {"label": "Time Tracking", "value": "time_tracking", "description": "Time logs, timesheets, and productivity data"},
    {"label": "Financial Data", "value": "financial_data", "description": "Budgets, expenses, and cost tracking"},
    {"label": "Reports & Analytics", "value": "reports_analytics", "description": "Generated reports and analytics data"},
    {"label": "User Activity", "value": "user_activity", "description": "User logs, actions, and system activity"},
    {"label": "Settings & Configuration", "value": "settings_config", "description": "System settings and configuration data"},
    {"label": "Complete Backup", "value": "complete_backup", "description": "Full system backup with all data"},
  ];

  final List<Map<String, dynamic>> exportFormats = [
    {"label": "Excel Spreadsheet (.xlsx)", "value": "excel", "size": "Medium"},
    {"label": "CSV Files (.csv)", "value": "csv", "size": "Small"},
    {"label": "JSON Format (.json)", "value": "json", "size": "Small"},
    {"label": "XML Format (.xml)", "value": "xml", "size": "Medium"},
    {"label": "PDF Document (.pdf)", "value": "pdf", "size": "Large"},
    {"label": "SQL Database (.sql)", "value": "sql", "size": "Small"},
    {"label": "ZIP Archive (.zip)", "value": "zip", "size": "Variable"},
  ];

  final List<Map<String, dynamic>> compressionOptions = [
    {"label": "No Compression", "value": "none"},
    {"label": "ZIP Compression", "value": "zip"},
    {"label": "GZIP Compression", "value": "gzip"},
    {"label": "7-Zip Compression", "value": "7zip"},
  ];

  final List<Map<String, dynamic>> dateRanges = [
    {"label": "Last 7 Days", "value": "last_7_days"},
    {"label": "Last 30 Days", "value": "last_30_days"},
    {"label": "Last 3 Months", "value": "last_3_months"},
    {"label": "Last 6 Months", "value": "last_6_months"},
    {"label": "Last Year", "value": "last_year"},
    {"label": "All Time", "value": "all_time"},
    {"label": "Custom Range", "value": "custom"},
  ];

  final List<Map<String, dynamic>> availableFields = [
    {"label": "Project Information", "value": "project_info"},
    {"label": "Task Details", "value": "task_details"},
    {"label": "Team Assignments", "value": "team_assignments"},
    {"label": "Time Logs", "value": "time_logs"},
    {"label": "Budget Data", "value": "budget_data"},
    {"label": "Milestone Progress", "value": "milestone_progress"},
    {"label": "File Attachments", "value": "file_attachments"},
    {"label": "Comments & Notes", "value": "comments_notes"},
    {"label": "Status History", "value": "status_history"},
    {"label": "Custom Fields", "value": "custom_fields"},
  ];

  final List<Map<String, dynamic>> exportHistory = [
    {
      "name": "Project Data Export",
      "type": "Project Data",
      "format": "Excel",
      "size": "15.2 MB",
      "date": "2024-01-15 14:30",
      "status": "completed",
      "records": "2,847"
    },
    {
      "name": "Team Performance Data",
      "type": "Team Data", 
      "format": "CSV",
      "size": "8.7 MB",
      "date": "2024-01-12 09:15",
      "status": "completed",
      "records": "1,523"
    },
    {
      "name": "Financial Report Export",
      "type": "Financial Data",
      "format": "Excel",
      "size": "12.4 MB", 
      "date": "2024-01-10 16:45",
      "status": "completed",
      "records": "3,291"
    },
    {
      "name": "Complete System Backup",
      "type": "Complete Backup",
      "format": "ZIP",
      "size": "245.8 MB",
      "date": "2024-01-08 22:00",
      "status": "processing",
      "records": "15,678"
    },
    {
      "name": "Time Tracking Export",
      "type": "Time Tracking",
      "format": "JSON",
      "size": "5.3 MB",
      "date": "2024-01-05 11:20",
      "status": "failed",
      "records": "956"
    },
  ];

  final List<Map<String, dynamic>> scheduledExports = [
    {
      "name": "Weekly Project Summary",
      "type": "Project Data",
      "schedule": "Every Monday at 9:00 AM",
      "format": "Excel",
      "lastRun": "2024-01-15",
      "nextRun": "2024-01-22",
      "status": "active"
    },
    {
      "name": "Monthly Financial Report",
      "type": "Financial Data",
      "schedule": "First day of month at 6:00 AM",
      "format": "PDF",
      "lastRun": "2024-01-01",
      "nextRun": "2024-02-01",
      "status": "active"
    },
    {
      "name": "Daily Time Tracking",
      "type": "Time Tracking",
      "schedule": "Every day at 11:59 PM",
      "format": "CSV",
      "lastRun": "2024-01-14",
      "nextRun": "2024-01-15",
      "status": "paused"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Export Data",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Export", icon: Icon(Icons.file_download)),
        Tab(text: "History", icon: Icon(Icons.history)),
        Tab(text: "Scheduled", icon: Icon(Icons.schedule)),
        Tab(text: "Settings", icon: Icon(Icons.settings)),
      ],
      tabChildren: [
        _buildExportTab(),
        _buildHistoryTab(),
        _buildScheduledTab(),
        _buildSettingsTab(),
      ],
    );
  }

  Widget _buildExportTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Export Configuration
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
                Row(
                  children: [
                    Icon(Icons.settings, color: primaryColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Export Configuration",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                QTextField(
                  label: "Export Name",
                  value: exportName,
                  hint: "Enter export file name",
                  onChanged: (value) {
                    exportName = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: spSm),
                QDropdownField(
                  label: "Data Type",
                  items: dataTypes,
                  value: selectedDataType,
                  onChanged: (value, label) {
                    selectedDataType = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: spSm),
                QDropdownField(
                  label: "Export Format",
                  items: exportFormats,
                  value: selectedFormat,
                  onChanged: (value, label) {
                    selectedFormat = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: spSm),
                QDropdownField(
                  label: "Date Range",
                  items: dateRanges,
                  value: selectedDateRange,
                  onChanged: (value, label) {
                    selectedDateRange = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: spSm),
                QDropdownField(
                  label: "Compression",
                  items: compressionOptions,
                  value: selectedCompression,
                  onChanged: (value, label) {
                    selectedCompression = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          SizedBox(height: spMd),

          // Field Selection
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
                Row(
                  children: [
                    Icon(Icons.view_column, color: primaryColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Field Selection",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        if (selectedFields.length == availableFields.length) {
                          selectedFields.clear();
                        } else {
                          selectedFields = availableFields.map((field) => field["value"].toString()).toList();
                        }
                        setState(() {});
                      },
                      child: Text(
                        selectedFields.length == availableFields.length ? "Deselect All" : "Select All",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Column(
                  children: availableFields.map((field) {
                    bool isSelected = selectedFields.contains(field["value"]);
                    return Container(
                      margin: EdgeInsets.only(bottom: spXs),
                      child: Row(
                        children: [
                          Checkbox(
                            value: isSelected,
                            onChanged: (value) {
                              if (value == true) {
                                selectedFields.add(field["value"]);
                              } else {
                                selectedFields.remove(field["value"]);
                              }
                              setState(() {});
                            },
                            activeColor: primaryColor,
                          ),
                          Expanded(
                            child: Text(
                              "${field["label"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                              ),
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

          SizedBox(height: spMd),

          // Export Options
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
                Row(
                  children: [
                    Icon(Icons.tune, color: primaryColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Export Options",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Checkbox(
                      value: includeDeleted,
                      onChanged: (value) {
                        includeDeleted = value ?? false;
                        setState(() {});
                      },
                      activeColor: primaryColor,
                    ),
                    Expanded(
                      child: Text(
                        "Include Deleted Records",
                        style: TextStyle(fontSize: 14, color: primaryColor),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: includeArchived,
                      onChanged: (value) {
                        includeArchived = value ?? false;
                        setState(() {});
                      },
                      activeColor: primaryColor,
                    ),
                    Expanded(
                      child: Text(
                        "Include Archived Data",
                        style: TextStyle(fontSize: 14, color: primaryColor),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: includeMetadata,
                      onChanged: (value) {
                        includeMetadata = value ?? false;
                        setState(() {});
                      },
                      activeColor: primaryColor,
                    ),
                    Expanded(
                      child: Text(
                        "Include Metadata & System Info",
                        style: TextStyle(fontSize: 14, color: primaryColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: spMd),

          // Export Preview
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: infoColor.withAlpha(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.preview, color: infoColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Export Preview",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                _buildPreviewItem("Data Type", selectedDataType.replaceAll('_', ' ').toUpperCase()),
                _buildPreviewItem("Format", selectedFormat.toUpperCase()),
                _buildPreviewItem("Fields Selected", "${selectedFields.length}/${availableFields.length}"),
                _buildPreviewItem("Estimated Size", "~25.6 MB"),
                _buildPreviewItem("Estimated Records", "~5,234"),
              ],
            ),
          ),

          SizedBox(height: spMd),

          // Export Buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Preview Export",
                  size: bs.md,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Start Export",
                  size: bs.md,
                  onPressed: () {
                    ss("Export process started successfully");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          // Summary Cards
          ResponsiveGridView(
            padding: EdgeInsets.all(spSm),
            minItemWidth: 200,
            children: [
              _buildSummaryCard("Total Exports", "147", Icons.file_download, primaryColor),
              _buildSummaryCard("This Month", "28", Icons.calendar_today, successColor),
              _buildSummaryCard("Data Exported", "2.4 GB", Icons.storage, infoColor),
              _buildSummaryCard("Success Rate", "94%", Icons.check_circle, successColor),
            ],
          ),

          SizedBox(height: spMd),

          // Export History List
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
                Row(
                  children: [
                    Icon(Icons.history, color: primaryColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Export History",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      icon: Icons.refresh,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                ...exportHistory.map((export) => _buildExportHistoryItem(export)).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExportHistoryItem(Map<String, dynamic> export) {
    Color statusColor = export["status"] == "completed" 
        ? successColor 
        : export["status"] == "processing" 
            ? warningColor 
            : dangerColor;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: statusColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              export["status"] == "completed" 
                  ? Icons.check_circle 
                  : export["status"] == "processing"
                      ? Icons.hourglass_empty
                      : Icons.error,
              color: statusColor,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${export["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${export["type"]} • ${export["format"]} • ${export["records"]} records",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "${export["status"].toString().toUpperCase()}",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${export["size"]} • ${export["date"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (export["status"] == "completed") ...[
            Column(
              children: [
                QButton(
                  icon: Icons.download,
                  size: bs.sm,
                  onPressed: () {},
                ),
                SizedBox(height: spXs),
                QButton(
                  icon: Icons.share,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
          ] else if (export["status"] == "processing") ...[
            QButton(
              icon: Icons.cancel,
              size: bs.sm,
              onPressed: () {},
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildScheduledTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
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
                Row(
                  children: [
                    Icon(Icons.schedule, color: primaryColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Scheduled Exports",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      icon: Icons.add,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                ...scheduledExports.map((scheduled) => _buildScheduledItem(scheduled)).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduledItem(Map<String, dynamic> scheduled) {
    Color statusColor = scheduled["status"] == "active" ? successColor : warningColor;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
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
                      "${scheduled["name"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${scheduled["type"]} • ${scheduled["format"]}",
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
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${scheduled["status"].toString().toUpperCase()}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            "${scheduled["schedule"]}",
            style: TextStyle(
              fontSize: 12,
              color: primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Text(
                "Last: ${scheduled["lastRun"]}",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "Next: ${scheduled["nextRun"]}",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: scheduled["status"] == "active" ? "Pause" : "Resume",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.delete,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
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
                Row(
                  children: [
                    Icon(Icons.settings, color: primaryColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Export Settings",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                _buildSettingItem(
                  "Default Export Format",
                  "Excel Spreadsheet",
                  Icons.description,
                ),
                _buildSettingItem(
                  "Auto-cleanup Old Exports",
                  "After 30 days",
                  Icons.auto_delete,
                ),
                _buildSettingItem(
                  "Maximum File Size",
                  "500 MB",
                  Icons.storage,
                ),
                _buildSettingItem(
                  "Email Notifications",
                  "Enabled",
                  Icons.email,
                ),
                _buildSettingItem(
                  "Cloud Storage Integration",
                  "Google Drive",
                  Icons.cloud,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(String title, String value, IconData icon) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Icon(icon, color: primaryColor, size: 20),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            icon: Icons.edit,
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
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
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              Spacer(),
              Icon(Icons.trending_up, color: successColor, size: 16),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
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
}
