import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmOfflineAccessView extends StatefulWidget {
  const EcmOfflineAccessView({super.key});

  @override
  State<EcmOfflineAccessView> createState() => _EcmOfflineAccessViewState();
}

class _EcmOfflineAccessViewState extends State<EcmOfflineAccessView> {
  bool offlineModeEnabled = true;
  bool autoSync = true;
  bool wifiOnlySync = false;
  String syncFrequency = "15min";
  String storageUsed = "2.1 GB";
  String storageLimit = "5.0 GB";
  double storagePercentage = 0.42;
  String lastSyncTime = "2 minutes ago";
  bool syncInProgress = false;

  List<Map<String, dynamic>> offlineContent = [
    {
      "category": "Product Catalog",
      "items": 2847,
      "size": "856 MB",
      "lastUpdated": "5 minutes ago",
      "status": "synced",
      "icon": Icons.inventory,
      "color": "#4CAF50",
    },
    {
      "category": "Order History",
      "items": 156,
      "size": "12.3 MB",
      "lastUpdated": "10 minutes ago",
      "status": "synced",
      "icon": Icons.history,
      "color": "#2196F3",
    },
    {
      "category": "User Preferences",
      "items": 1,
      "size": "2.1 MB",
      "lastUpdated": "1 hour ago",
      "status": "synced",
      "icon": Icons.person,
      "color": "#FF9800",
    },
    {
      "category": "Shopping Cart",
      "items": 8,
      "size": "1.2 MB",
      "lastUpdated": "2 minutes ago",
      "status": "pending",
      "icon": Icons.shopping_cart,
      "color": "#F44336",
    },
    {
      "category": "Wishlist",
      "items": 23,
      "size": "8.7 MB",
      "lastUpdated": "15 minutes ago",
      "status": "synced",
      "icon": Icons.favorite,
      "color": "#E91E63",
    },
    {
      "category": "App Settings",
      "items": 1,
      "size": "512 KB",
      "lastUpdated": "1 day ago",
      "status": "synced",
      "icon": Icons.settings,
      "color": "#9C27B0",
    },
  ];

  List<Map<String, dynamic>> syncOptions = [
    {"label": "Every 5 minutes", "value": "5min"},
    {"label": "Every 15 minutes", "value": "15min"},
    {"label": "Every 30 minutes", "value": "30min"},
    {"label": "Every hour", "value": "1hour"},
    {"label": "Manual only", "value": "manual"},
  ];

  List<Map<String, dynamic>> recentSyncActivity = [
    {
      "action": "Product catalog updated",
      "time": "2 minutes ago",
      "status": "success",
      "details": "2,847 products synchronized",
    },
    {
      "action": "Cart data synchronized",
      "time": "15 minutes ago",
      "status": "success",
      "details": "8 items in cart updated",
    },
    {
      "action": "User preferences synced",
      "time": "1 hour ago",
      "status": "success",
      "details": "Profile and settings updated",
    },
    {
      "action": "Sync failed - No internet",
      "time": "3 hours ago",
      "status": "failed",
      "details": "Will retry when connection is restored",
    },
    {
      "action": "Order history updated",
      "time": "6 hours ago",
      "status": "success",
      "details": "156 orders synchronized",
    },
  ];

