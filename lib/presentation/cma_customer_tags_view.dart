import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaCustomerTagsView extends StatefulWidget {
  const CmaCustomerTagsView({super.key});

  @override
  State<CmaCustomerTagsView> createState() => _CmaCustomerTagsViewState();
}

class _CmaCustomerTagsViewState extends State<CmaCustomerTagsView> {
  String searchQuery = "";
  String selectedCategory = "";
  bool showCreateDialog = false;
  String newTagName = "";
  String newTagDescription = "";
  String selectedTagColor = "#2196F3";
  String selectedTagCategory = "";

  List<Map<String, dynamic>> tagCategories = [
    {"label": "All Categories", "value": ""},
    {"label": "Behavior", "value": "behavior"},
    {"label": "Value", "value": "value"},
    {"label": "Status", "value": "status"},
    {"label": "Preference", "value": "preference"},
    {"label": "Risk", "value": "risk"},
  ];

  List<Map<String, dynamic>> tags = [
    {
      "id": "1",
      "name": "High Value",
      "description": "Customers with high lifetime value and significant revenue contribution",
      "color": "#4CAF50",
      "category": "value",
      "customerCount": 234,
      "totalRevenue": 4500000.0,
      "avgOrderValue": 19230.0,
      "isActive": true,
      "createdDate": "2024-10-15",
      "lastUsed": "2024-12-15",
    },
    {
      "id": "2",
      "name": "Loyal Customer",
      "description": "Long-term customers with consistent purchasing patterns",
      "color": "#2196F3",
      "category": "behavior",
      "customerCount": 567,
      "totalRevenue": 3200000.0,
      "avgOrderValue": 5643.0,
      "isActive": true,
      "createdDate": "2024-09-20",
      "lastUsed": "2024-12-14",
    },
    {
      "id": "3",
      "name": "New Customer",
      "description": "Recently acquired customers within first 90 days",
      "color": "#00BCD4",
      "category": "status",
      "customerCount": 189,
      "totalRevenue": 456000.0,
      "avgOrderValue": 2413.0,
      "isActive": true,
      "createdDate": "2024-11-01",
      "lastUsed": "2024-12-15",
    },
    {
      "id": "4",
      "name": "At Risk",
      "description": "Customers showing signs of potential churn or reduced engagement",
      "color": "#FF5722",
      "category": "risk",
      "customerCount": 89,
      "totalRevenue": 234000.0,
      "avgOrderValue": 2629.0,
      "isActive": true,
      "createdDate": "2024-08-10",
      "lastUsed": "2024-12-13",
    },
    {
      "id": "5",
      "name": "Premium Service",
      "description": "Customers who prefer premium service options",
      "color": "#9C27B0",
      "category": "preference",
      "customerCount": 145,
      "totalRevenue": 1890000.0,
      "avgOrderValue": 13034.0,
      "isActive": true,
      "createdDate": "2024-07-25",
      "lastUsed": "2024-12-12",
    },
    {
      "id": "6",
      "name": "Bulk Buyer",
      "description": "Customers who typically make large quantity purchases",
      "color": "#FF9800",
      "category": "behavior",
      "customerCount": 67,
      "totalRevenue": 2340000.0,
      "avgOrderValue": 34925.0,
      "isActive": true,
      "createdDate": "2024-06-15",
      "lastUsed": "2024-12-11",
    },
    {
      "id": "7",
      "name": "Seasonal Buyer",
      "description": "Customers with seasonal purchasing patterns",
      "color": "#795548",
      "category": "behavior",
      "customerCount": 345,
      "totalRevenue": 890000.0,
      "avgOrderValue": 2580.0,
      "isActive": true,
      "createdDate": "2024-05-30",
      "lastUsed": "2024-11-28",
    },
    {
      "id": "8",
      "name": "Price Sensitive",
      "description": "Customers who are highly responsive to pricing and discounts",
      "color": "#607D8B",
      "category": "preference",
      "customerCount": 456,
      "totalRevenue": 1230000.0,
      "avgOrderValue": 2697.0,
      "isActive": true,
      "createdDate": "2024-04-12",
      "lastUsed": "2024-12-10",
    },
    {
      "id": "9",
      "name": "Inactive",
      "description": "Customers with no activity in the past 6 months",
      "color": "#757575",
      "category": "status",
      "customerCount": 123,
      "totalRevenue": 0.0,
      "avgOrderValue": 0.0,
      "isActive": false,
      "createdDate": "2024-03-20",
      "lastUsed": "2024-06-15",
    },
  ];

