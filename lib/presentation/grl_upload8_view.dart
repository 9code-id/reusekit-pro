import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlUpload8View extends StatefulWidget {
  @override
  State<GrlUpload8View> createState() => _GrlUpload8ViewState();
}

class _GrlUpload8ViewState extends State<GrlUpload8View> {
  String uploadSpeed = "unlimited";
  String downloadSpeed = "unlimited";
  int maxConcurrent = 3;
  bool pauseOnBattery = false;
  bool pauseOnMetered = true;
  bool enableSchedule = false;
  String scheduleStart = "09:00";
  String scheduleEnd = "17:00";
  String retryCount = "3";
  String retryDelay = "5";

  List<Map<String, dynamic>> speedLimitItems = [
    {"label": "Unlimited", "value": "unlimited"},
    {"label": "100 KB/s", "value": "100"},
    {"label": "500 KB/s", "value": "500"},
    {"label": "1 MB/s", "value": "1000"},
    {"label": "5 MB/s", "value": "5000"},
    {"label": "10 MB/s", "value": "10000"},
  ];

  List<Map<String, dynamic>> retryCountItems = [
    {"label": "No Retry", "value": "0"},
    {"label": "1 Time", "value": "1"},
    {"label": "3 Times", "value": "3"},
    {"label": "5 Times", "value": "5"},
    {"label": "Unlimited", "value": "unlimited"},
  ];

  List<Map<String, dynamic>> retryDelayItems = [
    {"label": "1 Second", "value": "1"},
    {"label": "5 Seconds", "value": "5"},
    {"label": "10 Seconds", "value": "10"},
    {"label": "30 Seconds", "value": "30"},
    {"label": "1 Minute", "value": "60"},
  ];

  List<Map<String, dynamic>> performanceStats = [
    {
      "label": "CPU Usage",
      "value": "12%",
      "color": successColor,
      "icon": Icons.memory,
    },
    {
      "label": "Memory Usage",
      "value": "145 MB",
      "color": primaryColor,
      "icon": Icons.storage,
    },
    {
      "label": "Network Usage",
      "value": "2.4 MB/s",
      "color": warningColor,
      "icon": Icons.network_check,
    },
    {
      "label": "Disk I/O",
      "value": "850 KB/s",
      "color": infoColor,
      "icon": Icons.disc_full,
    },
  ];

  List<Map<String, dynamic>> activeTransfers = [
    {
      "name": "large_video.mp4",
      "size": "1.2 GB",
      "progress": 0.65,
      "speed": "2.4 MB/s",
      "eta": "3m 45s",
      "priority": "High"
    },
    {
      "name": "document_set.zip",
      "size": "450 MB",
      "progress": 0.30,
      "speed": "1.1 MB/s",
      "eta": "5m 12s",
      "priority": "Normal"
    },
    {
      "name": "backup_files.tar",
      "size": "2.8 GB",
      "progress": 0.15,
      "speed": "850 KB/s",
      "eta": "42m 18s",
      "priority": "Low"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Settings"),
        actions: [
          IconButton(
            icon: Icon(Icons.restore),
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
            // Performance Overview
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
                        Icons.tune,
                        color: Colors.white,
                        size: 28,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Performance Monitor",
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
                    children: performanceStats.map((stat) => Container(
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

            // Speed Limits
            Text(
              "Speed Limits",
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
                          label: "Upload Speed",
                          items: speedLimitItems,
                          value: uploadSpeed,
                          onChanged: (value, label) {
                            uploadSpeed = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: QDropdownField(
                          label: "Download Speed",
                          items: speedLimitItems,
                          value: downloadSpeed,
                          onChanged: (value, label) {
                            downloadSpeed = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),

                  QNumberField(
                    label: "Max Concurrent Transfers",
                    value: maxConcurrent.toString(),
                    onChanged: (value) {
                      maxConcurrent = int.tryParse(value) ?? 3;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Power & Network Settings
            Text(
              "Power & Network",
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
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Pause on Battery",
                              "value": true,
                              "checked": pauseOnBattery,
                            }
                          ],
                          value: [
                            if (pauseOnBattery)
                              {
                                "label": "Pause on Battery",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            pauseOnBattery = values.isNotEmpty;
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
                              "label": "Pause on Metered Connection",
                              "value": true,
                              "checked": pauseOnMetered,
                            }
                          ],
                          value: [
                            if (pauseOnMetered)
                              {
                                "label": "Pause on Metered Connection",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            pauseOnMetered = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Schedule Settings
            Text(
              "Schedule Settings",
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
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Enable Schedule",
                              "value": true,
                              "checked": enableSchedule,
                            }
                          ],
                          value: [
                            if (enableSchedule)
                              {
                                "label": "Enable Schedule",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            enableSchedule = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),

                  if (enableSchedule) ...[
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QTimePicker(
                            label: "Start Time",
                            value: TimeOfDay.fromDateTime(
                              DateTime.parse("2024-01-01 $scheduleStart:00"),
                            ),
                            onChanged: (value) {
                              if (value != null) {
                                scheduleStart = value.kkmm;
                                setState(() {});
                              }
                            },
                          ),
                        ),
                        Expanded(
                          child: QTimePicker(
                            label: "End Time",
                            value: TimeOfDay.fromDateTime(
                              DateTime.parse("2024-01-01 $scheduleEnd:00"),
                            ),
                            onChanged: (value) {
                              if (value != null) {
                                scheduleEnd = value.kkmm;
                                setState(() {});
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),

            // Retry Settings
            Text(
              "Retry Settings",
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
                          label: "Retry Count",
                          items: retryCountItems,
                          value: retryCount,
                          onChanged: (value, label) {
                            retryCount = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: QDropdownField(
                          label: "Retry Delay",
                          items: retryDelayItems,
                          value: retryDelay,
                          onChanged: (value, label) {
                            retryDelay = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Active Transfers
            Text(
              "Active Transfers",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            ...activeTransfers.map((transfer) => Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.cloud_upload,
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
                              "${transfer["name"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${transfer["size"]} • ${transfer["speed"]}",
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
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: _getPriorityColor(transfer["priority"]),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${transfer["priority"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "ETA: ${transfer["eta"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${((transfer["progress"] as double) * 100).toInt()}%",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      LinearProgressIndicator(
                        value: transfer["progress"] as double,
                        backgroundColor: disabledColor,
                        valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                      ),
                    ],
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
                    label: "Pause All",
                    color: warningColor,
                    size: bs.md,
                    onPressed: () {},
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Save Settings",
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

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Normal":
        return primaryColor;
      case "Low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }
}
