import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmProductSpecificationsView extends StatefulWidget {
  const IwmProductSpecificationsView({super.key});

  @override
  State<IwmProductSpecificationsView> createState() => _IwmProductSpecificationsViewState();
}

class _IwmProductSpecificationsViewState extends State<IwmProductSpecificationsView> {
  int selectedTab = 0;
  String selectedCategory = "all";
  String searchQuery = "";
  
  List<Map<String, dynamic>> categories = [
    {"label": "All Categories", "value": "all"},
    {"label": "Electronics", "value": "electronics"},
    {"label": "Clothing", "value": "clothing"},
    {"label": "Home & Garden", "value": "home"},
    {"label": "Sports", "value": "sports"},
  ];

  List<Map<String, dynamic>> products = [
    {
      "id": "PROD001",
      "name": "Wireless Headphones",
      "sku": "WH-2024-001",
      "category": "electronics",
      "image": "https://picsum.photos/80/80?random=1&keyword=headphones",
      "completeness": 85,
      "lastUpdated": "2024-01-15",
      "specifications": {
        "basic": {
          "brand": "TechSound",
          "model": "WH-Pro-2024",
          "color": "Black",
          "weight": "250g",
          "warranty": "2 years"
        },
        "technical": {
          "frequency_response": "20Hz - 20kHz",
          "impedance": "32 ohms",
          "sensitivity": "105 dB",
          "driver_size": "40mm",
          "battery_life": "30 hours"
        },
        "features": [
          "Active Noise Cancellation",
          "Bluetooth 5.0",
          "Quick Charge",
          "Voice Assistant"
        ],
        "dimensions": {
          "length": "18.5 cm",
          "width": "15.2 cm",
          "height": "7.8 cm"
        }
      }
    },
    {
      "id": "PROD002",
      "name": "Smart Watch",
      "sku": "SW-2024-002",
      "category": "electronics",
      "image": "https://picsum.photos/80/80?random=2&keyword=watch",
      "completeness": 92,
      "lastUpdated": "2024-01-14",
      "specifications": {
        "basic": {
          "brand": "SmartTech",
          "model": "ST-Watch-Pro",
          "color": "Silver",
          "weight": "45g",
          "warranty": "1 year"
        },
        "technical": {
          "display": "1.4 inch AMOLED",
          "resolution": "454x454",
          "processor": "Dual-core ARM",
          "storage": "16GB",
          "battery": "400mAh"
        },
        "features": [
          "Heart Rate Monitor",
          "GPS Tracking",
          "Water Resistant",
          "Sleep Tracking",
          "Fitness Modes"
        ],
        "dimensions": {
          "diameter": "44mm",
          "thickness": "12mm"
        }
      }
    },
    {
      "id": "PROD003",
      "name": "Running Shoes",
      "sku": "RS-2024-003",
      "category": "sports",
      "image": "https://picsum.photos/80/80?random=3&keyword=shoes",
      "completeness": 78,
      "lastUpdated": "2024-01-16",
      "specifications": {
        "basic": {
          "brand": "RunFast",
          "model": "RF-Runner-2024",
          "color": "Blue/White",
          "weight": "280g",
          "warranty": "6 months"
        },
        "technical": {
          "sole_material": "EVA Foam",
          "upper_material": "Mesh Fabric",
          "closure": "Lace-up",
          "heel_drop": "8mm"
        },
        "features": [
          "Breathable Mesh",
          "Shock Absorption",
          "Anti-slip Sole",
          "Lightweight Design"
        ],
        "sizes": ["US 7", "US 8", "US 9", "US 10", "US 11"]
      }
    },
  ];

