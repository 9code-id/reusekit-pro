import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaProductView extends StatefulWidget {
  const ImaProductView({super.key});

  @override
  State<ImaProductView> createState() => _ImaProductViewState();
}

class _ImaProductViewState extends State<ImaProductView> {
  int currentTab = 0;

  List<Map<String, dynamic>> dashboardStats = [
    {
      "title": "Total Products",
      "value": "1,247",
      "change": "+12.5%",
      "icon": Icons.inventory,
      "color": primaryColor,
      "isPositive": true,
    },
    {
      "title": "Active Products",
      "value": "1,198",
      "change": "+8.3%",
      "icon": Icons.check_circle,
      "color": successColor,
      "isPositive": true,
    },
    {
      "title": "Draft Products",
      "value": "23",
      "change": "-15.2%",
      "icon": Icons.edit,
      "color": warningColor,
      "isPositive": false,
    },
    {
      "title": "Archived Products",
      "value": "26",
      "change": "+5.7%",
      "icon": Icons.archive,
      "color": disabledBoldColor,
      "isPositive": true,
    },
  ];

  List<Map<String, dynamic>> recentProducts = [
    {
      "id": "PRD001",
      "name": "iPhone 14 Pro Max",
      "sku": "IP14PM-256GB",
      "category": "Electronics",
      "price": 1199.99,
      "stock": 45,
      "status": "Active",
      "image": "https://picsum.photos/80/80?random=1&keyword=phone",
      "createdAt": "2024-01-15",
    },
    {
      "id": "PRD002",
      "name": "Samsung Galaxy S23 Ultra",
      "sku": "SGS23U-512GB",
      "category": "Electronics",
      "price": 1099.99,
      "stock": 32,
      "status": "Active",
      "image": "https://picsum.photos/80/80?random=2&keyword=phone",
      "createdAt": "2024-01-14",
    },
    {
      "id": "PRD003",
      "name": "MacBook Air M2",
      "sku": "MBA-M2-13",
      "category": "Electronics",
      "price": 1299.99,
      "stock": 18,
      "status": "Low Stock",
      "image": "https://picsum.photos/80/80?random=3&keyword=laptop",
      "createdAt": "2024-01-13",
    },
    {
      "id": "PRD004",
      "name": "iPad Pro 11\"",
      "sku": "IPP11-256GB",
      "category": "Electronics",
      "price": 899.99,
      "stock": 0,
      "status": "Out of Stock",
      "image": "https://picsum.photos/80/80?random=4&keyword=tablet",
      "createdAt": "2024-01-12",
    },
    {
      "id": "PRD005",
      "name": "AirPods Pro 3rd Gen",
      "sku": "APP3-WHITE",
      "category": "Accessories",
      "price": 249.99,
      "stock": 67,
      "status": "Active",
      "image": "https://picsum.photos/80/80?random=5&keyword=headphones",
      "createdAt": "2024-01-11",
    },
  ];

  List<Map<String, dynamic>> categoryData = [
    {
      "name": "Electronics",
      "productCount": 456,
      "value": 567890.12,
      "icon": Icons.devices,
      "color": primaryColor,
    },
    {
      "name": "Clothing",
      "productCount": 234,
      "value": 123456.78,
      "icon": Icons.checkroom,
      "color": successColor,
    },
    {
      "name": "Home & Garden",
      "productCount": 189,
      "value": 234567.89,
      "icon": Icons.home,
      "color": infoColor,
    },
    {
      "name": "Sports",
      "productCount": 167,
      "value": 89012.34,
      "icon": Icons.sports_soccer,
      "color": warningColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Product Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Dashboard", icon: Icon(Icons.dashboard)),
        Tab(text: "Products", icon: Icon(Icons.inventory)),
        Tab(text: "Categories", icon: Icon(Icons.category)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildDashboardTab(),
        _buildProductsTab(),
        _buildCategoriesTab(),
        _buildAnalyticsTab(),
      ],
      onInit: (tabController) {
        // TabController initialized
      },
    );
  }

