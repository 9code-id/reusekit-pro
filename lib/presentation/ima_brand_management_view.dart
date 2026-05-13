import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaBrandManagementView extends StatefulWidget {
  const ImaBrandManagementView({super.key});

  @override
  State<ImaBrandManagementView> createState() => _ImaBrandManagementViewState();
}

class _ImaBrandManagementViewState extends State<ImaBrandManagementView> {
  String searchQuery = "";
  String selectedCategory = "all";
  String selectedStatus = "all";
  String sortBy = "name";
  
  List<Map<String, dynamic>> brands = [
    {
      "id": "BRD001",
      "name": "Apple",
      "description": "Premium technology brand",
      "logo": "https://picsum.photos/100/100?random=1&keyword=apple",
      "website": "https://apple.com",
      "category": "Electronics",
      "country": "United States",
      "establishedYear": 1976,
      "productCount": 245,
      "totalSales": 2500000.0,
      "commission": 5.5,
      "isActive": true,
      "isFeatured": true,
      "rating": 4.8,
      "reviewCount": 15420,
      "lastOrderDate": "2024-03-15",
      "contactEmail": "partnership@apple.com",
      "contactPhone": "+1-800-275-2273",
      "tags": ["premium", "technology", "innovation"],
    },
    {
      "id": "BRD002",
      "name": "Samsung",
      "description": "Leading electronics manufacturer",
      "logo": "https://picsum.photos/100/100?random=2&keyword=samsung",
      "website": "https://samsung.com",
      "category": "Electronics",
      "country": "South Korea",
      "establishedYear": 1938,
      "productCount": 198,
      "totalSales": 1850000.0,
      "commission": 4.8,
      "isActive": true,
      "isFeatured": true,
      "rating": 4.6,
      "reviewCount": 12350,
      "lastOrderDate": "2024-03-14",
      "contactEmail": "business@samsung.com",
      "contactPhone": "+82-2-2255-0114",
      "tags": ["electronics", "mobile", "display"],
    },
    {
      "id": "BRD003",
      "name": "Nike",
      "description": "Global sports and lifestyle brand",
      "logo": "https://picsum.photos/100/100?random=3&keyword=nike",
      "website": "https://nike.com",
      "category": "Sports",
      "country": "United States",
      "establishedYear": 1964,
      "productCount": 567,
      "totalSales": 3200000.0,
      "commission": 8.2,
      "isActive": true,
      "isFeatured": true,
      "rating": 4.7,
      "reviewCount": 28940,
      "lastOrderDate": "2024-03-16",
      "contactEmail": "partnerships@nike.com",
      "contactPhone": "+1-503-671-6453",
      "tags": ["sports", "lifestyle", "footwear"],
    },
    {
      "id": "BRD004",
      "name": "Adidas",
      "description": "German sports brand",
      "logo": "https://picsum.photos/100/100?random=4&keyword=adidas",
      "website": "https://adidas.com",
      "category": "Sports",
      "country": "Germany",
      "establishedYear": 1949,
      "productCount": 423,
      "totalSales": 2100000.0,
      "commission": 7.5,
      "isActive": true,
      "isFeatured": false,
      "rating": 4.5,
      "reviewCount": 18720,
      "lastOrderDate": "2024-03-13",
      "contactEmail": "business@adidas.com",
      "contactPhone": "+49-9132-84-0",
      "tags": ["sports", "performance", "style"],
    },
    {
      "id": "BRD005",
      "name": "H&M",
      "description": "Fast fashion retailer",
      "logo": "https://picsum.photos/100/100?random=5&keyword=fashion",
      "website": "https://hm.com",
      "category": "Fashion",
      "country": "Sweden",
      "establishedYear": 1947,
      "productCount": 1250,
      "totalSales": 1650000.0,
      "commission": 12.0,
      "isActive": true,
      "isFeatured": false,
      "rating": 4.2,
      "reviewCount": 24580,
      "lastOrderDate": "2024-03-12",
      "contactEmail": "business@hm.com",
      "contactPhone": "+46-8-796-55-00",
      "tags": ["fashion", "affordable", "trendy"],
    },
    {
      "id": "BRD006",
      "name": "Zara",
      "description": "Spanish fashion retailer",
      "logo": "https://picsum.photos/100/100?random=6&keyword=zara",
      "website": "https://zara.com",
      "category": "Fashion",
      "country": "Spain",
      "establishedYear": 1975,
      "productCount": 890,
      "totalSales": 2850000.0,
      "commission": 10.5,
      "isActive": true,
      "isFeatured": true,
      "rating": 4.4,
      "reviewCount": 31250,
      "lastOrderDate": "2024-03-17",
      "contactEmail": "corporate@zara.com",
      "contactPhone": "+34-981-18-54-00",
      "tags": ["fashion", "luxury", "design"],
    },
    {
      "id": "BRD007",
      "name": "Canon",
      "description": "Imaging and optical products",
      "logo": "https://picsum.photos/100/100?random=7&keyword=camera",
      "website": "https://canon.com",
      "category": "Electronics",
      "country": "Japan",
      "establishedYear": 1937,
      "productCount": 156,
      "totalSales": 980000.0,
      "commission": 6.0,
      "isActive": false,
      "isFeatured": false,
      "rating": 4.6,
      "reviewCount": 8450,
      "lastOrderDate": "2024-02-28",
      "contactEmail": "business@canon.com",
      "contactPhone": "+81-3-3758-2111",
      "tags": ["photography", "imaging", "professional"],
    },
    {
      "id": "BRD008",
      "name": "IKEA",
      "description": "Swedish furniture and home goods",
      "logo": "https://picsum.photos/100/100?random=8&keyword=furniture",
      "website": "https://ikea.com",
      "category": "Home & Garden",
      "country": "Sweden",
      "establishedYear": 1943,
      "productCount": 2340,
      "totalSales": 4200000.0,
      "commission": 15.0,
      "isActive": true,
      "isFeatured": true,
      "rating": 4.3,
      "reviewCount": 45680,
      "lastOrderDate": "2024-03-18",
      "contactEmail": "business@ikea.com",
      "contactPhone": "+46-476-81000",
      "tags": ["furniture", "home", "affordable"],
    },
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All Categories", "value": "all"},
    {"label": "Electronics", "value": "Electronics"},
    {"label": "Sports", "value": "Sports"},
    {"label": "Fashion", "value": "Fashion"},
    {"label": "Home & Garden", "value": "Home & Garden"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Inactive", "value": "inactive"},
    {"label": "Featured", "value": "featured"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Name (A-Z)", "value": "name"},
    {"label": "Total Sales", "value": "totalSales"},
    {"label": "Commission Rate", "value": "commission"},
    {"label": "Product Count", "value": "productCount"},
    {"label": "Rating", "value": "rating"},
  ];

  List<Map<String, dynamic>> get filteredBrands {
    List<Map<String, dynamic>> filtered = brands.where((brand) {
      bool matchesSearch = (brand["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (brand["description"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (brand["tags"] as List).any((tag) => tag.toString().toLowerCase().contains(searchQuery.toLowerCase()));
      
      bool matchesCategory = selectedCategory == "all" || brand["category"] == selectedCategory;
      
      bool matchesStatus = true;
      switch (selectedStatus) {
        case "active":
          matchesStatus = brand["isActive"] as bool;
          break;
        case "inactive":
          matchesStatus = !(brand["isActive"] as bool);
          break;
        case "featured":
          matchesStatus = brand["isFeatured"] as bool;
          break;
        default:
          matchesStatus = true;
      }
      
      return matchesSearch && matchesCategory && matchesStatus;
    }).toList();

    // Sort filtered results
    filtered.sort((a, b) {
      switch (sortBy) {
        case "totalSales":
          return (b["totalSales"] as double).compareTo(a["totalSales"] as double);
        case "commission":
          return (b["commission"] as double).compareTo(a["commission"] as double);
        case "productCount":
          return (b["productCount"] as int).compareTo(a["productCount"] as int);
        case "rating":
          return (b["rating"] as double).compareTo(a["rating"] as double);
        default:
          return (a["name"] as String).compareTo(b["name"] as String);
      }
    });

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Brand Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _addNewBrand();
            },
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              _viewAnalytics();
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              _showMoreOptions();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filter Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  // Search Bar
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm),
                          decoration: BoxDecoration(
                            color: Colors.grey.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: TextField(
                            onChanged: (value) {
                              searchQuery = value;
                              setState(() {});
                            },
                            decoration: InputDecoration(
                              hintText: "Search brands...",
                              border: InputBorder.none,
                              icon: Icon(Icons.search, color: disabledBoldColor),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.sort,
                        size: bs.sm,
                        onPressed: () {
                          _showSortOptions();
                        },
                      ),
                    ],
                  ),

                  // Filters Row
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm),
                          decoration: BoxDecoration(
                            color: Colors.grey.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: DropdownButton<String>(
                            value: selectedCategory,
                            isExpanded: true,
                            underline: SizedBox(),
                            items: categories.map((category) {
                              return DropdownMenuItem<String>(
                                value: "${category["value"]}",
                                child: Text("${category["label"]}"),
                              );
                            }).toList(),
                            onChanged: (value) {
                              selectedCategory = value!;
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm),
                          decoration: BoxDecoration(
                            color: Colors.grey.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: DropdownButton<String>(
                            value: selectedStatus,
                            isExpanded: true,
                            underline: SizedBox(),
                            items: statusOptions.map((status) {
                              return DropdownMenuItem<String>(
                                value: "${status["value"]}",
                                child: Text("${status["label"]}"),
                              );
                            }).toList(),
                            onChanged: (value) {
                              selectedStatus = value!;
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Statistics Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildStatCard("Total Brands", "${brands.length}", Icons.business, primaryColor),
                _buildStatCard("Active Brands", "${brands.where((b) => b["isActive"] as bool).length}", Icons.check_circle, successColor),
                _buildStatCard("Featured Brands", "${brands.where((b) => b["isFeatured"] as bool).length}", Icons.star, warningColor),
                _buildStatCard("Total Sales", "\$${(brands.fold(0.0, (sum, b) => sum + (b["totalSales"] as double)) / 1000000).toStringAsFixed(1)}M", Icons.attach_money, infoColor),
              ],
            ),

            // Results Header
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Text(
                    "${filteredBrands.length} brands found",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      _bulkActions();
                    },
                    child: Text(
                      "Bulk Actions",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Brands Grid
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: filteredBrands.map((brand) => _buildBrandCard(brand)).toList(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addNewBrand();
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 32,
            color: color,
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBrandCard(Map<String, dynamic> brand) {
    Color statusColor = (brand["isActive"] as bool) ? successColor : dangerColor;
    bool isFeatured = brand["isFeatured"] as bool;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: isFeatured ? Border.all(color: warningColor, width: 2) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Brand Logo and Header
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(radiusSm),
                    child: Image.network(
                      "${brand["logo"]}",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${brand["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          if (isFeatured)
                            Icon(
                              Icons.star,
                              size: 16,
                              color: warningColor,
                            ),
                        ],
                      ),
                      Text(
                        "${brand["country"]} • Est. ${brand["establishedYear"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                QButton(
                  icon: Icons.more_vert,
                  size: bs.sm,
                  onPressed: () {
                    _showBrandActions(brand);
                  },
                ),
              ],
            ),
          ),

          // Description
          Padding(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: Text(
              "${brand["description"]}",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          SizedBox(height: spSm),

          // Category and Status
          Padding(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${brand["category"]}",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: infoColor,
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: statusColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    (brand["isActive"] as bool) ? "Active" : "Inactive",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: statusColor,
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: spMd),

          // Metrics
          Padding(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildMetricItem("Products", "${brand["productCount"]}", Icons.inventory),
                    ),
                    Expanded(
                      child: _buildMetricItem("Commission", "${brand["commission"]}%", Icons.percent),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildMetricItem("Sales", "\$${((brand["totalSales"] as double) / 1000).toStringAsFixed(0)}K", Icons.trending_up),
                    ),
                    Expanded(
                      child: _buildMetricItem("Rating", "${brand["rating"]}", Icons.star),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: spMd),

          // Tags
          Padding(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: QHorizontalScroll(
              children: (brand["tags"] as List).map((tag) {
                return Container(
                  margin: EdgeInsets.only(right: spXs),
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: Colors.grey.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "$tag",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          SizedBox(height: spMd),

          // Action Buttons
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Edit",
                    size: bs.sm,
                    onPressed: () {
                      _editBrand(brand);
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Products",
                    size: bs.sm,
                    onPressed: () {
                      _viewBrandProducts(brand);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricItem(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 14,
            color: disabledBoldColor,
          ),
          SizedBox(width: spSm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
          ),
        ],
      ),
    );
  }

  void _showMoreOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                child: Row(
                  children: [
                    Icon(Icons.import_export, color: primaryColor),
                    SizedBox(width: spSm),
                    Text("Import Brands"),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                child: Row(
                  children: [
                    Icon(Icons.download, color: primaryColor),
                    SizedBox(width: spSm),
                    Text("Export Brands"),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                child: Row(
                  children: [
                    Icon(Icons.analytics, color: primaryColor),
                    SizedBox(width: spSm),
                    Text("Brand Analytics"),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                child: Row(
                  children: [
                    Icon(Icons.settings, color: primaryColor),
                    SizedBox(width: spSm),
                    Text("Brand Settings"),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Sort Brands",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              ...sortOptions.map((option) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  child: Row(
                    children: [
                      Radio<String>(
                        value: "${option["value"]}",
                        groupValue: sortBy,
                        onChanged: (value) {
                          sortBy = value!;
                          setState(() {});
                          Navigator.pop(context);
                        },
                      ),
                      Text("${option["label"]}"),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }

  void _showBrandActions(Map<String, dynamic> brand) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                child: Row(
                  children: [
                    Icon(Icons.edit, color: primaryColor),
                    SizedBox(width: spSm),
                    Text("Edit Brand"),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                child: Row(
                  children: [
                    Icon(Icons.inventory, color: primaryColor),
                    SizedBox(width: spSm),
                    Text("View Products"),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                child: Row(
                  children: [
                    Icon(Icons.analytics, color: primaryColor),
                    SizedBox(width: spSm),
                    Text("Brand Analytics"),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                child: Row(
                  children: [
                    Icon(Icons.contact_mail, color: primaryColor),
                    SizedBox(width: spSm),
                    Text("Contact Brand"),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                child: Row(
                  children: [
                    Icon(Icons.delete, color: dangerColor),
                    SizedBox(width: spSm),
                    Text("Delete Brand"),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _addNewBrand() {
    si("Add new brand feature coming soon!");
  }

  void _viewAnalytics() {
    si("Brand analytics feature coming soon!");
  }

  void _bulkActions() {
    si("Bulk actions feature coming soon!");
  }

  void _editBrand(Map<String, dynamic> brand) {
    si("Edit brand: ${brand["name"]}");
  }

  void _viewBrandProducts(Map<String, dynamic> brand) {
    si("View products for brand: ${brand["name"]}");
  }
}
