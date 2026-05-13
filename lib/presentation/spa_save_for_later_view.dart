import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaSaveForLaterView extends StatefulWidget {
  const SpaSaveForLaterView({super.key});

  @override
  State<SpaSaveForLaterView> createState() => _SpaSaveForLaterViewState();
}

class _SpaSaveForLaterViewState extends State<SpaSaveForLaterView> {
  int selectedTab = 0;
  String searchQuery = "";
  String categoryFilter = "All";
  String timeFilter = "Last 30 Days";
  String sortBy = "Most Recent";
  
  List<String> categoryOptions = ["All", "Skincare", "Massage", "Aromatherapy", "Wellness", "Accessories", "Gift Sets"];
  List<String> timeOptions = ["Last 7 Days", "Last 30 Days", "Last 90 Days", "All Time"];
  List<String> sortOptions = ["Most Recent", "Price: Low to High", "Price: High to Low", "Customer Name", "Save Date"];

  List<Map<String, dynamic>> savedItems = [
    {
      "id": "SAVE-2024-001",
      "customerId": "CUST-4567",
      "customerName": "Emma Thompson",
      "customerEmail": "emma.thompson@email.com",
      "itemName": "Luxury Aromatherapy Massage Oil Set",
      "itemImage": "https://picsum.photos/150/150?random=1&keyword=massage",
      "price": 189.99,
      "originalPrice": 225.00,
      "discount": 15.6,
      "category": "Aromatherapy",
      "brand": "Essential Bliss",
      "stock": 12,
      "savedDate": "2024-12-15 14:30",
      "lastViewed": "2024-12-16 10:15",
      "viewCount": 8,
      "notificationsSent": 2,
      "inCart": false,
      "wishlistPriority": "high",
      "notes": "Waiting for discount",
      "customerHistory": {
        "totalOrders": 15,
        "totalSpent": 2450.75,
        "avgOrderValue": 163.38,
        "lastOrder": "2024-11-20"
      }
    },
    {
      "id": "SAVE-2024-002",
      "customerId": "CUST-7890",
      "customerName": "Michael Rodriguez",
      "customerEmail": "m.rodriguez@email.com",
      "itemName": "Professional Massage Tool Kit",
      "itemImage": "https://picsum.photos/150/150?random=2&keyword=tools",
      "price": 145.50,
      "originalPrice": 145.50,
      "discount": 0,
      "category": "Massage",
      "brand": "ProSpa Tools",
      "stock": 5,
      "savedDate": "2024-12-14 16:45",
      "lastViewed": "2024-12-15 09:20",
      "viewCount": 3,
      "notificationsSent": 1,
      "inCart": false,
      "wishlistPriority": "medium",
      "notes": "Comparing with alternatives",
      "customerHistory": {
        "totalOrders": 8,
        "totalSpent": 1240.50,
        "avgOrderValue": 155.06,
        "lastOrder": "2024-10-15"
      }
    },
    {
      "id": "SAVE-2024-003",
      "customerId": "CUST-2345",
      "customerName": "Sarah Johnson",
      "customerEmail": "sarah.j@email.com",
      "itemName": "Organic Skincare Complete Set",
      "itemImage": "https://picsum.photos/150/150?random=3&keyword=skincare",
      "price": 295.75,
      "originalPrice": 350.00,
      "discount": 15.5,
      "category": "Skincare",
      "brand": "Pure Essence",
      "stock": 8,
      "savedDate": "2024-12-13 11:20",
      "lastViewed": "2024-12-16 08:45",
      "viewCount": 12,
      "notificationsSent": 3,
      "inCart": true,
      "wishlistPriority": "high",
      "notes": "Planning to purchase next month",
      "customerHistory": {
        "totalOrders": 22,
        "totalSpent": 4200.25,
        "avgOrderValue": 190.92,
        "lastOrder": "2024-11-28"
      }
    },
    {
      "id": "SAVE-2024-004",
      "customerId": "CUST-5678",
      "customerName": "Jessica Chen",
      "customerEmail": "j.chen@email.com",
      "itemName": "Wellness Subscription Box",
      "itemImage": "https://picsum.photos/150/150?random=4&keyword=wellness",
      "price": 89.99,
      "originalPrice": 99.99,
      "discount": 10.0,
      "category": "Wellness",
      "brand": "Monthly Wellness",
      "stock": 25,
      "savedDate": "2024-12-12 19:15",
      "lastViewed": "2024-12-14 13:30",
      "viewCount": 5,
      "notificationsSent": 2,
      "inCart": false,
      "wishlistPriority": "low",
      "notes": "Considering subscription",
      "customerHistory": {
        "totalOrders": 12,
        "totalSpent": 1850.75,
        "avgOrderValue": 154.23,
        "lastOrder": "2024-12-05"
      }
    }
  ];

