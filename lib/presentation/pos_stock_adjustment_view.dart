import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosStockAdjustmentView extends StatefulWidget {
  const PosStockAdjustmentView({super.key});

  @override
  State<PosStockAdjustmentView> createState() => _PosStockAdjustmentViewState();
}

class _PosStockAdjustmentViewState extends State<PosStockAdjustmentView> {
  int selectedTab = 0;
  String selectedProduct = "";
  String selectedWarehouse = "main";
  String adjustmentType = "increase";
  String adjustmentQuantity = "";
  String adjustmentReason = "";
  String adjustmentNotes = "";
  String searchQuery = "";
  String selectedFilter = "all";
  bool loading = false;

  List<Map<String, dynamic>> products = [
    {"label": "Wireless Headphones (WH-001)", "value": "prod_001"},
    {"label": "Bluetooth Speaker (BS-002)", "value": "prod_002"},
    {"label": "Cotton T-Shirt (CT-003)", "value": "prod_003"},
    {"label": "Coffee Beans 1kg (CB-004)", "value": "prod_004"},
    {"label": "Programming Book (PB-005)", "value": "prod_005"},
  ];

  List<Map<String, dynamic>> warehouses = [
    {"label": "Main Warehouse", "value": "main"},
    {"label": "Store A", "value": "store_a"},
    {"label": "Store B", "value": "store_b"},
    {"label": "Online Warehouse", "value": "online"},
  ];

  List<Map<String, dynamic>> adjustmentTypes = [
    {"label": "Increase Stock", "value": "increase"},
    {"label": "Decrease Stock", "value": "decrease"},
    {"label": "Cycle Count", "value": "cycle_count"},
    {"label": "Damage/Loss", "value": "damage"},
  ];

