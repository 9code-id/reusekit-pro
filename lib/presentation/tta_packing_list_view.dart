import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaPackingListView extends StatefulWidget {
  const TtaPackingListView({super.key});

  @override
  State<TtaPackingListView> createState() => _TtaPackingListViewState();
}

class _TtaPackingListViewState extends State<TtaPackingListView> {
  List<Map<String, dynamic>> packingCategories = [
    {
      "id": 1,
      "name": "Clothing",
      "icon": Icons.checkroom,
      "color": Colors.blue,
      "items": [
        {"name": "T-shirts", "packed": true, "quantity": 5},
        {"name": "Jeans", "packed": true, "quantity": 3},
        {"name": "Underwear", "packed": false, "quantity": 7},
        {"name": "Socks", "packed": true, "quantity": 6},
        {"name": "Pajamas", "packed": false, "quantity": 2},
        {"name": "Jacket", "packed": true, "quantity": 1},
        {"name": "Dress shoes", "packed": false, "quantity": 1},
        {"name": "Sneakers", "packed": true, "quantity": 1},
      ]
    },
    {
      "id": 2,
      "name": "Electronics",
      "icon": Icons.devices,
      "color": Colors.orange,
      "items": [
        {"name": "Phone charger", "packed": true, "quantity": 1},
        {"name": "Laptop", "packed": false, "quantity": 1},
        {"name": "Camera", "packed": true, "quantity": 1},
        {"name": "Power bank", "packed": false, "quantity": 1},
        {"name": "Headphones", "packed": true, "quantity": 1},
        {"name": "Adapters", "packed": false, "quantity": 2},
      ]
    },
    {
      "id": 3,
      "name": "Toiletries",
      "icon": Icons.spa,
      "color": Colors.green,
      "items": [
        {"name": "Toothbrush", "packed": true, "quantity": 1},
        {"name": "Toothpaste", "packed": true, "quantity": 1},
        {"name": "Shampoo", "packed": false, "quantity": 1},
        {"name": "Deodorant", "packed": true, "quantity": 1},
        {"name": "Sunscreen", "packed": false, "quantity": 1},
        {"name": "Medications", "packed": false, "quantity": 1},
      ]
    },
    {
      "id": 4,
      "name": "Documents",
      "icon": Icons.description,
      "color": Colors.red,
      "items": [
        {"name": "Passport", "packed": true, "quantity": 1},
        {"name": "Flight tickets", "packed": true, "quantity": 1},
        {"name": "Hotel confirmation", "packed": false, "quantity": 1},
        {"name": "Travel insurance", "packed": true, "quantity": 1},
        {"name": "Driver's license", "packed": false, "quantity": 1},
        {"name": "Credit cards", "packed": true, "quantity": 2},
      ]
    },
    {
      "id": 5,
      "name": "Essentials",
      "icon": Icons.inventory,
      "color": Colors.purple,
      "items": [
        {"name": "Wallet", "packed": true, "quantity": 1},
        {"name": "Sunglasses", "packed": false, "quantity": 1},
        {"name": "Umbrella", "packed": false, "quantity": 1},
        {"name": "Travel pillow", "packed": true, "quantity": 1},
        {"name": "Snacks", "packed": false, "quantity": 5},
        {"name": "Water bottle", "packed": true, "quantity": 1},
      ]
    },
  ];

  String selectedFilter = "All";
  bool showCompleted = true;

