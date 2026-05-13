import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaDocumentSharingView extends StatefulWidget {
  const ComaDocumentSharingView({Key? key}) : super(key: key);

  @override
  State<ComaDocumentSharingView> createState() => _ComaDocumentSharingViewState();
}

class _ComaDocumentSharingViewState extends State<ComaDocumentSharingView> {
  String searchQuery = "";
  String selectedProject = "All";
  String selectedType = "All";
  String selectedAccess = "All";

  List<Map<String, dynamic>> documentsData = [
    {
      "id": "DOC001",
      "title": "Project Specifications Manual",
      "description": "Comprehensive technical specifications and guidelines for the bridge construction project",
      "project": "Highway Bridge",
      "type": "Specification",
      "file_name": "Bridge_Specifications_v3.2.pdf",
      "file_size": "15.8 MB",
      "format": "PDF",
      "uploaded_by": "Project Manager",
      "upload_date": "2024-06-15",
      "last_modified": "2024-06-14",
      "access_level": "Team Access",
      "download_count": 47,
      "view_count": 125,
      "version": "3.2",
      "status": "Current",
      "category": "Technical",
      "tags": ["specifications", "technical", "guidelines", "bridge"],
      "shared_with": ["Engineering Team", "Contractors", "Quality Team"],
      "expiry_date": "2024-12-31",
      "password_protected": false,
      "comments": 8,
      "approval_required": true
    },
    {
      "id": "DOC002",
      "title": "Safety Protocols and Procedures",
      "description": "Complete safety guidelines, emergency procedures, and compliance requirements",
      "project": "City Mall",
      "type": "Safety",
      "file_name": "Safety_Protocols_2024.docx",
      "file_size": "8.3 MB",
      "format": "DOCX",
      "uploaded_by": "Safety Officer",
      "upload_date": "2024-06-14",
      "last_modified": "2024-06-13",
      "access_level": "Public",
      "download_count": 89,
      "view_count": 203,
      "version": "2.1",
      "status": "Current",
      "category": "Safety",
      "tags": ["safety", "protocols", "emergency", "compliance"],
      "shared_with": ["All Teams", "Contractors", "Visitors"],
      "expiry_date": "2024-12-31",
      "password_protected": false,
      "comments": 15,
      "approval_required": false
    },
    {
      "id": "DOC003",
      "title": "Quality Assurance Checklist",
      "description": "Detailed quality control checkpoints and inspection criteria for construction phases",
      "project": "Residential Complex",
      "type": "Quality",
      "file_name": "QA_Checklist_Residential.xlsx",
      "file_size": "2.1 MB",
      "format": "XLSX",
      "uploaded_by": "Quality Manager",
      "upload_date": "2024-06-13",
      "last_modified": "2024-06-12",
      "access_level": "Restricted",
      "download_count": 23,
      "view_count": 67,
      "version": "1.8",
      "status": "Under Review",
      "category": "Quality",
      "tags": ["quality", "checklist", "inspection", "phases"],
      "shared_with": ["Quality Team", "Senior Management"],
      "expiry_date": "2024-11-30",
      "password_protected": true,
      "comments": 5,
      "approval_required": true
    },
    {
      "id": "DOC004",
      "title": "Material Procurement Report",
      "description": "Monthly procurement status, supplier information, and material delivery schedules",
      "project": "Highway Bridge",
      "type": "Procurement",
      "file_name": "Material_Procurement_June_2024.pdf",
      "file_size": "12.7 MB",
      "format": "PDF",
      "uploaded_by": "Procurement Manager",
      "upload_date": "2024-06-12",
      "last_modified": "2024-06-11",
      "access_level": "Team Access",
      "download_count": 34,
      "view_count": 98,
      "version": "1.0",
      "status": "Current",
      "category": "Procurement",
      "tags": ["procurement", "materials", "suppliers", "delivery"],
      "shared_with": ["Management", "Procurement Team", "Site Engineers"],
      "expiry_date": "2024-07-31",
      "password_protected": false,
      "comments": 3,
      "approval_required": false
    },
    {
      "id": "DOC005",
      "title": "Environmental Impact Assessment",
      "description": "Environmental compliance report and mitigation measures for construction activities",
      "project": "City Mall",
      "type": "Environmental",
      "file_name": "Environmental_Impact_Assessment.pdf",
      "file_size": "28.4 MB",
      "format": "PDF",
      "uploaded_by": "Environmental Consultant",
      "upload_date": "2024-06-11",
      "last_modified": "2024-06-10",
      "access_level": "Public",
      "download_count": 156,
      "view_count": 287,
      "version": "2.0",
      "status": "Approved",
      "category": "Environmental",
      "tags": ["environmental", "impact", "compliance", "mitigation"],
      "shared_with": ["All Stakeholders", "Government Agencies", "Public"],
      "expiry_date": "2025-06-11",
      "password_protected": false,
      "comments": 22,
      "approval_required": true
    },
    {
      "id": "DOC006",
      "title": "Financial Progress Report",
      "description": "Detailed financial analysis, budget utilization, and cost projections",
      "project": "Residential Complex",
      "type": "Financial",
      "file_name": "Financial_Report_Q2_2024.xlsx",
      "file_size": "5.9 MB",
      "format": "XLSX",
      "uploaded_by": "Finance Manager",
      "upload_date": "2024-06-10",
      "last_modified": "2024-06-09",
      "access_level": "Confidential",
      "download_count": 12,
      "view_count": 28,
      "version": "1.3",
      "status": "Current",
      "category": "Financial",
      "tags": ["financial", "budget", "cost", "projections"],
      "shared_with": ["Senior Management", "Finance Team"],
      "expiry_date": "2024-09-30",
      "password_protected": true,
      "comments": 4,
      "approval_required": true
    }
  ];

