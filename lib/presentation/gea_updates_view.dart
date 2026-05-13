import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaUpdatesView extends StatefulWidget {
  const GeaUpdatesView({super.key});

  @override
  State<GeaUpdatesView> createState() => _GeaUpdatesViewState();
}

class _GeaUpdatesViewState extends State<GeaUpdatesView> {
  String selectedFilter = "all";
  bool isRefreshing = false;

  List<Map<String, dynamic>> updateTypes = [
    {"label": "All Updates", "value": "all"},
    {"label": "App Updates", "value": "app"},
    {"label": "System Updates", "value": "system"},
    {"label": "Feature Updates", "value": "feature"},
    {"label": "Security Updates", "value": "security"},
  ];

  List<Map<String, dynamic>> updatesData = [
    {
      "id": 1,
      "title": "GeaOS v2.5.0 - Major System Update",
      "description": "This major update introduces enhanced performance optimization, improved battery life, and new AI-powered features for better user experience.",
      "type": "system",
      "version": "v2.5.0",
      "releaseDate": "2025-06-15T08:00:00Z",
      "size": "1.2 GB",
      "status": "available",
      "priority": "high",
      "features": [
        "Enhanced performance optimization",
        "Improved battery life management",
        "New AI-powered suggestions",
        "Updated security protocols",
        "Redesigned notification system"
      ],
      "changelog": [
        "Fixed memory leak issues",
        "Improved app launch speed by 30%",
        "Added dark mode support",
        "Enhanced accessibility features"
      ],
      "requiresRestart": true,
      "downloadProgress": 0
    },
    {
      "id": 2,
      "title": "GeaText Editor v1.8.4 - Feature Enhancement",
      "description": "New collaborative editing features, improved syntax highlighting, and better file management capabilities.",
      "type": "app",
      "version": "v1.8.4",
      "releaseDate": "2025-06-14T14:30:00Z",
      "size": "85 MB",
      "status": "installed",
      "priority": "medium",
      "features": [
        "Real-time collaborative editing",
        "Enhanced syntax highlighting",
        "Improved file explorer",
        "New plugin system",
        "Better search functionality"
      ],
      "changelog": [
        "Added support for 15 new programming languages",
        "Fixed text rendering issues",
        "Improved plugin compatibility",
        "Enhanced auto-completion"
      ],
      "requiresRestart": false,
      "downloadProgress": 100
    },
    {
      "id": 3,
      "title": "Security Update - Critical Patch",
      "description": "Critical security patch addressing recent vulnerabilities. Immediate installation recommended for system protection.",
      "type": "security",
      "version": "Security-2025-06",
      "releaseDate": "2025-06-13T16:45:00Z",
      "size": "45 MB",
      "status": "pending",
      "priority": "critical",
      "features": [
        "Security vulnerability fixes",
        "Enhanced encryption protocols",
        "Improved firewall rules",
        "Updated malware definitions"
      ],
      "changelog": [
        "Fixed CVE-2025-1234 vulnerability",
        "Patched authentication bypass issue",
        "Enhanced SSL/TLS security",
        "Updated certificate validation"
      ],
      "requiresRestart": true,
      "downloadProgress": 65
    },
    {
      "id": 4,
      "title": "GeaCamera v3.2.0 - New Features",
      "description": "Revolutionary AI-powered photography features, enhanced night mode, and improved video stabilization.",
      "type": "feature",
      "version": "v3.2.0",
      "releaseDate": "2025-06-12T10:15:00Z",
      "size": "120 MB",
      "status": "available",
      "priority": "medium",
      "features": [
        "AI-powered scene recognition",
        "Enhanced night mode photography",
        "Improved video stabilization",
        "New portrait mode effects",
        "Advanced editing tools"
      ],
      "changelog": [
        "Added 8K video recording",
        "Improved low-light performance",
        "New filters and effects",
        "Better HDR processing"
      ],
      "requiresRestart": false,
      "downloadProgress": 0
    },
    {
      "id": 5,
      "title": "GeaHealth v2.1.3 - Bug Fixes",
      "description": "Important bug fixes and stability improvements for health tracking and data synchronization.",
      "type": "app",
      "version": "v2.1.3",
      "releaseDate": "2025-06-11T09:20:00Z",
      "size": "32 MB",
      "status": "installed",
      "priority": "low",
      "features": [
        "Improved data synchronization",
        "Better heart rate monitoring",
        "Enhanced sleep tracking",
        "Fixed crash issues"
      ],
      "changelog": [
        "Fixed sync issues with fitness devices",
        "Improved battery usage",
        "Better notification handling",
        "Enhanced data privacy"
      ],
      "requiresRestart": false,
      "downloadProgress": 100
    },
  ];

