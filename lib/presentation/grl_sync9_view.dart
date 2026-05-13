import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSync9View extends StatefulWidget {
  @override
  State<GrlSync9View> createState() => _GrlSync9ViewState();
}

class _GrlSync9ViewState extends State<GrlSync9View> {
  bool isConnected = true;
  double bandwidthUsage = 85.2;
  String connectionType = "WiFi";
  String serverStatus = "online";
  int latency = 45;
  double uploadSpeed = 12.5;
  double downloadSpeed = 48.3;
  
  List<Map<String, dynamic>> serverList = [
    {
      "name": "Primary Server",
      "location": "US East",
      "status": "online",
      "latency": 45,
      "load": 65,
      "isSelected": true
    },
    {
      "name": "Secondary Server",
      "location": "US West",
      "status": "online",
      "latency": 78,
      "load": 32,
      "isSelected": false
    },
    {
      "name": "Europe Server",
      "location": "EU Central",
      "status": "online",
      "latency": 125,
      "load": 88,
      "isSelected": false
    },
    {
      "name": "Asia Server",
      "location": "Asia Pacific",
      "status": "maintenance",
      "latency": 0,
      "load": 0,
      "isSelected": false
    },
    {
      "name": "Backup Server",
      "location": "Global CDN",
      "status": "online",
      "latency": 92,
      "load": 15,
      "isSelected": false
    }
  ];

  List<Map<String, dynamic>> networkActivity = [
    {
      "time": "14:30",
      "action": "Data Sync",
      "direction": "upload",
      "size": "2.5 MB",
      "status": "completed",
      "duration": "3.2s"
    },
    {
      "time": "14:28",
      "action": "File Download",
      "direction": "download", 
      "size": "15.8 MB",
      "status": "completed",
      "duration": "8.5s"
    },
    {
      "time": "14:25",
      "action": "Backup Upload",
      "direction": "upload",
      "size": "125 MB",
      "status": "completed",
      "duration": "2m 15s"
    },
    {
      "time": "14:20",
      "action": "Settings Sync",
      "direction": "upload",
      "size": "1.2 MB",
      "status": "failed",
      "duration": "timeout"
    },
    {
      "time": "14:15",
      "action": "Photo Backup",
      "direction": "upload",
      "size": "45.6 MB",
      "status": "completed",
      "duration": "1m 30s"
    }
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case 'online':
        return successColor;
      case 'maintenance':
        return warningColor;
      case 'offline':
        return dangerColor;
      case 'completed':
        return successColor;
      case 'failed':
        return dangerColor;
      case 'uploading':
      case 'downloading':
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getLoadColor(int load) {
    if (load < 50) return successColor;
    if (load < 80) return warningColor;
    return dangerColor;
  }

  void _selectServer(int index) {
    for (int i = 0; i < serverList.length; i++) {
      serverList[i]["isSelected"] = i == index;
    }
    setState(() {});
    ss("Server switched successfully");
  }

  void _testConnection() {
    // Simulate connection test
    ss("Connection test completed - All systems operational");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Network Status"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {});
              ss("Network status refreshed");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Connection Status
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: isConnected 
                    ? successColor.withAlpha(10)
                    : dangerColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: isConnected ? successColor : dangerColor,
                ),
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
                          color: (isConnected ? successColor : dangerColor).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          isConnected ? Icons.wifi : Icons.wifi_off,
                          color: isConnected ? successColor : dangerColor,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isConnected ? "Connected" : "Disconnected",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: isConnected ? successColor : dangerColor,
                              ),
                            ),
                            Text(
                              "Connection type: $connectionType",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
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
                          color: isConnected ? successColor : dangerColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          isConnected ? "ONLINE" : "OFFLINE",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Latency",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${latency}ms",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
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
                              "Upload",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${uploadSpeed.toStringAsFixed(1)} Mbps",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
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
                              "Download",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${downloadSpeed.toStringAsFixed(1)} Mbps",
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
            ),

            // Bandwidth Usage
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
                    "Bandwidth Usage",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Current Usage",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${bandwidthUsage.toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  LinearProgressIndicator(
                    value: bandwidthUsage / 100,
                    backgroundColor: disabledColor,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      bandwidthUsage > 90 ? dangerColor :
                      bandwidthUsage > 70 ? warningColor : primaryColor
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.info,
                        size: 16,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Bandwidth resets in 2 days",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Server Selection
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
                      Text(
                        "Server Selection",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "Test Connection",
                        icon: Icons.speed,
                        size: bs.sm,
                        onPressed: _testConnection,
                      ),
                    ],
                  ),
                  ...serverList.asMap().entries.map((entry) {
                    int index = entry.key;
                    Map<String, dynamic> server = entry.value;
                    bool isSelected = server["isSelected"] as bool;
                    String status = "${server["status"]}";
                    
                    return GestureDetector(
                      onTap: status == "online" ? () => _selectServer(index) : null,
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(bottom: spXs),
                        decoration: BoxDecoration(
                          color: isSelected 
                              ? primaryColor.withAlpha(10)
                              : status == "maintenance"
                                  ? warningColor.withAlpha(5)
                                  : Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: isSelected 
                                ? primaryColor
                                : status == "maintenance"
                                    ? warningColor
                                    : disabledColor,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor(status).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Icon(
                                    Icons.dns,
                                    color: _getStatusColor(status),
                                    size: 16,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "${server["name"]}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: primaryColor,
                                            ),
                                          ),
                                          if (isSelected) ...[
                                            SizedBox(width: spXs),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: spXs,
                                                vertical: spXxs,
                                              ),
                                              decoration: BoxDecoration(
                                                color: primaryColor,
                                                borderRadius: BorderRadius.circular(radiusXs),
                                              ),
                                              child: Text(
                                                "ACTIVE",
                                                style: TextStyle(
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                      Text(
                                        "${server["location"]}",
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
                                    color: _getStatusColor(status),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    status.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (status == "online")
                              Row(
                                children: [
                                  Icon(
                                    Icons.speed,
                                    size: 14,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${server["latency"]}ms",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Icon(
                                    Icons.memory,
                                    size: 14,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Load: ${server["load"]}%",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: _getLoadColor(server["load"] as int),
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Network Activity
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
                    "Recent Network Activity",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...networkActivity.map((activity) {
                    String status = "${activity["status"]}";
                    String direction = "${activity["direction"]}";
                    
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: _getStatusColor(status).withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border(
                          left: BorderSide(
                            width: 3,
                            color: _getStatusColor(status),
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(status).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Icon(
                                  direction == "upload" ? Icons.upload : Icons.download,
                                  color: _getStatusColor(status),
                                  size: 16,
                                ),
                              ),
                              SizedBox(width: spXs),
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
                                    Text(
                                      "${activity["time"]} • ${activity["size"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: spXxs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor(status),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      status.toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${activity["duration"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
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
