import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlBackup10View extends StatefulWidget {
  @override
  State<GrlBackup10View> createState() => _GrlBackup10ViewState();
}

class _GrlBackup10ViewState extends State<GrlBackup10View> {
  String selectedTimeframe = "month";
  bool enableVersionHistory = true;
  int maxVersions = 10;
  
  List<Map<String, dynamic>> versionHistory = [
    {
      "id": 1,
      "fileName": "Project_Proposal.docx",
      "version": "v5.2",
      "size": "2.4 MB",
      "modifiedBy": "Sarah Johnson",
      "timestamp": DateTime.now().subtract(Duration(hours: 2)),
      "changes": "Updated budget section and timeline",
      "type": "document",
      "status": "current",
    },
    {
      "id": 2,
      "fileName": "Project_Proposal.docx",
      "version": "v5.1",
      "size": "2.3 MB",
      "modifiedBy": "Michael Chen",
      "timestamp": DateTime.now().subtract(Duration(hours: 8)),
      "changes": "Added risk assessment section",
      "type": "document",
      "status": "previous",
    },
    {
      "id": 3,
      "fileName": "Design_Mockup.psd",
      "version": "v3.4",
      "size": "45.6 MB",
      "modifiedBy": "Emily Rodriguez",
      "timestamp": DateTime.now().subtract(Duration(days: 1)),
      "changes": "Updated color scheme and typography",
      "type": "design",
      "status": "previous",
    },
    {
      "id": 4,
      "fileName": "Budget_Analysis.xlsx",
      "version": "v2.1",
      "size": "1.8 MB",
      "modifiedBy": "David Park",
      "timestamp": DateTime.now().subtract(Duration(days: 2)),
      "changes": "Added Q4 projections",
      "type": "spreadsheet",
      "status": "previous",
    },
    {
      "id": 5,
      "fileName": "Marketing_Presentation.pptx",
      "version": "v4.0",
      "size": "12.3 MB",
      "modifiedBy": "Sarah Johnson",
      "timestamp": DateTime.now().subtract(Duration(days: 3)),
      "changes": "Restructured slides and added animations",
      "type": "presentation",
      "status": "previous",
    },
  ];

  List<Map<String, dynamic>> comparisonFiles = [
    {
      "fileName": "Project_Requirements.docx",
      "currentVersion": "v3.2",
      "previousVersion": "v3.1",
      "additions": 127,
      "deletions": 45,
      "modifications": 23,
      "lastChanged": DateTime.now().subtract(Duration(hours: 4)),
    },
    {
      "fileName": "API_Documentation.md",
      "currentVersion": "v2.8",
      "previousVersion": "v2.7",
      "additions": 89,
      "deletions": 12,
      "modifications": 34,
      "lastChanged": DateTime.now().subtract(Duration(days: 1)),
    },
    {
      "fileName": "Database_Schema.sql",
      "currentVersion": "v1.9",
      "previousVersion": "v1.8",
      "additions": 56,
      "deletions": 23,
      "modifications": 8,
      "lastChanged": DateTime.now().subtract(Duration(days: 2)),
    },
  ];