  List<Map<String, dynamic>> get filteredUpdates {
    if (selectedFilter == "all") {
      return updatesData;
    }
    return updatesData.where((update) => update["type"] == selectedFilter).toList();
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "critical":
        return dangerColor;
      case "high":
        return warningColor;
      case "medium":
        return infoColor;
      case "low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "available":
        return Icons.download;
      case "installed":
        return Icons.check_circle;
      case "pending":
        return Icons.pending;
      default:
        return Icons.info;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "available":
        return primaryColor;
      case "installed":
        return successColor;
      case "pending":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildUpdateCard(Map<String, dynamic> update) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getPriorityColor(update["priority"]),
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  _getStatusIcon(update["status"]),
                  color: _getStatusColor(update["status"]),
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "${update["title"]}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: _getPriorityColor(update["priority"]).withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${update["priority"]}".toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: _getPriorityColor(update["priority"]),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            Text(
              "${update["description"]}",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
                height: 1.4,
              ),
            ),
            SizedBox(height: spMd),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${update["version"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Icon(
                  Icons.storage,
                  size: 16,
                  color: disabledBoldColor,
                ),
                SizedBox(width: spXs),
                Text(
                  "${update["size"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Spacer(),
                Text(
                  DateTime.parse(update["releaseDate"]).dMMMy,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
            if (update["status"] == "pending" && (update["downloadProgress"] as int) > 0) ...[
              SizedBox(height: spMd),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Downloading...",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${update["downloadProgress"]}%",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  LinearProgressIndicator(
                    value: (update["downloadProgress"] as int) / 100,
                    backgroundColor: disabledColor,
                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                  ),
                ],
              ),
            ],
            SizedBox(height: spMd),
            Row(
              children: [
                if (update["requiresRestart"]) ...[
                  Icon(
                    Icons.restart_alt,
                    size: 16,
                    color: warningColor,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Restart required",
                    style: TextStyle(
                      fontSize: 12,
                      color: warningColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                ] else 
                  Spacer(),
                if (update["status"] == "available")
                  QButton(
                    label: "Download",
                    size: bs.sm,
                    onPressed: () {
                      // Start download
                      ss("Download started");
                    },
                  )
                else if (update["status"] == "pending")
                  QButton(
                    label: "Cancel",
                    size: bs.sm,
                    onPressed: () {
                      // Cancel download
                    },
                  )
                else if (update["status"] == "installed")
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "Installed",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: successColor,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: spMd),
            ExpansionTile(
              title: Text(
                "View Details",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              tilePadding: EdgeInsets.zero,
              childrenPadding: EdgeInsets.zero,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "New Features:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    ...(update["features"] as List).map((feature) => 
                      Padding(
                        padding: EdgeInsets.only(bottom: spXs),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.check_circle,
                              size: 16,
                              color: successColor,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "$feature",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ).toList(),
                    SizedBox(height: spMd),
                    Text(
                      "Changelog:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    ...(update["changelog"] as List).map((change) => 
                      Padding(
                        padding: EdgeInsets.only(bottom: spXs),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.build,
                              size: 16,
                              color: infoColor,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "$change",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ).toList(),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpdatesSummary() {
    int availableCount = updatesData.where((u) => u["status"] == "available").length;
    int pendingCount = updatesData.where((u) => u["status"] == "pending").length;
    int criticalCount = updatesData.where((u) => u["priority"] == "critical").length;

    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Updates Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "$availableCount",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Available",
                        style: TextStyle(
                          fontSize: 12,
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
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "$pendingCount",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Pending",
                        style: TextStyle(
                          fontSize: 12,
                          color: warningColor,
                        ),
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
                    color: dangerColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "$criticalCount",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "Critical",
                        style: TextStyle(
                          fontSize: 12,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("System Updates"),
        actions: [
          GestureDetector(
            onTap: () async {
              isRefreshing = true;
              setState(() {});
              await Future.delayed(Duration(seconds: 2));
              isRefreshing = false;
              setState(() {});
              ss("Updates refreshed");
            },
            child: Container(
              margin: EdgeInsets.only(right: spMd),
              child: Icon(
                Icons.refresh,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          isRefreshing = true;
          setState(() {});
          await Future.delayed(Duration(seconds: 2));
          isRefreshing = false;
          setState(() {});
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildUpdatesSummary(),
              QCategoryPicker(
                label: "Filter Updates",
                items: updateTypes,
                value: selectedFilter,
                onChanged: (index, label, value, item) {
                  selectedFilter = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spMd),
              if (isRefreshing)
                Center(
                  child: CircularProgressIndicator(),
                )
              else if (filteredUpdates.isEmpty)
                Container(
                  padding: EdgeInsets.all(spXl),
                  child: Column(
                    children: [
                      Icon(
                        Icons.system_update,
                        size: 64,
                        color: disabledColor,
                      ),
                      SizedBox(height: spMd),
                      Text(
                        "No updates available",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.w600,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Your system is up to date",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                )
              else
                Column(
                  children: filteredUpdates.map((update) => _buildUpdateCard(update)).toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
