import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlUpload9View extends StatefulWidget {
  @override
  State<GrlUpload9View> createState() => _GrlUpload9ViewState();
}

class _GrlUpload9ViewState extends State<GrlUpload9View> {
  String selectedTimeframe = "today";
  bool showFailedOnly = false;
  bool showLargeFilesOnly = false;
  String sortBy = "date";
  String filterStatus = "all";

  List<Map<String, dynamic>> timeframeItems = [
    {"label": "Today", "value": "today"},
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"},
    {"label": "Last 3 Months", "value": "3months"},
    {"label": "All Time", "value": "all"},
  ];

  List<Map<String, dynamic>> sortByItems = [
    {"label": "Date", "value": "date"},
    {"label": "File Name", "value": "name"},
    {"label": "File Size", "value": "size"},
    {"label": "Status", "value": "status"},
    {"label": "Duration", "value": "duration"},
  ];

  List<Map<String, dynamic>> statusFilterItems = [
    {"label": "All", "value": "all"},
    {"label": "Completed", "value": "completed"},
    {"label": "Failed", "value": "failed"},
    {"label": "Cancelled", "value": "cancelled"},
  ];

  List<Map<String, dynamic>> uploadHistory = [
    {
      "name": "project_report.pdf",
      "size": "2.4 MB",
      "status": "completed",
      "duration": "12s",
      "timestamp": "2024-01-22 14:30:25",
      "destination": "Google Drive",
      "speed": "200 KB/s",
      "attempts": 1,
      "id": "UP001"
    },
    {
      "name": "team_presentation.pptx",
      "size": "15.7 MB",
      "status": "completed",
      "duration": "1m 25s",
      "timestamp": "2024-01-22 13:45:12",
      "destination": "Dropbox",
      "speed": "185 KB/s",
      "attempts": 1,
      "id": "UP002"
    },
    {
      "name": "backup_database.sql",
      "size": "125.3 MB",
      "status": "failed",
      "duration": "8m 42s",
      "timestamp": "2024-01-22 12:15:30",
      "destination": "FTP Server",
      "speed": "240 KB/s",
      "attempts": 3,
      "id": "UP003",
      "error": "Connection timeout"
    },
    {
      "name": "video_conference.mp4",
      "size": "450.2 MB",
      "status": "completed",
      "duration": "25m 18s",
      "timestamp": "2024-01-22 11:20:45",
      "destination": "OneDrive",
      "speed": "300 KB/s",
      "attempts": 1,
      "id": "UP004"
    },
    {
      "name": "design_assets.zip",
      "size": "78.9 MB",
      "status": "cancelled",
      "duration": "3m 15s",
      "timestamp": "2024-01-22 10:30:18",
      "destination": "Amazon S3",
      "speed": "410 KB/s",
      "attempts": 1,
      "id": "UP005"
    },
    {
      "name": "annual_report.docx",
      "size": "3.2 MB",
      "status": "completed",
      "duration": "18s",
      "timestamp": "2024-01-21 16:45:22",
      "destination": "SharePoint",
      "speed": "178 KB/s",
      "attempts": 2,
      "id": "UP006"
    },
  ];