  @override
  Widget build(BuildContext context) {
    List<String> filterOptions = ["All", "Packed", "Unpacked"];
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Packing List"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showAddItemDialog();
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              _showOptionsMenu();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPackingProgress(),
            SizedBox(height: spLg),
            _buildFilterTabs(filterOptions),
            SizedBox(height: spLg),
            _buildQuickActions(),
            SizedBox(height: spLg),
            _buildCategoriesList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddCategoryDialog();
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildPackingProgress() {
    int totalItems = 0;
    int packedItems = 0;

    for (var category in packingCategories) {
      List items = category["items"] as List;
      totalItems += items.length;
      packedItems += items.where((item) => item["packed"] == true).length;
    }

    double progress = totalItems > 0 ? packedItems / totalItems : 0.0;

    return Container(
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(150)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.luggage,
                color: Colors.white,
                size: 32,
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Packing Progress",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "$packedItems of $totalItems items packed",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "${(progress * 100).toInt()}%",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.white.withAlpha(77),
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            minHeight: 8,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTabs(List<String> options) {
    return Container(
      height: 45,
      child: QCategoryPicker(
        items: options.map((option) => {
          "label": option,
          "value": option,
        }).toList(),
        value: selectedFilter,
        onChanged: (index, label, value, item) {
          selectedFilter = value;
          setState(() {});
        },
      ),
    );
  }

  Widget _buildQuickActions() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: successColor.withAlpha(26),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: successColor.withAlpha(77)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: successColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Mark All Packed",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: successColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spMd),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(26),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: infoColor.withAlpha(77)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.share,
                  color: infoColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Share List",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: infoColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoriesList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Categories",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        ...packingCategories.map((category) => _buildCategoryCard(category)),
      ],
    );
  }

