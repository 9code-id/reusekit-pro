import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaDataExportView extends StatefulWidget {
  const HcaDataExportView({super.key});

  @override
  State<HcaDataExportView> createState() => _HcaDataExportViewState();
}

class _HcaDataExportViewState extends State<HcaDataExportView> {
  int currentTab = 0;
  String selectedFormat = "PDF";
  String selectedDateRange = "Last 30 Days";
  String selectedDataType = "All Data";
  bool includeCharts = true;
  bool includeImages = false;
  bool anonymizeData = false;
  String exportPassword = "";
  String exportEmail = "";

  List<Map<String, dynamic>> formatItems = [
    {"label": "PDF", "value": "PDF"},
    {"label": "CSV", "value": "CSV"},
    {"label": "Excel", "value": "Excel"},
    {"label": "JSON", "value": "JSON"},
  ];

  List<Map<String, dynamic>> dateRangeItems = [
    {"label": "Last 7 Days", "value": "Last 7 Days"},
    {"label": "Last 30 Days", "value": "Last 30 Days"},
    {"label": "Last 3 Months", "value": "Last 3 Months"},
    {"label": "Last 6 Months", "value": "Last 6 Months"},
    {"label": "Last Year", "value": "Last Year"},
    {"label": "All Time", "value": "All Time"},
  ];

  List<Map<String, dynamic>> dataTypeItems = [
    {"label": "All Data", "value": "All Data"},
    {"label": "Health Metrics", "value": "Health Metrics"},
    {"label": "Medications", "value": "Medications"},
    {"label": "Appointments", "value": "Appointments"},
    {"label": "Lab Results", "value": "Lab Results"},
  ];

  List<Map<String, dynamic>> exportHistory = [
    {
      "id": "1",
      "type": "Health Summary",
      "format": "PDF",
      "date": "2024-01-15",
      "size": "2.5 MB",
      "status": "Completed",
    },
    {
      "id": "2",
      "type": "Lab Results",
      "format": "CSV",
      "date": "2024-01-10",
      "size": "1.2 MB",
      "status": "Completed",
    },
    {
      "id": "3",
      "type": "Medication History",
      "format": "Excel",
      "date": "2024-01-05",
      "size": "856 KB",
      "status": "Failed",
    },
  ];