  List<String> colorOptions = [
    "#2196F3", "#4CAF50", "#FF9800", "#F44336", "#9C27B0",
    "#00BCD4", "#FFC107", "#795548", "#607D8B", "#E91E63",
    "#3F51B5", "#8BC34A", "#FF5722", "#673AB7", "#009688"
  ];

  List<Map<String, dynamic>> get filteredTags {
    List<Map<String, dynamic>> filtered = tags;
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((tag) {
        return tag["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               tag["description"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }
    
    if (selectedCategory.isNotEmpty) {
      filtered = filtered.where((tag) => tag["category"] == selectedCategory).toList();
    }
    
    return filtered;
  }

  void _showCreateTagDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Create New Tag"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              QTextField(
                label: "Tag Name",
                value: newTagName,
                hint: "Enter descriptive tag name",
                onChanged: (value) {
                  newTagName = value;
                  setState(() {});
                },
              ),
              QMemoField(
                label: "Description",
                value: newTagDescription,
                hint: "Explain when this tag should be used",
                onChanged: (value) {
                  newTagDescription = value;
                  setState(() {});
                },
              ),
              QDropdownField(
                label: "Category",
                items: tagCategories.where((cat) => cat["value"].isNotEmpty).toList(),
                value: selectedTagCategory,
                onChanged: (value, label) {
                  selectedTagCategory = value;
                  setState(() {});
                },
              ),
              Text(
                "Select Color",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: disabledBoldColor,
                ),
              ),
              Wrap(
                spacing: spXs,
                runSpacing: spXs,
                children: colorOptions.map((color) {
                  return GestureDetector(
                    onTap: () {
                      selectedTagColor = color;
                      setState(() {});
                    },
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Color(int.parse(color.substring(1), radix: 16) + 0xFF000000),
                        borderRadius: BorderRadius.circular(radiusXs),
                        border: Border.all(
                          color: selectedTagColor == color ? primaryColor : Colors.transparent,
                          width: 3,
                        ),
                      ),
                      child: selectedTagColor == color 
                        ? Icon(Icons.check, color: Colors.white, size: 18)
                        : null,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _resetCreateDialog();
            },
            child: Text("Cancel"),
          ),
          QButton(
            label: "Create Tag",
            size: bs.sm,
            onPressed: () {
              if (newTagName.isNotEmpty && selectedTagCategory.isNotEmpty) {
                _createNewTag();
                Navigator.pop(context);
                _resetCreateDialog();
                ss("Tag created successfully");
              }
            },
          ),
        ],
      ),
    );
  }

  void _resetCreateDialog() {
    newTagName = "";
    newTagDescription = "";
    selectedTagCategory = "";
    selectedTagColor = "#2196F3";
  }

  void _createNewTag() {
    tags.add({
      "id": DateTime.now().millisecondsSinceEpoch.toString(),
      "name": newTagName,
      "description": newTagDescription,
      "color": selectedTagColor,
      "category": selectedTagCategory,
      "customerCount": 0,
      "totalRevenue": 0.0,
      "avgOrderValue": 0.0,
      "isActive": true,
      "createdDate": DateTime.now().toIso8601String().substring(0, 10),
      "lastUsed": DateTime.now().toIso8601String().substring(0, 10),
    });
    setState(() {});
  }

  void _deleteTag(String tagId) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this tag?");
    if (isConfirmed) {
      tags.removeWhere((tag) => tag["id"] == tagId);
      setState(() {});
      ss("Tag deleted successfully");
    }
  }

  Color _getColorFromHex(String hexColor) {
    return Color(int.parse(hexColor.substring(1), radix: 16) + 0xFF000000);
  }

  String _getCategoryLabel(String category) {
    switch (category) {
      case "behavior": return "Behavior";
      case "value": return "Value";
      case "status": return "Status";
      case "preference": return "Preference";
      case "risk": return "Risk";
      default: return "Other";
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "behavior": return infoColor;
      case "value": return successColor;
      case "status": return primaryColor;
      case "preference": return secondaryColor;
      case "risk": return dangerColor;
      default: return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, int> categoryStats = {};
    for (var tag in tags) {
      String category = tag["category"];
      categoryStats[category] = (categoryStats[category] ?? 0) + (tag["customerCount"] as int);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Tags"),
        actions: [
          IconButton(
            onPressed: _showCreateTagDialog,
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: primaryColor.withAlpha(100)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.local_offer,
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "Use tags to label customers for quick identification and targeted campaigns",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: QTextField(
                    label: "Search Tags",
                    value: searchQuery,
                    hint: "Search by name or description...",
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
                    items: tagCategories,
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            QHorizontalScroll(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: primaryColor.withAlpha(100)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${tags.where((t) => t["isActive"] == true).length}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Active Tags",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: successColor.withAlpha(100)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${((tags.map((t) => t["customerCount"] as int).reduce((a, b) => a + b)) / 1000).toStringAsFixed(1)}K",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Tagged Customers",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: infoColor.withAlpha(100)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "\$${((tags.map((t) => t["totalRevenue"] as double).reduce((a, b) => a + b)) / 1000000).toStringAsFixed(1)}M",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Total Revenue",
                        style: TextStyle(
                          fontSize: 12,
                          color: infoColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Wrap(
              spacing: spXs,
              runSpacing: spXs,
              children: categoryStats.entries.map((entry) {
                Color categoryColor = _getCategoryColor(entry.key);
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: categoryColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusXs),
                    border: Border.all(color: categoryColor.withAlpha(100)),
                  ),
                  child: Text(
                    "${_getCategoryLabel(entry.key)}: ${entry.value}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: categoryColor,
                    ),
                  ),
                );
              }).toList(),
            ),

            Column(
              spacing: spSm,
              children: filteredTags.map((tag) {
                Color tagColor = _getColorFromHex(tag["color"]);
                Color categoryColor = _getCategoryColor(tag["category"]);
                
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spSm,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: tagColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: categoryColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusXs),
                              border: Border.all(color: categoryColor.withAlpha(100)),
                            ),
                            child: Text(
                              _getCategoryLabel(tag["category"]),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: categoryColor,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "${tag["name"]}",
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
                              color: (tag["isActive"] as bool) ? successColor.withAlpha(30) : disabledColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              (tag["isActive"] as bool) ? "Active" : "Inactive",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: (tag["isActive"] as bool) ? successColor : disabledBoldColor,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          PopupMenuButton(
                            icon: Icon(Icons.more_vert, color: disabledBoldColor, size: 20),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                child: Row(
                                  children: [
                                    Icon(Icons.edit, size: 16),
                                    SizedBox(width: spXs),
                                    Text("Edit"),
                                  ],
                                ),
                                onTap: () {
                                  // Handle edit tag
                                },
                              ),
                              PopupMenuItem(
                                child: Row(
                                  children: [
                                    Icon(Icons.people, size: 16),
                                    SizedBox(width: spXs),
                                    Text("View Customers"),
                                  ],
                                ),
                                onTap: () {
                                  // Handle view customers with this tag
                                },
                              ),
                              PopupMenuItem(
                                child: Row(
                                  children: [
                                    Icon(Icons.delete, color: dangerColor, size: 16),
                                    SizedBox(width: spXs),
                                    Text("Delete", style: TextStyle(color: dangerColor)),
                                  ],
                                ),
                                onTap: () => _deleteTag(tag["id"]),
                              ),
                            ],
                          ),
                        ],
                      ),
                      
                      Text(
                        "${tag["description"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "${(tag["customerCount"] as int).toString()}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "Customers",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "\$${((tag["totalRevenue"] as double) / 1000).toStringAsFixed(0)}K",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
                                    ),
                                  ),
                                  Text(
                                    "Revenue",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: infoColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "\$${((tag["avgOrderValue"] as double)).currency}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: infoColor,
                                    ),
                                  ),
                                  Text(
                                    "Avg Order",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 14,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Created: ${DateTime.parse(tag["createdDate"]).dMMMy}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.access_time,
                            size: 14,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Last used: ${DateTime.parse(tag["lastUsed"]).dMMMy}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            if (filteredTags.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.local_offer_outlined,
                      size: 48,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No tags found",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try adjusting your search or create a new tag",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
