import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaExpenseCategoriesView extends StatefulWidget {
  const AbaExpenseCategoriesView({super.key});

  @override
  State<AbaExpenseCategoriesView> createState() => _AbaExpenseCategoriesViewState();
}

class _AbaExpenseCategoriesViewState extends State<AbaExpenseCategoriesView> {
  List<Map<String, dynamic>> categories = [];
  List<Map<String, dynamic>> filteredCategories = [];
  String searchQuery = "";
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    await Future.delayed(Duration(milliseconds: 800));
    
    categories = [
      {
        "id": "cat_001",
        "name": "Office Supplies",
        "description": "Stationery, paper, pens, and general office materials",
        "color": primaryColor,
        "icon": Icons.inventory_2,
        "totalExpenses": 45,
        "totalAmount": 2890.45,
        "monthlyBudget": 500.0,
        "percentUsed": 57.8,
        "isActive": true,
        "createdDate": "2024-01-15",
        "lastUsed": "2024-03-15"
      },
      {
        "id": "cat_002",
        "name": "Equipment",
        "description": "Therapy equipment, computers, and technology",
        "color": successColor,
        "icon": Icons.computer,
        "totalExpenses": 12,
        "totalAmount": 8500.20,
        "monthlyBudget": 2000.0,
        "percentUsed": 42.5,
        "isActive": true,
        "createdDate": "2024-01-15",
        "lastUsed": "2024-03-12"
      },
      {
        "id": "cat_003",
        "name": "Transportation",
        "description": "Travel, fuel, and vehicle-related expenses",
        "color": infoColor,
        "icon": Icons.directions_car,
        "totalExpenses": 28,
        "totalAmount": 1250.80,
        "monthlyBudget": 800.0,
        "percentUsed": 15.6,
        "isActive": true,
        "createdDate": "2024-01-15",
        "lastUsed": "2024-03-14"
      },
      {
        "id": "cat_004",
        "name": "Training",
        "description": "Professional development and training costs",
        "color": warningColor,
        "icon": Icons.school,
        "totalExpenses": 8,
        "totalAmount": 3200.00,
        "monthlyBudget": 1000.0,
        "percentUsed": 32.0,
        "isActive": true,
        "createdDate": "2024-01-15",
        "lastUsed": "2024-03-10"
      },
      {
        "id": "cat_005",
        "name": "Software",
        "description": "Software licenses, subscriptions, and digital tools",
        "color": secondaryColor,
        "icon": Icons.apps,
        "totalExpenses": 15,
        "totalAmount": 890.25,
        "monthlyBudget": 300.0,
        "percentUsed": 29.7,
        "isActive": true,
        "createdDate": "2024-01-15",
        "lastUsed": "2024-03-13"
      },
      {
        "id": "cat_006",
        "name": "Marketing",
        "description": "Advertising, promotional materials, and marketing",
        "color": dangerColor,
        "icon": Icons.campaign,
        "totalExpenses": 22,
        "totalAmount": 1850.60,
        "monthlyBudget": 750.0,
        "percentUsed": 24.7,
        "isActive": true,
        "createdDate": "2024-01-15",
        "lastUsed": "2024-03-11"
      },
      {
        "id": "cat_007",
        "name": "Utilities",
        "description": "Electricity, internet, phone, and utility bills",
        "color": primaryColor,
        "icon": Icons.electrical_services,
        "totalExpenses": 35,
        "totalAmount": 2100.30,
        "monthlyBudget": 600.0,
        "percentUsed": 35.0,
        "isActive": true,
        "createdDate": "2024-01-15",
        "lastUsed": "2024-03-15"
      },
      {
        "id": "cat_008",
        "name": "Insurance",
        "description": "Professional liability and business insurance",
        "color": infoColor,
        "icon": Icons.security,
        "totalExpenses": 4,
        "totalAmount": 4800.00,
        "monthlyBudget": 400.0,
        "percentUsed": 120.0,
        "isActive": true,
        "createdDate": "2024-01-15",
        "lastUsed": "2024-03-01"
      },
      {
        "id": "cat_009",
        "name": "Meals & Entertainment",
        "description": "Client meetings, team meals, and entertainment",
        "color": warningColor,
        "icon": Icons.restaurant,
        "totalExpenses": 18,
        "totalAmount": 650.45,
        "monthlyBudget": 200.0,
        "percentUsed": 32.5,
        "isActive": true,
        "createdDate": "2024-01-15",
        "lastUsed": "2024-03-09"
      },
      {
        "id": "cat_010",
        "name": "Other",
        "description": "Miscellaneous expenses not covered by other categories",
        "color": disabledBoldColor,
        "icon": Icons.more_horiz,
        "totalExpenses": 12,
        "totalAmount": 380.25,
        "monthlyBudget": 100.0,
        "percentUsed": 38.0,
        "isActive": true,
        "createdDate": "2024-01-15",
        "lastUsed": "2024-03-08"
      }
    ];

