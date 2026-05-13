import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosPurchaseAnalysisView extends StatefulWidget {
  const PosPurchaseAnalysisView({super.key});

  @override
  State<PosPurchaseAnalysisView> createState() => _PosPurchaseAnalysisViewState();
}

class _PosPurchaseAnalysisViewState extends State<PosPurchaseAnalysisView> {
  bool loading = false;
  String selectedPeriod = "This Month";
  String selectedCategory = "All Categories";
  String selectedSupplier = "All Suppliers";

  List<Map<String, dynamic>> periodOptions = [
    {"label": "Today", "value": "Today"},
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "All Categories"},
    {"label": "Food & Beverages", "value": "Food & Beverages"},
    {"label": "Electronics", "value": "Electronics"},
    {"label": "Clothing", "value": "Clothing"},
    {"label": "Health & Beauty", "value": "Health & Beauty"},
    {"label": "Home & Garden", "value": "Home & Garden"},
  ];

  List<Map<String, dynamic>> supplierOptions = [
    {"label": "All Suppliers", "value": "All Suppliers"},
    {"label": "ABC Foods Ltd", "value": "ABC Foods Ltd"},
    {"label": "Tech Solutions Inc", "value": "Tech Solutions Inc"},
    {"label": "Fashion Hub Co", "value": "Fashion Hub Co"},
    {"label": "Beauty World", "value": "Beauty World"},
    {"label": "Home Essentials", "value": "Home Essentials"},
  ];

  List<Map<String, dynamic>> purchaseData = [
    {
      "supplier": "ABC Foods Ltd",
      "category": "Food & Beverages",
      "orderDate": "2024-01-15",
      "orderNumber": "PO-2024-001",
      "totalAmount": 2500.75,
      "items": 15,
      "status": "Delivered",
      "paymentStatus": "Paid",
      "receivedDate": "2024-01-17",
    },
    {
      "supplier": "Tech Solutions Inc",
      "category": "Electronics",
      "orderDate": "2024-01-14",
      "orderNumber": "PO-2024-002",
      "totalAmount": 8900.50,
      "items": 8,
      "status": "Delivered",
      "paymentStatus": "Paid",
      "receivedDate": "2024-01-16",
    },
    {
      "supplier": "Fashion Hub Co",
      "category": "Clothing",
      "orderDate": "2024-01-13",
      "orderNumber": "PO-2024-003",
      "totalAmount": 3200.25,
      "items": 22,
      "status": "Pending",
      "paymentStatus": "Unpaid",
      "receivedDate": null,
    },
    {
      "supplier": "Beauty World",
      "category": "Health & Beauty",
      "orderDate": "2024-01-12",
      "orderNumber": "PO-2024-004",
      "totalAmount": 1750.80,
      "items": 12,
      "status": "Delivered",
      "paymentStatus": "Paid",
      "receivedDate": "2024-01-14",
    },
    {
      "supplier": "Home Essentials",
      "category": "Home & Garden",
      "orderDate": "2024-01-11",
      "orderNumber": "PO-2024-005",
      "totalAmount": 4200.90,
      "items": 18,
      "status": "Delivered",
      "paymentStatus": "Partial",
      "receivedDate": "2024-01-13",
    },
  ];

  List<Map<String, dynamic>> purchaseTrends = [
    {"month": "Jan", "amount": 18500.25, "orders": 45},
    {"month": "Feb", "amount": 22300.75, "orders": 52},
    {"month": "Mar", "amount": 19800.50, "orders": 48},
    {"month": "Apr", "amount": 25100.30, "orders": 58},
    {"month": "May", "amount": 21750.80, "orders": 51},
    {"month": "Jun", "amount": 28900.40, "orders": 65},
  ];

  List<Map<String, dynamic>> topSuppliers = [
    {
      "supplier": "ABC Foods Ltd",
      "totalPurchases": 45250.75,
      "orderCount": 28,
      "averageOrderValue": 1616.10,
      "reliability": 95.5,
    },
    {
      "supplier": "Tech Solutions Inc",
      "totalPurchases": 38900.50,
      "orderCount": 15,
      "averageOrderValue": 2593.37,
      "reliability": 92.3,
    },
    {
      "supplier": "Fashion Hub Co",
      "totalPurchases": 32100.25,
      "orderCount": 22,
      "averageOrderValue": 1459.10,
      "reliability": 88.7,
    },
    {
      "supplier": "Beauty World",
      "totalPurchases": 28750.80,
      "orderCount": 35,
      "averageOrderValue": 821.45,
      "reliability": 96.8,
    },
    {
      "supplier": "Home Essentials",
      "totalPurchases": 24200.90,
      "orderCount": 18,
      "averageOrderValue": 1344.49,
      "reliability": 90.2,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Purchase Analysis"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refreshData,
          ),
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: _exportReport,
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  _buildFilters(),
                  _buildSummaryCards(),
                  _buildPurchaseTrendsChart(),
                  _buildTopSuppliersSection(),
                  _buildRecentPurchasesTable(),
                  _buildInsightsSection(),
                ],
              ),
            ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Filters",
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
                  label: "Period",
                  items: periodOptions,
                  value: selectedPeriod,
                  onChanged: (value, label) {
                    selectedPeriod = value;
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
          QDropdownField(
            label: "Supplier",
            items: supplierOptions,
            value: selectedSupplier,
            onChanged: (value, label) {
              selectedSupplier = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.shopping_cart,
                      color: primaryColor,
                      size: 20,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Total Purchases",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "\$${((purchaseData.map((p) => p["totalAmount"] as double).reduce((a, b) => a + b))).currency}",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "+12.5% from last month",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.receipt,
                      color: infoColor,
                      size: 20,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Total Orders",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${purchaseData.length}",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: infoColor,
                  ),
                ),
                Text(
                  "+8.3% from last month",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPurchaseTrendsChart() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Purchase Trends",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            height: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: purchaseTrends.map((trend) {
                double maxAmount = purchaseTrends
                    .map((t) => t["amount"] as double)
                    .reduce((a, b) => a > b ? a : b);
                double height = ((trend["amount"] as double) / maxAmount) * 160;
                
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  spacing: spXs,
                  children: [
                    Text(
                      "\$${((trend["amount"] as double) / 1000).toStringAsFixed(1)}K",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Container(
                      width: 30,
                      height: height,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                    Text(
                      "${trend["month"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopSuppliersSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Top Suppliers",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...topSuppliers.map((supplier) {
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: primaryColor,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${supplier["supplier"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: (supplier["reliability"] as double) >= 95
                              ? successColor
                              : (supplier["reliability"] as double) >= 90
                                  ? warningColor
                                  : dangerColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${(supplier["reliability"] as double).toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 2,
                          children: [
                            Text(
                              "Total Purchases",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "\$${(supplier["totalPurchases"] as double).currency}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 2,
                          children: [
                            Text(
                              "Orders",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${supplier["orderCount"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: infoColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 2,
                          children: [
                            Text(
                              "Avg Order Value",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "\$${(supplier["averageOrderValue"] as double).currency}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: warningColor,
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
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildRecentPurchasesTable() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Recent Purchase Orders",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...purchaseData.map((purchase) {
            Color statusColor = purchase["status"] == "Delivered"
                ? successColor
                : purchase["status"] == "Pending"
                    ? warningColor
                    : dangerColor;
            Color paymentColor = purchase["paymentStatus"] == "Paid"
                ? successColor
                : purchase["paymentStatus"] == "Partial"
                    ? warningColor
                    : dangerColor;

            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: statusColor,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${purchase["orderNumber"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "\$${(purchase["totalAmount"] as double).currency}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 2,
                          children: [
                            Text(
                              "Supplier",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${purchase["supplier"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 2,
                          children: [
                            Text(
                              "Category",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${purchase["category"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: infoColor,
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
                          spacing: 2,
                          children: [
                            Text(
                              "Order Date",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${purchase["orderDate"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 2,
                          children: [
                            Text(
                              "Items",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${purchase["items"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: warningColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${purchase["status"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: paymentColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${purchase["paymentStatus"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildInsightsSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Purchase Insights",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: successColor.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border(
                left: BorderSide(
                  width: 4,
                  color: successColor,
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.trending_up,
                  color: successColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Purchase volume increased by 12.5% this month, with ABC Foods Ltd being the most reliable supplier at 95.5% reliability rating.",
                    style: TextStyle(
                      fontSize: 14,
                      color: successColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border(
                left: BorderSide(
                  width: 4,
                  color: infoColor,
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.insights,
                  color: infoColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Electronics category has the highest average order value at \$2,593.37, suggesting premium product procurement.",
                    style: TextStyle(
                      fontSize: 14,
                      color: infoColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border(
                left: BorderSide(
                  width: 4,
                  color: warningColor,
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.warning,
                  color: warningColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "1 purchase order is still pending delivery and 1 has unpaid payment status. Follow up required.",
                    style: TextStyle(
                      fontSize: 14,
                      color: warningColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _refreshData() {
    loading = true;
    setState(() {});

    Future.delayed(Duration(seconds: 2), () {
      loading = false;
      setState(() {});
      ss("Purchase analysis data refreshed successfully");
    });
  }

  void _exportReport() {
    ss("Purchase analysis report exported successfully");
  }
}
