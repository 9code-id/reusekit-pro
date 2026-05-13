import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmProductBundlesView extends StatefulWidget {
  const IwmProductBundlesView({super.key});

  @override
  State<IwmProductBundlesView> createState() => _IwmProductBundlesViewState();
}

class _IwmProductBundlesViewState extends State<IwmProductBundlesView> {
  int selectedTab = 0;
  String searchQuery = "";
  String selectedStatus = "all";
  String selectedCategory = "all";
  String sortBy = "name";
  bool showInactive = false;

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Inactive", "value": "inactive"},
    {"label": "Draft", "value": "draft"},
    {"label": "Out of Stock", "value": "out_of_stock"},
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "all"},
    {"label": "Electronics", "value": "electronics"},
    {"label": "Fashion", "value": "fashion"},
    {"label": "Home & Garden", "value": "home_garden"},
    {"label": "Sports", "value": "sports"},
    {"label": "Books", "value": "books"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Bundle Name", "value": "name"},
    {"label": "Price", "value": "price"},
    {"label": "Discount", "value": "discount"},
    {"label": "Sales", "value": "sales"},
    {"label": "Created Date", "value": "created"},
  ];

  List<Map<String, dynamic>> bundleStats = [
    {
      "title": "Total Bundles",
      "value": 45,
      "subtitle": "Active Bundles",
      "icon": Icons.inventory_2,
      "color": primaryColor
    },
    {
      "title": "Bundle Revenue",
      "value": 156780,
      "subtitle": "This Month",
      "icon": Icons.attach_money,
      "color": successColor,
      "isCurrency": true
    },
    {
      "title": "Avg Savings",
      "value": 23.5,
      "subtitle": "Customer Discount",
      "icon": Icons.savings,
      "color": infoColor,
      "isPercentage": true
    },
    {
      "title": "Bundle Sales",
      "value": 287,
      "subtitle": "This Month",
      "icon": Icons.trending_up,
      "color": warningColor
    },
  ];

  List<Map<String, dynamic>> productBundles = [
    {
      "id": 1,
      "name": "Home Office Essential",
      "description": "Complete setup for productive home office work",
      "status": "active",
      "category": "electronics",
      "image": "https://picsum.photos/100/100?random=1&keyword=office",
      "originalPrice": 2499.00,
      "bundlePrice": 1999.00,
      "discount": 20.0,
      "savings": 500.00,
      "stock": 25,
      "salesCount": 42,
      "createdAt": "2023-11-15",
      "updatedAt": "2024-01-10",
      "items": [
        {
          "productId": "laptop001",
          "name": "Dell XPS 13 Laptop",
          "price": 1299.00,
          "quantity": 1,
          "image": "https://picsum.photos/60/60?random=11&keyword=laptop"
        },
        {
          "productId": "monitor001",
          "name": "24\" Monitor",
          "price": 299.00,
          "quantity": 1,
          "image": "https://picsum.photos/60/60?random=12&keyword=monitor"
        },
        {
          "productId": "keyboard001",
          "name": "Wireless Keyboard & Mouse",
          "price": 89.00,
          "quantity": 1,
          "image": "https://picsum.photos/60/60?random=13&keyword=keyboard"
        },
        {
          "productId": "webcam001",
          "name": "HD Webcam",
          "price": 159.00,
          "quantity": 1,
          "image": "https://picsum.photos/60/60?random=14&keyword=webcam"
        },
        {
          "productId": "headset001",
          "name": "Noise-Cancelling Headset",
          "price": 199.00,
          "quantity": 1,
          "image": "https://picsum.photos/60/60?random=15&keyword=headset"
        },
        {
          "productId": "desk001",
          "name": "Adjustable Standing Desk",
          "price": 454.00,
          "quantity": 1,
          "image": "https://picsum.photos/60/60?random=16&keyword=desk"
        }
      ]
    },
    {
      "id": 2,
      "name": "Gaming Pro Setup",
      "description": "Ultimate gaming experience with high-performance components",
      "status": "active",
      "category": "electronics",
      "image": "https://picsum.photos/100/100?random=2&keyword=gaming",
      "originalPrice": 3299.00,
      "bundlePrice": 2799.00,
      "discount": 15.2,
      "savings": 500.00,
      "stock": 12,
      "salesCount": 28,
      "createdAt": "2023-10-20",
      "updatedAt": "2024-01-08",
      "items": [
        {
          "productId": "gpu001",
          "name": "RTX 4070 Graphics Card",
          "price": 1299.00,
          "quantity": 1,
          "image": "https://picsum.photos/60/60?random=21&keyword=gpu"
        },
        {
          "productId": "monitor002",
          "name": "27\" Gaming Monitor 144Hz",
          "price": 399.00,
          "quantity": 1,
          "image": "https://picsum.photos/60/60?random=22&keyword=gaming"
        },
        {
          "productId": "keyboard002",
          "name": "Mechanical Gaming Keyboard",
          "price": 149.00,
          "quantity": 1,
          "image": "https://picsum.photos/60/60?random=23&keyword=mechanical"
        },
        {
          "productId": "mouse001",
          "name": "Gaming Mouse",
          "price": 79.00,
          "quantity": 1,
          "image": "https://picsum.photos/60/60?random=24&keyword=mouse"
        },
        {
          "productId": "headset002",
          "name": "Gaming Headset RGB",
          "price": 129.00,
          "quantity": 1,
          "image": "https://picsum.photos/60/60?random=25&keyword=headset"
        },
        {
          "productId": "chair001",
          "name": "Gaming Chair Ergonomic",
          "price": 299.00,
          "quantity": 1,
          "image": "https://picsum.photos/60/60?random=26&keyword=chair"
        },
        {
          "productId": "mousepad001",
          "name": "Large Gaming Mousepad",
          "price": 39.00,
          "quantity": 1,
          "image": "https://picsum.photos/60/60?random=27&keyword=mousepad"
        }
      ]
    },
    {
      "id": 3,
      "name": "Fitness Starter Pack",
      "description": "Everything you need to start your home fitness journey",
      "status": "active",
      "category": "sports",
      "image": "https://picsum.photos/100/100?random=3&keyword=fitness",
      "originalPrice": 899.00,
      "bundlePrice": 649.00,
      "discount": 27.8,
      "savings": 250.00,
      "stock": 18,
      "salesCount": 35,
      "createdAt": "2023-12-01",
      "updatedAt": "2024-01-05",
      "items": [
        {
          "productId": "dumbbell001",
          "name": "Adjustable Dumbbells Set",
          "price": 299.00,
          "quantity": 1,
          "image": "https://picsum.photos/60/60?random=31&keyword=dumbbell"
        },
        {
          "productId": "mat001",
          "name": "Yoga Mat Premium",
          "price": 49.00,
          "quantity": 1,
          "image": "https://picsum.photos/60/60?random=32&keyword=yoga"
        },
        {
          "productId": "resistance001",
          "name": "Resistance Bands Set",
          "price": 35.00,
          "quantity": 1,
          "image": "https://picsum.photos/60/60?random=33&keyword=resistance"
        },
        {
          "productId": "kettlebell001",
          "name": "Kettlebell 20lbs",
          "price": 79.00,
          "quantity": 1,
          "image": "https://picsum.photos/60/60?random=34&keyword=kettlebell"
        },
        {
          "productId": "water001",
          "name": "Smart Water Bottle",
          "price": 59.00,
          "quantity": 1,
          "image": "https://picsum.photos/60/60?random=35&keyword=bottle"
        },
        {
          "productId": "towel001",
          "name": "Workout Towel Set",
          "price": 29.00,
          "quantity": 2,
          "image": "https://picsum.photos/60/60?random=36&keyword=towel"
        },
        {
          "productId": "tracker001",
          "name": "Fitness Tracker",
          "price": 199.00,
          "quantity": 1,
          "image": "https://picsum.photos/60/60?random=37&keyword=tracker"
        }
      ]
    },
    {
      "id": 4,
      "name": "Kitchen Essentials Pro",
      "description": "Professional-grade kitchen tools for cooking enthusiasts",
      "status": "active",
      "category": "home_garden",
      "image": "https://picsum.photos/100/100?random=4&keyword=kitchen",
      "originalPrice": 1299.00,
      "bundlePrice": 999.00,
      "discount": 23.1,
      "savings": 300.00,
      "stock": 8,
      "salesCount": 19,
      "createdAt": "2023-09-10",
      "updatedAt": "2024-01-03",
      "items": [
        {
          "productId": "blender001",
          "name": "High-Speed Blender",
          "price": 299.00,
          "quantity": 1,
          "image": "https://picsum.photos/60/60?random=41&keyword=blender"
        },
        {
          "productId": "knife001",
          "name": "Chef's Knife Set",
          "price": 199.00,
          "quantity": 1,
          "image": "https://picsum.photos/60/60?random=42&keyword=knife"
        },
        {
          "productId": "pan001",
          "name": "Non-Stick Pan Set",
          "price": 149.00,
          "quantity": 1,
          "image": "https://picsum.photos/60/60?random=43&keyword=pan"
        },
        {
          "productId": "cutting001",
          "name": "Bamboo Cutting Board",
          "price": 45.00,
          "quantity": 1,
          "image": "https://picsum.photos/60/60?random=44&keyword=cutting"
        },
        {
          "productId": "mixer001",
          "name": "Stand Mixer",
          "price": 399.00,
          "quantity": 1,
          "image": "https://picsum.photos/60/60?random=45&keyword=mixer"
        },
        {
          "productId": "scale001",
          "name": "Digital Kitchen Scale",
          "price": 35.00,
          "quantity": 1,
          "image": "https://picsum.photos/60/60?random=46&keyword=scale"
        }
      ]
    },
    {
      "id": 5,
      "name": "Student Study Bundle",
      "description": "Complete study setup for students and professionals",
      "status": "draft",
      "category": "books",
      "image": "https://picsum.photos/100/100?random=5&keyword=study",
      "originalPrice": 459.00,
      "bundlePrice": 349.00,
      "discount": 24.0,
      "savings": 110.00,
      "stock": 0,
      "salesCount": 12,
      "createdAt": "2023-08-15",
      "updatedAt": "2023-12-28",
      "items": [
        {
          "productId": "notebook001",
          "name": "Premium Notebook Set",
          "price": 89.00,
          "quantity": 3,
          "image": "https://picsum.photos/60/60?random=51&keyword=notebook"
        },
        {
          "productId": "pen001",
          "name": "Fountain Pen Collection",
          "price": 129.00,
          "quantity": 1,
          "image": "https://picsum.photos/60/60?random=52&keyword=pen"
        },
        {
          "productId": "lamp001",
          "name": "LED Desk Lamp",
          "price": 79.00,
          "quantity": 1,
          "image": "https://picsum.photos/60/60?random=53&keyword=lamp"
        },
        {
          "productId": "organizer001",
          "name": "Desk Organizer",
          "price": 49.00,
          "quantity": 1,
          "image": "https://picsum.photos/60/60?random=54&keyword=organizer"
        },
        {
          "productId": "calendar001",
          "name": "Planner & Calendar",
          "price": 29.00,
          "quantity": 1,
          "image": "https://picsum.photos/60/60?random=55&keyword=planner"
        }
      ]
    },
    {
      "id": 6,
      "name": "Fashion Weekend Set",
      "description": "Stylish outfit combinations for weekend activities",
      "status": "out_of_stock",
      "category": "fashion",
      "image": "https://picsum.photos/100/100?random=6&keyword=fashion",
      "originalPrice": 599.00,
      "bundlePrice": 449.00,
      "discount": 25.0,
      "savings": 150.00,
      "stock": 0,
      "salesCount": 8,
      "createdAt": "2023-07-20",
      "updatedAt": "2023-12-25",
      "items": [
        {
          "productId": "shirt001",
          "name": "Casual Shirt",
          "price": 89.00,
          "quantity": 2,
          "image": "https://picsum.photos/60/60?random=61&keyword=shirt"
        },
        {
          "productId": "jeans001",
          "name": "Premium Jeans",
          "price": 129.00,
          "quantity": 1,
          "image": "https://picsum.photos/60/60?random=62&keyword=jeans"
        },
        {
          "productId": "shoes001",
          "name": "Casual Sneakers",
          "price": 149.00,
          "quantity": 1,
          "image": "https://picsum.photos/60/60?random=63&keyword=sneakers"
        },
        {
          "productId": "watch001",
          "name": "Smart Watch",
          "price": 199.00,
          "quantity": 1,
          "image": "https://picsum.photos/60/60?random=64&keyword=watch"
        },
        {
          "productId": "belt001",
          "name": "Leather Belt",
          "price": 59.00,
          "quantity": 1,
          "image": "https://picsum.photos/60/60?random=65&keyword=belt"
        }
      ]
    },
  ];

  List<Map<String, dynamic>> get filteredBundles {
    List<Map<String, dynamic>> filtered = productBundles;

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((bundle) {
        return bundle["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
               bundle["description"].toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    if (selectedStatus != "all") {
      filtered = filtered.where((bundle) => bundle["status"] == selectedStatus).toList();
    }

    if (selectedCategory != "all") {
      filtered = filtered.where((bundle) => bundle["category"] == selectedCategory).toList();
    }

    if (!showInactive) {
      filtered = filtered.where((bundle) => 
          bundle["status"] != "inactive" && 
          bundle["status"] != "draft" && 
          bundle["status"] != "out_of_stock").toList();
    }

    // Sort bundles
    filtered.sort((a, b) {
      switch (sortBy) {
        case "price":
          return (b["bundlePrice"] as double).compareTo(a["bundlePrice"] as double);
        case "discount":
          return (b["discount"] as double).compareTo(a["discount"] as double);
        case "sales":
          return (b["salesCount"] as int).compareTo(a["salesCount"] as int);
        case "created":
          return DateTime.parse(b["createdAt"]).compareTo(DateTime.parse(a["createdAt"]));
        case "name":
        default:
          return a["name"].compareTo(b["name"]);
      }
    });

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Product Bundles",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Bundles", icon: Icon(Icons.inventory_2)),
        Tab(text: "Builder", icon: Icon(Icons.build_circle)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildBundlesTab(),
        _buildBuilderTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildBundlesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchAndFilters(),
          _buildBundleStats(),
          _buildBundlesList(),
        ],
      ),
    );
  }

  Widget _buildBuilderTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBundleBuilder(),
          _buildRecommendedBundles(),
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
          _buildBundleStats(),
          _buildTopPerformingBundles(),
          _buildBundlePerformanceChart(),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
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
                child: Container(
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(5),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: disabledOutlineBorderColor),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Icon(
                          Icons.search,
                          color: disabledBoldColor,
                          size: 20,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Search bundles...",
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: spSm),
                            ),
                            onChanged: (value) {
                              searchQuery = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.add,
                label: "Create Bundle",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          Row(
            children: [
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
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: categoryOptions,
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Sort By",
                  items: sortOptions,
                  value: sortBy,
                  onChanged: (value, label) {
                    sortBy = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Row(
                children: [
                  Text(
                    "Show Inactive",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(width: spXs),
                  Switch(
                    value: showInactive,
                    onChanged: (value) {
                      showInactive = value;
                      setState(() {});
                    },
                    activeColor: primaryColor,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBundleStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Bundle Overview",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: bundleStats.map((stat) => _buildStatCard(stat)).toList(),
        ),
      ],
    );
  }

  Widget _buildStatCard(Map<String, dynamic> stat) {
    String valueText;
    if (stat["isCurrency"] == true) {
      valueText = "\$${((stat["value"] as int).toDouble()).currency}";
    } else if (stat["isPercentage"] == true) {
      valueText = "${(stat["value"] as num).toStringAsFixed(1)}%";
    } else {
      valueText = "${stat["value"]}";
    }

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
            valueText,
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

  Widget _buildBundlesList() {
    List<Map<String, dynamic>> displayBundles = filteredBundles;

    return Column(
      spacing: spSm,
      children: displayBundles.map((bundle) => _buildBundleCard(bundle)).toList(),
    );
  }

  Widget _buildBundleCard(Map<String, dynamic> bundle) {
    Color statusColor = _getStatusColor(bundle["status"]);
    
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
                  "${bundle["image"]}",
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
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${bundle["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${bundle["status"]}".toUpperCase().replaceAll('_', ' '),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: statusColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${bundle["description"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Text(
                          "\$${(bundle["bundlePrice"] as double).currency}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "\$${(bundle["originalPrice"] as double).currency}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${(bundle["discount"] as double).toStringAsFixed(1)}% OFF",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: successColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          _buildBundleMetrics(bundle),
          _buildBundleItems(bundle["items"] as List<Map<String, dynamic>>),
        ],
      ),
    );
  }

  Widget _buildBundleMetrics(Map<String, dynamic> bundle) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(3),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          _buildMetricItem("Stock", "${bundle["stock"]}", Icons.inventory, primaryColor),
          _buildMetricItem("Sales", "${bundle["salesCount"]}", Icons.trending_up, infoColor),
          _buildMetricItem("Savings", "\$${(bundle["savings"] as double).currency}", Icons.savings, successColor),
          _buildMetricItem("Items", "${(bundle["items"] as List).length}", Icons.list, warningColor),
        ],
      ),
    );
  }

  Widget _buildMetricItem(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: color,
          ),
          SizedBox(width: 4),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBundleItems(List<Map<String, dynamic>> items) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: infoColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.inventory_2,
                color: primaryColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                "Bundle Items (${items.length})",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QHorizontalScroll(
            children: items.map((item) => _buildBundleItemChip(item)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBundleItemChip(Map<String, dynamic> item) {
    return Container(
      margin: EdgeInsets.only(right: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowXs],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusXs),
            child: Image.network(
              "${item["image"]}",
              width: 30,
              height: 30,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: spXs),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${item["name"]}",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Row(
                children: [
                  Text(
                    "Qty: ${item["quantity"]}",
                    style: TextStyle(
                      fontSize: 9,
                      color: infoColor,
                    ),
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "\$${(item["price"] as double).currency}",
                    style: TextStyle(
                      fontSize: 9,
                      color: successColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBundleBuilder() {
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
              Icon(
                Icons.build_circle,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Bundle Builder",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Text(
            "Create custom product bundles with automatic pricing and discount calculations.",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  icon: Icons.add_circle,
                  label: "Start New Bundle",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  icon: Icons.auto_awesome,
                  label: "Smart Suggestions",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedBundles() {
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
            "Recommended Bundle Ideas",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildRecommendationCard("Back to School Bundle", "Notebooks, pens, backpack, calculator", "Based on seasonal trends"),
          _buildRecommendationCard("Summer Sports Pack", "Water bottles, towels, sports gear", "Popular combination"),
          _buildRecommendationCard("Work From Home Pro", "Desk accessories, lighting, organization", "High demand category"),
        ],
      ),
    );
  }

  Widget _buildRecommendationCard(String title, String description, String reason) {
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
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Icon(
              Icons.lightbulb,
              color: infoColor,
              size: 16,
            ),
          ),
          SizedBox(width: spSm),
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
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  reason,
                  style: TextStyle(
                    fontSize: 10,
                    color: infoColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildTopPerformingBundles() {
    List<Map<String, dynamic>> topBundles = productBundles
        .where((bundle) => bundle["status"] == "active")
        .toList()
      ..sort((a, b) => (b["salesCount"] as int).compareTo(a["salesCount"] as int));

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
            "Top Performing Bundles",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...topBundles.take(5).map((bundle) => _buildTopBundleItem(bundle)),
        ],
      ),
    );
  }

  Widget _buildTopBundleItem(Map<String, dynamic> bundle) {
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
              "${bundle["image"]}",
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
                  "${bundle["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${bundle["salesCount"]} sales • ${(bundle["discount"] as double).toStringAsFixed(1)}% discount",
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
              color: successColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "#${productBundles.indexOf(bundle) + 1}",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: successColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBundlePerformanceChart() {
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
            "Bundle Performance Analytics",
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
                    Icons.donut_small,
                    size: 48,
                    color: primaryColor.withAlpha(100),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Bundle Sales & Revenue Chart",
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

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "active":
        return successColor;
      case "inactive":
        return disabledBoldColor;
      case "draft":
        return warningColor;
      case "out_of_stock":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }
}
