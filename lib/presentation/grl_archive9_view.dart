import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlArchive9View extends StatefulWidget {
  @override
  State<GrlArchive9View> createState() => _GrlArchive9ViewState();
}

class _GrlArchive9ViewState extends State<GrlArchive9View> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedStatus = "All";
  bool isSelectionMode = false;
  Set<String> selectedItems = {};

  List<Map<String, dynamic>> archivedDocuments = [
    {
      "id": "DOC-2024-001",
      "title": "Q4 Financial Report 2024",
      "category": "Financial",
      "type": "PDF",
      "size": "4.2 MB",
      "date": "2024-12-15",
      "status": "Archived",
      "author": "Sarah Johnson",
      "department": "Finance",
      "confidential": true,
      "version": "v1.0",
      "description": "Quarterly financial performance analysis with detailed revenue breakdown",
      "thumbnail": "https://picsum.photos/100/140?random=1&keyword=document",
      "tags": ["financial", "q4", "report", "2024"],
      "accessCount": 45,
      "lastAccessed": "2024-12-14",
    },
    {
      "id": "DOC-2024-002",
      "title": "Employee Handbook 2024",
      "category": "HR",
      "type": "PDF",
      "size": "8.7 MB",
      "date": "2024-11-30",
      "status": "Archived",
      "author": "Mike Wilson",
      "department": "Human Resources",
      "confidential": false,
      "version": "v2.1",
      "description": "Comprehensive employee handbook with updated policies and procedures",
      "thumbnail": "https://picsum.photos/100/140?random=2&keyword=handbook",
      "tags": ["hr", "handbook", "policies", "employees"],
      "accessCount": 128,
      "lastAccessed": "2024-12-10",
    },
    {
      "id": "DOC-2024-003",
      "title": "Technical Specifications",
      "category": "Technical",
      "type": "DOCX",
      "size": "2.1 MB",
      "date": "2024-11-15",
      "status": "Archived",
      "author": "Emma Davis",
      "department": "Engineering",
      "confidential": true,
      "version": "v3.0",
      "description": "Detailed technical specifications for new product development",
      "thumbnail": "https://picsum.photos/100/140?random=3&keyword=technical",
      "tags": ["technical", "specs", "development", "product"],
      "accessCount": 67,
      "lastAccessed": "2024-12-08",
    },
    {
      "id": "DOC-2024-004",
      "title": "Marketing Strategy Plan",
      "category": "Marketing",
      "type": "PPTX",
      "size": "15.4 MB",
      "date": "2024-10-20",
      "status": "Archived",
      "author": "Robert Lee",
      "department": "Marketing",
      "confidential": false,
      "version": "v1.5",
      "description": "Comprehensive marketing strategy for Q1 2025 campaigns",
      "thumbnail": "https://picsum.photos/100/140?random=4&keyword=marketing",
      "tags": ["marketing", "strategy", "campaign", "q1"],
      "accessCount": 89,
      "lastAccessed": "2024-12-05",
    },
    {
      "id": "DOC-2024-005",
      "title": "Legal Compliance Guide",
      "category": "Legal",
      "type": "PDF",
      "size": "6.8 MB",
      "date": "2024-09-30",
      "status": "Archived",
      "author": "Lisa Chen",
      "department": "Legal",
      "confidential": true,
      "version": "v2.0",
      "description": "Updated legal compliance guidelines and regulatory requirements",
      "thumbnail": "https://picsum.photos/100/140?random=5&keyword=legal",
      "tags": ["legal", "compliance", "regulations", "guide"],
      "accessCount": 34,
      "lastAccessed": "2024-11-28",
    },
    {
      "id": "DOC-2024-006",
      "title": "Project Alpha Documentation",
      "category": "Technical",
      "type": "ZIP",
      "size": "45.2 MB",
      "date": "2024-08-15",
      "status": "Archived",
      "author": "John Smith",
      "department": "Engineering",
      "confidential": true,
      "version": "v4.2",
      "description": "Complete project documentation package including source code and assets",
      "thumbnail": "https://picsum.photos/100/140?random=6&keyword=project",
      "tags": ["project", "alpha", "documentation", "code"],
      "accessCount": 156,
      "lastAccessed": "2024-12-12",
    },
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All", "value": "All"},
    {"label": "Financial", "value": "Financial"},
    {"label": "HR", "value": "HR"},
    {"label": "Technical", "value": "Technical"},
    {"label": "Marketing", "value": "Marketing"},
    {"label": "Legal", "value": "Legal"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Archived", "value": "Archived"},
    {"label": "Active", "value": "Active"},
    {"label": "Deleted", "value": "Deleted"},
  ];

  List<Map<String, dynamic>> get filteredDocuments {
    return archivedDocuments.where((doc) {
      bool matchesSearch = searchQuery.isEmpty ||
          doc["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          doc["author"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          doc["description"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          (doc["tags"] as List).any((tag) => tag.toString().toLowerCase().contains(searchQuery.toLowerCase()));

      bool matchesCategory = selectedCategory == "All" ||
          doc["category"] == selectedCategory;

      bool matchesStatus = selectedStatus == "All" ||
          doc["status"] == selectedStatus;

      return matchesSearch && matchesCategory && matchesStatus;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isSelectionMode 
            ? "${selectedItems.length} selected" 
            : "Document Archive"),
        actions: [
          if (isSelectionMode) ...[
            IconButton(
              icon: Icon(Icons.download),
              onPressed: selectedItems.isEmpty ? null : () {
                _bulkDownload();
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: selectedItems.isEmpty ? null : () {
                _bulkDelete();
              },
            ),
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                setState(() {
                  isSelectionMode = false;
                  selectedItems.clear();
                });
              },
            ),
          ] else ...[
            IconButton(
              icon: Icon(Icons.checklist),
              onPressed: () {
                setState(() {
                  isSelectionMode = true;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.filter_list),
              onPressed: () {
                // Show filter options
              },
            ),
          ],
        ],
      ),
      body: Column(
        children: [
          // Search and Filter Section
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                QTextField(
                  label: "Search documents...",
                  value: searchQuery,
                  hint: "Search by title, author, or tags",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Category",
                        items: categoryOptions,
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
                        label: "Status",
                        items: statusOptions,
                        value: selectedStatus,
                        onChanged: (value, label) {
                          selectedStatus = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Results Info
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            child: Row(
              children: [
                Text(
                  "${filteredDocuments.length} documents",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                if (searchQuery.isNotEmpty || selectedCategory != "All" || selectedStatus != "All")
                  GestureDetector(
                    onTap: () {
                      searchQuery = "";
                      selectedCategory = "All";
                      selectedStatus = "All";
                      setState(() {});
                    },
                    child: Text(
                      "Clear filters",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Documents Grid
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: filteredDocuments.map((doc) => GestureDetector(
                  onTap: () {
                    if (isSelectionMode) {
                      _toggleSelection(doc["id"]);
                    } else {
                      _openDocument(doc);
                    }
                  },
                  onLongPress: () {
                    if (!isSelectionMode) {
                      setState(() {
                        isSelectionMode = true;
                        selectedItems.add(doc["id"]);
                      });
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                      border: isSelectionMode && selectedItems.contains(doc["id"])
                          ? Border.all(color: primaryColor, width: 2)
                          : null,
                    ),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Document Thumbnail
                            Stack(
                              children: [
                                Container(
                                  height: 140,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                                    image: DecorationImage(
                                      image: NetworkImage("${doc["thumbnail"]}"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: spXs,
                                  right: spXs,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: _getTypeColor(doc["type"]).withAlpha(200),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${doc["type"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                if (doc["confidential"])
                                  Positioned(
                                    top: spXs,
                                    left: spXs,
                                    child: Container(
                                      padding: EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        color: dangerColor.withAlpha(200),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Icon(
                                        Icons.lock,
                                        color: Colors.white,
                                        size: 12,
                                      ),
                                    ),
                                  ),
                              ],
                            ),

                            // Document Info
                            Padding(
                              padding: EdgeInsets.all(spSm),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Title and Version
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${doc["title"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: disabledColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${doc["version"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: disabledBoldColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),

                                  // Author and Department
                                  Text(
                                    "${doc["author"]} • ${doc["department"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),

                                  // Category and Size
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: _getCategoryColor(doc["category"]).withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${doc["category"]}",
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: _getCategoryColor(doc["category"]),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "${doc["size"]}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spSm),

                                  // Description
                                  Text(
                                    "${doc["description"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                      height: 1.3,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: spSm),

                                  // Tags
                                  Wrap(
                                    spacing: spXxs,
                                    runSpacing: spXxs,
                                    children: (doc["tags"] as List).take(3).map((tag) => Container(
                                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
                                      decoration: BoxDecoration(
                                        color: primaryColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "#$tag",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: primaryColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    )).toList(),
                                  ),
                                  SizedBox(height: spSm),

                                  // Footer Info
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.visibility,
                                        size: 12,
                                        color: disabledColor,
                                      ),
                                      SizedBox(width: 2),
                                      Text(
                                        "${doc["accessCount"]}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledColor,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "${doc["date"]}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        // Selection Indicator
                        if (isSelectionMode)
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: selectedItems.contains(doc["id"]) 
                                    ? primaryColor 
                                    : Colors.white,
                                border: Border.all(
                                  color: selectedItems.contains(doc["id"]) 
                                      ? primaryColor 
                                      : disabledColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: selectedItems.contains(doc["id"]) 
                                  ? Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 16,
                                    )
                                  : null,
                            ),
                          ),
                      ],
                    ),
                  ),
                )).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _toggleSelection(String docId) {
    setState(() {
      if (selectedItems.contains(docId)) {
        selectedItems.remove(docId);
      } else {
        selectedItems.add(docId);
      }
    });
  }

  void _openDocument(Map<String, dynamic> doc) {
    // Handle document opening
    si("Opening ${doc["title"]}");
  }

  void _bulkDownload() async {
    bool isConfirmed = await confirm("Download ${selectedItems.length} selected documents?");
    
    if (isConfirmed) {
      showLoading();
      
      // Simulate download
      await Future.delayed(Duration(seconds: 2));
      
      hideLoading();
      ss("${selectedItems.length} documents downloaded successfully");
      
      setState(() {
        isSelectionMode = false;
        selectedItems.clear();
      });
    }
  }

  void _bulkDelete() async {
    bool isConfirmed = await confirm("Delete ${selectedItems.length} selected documents? This action cannot be undone.");
    
    if (isConfirmed) {
      showLoading();
      
      // Simulate deletion
      await Future.delayed(Duration(seconds: 1));
      
      hideLoading();
      ss("${selectedItems.length} documents deleted successfully");
      
      setState(() {
        // Remove deleted items from the list
        archivedDocuments.removeWhere((doc) => selectedItems.contains(doc["id"]));
        isSelectionMode = false;
        selectedItems.clear();
      });
    }
  }

  Color _getTypeColor(String type) {
    switch (type.toUpperCase()) {
      case "PDF":
        return dangerColor;
      case "DOCX":
        return infoColor;
      case "PPTX":
        return warningColor;
      case "ZIP":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Financial":
        return successColor;
      case "HR":
        return infoColor;
      case "Technical":
        return primaryColor;
      case "Marketing":
        return warningColor;
      case "Legal":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }
}
