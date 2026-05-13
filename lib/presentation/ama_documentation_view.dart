import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaDocumentationView extends StatefulWidget {
  const AmaDocumentationView({super.key});

  @override
  State<AmaDocumentationView> createState() => _AmaDocumentationViewState();
}

class _AmaDocumentationViewState extends State<AmaDocumentationView> {
  List documents = [
    {
      "id": 1,
      "title": "Organic Certification Records",
      "category": "Certifications",
      "type": "PDF",
      "size": "2.5 MB",
      "last_modified": "2024-01-15",
      "status": "Current",
      "expiry_date": "2025-06-15",
      "description": "Complete organic farming certification documentation",
      "tags": ["organic", "certification", "compliance"],
      "color": successColor,
      "icon": Icons.eco,
      "is_required": true,
    },
    {
      "id": 2, 
      "title": "Soil Test Reports",
      "category": "Testing",
      "type": "PDF",
      "size": "1.8 MB",
      "last_modified": "2024-01-10",
      "status": "Current",
      "expiry_date": "2024-07-10",
      "description": "Annual soil composition and fertility analysis",
      "tags": ["soil", "testing", "analysis"],
      "color": warningColor,
      "icon": Icons.science,
      "is_required": true,
    },
    {
      "id": 3,
      "title": "Pesticide Application Logs",
      "category": "Operations",
      "type": "Excel",
      "size": "0.9 MB",
      "last_modified": "2024-01-20",
      "status": "Current",
      "expiry_date": null,
      "description": "Daily pesticide usage and application records",
      "tags": ["pesticide", "application", "safety"],
      "color": dangerColor,
      "icon": Icons.warning,
      "is_required": true,
    },
    {
      "id": 4,
      "title": "Water Quality Certificates",
      "category": "Environmental",
      "type": "PDF",
      "size": "1.2 MB",
      "last_modified": "2023-12-20",
      "status": "Expiring Soon",
      "expiry_date": "2024-03-20",
      "description": "Irrigation water quality test results and certificates",
      "tags": ["water", "quality", "irrigation"],
      "color": infoColor,
      "icon": Icons.water_drop,
      "is_required": true,
    },
    {
      "id": 5,
      "title": "Equipment Maintenance Logs",
      "category": "Maintenance",
      "type": "PDF",
      "size": "3.2 MB",
      "last_modified": "2024-01-18",
      "status": "Current",
      "expiry_date": null,
      "description": "Farm equipment service and maintenance records",
      "tags": ["equipment", "maintenance", "service"],
      "color": primaryColor,
      "icon": Icons.build,
      "is_required": false,
    },
    {
      "id": 6,
      "title": "Worker Safety Training",
      "category": "Safety",
      "type": "PDF",
      "size": "1.5 MB",
      "last_modified": "2024-01-05",
      "status": "Current",
      "expiry_date": "2024-12-05",
      "description": "Employee safety training certificates and records",
      "tags": ["safety", "training", "workers"],
      "color": secondaryColor,
      "icon": Icons.safety_check,
      "is_required": true,
    },
    {
      "id": 7,
      "title": "Financial Records",
      "category": "Finance",
      "type": "Excel",
      "size": "2.1 MB",
      "last_modified": "2024-01-22",
      "status": "Current",
      "expiry_date": null,
      "description": "Farm income, expenses, and profitability reports",
      "tags": ["finance", "income", "expenses"],
      "color": warningColor,
      "icon": Icons.account_balance,
      "is_required": false,
    },
  ];

  String selectedCategory = "All";
  String selectedStatus = "All";
  String searchQuery = "";
  
  List<String> categories = ["All", "Certifications", "Testing", "Operations", "Environmental", "Maintenance", "Safety", "Finance"];
  List<String> statuses = ["All", "Current", "Expiring Soon", "Expired"];