  List<Map<String, dynamic>> adjustmentReasons = [
    {"label": "Physical Count Discrepancy", "value": "count_discrepancy"},
    {"label": "Received Inventory", "value": "received"},
    {"label": "Damaged Goods", "value": "damaged"},
    {"label": "Expired Products", "value": "expired"},
    {"label": "Lost/Stolen", "value": "lost"},
    {"label": "Return to Supplier", "value": "return"},
    {"label": "System Error", "value": "system_error"},
    {"label": "Other", "value": "other"},
  ];

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Adjustments", "value": "all"},
    {"label": "Today", "value": "today"},
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"},
    {"label": "Increases", "value": "increase"},
    {"label": "Decreases", "value": "decrease"},
  ];

  List<Map<String, dynamic>> stockAdjustments = [
    {
      "id": "adj_001",
      "product_name": "Wireless Headphones",
      "product_sku": "WH-001",
      "warehouse": "Main Warehouse",
      "adjustment_type": "increase",
      "quantity_before": 45,
      "quantity_adjusted": 10,
      "quantity_after": 55,
      "reason": "Received Inventory",
      "notes": "New shipment received from supplier",
      "adjusted_by": "John Smith",
      "adjustment_date": "2024-06-18",
      "image": "https://picsum.photos/60/60?random=1&keyword=headphones"
    },
    {
      "id": "adj_002",
      "product_name": "Bluetooth Speaker",
      "product_sku": "BS-002",
      "warehouse": "Store A",
      "adjustment_type": "decrease",
      "quantity_before": 15,
      "quantity_adjusted": -3,
      "quantity_after": 12,
      "reason": "Damaged Goods",
      "notes": "Water damage during transport",
      "adjusted_by": "Sarah Johnson",
      "adjustment_date": "2024-06-17",
      "image": "https://picsum.photos/60/60?random=2&keyword=speaker"
    },
    {
      "id": "adj_003",
      "product_name": "Cotton T-Shirt",
      "product_sku": "CT-003",
      "warehouse": "Store B",
      "adjustment_type": "cycle_count",
      "quantity_before": 25,
      "quantity_adjusted": -5,
      "quantity_after": 20,
      "reason": "Physical Count Discrepancy",
      "notes": "Cycle count revealed 5 units missing",
      "adjusted_by": "Mike Davis",
      "adjustment_date": "2024-06-16",
      "image": "https://picsum.photos/60/60?random=3&keyword=shirt"
    },
    {
      "id": "adj_004",  
      "product_name": "Coffee Beans 1kg",
      "product_sku": "CB-004",
      "warehouse": "Main Warehouse",
      "adjustment_type": "increase",
      "quantity_before": 180,
      "quantity_adjusted": 50,
      "quantity_after": 230,
      "reason": "Received Inventory",
      "notes": "Weekly supplier delivery",
      "adjusted_by": "Lisa Wilson",
      "adjustment_date": "2024-06-18",
      "image": "https://picsum.photos/60/60?random=4&keyword=coffee"
    },
    {
      "id": "adj_005",
      "product_name": "Programming Book",
      "product_sku": "PB-005",
      "warehouse": "Online Warehouse",
      "adjustment_type": "decrease",
      "quantity_before": 12,
      "quantity_adjusted": -2,
      "quantity_after": 10,
      "reason": "Lost/Stolen",
      "notes": "Books missing from shelf after audit",
      "adjusted_by": "David Brown",
      "adjustment_date": "2024-06-15",
      "image": "https://picsum.photos/60/60?random=5&keyword=book"
    },
  ];

  List<Map<String, dynamic>> get filteredAdjustments {
    var filtered = stockAdjustments.where((adjustment) {
      final matchesSearch = searchQuery.isEmpty || 
        adjustment["product_name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
        adjustment["product_sku"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      final matchesFilter = selectedFilter == "all" ||
        (selectedFilter == "today" && adjustment["adjustment_date"] == "2024-06-18") ||
        (selectedFilter == "week" && _isThisWeek(adjustment["adjustment_date"])) ||
        (selectedFilter == "month" && _isThisMonth(adjustment["adjustment_date"])) ||
        (selectedFilter == "increase" && adjustment["adjustment_type"] == "increase") ||
        (selectedFilter == "decrease" && (adjustment["adjustment_type"] == "decrease" || adjustment["adjustment_type"] == "damage"));
      
      return matchesSearch && matchesFilter;
    }).toList();

    // Sort by date descending
    filtered.sort((a, b) => b["adjustment_date"].toString().compareTo(a["adjustment_date"].toString()));
    
    return filtered;
  }

  bool _isThisWeek(String date) {
    final adjustmentDate = DateTime.parse("$date 00:00:00");
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    return adjustmentDate.isAfter(weekStart);
  }

  bool _isThisMonth(String date) {
    final adjustmentDate = DateTime.parse("$date 00:00:00");
    final now = DateTime.now();
    return adjustmentDate.month == now.month && adjustmentDate.year == now.year;
  }

  void _submitAdjustment() async {
    if (selectedProduct.isEmpty || adjustmentQuantity.isEmpty || adjustmentReason.isEmpty) {
      se("Please fill in all required fields");
      return;
    }

    loading = true;
    setState(() {});

    await Future.delayed(Duration(milliseconds: 1000));

    final quantity = int.tryParse(adjustmentQuantity) ?? 0;
    final adjustedQuantity = adjustmentType == "decrease" || adjustmentType == "damage" 
      ? -quantity 
      : quantity;

    final newAdjustment = {
      "id": "adj_${DateTime.now().millisecondsSinceEpoch}",
      "product_name": products.firstWhere((p) => p["value"] == selectedProduct)["label"].split(" (")[0],
      "product_sku": products.firstWhere((p) => p["value"] == selectedProduct)["label"].split("(")[1].replaceAll(")", ""),
      "warehouse": warehouses.firstWhere((w) => w["value"] == selectedWarehouse)["label"],
      "adjustment_type": adjustmentType,
      "quantity_before": 100, // Mock data
      "quantity_adjusted": adjustedQuantity,
      "quantity_after": 100 + adjustedQuantity,
      "reason": adjustmentReasons.firstWhere((r) => r["value"] == adjustmentReason)["label"],
      "notes": adjustmentNotes,
      "adjusted_by": "Current User",
      "adjustment_date": DateTime.now().toString().substring(0, 10),
      "image": "https://picsum.photos/60/60?random=10&keyword=product"
    };

    stockAdjustments.insert(0, newAdjustment);

    // Reset form
    selectedProduct = "";
    adjustmentQuantity = "";
    adjustmentReason = "";
    adjustmentNotes = "";
    adjustmentType = "increase";
    selectedWarehouse = "main";

    loading = false;
    selectedTab = 1;
    setState(() {});
    ss("Stock adjustment recorded successfully");
  }

  Widget _buildAdjustmentStats() {
    final totalAdjustments = stockAdjustments.length;
    final todayAdjustments = stockAdjustments.where((adj) => adj["adjustment_date"] == "2024-06-18").length;
    final increases = stockAdjustments.where((adj) => (adj["quantity_adjusted"] as int) > 0).length;
    final decreases = stockAdjustments.where((adj) => (adj["quantity_adjusted"] as int) < 0).length;

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
                  Icons.assignment,
                  color: primaryColor,
                  size: 32,
                ),
                SizedBox(height: spXs),
                Text(
                  "$totalAdjustments",  
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Total Adjustments",
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
                  Icons.today,
                  color: infoColor,
                  size: 32,
                ),
                SizedBox(height: spXs),
                Text(
                  "$todayAdjustments",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: infoColor,
                  ),
                ),
                Text(
                  "Today",
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
                  color: successColor,
                  size: 32,
                ),
                SizedBox(height: spXs),
                Text(
                  "$increases",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                Text(
                  "Increases",
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
                  Icons.trending_down,
                  color: dangerColor,
                  size: 32,
                ),
                SizedBox(height: spXs),
                Text(
                  "$decreases",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: dangerColor,
                  ),
                ),
                Text(
                  "Decreases",
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

  Widget _buildCreateAdjustmentTab() {
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
            "Create Stock Adjustment",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QDropdownField(
            label: "Select Product",
            items: products,
            value: selectedProduct,
            validator: Validator.required,
            onChanged: (value, label) {
              selectedProduct = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Warehouse",
                  items: warehouses,
                  value: selectedWarehouse,
                  onChanged: (value, label) {
                    selectedWarehouse = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Adjustment Type",
                  items: adjustmentTypes,
                  value: adjustmentType,
                  onChanged: (value, label) {
                    adjustmentType = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QNumberField(
            label: "Adjustment Quantity",
            value: adjustmentQuantity,
            hint: "Enter quantity to adjust",
            validator: Validator.required,
            onChanged: (value) {
              adjustmentQuantity = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Reason for Adjustment",
            items: adjustmentReasons,
            value: adjustmentReason,
            validator: Validator.required,
            onChanged: (value, label) {
              adjustmentReason = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Additional Notes",
            value: adjustmentNotes,
            hint: "Add any additional details about this adjustment",
            onChanged: (value) {
              adjustmentNotes = value;
              setState(() {});
            },
          ),
          if (selectedProduct.isNotEmpty && adjustmentQuantity.isNotEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Adjustment Preview:",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: infoColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Text(
                        "Product: ",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        products.firstWhere((p) => p["value"] == selectedProduct, orElse: () => {"label": ""})["label"],
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Warehouse: ",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        warehouses.firstWhere((w) => w["value"] == selectedWarehouse)["label"],
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Adjustment: ",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${adjustmentType == "decrease" || adjustmentType == "damage" ? "-" : "+"}${adjustmentQuantity}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: adjustmentType == "decrease" || adjustmentType == "damage" ? dangerColor : successColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          Container(
            width: double.infinity,
            child: QButton(
              label: loading ? "Processing..." : "Submit Adjustment",
              onPressed: loading ? null : _submitAdjustment,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdjustmentHistoryTab() {
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
                  label: "Search Adjustments",
                  value: searchQuery,
                  hint: "Enter product name or SKU",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Filter",
                  items: filterOptions,
                  value: selectedFilter,
                  onChanged: (value, label) {
                    selectedFilter = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ),
        ...filteredAdjustments.map((adjustment) => _buildAdjustmentCard(adjustment)),
      ],
    );
  }

  Widget _buildAdjustmentCard(Map<String, dynamic> adjustment) {
    final quantityAdjusted = adjustment["quantity_adjusted"] as int;
    final isIncrease = quantityAdjusted > 0;
    final adjustmentColor = isIncrease ? successColor : dangerColor;
    final adjustmentIcon = isIncrease ? Icons.trending_up : Icons.trending_down;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: adjustmentColor.withAlpha(30)),
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
                  "${adjustment["image"]}",
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
                      "${adjustment["product_name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "SKU: ${adjustment["product_sku"]} | ${adjustment["warehouse"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Adjusted by: ${adjustment["adjusted_by"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: adjustmentColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  children: [
                    Icon(
                      adjustmentIcon,
                      color: adjustmentColor,
                      size: 24,
                    ),
                    Text(
                      "${isIncrease ? "+" : ""}$quantityAdjusted",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: adjustmentColor,
                      ),
                    ),
                  ],
                ),
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
                      "Before",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${adjustment["quantity_before"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward,
                color: disabledBoldColor,
                size: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "After",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${adjustment["quantity_after"]}",
                      style: TextStyle(
                        fontSize: 16,
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
                      "Date",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${adjustment["adjustment_date"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${adjustment["adjustment_type"]}".toUpperCase().replaceAll('_', ' '),
                        style: TextStyle(
                          fontSize: 10,
                          color: infoColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Reason: ${adjustment["reason"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                if (adjustment["notes"].toString().isNotEmpty) ...[
                  SizedBox(height: spXs),
                  Text(
                    "Notes: ${adjustment["notes"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Stock Adjustment",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "New Adjustment", icon: Icon(Icons.add)),
        Tab(text: "History", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              _buildAdjustmentStats(),
              _buildCreateAdjustmentTab(),
            ],
          ),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              _buildAdjustmentStats(),
              _buildAdjustmentHistoryTab(),
            ],
          ),
        ),
      ],
    );
  }
}
