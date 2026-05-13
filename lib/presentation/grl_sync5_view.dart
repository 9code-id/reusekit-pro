import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSync5View extends StatefulWidget {
  @override
  State<GrlSync5View> createState() => _GrlSync5ViewState();
}

class _GrlSync5ViewState extends State<GrlSync5View> {
  bool autoSyncEnabled = true;
  bool wifiOnlySync = false;
  bool backgroundSync = true;
  String syncFrequency = "hourly";
  String lastSyncStatus = "success";
  int conflictResolution = 0;
  
  List<Map<String, dynamic>> syncFrequencyOptions = [
    {"label": "Every 15 minutes", "value": "15min"},
    {"label": "Every 30 minutes", "value": "30min"},
    {"label": "Hourly", "value": "hourly"},
    {"label": "Every 6 hours", "value": "6hours"},
    {"label": "Daily", "value": "daily"},
  ];

  List<Map<String, dynamic>> conflictOptions = [
    {"label": "Server wins", "value": "server"},
    {"label": "Client wins", "value": "client"},
    {"label": "Ask me", "value": "ask"},
  ];

  List<Map<String, dynamic>> syncServices = [
    {
      "name": "User Data",
      "icon": Icons.person,
      "enabled": true,
      "lastSync": "2 minutes ago",
      "status": "synced",
      "records": 1250
    },
    {
      "name": "Documents",
      "icon": Icons.description,
      "enabled": true,
      "lastSync": "5 minutes ago",
      "status": "synced",
      "records": 847
    },
    {
      "name": "Media Files",
      "icon": Icons.photo_library,
      "enabled": false,
      "lastSync": "1 hour ago",
      "status": "disabled",
      "records": 0
    },
    {
      "name": "Settings",
      "icon": Icons.settings,
      "enabled": true,
      "lastSync": "10 minutes ago",
      "status": "synced",
      "records": 156
    },
    {
      "name": "Contacts",
      "icon": Icons.contacts,
      "enabled": true,
      "lastSync": "3 minutes ago",
      "status": "synced",
      "records": 342
    },
    {
      "name": "Calendar",
      "icon": Icons.calendar_today,
      "enabled": true,
      "lastSync": "Failed",
      "status": "error",
      "records": 0
    }
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case 'synced':
        return successColor;
      case 'syncing':
        return infoColor;
      case 'error':
        return dangerColor;
      case 'disabled':
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  Icon _getStatusIcon(String status) {
    switch (status) {
      case 'synced':
        return Icon(Icons.check_circle, color: successColor, size: 16);
      case 'syncing':
        return Icon(Icons.sync, color: infoColor, size: 16);
      case 'error':
        return Icon(Icons.error, color: dangerColor, size: 16);
      case 'disabled':
        return Icon(Icons.pause_circle, color: disabledBoldColor, size: 16);
      default:
        return Icon(Icons.help, color: disabledBoldColor, size: 16);
    }
  }

  void _toggleService(int index) {
    syncServices[index]["enabled"] = !syncServices[index]["enabled"];
    if (syncServices[index]["enabled"]) {
      syncServices[index]["status"] = "synced";
      syncServices[index]["lastSync"] = "Just now";
    } else {
      syncServices[index]["status"] = "disabled";
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sync Settings"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // General Settings
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
                    "General Settings",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Auto Sync",
                        "value": true,
                        "checked": autoSyncEnabled,
                      }
                    ],
                    value: [if (autoSyncEnabled) {"label": "Auto Sync", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      autoSyncEnabled = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "WiFi Only",
                        "value": true,
                        "checked": wifiOnlySync,
                      }
                    ],
                    value: [if (wifiOnlySync) {"label": "WiFi Only", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      wifiOnlySync = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Background Sync",
                        "value": true,
                        "checked": backgroundSync,
                      }
                    ],
                    value: [if (backgroundSync) {"label": "Background Sync", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      backgroundSync = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Sync Frequency
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
                    "Sync Frequency",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QDropdownField(
                    label: "Frequency",
                    items: syncFrequencyOptions,
                    value: syncFrequency,
                    onChanged: (value, label) {
                      syncFrequency = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Conflict Resolution
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
                    "Conflict Resolution",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "When data conflicts occur during sync:",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  ...conflictOptions.asMap().entries.map((entry) {
                    int index = entry.key;
                    Map<String, dynamic> option = entry.value;
                    return GestureDetector(
                      onTap: () {
                        conflictResolution = index;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(bottom: spXs),
                        decoration: BoxDecoration(
                          color: conflictResolution == index 
                              ? primaryColor.withAlpha(10)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: conflictResolution == index 
                                ? primaryColor
                                : disabledColor,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              conflictResolution == index 
                                  ? Icons.radio_button_checked
                                  : Icons.radio_button_unchecked,
                              color: conflictResolution == index 
                                  ? primaryColor
                                  : disabledBoldColor,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${option["label"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: conflictResolution == index 
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                                color: conflictResolution == index 
                                    ? primaryColor
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Sync Services
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
                    "Sync Services",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Choose which data to sync:",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  ...syncServices.asMap().entries.map((entry) {
                    int index = entry.key;
                    Map<String, dynamic> service = entry.value;
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: disabledColor),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              service["icon"] as IconData,
                              color: primaryColor,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${service["name"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    _getStatusIcon("${service["status"]}"),
                                  ],
                                ),
                                Text(
                                  "Last sync: ${service["lastSync"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                if ((service["records"] as int) > 0)
                                  Text(
                                    "${service["records"]} records",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Switch(
                            value: service["enabled"] as bool,
                            onChanged: (value) => _toggleService(index),
                            activeColor: primaryColor,
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Save Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Save Settings",
                icon: Icons.save,
                size: bs.md,
                onPressed: () {
                  ss("Sync settings saved successfully");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
