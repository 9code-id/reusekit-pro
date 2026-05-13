import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaBlueprintsView extends StatefulWidget {
  const ComaBlueprintsView({Key? key}) : super(key: key);

  @override
  State<ComaBlueprintsView> createState() => _ComaBlueprintsViewState();
}

class _ComaBlueprintsViewState extends State<ComaBlueprintsView> {
  String searchQuery = "";
  String selectedProject = "All";
  String selectedStatus = "All";
  String selectedType = "All";

  List<Map<String, dynamic>> blueprintData = [
    {
      "id": "BP001",
      "title": "Foundation Plan - Level 1",
      "description": "Detailed foundation and structural blueprint for building level 1",
      "project": "Highway Bridge",
      "type": "Foundation",
      "status": "Approved",
      "version": "v3.2",
      "scale": "1:100",
      "drawing_number": "F-001",
      "sheet_size": "A1",
      "last_revision": "2024-06-15",
      "created_by": "Structural Engineer",
      "approved_by": "Chief Engineer",
      "file_size": "28.4 MB",
      "format": "DWG",
      "category": "Structural",
      "priority": "High",
      "compliance_status": "Compliant",
      "progress": 95
    },
    {
      "id": "BP002",
      "title": "Electrical Layout - Main Building",
      "description": "Complete electrical wiring and distribution layout for main building structure",
      "project": "City Mall",
      "type": "Electrical",
      "status": "Under Review",
      "version": "v2.1",
      "scale": "1:50",
      "drawing_number": "E-102",
      "sheet_size": "A0",
      "last_revision": "2024-06-12",
      "created_by": "Electrical Engineer",
      "approved_by": "Pending",
      "file_size": "15.7 MB",
      "format": "PDF",
      "category": "MEP",
      "priority": "Medium",
      "compliance_status": "Under Review",
      "progress": 78
    },
    {
      "id": "BP003",
      "title": "HVAC System Design",
      "description": "Heating, ventilation, and air conditioning system layout and specifications",
      "project": "Residential Complex",
      "type": "HVAC",
      "status": "Draft",
      "version": "v1.0",
      "scale": "1:200",
      "drawing_number": "M-201",
      "sheet_size": "A1",
      "last_revision": "2024-06-10",
      "created_by": "MEP Engineer",
      "approved_by": "Not Assigned",
      "file_size": "22.1 MB",
      "format": "DWG",
      "category": "MEP",
      "priority": "Low",
      "compliance_status": "Pending",
      "progress": 45
    },
    {
      "id": "BP004",
      "title": "Site Plan Overview",
      "description": "Comprehensive site layout showing all buildings, roads, and utilities",
      "project": "Highway Bridge",
      "type": "Site Plan",
      "status": "Approved",
      "version": "v4.0",
      "scale": "1:500",
      "drawing_number": "SP-001",
      "sheet_size": "A0",
      "last_revision": "2024-06-08",
      "created_by": "Site Planner",
      "approved_by": "Project Manager",
      "file_size": "35.2 MB",
      "format": "PDF",
      "category": "Site",
      "priority": "High",
      "compliance_status": "Compliant",
      "progress": 100
    },
    {
      "id": "BP005",
      "title": "Plumbing Schematic",
      "description": "Water supply and drainage system layout for all floors",
      "project": "City Mall",
      "type": "Plumbing",
      "status": "Revision Required",
      "version": "v1.8",
      "scale": "1:100",
      "drawing_number": "P-301",
      "sheet_size": "A1",
      "last_revision": "2024-06-05",
      "created_by": "Plumbing Engineer",
      "approved_by": "Under Review",
      "file_size": "18.9 MB",
      "format": "DWG",
      "category": "MEP",
      "priority": "Medium",
      "compliance_status": "Non-Compliant",
      "progress": 60
    },
    {
      "id": "BP006",
      "title": "Structural Framework",
      "description": "Steel and concrete structural framework details and specifications",
      "project": "Residential Complex",
      "type": "Structural",
      "status": "In Progress",
      "version": "v2.3",
      "scale": "1:75",
      "drawing_number": "S-105",
      "sheet_size": "A1",
      "last_revision": "2024-06-14",
      "created_by": "Structural Engineer",
      "approved_by": "Pending",
      "file_size": "31.6 MB",
      "format": "DWG",
      "category": "Structural",
      "priority": "High",
      "compliance_status": "Under Review",
      "progress": 82
    }
  ];

