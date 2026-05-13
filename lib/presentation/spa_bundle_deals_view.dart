import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaBundleDealsView extends StatefulWidget {
  const SpaBundleDealsView({super.key});

  @override
  State<SpaBundleDealsView> createState() => _SpaBundleDealsViewState();
}

class _SpaBundleDealsViewState extends State<SpaBundleDealsView> {
  int selectedTab = 0;
  String searchQuery = "";
  String selectedCategory = "All";
  String statusFilter = "All";
  
  List<String> categories = ["All", "Skincare", "Hair Care", "Aromatherapy", "Equipment", "Wellness"];
  List<String> statusOptions = ["All", "Active", "Inactive", "Expired", "Scheduled"];
  
  List<Map<String, dynamic>> bundleDeals = [
    {
      "id": "BUNDLE001",
      "name": "Complete Skincare Routine",
      "description": "Everything you need for a perfect skincare routine",
      "image": "https://picsum.photos/300/200?random=1&keyword=skincare",
      "category": "Skincare",
      "status": "Active",
      "startDate": "January 1, 2025",
      "endDate": "March 31, 2025",
      "originalPrice": 345.97,
      "bundlePrice": 249.99,
      "savings": 95.98,
      "discountPercent": 28,
      "soldCount": 87,
      "stockLimit": 200,
      "popularity": 94,
      "products": [
        {
          "id": "PROD001",
          "name": "Hyaluronic Acid Serum",
          "price": 89.99,
          "image": "https://picsum.photos/100/100?random=1&keyword=serum"
        },
        {
          "id": "PROD002", 
          "name": "Vitamin C Moisturizer",
          "price": 79.99,
          "image": "https://picsum.photos/100/100?random=2&keyword=moisturizer"
        },
        {
          "id": "PROD003",
          "name": "Gentle Cleanser",
          "price": 49.99,
          "image": "https://picsum.photos/100/100?random=3&keyword=cleanser"
        },
        {
          "id": "PROD004",
          "name": "Night Repair Cream",
          "price": 125.99,
          "image": "https://picsum.photos/100/100?random=4&keyword=cream"
        }
      ]
    },
    {
      "id": "BUNDLE002",
      "name": "Aromatherapy Relaxation Set",
      "description": "Create a spa-like atmosphere at home",
      "image": "https://picsum.photos/300/200?random=2&keyword=aromatherapy",
      "category": "Aromatherapy",
      "status": "Active",
      "startDate": "December 15, 2024",
      "endDate": "February 28, 2025",
      "originalPrice": 299.95,
      "bundlePrice": 199.99,
      "savings": 99.96,
      "discountPercent": 33,
      "soldCount": 134,
      "stockLimit": 150,
      "popularity": 89,
      "products": [
        {
          "id": "PROD005",
          "name": "Essential Oil Diffuser",
          "price": 129.99,
          "image": "https://picsum.photos/100/100?random=5&keyword=diffuser"
        },
        {
          "id": "PROD006",
          "name": "Essential Oil Set (5 oils)",
          "price": 89.99,
          "image": "https://picsum.photos/100/100?random=6&keyword=oils"
        },
        {
          "id": "PROD007",
          "name": "Aromatherapy Candles",
          "price": 79.97,
          "image": "https://picsum.photos/100/100?random=7&keyword=candles"
        }
      ]
    },
    {
      "id": "BUNDLE003",
      "name": "Professional Hair Care Kit",
      "description": "Salon-quality hair care for home use",
      "image": "https://picsum.photos/300/200?random=3&keyword=hair",
      "category": "Hair Care",
      "status": "Active",
      "startDate": "January 10, 2025",
      "endDate": "April 30, 2025",
      "originalPrice": 189.96,
      "bundlePrice": 129.99,
      "savings": 59.97,
      "discountPercent": 32,
      "soldCount": 56,
      "stockLimit": 100,
      "popularity": 82,
      "products": [
        {
          "id": "PROD008",
          "name": "Keratin Shampoo",
          "price": 45.99,
          "image": "https://picsum.photos/100/100?random=8&keyword=shampoo"
        },
        {
          "id": "PROD009",
          "name": "Deep Conditioning Mask",
          "price": 65.99,
          "image": "https://picsum.photos/100/100?random=9&keyword=mask"
        },
        {
          "id": "PROD010",
          "name": "Hair Oil Treatment",
          "price": 39.99,
          "image": "https://picsum.photos/100/100?random=10&keyword=oil"
        },
        {
          "id": "PROD011",
          "name": "Heat Protection Spray",
          "price": 37.99,
          "image": "https://picsum.photos/100/100?random=11&keyword=spray"
        }
      ]
    },
    {
      "id": "BUNDLE004",
      "name": "Spa Equipment Starter Pack",
      "description": "Everything needed to start your spa business",
      "image": "https://picsum.photos/300/200?random=4&keyword=equipment",
      "category": "Equipment",
      "status": "Scheduled",
      "startDate": "February 1, 2025",
      "endDate": "May 31, 2025",
      "originalPrice": 1299.95,
      "bundlePrice": 999.99,
      "savings": 299.96,
      "discountPercent": 23,
      "soldCount": 12,
      "stockLimit": 50,
      "popularity": 76,
      "products": [
        {
          "id": "PROD012",
          "name": "Facial Steamer",
          "price": 399.99,
          "image": "https://picsum.photos/100/100?random=12&keyword=steamer"
        },
        {
          "id": "PROD013",
          "name": "Hot Stone Warmer",
          "price": 299.99,
          "image": "https://picsum.photos/100/100?random=13&keyword=stones"
        },
        {
          "id": "PROD014",
          "name": "Massage Table",
          "price": 599.97,
          "image": "https://picsum.photos/100/100?random=14&keyword=table"
        }
      ]
    },
    {
      "id": "BUNDLE005",
      "name": "Wellness Detox Package",
      "description": "Complete detox and wellness program",
      "image": "https://picsum.photos/300/200?random=5&keyword=wellness",
      "category": "Wellness",
      "status": "Expired",
      "startDate": "November 1, 2024",
      "endDate": "December 31, 2024",
      "originalPrice": 234.95,
      "bundlePrice": 169.99,
      "savings": 64.96,
      "discountPercent": 28,
      "soldCount": 203,
      "stockLimit": 250,
      "popularity": 91,
      "products": [
        {
          "id": "PROD015",
          "name": "Detox Tea Blend",
          "price": 45.99,
          "image": "https://picsum.photos/100/100?random=15&keyword=tea"
        },
        {
          "id": "PROD016",
          "name": "Body Scrub Set",
          "price": 89.99,
          "image": "https://picsum.photos/100/100?random=16&keyword=scrub"
        },
        {
          "id": "PROD017",
          "name": "Wellness Journal",
          "price": 29.99,
          "image": "https://picsum.photos/100/100?random=17&keyword=journal"
        },
        {
          "id": "PROD018",
          "name": "Meditation App Subscription",
          "price": 68.98,
          "image": "https://picsum.photos/100/100?random=18&keyword=meditation"
        }
      ]
    }
  ];
  
