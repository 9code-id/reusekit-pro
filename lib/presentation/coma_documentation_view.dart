import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaDocumentationView extends StatefulWidget {
  const ComaDocumentationView({Key? key}) : super(key: key);

  @override
  State<ComaDocumentationView> createState() => _ComaDocumentationViewState();
}

class _ComaDocumentationViewState extends State<ComaDocumentationView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedStatus = "All";
  String selectedProject = "All";

  List<Map<String, dynamic>> documentationData = [
    {
      "id": "DOC001",
      "title": "Project Safety Manual",
      "description": "Comprehensive safety guidelines and protocols for construction site operations",
      "category": "Safety",
      "type": "Manual",
      "status": "Current",
      "version": "v2.1",
      "project": "Highway Bridge",
      "author": "Safety Department",
      "created_date": "2024-01-15",
      "last_modified": "2024-06-10",
      "file_size": "15.2 MB",
      "format": "PDF",
      "downloads": 245,
      "views": 1250,
      "tags": ["safety", "protocols", "guidelines"],
      "approval_status": "Approved",
      "expiry_date": "2025-01-15",
      "access_level": "Public"
    },
    {
      "id": "DOC002", 
      "title": "Equipment Operation Guide",
      "description": "Detailed operating instructions for heavy machinery and construction equipment",
      "category": "Operations",
      "type": "Guide",
      "status": "Current",
      "version": "v1.5",
      "project": "City Mall",
      "author": "Operations Team",
      "created_date": "2024-02-20",
      "last_modified": "2024-06-08",
      "file_size": "22.8 MB",
      "format": "PDF",
      "downloads": 189,
      "views": 890,
      "tags": ["equipment", "operations", "machinery"],
      "approval_status": "Approved",
      "expiry_date": "2024-12-20",
      "access_level": "Restricted"
    },
    {
      "id": "DOC003",
      "title": "Quality Control Procedures",
      "description": "Step-by-step quality assurance and control procedures for construction processes",
      "category": "Quality",
      "type": "Procedure",
      "status": "Draft",
      "version": "v0.8",
      "project": "Residential Complex",
      "author": "QC Team",
      "created_date": "2024-06-01",
      "last_modified": "2024-06-15",
      "file_size": "8.7 MB",
      "format": "PDF",
      "downloads": 67,
      "views": 234,
      "tags": ["quality", "procedures", "control"],
      "approval_status": "Pending",
      "expiry_date": "2025-06-01",
      "access_level": "Internal"
    },
    {
      "id": "DOC004",
      "title": "Environmental Impact Report",
      "description": "Assessment of environmental impact and mitigation strategies for construction activities",
      "category": "Environmental",
      "type": "Report",
      "status": "Current",
      "version": "v1.0",
      "project": "Highway Bridge",
      "author": "Environmental Team",
      "created_date": "2024-03-10",
      "last_modified": "2024-03-10",
      "file_size": "31.5 MB",
      "format": "PDF",
      "downloads": 145,
      "views": 567,
      "tags": ["environment", "impact", "assessment"],
      "approval_status": "Approved",
      "expiry_date": "2025-03-10",
      "access_level": "Public"
    },
    {
      "id": "DOC005",
      "title": "Material Specifications",
      "description": "Detailed specifications for construction materials including standards and requirements",
      "category": "Materials",
      "type": "Specification",
      "status": "Current",
      "version": "v3.2",
      "project": "City Mall",
      "author": "Materials Engineer",
      "created_date": "2024-01-05",
      "last_modified": "2024-05-28",
      "file_size": "19.3 MB",
      "format": "PDF",
      "downloads": 312,
      "views": 1456,
      "tags": ["materials", "specifications", "standards"],
      "approval_status": "Approved",
      "expiry_date": "2025-01-05",
      "access_level": "Internal"
    },
    {
      "id": "DOC006",
      "title": "Emergency Response Plan",
      "description": "Comprehensive emergency response procedures and contact information",
      "category": "Safety",
      "type": "Plan",
      "status": "Outdated",
      "version": "v1.8",
      "project": "All Projects",
      "author": "Emergency Response Team",
      "created_date": "2023-11-15",
      "last_modified": "2024-01-20",
      "file_size": "12.4 MB",
      "format": "PDF",
      "downloads": 278,
      "views": 1034,
      "tags": ["emergency", "response", "safety"],
      "approval_status": "Needs Update",
      "expiry_date": "2024-11-15",
      "access_level": "Public"
    }
  ];

  List<Map<String, dynamic>> get filteredDocuments {
    return documentationData.where((doc) {
      bool matchesSearch = doc["title"].toLowerCase().contains(searchQuery.toLowerCase()) ||
                          doc["description"].toLowerCase().contains(searchQuery.toLowerCase()) ||
                          doc["tags"].any((tag) => tag.toLowerCase().contains(searchQuery.toLowerCase()));
      
      bool matchesCategory = selectedCategory == "All" || doc["category"] == selectedCategory;
      bool matchesStatus = selectedStatus == "All" || doc["status"] == selectedStatus;
      bool matchesProject = selectedProject == "All" || doc["project"] == selectedProject;
      
      return matchesSearch && matchesCategory && matchesStatus && matchesProject;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Current":
        return successColor;
      case "Draft":
        return warningColor;
      case "Outdated":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getApprovalColor(String status) {
    switch (status) {
      case "Approved":
        return successColor;
      case "Pending":
        return warningColor;
      case "Needs Update":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    int totalDocuments = documentationData.length;
    int currentDocuments = documentationData.where((doc) => doc["status"] == "Current").length;
    int draftDocuments = documentationData.where((doc) => doc["status"] == "Draft").length;
    int outdatedDocuments = documentationData.where((doc) => doc["status"] == "Outdated").length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Documentation Management"),
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
                _buildStatCard("Total Documents", totalDocuments.toString(), Icons.description, primaryColor),
                _buildStatCard("Current", currentDocuments.toString(), Icons.check_circle, successColor),
                _buildStatCard("Draft", draftDocuments.toString(), Icons.edit, warningColor),
                _buildStatCard("Outdated", outdatedDocuments.toString(), Icons.warning, dangerColor),
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
                    label: "Search Documents",
                    value: searchQuery,
                    hint: "Search by title, description, or tags...",
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
                          label: "Category",
                          items: [
                            {"label": "All Categories", "value": "All"},
                            {"label": "Safety", "value": "Safety"},
                            {"label": "Operations", "value": "Operations"},
                            {"label": "Quality", "value": "Quality"},
                            {"label": "Environmental", "value": "Environmental"},
                            {"label": "Materials", "value": "Materials"},
                          ],
                          value: selectedCategory,
                          onChanged: (value, label) {
                            selectedCategory = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: QDropdownField(
                          label: "Status",
                          items: [
                            {"label": "All Status", "value": "All"},
                            {"label": "Current", "value": "Current"},
                            {"label": "Draft", "value": "Draft"},
                            {"label": "Outdated", "value": "Outdated"},
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
                    ],
                  ),
                ],
              ),
            ),

            // Documents List
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: filteredDocuments.map((doc) {
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
                                  "${doc["title"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${doc["id"]} - ${doc["type"]}",
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
                              color: _getStatusColor(doc["status"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${doc["status"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: _getStatusColor(doc["status"]),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Description
                      Text(
                        "${doc["description"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      // Document Details
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
                                  "Version:",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${doc["version"]}",
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
                                  "${doc["file_size"]}",
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
                                  "Downloads:",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${doc["downloads"]}",
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

                      // Project and Author
                      Row(
                        children: [
                          Icon(Icons.business, size: 16, color: disabledBoldColor),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "${doc["project"]}",
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
                              "${doc["author"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Approval Status
                      Row(
                        children: [
                          Icon(
                            doc["approval_status"] == "Approved" ? Icons.check_circle :
                            doc["approval_status"] == "Pending" ? Icons.schedule :
                            Icons.warning,
                            size: 16,
                            color: _getApprovalColor(doc["approval_status"]),
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${doc["approval_status"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: _getApprovalColor(doc["approval_status"]),
                              fontWeight: FontWeight.w600,
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