  List<Map<String, dynamic>> recentExports = [
    {
      "id": "1",
      "name": "Monthly Health Report - January 2024",
      "progress": 100,
      "status": "completed",
      "downloadUrl": "https://example.com/download/1",
    },
    {
      "id": "2",
      "name": "Lab Results Export",
      "progress": 75,
      "status": "processing",
      "downloadUrl": null,
    },
    {
      "id": "3",
      "name": "Medication Export",
      "progress": 0,
      "status": "queued",
      "downloadUrl": null,
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "completed":
      case "Completed":
        return successColor;
      case "processing":
        return warningColor;
      case "queued":
        return infoColor;
      case "Failed":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Data Export",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Export Data", icon: Icon(Icons.file_download)),
        Tab(text: "Quick Export", icon: Icon(Icons.flash_on)),
        Tab(text: "Export History", icon: Icon(Icons.history)),
        Tab(text: "Settings", icon: Icon(Icons.settings)),
      ],
      tabChildren: [
        _buildExportDataTab(),
        _buildQuickExportTab(),
        _buildExportHistoryTab(),
        _buildSettingsTab(),
      ],
    );
  }

  Widget _buildExportDataTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
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
              spacing: spSm,
              children: [
                Text(
                  "Export Configuration",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QDropdownField(
                  label: "Data Type",
                  items: dataTypeItems,
                  value: selectedDataType,
                  onChanged: (value, label) {
                    selectedDataType = value;
                    setState(() {});
                  },
                ),
                QDropdownField(
                  label: "Date Range",
                  items: dateRangeItems,
                  value: selectedDateRange,
                  onChanged: (value, label) {
                    selectedDateRange = value;
                    setState(() {});
                  },
                ),
                QDropdownField(
                  label: "Export Format",
                  items: formatItems,
                  value: selectedFormat,
                  onChanged: (value, label) {
                    selectedFormat = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

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
              spacing: spSm,
              children: [
                Text(
                  "Export Options",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QSwitch(
                  items: [
                    {
                      "label": "Include Charts & Graphs",
                      "value": true,
                      "checked": includeCharts,
                    }
                  ],
                  value: [if (includeCharts) {"label": "Include Charts & Graphs", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    includeCharts = values.isNotEmpty;
                    setState(() {});
                  },
                ),
                QSwitch(
                  items: [
                    {
                      "label": "Include Images & Attachments",
                      "value": true,
                      "checked": includeImages,
                    }
                  ],
                  value: [if (includeImages) {"label": "Include Images & Attachments", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    includeImages = values.isNotEmpty;
                    setState(() {});
                  },
                ),
                QSwitch(
                  items: [
                    {
                      "label": "Anonymize Personal Data",
                      "value": true,
                      "checked": anonymizeData,
                    }
                  ],
                  value: [if (anonymizeData) {"label": "Anonymize Personal Data", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    anonymizeData = values.isNotEmpty;
                    setState(() {});
                  },
                ),
                QTextField(
                  label: "Password Protection (Optional)",
                  value: exportPassword,
                  obscureText: true,
                  onChanged: (value) {
                    exportPassword = value;
                    setState(() {});
                  },
                ),
                QTextField(
                  label: "Email Export Link To",
                  value: exportEmail,
                  onChanged: (value) {
                    exportEmail = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Export Preview
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Export Preview",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    spacing: spXs,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Data Type:", style: TextStyle(fontWeight: FontWeight.w600)),
                          Text("$selectedDataType"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Date Range:", style: TextStyle(fontWeight: FontWeight.w600)),
                          Text("$selectedDateRange"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Format:", style: TextStyle(fontWeight: FontWeight.w600)),
                          Text("$selectedFormat"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Estimated Size:", style: TextStyle(fontWeight: FontWeight.w600)),
                          Text("~2.5 MB"),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: spSm),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Start Export",
                    size: bs.md,
                    onPressed: () {
                      ss("Export started successfully");
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickExportTab() {
    List<Map<String, dynamic>> quickExportOptions = [
      {
        "title": "Health Summary Report",
        "description": "Complete health overview with charts",
        "format": "PDF",
        "icon": Icons.assignment,
        "color": primaryColor,
      },
      {
        "title": "Lab Results Export",
        "description": "All laboratory test results",
        "format": "CSV",
        "icon": Icons.science,
        "color": successColor,
      },
      {
        "title": "Medication History",
        "description": "Complete medication records",
        "format": "Excel",
        "icon": Icons.medication,
        "color": warningColor,
      },
      {
        "title": "Appointment Records",
        "description": "All appointment history",
        "format": "PDF",
        "icon": Icons.event,
        "color": infoColor,
      },
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Text(
            "Quick Export Templates",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...quickExportOptions.map((option) => Container(
            padding: EdgeInsets.all(spSm),
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
                    color: (option["color"] as Color).withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    option["icon"],
                    color: option["color"],
                    size: 24,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${option["title"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${option["description"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "Format: ${option["format"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: option["color"],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                QButton(
                  label: "Export",
                  size: bs.sm,
                  onPressed: () {
                    ss("${option["title"]} export started");
                  },
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildExportHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Recent Exports
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Recent Exports",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...recentExports.map((export) => Container(
                  padding: EdgeInsets.all(spSm),
                  margin: EdgeInsets.only(bottom: spXs),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "${export["name"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: _getStatusColor(export["status"]),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${export["status"]}".toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (export["status"] != "completed") ...[
                        LinearProgressIndicator(
                          value: (export["progress"] as int) / 100,
                          backgroundColor: disabledColor,
                          valueColor: AlwaysStoppedAnimation(_getStatusColor(export["status"])),
                        ),
                        Text(
                          "${export["progress"]}% complete",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                      if (export["status"] == "completed") ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            QButton(
                              label: "Download",
                              size: bs.sm,
                              onPressed: () {
                                ss("Download started");
                              },
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                )).toList(),
              ],
            ),
          ),

          // Export History
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Export History",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...exportHistory.map((export) => Container(
                  padding: EdgeInsets.all(spSm),
                  margin: EdgeInsets.only(bottom: spXs),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${export["type"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${export["format"]} • ${export["size"]} • ${export["date"]}",
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
                          color: _getStatusColor(export["status"]),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${export["status"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                )).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Auto Export Settings
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Auto Export Settings",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QSwitch(
                  items: [
                    {
                      "label": "Enable Monthly Auto Export",
                      "value": true,
                      "checked": false,
                    }
                  ],
                  value: [],
                  onChanged: (values, ids) {
                    setState(() {});
                  },
                ),
                QDropdownField(
                  label: "Auto Export Format",
                  items: formatItems,
                  value: selectedFormat,
                  onChanged: (value, label) {
                    selectedFormat = value;
                    setState(() {});
                  },
                ),
                QTextField(
                  label: "Auto Export Email",
                  value: exportEmail,
                  onChanged: (value) {
                    exportEmail = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Storage Settings
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Storage & Cleanup",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    spacing: spXs,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total Export Storage:", style: TextStyle(fontWeight: FontWeight.w600)),
                          Text("24.7 MB"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total Exports:", style: TextStyle(fontWeight: FontWeight.w600)),
                          Text("15 files"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Oldest Export:", style: TextStyle(fontWeight: FontWeight.w600)),
                          Text("3 months ago"),
                        ],
                      ),
                    ],
                  ),
                ),
                QSwitch(
                  items: [
                    {
                      "label": "Auto-delete exports after 6 months",
                      "value": true,
                      "checked": true,
                    }
                  ],
                  value: [{"label": "Auto-delete exports after 6 months", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    setState(() {});
                  },
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Clear All Export Files",
                    size: bs.md,
                    onPressed: () {
                      sw("This will delete all export files permanently");
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
