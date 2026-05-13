import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaBrandStandardsView extends StatefulWidget {
  const FmaBrandStandardsView({super.key});

  @override
  State<FmaBrandStandardsView> createState() => _FmaBrandStandardsViewState();
}

class _FmaBrandStandardsViewState extends State<FmaBrandStandardsView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedCategory = "";
  String selectedStatus = "";
  
  List<Map<String, dynamic>> brandStandards = [
    {
      "id": "BS001",
      "title": "Logo Usage Guidelines",
      "description": "Official brand logo usage standards and requirements",
      "category": "Visual Identity",
      "status": "Active",
      "version": "2.1",
      "lastUpdated": "2024-01-15",
      "compliance": 95,
      "documents": 8,
      "priority": "High",
      "owner": "Brand Team",
      "image": "https://picsum.photos/400/300?random=1&keyword=logo"
    },
    {
      "id": "BS002",
      "title": "Color Palette Standards",
      "description": "Brand color specifications and application guidelines",
      "category": "Visual Identity",
      "status": "Active",
      "version": "1.5",
      "lastUpdated": "2023-11-20",
      "compliance": 88,
      "documents": 5,
      "priority": "High",
      "owner": "Design Team",
      "image": "https://picsum.photos/400/300?random=2&keyword=color"
    },
    {
      "id": "BS003",
      "title": "Typography Guidelines",
      "description": "Font families, sizes and hierarchy specifications",
      "category": "Visual Identity",
      "status": "Active",
      "version": "3.0",
      "lastUpdated": "2024-02-10",
      "compliance": 92,
      "documents": 12,
      "priority": "Medium",
      "owner": "Brand Team",
      "image": "https://picsum.photos/400/300?random=3&keyword=typography"
    },
    {
      "id": "BS004",
      "title": "Store Layout Standards",
      "description": "Physical store design and layout requirements",
      "category": "Store Design",
      "status": "Under Review",
      "version": "1.8",
      "lastUpdated": "2023-12-05",
      "compliance": 76,
      "documents": 15,
      "priority": "High",
      "owner": "Store Operations",
      "image": "https://picsum.photos/400/300?random=4&keyword=store"
    },
    {
      "id": "BS005",
      "title": "Customer Service Standards",
      "description": "Service quality and customer interaction guidelines",
      "category": "Operations",
      "status": "Active",
      "version": "2.3",
      "lastUpdated": "2024-01-08",
      "compliance": 85,
      "documents": 20,
      "priority": "High",
      "owner": "Customer Success",
      "image": "https://picsum.photos/400/300?random=5&keyword=service"
    },
    {
      "id": "BS006",
      "title": "Digital Marketing Standards",
      "description": "Online presence and digital marketing guidelines",
      "category": "Marketing",
      "status": "Active",
      "version": "1.2",
      "lastUpdated": "2023-10-25",
      "compliance": 90,
      "documents": 18,
      "priority": "Medium",
      "owner": "Marketing Team",
      "image": "https://picsum.photos/400/300?random=6&keyword=digital"
    }
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": ""},
    {"label": "Visual Identity", "value": "Visual Identity"},
    {"label": "Store Design", "value": "Store Design"},
    {"label": "Operations", "value": "Operations"},
    {"label": "Marketing", "value": "Marketing"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": ""},
    {"label": "Active", "value": "Active"},
    {"label": "Under Review", "value": "Under Review"},
    {"label": "Draft", "value": "Draft"},
  ];

  List<Map<String, dynamic>> get filteredStandards {
    return brandStandards.where((standard) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${standard["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${standard["description"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory.isEmpty || standard["category"] == selectedCategory;
      bool matchesStatus = selectedStatus.isEmpty || standard["status"] == selectedStatus;
      
      return matchesSearch && matchesCategory && matchesStatus;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Under Review":
        return warningColor;
      case "Draft":
        return infoColor;
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

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Brand Standards",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Standards", icon: Icon(Icons.rule)),
        Tab(text: "Compliance", icon: Icon(Icons.verified)),
        Tab(text: "Documents", icon: Icon(Icons.folder)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildStandardsTab(),
        _buildComplianceTab(),
        _buildDocumentsTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    int totalStandards = brandStandards.length;
    int activeStandards = brandStandards.where((s) => s["status"] == "Active").length;
    double avgCompliance = brandStandards.fold(0.0, (sum, s) => sum + (s["compliance"] as int)) / brandStandards.length;
    int totalDocuments = brandStandards.fold(0, (sum, s) => sum + (s["documents"] as int));

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildOverviewCard(
                "Total Standards",
                "$totalStandards",
                Icons.rule,
                primaryColor,
              ),
              _buildOverviewCard(
                "Active Standards",
                "$activeStandards",
                Icons.check_circle,
                successColor,
              ),
              _buildOverviewCard(
                "Average Compliance",
                "${avgCompliance.toStringAsFixed(1)}%",
                Icons.analytics,
                infoColor,
              ),
              _buildOverviewCard(
                "Total Documents",
                "$totalDocuments",
                Icons.folder,
                warningColor,
              ),
            ],
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Standards by Category",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Column(
                  spacing: spSm,
                  children: categoryOptions.skip(1).map((category) {
                    int count = brandStandards.where((s) => s["category"] == category["value"]).length;
                    double avgComplianceForCategory = brandStandards
                        .where((s) => s["category"] == category["value"])
                        .fold(0.0, (sum, s) => sum + (s["compliance"] as int)) / count;
                    
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: primaryColor.withAlpha(20),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${category["label"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "$count standards",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Compliance",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${avgComplianceForCategory.toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: avgComplianceForCategory >= 90 
                                        ? successColor 
                                        : avgComplianceForCategory >= 75 
                                            ? warningColor 
                                            : dangerColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
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
              Icon(
                icon,
                color: color,
                size: 24,
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

  Widget _buildStandardsTab() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [shadowSm],
          ),
          child: Column(
            spacing: spSm,
            children: [
              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Search standards...",
                      value: searchQuery,
                      hint: "Search by title or description",
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
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Filter by Category",
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
                      label: "Filter by Status",
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
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(spMd),
            itemCount: filteredStandards.length,
            itemBuilder: (context, index) {
              final standard = filteredStandards[index];
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                padding: EdgeInsets.all(spMd),
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
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusSm),
                          child: Image.network(
                            "${standard["image"]}",
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${standard["title"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor(standard["status"]).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${standard["status"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: _getStatusColor(standard["status"]),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${standard["description"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: primaryColor.withAlpha(10),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${standard["category"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getPriorityColor(standard["priority"]).withAlpha(10),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${standard["priority"]} Priority",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: _getPriorityColor(standard["priority"]),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(color: disabledColor),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Version ${standard["version"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Updated: ${standard["lastUpdated"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
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
                                "Compliance: ${standard["compliance"]}%",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: (standard["compliance"] as int) >= 90 
                                      ? successColor 
                                      : (standard["compliance"] as int) >= 75 
                                          ? warningColor 
                                          : dangerColor,
                                ),
                              ),
                              Text(
                                "${standard["documents"]} documents",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Owner",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${standard["owner"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: spSm),
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
            },
          ),
        ),
      ],
    );
  }

  Widget _buildComplianceTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Compliance Overview",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Column(
                  spacing: spSm,
                  children: brandStandards.map((standard) {
                    Color complianceColor = (standard["compliance"] as int) >= 90 
                        ? successColor 
                        : (standard["compliance"] as int) >= 75 
                            ? warningColor 
                            : dangerColor;
                    
                    return Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: complianceColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: complianceColor.withAlpha(30),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Text(
                                  "${standard["title"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${standard["category"]} • v${standard["version"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 8,
                                        decoration: BoxDecoration(
                                          color: disabledColor,
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: FractionallySizedBox(
                                          alignment: Alignment.centerLeft,
                                          widthFactor: (standard["compliance"] as int) / 100,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: complianceColor,
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Text(
                                      "${standard["compliance"]}%",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: complianceColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildComplianceCard(
                "High Compliance",
                "4 Standards",
                "≥90% Compliance",
                Icons.check_circle,
                successColor,
              ),
              _buildComplianceCard(
                "Medium Compliance",
                "1 Standard",
                "75-89% Compliance",
                Icons.warning,
                warningColor,
              ),
              _buildComplianceCard(
                "Low Compliance",
                "1 Standard",
                "<75% Compliance",
                Icons.error,
                dangerColor,
              ),
              _buildComplianceCard(
                "Average Score",
                "All Standards",
                "87.2% Average",
                Icons.analytics,
                infoColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildComplianceCard(String title, String subtitle, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
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
              Icon(
                icon,
                color: color,
                size: 24,
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
            subtitle,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentsTab() {
    List<Map<String, dynamic>> documents = [
      {
        "name": "Brand Guidelines v2.1.pdf",
        "type": "PDF",
        "size": "4.2 MB",
        "modified": "2024-01-15",
        "downloads": 245,
        "standard": "Logo Usage Guidelines"
      },
      {
        "name": "Color Palette Specs.sketch",
        "type": "Sketch",
        "size": "1.8 MB",
        "modified": "2023-11-20",
        "downloads": 156,
        "standard": "Color Palette Standards"
      },
      {
        "name": "Typography Kit.zip",
        "type": "Archive",
        "size": "12.5 MB",
        "modified": "2024-02-10",
        "downloads": 89,
        "standard": "Typography Guidelines"
      },
      {
        "name": "Store Layout Blueprint.dwg",
        "type": "CAD",
        "size": "8.7 MB",
        "modified": "2023-12-05",
        "downloads": 67,
        "standard": "Store Layout Standards"
      }
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Row(
                  children: [
                    Text(
                      "Document Library",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "Upload New",
                      icon: Icons.upload,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
                Column(
                  spacing: spSm,
                  children: documents.map((document) {
                    IconData fileIcon;
                    Color fileColor;
                    
                    switch (document["type"]) {
                      case "PDF":
                        fileIcon = Icons.picture_as_pdf;
                        fileColor = dangerColor;
                        break;
                      case "Sketch":
                        fileIcon = Icons.design_services;
                        fileColor = warningColor;
                        break;
                      case "Archive":
                        fileIcon = Icons.folder_zip;
                        fileColor = infoColor;
                        break;
                      case "CAD":
                        fileIcon = Icons.architecture;
                        fileColor = successColor;
                        break;
                      default:
                        fileIcon = Icons.insert_drive_file;
                        fileColor = disabledBoldColor;
                    }
                    
                    return Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: fileColor.withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: fileColor.withAlpha(20),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            fileIcon,
                            color: fileColor,
                            size: 32,
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Text(
                                  "${document["name"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${document["standard"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${document["size"]} • Modified ${document["modified"]}",
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
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "${document["downloads"]} downloads",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              QButton(
                                icon: Icons.download,
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
        ],
      ),
    );
  }
}
