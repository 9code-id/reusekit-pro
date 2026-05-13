import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaJobCategoriesView extends StatefulWidget {
  const RhaJobCategoriesView({super.key});

  @override
  State<RhaJobCategoriesView> createState() => _RhaJobCategoriesViewState();
}

class _RhaJobCategoriesViewState extends State<RhaJobCategoriesView> {
  String searchQuery = "";
  String selectedParentCategory = "All";
  
  List<Map<String, dynamic>> parentCategoryItems = [
    {"label": "All", "value": "All"},
    {"label": "Technology", "value": "Technology"},
    {"label": "Business", "value": "Business"},
    {"label": "Creative", "value": "Creative"},
    {"label": "Healthcare", "value": "Healthcare"},
    {"label": "Education", "value": "Education"},
  ];

  List<Map<String, dynamic>> jobCategories = [
    {
      "id": "1",
      "name": "Software Development",
      "parent": "Technology",
      "description": "Full-stack development, mobile apps, web development",
      "jobCount": 45,
      "subCategories": ["Frontend Development", "Backend Development", "Mobile Development", "Full-stack Development"],
      "trending": true,
      "color": "#2196F3",
    },
    {
      "id": "2",
      "name": "Data Science",
      "parent": "Technology",
      "description": "Machine learning, data analysis, AI development",
      "jobCount": 28,
      "subCategories": ["Machine Learning", "Data Analysis", "AI Development", "Data Engineering"],
      "trending": true,
      "color": "#4CAF50",
    },
    {
      "id": "3",
      "name": "Digital Marketing",
      "parent": "Business",
      "description": "SEO, social media, content marketing, advertising",
      "jobCount": 32,
      "subCategories": ["SEO Specialist", "Social Media Manager", "Content Marketing", "PPC Advertising"],
      "trending": false,
      "color": "#FF9800",
    },
    {
      "id": "4",
      "name": "Product Management",
      "parent": "Business",
      "description": "Product strategy, roadmap planning, user research",
      "jobCount": 19,
      "subCategories": ["Product Manager", "Product Owner", "Product Analyst", "UX Research"],
      "trending": true,
      "color": "#9C27B0",
    },
    {
      "id": "5",
      "name": "Graphic Design",
      "parent": "Creative",
      "description": "Visual design, branding, illustration, UI design",
      "jobCount": 24,
      "subCategories": ["UI/UX Designer", "Brand Designer", "Illustrator", "Motion Graphics"],
      "trending": false,
      "color": "#E91E63",
    },
    {
      "id": "6",
      "name": "Sales",
      "parent": "Business",
      "description": "Business development, account management, lead generation",
      "jobCount": 41,
      "subCategories": ["Sales Representative", "Account Manager", "Business Development", "Sales Manager"],
      "trending": false,
      "color": "#607D8B",
    },
    {
      "id": "7",
      "name": "Nursing",
      "parent": "Healthcare",
      "description": "Patient care, medical assistance, healthcare support",
      "jobCount": 37,
      "subCategories": ["Registered Nurse", "Licensed Practical Nurse", "Nurse Practitioner", "Healthcare Assistant"],
      "trending": true,
      "color": "#795548",
    },
    {
      "id": "8",
      "name": "Teaching",
      "parent": "Education",
      "description": "K-12 education, higher education, training and development",
      "jobCount": 29,
      "subCategories": ["Elementary Teacher", "High School Teacher", "College Professor", "Corporate Trainer"],
      "trending": false,
      "color": "#3F51B5",
    },
  ];

  Color _getCategoryColor(String colorHex) {
    return Color(int.parse(colorHex.replaceFirst('#', '0xFF')));
  }

