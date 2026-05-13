import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlArchive10View extends StatefulWidget {
  @override
  State<GrlArchive10View> createState() => _GrlArchive10ViewState();
}

class _GrlArchive10ViewState extends State<GrlArchive10View> {
  String searchQuery = "";
  String selectedTimeframe = "Last 30 Days";
  String selectedOperation = "All Operations";
  
  List<Map<String, dynamic>> backupJobs = [
    {
      "id": "BACKUP-001",
      "name": "Daily Archive Backup",
      "status": "Completed",
      "progress": 100,
      "startTime": "2024-12-15 02:00:00",
      "endTime": "2024-12-15 04:30:00",
      "duration": "2h 30m",
      "filesProcessed": 1250,
      "totalSize": "45.8 GB",
      "destination": "AWS S3 - Primary",
      "type": "Incremental",
      "nextRun": "2024-12-16 02:00:00",
      "success": true,
      "errors": 0,
      "warnings": 2,
    },
    {
      "id": "BACKUP-002",
      "name": "Weekly Full Backup",
      "status": "In Progress",
      "progress": 65,
      "startTime": "2024-12-15 01:00:00",
      "endTime": null,
      "duration": "5h 15m",
      "filesProcessed": 892,
      "totalSize": "128.4 GB",
      "destination": "Google Cloud Storage",
      "type": "Full",
      "nextRun": "2024-12-22 01:00:00",
      "success": null,
      "errors": 0,
      "warnings": 0,
    },
    {
      "id": "BACKUP-003",
      "name": "Critical Files Backup",
      "status": "Failed",
      "progress": 35,
      "startTime": "2024-12-14 23:30:00",
      "endTime": "2024-12-15 00:45:00",
      "duration": "1h 15m",
      "filesProcessed": 567,
      "totalSize": "12.3 GB",
      "destination": "Azure Blob Storage",
      "type": "Incremental",
      "nextRun": "2024-12-15 23:30:00",
      "success": false,
      "errors": 15,
      "warnings": 8,
    },
    {
      "id": "BACKUP-004",
      "name": "Media Archive Backup",
      "status": "Completed",
      "progress": 100,
      "startTime": "2024-12-14 03:00:00",
      "endTime": "2024-12-14 08:45:00",
      "duration": "5h 45m",
      "filesProcessed": 2340,
      "totalSize": "256.7 GB",
      "destination": "Local NAS Storage",
      "type": "Full",
      "nextRun": "2024-12-21 03:00:00",
      "success": true,
      "errors": 0,
      "warnings": 5,
    },
    {
      "id": "BACKUP-005",
      "name": "Database Backup",
      "status": "Scheduled",
      "progress": 0,
      "startTime": null,
      "endTime": null,
      "duration": null,
      "filesProcessed": 0,
      "totalSize": "8.9 GB",
      "destination": "AWS S3 - Secondary",
      "type": "Database",
      "nextRun": "2024-12-16 00:00:00",
      "success": null,
      "errors": 0,
      "warnings": 0,
    },
  ];

  List<Map<String, dynamic>> recentRestores = [
    {
      "id": "RESTORE-001",
      "requestedBy": "Sarah Johnson",
      "fileName": "Q3 Financial Report.pdf",
      "requestDate": "2024-12-15 14:20:00",
      "status": "Completed",
      "restoreLocation": "/Documents/Financial/2024/",
      "sourceBackup": "Daily Archive Backup - 2024-12-10",
      "duration": "5 minutes",
    },
    {
      "id": "RESTORE-002",
      "requestedBy": "Mike Wilson",
      "fileName": "Project Alpha Documentation",
      "requestDate": "2024-12-15 11:45:00",
      "status": "In Progress",
      "restoreLocation": "/Projects/Alpha/",
      "sourceBackup": "Weekly Full Backup - 2024-12-08",
      "duration": "15 minutes",
    },
    {
      "id": "RESTORE-003",
      "requestedBy": "Emma Davis",
      "fileName": "Marketing Assets Folder",
      "requestDate": "2024-12-14 16:30:00",
      "status": "Failed",
      "restoreLocation": "/Marketing/Assets/",
      "sourceBackup": "Media Archive Backup - 2024-12-07",
      "duration": "3 minutes",
    },
  ];

  List<Map<String, dynamic>> timeframeOptions = [
    {"label": "Last 24 Hours", "value": "Last 24 Hours"},
    {"label": "Last 7 Days", "value": "Last 7 Days"},
    {"label": "Last 30 Days", "value": "Last 30 Days"},
    {"label": "Last 3 Months", "value": "Last 3 Months"},
  ];

