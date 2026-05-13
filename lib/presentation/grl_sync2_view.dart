import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSync2View extends StatefulWidget {
  @override
  State<GrlSync2View> createState() => _GrlSync2ViewState();
}

class _GrlSync2ViewState extends State<GrlSync2View> {
  bool loading = false;
  String selectedConflictFilter = "all";
  
  List<Map<String, dynamic>> syncConflicts = [
    {
      "id": "1",
      "fileName": "Project Report.docx",
      "filePath": "/Documents/Work/",
      "conflictType": "version",
      "deviceA": "MacBook Pro",
      "deviceB": "Windows Desktop",
      "timestampA": "2024-06-22T10:30:00Z",
      "timestampB": "2024-06-22T10:35:00Z",
      "sizeA": 2.5,
      "sizeB": 2.7,
      "priority": "high",
      "status": "pending",
      "autoResolve": false,
    },
    {
      "id": "2",
      "fileName": "vacation-photos",
      "filePath": "/Photos/2024/",
      "conflictType": "deletion",
      "deviceA": "iPhone 13",
      "deviceB": "iPad Air", 
      "timestampA": "2024-06-22T09:15:00Z",
      "timestampB": "2024-06-22T09:20:00Z",
      "sizeA": 0.0,
      "sizeB": 125.8,
      "priority": "medium",
      "status": "resolved",
      "autoResolve": true,
    },
    {
      "id": "3",
      "fileName": "settings.json",
      "filePath": "/Config/App/",
      "conflictType": "content",
      "deviceA": "Android Phone",
      "deviceB": "MacBook Pro",
      "timestampA": "2024-06-21T18:45:00Z",
      "timestampB": "2024-06-21T18:50:00Z",
      "sizeA": 1.2,
      "sizeB": 1.1,
      "priority": "low",
      "status": "pending",
      "autoResolve": false,
    },
    {
      "id": "4",
      "fileName": "Music Library",
      "filePath": "/Media/Music/",
      "conflictType": "rename",
      "deviceA": "Windows Desktop",
      "deviceB": "iPad Air",
      "timestampA": "2024-06-21T14:20:00Z",
      "timestampB": "2024-06-21T14:25:00Z",
      "sizeA": 89.3,
      "sizeB": 89.3,
      "priority": "medium",
      "status": "pending",
      "autoResolve": true,
    },
    {
      "id": "5",
      "fileName": "presentation.pdf",
      "filePath": "/Documents/Presentations/",
      "conflictType": "version",
      "deviceA": "iPhone 13",
      "deviceB": "MacBook Pro",
      "timestampA": "2024-06-20T16:30:00Z",
      "timestampB": "2024-06-20T16:45:00Z",
      "sizeA": 15.7,
      "sizeB": 16.2,
      "priority": "high",
      "status": "ignored",
      "autoResolve": false,
    },
  ];