  List<Map<String, dynamic>> bundleTemplates = [
    {
      "id": "TEMPLATE001",
      "name": "Skincare Essentials",
      "description": "Basic skincare routine bundle template",
      "category": "Skincare",
      "estimatedDiscount": 25,
      "estimatedSavings": 75.00,
      "productCount": 3,
      "isPopular": true
    },
    {
      "id": "TEMPLATE002", 
      "name": "Hair Care Duo",
      "description": "Simple two-product hair care bundle",
      "category": "Hair Care",
      "estimatedDiscount": 20,
      "estimatedSavings": 40.00,
      "productCount": 2,
      "isPopular": false
    },
    {
      "id": "TEMPLATE003",
      "name": "Aromatherapy Starter",
      "description": "Introduction to aromatherapy bundle",
      "category": "Aromatherapy",
      "estimatedDiscount": 30,
      "estimatedSavings": 60.00,
      "productCount": 4,
      "isPopular": true
    }
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredBundles = _getFilteredBundles();
    
    return QTabBar(
      title: "Bundle Deals",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Active Bundles", icon: Icon(Icons.card_giftcard)),
        Tab(text: "Create Bundle", icon: Icon(Icons.add_box)),
      ],
      tabChildren: [
        _buildActiveBundlesTab(filteredBundles),
        _buildCreateBundleTab(),
      ],
    );
  }
  
  Widget _buildActiveBundlesTab(List<Map<String, dynamic>> bundles) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Search and Filters
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              spacing: spMd,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search bundle deals...",
                        value: searchQuery,
                        onChanged: (value) {
                          searchQuery = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spMd),
                    QButton(
                      icon: Icons.search,
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
                        items: categories.map((cat) => {"label": cat, "value": cat}).toList(),
                        value: selectedCategory,
                        onChanged: (value, label) {
                          selectedCategory = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: QDropdownField(
                        label: "Status",
                        items: statusOptions.map((status) => {"label": status, "value": status}).toList(),
                        value: statusFilter,
                        onChanged: (value, label) {
                          statusFilter = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Bundle Statistics
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Bundle Performance",
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
                    _buildStatCard("Total Bundles", "${bundles.length}", primaryColor, Icons.card_giftcard),
                    _buildStatCard("Active Bundles", "${bundles.where((b) => b["status"] == "Active").length}", successColor, Icons.check_circle),
                    _buildStatCard("Total Sales", "${bundles.fold(0, (sum, bundle) => sum + (bundle["soldCount"] as int))}", warningColor, Icons.shopping_cart),
                    _buildStatCard("Avg Savings", "${((bundles.fold(0.0, (sum, bundle) => sum + (bundle["discountPercent"] as int)) / bundles.length)).toStringAsFixed(0)}%", infoColor, Icons.savings),
                  ],
                ),
              ],
            ),
          ),
          
          // Bundles Grid
          if (bundles.isNotEmpty)
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: bundles.map((bundle) => _buildBundleCard(bundle)).toList(),
            )
          else
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.search_off,
                    size: 64,
                    color: disabledColor,
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "No bundles found",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Try adjusting your search or filters",
                    style: TextStyle(
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
  
  Widget _buildCreateBundleTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Bundle Templates
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Row(
                  children: [
                    Text(
                      "Bundle Templates",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "Create Custom",
                      size: bs.sm,
                      icon: Icons.add,
                      onPressed: () {
                        _createCustomBundle();
                      },
                    ),
                  ],
                ),
                Text(
                  "Start with a pre-built template or create your own bundle from scratch",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 200,
                  children: bundleTemplates.map((template) => _buildTemplateCard(template)).toList(),
                ),
              ],
            ),
          ),
          
          // Bundle Creation Guide
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Bundle Creation Guide",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                _buildGuideStep(1, "Select Products", "Choose 2-5 complementary products", Icons.inventory),
                _buildGuideStep(2, "Set Pricing", "Determine bundle price and discount", Icons.attach_money),
                _buildGuideStep(3, "Configure Details", "Add description, images, and schedule", Icons.settings),
                _buildGuideStep(4, "Launch Bundle", "Activate and start selling", Icons.launch),
              ],
            ),
          ),
          
          // Bundle Performance Tips
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Bundle Success Tips",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                _buildTip("Complement Products", "Bundle items that work well together", Icons.link),
                _buildTip("Attractive Pricing", "Offer 20-35% savings for best results", Icons.savings),
                _buildTip("Limited Time", "Create urgency with time-limited offers", Icons.timer),
                _buildTip("Clear Value", "Highlight savings and benefits prominently", Icons.star),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildStatCard(String title, String value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: color.withAlpha(60)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildBundleCard(Map<String, dynamic> bundle) {
    Color statusColor = _getStatusColor(bundle["status"]);
    List<Map<String, dynamic>> products = bundle["products"] as List<Map<String, dynamic>>;
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bundle Image
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                child: Image.network(
                  "${bundle["image"]}",
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: spSm,
                right: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: dangerColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "-${bundle["discountPercent"]}%",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: spSm,
                left: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${bundle["status"]}".toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                // Category and Name
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${bundle["category"]}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${products.length} Products",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                
                // Bundle Name
                Text(
                  "${bundle["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                // Description
                Text(
                  "${bundle["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                // Pricing
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "\$${(bundle["bundlePrice"] as double).toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "\$${(bundle["originalPrice"] as double).toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Text(
                      "Save \$${(bundle["savings"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 12,
                        color: dangerColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                
                // Products Preview
                Container(
                  height: 60,
                  child: QHorizontalScroll(
                    children: products.map((product) => 
                      Container(
                        margin: EdgeInsets.only(right: spSm),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(radiusSm),
                          child: Image.network(
                            "${product["image"]}",
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ).toList(),
                  ),
                ),
                
                // Sales Info
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.shopping_cart,
                        size: 16,
                        color: successColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${bundle["soldCount"]} sold",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${bundle["stockLimit"] - (bundle["soldCount"] as int)} remaining",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "View Details",
                        size: bs.sm,
                        icon: Icons.visibility,
                        color: infoColor,
                        onPressed: () {
                          _viewBundleDetails(bundle);
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Edit Bundle",
                        size: bs.sm,
                        icon: Icons.edit,
                        onPressed: () {
                          _editBundle(bundle);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildTemplateCard(Map<String, dynamic> template) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: primaryColor.withAlpha(60)),
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
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(
                  Icons.card_giftcard,
                  color: primaryColor,
                  size: 24,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${template["name"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        if (template["isPopular"]) ...[
                          SizedBox(width: spSm),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
                            decoration: BoxDecoration(
                              color: warningColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "POPULAR",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    Text(
                      "${template["category"]}",
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
          
          Text(
            "${template["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildTemplateInfo("Products", "${template["productCount"]}", Icons.inventory),
              _buildTemplateInfo("Discount", "${template["estimatedDiscount"]}%", Icons.percent),
              _buildTemplateInfo("Savings", "\$${(template["estimatedSavings"] as double).toStringAsFixed(0)}", Icons.savings),
            ],
          ),
          
          Container(
            width: double.infinity,
            child: QButton(
              label: "Use Template",
              size: bs.md,
              icon: Icons.add_box,
              onPressed: () {
                _useTemplate(template);
              },
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildTemplateInfo(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: infoColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: infoColor,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: infoColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 11,
                    color: infoColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildGuideStep(int step, String title, String description, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              "$step",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: spMd),
          Icon(
            icon,
            color: primaryColor,
            size: 20,
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
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildTip(String title, String description, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: successColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: successColor,
            size: 20,
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
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  List<Map<String, dynamic>> _getFilteredBundles() {
    List<Map<String, dynamic>> filtered = List.from(bundleDeals);
    
    // Filter by category
    if (selectedCategory != "All") {
      filtered = filtered.where((bundle) => bundle["category"] == selectedCategory).toList();
    }
    
    // Filter by status
    if (statusFilter != "All") {
      filtered = filtered.where((bundle) => bundle["status"] == statusFilter).toList();
    }
    
    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((bundle) => 
        (bundle["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (bundle["description"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (bundle["category"] as String).toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    return filtered;
  }
  
  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Inactive":
        return disabledColor;
      case "Expired":
        return dangerColor;
      case "Scheduled":
        return warningColor;
      default:
        return primaryColor;
    }
  }
  
  void _viewBundleDetails(Map<String, dynamic> bundle) {
    ss("Viewing details for ${bundle["name"]}");
  }
  
  void _editBundle(Map<String, dynamic> bundle) {
    ss("Editing bundle ${bundle["name"]}");
  }
  
  void _createCustomBundle() {
    ss("Creating custom bundle from scratch");
  }
  
  void _useTemplate(Map<String, dynamic> template) {
    ss("Using template ${template["name"]}");
  }
}
