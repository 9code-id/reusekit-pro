import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaSalesReportsView extends StatefulWidget {
  const RmaSalesReportsView({Key? key}) : super(key: key);

  @override
  State<RmaSalesReportsView> createState() => _RmaSalesReportsViewState();
}

class _RmaSalesReportsViewState extends State<RmaSalesReportsView> {
  String selectedPeriod = "monthly";
  String selectedProduct = "all";
  bool loading = false;

  List<Map<String, dynamic>> periods = [
    {"label": "Daily", "value": "daily"},
    {"label": "Weekly", "value": "weekly"},
    {"label": "Monthly", "value": "monthly"},
    {"label": "Quarterly", "value": "quarterly"},
  ];

  List<Map<String, dynamic>> products = [
    {"label": "All Products", "value": "all"},
    {"label": "Electronics", "value": "electronics"},
    {"label": "Clothing", "value": "clothing"},
    {"label": "Home & Garden", "value": "home_garden"},
  ];

  List<Map<String, dynamic>> salesData = [
    {
      "month": "March 2024",
      "totalSales": 125000.0,
      "returns": 8500.0,
      "returnRate": 6.8,
      "netSales": 116500.0,
      "refunded": 7200.0,
      "exchanged": 1300.0,
    },
    {
      "month": "February 2024",
      "totalSales": 118000.0,
      "returns": 9200.0,
      "returnRate": 7.8,
      "netSales": 108800.0,
      "refunded": 8100.0,
      "exchanged": 1100.0,
    },
    {
      "month": "January 2024",
      "totalSales": 105000.0,
      "returns": 6800.0,
      "returnRate": 6.5,
      "netSales": 98200.0,
      "refunded": 5900.0,
      "exchanged": 900.0,
    },
  ];

  List<Map<String, dynamic>> topReturnedProducts = [
    {
      "name": "Wireless Headphones Pro",
      "category": "Electronics",
      "totalSold": 450,
      "returned": 32,
      "returnRate": 7.1,
      "reason": "Audio quality issues",
      "image": "https://picsum.photos/60/60?random=1&keyword=headphones",
    },
    {
      "name": "Smart Watch Series X",
      "category": "Electronics",
      "totalSold": 320,
      "returned": 28,
      "returnRate": 8.8,
      "reason": "Battery problems",
      "image": "https://picsum.photos/60/60?random=2&keyword=watch",
    },
    {
      "name": "Designer Jacket",
      "category": "Clothing",
      "totalSold": 280,
      "returned": 18,
      "returnRate": 6.4,
      "reason": "Size issues",
      "image": "https://picsum.photos/60/60?random=3&keyword=jacket",
    },
    {
      "name": "Garden Tool Set",
      "category": "Home & Garden",
      "totalSold": 190,
      "returned": 15,
      "returnRate": 7.9,
      "reason": "Quality concerns",
      "image": "https://picsum.photos/60/60?random=4&keyword=tools",
    },
  ];

