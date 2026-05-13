import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaDocumentManagementView extends StatefulWidget {
  const RhaDocumentManagementView({super.key});

  @override
  State<RhaDocumentManagementView> createState() => _RhaDocumentManagementViewState();
}

class _RhaDocumentManagementViewState extends State<RhaDocumentManagementView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedStatus = "All";
  bool isGridView = false;

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Contracts", "value": "Contracts"},
    {"label": "Reports", "value": "Reports"},
    {"label": "Policies", "value": "Policies"},
    {"label": "Templates", "value": "Templates"},
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "Draft", "value": "Draft"},
    {"label": "Archived", "value": "Archived"},
    {"label": "Expired", "value": "Expired"},
  ];

  List<Map<String, dynamic>> documents = [
    {
      "id": "1",
      "title": "Employee Handbook 2024",
      "category": "Policies",
      "status": "Active",
      "type": "PDF",
      "size": "2.4 MB",
      "lastModified": "2024-03-15",
      "author": "HR Department",
      "downloads": 156,
      "icon": Icons.description,
      "color": Colors.red,
    },
    {
      "id": "2",
      "title": "Quarterly Performance Report",
      "category": "Reports",
      "status": "Active",
      "type": "XLSX",
      "size": "1.8 MB",
      "lastModified": "2024-03-14",
      "author": "Performance Team",
      "downloads": 89,
      "icon": Icons.table_chart,
      "color": Colors.green,
    },
    {
      "id": "3",
      "title": "Service Contract Template",
      "category": "Templates",
      "status": "Active",
      "type": "DOCX",
      "size": "856 KB",
      "lastModified": "2024-03-13",
      "author": "Legal Team",
      "downloads": 234,
      "icon": Icons.article,
      "color": Colors.blue,
    },
    {
      "id": "4",
      "title": "Budget Analysis 2024",
      "category": "Reports",
      "status": "Draft",
      "type": "PDF",
      "size": "3.2 MB",
      "lastModified": "2024-03-12",
      "author": "Finance Team",
      "downloads": 45,
      "icon": Icons.assessment,
      "color": Colors.orange,
    },
    {
      "id": "5",
      "title": "Safety Guidelines",
      "category": "Policies",
      "status": "Active",
      "type": "PDF",
      "size": "1.5 MB",
      "lastModified": "2024-03-11",
      "author": "Safety Officer",
      "downloads": 178,
      "icon": Icons.security,
      "color": Colors.purple,
    },
    {
      "id": "6",
      "title": "Client Agreement Form",
      "category": "Contracts",
      "status": "Active",
      "type": "PDF",
      "size": "945 KB",
      "lastModified": "2024-03-10",
      "author": "Business Development",
      "downloads": 312,
      "icon": Icons.handshake,
      "color": Colors.teal,
    },
  ];

  List<Map<String, dynamic>> get filteredDocuments {
    return documents.where((doc) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${doc["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${doc["author"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "All" || doc["category"] == selectedCategory;
      bool matchesStatus = selectedStatus == "All" || doc["status"] == selectedStatus;
      
      return matchesSearch && matchesCategory && matchesStatus;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active": return successColor;
      case "Draft": return warningColor;
      case "Archived": return disabledBoldColor;
      case "Expired": return dangerColor;
      default: return primaryColor;
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
          spacing: spMd,
          children: [
            // Search Bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search documents...",
                    value: searchQuery,
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

            // Filters
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
                    label: "Status",
                    items: statusItems,
                    value: selectedStatus,
                    onChanged: (value, label) {
                      selectedStatus = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Statistics Cards
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.folder, color: primaryColor, size: 32),
                        SizedBox(height: spXs),
                        Text(
                          "${documents.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Documents",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.cloud_upload, color: successColor, size: 32),
                        SizedBox(height: spXs),
                        Text(
                          "${documents.map((d) => d["downloads"] as int).reduce((a, b) => a + b)}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Downloads",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.storage, color: infoColor, size: 32),
                        SizedBox(height: spXs),
                        Text(
                          "12.4 GB",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Storage Used",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Documents List/Grid
            if (isGridView) ...[
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: filteredDocuments.map((document) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
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
                                color: (document["color"] as Color).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Icon(
                                document["icon"] as IconData,
                                color: document["color"] as Color,
                                size: 24,
                              ),
                            ),
                            Spacer(),
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
                                  color: _getStatusColor("${document["status"]}"),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${document["title"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "${document["category"]} • ${document["type"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${document["size"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.download, size: 12, color: disabledBoldColor),
                            SizedBox(width: 4),
                            Text(
                              "${document["downloads"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${document["lastModified"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: double.infinity,
                          child: QButton(
                            label: "Open",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ] else ...[
              Column(
                spacing: spSm,
                children: filteredDocuments.map((document) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: (document["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(
                            document["icon"] as IconData,
                            color: document["color"] as Color,
                            size: 32,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${document["title"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
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
                                        color: _getStatusColor("${document["status"]}"),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${document["category"]} • ${document["type"]} • ${document["size"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "By ${document["author"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Icon(Icons.download, size: 12, color: disabledBoldColor),
                                  SizedBox(width: 4),
                                  Text(
                                    "${document["downloads"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "${document["lastModified"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: spSm),
                        Column(
                          spacing: spXs,
                          children: [
                            QButton(
                              icon: Icons.download,
                              size: bs.sm,
                              onPressed: () {},
                            ),
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
          ],
        ),
      ),
    );
  }
}
