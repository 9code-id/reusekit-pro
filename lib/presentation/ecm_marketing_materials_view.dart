import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmMarketingMaterialsView extends StatefulWidget {
  const EcmMarketingMaterialsView({super.key});

  @override
  State<EcmMarketingMaterialsView> createState() => _EcmMarketingMaterialsViewState();
}

class _EcmMarketingMaterialsViewState extends State<EcmMarketingMaterialsView> {
  int currentTab = 0;
  String selectedCategory = "All";
  String searchQuery = "";

  List<Map<String, dynamic>> materials = [
    {
      "id": 1,
      "name": "Event Flyer - Tech Summit 2024",
      "category": "Print",
      "type": "Flyer",
      "format": "PDF",
      "size": "2.1 MB",
      "dimensions": "8.5x11 inches",
      "status": "Ready",
      "createdDate": "2024-06-18",
      "lastModified": "2024-06-18",
      "downloads": 145,
      "preview": "https://picsum.photos/300/400?random=1&keyword=flyer",
      "description": "Professional event flyer with event details and registration information",
      "tags": ["print", "flyer", "registration", "marketing"],
      "isApproved": true,
    },
    {
      "id": 2,
      "name": "Social Media Post - Speaker Announcement",
      "category": "Social Media",
      "type": "Instagram Post",
      "format": "PNG",
      "size": "945 KB",
      "dimensions": "1080x1080 px",
      "status": "In Review",
      "createdDate": "2024-06-17",
      "lastModified": "2024-06-17",
      "downloads": 89,
      "preview": "https://picsum.photos/300/300?random=2&keyword=social",
      "description": "Square format social media post for speaker announcements",
      "tags": ["social", "instagram", "speaker", "announcement"],
      "isApproved": false,
    },
    {
      "id": 3,
      "name": "Email Newsletter Template",
      "category": "Digital",
      "type": "Email Template",
      "format": "HTML",
      "size": "156 KB",
      "dimensions": "600px width",
      "status": "Ready",
      "createdDate": "2024-06-16",
      "lastModified": "2024-06-17",
      "downloads": 67,
      "preview": "https://picsum.photos/300/500?random=3&keyword=email",
      "description": "Responsive email template for event updates and announcements",
      "tags": ["email", "newsletter", "responsive", "updates"],
      "isApproved": true,
    },
    {
      "id": 4,
      "name": "Conference Banner - Main Stage",
      "category": "Print",
      "type": "Banner",
      "format": "PDF",
      "size": "4.2 MB",
      "dimensions": "10x3 feet",
      "status": "Draft",
      "createdDate": "2024-06-15",
      "lastModified": "2024-06-16",
      "downloads": 23,
      "preview": "https://picsum.photos/400/150?random=4&keyword=banner",
      "description": "Large format banner for main stage backdrop",
      "tags": ["print", "banner", "stage", "backdrop"],
      "isApproved": false,
    },
    {
      "id": 5,
      "name": "LinkedIn Event Cover",
      "category": "Social Media",
      "type": "LinkedIn Cover",
      "format": "JPG",
      "size": "1.2 MB",
      "dimensions": "1200x627 px",
      "status": "Ready",
      "createdDate": "2024-06-14",
      "lastModified": "2024-06-15",
      "downloads": 112,
      "preview": "https://picsum.photos/400/200?random=5&keyword=linkedin",
      "description": "Professional LinkedIn event cover image",
      "tags": ["social", "linkedin", "cover", "professional"],
      "isApproved": true,
    },
    {
      "id": 6,
      "name": "Name Badge Template",
      "category": "Print",
      "type": "Badge",
      "format": "PDF",
      "size": "890 KB",
      "dimensions": "4x3 inches",
      "status": "Ready",
      "createdDate": "2024-06-13",
      "lastModified": "2024-06-14",
      "downloads": 78,
      "preview": "https://picsum.photos/200/150?random=6&keyword=badge",
      "description": "Customizable name badge template for attendees",
      "tags": ["print", "badge", "attendee", "identification"],
      "isApproved": true,
    },
    {
      "id": 7,
      "name": "Event Program Booklet",
      "category": "Print",
      "type": "Booklet",
      "format": "PDF",
      "size": "6.8 MB",
      "dimensions": "8.5x11 inches",
      "status": "In Progress",
      "createdDate": "2024-06-12",
      "lastModified": "2024-06-16",
      "downloads": 34,
      "preview": "https://picsum.photos/300/400?random=7&keyword=booklet",
      "description": "Complete event program with schedules and speaker information",
      "tags": ["print", "program", "schedule", "speakers"],
      "isApproved": false,
    },
    {
      "id": 8,
      "name": "Mobile App Screenshots",
      "category": "Digital",
      "type": "App Store Assets",
      "format": "PNG",
      "size": "2.3 MB",
      "dimensions": "Various",
      "status": "Ready",
      "createdDate": "2024-06-11",
      "lastModified": "2024-06-12",
      "downloads": 56,
      "preview": "https://picsum.photos/200/400?random=8&keyword=app",
      "description": "App store screenshots for event mobile application",
      "tags": ["digital", "app", "screenshots", "mobile"],
      "isApproved": true,
    },
  ];

