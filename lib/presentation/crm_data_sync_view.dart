import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmDataSyncView extends StatefulWidget {
  const CrmDataSyncView({super.key});

  @override
  State<CrmDataSyncView> createState() => _CrmDataSyncViewState();
}

class _CrmDataSyncViewState extends State<CrmDataSyncView> {
  final formKey = GlobalKey<FormState>();
  String syncName = "";
  String selectedSource = "Salesforce";
  String selectedDestination = "HubSpot";
  String syncFrequency = "Hourly";
  String selectedDataType = "Contacts";
  bool autoSync = true;
  bool bidirectionalSync = false;
  String searchQuery = "";
  bool showActiveOnly = true;

  List<Map<String, dynamic>> sourceOptions = [
    {"label": "Salesforce", "value": "salesforce"},
    {"label": "HubSpot", "value": "hubspot"},
    {"label": "Pipedrive", "value": "pipedrive"},
    {"label": "Mailchimp", "value": "mailchimp"},
    {"label": "Google Sheets", "value": "google_sheets"},
    {"label": "CSV File", "value": "csv_file"},
  ];

  List<Map<String, dynamic>> destinationOptions = [
    {"label": "HubSpot", "value": "hubspot"},
    {"label": "Salesforce", "value": "salesforce"},
    {"label": "Pipedrive", "value": "pipedrive"},
    {"label": "Mailchimp", "value": "mailchimp"},
    {"label": "Google Sheets", "value": "google_sheets"},
    {"label": "Database", "value": "database"},
  ];

  List<Map<String, dynamic>> frequencyOptions = [
    {"label": "Real-time", "value": "realtime"},
    {"label": "Every 15 minutes", "value": "15min"},
    {"label": "Hourly", "value": "hourly"},
    {"label": "Daily", "value": "daily"},
    {"label": "Weekly", "value": "weekly"},
    {"label": "Manual", "value": "manual"},
  ];

  List<Map<String, dynamic>> dataTypeOptions = [
    {"label": "Contacts", "value": "contacts"},
    {"label": "Deals", "value": "deals"},
    {"label": "Companies", "value": "companies"},
    {"label": "Activities", "value": "activities"},
    {"label": "Products", "value": "products"},
    {"label": "All Data", "value": "all"},
  ];

  List<Map<String, dynamic>> syncJobs = [
    {
      "id": "1",
      "name": "Salesforce to HubSpot Contacts",
      "source": "Salesforce",
      "destination": "HubSpot", 
      "dataType": "Contacts",
      "frequency": "Hourly",
      "status": "active",
      "lastSync": "2024-12-19 14:30",
      "nextSync": "2024-12-19 15:30",
      "recordsSynced": 1245,
      "totalRecords": 1245,
      "successRate": 98.5,
      "bidirectional": false,
    },
    {
      "id": "2",
      "name": "HubSpot Deals Import",
      "source": "HubSpot",
      "destination": "Database",
      "dataType": "Deals",
      "frequency": "Daily",
      "status": "active",
      "lastSync": "2024-12-19 02:00",
      "nextSync": "2024-12-20 02:00",
      "recordsSynced": 456,
      "totalRecords": 478,
      "successRate": 95.4,
      "bidirectional": true,
    },
    {
      "id": "3",
      "name": "Mailchimp Contact Sync",
      "source": "Mailchimp",
      "destination": "Salesforce",
      "dataType": "Contacts",
      "frequency": "Manual",
      "status": "paused",
      "lastSync": "2024-12-18 10:15",
      "nextSync": null,
      "recordsSynced": 2340,
      "totalRecords": 2340,
      "successRate": 100.0,
      "bidirectional": false,
    },
    {
      "id": "4",
      "name": "Google Sheets Export",
      "source": "Database",
      "destination": "Google Sheets",
      "dataType": "Companies",
      "frequency": "Weekly",
      "status": "error",
      "lastSync": "2024-12-17 08:00",
      "nextSync": "2024-12-24 08:00",
      "recordsSynced": 89,
      "totalRecords": 156,
      "successRate": 57.1,
      "bidirectional": false,
    },
  ];

