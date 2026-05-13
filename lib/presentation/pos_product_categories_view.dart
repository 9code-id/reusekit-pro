import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosProductCategoriesView extends StatefulWidget {
  const PosProductCategoriesView({super.key});

  @override
  State<PosProductCategoriesView> createState() => _PosProductCategoriesViewState();
}

class _PosProductCategoriesViewState extends State<PosProductCategoriesView> {
  String searchQuery = "";
  bool isLoading = false;
  String newCategoryName = "";
  String newCategoryDescription = "";
  String selectedIcon = "fastfood";
  String selectedColor = "primary";

  List<Map<String, dynamic>> categories = [
    {
      "id": "cat_001",
      "name": "Beverages",
      "description": "Hot and cold drinks including coffee, tea, juices",
      "icon": "local_cafe",
      "color": "primary",
      "product_count": 45,
      "total_sales": 12450.75,
      "is_active": true,
      "created_date": "2024-01-15 09:30:00",
      "last_sale": "2024-12-19 14:30:00"
    },
    {
      "id": "cat_002",
      "name": "Food",
      "description": "Main meals, salads, sandwiches and hot dishes",
      "icon": "restaurant",
      "color": "success",
      "product_count": 38,
      "total_sales": 28750.25,
      "is_active": true,
      "created_date": "2024-01-15 09:30:00",
      "last_sale": "2024-12-19 13:45:00"
    },
    {
      "id": "cat_003",
      "name": "Pastries",
      "description": "Croissants, muffins, cakes and baked goods",
      "icon": "cake",
      "color": "warning",
      "product_count": 22,
      "total_sales": 8920.50,
      "is_active": true,
      "created_date": "2024-01-15 09:30:00",
      "last_sale": "2024-12-19 12:20:00"
    },
    {
      "id": "cat_004",
      "name": "Snacks",
      "description": "Light bites, chips, nuts and quick snacks",
      "icon": "fastfood",
      "color": "info",
      "product_count": 18,
      "total_sales": 4680.00,
      "is_active": true,
      "created_date": "2024-01-15 09:30:00",
      "last_sale": "2024-12-19 11:15:00"
    },
    {
      "id": "cat_005",
      "name": "Merchandise",
      "description": "Branded items, mugs, t-shirts and accessories",
      "icon": "shopping_bag",
      "color": "secondary",
      "product_count": 12,
      "total_sales": 2340.00,
      "is_active": true,
      "created_date": "2024-01-15 09:30:00",
      "last_sale": "2024-12-18 16:30:00"
    },
    {
      "id": "cat_006",
      "name": "Dairy",
      "description": "Milk, cheese, yogurt and dairy products",
      "icon": "eco",
      "color": "primary",
      "product_count": 8,
      "total_sales": 1560.25,
      "is_active": false,
      "created_date": "2024-01-15 09:30:00",
      "last_sale": "2024-12-10 10:20:00"
    },
  ];

  List<Map<String, dynamic>> iconOptions = [
    {"label": "Coffee", "value": "local_cafe"},
    {"label": "Restaurant", "value": "restaurant"},
    {"label": "Cake", "value": "cake"},
    {"label": "Fast Food", "value": "fastfood"},
    {"label": "Shopping", "value": "shopping_bag"},
    {"label": "Eco", "value": "eco"},
    {"label": "Local Bar", "value": "local_bar"},
    {"label": "Icecream", "value": "icecream"},
  ];

  List<Map<String, dynamic>> colorOptions = [
    {"label": "Primary", "value": "primary"},
    {"label": "Success", "value": "success"},
    {"label": "Warning", "value": "warning"},
    {"label": "Info", "value": "info"},
    {"label": "Secondary", "value": "secondary"},
    {"label": "Danger", "value": "danger"},
  ];