  List<Map<String, dynamic>> resolutionRules = [
    {
      "id": "1",
      "name": "Newer File Wins",
      "description": "Automatically choose the file with the most recent timestamp",
      "enabled": true,
      "conflictTypes": ["version", "content"],
      "priority": 1,
    },
    {
      "id": "2",
      "name": "Larger File Wins",
      "description": "Choose the larger file when timestamps are close",
      "enabled": false,
      "conflictTypes": ["version"],
      "priority": 2,
    },
    {
      "id": "3",
      "name": "Keep Both Files",
      "description": "Rename conflicting files and keep both versions",
      "enabled": true,
      "conflictTypes": ["rename", "content"],
      "priority": 3,
    },
    {
      "id": "4",
      "name": "Manual Resolution",
      "description": "Always require manual intervention for conflicts",
      "enabled": false,
      "conflictTypes": ["version", "content", "deletion", "rename"],
      "priority": 4,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sync Conflicts"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: _openConflictSettings,
          ),
          IconButton(
            icon: Icon(Icons.auto_fix_high),
            onPressed: _autoResolveAll,
          ),
        ],
      ),
      body: loading
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildConflictOverview(),
                SizedBox(height: spLg),
                _buildConflictFilter(),
                SizedBox(height: spMd),
                _buildConflictsList(),
                SizedBox(height: spLg),
                _buildResolutionRules(),
                SizedBox(height: spLg),
                _buildConflictActions(),
              ],
            ),
          ),
    );
  }

  Widget _buildConflictOverview() {
    int pendingConflicts = syncConflicts.where((c) => c["status"] == "pending").length;
    int resolvedConflicts = syncConflicts.where((c) => c["status"] == "resolved").length;
    int highPriorityConflicts = syncConflicts.where((c) => c["priority"] == "high" && c["status"] == "pending").length;
    int autoResolveEnabled = resolutionRules.where((r) => r["enabled"] as bool).length;

    return Container(
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
                Icons.warning,
                color: warningColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Conflict Overview",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              if (pendingConflicts > 0)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: dangerColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "$pendingConflicts Pending",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: dangerColor,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: _buildOverviewMetric(
                  "Pending",
                  "$pendingConflicts",
                  Icons.pending,
                  dangerColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildOverviewMetric(
                  "High Priority",
                  "$highPriorityConflicts",
                  Icons.priority_high,
                  warningColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildOverviewMetric(
                  "Resolved",
                  "$resolvedConflicts",
                  Icons.check_circle,
                  successColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildOverviewMetric(
                  "Auto Rules",
                  "$autoResolveEnabled",
                  Icons.auto_fix_high,
                  infoColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewMetric(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 16,
                color: color,
              ),
              SizedBox(width: spXs),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConflictFilter() {
    List<String> filterOptions = ["all", "pending", "resolved", "ignored", "high", "medium", "low"];
    
    return Row(
      children: [
        Text(
          "Filter:",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            height: 40,
            child: QHorizontalScroll(
              children: filterOptions.map((filter) {
                bool isSelected = selectedConflictFilter == filter;
                return GestureDetector(
                  onTap: () {
                    selectedConflictFilter = filter;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    margin: EdgeInsets.only(right: spXs),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      ),
                      boxShadow: isSelected ? [shadowSm] : [],
                    ),
                    child: Text(
                      filter.toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : disabledBoldColor,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildConflictsList() {
    List<Map<String, dynamic>> filteredConflicts = _getFilteredConflicts();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Sync Conflicts (${filteredConflicts.length})",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        if (filteredConflicts.isEmpty)
          Center(
            child: Column(
              children: [
                Icon(
                  Icons.check_circle,
                  size: 64,
                  color: successColor,
                ),
                SizedBox(height: spMd),
                Text(
                  "No conflicts found",
                  style: TextStyle(
                    fontSize: 16,
                    color: successColor,
                  ),
                ),
              ],
            ),
          )
        else
          ...filteredConflicts.map((conflict) => _buildConflictItem(conflict)).toList(),
      ],
    );
  }

  Widget _buildConflictItem(Map<String, dynamic> conflict) {
    Color priorityColor = _getPriorityColor(conflict["priority"] as String);
    Color statusColor = _getStatusColor(conflict["status"] as String);
    Color conflictTypeColor = _getConflictTypeColor(conflict["conflictType"] as String);
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: priorityColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: conflictTypeColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  _getConflictTypeIcon(conflict["conflictType"] as String),
                  size: 20,
                  color: conflictTypeColor,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: conflictTypeColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${conflict["conflictType"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: conflictTypeColor,
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: priorityColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${conflict["priority"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: priorityColor,
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${conflict["status"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: statusColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${conflict["fileName"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${conflict["filePath"]}",
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
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${conflict["deviceA"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Modified: ${DateTime.parse("${conflict["timestampA"]}").dMMMy}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          if (conflict["conflictType"] != "deletion")
                            Text(
                              "Size: ${((conflict["sizeA"] as double)).toStringAsFixed(1)} MB",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      child: Text(
                        "VS",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${conflict["deviceB"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Modified: ${DateTime.parse("${conflict["timestampB"]}").dMMMy}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          if (conflict["conflictType"] != "deletion" || (conflict["sizeB"] as double) > 0)
                            Text(
                              "Size: ${((conflict["sizeB"] as double)).toStringAsFixed(1)} MB",
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
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              if (conflict["autoResolve"] as bool)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.auto_fix_high,
                        size: 12,
                        color: infoColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "AUTO RESOLVE",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                ),
              Spacer(),
              if (conflict["status"] == "pending") ...[
                GestureDetector(
                  onTap: () => _resolveConflict(conflict, "keep_a"),
                  child: Text(
                    "Keep A",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ),
                SizedBox(width: spMd),
                GestureDetector(
                  onTap: () => _resolveConflict(conflict, "keep_b"),
                  child: Text(
                    "Keep B",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ),
                SizedBox(width: spMd),
                GestureDetector(
                  onTap: () => _resolveConflict(conflict, "keep_both"),
                  child: Text(
                    "Keep Both",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: successColor,
                    ),
                  ),
                ),
              ],
              if (conflict["status"] == "resolved")
                GestureDetector(
                  onTap: () => _reopenConflict(conflict),
                  child: Text(
                    "Reopen",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: warningColor,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildResolutionRules() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Auto Resolution Rules",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: _addResolutionRule,
              child: Text(
                "Add Rule",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: spMd),
        ...resolutionRules.map((rule) => _buildResolutionRuleItem(rule)).toList(),
      ],
    );
  }

  Widget _buildResolutionRuleItem(Map<String, dynamic> rule) {
    bool isEnabled = rule["enabled"] as bool;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border.all(
          color: isEnabled ? primaryColor : disabledOutlineBorderColor,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: (isEnabled ? primaryColor : disabledBoldColor).withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              isEnabled ? Icons.auto_fix_high : Icons.auto_fix_off,
              size: 20,
              color: isEnabled ? primaryColor : disabledBoldColor,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${rule["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${rule["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "Applies to: ${(rule["conflictTypes"] as List).join(", ")}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: isEnabled,
            onChanged: (value) {
              rule["enabled"] = value;
              setState(() {});
            },
            activeColor: primaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildConflictActions() {
    int pendingCount = syncConflicts.where((c) => c["status"] == "pending").length;
    
    return Column(
      children: [
        if (pendingCount > 0)
          Container(
            width: double.infinity,
            child: QButton(
              label: "Auto Resolve All ($pendingCount)",
              size: bs.md,
              icon: Icons.auto_fix_high,
              onPressed: _autoResolveAll,
            ),
          ),
        SizedBox(height: spSm),
        Row(
          children: [
            Expanded(
              child: QButton(
                label: "Clear Resolved",
                size: bs.sm,
                onPressed: _clearResolvedConflicts,
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QButton(
                label: "Export Log",
                size: bs.sm,
                onPressed: _exportConflictLog,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "pending":
        return dangerColor;
      case "resolved":
        return successColor;
      case "ignored":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getConflictTypeColor(String type) {
    switch (type) {
      case "version":
        return warningColor;
      case "deletion":
        return dangerColor;
      case "content":
        return infoColor;
      case "rename":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getConflictTypeIcon(String type) {
    switch (type) {
      case "version":
        return Icons.history;
      case "deletion":
        return Icons.delete;
      case "content":
        return Icons.edit;
      case "rename":
        return Icons.drive_file_rename_outline;
      default:
        return Icons.warning;
    }
  }

  List<Map<String, dynamic>> _getFilteredConflicts() {
    if (selectedConflictFilter == "all") {
      return syncConflicts;
    }
    
    if (["high", "medium", "low"].contains(selectedConflictFilter)) {
      return syncConflicts.where((c) => c["priority"] == selectedConflictFilter).toList();
    }
    
    return syncConflicts.where((c) => c["status"] == selectedConflictFilter).toList();
  }

  void _openConflictSettings() {
    si("Feature coming soon - Conflict resolution settings");
  }

  void _autoResolveAll() async {
    int pendingCount = syncConflicts.where((c) => c["status"] == "pending").length;
    if (pendingCount == 0) {
      si("No pending conflicts to resolve");
      return;
    }
    
    bool isConfirmed = await confirm("Auto resolve all $pendingCount pending conflicts?");
    if (isConfirmed) {
      showLoading();
      
      Future.delayed(Duration(seconds: 2), () {
        for (var conflict in syncConflicts) {
          if (conflict["status"] == "pending" && (conflict["autoResolve"] as bool)) {
            conflict["status"] = "resolved";
          }
        }
        hideLoading();
        setState(() {});
        ss("Auto resolved conflicts successfully");
      });
    }
  }

  void _resolveConflict(Map<String, dynamic> conflict, String resolution) {
    conflict["status"] = "resolved";
    setState(() {});
    
    String action = "";
    switch (resolution) {
      case "keep_a":
        action = "kept version from ${conflict["deviceA"]}";
        break;
      case "keep_b":
        action = "kept version from ${conflict["deviceB"]}";
        break;
      case "keep_both":
        action = "kept both versions";
        break;
    }
    
    ss("Conflict resolved: $action");
  }

  void _reopenConflict(Map<String, dynamic> conflict) {
    conflict["status"] = "pending";
    setState(() {});
    sw("Conflict reopened for manual resolution");
  }

  void _addResolutionRule() {
    si("Feature coming soon - Add custom resolution rule");
  }

  void _clearResolvedConflicts() async {
    int resolvedCount = syncConflicts.where((c) => c["status"] == "resolved").length;
    if (resolvedCount == 0) {
      si("No resolved conflicts to clear");
      return;
    }
    
    bool isConfirmed = await confirm("Clear all $resolvedCount resolved conflicts?");
    if (isConfirmed) {
      syncConflicts.removeWhere((c) => c["status"] == "resolved");
      setState(() {});
      ss("Resolved conflicts cleared");
    }
  }

  void _exportConflictLog() {
    showLoading();
    
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("Conflict log exported successfully");
    });
  }
}