  List<Map<String, dynamic>> templates = [
    {
      "id": 1,
      "name": "Corporate Event Package",
      "category": "Business",
      "items": 12,
      "preview": "https://picsum.photos/250/180?random=10&keyword=corporate",
      "description": "Professional templates for corporate events and conferences",
      "includes": ["Flyers", "Banners", "Name Badges", "Email Templates"],
    },
    {
      "id": 2,
      "name": "Tech Conference Bundle",
      "category": "Technology",
      "items": 15,
      "preview": "https://picsum.photos/250/180?random=11&keyword=tech",
      "description": "Modern tech-focused designs for technology conferences",
      "includes": ["Social Media", "Presentations", "Digital Assets", "Print Materials"],
    },
    {
      "id": 3,
      "name": "Medical Symposium Kit",
      "category": "Healthcare",
      "items": 9,
      "preview": "https://picsum.photos/250/180?random=12&keyword=medical",
      "description": "Clean and professional medical event materials",
      "includes": ["Certificates", "Brochures", "Signage", "Digital Badges"],
    },
    {
      "id": 4,
      "name": "Creative Workshop Set",
      "category": "Creative",
      "items": 11,
      "preview": "https://picsum.photos/250/180?random=13&keyword=creative",
      "description": "Artistic and creative templates for workshops and art events",
      "includes": ["Posters", "Social Posts", "Tickets", "Merchandise"],
    },
  ];

  List<String> categories = ["All", "Print", "Digital", "Social Media"];
  List<String> statusOptions = ["All", "Ready", "In Progress", "In Review", "Draft"];

