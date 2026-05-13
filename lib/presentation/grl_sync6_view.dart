import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSync6View extends StatefulWidget {
  @override
  State<GrlSync6View> createState() => _GrlSync6ViewState();
}

class _GrlSync6ViewState extends State<GrlSync6View> {
  bool isLoading = false;
  List<Map<String, dynamic>> conflictItems = [
    {
      "id": 1,
      "type": "Contact",
      "name": "John Smith",
      "field": "Phone Number",
      "localValue": "+1 (555) 123-4567",
      "serverValue": "+1 (555) 987-6543",
      "lastModified": "2024-06-22 14:30:00",
      "resolved": false,
      "resolution": null
    },
    {
      "id": 2,
      "type": "Document",
      "name": "Project Report.pdf",
      "field": "Content",
      "localValue": "Version 2.1 - Updated analysis",
      "serverValue": "Version 2.0 - Original draft",
      "lastModified": "2024-06-22 13:45:00",
      "resolved": false,
      "resolution": null
    },
    {
      "id": 3,
      "type": "Task",
      "name": "Complete quarterly review",
      "field": "Status",
      "localValue": "In Progress",
      "serverValue": "Completed",
      "lastModified": "2024-06-22 12:15:00",
      "resolved": true,
      "resolution": "server"
    },
    {
      "id": 4,
      "type": "Setting",
      "name": "Notification Preferences",
      "field": "Email Notifications",
      "localValue": "Enabled",
      "serverValue": "Disabled",
      "lastModified": "2024-06-22 11:20:00",
      "resolved": false,
      "resolution": null
    },
    {
      "id": 5,
      "type": "Contact",
      "name": "Sarah Johnson",
      "field": "Email Address",
      "localValue": "sarah.johnson@newcompany.com",
      "serverValue": "sarah.j@oldcompany.com",
      "lastModified": "2024-06-22 10:45:00",
      "resolved": true,
      "resolution": "local"
    }
  ];

  int _getUnresolvedCount() {
    return conflictItems.where((item) => !item["resolved"]).length;
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'contact':
        return primaryColor;
      case 'document':
        return warningColor;
      case 'task':
        return successColor;
      case 'setting':
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'contact':
        return Icons.person;
      case 'document':
        return Icons.description;
      case 'task':
        return Icons.task;
      case 'setting':
        return Icons.settings;
      default:
        return Icons.help;
    }
  }

  void _resolveConflict(int index, String resolution) {
    conflictItems[index]["resolved"] = true;
    conflictItems[index]["resolution"] = resolution;
    setState(() {});
    
    String action = resolution == "local" ? "kept local version" : "used server version";
    ss("Conflict resolved - $action");
  }

  void _resolveAllConflicts(String resolution) async {
    bool isConfirmed = await confirm("Resolve all conflicts with ${resolution == 'local' ? 'local' : 'server'} version?");
    if (!isConfirmed) return;

    for (int i = 0; i < conflictItems.length; i++) {
      if (!conflictItems[i]["resolved"]) {
        conflictItems[i]["resolved"] = true;
        conflictItems[i]["resolution"] = resolution;
      }
    }
    setState(() {});
    
    ss("All conflicts resolved");
  }

  @override
  Widget build(BuildContext context) {
    int unresolvedCount = _getUnresolvedCount();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Sync Conflicts"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              // Refresh conflicts
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
            // Conflict Summary
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: unresolvedCount > 0 ? warningColor.withAlpha(10) : successColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(
                  color: unresolvedCount > 0 ? warningColor : successColor,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: (unresolvedCount > 0 ? warningColor : successColor).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      unresolvedCount > 0 ? Icons.warning : Icons.check_circle,
                      color: unresolvedCount > 0 ? warningColor : successColor,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          unresolvedCount > 0 
                              ? "Sync Conflicts Detected"
                              : "All Conflicts Resolved",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: unresolvedCount > 0 ? warningColor : successColor,
                          ),
                        ),
                        Text(
                          unresolvedCount > 0 
                              ? "$unresolvedCount conflicts need your attention"
                              : "Data synchronization can continue",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Bulk Actions
            if (unresolvedCount > 0)
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
                      "Bulk Actions",
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
                            label: "Keep All Local",
                            icon: Icons.phone_android,
                            size: bs.sm,
                            onPressed: () => _resolveAllConflicts("local"),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Use All Server",
                            icon: Icons.cloud,
                            size: bs.sm,
                            onPressed: () => _resolveAllConflicts("server"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            // Conflicts List
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
                    "Conflict Details",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...conflictItems.asMap().entries.map((entry) {
                    int index = entry.key;
                    Map<String, dynamic> conflict = entry.value;
                    DateTime lastModified = DateTime.parse("${conflict["lastModified"]}");
                    bool isResolved = conflict["resolved"] as bool;
                    
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spSm),
                      decoration: BoxDecoration(
                        color: isResolved 
                            ? successColor.withAlpha(5)
                            : warningColor.withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: isResolved ? successColor : warningColor,
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
                                  color: _getTypeColor("${conflict["type"]}").withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Icon(
                                  _getTypeIcon("${conflict["type"]}"),
                                  color: _getTypeColor("${conflict["type"]}"),
                                  size: 16,
                                ),
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${conflict["type"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: _getTypeColor("${conflict["type"]}"),
                                ),
                              ),
                              Spacer(),
                              if (isResolved)
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: spXxs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: successColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "Resolved",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          Text(
                            "${conflict["name"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Field: ${conflict["field"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Last modified: ${lastModified.dMMMy}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          
                          // Local Version
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusXs),
                              border: Border.all(color: primaryColor.withAlpha(30)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.phone_android,
                                      size: 16,
                                      color: primaryColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "Local Version",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${conflict["localValue"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          SizedBox(height: spXs),
                          
                          // Server Version
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusXs),
                              border: Border.all(color: infoColor.withAlpha(30)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.cloud,
                                      size: 16,
                                      color: infoColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "Server Version",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: infoColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${conflict["serverValue"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          if (!isResolved) ...[
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: "Keep Local",
                                    icon: Icons.phone_android,
                                    size: bs.sm,
                                    onPressed: () => _resolveConflict(index, "local"),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: QButton(
                                    label: "Use Server",
                                    icon: Icons.cloud,
                                    size: bs.sm,
                                    onPressed: () => _resolveConflict(index, "server"),
                                  ),
                                ),
                              ],
                            ),
                          ] else ...[
                            SizedBox(height: spSm),
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    size: 16,
                                    color: successColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Resolved: Used ${conflict["resolution"] == "local" ? "local" : "server"} version",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: successColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
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
