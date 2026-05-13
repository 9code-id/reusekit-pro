import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaDocumentManagementView extends StatefulWidget {
  const LcaDocumentManagementView({super.key});

  @override
  State<LcaDocumentManagementView> createState() => _LcaDocumentManagementViewState();
}

class _LcaDocumentManagementViewState extends State<LcaDocumentManagementView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String sortBy = "date";
  bool isGridView = false;

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Contracts", "value": "contracts"},
    {"label": "Legal Briefs", "value": "briefs"},
    {"label": "Evidence", "value": "evidence"},
    {"label": "Court Filings", "value": "filings"},
    {"label": "Discovery", "value": "discovery"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Date Modified", "value": "date"},
    {"label": "Name", "value": "name"},
    {"label": "Size", "value": "size"},
    {"label": "Type", "value": "type"},
  ];

  List<Map<String, dynamic>> documents = [
    {
      "id": 1,
      "name": "Contract Agreement - Smith vs Jones",
      "type": "PDF",
      "size": "2.4 MB",
      "date": "2024-01-15",
      "category": "contracts",
      "status": "Active",
      "tags": ["contract", "litigation", "civil"],
      "lastModified": "2024-01-15 14:30",
      "createdBy": "John Attorney",
      "confidential": true,
    },
    {
      "id": 2,
      "name": "Medical Records Evidence",
      "type": "PDF",
      "size": "15.8 MB",
      "date": "2024-01-14",
      "category": "evidence",
      "status": "Under Review",
      "tags": ["medical", "evidence", "personal injury"],
      "lastModified": "2024-01-14 09:15",
      "createdBy": "Sarah Paralegal",
      "confidential": true,
    },
    {
      "id": 3,
      "name": "Motion to Dismiss Filing",
      "type": "DOCX",
      "size": "856 KB",
      "date": "2024-01-13",
      "category": "filings",
      "status": "Filed",
      "tags": ["motion", "court filing", "defense"],
      "lastModified": "2024-01-13 16:45",
      "createdBy": "Michael Partner",
      "confidential": false,
    },
    {
      "id": 4,
      "name": "Discovery Request Documents",
      "type": "PDF",
      "size": "8.2 MB",
      "date": "2024-01-12",
      "category": "discovery",
      "status": "Pending Response",
      "tags": ["discovery", "interrogatories", "civil"],
      "lastModified": "2024-01-12 11:20",
      "createdBy": "Lisa Associate",
      "confidential": true,
    },
    {
      "id": 5,
      "name": "Legal Brief - Precedent Analysis",
      "type": "PDF",
      "size": "3.7 MB",
      "date": "2024-01-11",
      "category": "briefs",
      "status": "Draft",
      "tags": ["legal brief", "research", "precedent"],
      "lastModified": "2024-01-11 13:55",
      "createdBy": "David Researcher",
      "confidential": false,
    },
  ];

  List<Map<String, dynamic>> get filteredDocuments {
    var filtered = documents.where((doc) {
      bool matchesSearch = doc["name"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || doc["category"] == selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();

    filtered.sort((a, b) {
      switch (sortBy) {
        case "name":
          return a["name"].compareTo(b["name"]);
        case "size":
          return b["size"].compareTo(a["size"]);
        case "type":
          return a["type"].compareTo(b["type"]);
        case "date":
        default:
          return b["date"].compareTo(a["date"]);
      }
    });

    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "active":
        return successColor;
      case "filed":
        return infoColor;
      case "under review":
        return warningColor;
      case "pending response":
        return warningColor;
      case "draft":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getFileIcon(String type) {
    switch (type.toLowerCase()) {
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Document Management"),
        actions: [
          IconButton(
            icon: Icon(isGridView ? Icons.list : Icons.grid_view),
            onPressed: () {
              isGridView = !isGridView;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to upload document
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search and Filters
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search documents",
                    value: searchQuery,
                    hint: "Enter document name or content",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.search,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: spSm),

            // Filter Row
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Category",
                    items: categories,
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Sort By",
                    items: sortOptions,
                    value: sortBy,
                    onChanged: (value, label) {
                      sortBy = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spLg),

            // Stats Cards
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.folder, color: primaryColor, size: 20),
                            SizedBox(width: spXs),
                            Text(
                              "Total Documents",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${documents.length}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
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
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.security, color: warningColor, size: 20),
                            SizedBox(width: spXs),
                            Text(
                              "Confidential",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${documents.where((d) => d["confidential"] == true).length}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spLg),

            // Document List/Grid
            Text(
              "Documents (${filteredDocuments.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            if (isGridView)
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
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Icon(
                                _getFileIcon("${document["type"]}"),
                                color: primaryColor,
                                size: 24,
                              ),
                            ),
                            Spacer(),
                            if (document["confidential"] == true)
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: warningColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "CONFIDENTIAL",
                                  style: TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
                                    color: warningColor,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${document["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Text(
                              "${document["type"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              " • ${document["size"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: _getStatusColor("${document["status"]}").withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${document["status"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: _getStatusColor("${document["status"]}"),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: "View",
                                size: bs.sm,
                                onPressed: () {},
                              ),
                            ),
                            SizedBox(width: spXs),
                            QButton(
                              icon: Icons.more_vert,
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              )
            else
              Column(
                children: filteredDocuments.map((document) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Icon(
                                _getFileIcon("${document["type"]}"),
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
                                      Expanded(
                                        child: Text(
                                          "${document["name"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                      if (document["confidential"] == true)
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: warningColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "CONFIDENTIAL",
                                            style: TextStyle(
                                              fontSize: 8,
                                              fontWeight: FontWeight.bold,
                                              color: warningColor,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Text(
                                        "${document["type"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        " • ${document["size"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        " • ${document["lastModified"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                              decoration: BoxDecoration(
                                color: _getStatusColor("${document["status"]}").withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${document["status"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: _getStatusColor("${document["status"]}"),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Icon(Icons.person, size: 14, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "Created by ${document["createdBy"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            QButton(
                              label: "View",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                            SizedBox(width: spXs),
                            QButton(
                              icon: Icons.more_vert,
                              size: bs.sm,
                              onPressed: () {},
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
}
