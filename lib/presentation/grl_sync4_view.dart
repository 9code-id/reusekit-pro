import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSync4View extends StatefulWidget {
  @override
  State<GrlSync4View> createState() => _GrlSync4ViewState();
}

class _GrlSync4ViewState extends State<GrlSync4View> {
  bool isLoading = false;
  String lastSyncTime = "2 hours ago";
  int totalRecords = 15847;
  int syncedRecords = 15420;
  int failedRecords = 427;
  double syncProgress = 0.85;
  
  List<Map<String, dynamic>> syncHistory = [
    {
      "id": 1,
      "date": "2024-06-22 14:30:00",
      "status": "success",
      "records": 1250,
      "duration": "2m 15s",
      "type": "Auto Sync"
    },
    {
      "id": 2,
      "date": "2024-06-22 12:15:00",
      "status": "partial",
      "records": 980,
      "duration": "1m 45s",
      "type": "Manual Sync"
    },
    {
      "id": 3,
      "date": "2024-06-22 10:00:00",
      "status": "failed",
      "records": 0,
      "duration": "0m 30s",
      "type": "Auto Sync"
    },
    {
      "id": 4,
      "date": "2024-06-22 08:30:00",
      "status": "success",
      "records": 2150,
      "duration": "3m 20s",
      "type": "Manual Sync"
    },
    {
      "id": 5,
      "date": "2024-06-21 22:00:00",
      "status": "success",
      "records": 1890,
      "duration": "2m 50s",
      "type": "Auto Sync"
    }
  ];

  Future<void> _startSync() async {
    isLoading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 3));
    
    syncProgress = 1.0;
    syncedRecords = totalRecords;
    failedRecords = 0;
    lastSyncTime = "Just now";
    isLoading = false;
    setState(() {});
    
    ss("Sync completed successfully");
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'success':
        return successColor;
      case 'partial':
        return warningColor;
      case 'failed':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'success':
        return 'Completed';
      case 'partial':
        return 'Partial';
      case 'failed':
        return 'Failed';
      default:
        return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Synchronization"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: isLoading ? null : _startSync,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Sync Status Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.sync,
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
                              "Sync Status",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Last sync: $lastSyncTime",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isLoading)
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Progress",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${(syncProgress * 100).toInt()}%",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      LinearProgressIndicator(
                        value: syncProgress,
                        backgroundColor: disabledColor,
                        valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Synced",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${syncedRecords.toString()}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
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
                                  "Failed",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${failedRecords.toString()}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: dangerColor,
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
                                  "Total",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${totalRecords.toString()}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Sync Actions
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Sync Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: isLoading ? "Syncing..." : "Start Sync",
                          icon: Icons.sync,
                          size: bs.md,
                          onPressed: isLoading ? null : _startSync,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Settings",
                          icon: Icons.settings,
                          size: bs.md,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Sync History
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Sync History",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...syncHistory.map((sync) {
                    DateTime syncDate = DateTime.parse("${sync["date"]}");
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: _getStatusColor("${sync["status"]}").withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border(
                          left: BorderSide(
                            width: 3,
                            color: _getStatusColor("${sync["status"]}"),
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${sync["type"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      syncDate.dMMMy,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: spXxs,
                                ),
                                decoration: BoxDecoration(
                                  color: _getStatusColor("${sync["status"]}"),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  _getStatusText("${sync["status"]}"),
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.storage,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${sync["records"]} records",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Icon(
                                Icons.schedule,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${sync["duration"]}",
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
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