  List<Map<String, dynamic>> get filteredCategories {
    return categories.where((category) {
      return category["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
             category["description"].toString().toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Categories"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showAddCategoryModal();
            },
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              // navigateTo('CategoryAnalyticsView')
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildCategoryStats(),
          Expanded(
            child: _buildCategoryList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Row(
        spacing: spSm,
        children: [
          Expanded(
            child: QTextField(
              label: "Search categories...",
              value: searchQuery,
              hint: "Name or description",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),
          ),
          QButton(
            icon: Icons.search,
            size: bs.md,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryStats() {
    int totalCategories = categories.length;
    int activeCategories = categories.where((c) => c["is_active"] as bool).length;
    int totalProducts = categories.fold(0, (sum, c) => sum + (c["product_count"] as int));
    double totalSales = categories.fold(0.0, (sum, c) => sum + (c["total_sales"] as double));

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Row(
        spacing: spSm,
        children: [
          Expanded(
            child: _buildStatCard(
              title: "Total",
              value: totalCategories.toString(),
              color: primaryColor,
              icon: Icons.category,
            ),
          ),
          Expanded(
            child: _buildStatCard(
              title: "Active",
              value: activeCategories.toString(),
              color: successColor,
              icon: Icons.check_circle,
            ),
          ),
          Expanded(
            child: _buildStatCard(
              title: "Products",
              value: totalProducts.toString(),
              color: infoColor,
              icon: Icons.inventory,
            ),
          ),
          Expanded(
            child: _buildStatCard(
              title: "Sales",
              value: "\$${(totalSales / 1000).toStringAsFixed(1)}K",
              color: warningColor,
              icon: Icons.attach_money,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(60)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryList() {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (filteredCategories.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.category_outlined,
              size: 64,
              color: disabledColor,
            ),
            SizedBox(height: spMd),
            Text(
              "No categories found",
              style: TextStyle(
                fontSize: fsH6,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spSm),
            QButton(
              label: "Add Category",
              icon: Icons.add,
              size: bs.md,
              onPressed: () {
                _showAddCategoryModal();
              },
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spSm,
        children: filteredCategories.map((category) {
          return _buildCategoryCard(category);
        }).toList(),
      ),
    );
  }

  Widget _buildCategoryCard(Map<String, dynamic> category) {
    Color categoryColor = _getCategoryColor(category["color"]);
    IconData categoryIcon = _getCategoryIcon(category["icon"]);
    bool isActive = category["is_active"] as bool;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(
          color: isActive ? disabledOutlineBorderColor : disabledColor,
          width: isActive ? 1 : 2,
        ),
      ),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            spacing: spMd,
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: categoryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(
                  categoryIcon,
                  color: categoryColor,
                  size: 32,
                ),
              ),
              
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${category["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        if (!isActive)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: disabledColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "INACTIVE",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
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
                    
                    Text(
                      "Created: ${DateTime.parse(category["created_date"]).dMMMy}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          Row(
            spacing: spMd,
            children: [
              Expanded(
                child: _buildCategoryMetric(
                  label: "Products",
                  value: "${category["product_count"]}",
                  color: infoColor,
                  icon: Icons.inventory,
                ),
              ),
              Expanded(
                child: _buildCategoryMetric(
                  label: "Total Sales",
                  value: "\$${((category["total_sales"] as double) / 1000).toStringAsFixed(1)}K",
                  color: successColor,
                  icon: Icons.trending_up,
                ),
              ),
              Expanded(
                child: _buildCategoryMetric(
                  label: "Last Sale",
                  value: "${DateTime.parse(category["last_sale"]).dMMMy}",
                  color: warningColor,
                  icon: Icons.schedule,
                ),
              ),
            ],
          ),
          
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "View Products",
                  size: bs.sm,
                  onPressed: () {
                    // navigateTo('PosProductListView', arguments: {'category': category["id"]})
                  },
                ),
              ),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {
                  _showEditCategoryModal(category);
                },
              ),
              QButton(
                icon: Icons.bar_chart,
                size: bs.sm,
                onPressed: () {
                  // navigateTo('CategoryDetailAnalyticsView', arguments: category)
                },
              ),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  _showCategoryOptions(category);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryMetric({
    required String label,
    required String value,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 16),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 9,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  void _showAddCategoryModal() {
    newCategoryName = "";
    newCategoryDescription = "";
    selectedIcon = "fastfood";
    selectedColor = "primary";
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          padding: EdgeInsets.only(
            top: spMd,
            left: spMd,
            right: spMd,
            bottom: MediaQuery.of(context).viewInsets.bottom + spMd,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spMd,
            children: [
              Row(
                children: [
                  Text(
                    "Add New Category",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              
              QTextField(
                label: "Category Name",
                value: newCategoryName,
                hint: "Enter category name",
                onChanged: (value) {
                  newCategoryName = value;
                  setModalState(() {});
                },
              ),
              
              QMemoField(
                label: "Description",
                value: newCategoryDescription,
                hint: "Enter category description",
                onChanged: (value) {
                  newCategoryDescription = value;
                  setModalState(() {});
                },
              ),
              
              Row(
                spacing: spSm,
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Icon",
                      items: iconOptions,
                      value: selectedIcon,
                      onChanged: (value, label) {
                        selectedIcon = value;
                        setModalState(() {});
                      },
                    ),
                  ),
                  Expanded(
                    child: QDropdownField(
                      label: "Color",
                      items: colorOptions,
                      value: selectedColor,
                      onChanged: (value, label) {
                        selectedColor = value;
                        setModalState(() {});
                      },
                    ),
                  ),
                ],
              ),
              
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: _getCategoryColor(selectedColor).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Row(
                  children: [
                    Icon(
                      _getCategoryIcon(selectedIcon),
                      color: _getCategoryColor(selectedColor),
                      size: 32,
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            newCategoryName.isEmpty ? "Category Name" : newCategoryName,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: _getCategoryColor(selectedColor),
                            ),
                          ),
                          Text(
                            newCategoryDescription.isEmpty ? "Category description" : newCategoryDescription,
                            style: TextStyle(
                              fontSize: 12,
                              color: _getCategoryColor(selectedColor).withAlpha(180),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Add Category",
                  size: bs.md,
                  onPressed: newCategoryName.isNotEmpty ? () {
                    _addCategory();
                    Navigator.pop(context);
                  } : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditCategoryModal(Map<String, dynamic> category) {
    newCategoryName = category["name"];
    newCategoryDescription = category["description"];
    selectedIcon = category["icon"];
    selectedColor = category["color"];
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          padding: EdgeInsets.only(
            top: spMd,
            left: spMd,
            right: spMd,
            bottom: MediaQuery.of(context).viewInsets.bottom + spMd,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spMd,
            children: [
              Row(
                children: [
                  Text(
                    "Edit Category",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              
              QTextField(
                label: "Category Name",
                value: newCategoryName,
                hint: "Enter category name",
                onChanged: (value) {
                  newCategoryName = value;
                  setModalState(() {});
                },
              ),
              
              QMemoField(
                label: "Description",
                value: newCategoryDescription,
                hint: "Enter category description",
                onChanged: (value) {
                  newCategoryDescription = value;
                  setModalState(() {});
                },
              ),
              
              Row(
                spacing: spSm,
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Icon",
                      items: iconOptions,
                      value: selectedIcon,
                      onChanged: (value, label) {
                        selectedIcon = value;
                        setModalState(() {});
                      },
                    ),
                  ),
                  Expanded(
                    child: QDropdownField(
                      label: "Color",
                      items: colorOptions,
                      value: selectedColor,
                      onChanged: (value, label) {
                        selectedColor = value;
                        setModalState(() {});
                      },
                    ),
                  ),
                ],
              ),
              
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Save Changes",
                  size: bs.md,
                  onPressed: newCategoryName.isNotEmpty ? () {
                    _updateCategory(category);
                    Navigator.pop(context);
                  } : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getCategoryColor(String colorName) {
    switch (colorName) {
      case "primary": return primaryColor;
      case "success": return successColor;
      case "warning": return warningColor;
      case "info": return infoColor;
      case "secondary": return secondaryColor;
      case "danger": return dangerColor;
      default: return primaryColor;
    }
  }

  IconData _getCategoryIcon(String iconName) {
    switch (iconName) {
      case "local_cafe": return Icons.local_cafe;
      case "restaurant": return Icons.restaurant;
      case "cake": return Icons.cake;
      case "fastfood": return Icons.fastfood;
      case "shopping_bag": return Icons.shopping_bag;
      case "eco": return Icons.eco;
      case "local_bar": return Icons.local_bar;
      case "icecream": return Icons.icecream;
      default: return Icons.category;
    }
  }

  void _addCategory() async {
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    
    categories.add({
      "id": "cat_${DateTime.now().millisecondsSinceEpoch}",
      "name": newCategoryName,
      "description": newCategoryDescription,
      "icon": selectedIcon,
      "color": selectedColor,
      "product_count": 0,
      "total_sales": 0.0,
      "is_active": true,
      "created_date": DateTime.now().toIso8601String(),
      "last_sale": DateTime.now().toIso8601String(),
    });
    
    hideLoading();
    setState(() {});
    ss("Category added successfully");
  }

  void _updateCategory(Map<String, dynamic> category) async {
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    
    int index = categories.indexWhere((c) => c["id"] == category["id"]);
    if (index != -1) {
      categories[index]["name"] = newCategoryName;
      categories[index]["description"] = newCategoryDescription;
      categories[index]["icon"] = selectedIcon;
      categories[index]["color"] = selectedColor;
    }
    
    hideLoading();
    setState(() {});
    ss("Category updated successfully");
  }

  void _showCategoryOptions(Map<String, dynamic> category) {
    // Category options implementation
  }
}
