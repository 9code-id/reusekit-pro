import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaCategoryManagementView extends StatefulWidget {
  const FmaCategoryManagementView({super.key});

  @override
  State<FmaCategoryManagementView> createState() => _FmaCategoryManagementViewState();
}

class _FmaCategoryManagementViewState extends State<FmaCategoryManagementView> {
  String searchQuery = "";
  String selectedFilter = "All";
  bool isAddingCategory = false;
  
  String newCategoryName = "";
  String newCategoryDescription = "";
  String newCategoryColor = "Blue";
  String newCategoryIcon = "restaurant";
  bool newCategoryActive = true;
  
  List<Map<String, dynamic>> categories = [
    {
      "id": "1",
      "name": "Main Course",
      "description": "Primary dishes and entrees",
      "color": "Blue",
      "icon": "restaurant",
      "itemCount": 15,
      "isActive": true,
      "sortOrder": 1,
    },
    {
      "id": "2", 
      "name": "Appetizers",
      "description": "Starters and small plates",
      "color": "Green",
      "icon": "local_dining",
      "itemCount": 8,
      "isActive": true,
      "sortOrder": 2,
    },
    {
      "id": "3",
      "name": "Desserts",
      "description": "Sweet treats and desserts",
      "color": "Pink", 
      "icon": "cake",
      "itemCount": 6,
      "isActive": true,
      "sortOrder": 3,
    },
    {
      "id": "4",
      "name": "Beverages",
      "description": "Drinks and refreshments",
      "color": "Orange",
      "icon": "local_cafe",
      "itemCount": 12,
      "isActive": true,
      "sortOrder": 4,
    },
    {
      "id": "5",
      "name": "Side Dishes",
      "description": "Complementary sides",
      "color": "Purple",
      "icon": "rice_bowl",
      "itemCount": 4,
      "isActive": false,
      "sortOrder": 5,
    },
  ];

  List<Map<String, dynamic>> filterItems = [
    {"label": "All Categories", "value": "All"},
    {"label": "Active Only", "value": "Active"},
    {"label": "Inactive Only", "value": "Inactive"},
  ];

  List<Map<String, dynamic>> colorOptions = [
    {"label": "Blue", "value": "Blue"},
    {"label": "Green", "value": "Green"},
    {"label": "Pink", "value": "Pink"},
    {"label": "Orange", "value": "Orange"},
    {"label": "Purple", "value": "Purple"},
    {"label": "Red", "value": "Red"},
  ];

  List<Map<String, dynamic>> iconOptions = [
    {"label": "Restaurant", "value": "restaurant"},
    {"label": "Local Dining", "value": "local_dining"},
    {"label": "Cake", "value": "cake"},
    {"label": "Local Cafe", "value": "local_cafe"},
    {"label": "Rice Bowl", "value": "rice_bowl"},
    {"label": "Fastfood", "value": "fastfood"},
  ];