  List<Map<String, dynamic>> summaryStats = [
    {
      "label": "Total Uploads",
      "value": "247",
      "color": primaryColor,
      "icon": Icons.cloud_upload,
    },
    {
      "label": "Success Rate",
      "value": "94.3%",
      "color": successColor,
      "icon": Icons.check_circle,
    },
    {
      "label": "Data Transferred",
      "value": "12.4 GB",
      "color": infoColor,
      "icon": Icons.data_usage,
    },
    {
      "label": "Failed Uploads",
      "value": "14",
      "color": dangerColor,
      "icon": Icons.error,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload History"),
        actions: [
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.delete_sweep),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Summary Statistics
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    primaryColor,
                    primaryColor.withAlpha(180),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.history,
                        color: Colors.white,
                        size: 28,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Upload Summary",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  ResponsiveGridView(
                    minItemWidth: 150,
                    children: summaryStats.map((stat) => Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                stat["icon"] as IconData,
                                color: Colors.white,
                                size: 20,
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${stat["label"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.white.withAlpha(200),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${stat["value"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    )).toList(),
                  ),
                ],
              ),
            ),

            // Filters
            Text(
              "Filters",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                children: [
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Timeframe",
                          items: timeframeItems,
                          value: selectedTimeframe,
                          onChanged: (value, label) {
                            selectedTimeframe = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: QDropdownField(
                          label: "Status",
                          items: statusFilterItems,
                          value: filterStatus,
                          onChanged: (value, label) {
                            filterStatus = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),

                  QDropdownField(
                    label: "Sort By",
                    items: sortByItems,
                    value: sortBy,
                    onChanged: (value, label) {
                      sortBy = value;
                      setState(() {});
                    },
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Failed Only",
                              "value": true,
                              "checked": showFailedOnly,
                            }
                          ],
                          value: [
                            if (showFailedOnly)
                              {
                                "label": "Failed Only",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            showFailedOnly = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Large Files Only (>50MB)",
                              "value": true,
                              "checked": showLargeFilesOnly,
                            }
                          ],
                          value: [
                            if (showLargeFilesOnly)
                              {
                                "label": "Large Files Only (>50MB)",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            showLargeFilesOnly = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Upload History List
            Text(
              "Upload History",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            ...uploadHistory.map((upload) => Container(
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
                border: Border.all(
                  color: _getStatusColor(upload["status"]).withAlpha(50),
                ),
              ),
              child: ExpansionTile(
                leading: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: _getStatusColor(upload["status"]).withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    _getStatusIcon(upload["status"]),
                    color: _getStatusColor(upload["status"]),
                    size: 20,
                  ),
                ),
                title: Text(
                  "${upload["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  "${upload["size"]} • ${upload["destination"]} • ${upload["timestamp"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                trailing: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spSm,
                    vertical: spXs,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(upload["status"]),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${upload["status"]}".toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(30),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(radiusLg),
                        bottomRight: Radius.circular(radiusLg),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: _buildDetailItem(
                                "Upload ID",
                                "${upload["id"]}",
                                Icons.tag,
                              ),
                            ),
                            Expanded(
                              child: _buildDetailItem(
                                "Duration",
                                "${upload["duration"]}",
                                Icons.timer,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: _buildDetailItem(
                                "Speed",
                                "${upload["speed"]}",
                                Icons.speed,
                              ),
                            ),
                            Expanded(
                              child: _buildDetailItem(
                                "Attempts",
                                "${upload["attempts"]}",
                                Icons.refresh,
                              ),
                            ),
                          ],
                        ),
                        if (upload["error"] != null) ...[
                          _buildDetailItem(
                            "Error",
                            "${upload["error"]}",
                            Icons.error_outline,
                          ),
                        ],
                        SizedBox(height: spSm),
                        Row(
                          spacing: spSm,
                          children: [
                            if (upload["status"] == "failed") ...[
                              Expanded(
                                child: QButton(
                                  label: "Retry",
                                  color: warningColor,
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                              ),
                            ],
                            Expanded(
                              child: QButton(
                                label: "View Details",
                                size: bs.sm,
                                onPressed: () {},
                              ),
                            ),
                            Expanded(
                              child: QButton(
                                label: "Delete",
                                color: dangerColor,
                                size: bs.sm,
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),

            // Action Buttons
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Export History",
                    color: secondaryColor,
                    size: bs.md,
                    onPressed: () {},
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Clear History",
                    color: dangerColor,
                    size: bs.md,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: disabledBoldColor,
        ),
        SizedBox(width: spXs),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "failed":
        return dangerColor;
      case "cancelled":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "completed":
        return Icons.check_circle;
      case "failed":
        return Icons.error;
      case "cancelled":
        return Icons.cancel;
      default:
        return Icons.help;
    }
  }
}
