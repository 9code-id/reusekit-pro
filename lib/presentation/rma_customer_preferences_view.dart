import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaCustomerPreferencesView extends StatefulWidget {
  const RmaCustomerPreferencesView({super.key});

  @override
  State<RmaCustomerPreferencesView> createState() => _RmaCustomerPreferencesViewState();
}

class _RmaCustomerPreferencesViewState extends State<RmaCustomerPreferencesView> {
  int selectedTab = 0;
  String searchQuery = "";
  String selectedSegment = "All";
  String selectedCategory = "All";

  List<Map<String, dynamic>> customerData = [
    {
      "id": "CUST001",
      "name": "Sarah Johnson",
      "email": "sarah.johnson@email.com",
      "avatar": "https://picsum.photos/80/80?random=1&keyword=woman",
      "segment": "Premium",
      "total_orders": 45,
      "total_spent": 2850.50,
      "avg_order": 63.34,
      "last_order": "2024-06-18",
      "preferred_categories": ["Electronics", "Fashion", "Home"],
      "communication_preference": "Email",
      "purchase_frequency": "Weekly",
      "price_sensitivity": "Low",
      "brand_loyalty": "High",
      "device_preference": "Mobile",
      "payment_method": "Credit Card",
      "delivery_preference": "Standard",
      "review_tendency": "Always",
      "discount_responsive": true,
      "seasonal_buyer": false
    },
    {
      "id": "CUST002",
      "name": "Michael Chen",
      "email": "michael.chen@email.com",
      "avatar": "https://picsum.photos/80/80?random=2&keyword=man",
      "segment": "Regular",
      "total_orders": 12,
      "total_spent": 450.75,
      "avg_order": 37.56,
      "last_order": "2024-06-15",
      "preferred_categories": ["Electronics", "Books"],
      "communication_preference": "SMS",
      "purchase_frequency": "Monthly",
      "price_sensitivity": "High",
      "brand_loyalty": "Medium",
      "device_preference": "Desktop",
      "payment_method": "PayPal",
      "delivery_preference": "Express",
      "review_tendency": "Sometimes",
      "discount_responsive": true,
      "seasonal_buyer": true
    },
    {
      "id": "CUST003",
      "name": "Emma Davis",
      "email": "emma.davis@email.com",
      "avatar": "https://picsum.photos/80/80?random=3&keyword=woman",
      "segment": "VIP",
      "total_orders": 78,
      "total_spent": 5240.25,
      "avg_order": 67.18,
      "last_order": "2024-06-17",
      "preferred_categories": ["Fashion", "Beauty", "Home"],
      "communication_preference": "Email",
      "purchase_frequency": "Weekly",
      "price_sensitivity": "Low",
      "brand_loyalty": "High",
      "device_preference": "Mobile",
      "payment_method": "Credit Card",
      "delivery_preference": "Express",
      "review_tendency": "Always",
      "discount_responsive": false,
      "seasonal_buyer": true
    },
    {
      "id": "CUST004",
      "name": "David Wilson",
      "email": "david.wilson@email.com",
      "avatar": "https://picsum.photos/80/80?random=4&keyword=man",
      "segment": "New",
      "total_orders": 3,
      "total_spent": 125.00,
      "avg_order": 41.67,
      "last_order": "2024-06-10",
      "preferred_categories": ["Sports", "Electronics"],
      "communication_preference": "Push",
      "purchase_frequency": "Occasionally",
      "price_sensitivity": "High",
      "brand_loyalty": "Low",
      "device_preference": "Mobile",
      "payment_method": "Debit Card",
      "delivery_preference": "Standard",
      "review_tendency": "Rarely",
      "discount_responsive": true,
      "seasonal_buyer": false
    },
    {
      "id": "CUST005",
      "name": "Lisa Thompson",
      "email": "lisa.thompson@email.com",
      "avatar": "https://picsum.photos/80/80?random=5&keyword=woman",
      "segment": "Regular",
      "total_orders": 28,
      "total_spent": 980.40,
      "avg_order": 35.01,
      "last_order": "2024-06-12",
      "preferred_categories": ["Books", "Home", "Health"],
      "communication_preference": "Email",
      "purchase_frequency": "Monthly",
      "price_sensitivity": "Medium",
      "brand_loyalty": "Medium",
      "device_preference": "Desktop",
      "payment_method": "Credit Card",
      "delivery_preference": "Standard",
      "review_tendency": "Sometimes",
      "discount_responsive": true,
      "seasonal_buyer": true
    }
  ];

