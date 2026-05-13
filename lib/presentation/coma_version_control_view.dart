import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaVersionControlView extends StatefulWidget {
  const ComaVersionControlView({Key? key}) : super(key: key);

  @override
  State<ComaVersionControlView> createState() => _ComaVersionControlViewState();
}

class _ComaVersionControlViewState extends State<ComaVersionControlView> {
  String searchQuery = "";
  String selectedProject = "All";
  String selectedBranch = "All";
  String selectedType = "All";

  List<Map<String, dynamic>> versionsData = [
    {
      "id": "V001",
      "document_name": "Foundation Blueprint",
      "version": "v3.2",
      "branch": "main",
      "project": "Highway Bridge",
      "type": "Blueprint",
      "commit_hash": "a1b2c3d4",
      "author": "John Smith",
      "commit_message": "Updated foundation depth specifications based on soil analysis",
      "commit_date": "2024-06-15",
      "commit_time": "14:30",
      "file_size": "28.4 MB",
      "changes": "+127 -45",
      "status": "Current",
      "merge_status": "Merged",
      "conflicts": 0,
      "approvals": 3,
      "required_approvals": 2,
      "tags": ["foundation", "structural", "approved"],
      "parent_version": "v3.1",
      "child_versions": [],
      "diff_added": 127,
      "diff_removed": 45,
      "files_changed": 5,
      "reviewers": ["Chief Engineer", "Site Manager", "Quality Lead"],
      "is_protected": true
    },
    {
      "id": "V002",
      "document_name": "Electrical Layout",
      "version": "v2.1",
      "branch": "feature/electrical-upgrade",
      "project": "City Mall",
      "type": "Layout",
      "commit_hash": "e5f6g7h8",
      "author": "Sarah Johnson",
      "commit_message": "Added new electrical panels and updated cable routing for east wing",
      "commit_date": "2024-06-14",
      "commit_time": "11:45",
      "file_size": "15.7 MB",
      "changes": "+89 -23",
      "status": "Under Review",
      "merge_status": "Pending",
      "conflicts": 2,
      "approvals": 1,
      "required_approvals": 2,
      "tags": ["electrical", "panels", "routing"],
      "parent_version": "v2.0",
      "child_versions": [],
      "diff_added": 89,
      "diff_removed": 23,
      "files_changed": 3,
      "reviewers": ["Electrical Engineer", "Project Manager"],
      "is_protected": false
    },
    {
      "id": "V003",
      "document_name": "HVAC System Design",
      "version": "v1.8",
      "branch": "develop",
      "project": "Residential Complex",
      "type": "Design",
      "commit_hash": "i9j0k1l2",
      "author": "Mike Wilson",
      "commit_message": "Optimized ductwork layout and added energy efficiency improvements",
      "commit_date": "2024-06-13",
      "commit_time": "09:20",
      "file_size": "22.1 MB",
      "changes": "+234 -67",
      "status": "Draft",
      "merge_status": "Not Merged",
      "conflicts": 0,
      "approvals": 0,
      "required_approvals": 3,
      "tags": ["hvac", "ductwork", "efficiency"],
      "parent_version": "v1.7",
      "child_versions": ["v1.9-beta"],
      "diff_added": 234,
      "diff_removed": 67,
      "files_changed": 8,
      "reviewers": ["MEP Engineer", "Energy Consultant", "Design Lead"],
      "is_protected": false
    },
    {
      "id": "V004",
      "document_name": "Safety Protocols",
      "version": "v4.0",
      "branch": "main",
      "project": "Highway Bridge",
      "type": "Protocol",
      "commit_hash": "m3n4o5p6",
      "author": "David Brown",
      "commit_message": "Major safety protocol update with new OSHA compliance requirements",
      "commit_date": "2024-06-12",
      "commit_time": "16:10",
      "file_size": "8.3 MB",
      "changes": "+156 -89",
      "status": "Current",
      "merge_status": "Merged",
      "conflicts": 0,
      "approvals": 4,
      "required_approvals": 2,
      "tags": ["safety", "osha", "compliance", "protocols"],
      "parent_version": "v3.9",
      "child_versions": [],
      "diff_added": 156,
      "diff_removed": 89,
      "files_changed": 12,
      "reviewers": ["Safety Officer", "Legal Team", "Project Manager", "Site Supervisor"],
      "is_protected": true
    },
    {
      "id": "V005",
      "document_name": "Material Specifications",
      "version": "v2.5",
      "branch": "hotfix/material-update",
      "project": "City Mall",
      "type": "Specification",
      "commit_hash": "q7r8s9t0",
      "author": "Lisa Garcia",
      "commit_message": "Hotfix: Updated concrete grade specifications for structural elements",
      "commit_date": "2024-06-11",
      "commit_time": "13:55",
      "file_size": "12.9 MB",
      "changes": "+45 -12",
      "status": "Hotfix",
      "merge_status": "Merged",
      "conflicts": 1,
      "approvals": 2,
      "required_approvals": 1,
      "tags": ["materials", "concrete", "hotfix", "structural"],
      "parent_version": "v2.4",
      "child_versions": [],
      "diff_added": 45,
      "diff_removed": 12,
      "files_changed": 2,
      "reviewers": ["Materials Engineer", "Structural Engineer"],
      "is_protected": true
    },
    {
      "id": "V006",
      "document_name": "Quality Checklist",
      "version": "v1.3",
      "branch": "feature/quality-enhancement",
      "project": "Residential Complex",
      "type": "Checklist",
      "commit_hash": "u1v2w3x4",
      "author": "Robert Lee",
      "commit_message": "Enhanced quality control checkpoints for residential units",
      "commit_date": "2024-06-10",
      "commit_time": "10:30",
      "file_size": "5.2 MB",
      "changes": "+78 -34",
      "status": "Under Review",
      "merge_status": "Pending",
      "conflicts": 0,
      "approvals": 2,
      "required_approvals": 3,
      "tags": ["quality", "checklist", "residential", "enhancement"],
      "parent_version": "v1.2",
      "child_versions": [],
      "diff_added": 78,
      "diff_removed": 34,
      "files_changed": 4,
      "reviewers": ["Quality Manager", "Construction Manager", "Client Representative"],
      "is_protected": false
    }
  ];