  @override
  Widget build(BuildContext context) {
    List filteredDocs = documents.where((doc) {
      bool categoryMatch = selectedCategory == "All" || doc["category"] == selectedCategory;
      bool statusMatch = selectedStatus == "All" || doc["status"] == selectedStatus;
      bool searchMatch = searchQuery.isEmpty || 
        "${doc["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
        (doc["tags"] as List).any((tag) => "$tag".toLowerCase().contains(searchQuery.toLowerCase()));
      return categoryMatch && statusMatch && searchMatch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Documentation"),
        actions: [
          IconButton(
            icon: Icon(Icons.upload_file),
            onPressed: () {
              // Upload new document
            },
          ),
          IconButton(
            icon: Icon(Icons.folder),
            onPressed: () {
              // Browse folders
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Document Overview
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.folder_open,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Document Overview",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${documents.length}",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Total Docs",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 14,
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
                              "${documents.where((d) => d["is_required"] == true).length}",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Required",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 14,
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
                              "${documents.where((d) => d["status"] == "Expiring Soon").length}",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Expiring",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 14,
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
            
            SizedBox(height: spLg),
            
            // Search and Quick Actions
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
                  icon: Icons.add,
                  size: bs.sm,
                  onPressed: () {
                    // Add new document
                  },
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Category",
                    items: categories.map((cat) => {
                      "label": cat,
                      "value": cat,
                    }).toList(),
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
                    items: statuses.map((status) => {
                      "label": status,
                      "value": status,
                    }).toList(),
                    value: selectedStatus,
                    onChanged: (value, label) {
                      selectedStatus = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Documents List
            Text(
              "Documents (${filteredDocs.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredDocs.length,
              itemBuilder: (context, index) {
                final doc = filteredDocs[index];
                
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: doc["is_required"] ? Border(
                      left: BorderSide(
                        width: 4,
                        color: doc["color"] as Color,
                      ),
                    ) : null,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: (doc["color"] as Color).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                doc["icon"] as IconData,
                                color: doc["color"] as Color,
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
                                          "${doc["title"]}",
                                          style: TextStyle(
                                            fontSize: fsH6,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                      if (doc["is_required"])
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: dangerColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "Required",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: dangerColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: _getStatusColor(doc["status"]).withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${doc["status"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: _getStatusColor(doc["status"]),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${doc["category"]}",
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
                          ],
                        ),
                        
                        SizedBox(height: spSm),
                        
                        // Description
                        Text(
                          "${doc["description"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            height: 1.4,
                          ),
                        ),
                        
                        SizedBox(height: spSm),
                        
                        // File Details
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
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.insert_drive_file,
                                          size: 14,
                                          color: disabledBoldColor,
                                        ),
                                        SizedBox(width: spXs),
                                        Text(
                                          "${doc["type"]} • ${doc["size"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.update,
                                          size: 14,
                                          color: disabledBoldColor,
                                        ),
                                        SizedBox(width: spXs),
                                        Text(
                                          "Modified: ${doc["last_modified"]}",
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
                              if (doc["expiry_date"] != null) ...[
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.event,
                                      size: 14,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "Expires: ${doc["expiry_date"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ),
                        
                        SizedBox(height: spSm),
                        
                        // Tags
                        Wrap(
                          spacing: spXs,
                          runSpacing: spXs,
                          children: (doc["tags"] as List).map((tag) => 
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
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
                            ),
                          ).toList(),
                        ),
                        
                        SizedBox(height: spSm),
                        
                        // Actions
                        Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: "View",
                                size: bs.sm,
                                onPressed: () {
                                  // View document
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            QButton(
                              label: "Download",
                              icon: Icons.download,
                              size: bs.sm,
                              onPressed: () {
                                // Download document
                              },
                            ),
                            SizedBox(width: spSm),
                            QButton(
                              icon: Icons.share,
                              size: bs.sm,
                              onPressed: () {
                                // Share document
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Current":
        return successColor;
      case "Expiring Soon":
        return warningColor;
      case "Expired":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }
}
