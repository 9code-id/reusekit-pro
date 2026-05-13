import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmSkuManagementView extends StatefulWidget {
  const IwmSkuManagementView({super.key});

  @override
  State<IwmSkuManagementView> createState() => _IwmSkuManagementViewState();
}

class _IwmSkuManagementViewState extends State<IwmSkuManagementView> {
  int selectedTab = 0;
  String selectedCategory = "all";
  String selectedStatus = "all";
  String searchQuery = "";
  
  List<Map<String, dynamic>> categories = [
    {"label": "All Categories", "value": "all"},
    {"label": "Electronics", "value": "electronics"},
    {"label": "Clothing", "value": "clothing"},
    {"label": "Home & Garden", "value": "home"},
    {"label": "Sports", "value": "sports"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Inactive", "value": "inactive"},
    {"label": "Discontinued", "value": "discontinued"},
  ];

  List<Map<String, dynamic>> skuList = [
    {
      "id": "SKU001",
      "sku": "WH-2024-001",
      "name": "Wireless Headphones",
      "category": "electronics",
      "brand": "TechSound",
      "variant": "Black, Bluetooth 5.0",
      "barcode": "123456789012",
      "price": 89.99,
      "cost": 45.50,
      "stock": 125,
      "lowStockLevel": 20,
      "status": "active",
      "created": "2024-01-10",
      "lastUpdated": "2024-01-15",
      "image": "https://picsum.photos/60/60?random=1&keyword=headphones"
    },
    {
      "id": "SKU002",
      "sku": "SW-2024-002",
      "name": "Smart Watch",
      "category": "electronics",
      "brand": "SmartTech",
      "variant": "Silver, GPS",
      "barcode": "987654321098",
      "price": 199.99,
      "cost": 120.00,
      "stock": 78,
      "lowStockLevel": 15,
      "status": "active",
      "created": "2024-01-08",
      "lastUpdated": "2024-01-14",
      "image": "https://picsum.photos/60/60?random=2&keyword=watch"
    },
    {
      "id": "SKU003",
      "sku": "RS-2024-003",
      "name": "Running Shoes",
      "category": "sports",
      "brand": "RunFast",
      "variant": "Blue, Size 42",
      "barcode": "456789123456",
      "price": 79.99,
      "cost": 35.00,
      "stock": 12,
      "lowStockLevel": 20,
      "status": "active",
      "created": "2024-01-05",
      "lastUpdated": "2024-01-16",
      "image": "https://picsum.photos/60/60?random=3&keyword=shoes"
    },
    {
      "id": "SKU004",
      "sku": "CT-2024-004",
      "name": "Cotton T-Shirt",
      "category": "clothing",
      "brand": "ComfortWear",
      "variant": "White, Size M",
      "barcode": "789123456789",
      "price": 24.99,
      "cost": 8.50,
      "stock": 0,
      "lowStockLevel": 50,
      "status": "inactive",
      "created": "2024-01-03",
      "lastUpdated": "2024-01-12",
      "image": "https://picsum.photos/60/60?random=4&keyword=shirt"
    },
    {
      "id": "SKU005",
      "sku": "GT-2024-005",
      "name": "Garden Tools Set",
      "category": "home",
      "brand": "GreenThumb",
      "variant": "Complete Set",
      "barcode": "321654987321",
      "price": 149.99,
      "cost": 89.00,
      "stock": 45,
      "lowStockLevel": 10,
      "status": "discontinued",
      "created": "2023-12-20",
      "lastUpdated": "2024-01-10",
      "image": "https://picsum.photos/60/60?random=5&keyword=tools"
    },
  ];

  List<Map<String, dynamic>> skuStats = [
    {
      "title": "Total SKUs",
      "value": 1248,
      "subtitle": "All Products",
      "icon": Icons.inventory_2,
      "color": primaryColor,
    },
    {
      "title": "Active SKUs",
      "value": 1089,
      "subtitle": "87% Active",
      "icon": Icons.check_circle,
      "color": successColor,
    },
    {
      "title": "Low Stock",
      "value": 34,
      "subtitle": "Need Reorder",
      "icon": Icons.warning,
      "color": warningColor,
    },
    {
      "title": "Out of Stock",
      "value": 12,
      "subtitle": "Urgent",
      "icon": Icons.error,
      "color": dangerColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "SKU Management",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "SKU List", icon: Icon(Icons.list)),
        Tab(text: "Generator", icon: Icon(Icons.auto_awesome)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildSkuListTab(),
        _buildGeneratorTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSkuStats(),
          _buildQuickActions(),
          _buildRecentSkus(),
          _buildLowStockAlert(),
        ],
      ),
    );
  }

  Widget _buildSkuListTab() {
    List<Map<String, dynamic>> filteredSkus = skuList.where((sku) {
      bool categoryMatch = selectedCategory == "all" || sku["category"] == selectedCategory;
      bool statusMatch = selectedStatus == "all" || sku["status"] == selectedStatus;
      bool searchMatch = searchQuery.isEmpty || 
          (sku["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (sku["sku"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (sku["brand"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      return categoryMatch && statusMatch && searchMatch;
    }).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSkuFilters(),
          _buildSkuListView(filteredSkus),
        ],
      ),
    );
  }

  Widget _buildGeneratorTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSkuGenerator(),
          _buildGeneratorSettings(),
          _buildBulkGenerator(),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSkuAnalytics(),
          _buildCategoryDistribution(),
          _buildPerformanceMetrics(),
        ],
      ),
    );
  }

  Widget _buildSkuStats() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: skuStats.map((stat) => _buildStatCard(stat)).toList(),
    );
  }

  Widget _buildStatCard(Map<String, dynamic> stat) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spXs,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: (stat["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  stat["icon"],
                  color: stat["color"],
                  size: 20,
                ),
              ),
            ],
          ),
          Text(
            "${stat["value"]}",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "${stat["title"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Text(
            "${stat["subtitle"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  label: "Add SKU",
                  icon: Icons.add,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Import CSV",
                  icon: Icons.upload_file,
                  onPressed: () {},
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Export List",
                  icon: Icons.download,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Generate Batch",
                  icon: Icons.auto_awesome,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentSkus() {
    List<Map<String, dynamic>> recentSkus = skuList.take(3).toList();
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Recently Added SKUs",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                label: "View All",
                size: bs.sm,
                onPressed: () {
                  selectedTab = 1;
                  setState(() {});
                },
              ),
            ],
          ),
          ...recentSkus.map((sku) => _buildRecentSkuItem(sku)),
        ],
      ),
    );
  }

  Widget _buildRecentSkuItem(Map<String, dynamic> sku) {
    Color statusColor = _getStatusColor(sku["status"]);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(3),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusXs),
            child: Image.network(
              "${sku["image"]}",
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
                  "${sku["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${sku["sku"]} • Stock: ${sku["stock"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
            decoration: BoxDecoration(
              color: statusColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "${sku["status"]}",
              style: TextStyle(
                color: statusColor,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLowStockAlert() {
    List<Map<String, dynamic>> lowStockItems = skuList.where((sku) => 
        (sku["stock"] as int) <= (sku["lowStockLevel"] as int)).toList();
    
    if (lowStockItems.isEmpty) return SizedBox();
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.warning, color: warningColor, size: 20),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "Low Stock Alert",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: warningColor,
                  ),
                ),
              ),
              QButton(
                label: "Reorder All",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          ...lowStockItems.take(3).map((sku) => _buildLowStockItem(sku)),
          if (lowStockItems.length > 3)
            Text(
              "And ${lowStockItems.length - 3} more items...",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
                fontStyle: FontStyle.italic,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLowStockItem(Map<String, dynamic> sku) {
    bool isOutOfStock = (sku["stock"] as int) == 0;
    Color alertColor = isOutOfStock ? dangerColor : warningColor;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: alertColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: alertColor.withAlpha(50)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusXs),
            child: Image.network(
              "${sku["image"]}",
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
                  "${sku["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${sku["sku"]} • Stock: ${sku["stock"]} (Min: ${sku["lowStockLevel"]})",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            label: "Reorder",
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSkuFilters() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(Icons.search, color: disabledBoldColor, size: 20),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QTextField(
                        label: "Search SKUs...",
                        value: searchQuery,
                        onChanged: (value) {
                          searchQuery = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.filter_list,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: categories,
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
                  label: "Status",
                  items: statusOptions,
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
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

  Widget _buildSkuListView(List<Map<String, dynamic>> skus) {
    return Column(
      spacing: spSm,
      children: skus.map((sku) => _buildSkuCard(sku)).toList(),
    );
  }

  Widget _buildSkuCard(Map<String, dynamic> sku) {
    Color statusColor = _getStatusColor(sku["status"]);
    bool isLowStock = (sku["stock"] as int) <= (sku["lowStockLevel"] as int);
    bool isOutOfStock = (sku["stock"] as int) == 0;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${sku["image"]}",
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${sku["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "SKU: ${sku["sku"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${sku["brand"]} • ${sku["variant"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Barcode: ${sku["barcode"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${sku["status"]}",
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  if (isOutOfStock) ...[
                    SizedBox(height: spXs),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: dangerColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "Out of Stock",
                        style: TextStyle(
                          color: dangerColor,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ] else if (isLowStock) ...[
                    SizedBox(height: spXs),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "Low Stock",
                        style: TextStyle(
                          color: warningColor,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Price",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "\$${(sku["price"] as double).toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: spSm),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Cost",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "\$${(sku["cost"] as double).toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: spSm),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Stock",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${sku["stock"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: isOutOfStock ? dangerColor : isLowStock ? warningColor : successColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  QButton(
                    icon: Icons.edit,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                  SizedBox(width: spXs),
                  QButton(
                    icon: Icons.more_vert,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSkuGenerator() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "SKU Generator",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: categories.where((cat) => cat["value"] != "all").toList(),
                  value: "electronics",
                  onChanged: (value, label) {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Brand Code",
                  value: "TEC",
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Product Code",
                  value: "WH",
                  onChanged: (value) {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QNumberField(
                  label: "Starting Number",
                  value: "001",
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: primaryColor.withAlpha(50)),
            ),
            child: Row(
              children: [
                Icon(Icons.preview, color: primaryColor, size: 20),
                SizedBox(width: spXs),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Generated SKU Preview",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "TEC-WH-2024-001",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                QButton(
                  label: "Generate",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGeneratorSettings() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Generator Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Format Pattern",
                  items: [
                    {"label": "BRAND-PRODUCT-YEAR-NUMBER", "value": "brand_product_year_number"},
                    {"label": "CATEGORY-BRAND-NUMBER", "value": "category_brand_number"},
                    {"label": "PRODUCT-VARIANT-NUMBER", "value": "product_variant_number"},
                  ],
                  value: "brand_product_year_number",
                  onChanged: (value, label) {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Number Format",
                  items: [
                    {"label": "3 Digits (001)", "value": "3"},
                    {"label": "4 Digits (0001)", "value": "4"},
                    {"label": "5 Digits (00001)", "value": "5"},
                  ],
                  value: "3",
                  onChanged: (value, label) {},
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Include Year",
                      "value": true,
                      "checked": true,
                    }
                  ],
                  value: [{"label": "Include Year", "value": true, "checked": true}],
                  onChanged: (values, ids) {},
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Auto-increment Numbers",
                      "value": true,
                      "checked": true,
                    }
                  ],
                  value: [{"label": "Auto-increment Numbers", "value": true, "checked": true}],
                  onChanged: (values, ids) {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBulkGenerator() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Bulk SKU Generation",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QNumberField(
                  label: "Quantity",
                  value: "10",
                  onChanged: (value) {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Prefix",
                  value: "BULK",
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
          Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: disabledOutlineBorderColor),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.preview,
                    size: 32,
                    color: primaryColor.withAlpha(100),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Bulk generation preview",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Generate Bulk",
                  icon: Icons.auto_awesome,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Export CSV",
                  icon: Icons.download,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSkuAnalytics() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "SKU Analytics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: disabledOutlineBorderColor),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.analytics,
                    size: 48,
                    color: primaryColor.withAlpha(100),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "SKU Performance Analytics",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 14,
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

  Widget _buildCategoryDistribution() {
    List<Map<String, dynamic>> categoryData = [
      {"category": "Electronics", "count": 450, "percentage": 36.1},
      {"category": "Clothing", "count": 312, "percentage": 25.0},
      {"category": "Home & Garden", "count": 278, "percentage": 22.3},
      {"category": "Sports", "count": 208, "percentage": 16.6},
    ];

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Category Distribution",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...categoryData.map((category) => _buildCategoryItem(category)),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(Map<String, dynamic> category) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(3),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${category["category"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${category["count"]} SKUs (${(category["percentage"] as double).toStringAsFixed(1)}%)",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 100,
            height: 4,
            decoration: BoxDecoration(
              color: disabledOutlineBorderColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: (category["percentage"] as double) / 100,
              child: Container(
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceMetrics() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Performance Metrics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildMetricCard("Avg Stock Level", "78 units", Icons.inventory),
              _buildMetricCard("Avg Profit Margin", "42.5%", Icons.trending_up),
              _buildMetricCard("SKUs Added Today", "12", Icons.add_circle),
              _buildMetricCard("Inactive SKUs", "89", Icons.pause_circle),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        spacing: spXs,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: primaryColor, size: 20),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "active":
        return successColor;
      case "inactive":
        return warningColor;
      case "discontinued":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }
}