  List<Map<String, dynamic>> get filteredCategories {
    return jobCategories.where((category) {
      bool matchesSearch = searchQuery.isEmpty ||
          (category["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (category["description"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesParent = selectedParentCategory == "All" ||
          category["parent"] == selectedParentCategory;
      
      return matchesSearch && matchesParent;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Job Categories"),
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle_outline),
            onPressed: () {
              _showAddCategoryDialog();
            },
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              // View category analytics
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
                        label: "Search categories...",
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
                QDropdownField(
                  label: "Filter by Parent Category",
                  items: parentCategoryItems,
                  value: selectedParentCategory,
                  onChanged: (value, label) {
                    selectedParentCategory = value;
                    setState(() {});
                  },
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
                          "${jobCategories.length}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Categories",
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
                          "${jobCategories.fold(0, (sum, cat) => sum + (cat["jobCount"] as int))}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Total Jobs",
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
                          "${jobCategories.where((cat) => cat["trending"] as bool).length}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Trending",
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

          // Categories Grid
          Expanded(
            child: ResponsiveGridView(
              padding: EdgeInsets.all(spMd),
              minItemWidth: 200,
              children: filteredCategories.map((category) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: (category["trending"] as bool)
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
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: _getCategoryColor("${category["color"]}").withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              _getCategoryIcon("${category["name"]}"),
                              color: _getCategoryColor("${category["color"]}"),
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${category["name"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${category["parent"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (category["trending"] as bool)
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
                                "TRENDING",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),

                      // Description
                      Text(
                        "${category["description"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),

                      // Job Count
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${category["jobCount"]} active jobs",
                          style: TextStyle(
                            color: successColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      // Sub-categories
                      Text(
                        "Sub-categories:",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: primaryColor,
                        ),
                      ),
                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs,
                        children: (category["subCategories"] as List).take(3).map((sub) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: _getCategoryColor("${category["color"]}").withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "$sub",
                              style: TextStyle(
                                color: _getCategoryColor("${category["color"]}"),
                                fontSize: 10,
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                      // Action Buttons
                      Row(
                        spacing: spXs,
                        children: [
                          Expanded(
                            child: QButton(
                              label: "View Jobs",
                              size: bs.sm,
                              onPressed: () {
                                // View jobs in this category
                              },
                            ),
                          ),
                          QButton(
                            icon: Icons.edit,
                            size: bs.sm,
                            onPressed: () {
                              _showEditCategoryDialog(category);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddCategoryDialog();
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String categoryName) {
    switch (categoryName) {
      case "Software Development":
        return Icons.code;
      case "Data Science":
        return Icons.analytics;
      case "Digital Marketing":
        return Icons.campaign;
      case "Product Management":
        return Icons.inventory;
      case "Graphic Design":
        return Icons.palette;
      case "Sales":
        return Icons.trending_up;
      case "Nursing":
        return Icons.local_hospital;
      case "Teaching":
        return Icons.school;
      default:
        return Icons.work;
    }
  }

  void _showAddCategoryDialog() {
    String categoryName = "";
    String parentCategory = "Technology";
    String description = "";
    String color = "#2196F3";

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add New Category"),
        content: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              QTextField(
                label: "Category Name",
                value: categoryName,
                onChanged: (value) => categoryName = value,
              ),
              QDropdownField(
                label: "Parent Category",
                items: parentCategoryItems.where((item) => item["value"] != "All").toList(),
                value: parentCategory,
                onChanged: (value, label) => parentCategory = value,
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
              if (categoryName.isNotEmpty && description.isNotEmpty) {
                Navigator.pop(context);
                ss("Category added successfully");
              }
            },
            child: Text("Add"),
          ),
        ],
      ),
    );
  }

  void _showEditCategoryDialog(Map<String, dynamic> category) {
    String categoryName = category["name"];
    String parentCategory = category["parent"];
    String description = category["description"];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Category"),
        content: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              QTextField(
                label: "Category Name",
                value: categoryName,
                onChanged: (value) => categoryName = value,
              ),
              QDropdownField(
                label: "Parent Category",
                items: parentCategoryItems.where((item) => item["value"] != "All").toList(),
                value: parentCategory,
                onChanged: (value, label) => parentCategory = value,
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
              ss("Category updated successfully");
            },
            child: Text("Update"),
          ),
        ],
      ),
    );
  }
}