  Widget _buildStorageIndicator() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Storage Usage",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: storagePercentage > 0.8 ? dangerColor.withAlpha(20) : successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${(storagePercentage * 100).toInt()}% used",
                  style: TextStyle(
                    color: storagePercentage > 0.8 ? dangerColor : successColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                storageUsed,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "of $storageLimit",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          LinearProgressIndicator(
            value: storagePercentage,
            backgroundColor: disabledColor.withAlpha(50),
            valueColor: AlwaysStoppedAnimation<Color>(
              storagePercentage > 0.8 ? dangerColor : primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          if (storagePercentage > 0.8) ...[
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning, color: warningColor, size: 16),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "Storage is almost full. Consider clearing some offline data.",
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

  Widget _buildOfflineContentItem(Map<String, dynamic> content) {
    final statusColor = content["status"] == "synced" ? successColor :
                      content["status"] == "pending" ? warningColor : dangerColor;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: Color(int.parse("0xFF${content["color"].substring(1)}")).withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              content["icon"],
              color: Color(int.parse("0xFF${content["color"].substring(1)}")),
              size: 22,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${content["category"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${content["status"]}",
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "${content["items"]} items",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      " • ",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                      ),
                    ),
                    Text(
                      "${content["size"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "Updated ${content["lastUpdated"]}",
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledColor,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              content["status"] == "synced" ? Icons.sync : Icons.sync_problem,
              color: statusColor,
              size: 20,
            ),
            onPressed: () {
              if (content["status"] != "synced") {
                // Trigger sync for this item
                si("Syncing ${content["category"]}...");
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSyncActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recent Sync Activity",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        ...recentSyncActivity.map((activity) {
          final isSuccess = activity["status"] == "success";
          
          return Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(
                color: isSuccess ? successColor.withAlpha(50) : dangerColor.withAlpha(50),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: isSuccess ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    isSuccess ? Icons.check_circle : Icons.error,
                    color: isSuccess ? successColor : dangerColor,
                    size: 16,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${activity["action"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${activity["details"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${activity["time"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  void _performManualSync() async {
    syncInProgress = true;
    setState(() {});
    
    // Simulate sync process
    await Future.delayed(Duration(seconds: 3));
    
    lastSyncTime = "Just now";
    syncInProgress = false;
    setState(() {});
    
    ss("Sync completed successfully!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Offline Access"),
        actions: [
          if (syncInProgress) ...[
            Container(
              width: 40,
              height: 40,
              child: Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                  ),
                ),
              ),
            ),
          ] else ...[
            IconButton(
              icon: Icon(Icons.sync),
              onPressed: _performManualSync,
            ),
          ],
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              si("Advanced offline settings");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Offline Mode Toggle
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: offlineModeEnabled ? primaryColor.withAlpha(10) : warningColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: offlineModeEnabled ? primaryColor : warningColor,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    offlineModeEnabled ? Icons.cloud_done : Icons.cloud_off,
                    color: offlineModeEnabled ? primaryColor : warningColor,
                    size: 30,
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Offline Mode",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: offlineModeEnabled ? primaryColor : warningColor,
                          ),
                        ),
                        Text(
                          offlineModeEnabled 
                              ? "App works without internet connection"
                              : "Internet connection required",
                          style: TextStyle(
                            fontSize: 12,
                            color: offlineModeEnabled ? primaryColor : warningColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: offlineModeEnabled,
                    onChanged: (value) {
                      offlineModeEnabled = value;
                      setState(() {});
                      if (value) {
                        ss("Offline mode enabled");
                      } else {
                        sw("Offline mode disabled");
                      }
                    },
                    activeColor: primaryColor,
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),

            // Storage Usage
            _buildStorageIndicator(),
            SizedBox(height: spLg),

            // Sync Settings
            Text(
              "Sync Settings",
              style: TextStyle(
                fontSize: fsH5,
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
                children: [
                  Row(
                    children: [
                      Icon(Icons.access_time, color: primaryColor, size: 20),
                      SizedBox(width: spSm),
                      Text(
                        "Last sync: $lastSyncTime",
                        style: TextStyle(
                          fontSize: 14,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  QDropdownField(
                    label: "Auto Sync Frequency",
                    items: syncOptions,
                    value: syncFrequency,
                    onChanged: (value, label) {
                      if (offlineModeEnabled) {
                        syncFrequency = value;
                        setState(() {});
                      }
                    },
                  ),
                  SizedBox(height: spMd),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Auto Sync",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Automatically sync when data changes",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Switch(
                        value: autoSync,
                        onChanged: offlineModeEnabled ? (value) {
                          autoSync = value;
                          setState(() {});
                        } : null,
                        activeColor: primaryColor,
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "WiFi Only Sync",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Only sync when connected to WiFi",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Switch(
                        value: wifiOnlySync,
                        onChanged: offlineModeEnabled ? (value) {
                          wifiOnlySync = value;
                          setState(() {});
                        } : null,
                        activeColor: primaryColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),

            // Offline Content
            Text(
              "Offline Content",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Data available when offline",
              style: TextStyle(
                color: disabledBoldColor,
                fontSize: 14,
              ),
            ),
            SizedBox(height: spMd),
            ...offlineContent.map((content) => _buildOfflineContentItem(content)).toList(),
            SizedBox(height: spLg),

            // Sync Activity
            _buildSyncActivity(),
            SizedBox(height: spLg),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Manual Sync",
                    size: bs.md,
                    onPressed: offlineModeEnabled && !syncInProgress ? _performManualSync : null,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Clear Cache",
                    size: bs.md,
                    onPressed: () async {
                      bool isConfirmed = await confirm("Are you sure you want to clear all offline data?");
                      if (isConfirmed) {
                        storageUsed = "0.5 GB";
                        storagePercentage = 0.1;
                        setState(() {});
                        ss("Offline cache cleared successfully");
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
