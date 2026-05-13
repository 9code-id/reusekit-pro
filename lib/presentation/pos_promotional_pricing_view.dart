import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosPromotionalPricingView extends StatefulWidget {
  const PosPromotionalPricingView({super.key});

  @override
  State<PosPromotionalPricingView> createState() => _PosPromotionalPricingViewState();
}

class _PosPromotionalPricingViewState extends State<PosPromotionalPricingView> {
  int selectedTab = 0;
  String selectedStatus = "all";
  String searchQuery = "";
  bool loading = false;

  // Create Promotion Form
  String promotionName = "";
  String promotionType = "percentage";
  String discountValue = "";
  String selectedProduct = "";
  String startDate = DateTime.now().toString();
  String endDate = DateTime.now().add(Duration(days: 30)).toString();
  String minimumPurchase = "";
  String maxDiscount = "";
  bool isActive = true;

  List<Map<String, dynamic>> promotionTypes = [
    {"label": "Percentage Discount", "value": "percentage"},
    {"label": "Fixed Amount", "value": "fixed"},
    {"label": "Buy One Get One", "value": "bogo"},
    {"label": "Bundle Discount", "value": "bundle"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Scheduled", "value": "scheduled"},
    {"label": "Expired", "value": "expired"},
    {"label": "Paused", "value": "paused"},
  ];

  List<Map<String, dynamic>> products = [
    {"label": "Wireless Headphones", "value": "prod_001"},
    {"label": "Bluetooth Speaker", "value": "prod_002"},
    {"label": "Smart Watch", "value": "prod_003"},
    {"label": "Phone Case", "value": "prod_004"},
  ];

  List<Map<String, dynamic>> promotions = [
    {
      "id": "promo_001",
      "name": "Summer Sale - Electronics",
      "type": "percentage",
      "discount": 25.0,
      "product": "Wireless Headphones",
      "original_price": 89.99,
      "discounted_price": 67.49,
      "start_date": "2024-06-01",
      "end_date": "2024-06-30",
      "status": "active",
      "min_purchase": 50.0,
      "max_discount": 100.0,
      "usage_count": 147,
      "total_savings": 3234.50,
      "image": "https://picsum.photos/80/80?random=1&keyword=headphones"
    },
    {
      "id": "promo_002",
      "name": "Flash Sale - Speakers",
      "type": "fixed",
      "discount": 15.0,
      "product": "Bluetooth Speaker",
      "original_price": 129.99,
      "discounted_price": 114.99,
      "start_date": "2024-06-15",
      "end_date": "2024-06-20",
      "status": "expired",
      "min_purchase": 0.0,
      "max_discount": 15.0,
      "usage_count": 89,
      "total_savings": 1335.00,
      "image": "https://picsum.photos/80/80?random=2&keyword=speaker"
    },
    {
      "id": "promo_003",
      "name": "BOGO Smart Watches",
      "type": "bogo",
      "discount": 50.0,
      "product": "Smart Watch",
      "original_price": 199.99,
      "discounted_price": 199.99,
      "start_date": "2024-07-01",
      "end_date": "2024-07-15",
      "status": "scheduled",
      "min_purchase": 200.0,
      "max_discount": 199.99,
      "usage_count": 0,
      "total_savings": 0.0,
      "image": "https://picsum.photos/80/80?random=3&keyword=watch"
    },
    {
      "id": "promo_004",
      "name": "Bundle Deal - Accessories",
      "type": "bundle",
      "discount": 30.0,
      "product": "Phone Case",
      "original_price": 24.99,
      "discounted_price": 17.49,
      "start_date": "2024-06-10",
      "end_date": "2024-12-31",
      "status": "paused",
      "min_purchase": 25.0,
      "max_discount": 50.0,
      "usage_count": 23,
      "total_savings": 172.50,
      "image": "https://picsum.photos/80/80?random=4&keyword=phone"
    },
  ];

  List<Map<String, dynamic>> get filteredPromotions {
    return promotions.where((promo) {
      final matchesStatus = selectedStatus == "all" || promo["status"] == selectedStatus;
      final matchesSearch = searchQuery.isEmpty || 
        promo["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
        promo["product"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      return matchesStatus && matchesSearch;
    }).toList();
  }

  void _createPromotion() async {
    if (promotionName.isEmpty || discountValue.isEmpty) {
      se("Please fill in required fields");
      return;
    }

    loading = true;
    setState(() {});

    await Future.delayed(Duration(milliseconds: 1000));

    // Add new promotion to list
    final newPromo = {
      "id": "promo_${DateTime.now().millisecondsSinceEpoch}",
      "name": promotionName,
      "type": promotionType,
      "discount": double.tryParse(discountValue) ?? 0.0,
      "product": products.firstWhere((p) => p["value"] == selectedProduct)["label"],
      "original_price": 99.99,
      "discounted_price": promotionType == "percentage" 
        ? 99.99 * (1 - (double.tryParse(discountValue) ?? 0) / 100)
        : 99.99 - (double.tryParse(discountValue) ?? 0),
      "start_date": DateTime.parse(startDate).toString().substring(0, 10),
      "end_date": DateTime.parse(endDate).toString().substring(0, 10),
      "status": isActive ? "active" : "paused",
      "min_purchase": double.tryParse(minimumPurchase) ?? 0.0,
      "max_discount": double.tryParse(maxDiscount) ?? 0.0,
      "usage_count": 0,
      "total_savings": 0.0,
      "image": "https://picsum.photos/80/80?random=10&keyword=product"
    };

    promotions.insert(0, newPromo);

    // Reset form
    promotionName = "";
    discountValue = "";
    selectedProduct = "";
    minimumPurchase = "";
    maxDiscount = "";
    isActive = true;

    loading = false;
    selectedTab = 0;
    setState(() {});
    ss("Promotion created successfully");
  }

  void _togglePromotionStatus(String promoId) async {
    loading = true;
    setState(() {});

    await Future.delayed(Duration(milliseconds: 500));

    final promoIndex = promotions.indexWhere((p) => p["id"] == promoId);
    if (promoIndex != -1) {
      final currentStatus = promotions[promoIndex]["status"];
      promotions[promoIndex]["status"] = 
        currentStatus == "active" ? "paused" : 
        currentStatus == "paused" ? "active" : currentStatus;
    }

    loading = false;
    setState(() {});
    si("Promotion status updated");
  }

  void _deletePromotion(String promoId) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this promotion?");
    if (isConfirmed) {
      promotions.removeWhere((p) => p["id"] == promoId);
      setState(() {});
      ss("Promotion deleted successfully");
    }
  }

  Widget _buildPromotionStats() {
    final activePromotions = promotions.where((p) => p["status"] == "active").length;
    final totalSavings = promotions.map((p) => p["total_savings"] as double)
        .fold(0.0, (sum, savings) => sum + savings);
    final totalUsage = promotions.map((p) => p["usage_count"] as int)
        .fold(0, (sum, usage) => sum + usage);

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
                Icon(
                  Icons.local_offer,
                  color: primaryColor,
                  size: 32,
                ),
                SizedBox(height: spXs),
                Text(
                  "$activePromotions",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Active Promos",
                  style: TextStyle(
                    fontSize: 12,
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
                Icon(
                  Icons.savings,
                  color: successColor,
                  size: 32,
                ),
                SizedBox(height: spXs),
                Text(
                  "\$${totalSavings.toStringAsFixed(0)}",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                Text(
                  "Total Savings",
                  style: TextStyle(
                    fontSize: 12,
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
                Icon(
                  Icons.trending_up,
                  color: warningColor,
                  size: 32,
                ),
                SizedBox(height: spXs),
                Text(
                  "$totalUsage",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: warningColor,
                  ),
                ),
                Text(
                  "Total Usage",
                  style: TextStyle(
                    fontSize: 12,
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

  Widget _buildPromotionsListTab() {
    return Column(
      spacing: spMd,
      children: [
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search Promotions",
                  value: searchQuery,
                  hint: "Enter promotion name or product",
                  onChanged: (value) {
                    searchQuery = value;
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
        ),
        ...filteredPromotions.map((promo) => _buildPromotionCard(promo)),
      ],
    );
  }

  Widget _buildPromotionCard(Map<String, dynamic> promo) {
    final isActive = promo["status"] == "active";
    final isExpired = promo["status"] == "expired";
    final isScheduled = promo["status"] == "scheduled";
    final isPaused = promo["status"] == "paused";

    Color statusColor = disabledBoldColor;
    if (isActive) statusColor = successColor;
    else if (isExpired) statusColor = dangerColor;
    else if (isScheduled) statusColor = infoColor;
    else if (isPaused) statusColor = warningColor;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: statusColor.withAlpha(50)),
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
                  "${promo["image"]}",
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
                      "${promo["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${promo["product"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${promo["status"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              color: statusColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            promo["type"] == "percentage" 
                              ? "${(promo["discount"] as double).toStringAsFixed(0)}% OFF"
                              : "\$${(promo["discount"] as double).toStringAsFixed(0)} OFF",
                            style: TextStyle(
                              fontSize: 10,
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
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
                    icon: isActive || isPaused ? Icons.pause : Icons.play_arrow,
                    size: bs.sm,
                    onPressed: () => _togglePromotionStatus(promo["id"]),
                  ),
                  SizedBox(height: spXs),
                  QButton(
                    icon: Icons.delete,
                    size: bs.sm,
                    onPressed: () => _deletePromotion(promo["id"]),
                  ),
                ],
              ),
            ],
          ),
          Divider(color: disabledOutlineBorderColor),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Original Price",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${(promo["original_price"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 14,
                        decoration: TextDecoration.lineThrough,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sale Price",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${(promo["discounted_price"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Usage",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${promo["usage_count"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Savings",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${(promo["total_savings"] as double).toStringAsFixed(0)}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.schedule,
                  color: infoColor,
                  size: 16,
                ),
                SizedBox(width: spXs),
                Text(
                  "${promo["start_date"]} to ${promo["end_date"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: infoColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreatePromotionTab() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Create New Promotion",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Promotion Name",
            value: promotionName,
            hint: "Enter promotion name",
            validator: Validator.required,
            onChanged: (value) {
              promotionName = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Promotion Type",
                  items: promotionTypes,
                  value: promotionType,
                  onChanged: (value, label) {
                    promotionType = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QNumberField(
                  label: promotionType == "percentage" ? "Discount (%)" : "Discount (\$)",
                  value: discountValue,
                  validator: Validator.required,
                  onChanged: (value) {
                    discountValue = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Select Product",
            items: products,
            value: selectedProduct,
            onChanged: (value, label) {
              selectedProduct = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDatePicker(
                  label: "Start Date",
                  value: DateTime.parse(startDate),
                  onChanged: (value) {
                    startDate = value.toString();
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDatePicker(
                  label: "End Date",
                  value: DateTime.parse(endDate),
                  onChanged: (value) {
                    endDate = value.toString();
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QNumberField(
                  label: "Minimum Purchase (\$)",
                  value: minimumPurchase,
                  hint: "Optional minimum amount",
                  onChanged: (value) {
                    minimumPurchase = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QNumberField(
                  label: "Max Discount (\$)",
                  value: maxDiscount,
                  hint: "Optional discount limit",
                  onChanged: (value) {
                    maxDiscount = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QSwitch(
            items: [
              {
                "label": "Activate immediately",
                "value": true,
                "checked": isActive,
              }
            ],
            value: [if (isActive) {"label": "Activate immediately", "value": true, "checked": true}],
            onChanged: (values, ids) {
              isActive = values.isNotEmpty;
              setState(() {});
            },
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: loading ? "Creating..." : "Create Promotion",
              onPressed: loading ? null : _createPromotion,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Promotional Pricing",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Active Promotions", icon: Icon(Icons.local_offer)),
        Tab(text: "Create Promotion", icon: Icon(Icons.add)),
      ],
      tabChildren: [
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              _buildPromotionStats(),
              _buildPromotionsListTab(),
            ],
          ),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildCreatePromotionTab(),
        ),
      ],
    );
  }
}
