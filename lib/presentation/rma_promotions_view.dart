import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaPromotionsView extends StatefulWidget {
  const RmaPromotionsView({super.key});

  @override
  State<RmaPromotionsView> createState() => _RmaPromotionsViewState();
}

class _RmaPromotionsViewState extends State<RmaPromotionsView> {
  int selectedTab = 0;
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedType = "All";

  List<Map<String, dynamic>> promotionsData = [
    {
      "id": "PROMO001",
      "code": "SUMMER25",
      "title": "Summer Sale 2024",
      "description": "Get 25% off on all summer collection items",
      "type": "Percentage",
      "value": 25.0,
      "minimum_order": 50.0,
      "maximum_discount": 100.0,
      "usage_limit": 1000,
      "used_count": 342,
      "start_date": "2024-06-01",
      "end_date": "2024-06-30",
      "status": "Active",
      "categories": ["Fashion", "Sports", "Outdoor"],
      "customer_segments": ["All"],
      "auto_apply": false,
      "stackable": false,
      "first_time_only": false,
      "revenue_generated": 8550.75,
      "orders_count": 342,
      "avg_order_value": 75.25,
      "image": "https://picsum.photos/300/200?random=1&keyword=summer"
    },
    {
      "id": "PROMO002",
      "code": "WELCOME15",
      "title": "New Customer Welcome",
      "description": "Welcome! Enjoy 15% off your first purchase",
      "type": "Percentage",
      "value": 15.0,
      "minimum_order": 25.0,
      "maximum_discount": 50.0,
      "usage_limit": null,
      "used_count": 189,
      "start_date": "2024-01-01",
      "end_date": "2024-12-31",
      "status": "Active",
      "categories": ["All"],
      "customer_segments": ["New"],
      "auto_apply": true,
      "stackable": false,
      "first_time_only": true,
      "revenue_generated": 4725.50,
      "orders_count": 189,
      "avg_order_value": 42.15,
      "image": "https://picsum.photos/300/200?random=2&keyword=welcome"
    },
    {
      "id": "PROMO003",
      "code": "FLASH40",
      "title": "Flash Weekend Deal",
      "description": "48-hour flash sale with up to 40% off electronics",
      "type": "Percentage",
      "value": 40.0,
      "minimum_order": 100.0,
      "maximum_discount": 200.0,
      "usage_limit": 500,
      "used_count": 425,
      "start_date": "2024-05-25",
      "end_date": "2024-05-27",
      "status": "Expired",
      "categories": ["Electronics", "Gadgets"],
      "customer_segments": ["VIP", "Premium"],
      "auto_apply": false,
      "stackable": false,
      "first_time_only": false,
      "revenue_generated": 21250.00,
      "orders_count": 425,
      "avg_order_value": 125.65,
      "image": "https://picsum.photos/300/200?random=3&keyword=flash"
    },
    {
      "id": "PROMO004",
      "code": "FREESHIP",
      "title": "Free Shipping Offer",
      "description": "Free shipping on orders above \$50",
      "type": "Free Shipping",
      "value": 0.0,
      "minimum_order": 50.0,
      "maximum_discount": 15.0,
      "usage_limit": null,
      "used_count": 1245,
      "start_date": "2024-01-01",
      "end_date": "2024-12-31",
      "status": "Active",
      "categories": ["All"],
      "customer_segments": ["All"],
      "auto_apply": true,
      "stackable": true,
      "first_time_only": false,
      "revenue_generated": 62250.00,
      "orders_count": 1245,
      "avg_order_value": 67.85,
      "image": "https://picsum.photos/300/200?random=4&keyword=shipping"
    },
    {
      "id": "PROMO005",
      "code": "LOYALTY10",
      "title": "Loyalty Rewards",
      "description": "Exclusive 10% discount for loyal customers",
      "type": "Percentage",
      "value": 10.0,
      "minimum_order": 30.0,
      "maximum_discount": 75.0,
      "usage_limit": null,
      "used_count": 658,
      "start_date": "2024-03-01",
      "end_date": "2024-12-31",
      "status": "Paused",
      "categories": ["All"],
      "customer_segments": ["VIP", "Premium"],
      "auto_apply": false,
      "stackable": true,
      "first_time_only": false,
      "revenue_generated": 19740.50,
      "orders_count": 658,
      "avg_order_value": 58.45,
      "image": "https://picsum.photos/300/200?random=5&keyword=loyalty"
    },
    {
      "id": "PROMO006",
      "code": "FIXED20",
      "title": "Fixed \$20 Off",
      "description": "Get \$20 off on orders above \$100",
      "type": "Fixed Amount",
      "value": 20.0,
      "minimum_order": 100.0,
      "maximum_discount": 20.0,
      "usage_limit": 300,
      "used_count": 156,
      "start_date": "2024-06-15",
      "end_date": "2024-07-15",
      "status": "Active",
      "categories": ["Home", "Electronics"],
      "customer_segments": ["Regular", "Premium"],
      "auto_apply": false,
      "stackable": false,
      "first_time_only": false,
      "revenue_generated": 7020.00,
      "orders_count": 156,
      "avg_order_value": 115.50,
      "image": "https://picsum.photos/300/200?random=6&keyword=discount"
    }
  ];