  List<Map<String, dynamic>> get filteredVersions {
    return versionsData.where((version) {
      bool matchesSearch = version["document_name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
                          version["commit_message"].toLowerCase().contains(searchQuery.toLowerCase()) ||
                          version["author"].toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesProject = selectedProject == "All" || version["project"] == selectedProject;
      bool matchesBranch = selectedBranch == "All" || version["branch"] == selectedBranch;
      bool matchesType = selectedType == "All" || version["type"] == selectedType;
      
      return matchesSearch && matchesProject && matchesBranch && matchesType;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Current":
        return successColor;
      case "Under Review":
        return warningColor;
      case "Draft":
        return infoColor;
      case "Hotfix":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getMergeStatusColor(String mergeStatus) {
    switch (mergeStatus) {
      case "Merged":
        return successColor;
      case "Pending":
        return warningColor;
      case "Not Merged":
        return disabledBoldColor;
      case "Conflict":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getBranchColor(String branch) {
    switch (branch) {
      case "main":
        return primaryColor;
      case "develop":
        return infoColor;
      default:
        return warningColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    int totalVersions = versionsData.length;
    int currentVersions = versionsData.where((v) => v["status"] == "Current").length;
    int pendingReviews = versionsData.where((v) => v["status"] == "Under Review").length;
    int conflicts = versionsData.where((v) => (v["conflicts"] as int) > 0).length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Version Control"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Summary Statistics
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildStatCard("Total Versions", totalVersions.toString(), Icons.source, primaryColor),
                _buildStatCard("Current", currentVersions.toString(), Icons.check_circle, successColor),
                _buildStatCard("Under Review", pendingReviews.toString(), Icons.rate_review, warningColor),
                _buildStatCard("Conflicts", conflicts.toString(), Icons.warning, dangerColor),
              ],
            ),

            // Search and Filters
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  QTextField(
                    label: "Search Versions",
                    value: searchQuery,
                    hint: "Search by document name, commit message, or author...",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Project",
                          items: [
                            {"label": "All Projects", "value": "All"},
                            {"label": "Highway Bridge", "value": "Highway Bridge"},
                            {"label": "City Mall", "value": "City Mall"},
                            {"label": "Residential Complex", "value": "Residential Complex"},
                          ],
                          value: selectedProject,
                          onChanged: (value, label) {
                            selectedProject = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: QDropdownField(
                          label: "Branch",
                          items: [
                            {"label": "All Branches", "value": "All"},
                            {"label": "main", "value": "main"},
                            {"label": "develop", "value": "develop"},
                            {"label": "feature/*", "value": "feature"},
                            {"label": "hotfix/*", "value": "hotfix"},
                          ],
                          value: selectedBranch,
                          onChanged: (value, label) {
                            selectedBranch = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: QDropdownField(
                          label: "Type",
                          items: [
                            {"label": "All Types", "value": "All"},
                            {"label": "Blueprint", "value": "Blueprint"},
                            {"label": "Layout", "value": "Layout"},
                            {"label": "Design", "value": "Design"},
                            {"label": "Protocol", "value": "Protocol"},
                            {"label": "Specification", "value": "Specification"},
                            {"label": "Checklist", "value": "Checklist"},
                          ],
                          value: selectedType,
                          onChanged: (value, label) {
                            selectedType = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Version History List
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: filteredVersions.map((version) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: version["is_protected"] == true 
                        ? Border.all(color: primaryColor.withAlpha(50), width: 2)
                        : null,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      // Header with Version and Status
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${version["document_name"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${version["version"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    if (version["is_protected"] == true)
                                      Icon(
                                        Icons.lock,
                                        size: 12,
                                        color: warningColor,
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getStatusColor(version["status"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${version["status"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: _getStatusColor(version["status"]),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Branch and Commit Info
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getBranchColor(version["branch"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.account_tree,
                                  size: 12,
                                  color: _getBranchColor(version["branch"]),
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${version["branch"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: _getBranchColor(version["branch"]),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: spSm),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${version["commit_hash"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                                fontFamily: "monospace",
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Commit Message
                      Text(
                        "${version["commit_message"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      // Changes Summary
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          spacing: spXs,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Changes:",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "+${version["diff_added"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: successColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      " -${version["diff_removed"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: dangerColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Files:",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${version["files_changed"]} files",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Size:",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${version["file_size"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Merge Status and Conflicts
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getMergeStatusColor(version["merge_status"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  version["merge_status"] == "Merged" ? Icons.merge :
                                  version["merge_status"] == "Pending" ? Icons.schedule :
                                  Icons.block,
                                  size: 12,
                                  color: _getMergeStatusColor(version["merge_status"]),
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${version["merge_status"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: _getMergeStatusColor(version["merge_status"]),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if ((version["conflicts"] as int) > 0) ...[
                            SizedBox(width: spSm),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                              decoration: BoxDecoration(
                                color: dangerColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.warning,
                                    size: 12,
                                    color: dangerColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${version["conflicts"]} conflicts",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: dangerColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),

                      // Author and Date
                      Row(
                        children: [
                          Icon(Icons.person, size: 16, color: disabledBoldColor),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "${version["author"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "${version["commit_date"]} at ${version["commit_time"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Approval Status
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: (version["approvals"] as int) >= (version["required_approvals"] as int)
                              ? successColor.withAlpha(20)
                              : warningColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              (version["approvals"] as int) >= (version["required_approvals"] as int)
                                  ? Icons.check_circle
                                  : Icons.pending,
                              size: 16,
                              color: (version["approvals"] as int) >= (version["required_approvals"] as int)
                                  ? successColor
                                  : warningColor,
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "Approvals: ${version["approvals"]}/${version["required_approvals"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: (version["approvals"] as int) >= (version["required_approvals"] as int)
                                      ? successColor
                                      : warningColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Actions
                      Row(
                        spacing: spXs,
                        children: [
                          Expanded(
                            child: QButton(
                              label: "View Diff",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ),
                          Expanded(
                            child: QButton(
                              label: "Compare",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ),
                          Expanded(
                            child: QButton(
                              label: "Rollback",
                              size: bs.sm,
                              onPressed: () {},
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
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
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
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