  List<Map<String, dynamic>> returnReasons = [
    {"reason": "Defective Product", "count": 145, "percentage": 35.2},
    {"reason": "Wrong Size/Fit", "count": 98, "percentage": 23.8},
    {"reason": "Not as Described", "count": 67, "percentage": 16.3},
    {"reason": "Changed Mind", "count": 52, "percentage": 12.6},
    {"reason": "Damaged in Shipping", "count": 38, "percentage": 9.2},
    {"reason": "Other", "count": 12, "percentage": 2.9},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sales & Returns Reports"),
        actions: [
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () => _exportReport(),
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => _refreshData(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFilters(),
            SizedBox(height: spLg),
            _buildSalesOverview(),
            SizedBox(height: spLg),
            _buildSalesChart(),
            SizedBox(height: spLg),
            _buildReturnAnalysis(),
            SizedBox(height: spLg),
            _buildTopReturnedProducts(),
            SizedBox(height: spLg),
            _buildReturnReasons(),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Report Filters",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Period",
                  items: periods,
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
                  label: "Product Category",
                  items: products,
                  value: selectedProduct,
                  onChanged: (value, label) {
                    selectedProduct = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSalesOverview() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildOverviewCard(
          "Total Sales",
          "\$125,000",
          Icons.trending_up,
          successColor,
          "+8.5%",
          true,
        ),
        _buildOverviewCard(
          "Total Returns",
          "\$8,500",
          Icons.assignment_return,
          warningColor,
          "-2.1%",
          false,
        ),
        _buildOverviewCard(
          "Return Rate",
          "6.8%",
          Icons.percent,
          infoColor,
          "Within target",
          true,
        ),
        _buildOverviewCard(
          "Net Sales",
          "\$116,500",
          Icons.account_balance_wallet,
          primaryColor,
          "+9.2%",
          true,
        ),
      ],
    );
  }

  Widget _buildOverviewCard(String title, String value, IconData icon, Color color, String change, bool isPositive) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: color.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                decoration: BoxDecoration(
                  color: (isPositive ? successColor : dangerColor).withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  change,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: isPositive ? successColor : dangerColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSalesChart() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Sales vs Returns Trend",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Container(
            height: 200,
            child: Column(
              children: salesData.map((data) => _buildChartRow(data)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartRow(Map<String, dynamic> data) {
    double salesWidth = ((data["totalSales"] as double) / 125000) * 250;
    double returnsWidth = ((data["returns"] as double) / 125000) * 250;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${data["month"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: salesWidth,
                          height: 8,
                          decoration: BoxDecoration(
                            color: successColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "\$${((data["totalSales"] as double) / 1000).toInt()}K",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Container(
                          width: returnsWidth,
                          height: 6,
                          decoration: BoxDecoration(
                            color: warningColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "\$${((data["returns"] as double) / 1000).toInt()}K",
                          style: TextStyle(
                            fontSize: 12,
                            color: warningColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
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

  Widget _buildReturnAnalysis() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Return Analysis",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                _buildAnalysisItem("Refunded", "\$7,200", "84.7%", dangerColor),
                SizedBox(height: spSm),
                _buildAnalysisItem("Exchanged", "\$1,300", "15.3%", infoColor),
                SizedBox(height: spMd),
                Text(
                  "Most returns are refunded rather than exchanged, indicating potential product quality issues.",
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
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Processing Time",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                _buildProcessingItem("Same Day", "45%", successColor),
                SizedBox(height: spSm),
                _buildProcessingItem("1-3 Days", "38%", warningColor),
                SizedBox(height: spSm),
                _buildProcessingItem("4+ Days", "17%", dangerColor),
                SizedBox(height: spMd),
                Text(
                  "Most returns are processed within 3 days, meeting customer expectations.",
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

  Widget _buildAnalysisItem(String label, String value, String percentage, Color color) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
            ),
          ),
        ),
        Text(
          "$value ($percentage)",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildProcessingItem(String timeframe, String percentage, Color color) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Text(
            timeframe,
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
            ),
          ),
        ),
        Text(
          percentage,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildTopReturnedProducts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Top Returned Products",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        ...topReturnedProducts.map((product) => _buildProductItem(product)).toList(),
      ],
    );
  }

  Widget _buildProductItem(Map<String, dynamic> product) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusMd),
            child: Image.network(
              "${product["image"]}",
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${product["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${product["category"]} • ${product["reason"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Sold: ${product["totalSold"]} | Returned: ${product["returned"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              "${(product["returnRate"] as double).toStringAsFixed(1)}%",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: warningColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReturnReasons() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Return Reasons",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ...returnReasons.map((reason) => _buildReasonItem(reason)).toList(),
        ],
      ),
    );
  }

  Widget _buildReasonItem(Map<String, dynamic> reason) {
    double percentage = (reason["percentage"] as double) / 100;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${reason["reason"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                  ),
                ),
              ),
              Text(
                "${reason["count"]} (${(reason["percentage"] as double).toStringAsFixed(1)}%)",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Container(
            height: 4,
            child: Row(
              children: [
                Expanded(
                  flex: (percentage * 1000).toInt(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                  ),
                ),
                Expanded(
                  flex: ((1 - percentage) * 1000).toInt(),
                  child: Container(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _exportReport() {
    ss("Sales report exported successfully");
  }

  void _refreshData() {
    loading = true;
    setState(() {});
    
    Future.delayed(Duration(seconds: 2), () {
      loading = false;
      setState(() {});
      ss("Data refreshed successfully");
    });
  }
}
