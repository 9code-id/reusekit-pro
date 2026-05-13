import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsOfflineModeView extends StatefulWidget {
  const BrsOfflineModeView({super.key});

  @override
  State<BrsOfflineModeView> createState() => _BrsOfflineModeViewState();
}

class _BrsOfflineModeViewState extends State<BrsOfflineModeView> {
  bool isOnline = false;
  bool autoSync = true;
  bool downloadImages = false;
  bool compressData = true;
  
  List<Map<String, dynamic>> offlineBookings = [
    {
      "id": "BK001",
      "barber": "John Smith",
      "service": "Premium Haircut",
      "date": "2024-06-12",
      "time": "10:00 AM",
      "status": "Pending Sync",
      "price": 45.0,
      "syncStatus": "waiting",
    },
    {
      "id": "BK002",
      "barber": "Mike Johnson",
      "service": "Beard Trim",
      "date": "2024-06-10",
      "time": "2:30 PM",
      "status": "Synced",
      "price": 25.0,
      "syncStatus": "synced",
    },
  ];
  
  List<Map<String, dynamic>> downloadedData = [
    {
      "type": "Barber Profiles",
      "count": 15,
      "size": "2.4 MB",
      "lastSync": "2024-06-11 09:30",
      "icon": Icons.person,
    },
    {
      "type": "Service Catalog",
      "count": 28,
      "size": "1.8 MB",
      "lastSync": "2024-06-11 09:30",
      "icon": Icons.content_cut,
    },
    {
      "type": "Previous Bookings",
      "count": 12,
      "size": "3.2 MB",
      "lastSync": "2024-06-10 15:45",
      "icon": Icons.history,
    },
    {
      "type": "Gallery Images",
      "count": 45,
      "size": "15.6 MB",
      "lastSync": "2024-06-09 14:20",
      "icon": Icons.photo_library,
    },
  ];
  
  Map<String, dynamic> syncStats = {
    "totalOfflineData": "23.0 MB",
    "lastFullSync": "2024-06-11 09:30",
    "pendingSync": 3,
    "failedSync": 1,
  };
  
  void _toggleOnlineMode() {
    setState(() {
      isOnline = !isOnline;
    });
    
    if (isOnline) {
      _syncData();
      ss("Online mode enabled. Syncing data...");
    } else {
      sw("Offline mode activated. Some features may be limited.");
    }
  }
  
  void _syncData() async {
    showLoading();
    
    await Future.delayed(Duration(seconds: 3));
    
    // Simulate sync process
    for (int i = 0; i < offlineBookings.length; i++) {
      if (offlineBookings[i]["syncStatus"] == "waiting") {
        setState(() {
          offlineBookings[i]["syncStatus"] = "synced";
          offlineBookings[i]["status"] = "Confirmed";
        });
      }
    }
    
    setState(() {
      syncStats["lastFullSync"] = "Just now";
      syncStats["pendingSync"] = 0;
    });
    
    hideLoading();
    ss("Data synchronized successfully");
  }
  
  void _downloadOfflineData() async {
    showLoading();
    
    await Future.delayed(Duration(seconds: 2));
    
    // Update download status
    for (int i = 0; i < downloadedData.length; i++) {
      setState(() {
        downloadedData[i]["lastSync"] = "Just now";
      });
    }
    
    hideLoading();
    ss("Offline data updated successfully");
  }
  
  void _clearOfflineData() async {
    bool isConfirmed = await confirm("Are you sure you want to clear all offline data? This action cannot be undone.");
    
    if (isConfirmed) {
      showLoading();
      
      await Future.delayed(Duration(seconds: 1));
      
      setState(() {
        syncStats["totalOfflineData"] = "0 MB";
        downloadedData.clear();
      });
      
      hideLoading();
      ss("Offline data cleared successfully");
    }
  }
  
