import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaJobTemplatesView extends StatefulWidget {
  const RhaJobTemplatesView({super.key});

  @override
  State<RhaJobTemplatesView> createState() => _RhaJobTemplatesViewState();
}

class _RhaJobTemplatesViewState extends State<RhaJobTemplatesView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedType = "All";
  
  List<Map<String, dynamic>> categoryItems = [
    {"label": "All", "value": "All"},
    {"label": "Technology", "value": "Technology"},
    {"label": "Marketing", "value": "Marketing"},
    {"label": "Sales", "value": "Sales"},
    {"label": "HR", "value": "HR"},
    {"label": "Finance", "value": "Finance"},
    {"label": "Healthcare", "value": "Healthcare"},
  ];
  
  List<Map<String, dynamic>> typeItems = [
    {"label": "All", "value": "All"},
    {"label": "Full Template", "value": "Full Template"},
    {"label": "Description Only", "value": "Description Only"},
    {"label": "Requirements Only", "value": "Requirements Only"},
    {"label": "Benefits Only", "value": "Benefits Only"},
  ];

  List<Map<String, dynamic>> jobTemplates = [
    {
      "id": "1",
      "name": "Senior Flutter Developer",
      "category": "Technology",
      "type": "Full Template",
      "description": "Complete template for hiring senior mobile app developers with Flutter expertise",
      "usageCount": 23,
      "lastUsed": "2024-06-15",
      "createdBy": "HR Team",
      "rating": 4.8,
      "featured": true,
      "sections": ["Job Summary", "Requirements", "Responsibilities", "Benefits"],
      "tags": ["Flutter", "Mobile", "Senior", "Full-time"],
    },
    {
      "id": "2",
      "name": "Digital Marketing Manager",
      "category": "Marketing",
      "type": "Full Template",
      "description": "Comprehensive template for marketing management positions",
      "usageCount": 18,
      "lastUsed": "2024-06-12",
      "createdBy": "Marketing Team",
      "rating": 4.6,
      "featured": false,
      "sections": ["Job Summary", "Requirements", "Responsibilities", "Benefits"],
      "tags": ["Marketing", "Manager", "Digital", "Full-time"],
    },
    {
      "id": "3",
      "name": "Sales Representative Template",
      "category": "Sales",
      "type": "Description Only",
      "description": "Standard description template for sales positions",
      "usageCount": 35,
      "lastUsed": "2024-06-10",
      "createdBy": "Sales Team",
      "rating": 4.4,
      "featured": true,
      "sections": ["Job Summary", "Responsibilities"],
      "tags": ["Sales", "Representative", "Commission", "Remote"],
    },
    {
      "id": "4",
      "name": "HR Specialist Requirements",
      "category": "HR",
      "type": "Requirements Only",
      "description": "Detailed requirements template for HR positions",
      "usageCount": 12,
      "lastUsed": "2024-06-08",
      "createdBy": "HR Team",
      "rating": 4.7,
      "featured": false,
      "sections": ["Requirements"],
      "tags": ["HR", "Specialist", "Experience", "Certification"],
    },
    {
      "id": "5",
      "name": "Tech Startup Benefits Package",
      "category": "Technology",
      "type": "Benefits Only",
      "description": "Competitive benefits template for technology companies",
      "usageCount": 41,
      "lastUsed": "2024-06-14",
      "createdBy": "Admin",
      "rating": 4.9,
      "featured": true,
      "sections": ["Benefits"],
      "tags": ["Benefits", "Startup", "Tech", "Competitive"],
    },
    {
      "id": "6",
      "name": "Healthcare Professional",
      "category": "Healthcare",
      "type": "Full Template",
      "description": "Complete template for healthcare and medical positions",
      "usageCount": 16,
      "lastUsed": "2024-06-06",
      "createdBy": "Healthcare Team",
      "rating": 4.5,
      "featured": false,
      "sections": ["Job Summary", "Requirements", "Responsibilities", "Benefits"],
      "tags": ["Healthcare", "Medical", "Professional", "Licensed"],
    },
  ];

  List<Map<String, dynamic>> get filteredTemplates {
    return jobTemplates.where((template) {
      bool matchesSearch = searchQuery.isEmpty ||
          (template["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (template["description"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "All" ||
          template["category"] == selectedCategory;
      
      bool matchesType = selectedType == "All" ||
          template["type"] == selectedType;
      
      return matchesSearch && matchesCategory && matchesType;
    }).toList();
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "Full Template":
        return primaryColor;
      case "Description Only":
        return infoColor;
      case "Requirements Only":
        return warningColor;
      case "Benefits Only":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Job Templates"),
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle_outline),
            onPressed: () {
              _showCreateTemplateDialog();
            },
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              // View template analytics
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filter Section
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.white,
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search templates...",
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
                      onPressed: () {
                        // Perform search
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Category",
                        items: categoryItems,
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
                        label: "Template Type",
                        items: typeItems,
                        value: selectedType,
                        onChanged: (value, label) {
                          selectedType = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Summary Section
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: primaryColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${jobTemplates.length}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Templates",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: successColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${jobTemplates.fold(0, (sum, t) => sum + (t["usageCount"] as int))}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Total Uses",
                          style: TextStyle(
                            color: successColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: warningColor.withAlpha(50)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${jobTemplates.where((t) => t["featured"] as bool).length}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Featured",
                          style: TextStyle(
                            color: warningColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Templates List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: filteredTemplates.length,
              itemBuilder: (context, index) {
                final template = filteredTemplates[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: (template["featured"] as bool)
                        ? Border.all(color: warningColor, width: 2)
                        : null,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      // Header Row
                      Row(
                        children: [
                          if (template["featured"] as bool)
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: warningColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "FEATURED",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          if (template["featured"] as bool) SizedBox(width: spXs),
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
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _getTypeColor("${template["type"]}")
                                  .withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${template["type"]}",
                              style: TextStyle(
                                color: _getTypeColor("${template["type"]}"),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Description
                      Text(
                        "${template["description"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),

                      // Category and Rating
                      Row(
                        children: [
                          Icon(
                            Icons.category,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${template["category"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Icon(
                            Icons.star,
                            size: 16,
                            color: warningColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${template["rating"]}",
                            style: TextStyle(
                              color: warningColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),

                      // Sections Included
                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs,
                        children: (template["sections"] as List).map((section) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "$section",
                              style: TextStyle(
                                color: infoColor,
                                fontSize: 10,
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                      // Tags
                      if ((template["tags"] as List).isNotEmpty)
                        Wrap(
                          spacing: spXs,
                          runSpacing: spXs,
                          children: (template["tags"] as List).map((tag) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "#$tag",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 10,
                                ),
                              ),
                            );
                          }).toList(),
                        ),

                      // Usage Statistics
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.group,
                                  size: 16,
                                  color: successColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Used ${template["usageCount"]} times",
                                  style: TextStyle(
                                    color: successColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Icon(
                                  Icons.access_time,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Last used: ${template["lastUsed"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // Created By and Actions
                      Row(
                        children: [
                          Text(
                            "Created by: ${template["createdBy"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                          Spacer(),
                          Row(
                            children: [
                              QButton(
                                label: "Use Template",
                                size: bs.sm,
                                onPressed: () {
                                  _useTemplate(template);
                                },
                              ),
                              SizedBox(width: spXs),
                              QButton(
                                icon: Icons.preview,
                                size: bs.sm,
                                onPressed: () {
                                  _showTemplatePreview(template);
                                },
                              ),
                              SizedBox(width: spXs),
                              QButton(
                                icon: Icons.more_vert,
                                size: bs.sm,
                                onPressed: () {
                                  _showTemplateActions(template);
                                },
                              ),
                            ],
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreateTemplateDialog();
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void _useTemplate(Map<String, dynamic> template) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Use Template"),
        content: Text("Apply \"${template["name"]}\" to a new job posting?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ss("Template applied to new job posting");
            },
            child: Text("Use Template"),
          ),
        ],
      ),
    );
  }

  void _showTemplatePreview(Map<String, dynamic> template) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Template Preview"),
        content: Container(
          width: double.maxFinite,
          height: 400,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "${template["name"]}",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Category: ${template["category"]} • Type: ${template["type"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: spSm),
                Text("${template["description"]}"),
                SizedBox(height: spSm),
                Text(
                  "Included Sections:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                ...(template["sections"] as List).map((section) {
                  return Text("• $section");
                }).toList(),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }

  void _showTemplateActions(Map<String, dynamic> template) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            Text(
              "Template Actions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text("Edit Template"),
              onTap: () {
                Navigator.pop(context);
                _showEditTemplateDialog(template);
              },
            ),
            ListTile(
              leading: Icon(Icons.copy),
              title: Text("Duplicate Template"),
              onTap: () {
                Navigator.pop(context);
                ss("Template duplicated");
              },
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text("Share Template"),
              onTap: () {
                Navigator.pop(context);
                ss("Template shared");
              },
            ),
            ListTile(
              leading: Icon(Icons.delete, color: dangerColor),
              title: Text("Delete Template", style: TextStyle(color: dangerColor)),
              onTap: () async {
                Navigator.pop(context);
                bool isConfirmed = await confirm("Are you sure you want to delete this template?");
                if (isConfirmed) {
                  ss("Template deleted");
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showCreateTemplateDialog() {
    String templateName = "";
    String category = "Technology";
    String type = "Full Template";
    String description = "";

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Create New Template"),
        content: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              QTextField(
                label: "Template Name",
                value: templateName,
                onChanged: (value) => templateName = value,
              ),
              QDropdownField(
                label: "Category",
                items: categoryItems.where((item) => item["value"] != "All").toList(),
                value: category,
                onChanged: (value, label) => category = value,
              ),
              QDropdownField(
                label: "Template Type",
                items: typeItems.where((item) => item["value"] != "All").toList(),
                value: type,
                onChanged: (value, label) => type = value,
              ),
              QMemoField(
                label: "Description",
                value: description,
                onChanged: (value) => description = value,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              if (templateName.isNotEmpty && description.isNotEmpty) {
                Navigator.pop(context);
                ss("Template created successfully");
              }
            },
            child: Text("Create"),
          ),
        ],
      ),
    );
  }

  void _showEditTemplateDialog(Map<String, dynamic> template) {
    String templateName = template["name"];
    String category = template["category"];
    String type = template["type"];
    String description = template["description"];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Template"),
        content: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              QTextField(
                label: "Template Name",
                value: templateName,
                onChanged: (value) => templateName = value,
              ),
              QDropdownField(
                label: "Category",
                items: categoryItems.where((item) => item["value"] != "All").toList(),
                value: category,
                onChanged: (value, label) => category = value,
              ),
              QDropdownField(
                label: "Template Type",
                items: typeItems.where((item) => item["value"] != "All").toList(),
                value: type,
                onChanged: (value, label) => type = value,
              ),
              QMemoField(
                label: "Description",
                value: description,
                onChanged: (value) => description = value,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ss("Template updated successfully");
            },
            child: Text("Update"),
          ),
        ],
      ),
    );
  }
}