  List<Map<String, dynamic>> operationOptions = [
    {"label": "All Operations", "value": "All Operations"},
    {"label": "Backup", "value": "Backup"},
    {"label": "Restore", "value": "Restore"},
    {"label": "Verification", "value": "Verification"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Backup & Restore"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _createBackupJob();
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Handle settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Quick Stats
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 150,
              children: [
                _buildStatCard(
                  "Active Backups",
                  "5",
                  "2 running now",
                  Icons.backup,
                  primaryColor,
                ),
                _buildStatCard(
                  "Success Rate",
                  "98.5%",
                  "Last 30 days",
                  Icons.check_circle,
                  successColor,
                ),
                _buildStatCard(
                  "Total Storage",
                  "2.4 TB",
                  "1.8 TB used",
                  Icons.storage,
                  infoColor,
                ),
                _buildStatCard(
                  "Failed Jobs",
                  "3",
                  "Requires attention",
                  Icons.error,
                  dangerColor,
                ),
              ],
            ),

            // Filter Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  QTextField(
                    label: "Search operations...",
                    value: searchQuery,
                    hint: "Search by job name or destination",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Timeframe",
                          items: timeframeOptions,
                          value: selectedTimeframe,
                          onChanged: (value, label) {
                            selectedTimeframe = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Operation",
                          items: operationOptions,
                          value: selectedOperation,
                          onChanged: (value, label) {
                            selectedOperation = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Backup Jobs Section
            Container(
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
                        Icons.backup,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Backup Jobs",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "Run Backup",
                        icon: Icons.play_arrow,
                        size: bs.sm,
                        onPressed: () {
                          _runBackup();
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ...backupJobs.map((job) => Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border(
                        left: BorderSide(
                          width: 4,
                          color: _getStatusColor(job["status"]),
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${job["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: _getStatusColor(job["status"]).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${job["status"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: _getStatusColor(job["status"]),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),

                        // Progress Bar (if in progress)
                        if (job["status"] == "In Progress") ...[
                          Row(
                            children: [
                              Expanded(
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: disabledColor.withAlpha(30),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                    ),
                                    Container(
                                      height: 8,
                                      width: (MediaQuery.of(context).size.width - 96) * 
                                             (job["progress"] as int) / 100,
                                      decoration: BoxDecoration(
                                        color: warningColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${job["progress"]}%",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: warningColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                        ],

                        // Job Details
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Type: ${job["type"]} • Destination: ${job["destination"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(height: spXxs),
                                  Text(
                                    "Files: ${job["filesProcessed"]} • Size: ${job["totalSize"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  if (job["duration"] != null) ...[
                                    SizedBox(height: spXxs),
                                    Text(
                                      "Duration: ${job["duration"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),

                        // Footer with errors/warnings and next run
                        Row(
                          children: [
                            if (job["errors"] > 0 || job["warnings"] > 0) ...[
                              if (job["errors"] > 0)
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: dangerColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${job["errors"]} errors",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: dangerColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              SizedBox(width: spXs),
                              if (job["warnings"] > 0)
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: warningColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${job["warnings"]} warnings",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: warningColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                            ],
                            Spacer(),
                            if (job["nextRun"] != null)
                              Text(
                                "Next: ${job["nextRun"]?.split(" ")[0]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledColor,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  )).toList(),
                ],
              ),
            ),

            // Recent Restores Section
            Container(
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
                        Icons.restore,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Recent Restores",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "New Restore",
                        icon: Icons.add,
                        size: bs.sm,
                        onPressed: () {
                          _newRestore();
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ...recentRestores.map((restore) => Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.restore,
                              color: primaryColor,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "${restore["fileName"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: _getStatusColor(restore["status"]).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${restore["status"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: _getStatusColor(restore["status"]),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Requested by ${restore["requestedBy"]} • ${restore["duration"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXxs),
                        Text(
                          "Source: ${restore["sourceBackup"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledColor,
                          ),
                        ),
                      ],
                    ),
                  )).toList(),
                ],
              ),
            ),

            // Quick Actions
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Verify Backups",
                          icon: Icons.verified,
                          size: bs.sm,
                          onPressed: () {
                            _verifyBackups();
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "View Logs",
                          icon: Icons.list_alt,
                          size: bs.sm,
                          onPressed: () {
                            // Handle view logs
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

  Widget _buildStatCard(String title, String value, String subtitle, IconData icon, Color color) {
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
                icon,
                color: color,
                size: 24,
              ),
              Spacer(),
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
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXxs),
          Text(
            subtitle,
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
      case "Completed":
        return successColor;
      case "In Progress":
        return warningColor;
      case "Failed":
        return dangerColor;
      case "Scheduled":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  void _createBackupJob() {
    // Handle create backup job
    si("Creating new backup job...");
  }

  void _runBackup() async {
    bool isConfirmed = await confirm("Run manual backup now?");
    
    if (isConfirmed) {
      showLoading();
      
      // Simulate backup start
      await Future.delayed(Duration(seconds: 2));
      
      hideLoading();
      ss("Backup job started successfully");
    }
  }

  void _newRestore() {
    // Handle new restore request
    si("Creating new restore request...");
  }

  void _verifyBackups() async {
    showLoading();
    
    // Simulate backup verification
    await Future.delayed(Duration(seconds: 3));
    
    hideLoading();
    ss("Backup verification completed successfully");
  }
}
