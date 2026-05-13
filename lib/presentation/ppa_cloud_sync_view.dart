import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaCloudSyncView extends StatefulWidget {
  const PpaCloudSyncView({super.key});

  @override
  State<PpaCloudSyncView> createState() => _PpaCloudSyncViewState();
}

class _PpaCloudSyncViewState extends State<PpaCloudSyncView> {
  bool cloudSyncEnabled = true;
  bool autoSyncEnabled = false;
  bool wifiOnlySync = true;
  String selectedCloudProvider = "Google Drive";
  String syncQuality = "Original";
  
  List<Map<String, dynamic>> cloudProviders = [
    {"label": "Google Drive", "value": "Google Drive"},
    {"label": "Dropbox", "value": "Dropbox"},
    {"label": "OneDrive", "value": "OneDrive"},
    {"label": "iCloud", "value": "iCloud"},
    {"label": "Amazon Photos", "value": "Amazon Photos"},
  ];

  List<Map<String, dynamic>> qualityOptions = [
    {"label": "Original Quality", "value": "Original"},
    {"label": "High Quality", "value": "High"},
    {"label": "Standard Quality", "value": "Standard"},
    {"label": "Compressed", "value": "Compressed"},
  ];

  List<Map<String, dynamic>> syncActivities = [
    {
      "type": "Upload",
      "fileName": "Wedding_Album_001.jpg",
      "status": "Completed",
      "size": "4.2 MB",
      "timestamp": "2024-06-16T10:30:00",
      "provider": "Google Drive",
    },
    {
      "type": "Upload",
      "fileName": "Birthday_Party_025.jpg", 
      "status": "In Progress",
      "size": "3.8 MB",
      "timestamp": "2024-06-16T10:28:00",
      "provider": "Google Drive",
      "progress": 65,
    },
    {
      "type": "Download",
      "fileName": "Vacation_Photos_045.jpg",
      "status": "Completed",
      "size": "5.1 MB",
      "timestamp": "2024-06-16T10:25:00",
      "provider": "Google Drive",
    },
    {
      "type": "Upload",
      "fileName": "Portrait_Session_012.jpg",
      "status": "Failed",
      "size": "6.2 MB",
      "timestamp": "2024-06-16T10:20:00",
      "provider": "Google Drive",
      "error": "Network connection lost",
    },
  ];

  double storageUsed = 15.6;
  double storageTotal = 50.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cloud Sync"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              _showSyncHistory();
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _forceSyncNow();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.cloud_sync,
                    color: primaryColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Cloud Synchronization",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Keep your photos safe and accessible across all devices",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            _buildStorageOverview(),