  List<Map<String, dynamic>> syncLogs = [
    {
      "id": "1",
      "jobId": "1",
      "jobName": "Salesforce to HubSpot Contacts",
      "timestamp": "2024-12-19 14:30",
      "status": "success",
      "recordsProcessed": 15,
      "recordsSucceeded": 15,
      "recordsFailed": 0,
      "duration": "2.3s",
      "message": "Sync completed successfully",
    },
    {
      "id": "2", 
      "jobId": "2",
      "jobName": "HubSpot Deals Import",
      "timestamp": "2024-12-19 02:00",
      "status": "success",
      "recordsProcessed": 23,
      "recordsSucceeded": 22,
      "recordsFailed": 1,
      "duration": "8.7s",
      "message": "1 record failed validation",
    },
    {
      "id": "3",
      "jobId": "4",
      "jobName": "Google Sheets Export",
      "timestamp": "2024-12-17 08:00",
      "status": "error",
      "recordsProcessed": 156,
      "recordsSucceeded": 89,
      "recordsFailed": 67,
      "duration": "45.2s",
      "message": "Authentication error with Google Sheets API",
    },
  ];

  int currentTab = 0;

  List<Map<String, dynamic>> get filteredSyncJobs {
    return syncJobs.where((job) {
      bool matchesSearch = searchQuery.isEmpty ||
          (job["name"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = !showActiveOnly || job["status"] == "active";
      
      return matchesSearch && matchesStatus;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "paused":
        return warningColor;
      case "error":
        return dangerColor;
      case "running":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getLogStatusColor(String status) {
    switch (status) {
      case "success":
        return successColor;
      case "error":
        return dangerColor;
      case "warning":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  void _triggerSync(String id) async {
    showLoading();
    // Simulate sync process
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    
    int index = syncJobs.indexWhere((job) => job["id"] == id);
    if (index != -1) {
      syncJobs[index]["lastSync"] = "2024-12-19 ${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}";
      setState(() {});
      ss("Sync triggered successfully");
    }
  }

  void _pauseSync(String id) {
    int index = syncJobs.indexWhere((job) => job["id"] == id);
    if (index != -1) {
      syncJobs[index]["status"] = syncJobs[index]["status"] == "active" ? "paused" : "active";
      setState(() {});
      si("Sync job ${syncJobs[index]["status"] == "active" ? "resumed" : "paused"}");
    }
  }

  void _createSyncJob() {
    if (formKey.currentState!.validate()) {
      ss("Data sync job created successfully");
      back();
    }
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: primaryColor.withAlpha(30)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.sync, color: primaryColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Active Sync Jobs",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${syncJobs.where((job) => job["status"] == "active").length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: successColor.withAlpha(30)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.check_circle, color: successColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Records Synced",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "4.1K",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
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
                          Icon(Icons.trending_up, color: infoColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Success Rate",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "97.8%",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: warningColor.withAlpha(30)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.schedule, color: warningColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Last Sync",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "5 min ago",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: infoColor.withAlpha(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.info, color: infoColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Sync Performance",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "2.1s",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "Avg. Duration",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "15",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Daily Syncs",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "1",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: dangerColor,
                            ),
                          ),
                          Text(
                            "Errors",
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSyncJobsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search Sync Jobs",
                  value: searchQuery,
                  hint: "Search by name",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {
                  currentTab = 3;
                  setState(() {});
                },
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Show Active Only",
                      "value": true,
                      "checked": showActiveOnly,
                    }
                  ],
                  value: [
                    if (showActiveOnly)
                      {
                        "label": "Show Active Only",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    showActiveOnly = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sync Jobs (${filteredSyncJobs.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Column(
                  spacing: spSm,
                  children: filteredSyncJobs.map((job) {
                    return Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                        border: job["status"] == "error"
                            ? Border.all(color: dangerColor.withAlpha(50), width: 2)
                            : null,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${job["name"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Row(
                                      children: [
                                        Text(
                                          "${job["source"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: infoColor,
                                          ),
                                        ),
                                        Icon(
                                          job["bidirectional"] as bool ? Icons.sync_alt : Icons.arrow_forward,
                                          size: 16,
                                          color: disabledBoldColor,
                                        ),
                                        Text(
                                          "${job["destination"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: infoColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(job["status"] as String).withAlpha(10),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${job["status"]}".toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: _getStatusColor(job["status"] as String),
                                  ),
                                ),
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
                                  color: primaryColor.withAlpha(10),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${job["dataType"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "Frequency: ${job["frequency"]}",
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
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "${job["recordsSynced"]}/${job["totalRecords"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "Records",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "${(job["successRate"] as double).toStringAsFixed(1)}%",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: successColor,
                                      ),
                                    ),
                                    Text(
                                      "Success",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      job["lastSync"] != null ? "Recently" : "Never",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: job["lastSync"] != null ? successColor : disabledColor,
                                      ),
                                    ),
                                    Text(
                                      "Last Sync",
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
                          if (job["nextSync"] != null) ...[
                            SizedBox(height: spSm),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: infoColor.withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.schedule,
                                    size: 16,
                                    color: infoColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Next sync: ${job["nextSync"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: infoColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          SizedBox(height: spSm),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              QButton(
                                label: "Sync Now",
                                size: bs.sm,
                                onPressed: () => _triggerSync(job["id"] as String),
                              ),
                              SizedBox(width: spSm),
                              QButton(
                                label: job["status"] == "active" ? "Pause" : "Resume",
                                size: bs.sm,
                                onPressed: () => _pauseSync(job["id"] as String),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Recent Sync Logs",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Column(
                  spacing: spSm,
                  children: syncLogs.map((log) {
                    return Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                        border: log["status"] == "error"
                            ? Border.all(color: dangerColor.withAlpha(50))
                            : null,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  "${log["jobName"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
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
                                  color: _getLogStatusColor(log["status"] as String).withAlpha(10),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${log["status"]}".toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: _getLogStatusColor(log["status"] as String),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${log["timestamp"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "Duration: ${log["duration"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "${log["recordsProcessed"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "Processed",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "${log["recordsSucceeded"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: successColor,
                                      ),
                                    ),
                                    Text(
                                      "Success",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "${log["recordsFailed"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: dangerColor,
                                      ),
                                    ),
                                    Text(
                                      "Failed",
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
                          SizedBox(height: spSm),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${log["message"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
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
        ],
      ),
    );
  }

  Widget _buildCreateTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Form(
        key: formKey,
        child: Column(
          spacing: spMd,
          children: [
            QTextField(
              label: "Sync Job Name",
              value: syncName,
              hint: "Enter descriptive name for this sync job",
              validator: Validator.required,
              onChanged: (value) {
                syncName = value;
                setState(() {});
              },
            ),
            QDropdownField(
              label: "Data Source",
              items: sourceOptions,
              value: selectedSource,
              onChanged: (value, label) {
                selectedSource = value;
                setState(() {});
              },
            ),
            QDropdownField(
              label: "Destination",
              items: destinationOptions,
              value: selectedDestination,
              onChanged: (value, label) {
                selectedDestination = value;
                setState(() {});
              },
            ),
            QDropdownField(
              label: "Data Type",
              items: dataTypeOptions,
              value: selectedDataType,
              onChanged: (value, label) {
                selectedDataType = value;
                setState(() {});
              },
            ),
            QDropdownField(
              label: "Sync Frequency",
              items: frequencyOptions,
              value: syncFrequency,
              onChanged: (value, label) {
                syncFrequency = value;
                setState(() {});
              },
            ),
            Row(
              children: [
                Expanded(
                  child: QSwitch(
                    items: [
                      {
                        "label": "Auto Sync",
                        "value": true,
                        "checked": autoSync,
                      }
                    ],
                    value: [
                      if (autoSync)
                        {
                          "label": "Auto Sync",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      autoSync = values.isNotEmpty;
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
                        "label": "Bidirectional Sync",
                        "value": true,
                        "checked": bidirectionalSync,
                      }
                    ],
                    value: [
                      if (bidirectionalSync)
                        {
                          "label": "Bidirectional Sync",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      bidirectionalSync = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: warningColor.withAlpha(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.warning, color: warningColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Sync Configuration",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Ensure both systems have proper API credentials configured\n• Test sync with a small data set before enabling auto sync\n• Bidirectional sync can cause data conflicts if not properly configured\n• Monitor sync logs regularly for any errors or issues",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Create Sync Job",
                size: bs.md,
                onPressed: _createSyncJob,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Data Sync",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Sync Jobs", icon: Icon(Icons.sync)),
        Tab(text: "Logs", icon: Icon(Icons.history)),
        Tab(text: "Create", icon: Icon(Icons.add)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildSyncJobsTab(),
        _buildLogsTab(),
        _buildCreateTab(),
      ],
      onInit: (tabController) {},
    );
  }
}
