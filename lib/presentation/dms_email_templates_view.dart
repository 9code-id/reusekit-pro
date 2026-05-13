import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsEmailTemplatesView extends StatefulWidget {
  const DmsEmailTemplatesView({super.key});

  @override
  State<DmsEmailTemplatesView> createState() => _DmsEmailTemplatesViewState();
}

class _DmsEmailTemplatesViewState extends State<DmsEmailTemplatesView> {
  String templateName = "";
  String selectedCategory = "newsletter";
  String selectedStyle = "modern";
  String searchQuery = "";
  String filterCategory = "all";
  String selectedTemplate = "";
  bool isEditing = false;

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "Newsletter", "value": "newsletter"},
    {"label": "Promotional", "value": "promotional"},
    {"label": "Welcome Email", "value": "welcome"},
    {"label": "Abandoned Cart", "value": "cart"},
    {"label": "Event Invitation", "value": "event"},
    {"label": "Thank You", "value": "thankyou"}
  ];

  List<Map<String, dynamic>> styleOptions = [
    {"label": "Modern", "value": "modern"},
    {"label": "Classic", "value": "classic"},
    {"label": "Minimalist", "value": "minimalist"},
    {"label": "Creative", "value": "creative"}
  ];

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Templates", "value": "all"},
    {"label": "Newsletter", "value": "newsletter"},
    {"label": "Promotional", "value": "promotional"},
    {"label": "Welcome Email", "value": "welcome"},
    {"label": "Abandoned Cart", "value": "cart"},
    {"label": "Event Invitation", "value": "event"}
  ];

  List<Map<String, dynamic>> templates = [
    {
      "id": "tmp1",
      "name": "Summer Newsletter Template",
      "category": "Newsletter",
      "style": "Modern",
      "description": "Bright and engaging newsletter template for summer campaigns",
      "thumbnail": "https://picsum.photos/300/200?random=1&keyword=email",
      "createdDate": "2024-06-15",
      "lastUsed": "2024-06-18",
      "usageCount": 12,
      "status": "Published",
      "openRate": 26.8,
      "clickRate": 4.2,
      "tags": ["Summer", "Newsletter", "Seasonal"]
    },
    {
      "id": "tmp2",
      "name": "Product Launch Template",
      "category": "Promotional",
      "style": "Modern",
      "description": "Professional template for announcing new products and features",
      "thumbnail": "https://picsum.photos/300/200?random=2&keyword=product",
      "createdDate": "2024-06-10",
      "lastUsed": "2024-06-15",
      "usageCount": 8,
      "status": "Published",
      "openRate": 28.5,
      "clickRate": 5.8,
      "tags": ["Product", "Launch", "Announcement"]
    },
    {
      "id": "tmp3",
      "name": "Welcome Series Template",
      "category": "Welcome Email",
      "style": "Classic",
      "description": "Warm and inviting template for welcoming new subscribers",
      "thumbnail": "https://picsum.photos/300/200?random=3&keyword=welcome",
      "createdDate": "2024-05-20",
      "lastUsed": "2024-06-17",
      "usageCount": 25,
      "status": "Published",
      "openRate": 42.1,
      "clickRate": 7.3,
      "tags": ["Welcome", "Onboarding", "New User"]
    },
    {
      "id": "tmp4",
      "name": "Abandoned Cart Recovery",
      "category": "Abandoned Cart",
      "style": "Minimalist",
      "description": "Simple and effective template for cart abandonment campaigns",
      "thumbnail": "https://picsum.photos/300/200?random=4&keyword=cart",
      "createdDate": "2024-05-15",
      "lastUsed": "2024-06-18",
      "usageCount": 18,
      "status": "Published",
      "openRate": 35.2,
      "clickRate": 12.8,
      "tags": ["Cart", "Recovery", "Ecommerce"]
    },
    {
      "id": "tmp5",
      "name": "Event Invitation Template",
      "category": "Event Invitation",
      "style": "Creative",
      "description": "Eye-catching template for event invitations and announcements",
      "thumbnail": "https://picsum.photos/300/200?random=5&keyword=event",
      "createdDate": "2024-06-01",
      "lastUsed": "2024-06-12",
      "usageCount": 6,
      "status": "Draft",
      "openRate": 0,
      "clickRate": 0,
      "tags": ["Event", "Invitation", "RSVP"]
    },
    {
      "id": "tmp6",
      "name": "Black Friday Sale Template",
      "category": "Promotional",
      "style": "Modern",
      "description": "High-converting template for special sales and promotions",
      "thumbnail": "https://picsum.photos/300/200?random=6&keyword=sale",
      "createdDate": "2024-05-25",
      "lastUsed": "2024-06-08",
      "usageCount": 15,
      "status": "Published",
      "openRate": 31.7,
      "clickRate": 8.9,
      "tags": ["Sale", "Promotion", "Black Friday"]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Email Templates"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showTemplateCreator();
            },
          ),
          IconButton(
            icon: Icon(Icons.design_services),
            onPressed: () {
              ss("Opening template designer");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildHeader(),
            _buildTemplateCreator(),
            _buildTemplateFilters(),
            _buildTemplateGrid(),
            _buildTemplateStats(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.design_services,
                color: Colors.white,
                size: 32,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email Templates",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Create and manage beautiful email templates",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(230),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildMetricCard("Total Templates", "15", Icons.design_services),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildMetricCard("Published", "12", Icons.publish),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildMetricCard("Avg. Open Rate", "32.1%", Icons.mail),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(26),
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
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              color: Colors.white.withAlpha(204),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTemplateCreator() {
    return Container(
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
              Icon(
                Icons.add_circle,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Create New Template",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QTextField(
            label: "Template Name",
            value: templateName,
            hint: "Enter descriptive template name",
            onChanged: (value) {
              templateName = value;
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
                  label: "Style",
                  items: styleOptions,
                  value: selectedStyle,
                  onChanged: (value, label) {
                    selectedStyle = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Create from Scratch",
                  size: bs.md,
                  onPressed: () {
                    if (templateName.isNotEmpty) {
                      ss("Creating template: $templateName");
                      _resetCreatorForm();
                    } else {
                      se("Please enter template name");
                    }
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Browse Gallery",
                  size: bs.md,
                  onPressed: () {
                    si("Opening template gallery");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTemplateFilters() {
    return Container(
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
              Icon(
                Icons.filter_list,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Filter Templates",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search Templates",
                  value: searchQuery,
                  hint: "Search by name or tags",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: filterOptions,
                  value: filterCategory,
                  onChanged: (value, label) {
                    filterCategory = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTemplateGrid() {
    List<Map<String, dynamic>> filteredTemplates = templates.where((template) {
      bool matchesSearch = searchQuery.isEmpty || 
          template["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          (template["tags"] as List).any((tag) => tag.toString().toLowerCase().contains(searchQuery.toLowerCase()));
      
      bool matchesCategory = filterCategory == "all" || 
          template["category"].toString().toLowerCase() == filterCategory.toLowerCase();
      
      return matchesSearch && matchesCategory;
    }).toList();

    return Container(
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
              Icon(
                Icons.grid_view,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Templates (${filteredTemplates.length})",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ResponsiveGridView(
            minItemWidth: 200,
            children: filteredTemplates.map((template) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: template["status"] == "Published" 
                        ? successColor 
                        : disabledColor,
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radiusSm),
                          topRight: Radius.circular(radiusSm),
                        ),
                        image: DecorationImage(
                          image: NetworkImage("${template["thumbnail"]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: spXs,
                            right: spXs,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: template["status"] == "Published" 
                                    ? successColor 
                                    : warningColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${template["status"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spSm,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Text(
                                "${template["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${template["category"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "•",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${template["style"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${template["description"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          if (template["status"] == "Published") ...[
                            Row(
                              children: [
                                Expanded(
                                  child: _buildTemplateMetric(
                                    "Used", 
                                    "${template["usageCount"]}x"
                                  ),
                                ),
                                Expanded(
                                  child: _buildTemplateMetric(
                                    "Open Rate", 
                                    "${(template["openRate"] as double).toStringAsFixed(1)}%"
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildTemplateMetric(
                                    "Click Rate", 
                                    "${(template["clickRate"] as double).toStringAsFixed(1)}%"
                                  ),
                                ),
                                Expanded(
                                  child: _buildTemplateMetric(
                                    "Last Used", 
                                    "${template["lastUsed"]}"
                                  ),
                                ),
                              ],
                            ),
                          ],
                          Wrap(
                            spacing: spXs,
                            runSpacing: spXs,
                            children: (template["tags"] as List).take(3).map((tag) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: infoColor.withAlpha(26),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "$tag",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: infoColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "Use Template",
                                  size: bs.sm,
                                  onPressed: () {
                                    ss("Using template: ${template["name"]}");
                                  },
                                ),
                              ),
                              SizedBox(width: spSm),
                              QButton(
                                icon: Icons.more_vert,
                                size: bs.sm,
                                onPressed: () {
                                  _showTemplateOptions(template);
                                },
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
    );
  }

  Widget _buildTemplateMetric(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 2,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildTemplateStats() {
    return Container(
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
              Icon(
                Icons.analytics,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Template Performance",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ResponsiveGridView(
            minItemWidth: 200,
            children: [
              _buildStatsCard(
                "Top Performing",
                "Welcome Series Template",
                "42.1% open rate",
                Icons.trending_up,
                successColor,
              ),
              _buildStatsCard(
                "Most Used",
                "Summer Newsletter Template",
                "Used 25 times",
                Icons.favorite,
                infoColor,
              ),
              _buildStatsCard(
                "Highest Revenue",
                "Abandoned Cart Recovery",
                "\$15.2K generated",
                Icons.attach_money,
                warningColor,
              ),
              _buildStatsCard(
                "Best Click Rate",
                "Product Launch Template",
                "12.8% click rate",
                Icons.mouse,
                primaryColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard(String title, String template, String metric, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: color.withAlpha(26),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: color.withAlpha(51),
          width: 1,
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 20,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          Text(
            template,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
          Text(
            metric,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  void _showTemplateCreator() {
    ss("Opening advanced template creator");
  }

  void _showTemplateOptions(Map<String, dynamic> template) {
    si("Template options for ${template["name"]}");
  }

  void _resetCreatorForm() {
    templateName = "";
    selectedCategory = "newsletter";
    selectedStyle = "modern";
    setState(() {});
  }
}
