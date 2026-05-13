import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlStorage4View extends StatefulWidget {
  @override
  State<GrlStorage4View> createState() => _GrlStorage4ViewState();
}

class _GrlStorage4ViewState extends State<GrlStorage4View> {
  List<Map<String, dynamic>> storageDevices = [
    {
      "name": "SSD Samsung 970 EVO Plus",
      "type": "NVMe SSD",
      "capacity": "1TB",
      "used": 687.5,
      "total": 1000.0,
      "health": 98,
      "temperature": 45,
      "icon": Icons.storage,
      "color": primaryColor,
      "status": "Excellent"
    },
    {
      "name": "WD Black HDD",
      "type": "Hard Drive",
      "capacity": "2TB",
      "used": 1200.8,
      "total": 2000.0,
      "health": 89,
      "temperature": 38,
      "icon": Icons.storage,
      "color": warningColor,
      "status": "Good"
    },
    {
      "name": "Kingston DataTraveler",
      "type": "USB Drive",
      "capacity": "64GB",
      "used": 12.5,
      "total": 64.0,
      "health": 85,
      "temperature": 32,
      "icon": Icons.usb,
      "color": successColor,
      "status": "Good"
    },
    {
      "name": "Seagate Backup Plus",
      "type": "External HDD",
      "capacity": "4TB",
      "used": 3200.0,
      "total": 4000.0,
      "health": 92,
      "temperature": 42,
      "icon": Icons.storage,
      "color": dangerColor,
      "status": "Nearly Full"
    }
  ];

  List<Map<String, dynamic>> recentActivity = [
    {
      "action": "File Transfer",
      "file": "backup_2025.zip",
      "size": "2.4 GB",
      "device": "SSD Samsung 970 EVO Plus",
      "time": "2 minutes ago",
      "status": "Completed",
      "icon": Icons.file_download
    },
    {
      "action": "System Backup",
      "file": "system_image.img",
      "size": "15.8 GB",
      "device": "Seagate Backup Plus",
      "time": "1 hour ago",
      "status": "In Progress",
      "icon": Icons.backup
    },
    {
      "action": "File Cleanup",
      "file": "temp_files",
      "size": "890 MB",
      "device": "WD Black HDD",
      "time": "3 hours ago",
      "status": "Completed",
      "icon": Icons.cleaning_services
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Storage Monitor"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              ss("Storage data refreshed");
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStorageOverview(),
            _buildStorageDevices(),
            _buildRecentActivity(),
            _buildStorageActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildStorageOverview() {
    double totalCapacity = storageDevices.fold(0.0, (sum, device) => sum + (device["total"] as double));
    double totalUsed = storageDevices.fold(0.0, (sum, device) => sum + (device["used"] as double));
    double usagePercentage = (totalUsed / totalCapacity) * 100;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.storage,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Total Storage Usage",
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${(totalUsed / 1000).toStringAsFixed(1)} TB used",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "of ${(totalCapacity / 1000).toStringAsFixed(1)} TB total",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: usagePercentage > 80 ? dangerColor.withAlpha(20) : successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${usagePercentage.toStringAsFixed(1)}%",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: usagePercentage > 80 ? dangerColor : successColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: disabledColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: FractionallySizedBox(
              widthFactor: usagePercentage / 100,
              child: Container(
                decoration: BoxDecoration(
                  color: usagePercentage > 80 ? dangerColor : primaryColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStorageDevices() {
    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Storage Devices",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...storageDevices.map((device) => _buildDeviceCard(device)),
      ],
    );
  }

  Widget _buildDeviceCard(Map<String, dynamic> device) {
    double usagePercentage = ((device["used"] as double) / (device["total"] as double)) * 100;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: device["color"] as Color,
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                device["icon"] as IconData,
                color: device["color"] as Color,
                size: 24,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${device["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${device["type"]} • ${device["capacity"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: (device["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${device["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: device["color"] as Color,
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
                      "${(device["used"] as double).toStringAsFixed(1)} GB used",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "of ${(device["total"] as double).toStringAsFixed(0)} GB",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                spacing: spSm,
                children: [
                  Column(
                    children: [
                      Text(
                        "Health",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${device["health"]}%",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Temp",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${device["temperature"]}°C",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: disabledColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: FractionallySizedBox(
              widthFactor: usagePercentage / 100,
              child: Container(
                decoration: BoxDecoration(
                  color: device["color"] as Color,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Text(
                "${usagePercentage.toStringAsFixed(1)}% used",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  si("Opening ${device["name"]} details");
                },
                child: Text(
                  "View Details",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Recent Activity",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                si("Opening full activity log");
              },
              child: Text(
                "View All",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ),
          ],
        ),
        ...recentActivity.map((activity) => _buildActivityItem(activity)),
      ],
    );
  }

  Widget _buildActivityItem(Map<String, dynamic> activity) {
    Color statusColor = activity["status"] == "Completed" ? successColor : 
                       activity["status"] == "In Progress" ? warningColor : dangerColor;

    return Container(
      padding: EdgeInsets.all(spMd),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              activity["icon"] as IconData,
              color: primaryColor,
              size: 20,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${activity["action"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${activity["status"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "${activity["file"]} • ${activity["size"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${activity["device"]} • ${activity["time"]}",
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
    );
  }

  Widget _buildStorageActions() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Storage Actions",
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
                  label: "Cleanup",
                  icon: Icons.cleaning_services,
                  size: bs.sm,
                  onPressed: () {
                    ss("Starting storage cleanup");
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Optimize",
                  icon: Icons.tune,
                  size: bs.sm,
                  onPressed: () {
                    ss("Starting storage optimization");
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Backup",
                  icon: Icons.backup,
                  size: bs.sm,
                  onPressed: () {
                    ss("Starting backup process");
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Analyze",
                  icon: Icons.analytics,
                  size: bs.sm,
                  onPressed: () {
                    ss("Starting storage analysis");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