            Text(
              "Sync Settings",
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
                spacing: spSm,
                children: [
                  QSwitch(
                    label: "Cloud Sync",
                    items: [
                      {
                        "label": "Enable cloud synchronization",
                        "value": true,
                        "checked": cloudSyncEnabled,
                      }
                    ],
                    value: [
                      if (cloudSyncEnabled)
                        {
                          "label": "Enable cloud synchronization",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      cloudSyncEnabled = values.isNotEmpty;
                      setState(() {});
                    },
                  ),

                  if (cloudSyncEnabled) ...[
                    QDropdownField(
                      label: "Cloud Provider",
                      items: cloudProviders,
                      value: selectedCloudProvider,
                      onChanged: (value, label) {
                        selectedCloudProvider = value;
                        setState(() {});
                      },
                    ),

                    QDropdownField(
                      label: "Sync Quality",
                      items: qualityOptions,
                      value: syncQuality,
                      onChanged: (value, label) {
                        syncQuality = value;
                        setState(() {});
                      },
                    ),

                    QSwitch(
                      label: "Auto Sync",
                      items: [
                        {
                          "label": "Automatically sync new photos",
                          "value": true,
                          "checked": autoSyncEnabled,
                        }
                      ],
                      value: [
                        if (autoSyncEnabled)
                          {
                            "label": "Automatically sync new photos",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        autoSyncEnabled = values.isNotEmpty;
                        setState(() {});
                      },
                    ),

                    QSwitch(
                      label: "WiFi Only",
                      items: [
                        {
                          "label": "Sync only when connected to WiFi",
                          "value": true,
                          "checked": wifiOnlySync,
                        }
                      ],
                      value: [
                        if (wifiOnlySync)
                          {
                            "label": "Sync only when connected to WiFi",
                            "value": true,
                            "checked": true
                          }
                      ],
                      onChanged: (values, ids) {
                        wifiOnlySync = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                  ],
                ],
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Sync Now",
                    size: bs.md,
                    icon: Icons.sync,
                    onPressed: cloudSyncEnabled ? () {
                      _syncNow();
                    } : null,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Connect Account",
                    size: bs.md,
                    icon: Icons.account_circle,
                    onPressed: () {
                      _connectCloudAccount();
                    },
                  ),
                ),
              ],
            ),

            Text(
              "Recent Activity",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: syncActivities.length,
              itemBuilder: (context, index) {
                final activity = syncActivities[index];
                return _buildActivityCard(activity);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStorageOverview() {
    double usedPercentage = storageUsed / storageTotal;
    
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
                Icons.storage,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Storage Usage",
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
              Expanded(
                child: LinearProgressIndicator(
                  value: usedPercentage,
                  backgroundColor: disabledColor,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    usedPercentage > 0.8 ? dangerColor : 
                    usedPercentage > 0.6 ? warningColor : successColor
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "${(usedPercentage * 100).toStringAsFixed(0)}%",
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          Row(
            children: [
              Text(
                "${storageUsed.toStringAsFixed(1)} GB used",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 14,
                ),
              ),
              Spacer(),
              Text(
                "of ${storageTotal.toStringAsFixed(0)} GB",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          
          if (usedPercentage > 0.8) ...[
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: warningColor.withAlpha(50)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning,
                    color: warningColor,
                    size: 16,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Storage almost full. Consider upgrading your plan.",
                      style: TextStyle(
                        color: warningColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildActivityCard(Map<String, dynamic> activity) {
    Color statusColor = _getActivityStatusColor(activity["status"]);
    IconData typeIcon = activity["type"] == "Upload" ? Icons.cloud_upload : Icons.cloud_download;
    
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
          Icon(
            typeIcon,
            color: statusColor,
            size: 20,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${activity["fileName"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "${activity["type"]} • ${activity["size"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                    if (activity["provider"] != null) ...[
                      Text(
                        " • ${activity["provider"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ],
                ),
                if (activity["status"] == "In Progress" && activity["progress"] != null) ...[
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                          value: (activity["progress"] as int) / 100,
                          backgroundColor: disabledColor,
                          valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "${activity["progress"]}%",
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
                if (activity["error"] != null) ...[
                  SizedBox(height: spXs),
                  Text(
                    "${activity["error"]}",
                    style: TextStyle(
                      color: dangerColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: statusColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              "${activity["status"]}",
              style: TextStyle(
                color: statusColor,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getActivityStatusColor(String status) {
    switch (status) {
      case "Completed":
        return successColor;
      case "In Progress":
        return warningColor;
      case "Failed":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _syncNow() {
    showLoading();
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("Sync completed successfully!");
    });
  }

  void _forceSyncNow() {
    si("Force sync initiated");
  }

  void _connectCloudAccount() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Connect Cloud Account"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Connect your ${selectedCloudProvider} account to enable cloud synchronization."),
              SizedBox(height: spSm),
              Text(
                "Your photos will be securely synced and backed up to your cloud storage.",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            QButton(
              label: "Connect",
              size: bs.sm,
              onPressed: () {
                Navigator.pop(context);
                ss("Cloud account connected successfully!");
              },
            ),
          ],
        );
      },
    );
  }

  void _showSyncHistory() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Sync History"),
          content: Container(
            width: double.maxFinite,
            height: 300,
            child: ListView.builder(
              itemCount: syncActivities.length,
              itemBuilder: (context, index) {
                final activity = syncActivities[index];
                return ListTile(
                  title: Text("${activity["fileName"]}"),
                  subtitle: Text("${activity["type"]} • ${activity["status"]}"),
                  trailing: Text("${activity["size"]}"),
                );
              },
            ),
          ),
          actions: [
            QButton(
              label: "Close",
              size: bs.sm,
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }
}