  List<Map<String, dynamic>> get filteredCustomers {
    return customerData.where((customer) {
      bool matchesSearch = "${customer["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${customer["email"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesSegment = selectedSegment == "All" || customer["segment"] == selectedSegment;
      bool matchesCategory = selectedCategory == "All" || 
                            (customer["preferred_categories"] as List).contains(selectedCategory);
      
      return matchesSearch && matchesSegment && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Customer Preferences",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Profiles", icon: Icon(Icons.person)),
        Tab(text: "Segments", icon: Icon(Icons.group)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildProfilesTab(),
        _buildSegmentsTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildProfilesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildSearchAndFilters(),
          _buildOverviewStats(),
          _buildCustomerProfiles(),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Column(
      spacing: spSm,
      children: [
        QTextField(
          label: "Search customers",
          value: searchQuery,
          hint: "Search by name or email",
          onChanged: (value) {
            searchQuery = value;
            setState(() {});
          },
        ),
        Row(
          children: [
            Expanded(
              child: QDropdownField(
                label: "Segment",
                items: [
                  {"label": "All", "value": "All"},
                  {"label": "VIP", "value": "VIP"},
                  {"label": "Premium", "value": "Premium"},
                  {"label": "Regular", "value": "Regular"},
                  {"label": "New", "value": "New"},
                ],
                value: selectedSegment,
                onChanged: (value, label) {
                  selectedSegment = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QDropdownField(
                label: "Category",
                items: [
                  {"label": "All", "value": "All"},
                  {"label": "Electronics", "value": "Electronics"},
                  {"label": "Fashion", "value": "Fashion"},
                  {"label": "Home", "value": "Home"},
                  {"label": "Books", "value": "Books"},
                  {"label": "Beauty", "value": "Beauty"},
                  {"label": "Sports", "value": "Sports"},
                ],
                value: selectedCategory,
                onChanged: (value, label) {
                  selectedCategory = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOverviewStats() {
    int totalCustomers = customerData.length;
    double avgOrderValue = customerData.fold(0.0, (sum, c) => sum + (c["avg_order"] as double)) / totalCustomers;
    int activeCustomers = customerData.where((c) => c["purchase_frequency"] != "Rarely").length;
    int loyalCustomers = customerData.where((c) => c["brand_loyalty"] == "High").length;

    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Text(
                  "$totalCustomers",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Total Customers",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Text(
                  "\$${avgOrderValue.toStringAsFixed(0)}",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Avg Order Value",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Text(
                  "$loyalCustomers",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: warningColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Loyal Customers",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCustomerProfiles() {
    return Column(
      spacing: spSm,
      children: filteredCustomers.map((customer) {
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
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusLg),
                      image: DecorationImage(
                        image: NetworkImage("${customer["avatar"]}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${customer["name"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: fsH6,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: _getSegmentColor(customer["segment"]).withAlpha(50),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${customer["segment"]}",
                                style: TextStyle(
                                  color: _getSegmentColor(customer["segment"]),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${customer["email"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "${customer["total_orders"]} orders",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "\$${((customer["total_spent"] as double).toDouble()).currency}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "Preferences & Behavior",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: primaryColor,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Categories: ${(customer["preferred_categories"] as List).take(2).join(", ")}",
                            style: TextStyle(fontSize: 11, color: disabledBoldColor),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Frequency: ${customer["purchase_frequency"]}",
                            style: TextStyle(fontSize: 11, color: disabledBoldColor),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Loyalty: ${customer["brand_loyalty"]}",
                            style: TextStyle(fontSize: 11, color: disabledBoldColor),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Device: ${customer["device_preference"]}",
                            style: TextStyle(fontSize: 11, color: disabledBoldColor),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Price Sensitivity: ${customer["price_sensitivity"]}",
                            style: TextStyle(fontSize: 11, color: disabledBoldColor),
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
                    child: Row(
                      children: [
                        if (customer["discount_responsive"] as bool) ...[
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(50),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "Discount Responsive",
                              style: TextStyle(
                                color: successColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(width: spXs),
                        ],
                        if (customer["seasonal_buyer"] as bool) ...[
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(50),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "Seasonal",
                              style: TextStyle(
                                color: infoColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  QButton(
                    icon: Icons.person,
                    size: bs.sm,
                    onPressed: () {
                      // View detailed profile
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSegmentsTab() {
    Map<String, List<Map<String, dynamic>>> segments = {};
    for (var customer in customerData) {
      String segment = customer["segment"] as String;
      if (!segments.containsKey(segment)) {
        segments[segment] = [];
      }
      segments[segment]!.add(customer);
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Text(
            "Customer Segments Analysis",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: segments.entries.map((entry) {
              double avgSpent = entry.value.fold(0.0, (sum, c) => sum + (c["total_spent"] as double)) / entry.value.length;
              int totalOrders = entry.value.fold(0, (sum, c) => sum + (c["total_orders"] as int));
              
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
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: _getSegmentColor(entry.key),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "${entry.key} Customers",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: fsH6,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${entry.value.length} customers",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: _getSegmentColor(entry.key),
                      ),
                    ),
                    Column(
                      spacing: spXs,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Avg Spent:",
                              style: TextStyle(fontSize: 12, color: disabledBoldColor),
                            ),
                            Text(
                              "\$${avgSpent.toStringAsFixed(0)}",
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Orders:",
                              style: TextStyle(fontSize: 12, color: disabledBoldColor),
                            ),
                            Text(
                              "$totalOrders",
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
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
          _buildPreferenceAnalytics(),
          _buildBehaviorAnalytics(),
          _buildTrendAnalytics(),
        ],
      ),
    );
  }

  Widget _buildPreferenceAnalytics() {
    Map<String, int> categoryPrefs = {};
    Map<String, int> devicePrefs = {};
    Map<String, int> paymentPrefs = {};

    for (var customer in customerData) {
      for (var category in (customer["preferred_categories"] as List)) {
        categoryPrefs[category] = (categoryPrefs[category] ?? 0) + 1;
      }
      String device = customer["device_preference"] as String;
      devicePrefs[device] = (devicePrefs[device] ?? 0) + 1;
      
      String payment = customer["payment_method"] as String;
      paymentPrefs[payment] = (paymentPrefs[payment] ?? 0) + 1;
    }

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
          Text(
            "Preference Analytics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Text(
                "Top Categories",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              ...categoryPrefs.entries.take(3).map((entry) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(entry.key, style: TextStyle(fontSize: 12)),
                    Text("${entry.value} customers", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                  ],
                );
              }).toList(),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "Device Preference",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                    ),
                    ...devicePrefs.entries.map((entry) {
                      return Text(
                        "${entry.key}: ${entry.value}",
                        style: TextStyle(fontSize: 11, color: disabledBoldColor),
                      );
                    }).toList(),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "Payment Method",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                    ),
                    ...paymentPrefs.entries.map((entry) {
                      return Text(
                        "${entry.key}: ${entry.value}",
                        style: TextStyle(fontSize: 11, color: disabledBoldColor),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBehaviorAnalytics() {
    Map<String, int> loyaltyDistribution = {};
    Map<String, int> sensitivityDistribution = {};
    int discountResponsive = customerData.where((c) => c["discount_responsive"] as bool).length;
    int seasonalBuyers = customerData.where((c) => c["seasonal_buyer"] as bool).length;

    for (var customer in customerData) {
      String loyalty = customer["brand_loyalty"] as String;
      loyaltyDistribution[loyalty] = (loyaltyDistribution[loyalty] ?? 0) + 1;
      
      String sensitivity = customer["price_sensitivity"] as String;
      sensitivityDistribution[sensitivity] = (sensitivityDistribution[sensitivity] ?? 0) + 1;
    }

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
          Text(
            "Behavior Analytics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  children: [
                    Text(
                      "$discountResponsive",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Discount Responsive",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  children: [
                    Text(
                      "$seasonalBuyers",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                    Text(
                      "Seasonal Buyers",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "Brand Loyalty",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                    ),
                    ...loyaltyDistribution.entries.map((entry) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(entry.key, style: TextStyle(fontSize: 11)),
                          Text("${entry.value}", style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "Price Sensitivity",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                    ),
                    ...sensitivityDistribution.entries.map((entry) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(entry.key, style: TextStyle(fontSize: 11)),
                          Text("${entry.value}", style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTrendAnalytics() {
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
          Text(
            "Trends & Insights",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          Column(
            spacing: spSm,
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Icon(Icons.trending_up, color: primaryColor, size: 20),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "Mobile preference increasing by 15% this quarter",
                        style: TextStyle(fontSize: 12, color: disabledBoldColor),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Icon(Icons.insights, color: successColor, size: 20),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "VIP customers spend 3x more than regular customers",
                        style: TextStyle(fontSize: 12, color: disabledBoldColor),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Icon(Icons.warning, color: warningColor, size: 20),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "High price sensitivity customers have 40% lower retention",
                        style: TextStyle(fontSize: 12, color: disabledBoldColor),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getSegmentColor(String segment) {
    switch (segment) {
      case "VIP":
        return dangerColor;
      case "Premium":
        return warningColor;
      case "Regular":
        return successColor;
      case "New":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }
}