  Color _getSyncStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'synced':
        return successColor;
      case 'waiting':
        return warningColor;
      case 'failed':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }
  
  IconData _getSyncStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'synced':
        return Icons.check_circle;
      case 'waiting':
        return Icons.sync;
      case 'failed':
        return Icons.error;
      default:
        return Icons.help;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Offline Mode"),
        actions: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: isOnline ? successColor : warningColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Row(
                  children: [
                    Icon(
                      isOnline ? Icons.wifi : Icons.wifi_off,
                      color: Colors.white,
                      size: 12,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      isOnline ? "Online" : "Offline",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spSm),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Connection Status Card
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: isOnline ? successColor.withAlpha(30) : warningColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: isOnline ? successColor : warningColor),
              ),
              child: Row(
                children: [
                  Icon(
                    isOnline ? Icons.wifi : Icons.wifi_off,
                    color: isOnline ? successColor : warningColor,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isOnline ? "Online Mode" : "Offline Mode",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isOnline ? successColor : warningColor,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          isOnline 
                            ? "All features available. Data will sync automatically."
                            : "Limited features. Some data may not be up to date.",
                          style: TextStyle(
                            color: isOnline ? successColor : warningColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  QButton(
                    label: isOnline ? "Go Offline" : "Go Online",
                    size: bs.sm,
                    onPressed: _toggleOnlineMode,
                  ),
                ],
              ),
            ),
            
            // Sync Statistics
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
                  Row(
                    children: [
                      Icon(Icons.analytics, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Sync Statistics",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        icon: Icons.sync,
                        size: bs.sm,
                        onPressed: isOnline ? _syncData : null,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${syncStats["totalOfflineData"]}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Total Offline Data",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${syncStats["pendingSync"]}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                              Text(
                                "Pending Sync",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: warningColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: Colors.grey.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.access_time, color: disabledBoldColor, size: 14),
                        SizedBox(width: spXs),
                        Text(
                          "Last sync: ${syncStats["lastFullSync"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // Offline Settings
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
                  Row(
                    children: [
                      Icon(Icons.settings, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Offline Settings",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Auto-sync when online",
                        "value": true,
                        "checked": autoSync,
                      }
                    ],
                    value: [
                      if (autoSync)
                        {
                          "label": "Auto-sync when online",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      setState(() {
                        autoSync = values.isNotEmpty;
                      });
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Download high-quality images",
                        "value": true,
                        "checked": downloadImages,
                      }
                    ],
                    value: [
                      if (downloadImages)
                        {
                          "label": "Download high-quality images",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      setState(() {
                        downloadImages = values.isNotEmpty;
                      });
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Compress offline data",
                        "value": true,
                        "checked": compressData,
                      }
                    ],
                    value: [
                      if (compressData)
                        {
                          "label": "Compress offline data",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      setState(() {
                        compressData = values.isNotEmpty;
                      });
                    },
                  ),
                ],
              ),
            ),
            
            // Downloaded Data
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
                  Row(
                    children: [
                      Icon(Icons.download, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Downloaded Data",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "Update All",
                        size: bs.sm,
                        onPressed: isOnline ? _downloadOfflineData : null,
                      ),
                    ],
                  ),
                  if (downloadedData.isEmpty) ...[
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.grey.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.cloud_download, color: disabledBoldColor, size: 32),
                          SizedBox(height: spXs),
                          Text(
                            "No offline data available",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Go online to download data for offline use",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ] else ...[
                    Column(
                      spacing: spXs,
                      children: downloadedData.map((data) {
                        return Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.grey.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(50),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Icon(
                                  data["icon"] as IconData,
                                  color: primaryColor,
                                  size: 20,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${data["type"]}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      "${data["count"]} items • ${data["size"]}",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: spSm),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Last sync:",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 10,
                                    ),
                                  ),
                                  Text(
                                    "${data["lastSync"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ),
            ),
            
            // Offline Bookings
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
                  Row(
                    children: [
                      Icon(Icons.bookmark, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Offline Bookings",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: spXs,
                    children: offlineBookings.map((booking) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border(
                            left: BorderSide(
                              width: 4,
                              color: _getSyncStatusColor("${booking["syncStatus"]}"),
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
                                  child: Text(
                                    "${booking["service"]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: _getSyncStatusColor("${booking["syncStatus"]}").withAlpha(50),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        _getSyncStatusIcon("${booking["syncStatus"]}"),
                                        color: _getSyncStatusColor("${booking["syncStatus"]}"),
                                        size: 10,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${booking["status"]}",
                                        style: TextStyle(
                                          color: _getSyncStatusColor("${booking["syncStatus"]}"),
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Barber: ${booking["barber"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "\$${(booking["price"] as double).currency}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.calendar_today, color: disabledBoldColor, size: 12),
                                SizedBox(width: spXs),
                                Text(
                                  "${booking["date"]} at ${booking["time"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
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
            
            // Data Management Actions
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
                  Row(
                    children: [
                      Icon(Icons.storage, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Data Management",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Download Data",
                          icon: Icons.download,
                          onPressed: isOnline ? _downloadOfflineData : null,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Clear Data",
                          icon: Icons.delete,
                          onPressed: _clearOfflineData,
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
}