  List<Map<String, dynamic>> automationRules = [
    {
      "id": "rule_1",
      "name": "Price Drop Notification",
      "type": "Price Alert",
      "trigger": "Price decreases by 10% or more",
      "action": "Send email notification",
      "active": true,
      "conversions": 45,
      "efficiency": 23.5
    },
    {
      "id": "rule_2",
      "name": "Stock Alert",
      "type": "Inventory Alert",
      "trigger": "Stock falls below 5 items",
      "action": "Send urgent notification",
      "active": true,
      "conversions": 28,
      "efficiency": 35.7
    },
    {
      "id": "rule_3",
      "name": "Wishlist Reminder",
      "type": "Time-based",
      "trigger": "7 days after saving",
      "action": "Send reminder email",
      "active": true,
      "conversions": 67,
      "efficiency": 18.2
    },
    {
      "id": "rule_4",
      "name": "New Arrival Match",
      "type": "Product Match",
      "trigger": "Similar product launches",
      "action": "Send recommendation",
      "active": false,
      "conversions": 12,
      "efficiency": 15.8
    }
  ];

  Map<String, dynamic> analyticsData = {
    "totalSavedItems": 1456,
    "totalCustomers": 834,
    "conversionRate": 24.8,
    "averageSaveTime": "12.5 days",
    "totalConversions": 361,
    "conversionValue": 89750.25,
    "avgItemValue": 167.85,
    "topCategory": "Skincare (35%)",
    "monthlyTrend": [
      {"month": "Jan", "saved": 98, "converted": 24, "value": 4850.50},
      {"month": "Feb", "saved": 112, "converted": 31, "value": 6240.75},
      {"month": "Mar", "saved": 89, "converted": 22, "value": 4275.25},
      {"month": "Apr", "saved": 105, "converted": 26, "value": 5120.00},
      {"month": "May", "saved": 126, "converted": 35, "value": 7290.50},
      {"month": "Jun", "saved": 134, "converted": 38, "value": 8085.75},
      {"month": "Jul", "saved": 118, "converted": 29, "value": 6570.25},
      {"month": "Aug", "saved": 142, "converted": 40, "value": 8830.00},
      {"month": "Sep", "saved": 156, "converted": 42, "value": 9640.75},
      {"month": "Oct", "saved": 168, "converted": 47, "value": 10780.50},
      {"month": "Nov", "saved": 145, "converted": 38, "value": 8865.25},
      {"month": "Dec", "saved": 163, "converted": 45, "value": 9965.50}
    ]
  };

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Save for Later Management",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Saved Items", icon: Icon(Icons.bookmark)),
        Tab(text: "Customer Insights", icon: Icon(Icons.people)),
        Tab(text: "Automation", icon: Icon(Icons.auto_awesome)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildSavedItemsTab(),
        _buildCustomerInsightsTab(),
        _buildAutomationTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildSavedItemsTab() {
    List<Map<String, dynamic>> filteredItems = savedItems.where((item) {
      bool matchesSearch = item["itemName"].toLowerCase().contains(searchQuery.toLowerCase()) ||
                          item["customerName"].toLowerCase().contains(searchQuery.toLowerCase()) ||
                          item["brand"].toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = categoryFilter == "All" || item["category"] == categoryFilter;
      return matchesSearch && matchesCategory;
    }).toList();

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
                QTextField(
                  label: "Search saved items...",
                  value: searchQuery,
                  hint: "Product name, customer, or brand",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Category",
                        items: categoryOptions.map((category) => {"label": category, "value": category}).toList(),
                        value: categoryFilter,
                        onChanged: (value, label) {
                          categoryFilter = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: QDropdownField(
                        label: "Time Period",
                        items: timeOptions.map((time) => {"label": time, "value": time}).toList(),
                        value: timeFilter,
                        onChanged: (value, label) {
                          timeFilter = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: QDropdownField(
                        label: "Sort By",
                        items: sortOptions.map((sort) => {"label": sort, "value": sort}).toList(),
                        value: sortBy,
                        onChanged: (value, label) {
                          sortBy = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Quick Stats
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildQuickStat("Total Saved", "${savedItems.length}", primaryColor, Icons.bookmark),
                _buildQuickStat("In Cart", "${savedItems.where((item) => item["inCart"]).length}", successColor, Icons.shopping_cart),
                _buildQuickStat("High Priority", "${savedItems.where((item) => item["wishlistPriority"] == "high").length}", warningColor, Icons.priority_high),
                _buildQuickStat("Avg Value", "\$${(savedItems.fold(0.0, (sum, item) => sum + (item["price"] as double)) / savedItems.length).currency}", infoColor, Icons.attach_money),
              ],
            ),
          ),

          // Saved Items List
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
                      "Saved Items (${filteredItems.length})",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "Bulk Notify",
                      size: bs.sm,
                      icon: Icons.notifications,
                      onPressed: () {
                        _bulkNotify();
                      },
                    ),
                  ],
                ),
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 300,
                  children: filteredItems.map((item) => _buildSavedItemCard(item)).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerInsightsTab() {
    Map<String, int> customerSummary = {};
    for (var item in savedItems) {
      String customer = item["customerName"];
      customerSummary[customer] = (customerSummary[customer] ?? 0) + 1;
    }

    List<MapEntry<String, int>> topCustomers = customerSummary.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Customer Behavior Overview
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
                  "Customer Behavior Overview",
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
                    _buildBehaviorCard("Active Savers", "834", "customers", primaryColor, Icons.bookmark_add),
                    _buildBehaviorCard("Avg Items Saved", "2.8", "per customer", infoColor, Icons.inventory),
                    _buildBehaviorCard("Purchase Rate", "24.8%", "conversion", successColor, Icons.trending_up),
                    _buildBehaviorCard("Avg Save Duration", "12.5 days", "before purchase", warningColor, Icons.schedule),
                  ],
                ),
              ],
            ),
          ),

          // Top Customers
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
                  "Top Customers by Saved Items",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...topCustomers.take(5).map((entry) {
                  var customer = savedItems.firstWhere((item) => item["customerName"] == entry.key);
                  return _buildCustomerCard(customer, entry.value);
                }).toList(),
              ],
            ),
          ),

          // Customer Segmentation
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
                  "Customer Segmentation",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                _buildSegmentCard("High-Value Savers", "156 customers", "Avg save value: \$245", successColor, Icons.diamond),
                _buildSegmentCard("Frequent Browsers", "298 customers", "5+ items saved monthly", primaryColor, Icons.visibility),
                _buildSegmentCard("Discount Seekers", "189 customers", "Only save discounted items", warningColor, Icons.local_offer),
                _buildSegmentCard("Loyal Converters", "78 customers", "85%+ conversion rate", infoColor, Icons.loyalty),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAutomationTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Create New Rule
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
                      "Automation Rules",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "Create Rule",
                      size: bs.sm,
                      icon: Icons.add,
                      onPressed: () {
                        _createAutomationRule();
                      },
                    ),
                  ],
                ),
                Text(
                  "Automate notifications and actions based on customer behavior",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // Automation Rules List
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
                  "Active Rules",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...automationRules.map((rule) => _buildAutomationRuleCard(rule)).toList(),
              ],
            ),
          ),

          // Rule Performance
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
                  "Rule Performance",
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
                    _buildPerformanceCard("Total Triggers", "2,456", "this month", primaryColor, Icons.flash_on),
                    _buildPerformanceCard("Successful Actions", "1,834", "74.7% success rate", successColor, Icons.check_circle),
                    _buildPerformanceCard("Conversions", "152", "from automation", warningColor, Icons.trending_up),
                    _buildPerformanceCard("Revenue Impact", "\$28,450", "attributed to rules", infoColor, Icons.attach_money),
                  ],
                ),
              ],
            ),
          ),

          // Quick Setup Templates
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
                  "Quick Setup Templates",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                _buildTemplateCard("Price Drop Alert", "Notify when saved item price drops", "Set up in 2 minutes", successColor),
                _buildTemplateCard("Back in Stock", "Alert when out-of-stock items return", "Essential for inventory", primaryColor),
                _buildTemplateCard("Wishlist Reminder", "Remind customers about saved items", "Boost conversion rates", warningColor),
                _buildTemplateCard("Similar Product Suggestion", "Recommend alternatives to saved items", "Increase sales opportunities", infoColor),
              ],
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
        spacing: spMd,
        children: [
          // Key Metrics
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
                  "Key Metrics",
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
                    _buildMetricCard("Total Saved Items", "${analyticsData["totalSavedItems"]}", "across all customers", primaryColor, Icons.bookmark),
                    _buildMetricCard("Conversion Rate", "${analyticsData["conversionRate"]}%", "from saved to purchased", successColor, Icons.trending_up),
                    _buildMetricCard("Revenue Generated", "\$${(analyticsData["conversionValue"] as double).currency}", "from saved items", infoColor, Icons.attach_money),
                    _buildMetricCard("Avg Save Duration", "${analyticsData["averageSaveTime"]}", "before purchase", warningColor, Icons.schedule),
                  ],
                ),
              ],
            ),
          ),

          // Monthly Trends
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
                  "Monthly Save & Conversion Trends",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Container(
                  height: 300,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Items Saved vs Converted",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "Saved",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "Converted",
                              style: TextStyle(
                                fontSize: 12,
                                color: successColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spMd),
                      Expanded(
                        child: QHorizontalScroll(
                          children: (analyticsData["monthlyTrend"] as List).map((month) {
                            return Container(
                              width: 80,
                              margin: EdgeInsets.only(right: spSm),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          width: 30,
                                          height: ((month["saved"] as int) / 180 * 200).toDouble(),
                                          decoration: BoxDecoration(
                                            color: primaryColor,
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                        ),
                                        SizedBox(height: spXs),
                                        Container(
                                          width: 30,
                                          height: ((month["converted"] as int) / 180 * 200).toDouble(),
                                          decoration: BoxDecoration(
                                            color: successColor,
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${month["month"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Category Analysis
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
                  "Most Saved Categories",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                _buildCategoryBar("Skincare", 0.35, primaryColor),
                _buildCategoryBar("Aromatherapy", 0.28, successColor),
                _buildCategoryBar("Massage", 0.22, infoColor),
                _buildCategoryBar("Wellness", 0.18, warningColor),
                _buildCategoryBar("Accessories", 0.15, dangerColor),
              ],
            ),
          ),

          // Customer Insights
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
                  "Customer Insights",
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
                    _buildInsightCard("Repeat Savers", "67%", "save multiple items", primaryColor),
                    _buildInsightCard("Mobile Savers", "78%", "use mobile app", successColor),
                    _buildInsightCard("Price Conscious", "45%", "wait for discounts", warningColor),
                    _buildInsightCard("Quick Buyers", "23%", "convert within 24h", infoColor),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStat(String title, String value, Color color, IconData icon) {
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
              Icon(icon, color: color, size: 24),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: fsH6,
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

  Widget _buildSavedItemCard(Map<String, dynamic> item) {
    Color priorityColor = item["wishlistPriority"] == "high" ? dangerColor :
                         item["wishlistPriority"] == "medium" ? warningColor : successColor;

    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border.all(color: priorityColor.withAlpha(30)),
      ),
      child: Column(
        spacing: spMd,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
            child: Stack(
              children: [
                Image.network(
                  "${item["itemImage"]}",
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                if (item["discount"] > 0)
                  Positioned(
                    top: spSm,
                    left: spSm,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: dangerColor,
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Text(
                        "-${(item["discount"] as double).toStringAsFixed(0)}%",
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
                  right: spSm,
                  child: Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: priorityColor,
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Icon(
                      Icons.priority_high,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "${item["itemName"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "${item["brand"]} • ${item["category"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Row(
                  children: [
                    if (item["discount"] > 0)
                      Text(
                        "\$${(item["originalPrice"] as double).currency}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    if (item["discount"] > 0) SizedBox(width: spXs),
                    Text(
                      "\$${(item["price"] as double).currency}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: item["discount"] > 0 ? dangerColor : primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Stock: ${item["stock"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: item["stock"] < 5 ? dangerColor : successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.person, size: 16, color: primaryColor),
                          SizedBox(width: spXs),
                          Text(
                            "${item["customerName"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Spacer(),
                          if (item["inCart"])
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: successColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "In Cart",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Saved: ${DateTime.parse(item["savedDate"]).dMMMy}", 
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Views: ${item["viewCount"]}",
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
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Notify Customer",
                        size: bs.sm,
                        icon: Icons.notifications,
                        onPressed: () {
                          _notifyCustomer(item);
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "View Details",
                        size: bs.sm,
                        icon: Icons.info,
                        color: infoColor,
                        onPressed: () {
                          _viewItemDetails(item);
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

  Widget _buildBehaviorCard(String title, String value, String subtitle, Color color, IconData icon) {
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
              Icon(icon, color: color, size: 24),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: fsH6,
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
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerCard(Map<String, dynamic> customer, int savedCount) {
    return Container(
      padding: EdgeInsets.all(spMd),
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusLg),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Icon(
              Icons.person,
              color: primaryColor,
              size: 20,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${customer["customerName"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${customer["customerEmail"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "$savedCount items saved • \$${(customer["customerHistory"]["totalSpent"] as double).currency} total spent",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            icon: Icons.email,
            size: bs.sm,
            onPressed: () {
              _contactCustomer(customer);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSegmentCard(String title, String count, String description, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spMd),
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: color.withAlpha(60)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text(
                  count,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAutomationRuleCard(Map<String, dynamic> rule) {
    Color statusColor = rule["active"] ? successColor : disabledBoldColor;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusLg),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: statusColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Icon(
              rule["active"] ? Icons.play_arrow : Icons.pause,
              color: statusColor,
              size: 20,
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
                      "${rule["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Text(
                        rule["active"] ? "Active" : "Inactive",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "${rule["type"]} • ${rule["trigger"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${rule["conversions"]} conversions • ${rule["efficiency"]}% efficiency",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            icon: Icons.edit,
            size: bs.sm,
            onPressed: () {
              _editRule(rule);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceCard(String title, String value, String subtitle, Color color, IconData icon) {
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
              Icon(icon, color: color, size: 24),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: fsH6,
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
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTemplateCard(String title, String description, String duration, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: color.withAlpha(60)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Icon(
              Icons.auto_awesome,
              color: Colors.white,
              size: 20,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: color,
                  ),
                ),
                Text(
                  duration,
                  style: TextStyle(
                    fontSize: 12,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            label: "Use Template",
            size: bs.sm,
            color: color,
            onPressed: () {
              _useTemplate(title);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, String subtitle, Color color, IconData icon) {
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
              Icon(icon, color: color, size: 24),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: fsH6,
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
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryBar(String category, double percentage, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                category,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${(percentage * 100).toInt()}%",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: percentage,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightCard(String title, String value, String subtitle, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: color.withAlpha(60)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: color,
            ),
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
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  void _bulkNotify() {
    ss("Sending bulk notifications to customers...");
  }

  void _notifyCustomer(Map<String, dynamic> item) {
    ss("Sending notification to ${item["customerName"]}...");
  }

  void _viewItemDetails(Map<String, dynamic> item) {
    ss("Viewing details for ${item["itemName"]}...");
  }

  void _contactCustomer(Map<String, dynamic> customer) {
    ss("Contacting ${customer["customerName"]}...");
  }

  void _createAutomationRule() {
    ss("Creating new automation rule...");
  }

  void _editRule(Map<String, dynamic> rule) {
    ss("Editing rule: ${rule["name"]}...");
  }

  void _useTemplate(String templateName) {
    ss("Using template: $templateName...");
  }
}