  Widget _buildDashboardTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Welcome Header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome Back!",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Manage your product inventory efficiently",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.inventory_2,
                  size: 60,
                  color: Colors.white.withAlpha(100),
                ),
              ],
            ),
          ),

          // Quick Stats
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: dashboardStats.map((stat) {
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
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: (stat["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            stat["icon"],
                            color: stat["color"] as Color,
                            size: 24,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: (stat["isPositive"] as bool)
                                ? successColor.withAlpha(20)
                                : dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${stat["change"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: (stat["isPositive"] as bool)
                                  ? successColor
                                  : dangerColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${stat["title"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${stat["value"]}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          // Quick Actions
          Container(
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
                  "Quick Actions",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Add Product",
                        icon: Icons.add,
                        size: bs.sm,
                        onPressed: () {
                          // Navigate to add product
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Import Products",
                        icon: Icons.upload,
                        size: bs.sm,
                        onPressed: () {
                          // Import products
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Export Data",
                        icon: Icons.download,
                        size: bs.sm,
                        onPressed: () {
                          // Export data
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Bulk Edit",
                        icon: Icons.edit,
                        size: bs.sm,
                        onPressed: () {
                          // Bulk edit
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Recent Products
          Container(
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
                      "Recent Products",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        // View all products
                      },
                      child: Text(
                        "View All",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                ...recentProducts.take(3).map((product) {
                  Color statusColor = successColor;
                  if (product["status"] == "Low Stock") statusColor = warningColor;
                  if (product["status"] == "Out of Stock") statusColor = dangerColor;

                  return Container(
                    padding: EdgeInsets.all(spSm),
                    margin: EdgeInsets.only(bottom: spXs),
                    decoration: BoxDecoration(
                      color: Colors.grey.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusXs),
                          child: Image.network(
                            "${product["image"]}",
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${product["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "SKU: ${product["sku"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "\$${(product["price"] as double).currency}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: statusColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${product["status"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: statusColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        QButton(
                          icon: Icons.edit,
                          size: bs.sm,
                          onPressed: () {
                            // Edit product
                          },
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Search and Filter
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search products...",
                      border: InputBorder.none,
                      icon: Icon(Icons.search, color: disabledBoldColor),
                    ),
                  ),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.filter_list,
                size: bs.sm,
                onPressed: () {
                  // Show filter
                },
              ),
            ],
          ),

          // Product List
          Container(
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
                      "All Products",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "Add Product",
                      icon: Icons.add,
                      size: bs.sm,
                      onPressed: () {
                        // Add product
                      },
                    ),
                  ],
                ),
                ...recentProducts.map((product) {
                  Color statusColor = successColor;
                  if (product["status"] == "Low Stock") statusColor = warningColor;
                  if (product["status"] == "Out of Stock") statusColor = dangerColor;

                  return Container(
                    padding: EdgeInsets.all(spSm),
                    margin: EdgeInsets.only(bottom: spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusXs),
                          child: Image.network(
                            "${product["image"]}",
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${product["name"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "SKU: ${product["sku"]} • ${product["category"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Text(
                                    "\$${(product["price"] as double).currency}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "Stock: ${product["stock"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: statusColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${product["status"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: statusColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            QButton(
                              icon: Icons.edit,
                              size: bs.sm,
                              onPressed: () {
                                // Edit product
                              },
                            ),
                            SizedBox(height: spXs),
                            QButton(
                              icon: Icons.more_vert,
                              size: bs.sm,
                              onPressed: () {
                                // More options
                              },
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
        ],
      ),
    );
  }

  Widget _buildCategoriesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Categories Grid
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: categoryData.map((category) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border.all(
                    color: (category["color"] as Color).withAlpha(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: (category["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            category["icon"],
                            color: category["color"] as Color,
                            size: 28,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          icon: Icons.edit,
                          size: bs.sm,
                          onPressed: () {
                            // Edit category
                          },
                        ),
                      ],
                    ),
                    Text(
                      "${category["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${category["productCount"]} Products",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${(category["value"] as double).currency}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: category["color"] as Color,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          // Add Category Button
          Container(
            width: double.infinity,
            child: QButton(
              label: "Add New Category",
              icon: Icons.add,
              size: bs.md,
              onPressed: () {
                // Add category
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Product Analytics",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Text(
                  "Analytics coming soon...",
                  style: TextStyle(
                    fontSize: 16,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spMd),
                Icon(
                  Icons.analytics,
                  size: 80,
                  color: disabledBoldColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