  List<Map<String, dynamic>> get filteredPromotions {
    return promotionsData.where((promo) {
      bool matchesSearch = "${promo["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${promo["code"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${promo["description"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesStatus = selectedStatus == "All" || promo["status"] == selectedStatus;
      bool matchesType = selectedType == "All" || promo["type"] == selectedType;
      
      return matchesSearch && matchesStatus && matchesType;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Promotions",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Active", icon: Icon(Icons.local_offer)),
        Tab(text: "All Promos", icon: Icon(Icons.confirmation_number)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "Create", icon: Icon(Icons.add_circle)),
      ],
      tabChildren: [
        _buildActivePromotionsTab(),
        _buildAllPromotionsTab(),
        _buildAnalyticsTab(),
        _buildCreateTab(),
      ],
    );
  }

  Widget _buildActivePromotionsTab() {
    List<Map<String, dynamic>> activePromos = promotionsData.where((p) => p["status"] == "Active").toList();
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildActiveStats(activePromos),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Text(
                "Currently Active Promotions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ...activePromos.map((promo) => _buildPromotionCard(promo)).toList(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActiveStats(List<Map<String, dynamic>> activePromos) {
    double totalRevenue = activePromos.fold(0.0, (sum, p) => sum + (p["revenue_generated"] as double));
    int totalOrders = activePromos.fold(0, (sum, p) => sum + (p["orders_count"] as int));
    int totalUsage = activePromos.fold(0, (sum, p) => sum + (p["used_count"] as int));

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
                  "${activePromos.length}",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Active Promos",
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
                  "\$${(totalRevenue.toDouble()).currency}",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Revenue",
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
                  "$totalUsage",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: warningColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Total Uses",
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

  Widget _buildAllPromotionsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildSearchAndFilters(),
          _buildOverallStats(),
          _buildPromotionsList(),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Column(
      spacing: spSm,
      children: [
        QTextField(
          label: "Search promotions",
          value: searchQuery,
          hint: "Search by title, code, or description",
          onChanged: (value) {
            searchQuery = value;
            setState(() {});
          },
        ),
        Row(
          children: [
            Expanded(
              child: QDropdownField(
                label: "Status",
                items: [
                  {"label": "All", "value": "All"},
                  {"label": "Active", "value": "Active"},
                  {"label": "Paused", "value": "Paused"},
                  {"label": "Expired", "value": "Expired"},
                  {"label": "Scheduled", "value": "Scheduled"},
                ],
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
                label: "Type",
                items: [
                  {"label": "All", "value": "All"},
                  {"label": "Percentage", "value": "Percentage"},
                  {"label": "Fixed Amount", "value": "Fixed Amount"},
                  {"label": "Free Shipping", "value": "Free Shipping"},
                ],
                value: selectedType,
                onChanged: (value, label) {
                  selectedType = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOverallStats() {
    double totalRevenue = promotionsData.fold(0.0, (sum, p) => sum + (p["revenue_generated"] as double));
    int totalOrders = promotionsData.fold(0, (sum, p) => sum + (p["orders_count"] as int));
    int totalPromotions = promotionsData.length;
    double avgOrderValue = totalOrders > 0 ? totalRevenue / totalOrders : 0;

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
                  "$totalPromotions",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Total Promos",
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
                  "\$${(totalRevenue.toDouble()).currency}",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Total Revenue",
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
                    color: warningColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Avg Order",
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

  Widget _buildPromotionsList() {
    return Column(
      spacing: spSm,
      children: filteredPromotions.map((promo) => _buildPromotionCard(promo)).toList(),
    );
  }

  Widget _buildPromotionCard(Map<String, dynamic> promo) {
    double usagePercentage = promo["usage_limit"] != null 
        ? ((promo["used_count"] as int) / (promo["usage_limit"] as int)) * 100 
        : 0;

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
                width: 80,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusSm),
                  image: DecorationImage(
                    image: NetworkImage("${promo["image"]}"),
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
                        Expanded(
                          child: Text(
                            "${promo["title"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: fsH6,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: _getStatusColor(promo["status"]).withAlpha(50),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${promo["status"]}",
                            style: TextStyle(
                              color: _getStatusColor(promo["status"]),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${promo["code"]}",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontFamily: "monospace",
                        ),
                      ),
                    ),
                    Text(
                      "${promo["type"]} • ${promo["start_date"]} - ${promo["end_date"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text(
            "${promo["description"]}",
            style: TextStyle(
              fontSize: 13,
              color: disabledBoldColor,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Text(
                      "Discount: ",
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      promo["type"] == "Percentage" 
                          ? "${(promo["value"] as double).toStringAsFixed(0)}% off"
                          : promo["type"] == "Fixed Amount"
                              ? "\$${(promo["value"] as double).toStringAsFixed(0)} off"
                              : "Free Shipping",
                      style: TextStyle(fontSize: 12, color: successColor, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Text(
                      "Min: \$${(promo["minimum_order"] as double).toStringAsFixed(0)}",
                      style: TextStyle(fontSize: 11, color: disabledBoldColor),
                    ),
                  ],
                ),
                if (promo["usage_limit"] != null) ...[
                  Row(
                    children: [
                      Text(
                        "Usage: ${promo["used_count"]}/${promo["usage_limit"]}",
                        style: TextStyle(fontSize: 11, color: disabledBoldColor),
                      ),
                      Spacer(),
                      Text(
                        "${usagePercentage.toStringAsFixed(0)}%",
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Container(
                    height: 4,
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: usagePercentage / 100,
                      child: Container(
                        decoration: BoxDecoration(
                          color: usagePercentage > 80 ? dangerColor : 
                                 usagePercentage > 60 ? warningColor : successColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "\$${((promo["revenue_generated"] as double).toDouble()).currency}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Revenue",
                      style: TextStyle(fontSize: 10, color: disabledBoldColor),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "${promo["orders_count"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Orders",
                      style: TextStyle(fontSize: 10, color: disabledBoldColor),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "\$${(promo["avg_order_value"] as double).toStringAsFixed(0)}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: warningColor,
                      ),
                    ),
                    Text(
                      "Avg Order",
                      style: TextStyle(fontSize: 10, color: disabledBoldColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spXs,
            children: [
              Row(
                children: [
                  Text(
                    "Categories: ",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11),
                  ),
                  Expanded(
                    child: Text(
                      (promo["categories"] as List).join(", "),
                      style: TextStyle(fontSize: 11, color: disabledBoldColor),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Segments: ",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11),
                  ),
                  Expanded(
                    child: Text(
                      (promo["customer_segments"] as List).join(", "),
                      style: TextStyle(fontSize: 11, color: disabledBoldColor),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  if (promo["auto_apply"] as bool) ...[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "Auto Apply",
                        style: TextStyle(
                          color: successColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: spXs),
                  ],
                  if (promo["stackable"] as bool) ...[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "Stackable",
                        style: TextStyle(
                          color: infoColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: spXs),
                  ],
                  if (promo["first_time_only"] as bool) ...[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "First Time Only",
                        style: TextStyle(
                          color: warningColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
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
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {
                    // View promotion details
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: promo["status"] == "Active" ? Icons.pause : Icons.play_arrow,
                size: bs.sm,
                onPressed: () {
                  // Toggle promotion status
                },
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {
                  // Edit promotion
                },
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.content_copy,
                size: bs.sm,
                onPressed: () {
                  // Copy promotion code
                },
              ),
            ],
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
          _buildTypeAnalytics(),
          _buildUsageAnalytics(),
          _buildTopPerformers(),
        ],
      ),
    );
  }

  Widget _buildTypeAnalytics() {
    Map<String, Map<String, dynamic>> typeStats = {};
    
    for (var promo in promotionsData) {
      String type = promo["type"] as String;
      if (!typeStats.containsKey(type)) {
        typeStats[type] = {
          "count": 0,
          "revenue": 0.0,
          "orders": 0,
          "usage": 0,
        };
      }
      typeStats[type]!["count"] += 1;
      typeStats[type]!["revenue"] += (promo["revenue_generated"] as double);
      typeStats[type]!["orders"] += (promo["orders_count"] as int);
      typeStats[type]!["usage"] += (promo["used_count"] as int);
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
            "Performance by Type",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: typeStats.entries.map((entry) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: _getTypeColor(entry.key).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      entry.key,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: _getTypeColor(entry.key),
                      ),
                    ),
                    Text(
                      "${entry.value["count"]} promotions",
                      style: TextStyle(fontSize: 11, color: disabledBoldColor),
                    ),
                    Text(
                      "Revenue: \$${((entry.value["revenue"] as double).toDouble()).currency}",
                      style: TextStyle(fontSize: 11, color: disabledBoldColor),
                    ),
                    Text(
                      "Orders: ${entry.value["orders"]}",
                      style: TextStyle(fontSize: 11, color: disabledBoldColor),
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

  Widget _buildUsageAnalytics() {
    int activePromos = promotionsData.where((p) => p["status"] == "Active").length;
    int expiredPromos = promotionsData.where((p) => p["status"] == "Expired").length;
    int pausedPromos = promotionsData.where((p) => p["status"] == "Paused").length;
    
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
            "Usage Statistics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "$activePromos",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Active",
                        style: TextStyle(fontSize: 11, color: disabledBoldColor),
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
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "$expiredPromos",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Expired",
                        style: TextStyle(fontSize: 11, color: disabledBoldColor),
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
                    color: warningColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "$pausedPromos",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Paused",
                        style: TextStyle(fontSize: 11, color: disabledBoldColor),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTopPerformers() {
    var sortedPromos = List<Map<String, dynamic>>.from(promotionsData);
    sortedPromos.sort((a, b) => (b["revenue_generated"] as double).compareTo(a["revenue_generated"] as double));

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
            "Top Performing Promotions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          ...sortedPromos.take(3).map((promo) {
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${promo["title"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          "${promo["orders_count"]} orders • ${promo["used_count"]} uses",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "\$${((promo["revenue_generated"] as double).toDouble()).currency}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: successColor,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildCreateTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
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
                  "Create New Promotion",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                QButton(
                  label: "Percentage Discount",
                  size: bs.md,
                  onPressed: () {
                    // Create percentage discount
                  },
                ),
                QButton(
                  label: "Fixed Amount Discount",
                  size: bs.md,
                  onPressed: () {
                    // Create fixed amount discount
                  },
                ),
                QButton(
                  label: "Free Shipping Offer",
                  size: bs.md,
                  onPressed: () {
                    // Create free shipping offer
                  },
                ),
                QButton(
                  label: "Buy One Get One",
                  size: bs.md,
                  onPressed: () {
                    // Create BOGO offer
                  },
                ),
              ],
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
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Quick Actions",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                QButton(
                  label: "Bulk Import Codes",
                  size: bs.md,
                  onPressed: () {
                    // Bulk import promotion codes
                  },
                ),
                QButton(
                  label: "Export Promotion Report",
                  size: bs.md,
                  onPressed: () {
                    // Export report
                  },
                ),
                QButton(
                  label: "Schedule Promotion",
                  size: bs.md,
                  onPressed: () {
                    // Schedule promotion
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Expired":
        return infoColor;
      case "Paused":
        return warningColor;
      case "Scheduled":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "Percentage":
        return primaryColor;
      case "Fixed Amount":
        return successColor;
      case "Free Shipping":
        return infoColor;
      default:
        return warningColor;
    }
  }
}
