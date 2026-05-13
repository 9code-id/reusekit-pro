import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaPropertyDocumentsView extends StatefulWidget {
  const ReaPropertyDocumentsView({super.key});

  @override
  State<ReaPropertyDocumentsView> createState() => _ReaPropertyDocumentsViewState();
}

class _ReaPropertyDocumentsViewState extends State<ReaPropertyDocumentsView> {
  String selectedProperty = "Luxury Apartment - Downtown";
  String documentCategory = "All Documents";
  bool isGridView = false;

  List<Map<String, dynamic>> documentCategories = [
    {
      "category": "Legal Documents",
      "count": 8,
      "icon": Icons.gavel,
      "color": const Color(0xFF2196F3),
    },
    {
      "category": "Financial Records",
      "count": 12,
      "icon": Icons.account_balance,
      "color": const Color(0xFF4CAF50),
    },
    {
      "category": "Property Records",
      "count": 6,
      "icon": Icons.home,
      "color": const Color(0xFFFF9800),
    },
    {
      "category": "Insurance Papers",
      "count": 4,
      "icon": Icons.security,
      "color": const Color(0xFF9C27B0),
    },
  ];

  List<Map<String, dynamic>> documents = [
    {
      "name": "Property Deed",
      "category": "Legal Documents",
      "type": "PDF",
      "size": "2.4 MB",
      "date": "2024-01-15",
      "status": "Verified",
      "importance": "Critical",
      "icon": Icons.description,
      "color": const Color(0xFF2196F3),
    },
    {
      "name": "Title Insurance Policy",
      "category": "Insurance Papers",
      "type": "PDF",
      "size": "1.8 MB",
      "date": "2024-01-15",
      "status": "Active",
      "importance": "Critical",
      "icon": Icons.security,
      "color": const Color(0xFF9C27B0),
    },
    {
      "name": "Property Survey Report",
      "category": "Property Records",
      "type": "PDF",
      "size": "5.2 MB",
      "date": "2024-01-10",
      "status": "Current",
      "importance": "High",
      "icon": Icons.map,
      "color": const Color(0xFFFF9800),
    },
    {
      "name": "Home Inspection Report",
      "category": "Property Records",
      "type": "PDF",
      "size": "8.7 MB",
      "date": "2024-01-08",
      "status": "Complete",
      "importance": "High",
      "icon": Icons.assessment,
      "color": const Color(0xFFFF9800),
    },
    {
      "name": "Property Tax Records",
      "category": "Financial Records",
      "type": "PDF",
      "size": "1.2 MB",
      "date": "2024-01-20",
      "status": "Current",
      "importance": "High",
      "icon": Icons.receipt,
      "color": const Color(0xFF4CAF50),
    },
    {
      "name": "Purchase Agreement",
      "category": "Legal Documents",
      "type": "PDF",
      "size": "3.1 MB",
      "date": "2023-12-28",
      "status": "Executed",
      "importance": "Critical",
      "icon": Icons.handshake,
      "color": const Color(0xFF2196F3),
    },
    {
      "name": "Mortgage Documents",
      "category": "Financial Records",
      "type": "PDF",
      "size": "4.6 MB",
      "date": "2024-01-05",
      "status": "Active",
      "importance": "Critical",
      "icon": Icons.account_balance,
      "color": const Color(0xFF4CAF50),
    },
    {
      "name": "HOA Documents",
      "category": "Legal Documents",
      "type": "PDF",
      "size": "2.8 MB",
      "date": "2024-01-12",
      "status": "Current",
      "importance": "Medium",
      "icon": Icons.apartment,
      "color": const Color(0xFF2196F3),
    },
    {
      "name": "Property Insurance",
      "category": "Insurance Papers",
      "type": "PDF",
      "size": "1.5 MB",
      "date": "2024-01-18",
      "status": "Active",
      "importance": "Critical",
      "icon": Icons.shield,
      "color": const Color(0xFF9C27B0),
    },
    {
      "name": "Utility Bills Archive",
      "category": "Financial Records",
      "type": "ZIP",
      "size": "12.3 MB",
      "date": "2024-01-25",
      "status": "Archive",
      "importance": "Low",
      "icon": Icons.folder_zip,
      "color": const Color(0xFF4CAF50),
    },
    {
      "name": "Appraisal Report",
      "category": "Property Records",
      "type": "PDF",
      "size": "6.4 MB",
      "date": "2024-01-03",
      "status": "Current",
      "importance": "High",
      "icon": Icons.analytics,
      "color": const Color(0xFFFF9800),
    },
    {
      "name": "Warranty Documents",
      "category": "Property Records",
      "type": "PDF",
      "size": "2.1 MB",
      "date": "2024-01-16",
      "status": "Active",
      "importance": "Medium",
      "icon": Icons.verified,
      "color": const Color(0xFFFF9800),
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredDocuments = documentCategory == "All Documents"
        ? documents
        : documents.where((doc) => doc["category"] == documentCategory).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Property Documents"),
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
            onPressed: () => _showUploadDialog(),
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => ss("Search documents"),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildPropertySelector(),
            _buildDocumentStats(),
            _buildCategoryFilter(),
            _buildDocumentList(filteredDocuments),
            _buildStorageInfo(),
            _buildQuickActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildPropertySelector() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.folder,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Document Library",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Select Property",
            items: [
              {"label": "Luxury Apartment - Downtown", "value": "Luxury Apartment - Downtown"},
              {"label": "Commercial Space - Business District", "value": "Commercial Space - Business District"},
              {"label": "Villa - Suburban Area", "value": "Villa - Suburban Area"},
              {"label": "Office Building - Tech Hub", "value": "Office Building - Tech Hub"},
            ],
            value: selectedProperty,
            onChanged: (value, label) {
              selectedProperty = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentStats() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(150)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spMd,
        children: [
          Text(
            "Document Summary",
            style: TextStyle(
              color: Colors.white,
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 100,
            children: [
              _buildStatCard("Total", "${documents.length}", Icons.description),
              _buildStatCard("Critical", "${documents.where((d) => d["importance"] == "Critical").length}", Icons.priority_high),
              _buildStatCard("Active", "${documents.where((d) => d["status"] == "Active" || d["status"] == "Current").length}", Icons.check_circle),
              _buildStatCard("Size", "${_calculateTotalSize()}", Icons.storage),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(50),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withAlpha(180),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.category,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Document Categories",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QHorizontalScroll(
            children: [
              _buildCategoryChip("All Documents", documents.length),
              ...documentCategories.map((category) =>
                  _buildCategoryChip(category["category"], category["count"])),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String category, int count) {
    bool isSelected = documentCategory == category;
    
    return GestureDetector(
      onTap: () {
        documentCategory = category;
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
        margin: EdgeInsets.only(right: spXs),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : disabledColor,
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Row(
          children: [
            Text(
              category,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : primaryColor,
              ),
            ),
            SizedBox(width: spXs),
            Container(
              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white.withAlpha(50) : primaryColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Text(
                "$count",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentList(List<Map<String, dynamic>> filteredDocuments) {
    if (isGridView) {
      return ResponsiveGridView(
        padding: EdgeInsets.zero,
        minItemWidth: 200,
        children: filteredDocuments.map((doc) => _buildDocumentGridCard(doc)).toList(),
      );
    } else {
      return Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Text(
                "Documents (${filteredDocuments.length})",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...filteredDocuments.map((doc) => _buildDocumentListCard(doc)),
        ],
      );
    }
  }

  Widget _buildDocumentListCard(Map<String, dynamic> doc) {
    Color importanceColor = _getImportanceColor(doc["importance"]);
    Color statusColor = _getStatusColor(doc["status"]);
    
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
              color: (doc["color"] as Color).withAlpha(30),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Icon(
              doc["icon"] as IconData,
              color: doc["color"] as Color,
              size: 24,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${doc["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: importanceColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${doc["importance"]}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: importanceColor,
                        ),
                      ),
                    ),
                    SizedBox(width: spXs),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${doc["status"]}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: statusColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "${doc["type"]} • ${doc["size"]} • ${DateTime.parse(doc["date"]).dMMMy}",
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
          Column(
            children: [
              GestureDetector(
                onTap: () => _downloadDocument(doc),
                child: Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Icon(
                    Icons.download,
                    color: primaryColor,
                    size: 16,
                  ),
                ),
              ),
              SizedBox(height: spXs),
              GestureDetector(
                onTap: () => _shareDocument(doc),
                child: Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Icon(
                    Icons.share,
                    color: infoColor,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentGridCard(Map<String, dynamic> doc) {
    Color importanceColor = _getImportanceColor(doc["importance"]);
    Color statusColor = _getStatusColor(doc["status"]);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: (doc["color"] as Color).withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(
                  doc["icon"] as IconData,
                  color: doc["color"] as Color,
                  size: 20,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: importanceColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${doc["importance"]}",
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: importanceColor,
                  ),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${doc["name"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: spXs),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${doc["status"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "${doc["type"]} • ${doc["size"]}",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "${DateTime.parse(doc["date"]).dMMMy}",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Row(
            spacing: spXs,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => _downloadDocument(doc),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: spXs),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Icon(
                      Icons.download,
                      color: primaryColor,
                      size: 16,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => _shareDocument(doc),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: spXs),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Icon(
                      Icons.share,
                      color: infoColor,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStorageInfo() {
    double totalSizeMB = documents.fold(0.0, (sum, doc) {
      String sizeStr = doc["size"] as String;
      double size = double.tryParse(sizeStr.split(' ')[0]) ?? 0;
      return sum + size;
    });

    double usagePercentage = (totalSizeMB / 1000) * 100; // Assuming 1GB limit

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.cloud_queue,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Storage Usage",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${totalSizeMB.toStringAsFixed(1)} MB / 1 GB",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: disabledOutlineBorderColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: usagePercentage / 100,
              child: Container(
                decoration: BoxDecoration(
                  color: usagePercentage > 80 ? dangerColor : primaryColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    List<Map<String, dynamic>> actions = [
      {
        "title": "Upload Document",
        "icon": Icons.upload_file,
        "color": primaryColor,
        "action": () => _showUploadDialog(),
      },
      {
        "title": "Create Folder",
        "icon": Icons.create_new_folder,
        "color": infoColor,
        "action": () => ss("Creating new folder"),
      },
      {
        "title": "Scan Document",
        "icon": Icons.document_scanner,
        "color": successColor,
        "action": () => ss("Opening document scanner"),
      },
      {
        "title": "Archive Old Files",
        "icon": Icons.archive,
        "color": warningColor,
        "action": () => ss("Archiving old documents"),
      },
    ];

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.bolt,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Quick Actions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: actions.map((action) {
              return GestureDetector(
                onTap: action["action"],
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: (action["color"] as Color).withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                    border: Border.all(
                      color: (action["color"] as Color).withAlpha(100),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    spacing: spXs,
                    children: [
                      Icon(
                        action["icon"] as IconData,
                        color: action["color"] as Color,
                        size: 28,
                      ),
                      Text(
                        "${action["title"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: action["color"] as Color,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Color _getImportanceColor(String importance) {
    switch (importance) {
      case "Critical":
        return dangerColor;
      case "High":
        return warningColor;
      case "Medium":
        return infoColor;
      case "Low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
      case "Current":
      case "Verified":
        return successColor;
      case "Pending":
        return warningColor;
      case "Expired":
        return dangerColor;
      case "Archive":
        return disabledBoldColor;
      default:
        return infoColor;
    }
  }

  String _calculateTotalSize() {
    double totalSizeMB = documents.fold(0.0, (sum, doc) {
      String sizeStr = doc["size"] as String;
      double size = double.tryParse(sizeStr.split(' ')[0]) ?? 0;
      return sum + size;
    });

    if (totalSizeMB > 1000) {
      return "${(totalSizeMB / 1000).toStringAsFixed(1)} GB";
    } else {
      return "${totalSizeMB.toStringAsFixed(1)} MB";
    }
  }

  void _downloadDocument(Map<String, dynamic> doc) {
    ss("Downloading ${doc["name"]}");
  }

  void _shareDocument(Map<String, dynamic> doc) {
    ss("Sharing ${doc["name"]}");
  }

  void _showUploadDialog() {
    ss("Upload document dialog opened");
  }
}