  List<Map<String, dynamic>> specificationStats = [
    {
      "title": "Total Products",
      "value": 156,
      "subtitle": "With Specifications",
      "icon": Icons.inventory,
      "color": primaryColor,
    },
    {
      "title": "Complete Specs",
      "value": 128,
      "subtitle": "82% Complete",
      "icon": Icons.check_circle,
      "color": successColor,
    },
    {
      "title": "Missing Data",
      "value": 28,
      "subtitle": "Need Attention",
      "icon": Icons.warning,
      "color": warningColor,
    },
    {
      "title": "Avg Completeness",
      "value": "84%",
      "subtitle": "Overall Score",
      "icon": Icons.analytics,
      "color": infoColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Product Specifications",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.description)),
        Tab(text: "Editor", icon: Icon(Icons.edit)),
        Tab(text: "Templates", icon: Icon(Icons.library_books)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildEditorTab(),
        _buildTemplatesTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    List<Map<String, dynamic>> filteredProducts = products.where((product) {
      bool categoryMatch = selectedCategory == "all" || product["category"] == selectedCategory;
      bool searchMatch = searchQuery.isEmpty || 
          (product["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (product["sku"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      return categoryMatch && searchMatch;
    }).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildOverviewFilters(),
          _buildSpecificationStats(),
          _buildProductsList(filteredProducts),
        ],
      ),
    );
  }

  Widget _buildEditorTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildEditorHeader(),
          _buildSpecificationEditor(),
        ],
      ),
    );
  }

  Widget _buildTemplatesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTemplateActions(),
          _buildTemplatesList(),
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
          _buildCompletenessAnalytics(),
          _buildSpecificationTrends(),
          _buildMissingDataReport(),
        ],
      ),
    );
  }

  Widget _buildOverviewFilters() {
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
                        label: "Search products...",
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
              QButton(
                icon: Icons.add,
                label: "Add Product",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSpecificationStats() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: specificationStats.map((stat) => _buildStatCard(stat)).toList(),
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

  Widget _buildProductsList(List<Map<String, dynamic>> products) {
    return Column(
      spacing: spSm,
      children: products.map((product) => _buildProductSpecCard(product)).toList(),
    );
  }

  Widget _buildProductSpecCard(Map<String, dynamic> product) {
    double completeness = (product["completeness"] as int).toDouble() / 100;
    Color completenessColor = completeness >= 0.8 ? successColor : completeness >= 0.6 ? warningColor : dangerColor;
    
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
                      "SKU: ${product["sku"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Updated: ${product["lastUpdated"]}",
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
                  Text(
                    "${product["completeness"]}%",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: completenessColor,
                    ),
                  ),
                  Text(
                    "Complete",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          LinearProgressIndicator(
            value: completeness,
            backgroundColor: disabledOutlineBorderColor,
            valueColor: AlwaysStoppedAnimation<Color>(completenessColor),
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Specs",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Edit",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEditorHeader() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Specification Editor",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Edit product specifications in detail",
                  style: TextStyle(
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              QButton(
                label: "Import CSV",
                icon: Icons.upload_file,
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Export CSV",
                icon: Icons.download,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSpecificationEditor() {
    Map<String, dynamic> selectedProduct = products.first;
    
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
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${selectedProduct["image"]}",
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
                      "${selectedProduct["name"]}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "SKU: ${selectedProduct["sku"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              QButton(
                label: "Save Changes",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          Divider(),
          _buildBasicSpecifications(selectedProduct["specifications"]["basic"]),
          _buildTechnicalSpecifications(selectedProduct["specifications"]["technical"]),
          _buildFeaturesList(selectedProduct["specifications"]["features"]),
          _buildDimensionsEditor(selectedProduct["specifications"]["dimensions"]),
        ],
      ),
    );
  }

  Widget _buildBasicSpecifications(Map<String, dynamic> basic) {
    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Basic Information",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: basic.entries.map((entry) => 
            QTextField(
              label: entry.key.replaceAll('_', ' ').toUpperCase(),
              value: "${entry.value}",
              onChanged: (value) {},
            )
          ).toList(),
        ),
      ],
    );
  }

  Widget _buildTechnicalSpecifications(Map<String, dynamic> technical) {
    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Technical Specifications",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: technical.entries.map((entry) => 
            QTextField(
              label: entry.key.replaceAll('_', ' ').toUpperCase(),
              value: "${entry.value}",
              onChanged: (value) {},
            )
          ).toList(),
        ),
      ],
    );
  }

  Widget _buildFeaturesList(List<dynamic> features) {
    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                "Features",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ),
            QButton(
              icon: Icons.add,
              label: "Add Feature",
              size: bs.sm,
              onPressed: () {},
            ),
          ],
        ),
        ...features.asMap().entries.map((entry) => 
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: disabledOutlineBorderColor),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: successColor, size: 16),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "${entry.value}",
                    style: TextStyle(color: primaryColor),
                  ),
                ),
                QButton(
                  icon: Icons.delete,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
          )
        ),
      ],
    );
  }

  Widget _buildDimensionsEditor(Map<String, dynamic> dimensions) {
    return Column(
      spacing: spSm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Dimensions",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: dimensions.entries.map((entry) => 
            QTextField(
              label: entry.key.replaceAll('_', ' ').toUpperCase(),
              value: "${entry.value}",
              onChanged: (value) {},
            )
          ).toList(),
        ),
      ],
    );
  }

  Widget _buildTemplateActions() {
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
            "Specification Templates",
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
                  label: "Create Template",
                  icon: Icons.add,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Import Template",
                  icon: Icons.upload,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTemplatesList() {
    List<Map<String, dynamic>> templates = [
      {
        "name": "Electronics Template",
        "category": "Electronics",
        "fields": 15,
        "usage": 45,
        "created": "2024-01-10"
      },
      {
        "name": "Clothing Template",
        "category": "Clothing",
        "fields": 12,
        "usage": 32,
        "created": "2024-01-08"
      },
      {
        "name": "Sports Equipment",
        "category": "Sports",
        "fields": 18,
        "usage": 28,
        "created": "2024-01-05"
      },
    ];

    return Column(
      spacing: spSm,
      children: templates.map((template) => _buildTemplateCard(template)).toList(),
    );
  }

  Widget _buildTemplateCard(Map<String, dynamic> template) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              Icons.description,
              color: primaryColor,
              size: 24,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${template["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${template["category"]} • ${template["fields"]} fields",
                  style: TextStyle(
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "Used by ${template["usage"]} products",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledColor,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              QButton(
                label: "Use",
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(height: spXs),
              Row(
                children: [
                  QButton(
                    icon: Icons.edit,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                  SizedBox(width: spXs),
                  QButton(
                    icon: Icons.delete,
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

  Widget _buildCompletenessAnalytics() {
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
            "Specification Completeness",
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
                    Icons.pie_chart,
                    size: 48,
                    color: primaryColor.withAlpha(100),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Completeness Distribution",
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

  Widget _buildSpecificationTrends() {
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
            "Specification Trends",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            height: 150,
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
                    Icons.trending_up,
                    size: 48,
                    color: successColor.withAlpha(100),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Weekly Progress Trends",
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

  Widget _buildMissingDataReport() {
    List<Map<String, dynamic>> missingData = [
      {"field": "Weight", "products": 15, "priority": "High"},
      {"field": "Warranty", "products": 8, "priority": "Medium"},
      {"field": "Dimensions", "products": 23, "priority": "High"},
      {"field": "Technical Specs", "products": 12, "priority": "Low"},
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
            "Missing Data Report",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...missingData.map((data) => _buildMissingDataItem(data)),
        ],
      ),
    );
  }

  Widget _buildMissingDataItem(Map<String, dynamic> data) {
    Color priorityColor = _getPriorityColor(data["priority"]);
    
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
            width: 4,
            height: 40,
            decoration: BoxDecoration(
              color: priorityColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${data["field"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${data["products"]} products missing this field",
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
              color: priorityColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "${data["priority"]}",
              style: TextStyle(
                color: priorityColor,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }
}