  List<Map<String, dynamic>> get filteredBlueprints {
    return blueprintData.where((blueprint) {
      bool matchesSearch = blueprint["title"].toLowerCase().contains(searchQuery.toLowerCase()) ||
                          blueprint["description"].toLowerCase().contains(searchQuery.toLowerCase()) ||
                          blueprint["drawing_number"].toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesProject = selectedProject == "All" || blueprint["project"] == selectedProject;
      bool matchesStatus = selectedStatus == "All" || blueprint["status"] == selectedStatus;
      bool matchesType = selectedType == "All" || blueprint["type"] == selectedType;
      
      return matchesSearch && matchesProject && matchesStatus && matchesType;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Approved":
        return successColor;
      case "Under Review":
        return infoColor;
      case "Draft":
        return warningColor;
      case "Revision Required":
        return dangerColor;
      case "In Progress":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getComplianceColor(String compliance) {
    switch (compliance) {
      case "Compliant":
        return successColor;
      case "Under Review":
        return infoColor;
      case "Pending":
        return warningColor;
      case "Non-Compliant":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    int totalBlueprints = blueprintData.length;
    int approvedBlueprints = blueprintData.where((bp) => bp["status"] == "Approved").length;
    int inProgressBlueprints = blueprintData.where((bp) => bp["status"] == "In Progress" || bp["status"] == "Under Review").length;
    int draftBlueprints = blueprintData.where((bp) => bp["status"] == "Draft").length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Blueprints Management"),
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
                _buildStatCard("Total Blueprints", totalBlueprints.toString(), Icons.architecture, primaryColor),
                _buildStatCard("Approved", approvedBlueprints.toString(), Icons.check_circle, successColor),
                _buildStatCard("In Progress", inProgressBlueprints.toString(), Icons.work, infoColor),
                _buildStatCard("Draft", draftBlueprints.toString(), Icons.edit, warningColor),
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
                    label: "Search Blueprints",
                    value: searchQuery,
                    hint: "Search by title, description, or drawing number...",
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
                          label: "Status",
                          items: [
                            {"label": "All Status", "value": "All"},
                            {"label": "Approved", "value": "Approved"},
                            {"label": "Under Review", "value": "Under Review"},
                            {"label": "In Progress", "value": "In Progress"},
                            {"label": "Draft", "value": "Draft"},
                            {"label": "Revision Required", "value": "Revision Required"},
                          ],
                          value: selectedStatus,
                          onChanged: (value, label) {
                            selectedStatus = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: QDropdownField(
                          label: "Type",
                          items: [
                            {"label": "All Types", "value": "All"},
                            {"label": "Foundation", "value": "Foundation"},
                            {"label": "Electrical", "value": "Electrical"},
                            {"label": "HVAC", "value": "HVAC"},
                            {"label": "Plumbing", "value": "Plumbing"},
                            {"label": "Structural", "value": "Structural"},
                            {"label": "Site Plan", "value": "Site Plan"},
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

            // Blueprints List
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: filteredBlueprints.map((blueprint) {
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
                      // Header
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${blueprint["title"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${blueprint["drawing_number"]} - ${blueprint["type"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getStatusColor(blueprint["status"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${blueprint["status"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: _getStatusColor(blueprint["status"]),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Progress Bar
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Progress",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${blueprint["progress"]}%",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 6,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: (blueprint["progress"] as int) * 2.0,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: _getStatusColor(blueprint["status"]),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // Description
                      Text(
                        "${blueprint["description"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      // Blueprint Details
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
                                  "Scale:",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${blueprint["scale"]}",
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
                                  "Sheet Size:",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${blueprint["sheet_size"]}",
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
                                  "Version:",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${blueprint["version"]}",
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

                      // Priority and Compliance
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getPriorityColor(blueprint["priority"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.flag,
                                  size: 12,
                                  color: _getPriorityColor(blueprint["priority"]),
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${blueprint["priority"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: _getPriorityColor(blueprint["priority"]),
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
                              color: _getComplianceColor(blueprint["compliance_status"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  blueprint["compliance_status"] == "Compliant" ? Icons.verified :
                                  blueprint["compliance_status"] == "Under Review" ? Icons.schedule :
                                  blueprint["compliance_status"] == "Pending" ? Icons.pending :
                                  Icons.warning,
                                  size: 12,
                                  color: _getComplianceColor(blueprint["compliance_status"]),
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${blueprint["compliance_status"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: _getComplianceColor(blueprint["compliance_status"]),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // Project and Creator
                      Row(
                        children: [
                          Icon(Icons.business, size: 16, color: disabledBoldColor),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "${blueprint["project"]}",
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
                          Icon(Icons.person, size: 16, color: disabledBoldColor),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "${blueprint["created_by"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Actions
                      Row(
                        spacing: spXs,
                        children: [
                          Expanded(
                            child: QButton(
                              label: "View",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ),
                          Expanded(
                            child: QButton(
                              label: "Download",
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