    filteredCategories = categories;
    loading = false;
    setState(() {});
  }

  void _filterCategories() {
    filteredCategories = categories.where((category) {
      return category["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
             category["description"].toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Expense Categories"),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Categories"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showAddCategoryDialog(),
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () => _showMoreOptions(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            _buildSearchSection(),
            _buildSummaryCards(),
            _buildCategoriesList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddCategoryDialog(),
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildSearchSection() {
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
          Text(
            "Search Categories",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search by name or description",
                  value: searchQuery,
                  hint: "Enter search term...",
                  onChanged: (value) {
                    searchQuery = value;
                    _filterCategories();
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.clear,
                size: bs.sm,
                color: secondaryColor,
                onPressed: () {
                  searchQuery = "";
                  _filterCategories();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards() {
    double totalBudget = categories.fold(0.0, (sum, cat) => sum + (cat["monthlyBudget"] as double));
    double totalSpent = categories.fold(0.0, (sum, cat) => sum + (cat["totalAmount"] as double));
    int totalExpenses = categories.fold(0, (sum, cat) => sum + (cat["totalExpenses"] as int));
    int activeCategories = categories.where((cat) => cat["isActive"]).length;

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 150,
      children: [
        _buildSummaryCard(
          "Total Categories",
          "${categories.length}",
          Icons.category,
          primaryColor
        ),
        _buildSummaryCard(
          "Active Categories",
          "$activeCategories",
          Icons.check_circle,
          successColor
        ),
        _buildSummaryCard(
          "Total Expenses",
          "$totalExpenses",
          Icons.receipt,
          infoColor
        ),
        _buildSummaryCard(
          "Total Budget",
          "\$${totalBudget.currency}",
          Icons.account_balance_wallet,
          warningColor
        ),
        _buildSummaryCard(
          "Total Spent",
          "\$${totalSpent.currency}",
          Icons.trending_up,
          secondaryColor
        ),
        _buildSummaryCard(
          "Budget Usage",
          "${((totalSpent / totalBudget) * 100).toStringAsFixed(1)}%",
          Icons.pie_chart,
          totalSpent > totalBudget ? dangerColor : successColor
        ),
      ],
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
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
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              Spacer(),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesList() {
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
              Text(
                "Categories (${filteredCategories.length})",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Manage",
                size: bs.sm,
                onPressed: () => _showManageOptions(),
              ),
            ],
          ),
          ...filteredCategories.map((category) => _buildCategoryItem(category)),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(Map<String, dynamic> category) {
    double percentUsed = category["percentUsed"] as double;
    Color statusColor = percentUsed > 100 
        ? dangerColor 
        : percentUsed > 80 
            ? warningColor 
            : successColor;

    return GestureDetector(
      onTap: () => _showCategoryDetails(category),
      child: Container(
        padding: EdgeInsets.all(spMd),
        margin: EdgeInsets.only(bottom: spSm),
        decoration: BoxDecoration(
          color: primaryColor.withAlpha(5),
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: disabledOutlineBorderColor,
            width: 1,
          ),
        ),
        child: Column(
          spacing: spSm,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: category["color"].withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    category["icon"],
                    color: category["color"],
                    size: 24,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Text(
                        "${category["name"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${category["description"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: spXs,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: category["isActive"] ? successColor : dangerColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        category["isActive"] ? "Active" : "Inactive",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      "${category["totalExpenses"]} expenses",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Divider(height: 1),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Text(
                        "Spent",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "\$${(category["totalAmount"] as double).currency}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Text(
                        "Budget",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "\$${(category["monthlyBudget"] as double).currency}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    spacing: spXs,
                    children: [
                      Text(
                        "Usage",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${percentUsed.toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              height: 4,
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                children: [
                  Container(
                    width: (MediaQuery.of(context).size.width - 64) * (percentUsed / 100).clamp(0.0, 1.0),
                    height: 4,
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(radiusXs),
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

  void _showAddCategoryDialog() {
    String name = "";
    String description = "";
    String monthlyBudget = "";
    Color selectedColor = primaryColor;
    IconData selectedIcon = Icons.category;
    
    List<Color> availableColors = [
      primaryColor, successColor, infoColor, warningColor, 
      secondaryColor, dangerColor, disabledBoldColor
    ];
    
    List<IconData> availableIcons = [
      Icons.category, Icons.inventory_2, Icons.computer, Icons.directions_car,
      Icons.school, Icons.apps, Icons.campaign, Icons.electrical_services,
      Icons.security, Icons.restaurant, Icons.more_horiz, Icons.work,
      Icons.home, Icons.health_and_safety, Icons.build, Icons.local_gas_station
    ];

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text("Add New Category"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: spMd,
              children: [
                QTextField(
                  label: "Category Name",
                  value: name,
                  hint: "Enter category name",
                  onChanged: (value) {
                    name = value;
                    setDialogState(() {});
                  },
                ),
                QMemoField(
                  label: "Description",
                  value: description,
                  hint: "Enter category description",
                  onChanged: (value) {
                    description = value;
                    setDialogState(() {});
                  },
                ),
                QNumberField(
                  label: "Monthly Budget (\$)",
                  value: monthlyBudget,
                  hint: "0.00",
                  onChanged: (value) {
                    monthlyBudget = value;
                    setDialogState(() {});
                  },
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Select Color",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Wrap(
                      spacing: spSm,
                      children: availableColors.map((color) => GestureDetector(
                        onTap: () {
                          selectedColor = color;
                          setDialogState(() {});
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: selectedColor == color 
                                ? Border.all(color: primaryColor, width: 3)
                                : null,
                          ),
                        ),
                      )).toList(),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Select Icon",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Wrap(
                      spacing: spSm,
                      children: availableIcons.map((icon) => GestureDetector(
                        onTap: () {
                          selectedIcon = icon;
                          setDialogState(() {});
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: selectedIcon == icon 
                                ? selectedColor.withAlpha(20)
                                : disabledColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: selectedIcon == icon 
                                ? Border.all(color: selectedColor, width: 2)
                                : null,
                          ),
                          child: Icon(
                            icon,
                            color: selectedIcon == icon ? selectedColor : disabledBoldColor,
                            size: 20,
                          ),
                        ),
                      )).toList(),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            QButton(
              label: "Add Category",
              size: bs.sm,
              onPressed: () {
                if (name.isNotEmpty && description.isNotEmpty && monthlyBudget.isNotEmpty) {
                  Navigator.pop(context);
                  _addCategory(name, description, monthlyBudget, selectedColor, selectedIcon);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _addCategory(String name, String description, String budget, Color color, IconData icon) {
    String newId = "cat_${DateTime.now().millisecondsSinceEpoch}";
    Map<String, dynamic> newCategory = {
      "id": newId,
      "name": name,
      "description": description,
      "color": color,
      "icon": icon,
      "totalExpenses": 0,
      "totalAmount": 0.0,
      "monthlyBudget": double.tryParse(budget) ?? 0.0,
      "percentUsed": 0.0,
      "isActive": true,
      "createdDate": DateTime.now().toString().split(' ')[0],
      "lastUsed": null
    };

    categories.add(newCategory);
    _filterCategories();
    ss("Category added successfully");
  }

  void _showCategoryDetails(Map<String, dynamic> category) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: category["color"].withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    category["icon"],
                    color: category["color"],
                    size: 24,
                  ),
                ),
                SizedBox(width: spMd),
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
                        "${category["description"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            Divider(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    _buildDetailSection("Statistics", [
                      {"label": "Total Expenses", "value": "${category["totalExpenses"]}"},
                      {"label": "Total Amount", "value": "\$${(category["totalAmount"] as double).currency}"},
                      {"label": "Monthly Budget", "value": "\$${(category["monthlyBudget"] as double).currency}"},
                      {"label": "Budget Usage", "value": "${(category["percentUsed"] as double).toStringAsFixed(1)}%"},
                    ]),
                    _buildDetailSection("Information", [
                      {"label": "Category ID", "value": "${category["id"]}"},
                      {"label": "Status", "value": category["isActive"] ? "Active" : "Inactive"},
                      {"label": "Created Date", "value": "${category["createdDate"]}"},
                      {"label": "Last Used", "value": category["lastUsed"] ?? "Never"},
                    ]),
                  ],
                ),
              ),
            ),
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Edit",
                    color: secondaryColor,
                    onPressed: () {
                      Navigator.pop(context);
                      _editCategory(category);
                    },
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: category["isActive"] ? "Deactivate" : "Activate",
                    color: category["isActive"] ? warningColor : successColor,
                    onPressed: () {
                      Navigator.pop(context);
                      _toggleCategoryStatus(category);
                    },
                  ),
                ),
                QButton(
                  icon: Icons.delete,
                  size: bs.sm,
                  color: dangerColor,
                  onPressed: () {
                    Navigator.pop(context);
                    _deleteCategory(category);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, List<Map<String, String>> details) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...details.map((detail) => Row(
            children: [
              SizedBox(
                width: 120,
                child: Text(
                  detail["label"]!,
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              Text(
                detail["value"]!,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }

  void _editCategory(Map<String, dynamic> category) {
    // Navigate to edit category screen
    ss("Category edit functionality");
  }

  void _toggleCategoryStatus(Map<String, dynamic> category) {
    setState(() {
      category["isActive"] = !category["isActive"];
    });
    
    String status = category["isActive"] ? "activated" : "deactivated";
    ss("Category $status successfully");
  }

  void _deleteCategory(Map<String, dynamic> category) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this category? This action cannot be undone.");
    if (isConfirmed) {
      setState(() {
        categories.removeWhere((cat) => cat["id"] == category["id"]);
        _filterCategories();
      });
      ss("Category deleted successfully");
    }
  }

  void _showMoreOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            ListTile(
              leading: Icon(Icons.download, color: primaryColor),
              title: Text("Export Categories"),
              onTap: () {
                Navigator.pop(context);
                _exportCategories();
              },
            ),
            ListTile(
              leading: Icon(Icons.upload, color: primaryColor),
              title: Text("Import Categories"),
              onTap: () {
                Navigator.pop(context);
                _importCategories();
              },
            ),
            ListTile(
              leading: Icon(Icons.sync, color: primaryColor),
              title: Text("Sync Categories"),
              onTap: () {
                Navigator.pop(context);
                _syncCategories();
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: primaryColor),
              title: Text("Category Settings"),
              onTap: () {
                Navigator.pop(context);
                _showCategorySettings();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showManageOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            ListTile(
              leading: Icon(Icons.sort, color: primaryColor),
              title: Text("Sort Categories"),
              onTap: () {
                Navigator.pop(context);
                _showSortOptions();
              },
            ),
            ListTile(
              leading: Icon(Icons.filter_list, color: primaryColor),
              title: Text("Filter Categories"),
              onTap: () {
                Navigator.pop(context);
                _showFilterOptions();
              },
            ),
            ListTile(
              leading: Icon(Icons.select_all, color: primaryColor),
              title: Text("Bulk Actions"),
              onTap: () {
                Navigator.pop(context);
                _showBulkActions();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _exportCategories() {
    ss("Categories exported successfully");
  }

  void _importCategories() {
    ss("Category import functionality");
  }

  void _syncCategories() {
    ss("Categories synced successfully");
  }

  void _showCategorySettings() {
    ss("Category settings");
  }

  void _showSortOptions() {
    ss("Sort options");
  }

  void _showFilterOptions() {
    ss("Filter options");
  }

  void _showBulkActions() {
    ss("Bulk actions");
  }
}