  List<Map<String, dynamic>> get filteredCategories {
    var filtered = categories.where((category) {
      bool matchesSearch = category["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          category["description"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesFilter = selectedFilter == "All" ||
                          (selectedFilter == "Active" && category["isActive"] == true) ||
                          (selectedFilter == "Inactive" && category["isActive"] == false);
      
      return matchesSearch && matchesFilter;
    }).toList();
    
    filtered.sort((a, b) => (a["sortOrder"] as int).compareTo(b["sortOrder"] as int));
    return filtered;
  }

  Color getCategoryColor(String colorName) {
    switch (colorName) {
      case "Blue": return Colors.blue;
      case "Green": return Colors.green;
      case "Pink": return Colors.pink;
      case "Orange": return Colors.orange;
      case "Purple": return Colors.purple;
      case "Red": return Colors.red;
      default: return primaryColor;
    }
  }

  IconData getCategoryIcon(String iconName) {
    switch (iconName) {
      case "restaurant": return Icons.restaurant;
      case "local_dining": return Icons.local_dining;
      case "cake": return Icons.cake;
      case "local_cafe": return Icons.local_cafe;
      case "rice_bowl": return Icons.rice_bowl;
      case "fastfood": return Icons.fastfood;
      default: return Icons.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Category Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              isAddingCategory = true;
              setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filter
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search Categories",
                    value: searchQuery,
                    hint: "Search by name or description",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                Container(
                  width: 150,
                  child: QDropdownField(
                    label: "Filter",
                    items: filterItems,
                    value: selectedFilter,
                    onChanged: (value, label) {
                      selectedFilter = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Add Category Form
            if (isAddingCategory)
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border.all(color: primaryColor.withAlpha(50)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.add_circle, color: primaryColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Add New Category",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            isAddingCategory = false;
                            newCategoryName = "";
                            newCategoryDescription = "";
                            newCategoryColor = "Blue";
                            newCategoryIcon = "restaurant";
                            newCategoryActive = true;
                            setState(() {});
                          },
                          child: Icon(Icons.close, color: disabledBoldColor, size: 20),
                        ),
                      ],
                    ),
                    QTextField(
                      label: "Category Name",
                      value: newCategoryName,
                      validator: Validator.required,
                      onChanged: (value) {
                        newCategoryName = value;
                        setState(() {});
                      },
                    ),
                    QMemoField(
                      label: "Description",
                      value: newCategoryDescription,
                      hint: "Brief description of this category",
                      onChanged: (value) {
                        newCategoryDescription = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Color",
                            items: colorOptions,
                            value: newCategoryColor,
                            onChanged: (value, label) {
                              newCategoryColor = value;
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(
                          child: QDropdownField(
                            label: "Icon",
                            items: iconOptions,
                            value: newCategoryIcon,
                            onChanged: (value, label) {
                              newCategoryIcon = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Active Category",
                          "value": true,
                          "checked": newCategoryActive,
                        }
                      ],
                      value: [if (newCategoryActive) {"label": "Active Category", "value": true, "checked": true}],
                      onChanged: (values, ids) {
                        newCategoryActive = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Add Category",
                            onPressed: () {
                              if (newCategoryName.isNotEmpty) {
                                categories.add({
                                  "id": DateTime.now().millisecondsSinceEpoch.toString(),
                                  "name": newCategoryName,
                                  "description": newCategoryDescription,
                                  "color": newCategoryColor,
                                  "icon": newCategoryIcon,
                                  "itemCount": 0,
                                  "isActive": newCategoryActive,
                                  "sortOrder": categories.length + 1,
                                });
                                isAddingCategory = false;
                                newCategoryName = "";
                                newCategoryDescription = "";
                                newCategoryColor = "Blue";
                                newCategoryIcon = "restaurant";
                                newCategoryActive = true;
                                ss("Category added successfully");
                                setState(() {});
                              }
                            },
                          ),
                        ),
                        QButton(
                          label: "Cancel",
                          color: disabledBoldColor,
                          size: bs.sm,
                          onPressed: () {
                            isAddingCategory = false;
                            newCategoryName = "";
                            newCategoryDescription = "";
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            // Categories List
            Container(
              padding: EdgeInsets.all(spSm),
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
                      Icon(Icons.category, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Categories (${filteredCategories.length})",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Drag to reorder",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  ...filteredCategories.map((category) {
                    Color categoryColor = getCategoryColor(category["color"]);
                    IconData categoryIcon = getCategoryIcon(category["icon"]);
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: spXs),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: category["isActive"] 
                            ? categoryColor.withAlpha(50)
                            : disabledOutlineBorderColor,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.drag_handle, color: disabledBoldColor, size: 16),
                          SizedBox(width: spSm),
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: categoryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Icon(
                              categoryIcon,
                              color: categoryColor,
                              size: 18,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${category["name"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: category["isActive"] ? primaryColor : disabledBoldColor,
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    if (!category["isActive"])
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: dangerColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "Inactive",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: dangerColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                if (category["description"].toString().isNotEmpty)
                                  Text(
                                    "${category["description"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Icon(Icons.restaurant_menu, size: 12, color: disabledBoldColor),
                                    SizedBox(width: 4),
                                    Text(
                                      "${category["itemCount"]} items",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: categoryColor,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      "${category["color"]}",
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
                                onTap: () {
                                  // navigateTo(FmaCategoryEditView(categoryId: category["id"]));
                                },
                                child: Container(
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Icon(
                                    Icons.edit,
                                    color: primaryColor,
                                    size: 16,
                                  ),
                                ),
                              ),
                              SizedBox(height: spXs),
                              GestureDetector(
                                onTap: () async {
                                  bool isConfirmed = await confirm("Are you sure you want to delete this category? This action cannot be undone.");
                                  if (isConfirmed) {
                                    categories.removeWhere((c) => c["id"] == category["id"]);
                                    ss("Category deleted successfully");
                                    setState(() {});
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    color: dangerColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Icon(
                                    Icons.delete,
                                    color: dangerColor,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Summary Stats
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${categories.where((c) => c["isActive"] == true).length}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Active",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                            fontWeight: FontWeight.w600,
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
                      color: dangerColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${categories.where((c) => c["isActive"] == false).length}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        Text(
                          "Inactive",
                          style: TextStyle(
                            fontSize: 12,
                            color: dangerColor,
                            fontWeight: FontWeight.w600,
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
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${categories.fold(0, (sum, c) => sum + (c["itemCount"] as int))}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Items",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