  Widget _buildCategoryCard(Map<String, dynamic> category) {
    List items = category["items"] as List;
    int totalItems = items.length;
    int packedItems = items.where((item) => item["packed"] == true).length;
    
    // Filter items based on selected filter
    List filteredItems = items;
    if (selectedFilter == "Packed") {
      filteredItems = items.where((item) => item["packed"] == true).toList();
    } else if (selectedFilter == "Unpacked") {
      filteredItems = items.where((item) => item["packed"] == false).toList();
    }

    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: ExpansionTile(
        leading: Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: (category["color"] as Color).withAlpha(26),
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          child: Icon(
            category["icon"],
            color: category["color"],
            size: 24,
          ),
        ),
        title: Text(
          "${category["name"]}",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$packedItems of $totalItems items packed",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spXs),
            LinearProgressIndicator(
              value: totalItems > 0 ? packedItems / totalItems : 0.0,
              backgroundColor: disabledColor,
              valueColor: AlwaysStoppedAnimation<Color>(category["color"]),
              minHeight: 3,
            ),
          ],
        ),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            child: Column(
              children: filteredItems.map<Widget>((item) {
                return _buildPackingItem(item, category["id"]);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPackingItem(Map<String, dynamic> item, int categoryId) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: item["packed"] ? successColor.withAlpha(26) : Colors.grey.withAlpha(26),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(
          color: item["packed"] ? successColor.withAlpha(77) : disabledOutlineBorderColor,
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              item["packed"] = !item["packed"];
              setState(() {});
            },
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: item["packed"] ? successColor : Colors.transparent,
                border: Border.all(
                  color: item["packed"] ? successColor : disabledBoldColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: item["packed"]
                  ? Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    )
                  : null,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${item["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: item["packed"] ? successColor : primaryColor,
                    decoration: item["packed"] ? TextDecoration.lineThrough : null,
                  ),
                ),
                if ((item["quantity"] as int) > 1)
                  Text(
                    "Quantity: ${item["quantity"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              _showEditItemDialog(item, categoryId);
            },
            child: Icon(
              Icons.edit,
              color: infoColor,
              size: 18,
            ),
          ),
          SizedBox(width: spSm),
          GestureDetector(
            onTap: () {
              _deleteItem(item, categoryId);
            },
            child: Icon(
              Icons.delete,
              color: dangerColor,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }

  void _showAddItemDialog() {
    String itemName = "";
    int quantity = 1;
    int selectedCategoryId = packingCategories.first["id"];

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text("Add New Item"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              QTextField(
                label: "Item Name",
                value: itemName,
                onChanged: (value) {
                  itemName = value;
                },
              ),
              SizedBox(height: spMd),
              QNumberField(
                label: "Quantity",
                value: quantity.toString(),
                onChanged: (value) {
                  quantity = int.tryParse(value) ?? 1;
                },
              ),
              SizedBox(height: spMd),
              QDropdownField(
                label: "Category",
                value: selectedCategoryId,
                items: packingCategories.map((cat) => {
                  "label": cat["name"],
                  "value": cat["id"],
                }).toList(),
                onChanged: (value, label) {
                  selectedCategoryId = value;
                  setDialogState(() {});
                },
              ),
            ],
          ),
          actions: [
            QButton(
              label: "Cancel",
              onPressed: () => back(),
            ),
            QButton(
              label: "Add Item",
              onPressed: () {
                if (itemName.isNotEmpty) {
                  _addItemToCategory(selectedCategoryId, itemName, quantity);
                  back();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showAddCategoryDialog() {
    String categoryName = "";
    IconData selectedIcon = Icons.category;
    Color selectedColor = primaryColor;

    List<IconData> iconOptions = [
      Icons.category,
      Icons.checkroom,
      Icons.devices,
      Icons.spa,
      Icons.description,
      Icons.inventory,
      Icons.sports,
      Icons.medical_services,
    ];

    List<Color> colorOptions = [
      primaryColor,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.red,
      Colors.purple,
      Colors.teal,
      Colors.pink,
    ];

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text("Add New Category"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              QTextField(
                label: "Category Name",
                value: categoryName,
                onChanged: (value) {
                  categoryName = value;
                },
              ),
              SizedBox(height: spMd),
              Text(
                "Select Icon",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Container(
                height: 60,
                child: QHorizontalScroll(
                  children: iconOptions.map((icon) {
                    return GestureDetector(
                      onTap: () {
                        selectedIcon = icon;
                        setDialogState(() {});
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        margin: EdgeInsets.only(right: spSm),
                        decoration: BoxDecoration(
                          color: selectedIcon == icon ? primaryColor.withAlpha(26) : Colors.grey.withAlpha(26),
                          borderRadius: BorderRadius.circular(radiusMd),
                          border: Border.all(
                            color: selectedIcon == icon ? primaryColor : disabledOutlineBorderColor,
                          ),
                        ),
                        child: Icon(
                          icon,
                          color: selectedIcon == icon ? primaryColor : disabledBoldColor,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: spMd),
              Text(
                "Select Color",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Container(
                height: 40,
                child: QHorizontalScroll(
                  children: colorOptions.map((color) {
                    return GestureDetector(
                      onTap: () {
                        selectedColor = color;
                        setDialogState(() {});
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        margin: EdgeInsets.only(right: spSm),
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: selectedColor == color ? primaryColor : Colors.transparent,
                            width: 3,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          actions: [
            QButton(
              label: "Cancel",
              onPressed: () => back(),
            ),
            QButton(
              label: "Add Category",
              onPressed: () {
                if (categoryName.isNotEmpty) {
                  _addNewCategory(categoryName, selectedIcon, selectedColor);
                  back();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showEditItemDialog(Map<String, dynamic> item, int categoryId) {
    String itemName = item["name"];
    int quantity = item["quantity"];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Item"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QTextField(
              label: "Item Name",
              value: itemName,
              onChanged: (value) {
                itemName = value;
              },
            ),
            SizedBox(height: spMd),
            QNumberField(
              label: "Quantity",
              value: quantity.toString(),
              onChanged: (value) {
                quantity = int.tryParse(value) ?? 1;
              },
            ),
          ],
        ),
        actions: [
          QButton(
            label: "Cancel",
            onPressed: () => back(),
          ),
          QButton(
            label: "Save Changes",
            onPressed: () {
              item["name"] = itemName;
              item["quantity"] = quantity;
              setState(() {});
              back();
            },
          ),
        ],
      ),
    );
  }

  void _showOptionsMenu() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(spLg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: spLg),
            Text(
              "Options",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spLg),
            _buildOptionItem(
              icon: Icons.check_circle,
              title: "Mark All as Packed",
              subtitle: "Mark all items as packed",
              onTap: () {
                _markAllAsPacked();
                back();
              },
            ),
            _buildOptionItem(
              icon: Icons.refresh,
              title: "Reset All",
              subtitle: "Mark all items as unpacked",
              onTap: () {
                _resetAllItems();
                back();
              },
            ),
            _buildOptionItem(
              icon: Icons.download,
              title: "Export List",
              subtitle: "Export packing list as PDF",
              onTap: () {
                back();
                ss("List exported successfully");
              },
            ),
            _buildOptionItem(
              icon: Icons.article,
              title: "Use Template",
              subtitle: "Load a packing template",
              onTap: () {
                back();
                _showTemplateDialog();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spMd),
        margin: EdgeInsets.only(bottom: spSm),
        decoration: BoxDecoration(
          color: Colors.grey.withAlpha(26),
          borderRadius: BorderRadius.circular(radiusMd),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: primaryColor,
              size: 24,
            ),
            SizedBox(width: spMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: disabledBoldColor,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  void _showTemplateDialog() {
    List<Map<String, dynamic>> templates = [
      {
        "name": "Beach Vacation",
        "description": "Perfect for tropical getaways",
        "icon": Icons.beach_access,
      },
      {
        "name": "Business Trip",
        "description": "Professional travel essentials",
        "icon": Icons.business_center,
      },
      {
        "name": "Adventure Travel",
        "description": "Outdoor and hiking gear",
        "icon": Icons.hiking,
      },
      {
        "name": "City Break",
        "description": "Urban exploration essentials",
        "icon": Icons.location_city,
      },
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Choose Template"),
        content: Container(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: templates.length,
            itemBuilder: (context, index) {
              final template = templates[index];
              return GestureDetector(
                onTap: () {
                  back();
                  _loadTemplate(template["name"]);
                },
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey.withAlpha(26),
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        template["icon"],
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${template["name"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${template["description"]}",
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
                ),
              );
            },
          ),
        ),
        actions: [
          QButton(
            label: "Cancel",
            onPressed: () => back(),
          ),
        ],
      ),
    );
  }

  void _addItemToCategory(int categoryId, String itemName, int quantity) {
    int categoryIndex = packingCategories.indexWhere((cat) => cat["id"] == categoryId);
    if (categoryIndex != -1) {
      List items = packingCategories[categoryIndex]["items"];
      items.add({
        "name": itemName,
        "packed": false,
        "quantity": quantity,
      });
      setState(() {});
      ss("Item added successfully");
    }
  }

  void _addNewCategory(String name, IconData icon, Color color) {
    int newId = packingCategories.length + 1;
    packingCategories.add({
      "id": newId,
      "name": name,
      "icon": icon,
      "color": color,
      "items": [],
    });
    setState(() {});
    ss("Category added successfully");
  }

  void _deleteItem(Map<String, dynamic> item, int categoryId) {
    int categoryIndex = packingCategories.indexWhere((cat) => cat["id"] == categoryId);
    if (categoryIndex != -1) {
      List items = packingCategories[categoryIndex]["items"];
      items.remove(item);
      setState(() {});
      ss("Item deleted successfully");
    }
  }

  void _markAllAsPacked() {
    for (var category in packingCategories) {
      List items = category["items"];
      for (var item in items) {
        item["packed"] = true;
      }
    }
    setState(() {});
    ss("All items marked as packed");
  }

  void _resetAllItems() {
    for (var category in packingCategories) {
      List items = category["items"];
      for (var item in items) {
        item["packed"] = false;
      }
    }
    setState(() {});
    ss("All items reset to unpacked");
  }

  void _loadTemplate(String templateName) {
    // In a real app, this would load template data from a database or API
    ss("Template '$templateName' loaded successfully");
  }
}