  List<Map<String, dynamic>> get filteredMaterials {
    return materials.where((material) {
      bool matchesCategory = selectedCategory == "All" || material["category"] == selectedCategory;
      bool matchesSearch = searchQuery.isEmpty || 
          material["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          material["description"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Marketing Materials",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Materials", icon: Icon(Icons.inventory)),
        Tab(text: "Templates", icon: Icon(Icons.design_services)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildMaterialsTab(),
        _buildTemplatesTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildMaterialsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          _buildSearchAndFilters(),
          SizedBox(height: spMd),
          _buildMaterialsStats(),
          SizedBox(height: spMd),
          _buildMaterialsList(),
          SizedBox(height: spMd),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Create New Material",
              size: bs.md,
              onPressed: () {
                ss("Create new marketing material");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Column(
      children: [
        QTextField(
          label: "Search Materials",
          value: searchQuery,
          hint: "Enter material name or description...",
          onChanged: (value) {
            searchQuery = value;
            setState(() {});
          },
        ),
        SizedBox(height: spSm),
        QCategoryPicker(
          label: "Category",
          items: categories.map((category) => {
            "label": category,
            "value": category,
          }).toList(),
          value: selectedCategory,
          onChanged: (index, label, value, item) {
            selectedCategory = value;
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildMaterialsStats() {
    int totalMaterials = materials.length;
    int readyMaterials = materials.where((m) => m["status"] == "Ready").length;
    int approvedMaterials = materials.where((m) => m["isApproved"]).length;
    int totalDownloads = materials.fold(0, (sum, m) => sum + (m["downloads"] as int));

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: primaryColor.withAlpha(50)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildStatCard("Total", "$totalMaterials", primaryColor),
              ),
              Container(width: 1, height: 40, color: primaryColor.withAlpha(100)),
              Expanded(
                child: _buildStatCard("Ready", "$readyMaterials", successColor),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildStatCard("Approved", "$approvedMaterials", infoColor),
              ),
              Container(width: 1, height: 40, color: primaryColor.withAlpha(100)),
              Expanded(
                child: _buildStatCard("Downloads", "${(totalDownloads / 1000).toStringAsFixed(1)}K", warningColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: spXs),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildMaterialsList() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: filteredMaterials.map((material) {
        return Container(
          margin: EdgeInsets.only(bottom: spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(radiusMd),
                      topRight: Radius.circular(radiusMd),
                    ),
                    child: Image.network(
                      "${material["preview"]}",
                      width: double.infinity,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: spXs,
                    right: spXs,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: _getStatusColor(material["status"]),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${material["status"]}",
                        style: TextStyle(
                          fontSize: 9,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  if (material["isApproved"])
                    Positioned(
                      top: spXs,
                      left: spXs,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: successColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 12,
                        ),
                      ),
                    ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(spSm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${material["name"]}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        _buildCategoryBadge(material["category"]),
                        SizedBox(width: spXs),
                        _buildTypeBadge(material["type"]),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${material["description"]}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    _buildMaterialInfo(material),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Icon(Icons.download, color: infoColor, size: 14),
                        SizedBox(width: 2),
                        Text(
                          "${material["downloads"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: infoColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${material["size"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Download",
                            size: bs.sm,
                            onPressed: () {
                              ss("Downloaded ${material["name"]}");
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Edit",
                            size: bs.sm,
                            onPressed: () {
                              ss("Editing ${material["name"]}");
                            },
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
    );
  }

  Widget _buildCategoryBadge(String category) {
    Color color;
    switch (category) {
      case "Print":
        color = primaryColor;
        break;
      case "Digital":
        color = successColor;
        break;
      case "Social Media":
        color = warningColor;
        break;
      default:
        color = disabledColor;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusXs),
        border: Border.all(color: color.withAlpha(100)),
      ),
      child: Text(
        category,
        style: TextStyle(
          fontSize: 9,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildTypeBadge(String type) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
      decoration: BoxDecoration(
        color: secondaryColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusXs),
        border: Border.all(color: secondaryColor.withAlpha(100)),
      ),
      child: Text(
        type,
        style: TextStyle(
          fontSize: 9,
          color: secondaryColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildMaterialInfo(Map<String, dynamic> material) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        color: disabledColor.withAlpha(30),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Format:",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              Text(
                "${material["format"]}",
                style: TextStyle(
                  fontSize: 11,
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 2),
          Row(
            children: [
              Text(
                "Dimensions:",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              Text(
                "${material["dimensions"]}",
                style: TextStyle(
                  fontSize: 11,
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Ready":
        return successColor;
      case "In Progress":
        return warningColor;
      case "In Review":
        return infoColor;
      case "Draft":
        return disabledColor;
      default:
        return disabledColor;
    }
  }

  Widget _buildTemplatesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          Text(
            "Material Templates",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Choose from pre-designed template packages",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: templates.map((template) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radiusMd),
                        topRight: Radius.circular(radiusMd),
                      ),
                      child: Image.network(
                        "${template["preview"]}",
                        width: double.infinity,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${template["name"]}",
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
                                  color: infoColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                  border: Border.all(color: infoColor.withAlpha(100)),
                                ),
                                child: Text(
                                  "${template["items"]} items",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: infoColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${template["category"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: secondaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${template["description"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Includes:",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Wrap(
                            spacing: spXs,
                            runSpacing: spXs,
                            children: (template["includes"] as List).map<Widget>((item) {
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  item,
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: primaryColor,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          SizedBox(height: spSm),
                          Container(
                            width: double.infinity,
                            child: QButton(
                              label: "Use Template",
                              size: bs.sm,
                              onPressed: () {
                                ss("Using ${template["name"]} template");
                              },
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
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: [
          _buildDownloadAnalytics(),
          SizedBox(height: spMd),
          _buildMaterialPerformance(),
          SizedBox(height: spMd),
          _buildUsageStatistics(),
        ],
      ),
    );
  }

  Widget _buildDownloadAnalytics() {
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
          Text(
            "Download Analytics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.trending_up,
                    color: primaryColor,
                    size: 32,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Download Trends Chart",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMaterialPerformance() {
    List<Map<String, dynamic>> topMaterials = materials
        .where((m) => m["downloads"] > 50)
        .toList()
      ..sort((a, b) => (b["downloads"] as int).compareTo(a["downloads"] as int));

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
          Text(
            "Top Performing Materials",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...topMaterials.take(5).map((material) {
            return Container(
              margin: EdgeInsets.only(bottom: spXs),
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusXs),
                    child: Image.network(
                      "${material["preview"]}",
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${material["name"]}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${material["type"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "${material["downloads"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  SizedBox(width: spXs),
                  Icon(Icons.download, color: successColor, size: 16),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildUsageStatistics() {
    Map<String, int> categoryStats = {};
    Map<String, int> formatStats = {};
    
    for (var material in materials) {
      String category = material["category"];
      String format = material["format"];
      categoryStats[category] = (categoryStats[category] ?? 0) + 1;
      formatStats[format] = (formatStats[format] ?? 0) + 1;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "By Category",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                ...categoryStats.entries.map((entry) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spXs),
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: secondaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            entry.key,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: secondaryColor,
                            ),
                          ),
                        ),
                        Text(
                          "${entry.value}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
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
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "By Format",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                ...formatStats.entries.map((entry) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spXs),
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            entry.key,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: infoColor,
                            ),
                          ),
                        ),
                        Text(
                          "${entry.value}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