  List<Map<String, dynamic>> retentionPolicies = [
    {
      "name": "Documents",
      "fileTypes": ["docx", "pdf", "txt"],
      "retentionDays": 90,
      "maxVersions": 15,
      "totalFiles": 234,
      "totalSize": "456 MB",
    },
    {
      "name": "Images",
      "fileTypes": ["jpg", "png", "gif"],
      "retentionDays": 180,
      "maxVersions": 5,
      "totalFiles": 1247,
      "totalSize": "2.4 GB",
    },
    {
      "name": "Code Files",
      "fileTypes": ["js", "py", "java"],
      "retentionDays": 365,
      "maxVersions": 25,
      "totalFiles": 89,
      "totalSize": "123 MB",
    },
    {
      "name": "Design Files",
      "fileTypes": ["psd", "ai", "sketch"],
      "retentionDays": 120,
      "maxVersions": 10,
      "totalFiles": 67,
      "totalSize": "1.8 GB",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Version History & Control"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: _showRetentionSettings,
          ),
          IconButton(
            icon: Icon(Icons.help),
            onPressed: _showVersionHelp,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Version Control Overview
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [infoColor, infoColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.history,
                        color: Colors.white,
                        size: 28,
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Version Control",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            ),
                            Text(
                              "Track every change",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: enableVersionHistory,
                        onChanged: (value) {
                          enableVersionHistory = value;
                          setState(() {});
                        },
                        activeColor: Colors.white,
                        activeTrackColor: Colors.white.withAlpha(100),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${versionHistory.length}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Total Versions",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
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
                              "${_getTotalSizeVersions()}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Storage Used",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
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
                              "$maxVersions",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Max Versions",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
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

            SizedBox(height: spMd),

            // Time Filter
            QHorizontalScroll(
              children: [
                {"label": "Today", "value": "today"},
                {"label": "Week", "value": "week"},
                {"label": "Month", "value": "month"},
                {"label": "Year", "value": "year"},
                {"label": "All Time", "value": "all"},
              ].map((timeframe) => GestureDetector(
                onTap: () {
                  selectedTimeframe = timeframe["value"]!;
                  setState(() {});
                },
                child: Container(
                  margin: EdgeInsets.only(right: spSm),
                  padding: EdgeInsets.symmetric(
                    horizontal: spMd,
                    vertical: spSm,
                  ),
                  decoration: BoxDecoration(
                    color: selectedTimeframe == timeframe["value"] ? primaryColor : Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Text(
                    timeframe["label"]!,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: selectedTimeframe == timeframe["value"] ? Colors.white : primaryColor,
                    ),
                  ),
                ),
              )).toList(),
            ),

            SizedBox(height: spMd),

            // Version History
            Text(
              "Recent Version History",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            ...versionHistory.map((version) => Container(
              margin: EdgeInsets.only(bottom: spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
                border: version["status"] == "current"
                    ? Border.all(color: primaryColor, width: 2)
                    : null,
              ),
              child: Padding(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: _getFileTypeColor(version["type"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Icon(
                            _getFileTypeIcon(version["type"]),
                            color: _getFileTypeColor(version["type"]),
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${version["fileName"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: version["status"] == "current" 
                                          ? successColor.withAlpha(20) 
                                          : primaryColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${version["version"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: version["status"] == "current" 
                                            ? successColor 
                                            : primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Modified by ${version["modifiedBy"]}",
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
                    SizedBox(height: spMd),
                    Text(
                      "${version["changes"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 16,
                          color: primaryColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${(version["timestamp"] as DateTime).dMMMy} • ${(version["timestamp"] as DateTime).dMMMykkss}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Icon(
                          Icons.storage,
                          size: 16,
                          color: primaryColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${version["size"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Spacer(),
                        if (version["status"] != "current") ...[
                          QButton(
                            label: "Restore",
                            size: bs.sm,
                            icon: Icons.restore,
                            onPressed: () => _restoreVersion(version),
                          ),
                          SizedBox(width: spSm),
                        ],
                        QButton(
                          label: "Download",
                          size: bs.sm,
                          icon: Icons.download,
                          onPressed: () => _downloadVersion(version),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )).toList(),

            SizedBox(height: spMd),

            // File Comparison
            Text(
              "File Comparisons",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            ...comparisonFiles.map((file) => Container(
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.compare_arrows,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${file["fileName"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${file["currentVersion"]} vs ${file["previousVersion"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      QButton(
                        label: "Compare",
                        size: bs.sm,
                        icon: Icons.visibility,
                        onPressed: () => _compareVersions(file),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${file["additions"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "Additions",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: successColor,
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
                                "${file["deletions"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: dangerColor,
                                ),
                              ),
                              Text(
                                "Deletions",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: dangerColor,
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
                                "${file["modifications"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                              Text(
                                "Changes",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: warningColor,
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
            )).toList(),

            SizedBox(height: spMd),

            // Retention Policies
            Text(
              "Retention Policies",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            ...retentionPolicies.map((policy) => Container(
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "${policy["name"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.edit, color: primaryColor),
                        onPressed: () => _editRetentionPolicy(policy),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Wrap(
                    spacing: spXs,
                    runSpacing: spXs,
                    children: (policy["fileTypes"] as List<String>).map((type) => Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        ".$type",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    )).toList(),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${policy["retentionDays"]} days",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Retention",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
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
                              "${policy["maxVersions"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Max Versions",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
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
                              "${policy["totalFiles"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "Files",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
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
                              "${policy["totalSize"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                            Text(
                              "Size",
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
                ],
              ),
            )).toList(),

            SizedBox(height: spMd),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Cleanup Old Versions",
                    size: bs.md,
                    icon: Icons.cleaning_services,
                    onPressed: _cleanupVersions,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Export History",
                    size: bs.md,
                    icon: Icons.download,
                    onPressed: _exportHistory,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getTotalSizeVersions() {
    // Calculate total size from version history
    double totalMB = 0;
    for (var version in versionHistory) {
      String size = version["size"];
      if (size.contains("GB")) {
        totalMB += (double.tryParse(size.replaceAll(" GB", "")) ?? 0) * 1024;
      } else if (size.contains("MB")) {
        totalMB += double.tryParse(size.replaceAll(" MB", "")) ?? 0;
      }
    }
    
    if (totalMB > 1024) {
      return "${(totalMB / 1024).toStringAsFixed(1)} GB";
    } else {
      return "${totalMB.toInt()} MB";
    }
  }

  Color _getFileTypeColor(String type) {
    switch (type) {
      case 'document':
        return primaryColor;
      case 'design':
        return warningColor;
      case 'spreadsheet':
        return successColor;
      case 'presentation':
        return infoColor;
      default:
        return primaryColor;
    }
  }

  IconData _getFileTypeIcon(String type) {
    switch (type) {
      case 'document':
        return Icons.description;
      case 'design':
        return Icons.palette;
      case 'spreadsheet':
        return Icons.table_chart;
      case 'presentation':
        return Icons.slideshow;
      default:
        return Icons.insert_drive_file;
    }
  }

  void _restoreVersion(Map<String, dynamic> version) async {
    bool isConfirmed = await confirm("Are you sure you want to restore ${version["fileName"]} to ${version["version"]}? This will create a new version.");
    if (!isConfirmed) return;
    
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    
    ss("${version["fileName"]} restored to ${version["version"]}");
  }

  void _downloadVersion(Map<String, dynamic> version) async {
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    
    ss("${version["fileName"]} ${version["version"]} downloaded successfully");
  }

  void _compareVersions(Map<String, dynamic> file) {
    si("Comparing ${file["currentVersion"]} with ${file["previousVersion"]} for ${file["fileName"]}");
  }

  void _editRetentionPolicy(Map<String, dynamic> policy) {
    si("Edit retention policy for ${policy["name"]}");
  }

  void _cleanupVersions() async {
    bool isConfirmed = await confirm("This will permanently delete old versions based on retention policies. Continue?");
    if (!isConfirmed) return;
    
    showLoading();
    await Future.delayed(Duration(seconds: 3));
    hideLoading();
    
    ss("Old versions cleaned up successfully. 45 MB freed.");
  }

  void _exportHistory() async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    
    ss("Version history exported successfully");
  }

  void _showRetentionSettings() {
    si("Configure retention settings for different file types");
  }

  void _showVersionHelp() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Version Control Help"),
        content: Text(
          "Version control automatically saves every change to your files.\n\n"
          "• Current: The latest version of your file\n"
          "• Previous: Older versions you can restore\n"
          "• Compare: See what changed between versions\n"
          "• Restore: Go back to an older version\n\n"
          "Retention policies control how long versions are kept."
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Got it"),
          ),
        ],
      ),
    );
  }
}