  List<Map<String, dynamic>> get filteredDocuments {
    return documentsData.where((doc) {
      bool matchesSearch = doc["title"].toLowerCase().contains(searchQuery.toLowerCase()) ||
                          doc["description"].toLowerCase().contains(searchQuery.toLowerCase()) ||
                          doc["file_name"].toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesProject = selectedProject == "All" || doc["project"] == selectedProject;
      bool matchesType = selectedType == "All" || doc["type"] == selectedType;
      bool matchesAccess = selectedAccess == "All" || doc["access_level"] == selectedAccess;
      
      return matchesSearch && matchesProject && matchesType && matchesAccess;
    }).toList();
  }

  Color _getAccessColor(String access) {
    switch (access) {
      case "Public":
        return successColor;
      case "Team Access":
        return infoColor;
      case "Restricted":
        return warningColor;
      case "Confidential":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Current":
        return successColor;
      case "Under Review":
        return warningColor;
      case "Approved":
        return infoColor;
      case "Expired":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getFileIcon(String format) {
    switch (format.toLowerCase()) {
      case "pdf":
        return Icons.picture_as_pdf;
      case "docx":
      case "doc":
        return Icons.description;
      case "xlsx":
      case "xls":
        return Icons.table_chart;
      case "pptx":
      case "ppt":
        return Icons.slideshow;
      default:
        return Icons.insert_drive_file;
    }
  }

  @override
  Widget build(BuildContext context) {
    int totalDocuments = documentsData.length;
    int publicDocuments = documentsData.where((doc) => doc["access_level"] == "Public").length;
    int protectedDocuments = documentsData.where((doc) => doc["password_protected"] == true).length;
    int pendingApproval = documentsData.where((doc) => doc["approval_required"] == true && doc["status"] != "Approved").length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Document Sharing"),
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
                _buildStatCard("Total Documents", totalDocuments.toString(), Icons.folder, primaryColor),
                _buildStatCard("Public Access", publicDocuments.toString(), Icons.public, successColor),
                _buildStatCard("Protected", protectedDocuments.toString(), Icons.lock, warningColor),
                _buildStatCard("Pending Approval", pendingApproval.toString(), Icons.pending, dangerColor),
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
                    hint: "Search by title, description, or filename...",
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
                          label: "Document Type",
                          items: [
                            {"label": "All Types", "value": "All"},
                            {"label": "Specification", "value": "Specification"},
                            {"label": "Safety", "value": "Safety"},
                            {"label": "Quality", "value": "Quality"},
                            {"label": "Procurement", "value": "Procurement"},
                            {"label": "Environmental", "value": "Environmental"},
                            {"label": "Financial", "value": "Financial"},
                          ],
                          value: selectedType,
                          onChanged: (value, label) {
                            selectedType = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: QDropdownField(
                          label: "Access Level",
                          items: [
                            {"label": "All Access", "value": "All"},
                            {"label": "Public", "value": "Public"},
                            {"label": "Team Access", "value": "Team Access"},
                            {"label": "Restricted", "value": "Restricted"},
                            {"label": "Confidential", "value": "Confidential"},
                          ],
                          value: selectedAccess,
                          onChanged: (value, label) {
                            selectedAccess = value;
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
              children: filteredDocuments.map((document) {
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
                      // Header with File Icon
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              _getFileIcon(document["format"]),
                              color: primaryColor,
                              size: 24,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${document["title"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${document["file_name"]}",
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

                      // Status and Access Badges
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getStatusColor(document["status"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${document["status"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: _getStatusColor(document["status"]),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getAccessColor(document["access_level"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  document["password_protected"] == true ? Icons.lock : Icons.lock_open,
                                  size: 12,
                                  color: _getAccessColor(document["access_level"]),
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${document["access_level"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: _getAccessColor(document["access_level"]),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // Description
                      Text(
                        "${document["description"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      // File Details
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
                                  "Size:",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${document["file_size"]}",
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
                                  "${document["version"]}",
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
                                  "Upload Date:",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${document["upload_date"]}",
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

                      // Upload Information
                      Row(
                        children: [
                          Icon(Icons.person, size: 16, color: disabledBoldColor),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "Uploaded by ${document["uploaded_by"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Shared With
                      Row(
                        children: [
                          Icon(Icons.group, size: 16, color: disabledBoldColor),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "Shared with ${(document["shared_with"] as List).length} groups",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Usage Statistics
                      Row(
                        children: [
                          Icon(Icons.download, size: 16, color: successColor),
                          SizedBox(width: spXs),
                          Text(
                            "${document["download_count"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Icon(Icons.visibility, size: 16, color: infoColor),
                          SizedBox(width: spXs),
                          Text(
                            "${document["view_count"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Icon(Icons.comment, size: 16, color: warningColor),
                          SizedBox(width: spXs),
                          Text(
                            "${document["comments"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),

                      // Expiry Warning (if applicable)
                      if (document["expiry_date"] != null)
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.schedule,
                                size: 16,
                                color: warningColor,
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "Expires: ${document["expiry_date"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: warningColor,
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
                          Expanded(
                            child: QButton(
                              label: "Share",
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
