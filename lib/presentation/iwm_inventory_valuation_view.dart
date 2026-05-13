import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmInventoryValuationView extends StatefulWidget {
  const IwmInventoryValuationView({super.key});

  @override
  State<IwmInventoryValuationView> createState() => _IwmInventoryValuationViewState();
}

class _IwmInventoryValuationViewState extends State<IwmInventoryValuationView> {
  int selectedTab = 0;
  String selectedPeriod = "current";
  String selectedCategory = "all";
  String selectedMethod = "fifo";
  
  List<Map<String, dynamic>> periods = [
    {"label": "Current Period", "value": "current"},
    {"label": "Last Month", "value": "last_month"},
    {"label": "Last Quarter", "value": "last_quarter"},
    {"label": "Last Year", "value": "last_year"},
  ];
  
  List<Map<String, dynamic>> categories = [
    {"label": "All Categories", "value": "all"},
    {"label": "Electronics", "value": "electronics"},
    {"label": "Clothing", "value": "clothing"},
    {"label": "Food & Beverages", "value": "food"},
    {"label": "Home & Garden", "value": "home"},
  ];
  
  List<Map<String, dynamic>> valuationMethods = [
    {"label": "FIFO (First In, First Out)", "value": "fifo"},
    {"label": "LIFO (Last In, First Out)", "value": "lifo"},
    {"label": "Weighted Average Cost", "value": "weighted"},
    {"label": "Standard Cost", "value": "standard"},
  ];
  
  List<Map<String, dynamic>> valuationSummary = [
    {
      "title": "Total Inventory Value",
      "value": 2847562.50,
      "change": 12.5,
      "subtitle": "Current Market Value",
      "icon": Icons.account_balance_wallet,
      "color": primaryColor
    },
    {
      "title": "Cost of Goods",
      "value": 2156890.75,
      "change": -3.2,
      "subtitle": "Purchase Cost",
      "icon": Icons.shopping_cart,
      "color": successColor
    },
    {
      "title": "Markup Value",
      "value": 690671.75,
      "change": 8.9,
      "subtitle": "Potential Profit",
      "icon": Icons.trending_up,
      "color": infoColor
    },
    {
      "title": "Dead Stock Value",
      "value": 125420.00,
      "change": -15.6,
      "subtitle": "Non-moving Items",
      "icon": Icons.warning,
      "color": dangerColor
    },
  ];
  
  List<Map<String, dynamic>> categoryBreakdown = [
    {
      "category": "Electronics",
      "totalValue": 1245800.00,
      "percentage": 43.7,
      "itemCount": 324,
      "avgValue": 3845.68,
      "color": primaryColor,
      "trend": "up",
      "trendValue": 8.5
    },
    {
      "category": "Clothing",
      "totalValue": 687200.00,
      "percentage": 24.1,
      "itemCount": 892,
      "avgValue": 770.40,
      "color": successColor,
      "trend": "down",
      "trendValue": -2.3
    },
    {
      "category": "Home & Garden",
      "totalValue": 456780.00,
      "percentage": 16.0,
      "itemCount": 234,
      "avgValue": 1951.20,
      "color": infoColor,
      "trend": "up",
      "trendValue": 15.2
    },
    {
      "category": "Food & Beverages",
      "totalValue": 289430.00,
      "percentage": 10.2,
      "itemCount": 567,
      "avgValue": 510.50,
      "color": warningColor,
      "trend": "up",
      "trendValue": 5.8
    },
    {
      "category": "Sports & Recreation",
      "totalValue": 168352.50,
      "percentage": 6.0,
      "itemCount": 178,
      "avgValue": 945.80,
      "color": dangerColor,
      "trend": "down",
      "trendValue": -8.1
    },
  ];
  
  List<Map<String, dynamic>> topValuedItems = [
    {
      "name": "MacBook Pro 16-inch M3",
      "sku": "MBP16-M3-1TB",
      "category": "Electronics",
      "quantity": 25,
      "unitCost": 2299.00,
      "unitPrice": 2899.00,
      "totalValue": 72475.00,
      "markup": 26.1,
      "turnoverRate": 3.2,
      "image": "https://picsum.photos/50/50?random=1&keyword=laptop"
    },
    {
      "name": "iPhone 15 Pro Max 256GB",
      "sku": "IPH15PM-256",
      "category": "Electronics",
      "quantity": 45,
      "unitCost": 999.00,
      "unitPrice": 1299.00,
      "totalValue": 58455.00,
      "markup": 30.0,
      "turnoverRate": 5.8,
      "image": "https://picsum.photos/50/50?random=2&keyword=phone"
    },
    {
      "name": "Samsung OLED 65-inch TV",
      "sku": "SAM-OLED65-4K",
      "category": "Electronics",
      "quantity": 12,
      "unitCost": 1899.00,
      "unitPrice": 2399.00,
      "totalValue": 28788.00,
      "markup": 26.3,
      "turnoverRate": 2.1,
      "image": "https://picsum.photos/50/50?random=3&keyword=tv"
    },
    {
      "name": "Nike Air Jordan Retro Collection",
      "sku": "NAJ-RETRO-SET",
      "category": "Clothing",
      "quantity": 89,
      "unitCost": 145.00,
      "unitPrice": 229.99,
      "totalValue": 20469.11,
      "markup": 58.6,
      "turnoverRate": 4.5,
      "image": "https://picsum.photos/50/50?random=4&keyword=shoes"
    },
    {
      "name": "Dyson V15 Detect Vacuum",
      "sku": "DYS-V15-DET",
      "category": "Home & Garden",
      "quantity": 28,
      "unitCost": 549.00,
      "unitPrice": 749.99,
      "totalValue": 20999.72,
      "markup": 36.6,
      "turnoverRate": 1.8,
      "image": "https://picsum.photos/50/50?random=5&keyword=vacuum"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Inventory Valuation",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Categories", icon: Icon(Icons.category)),
        Tab(text: "Top Items", icon: Icon(Icons.star)),
        Tab(text: "Reports", icon: Icon(Icons.assessment)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildCategoriesTab(),
        _buildTopItemsTab(),
        _buildReportsTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFilters(),
          _buildValuationSummary(),
          _buildValuationChart(),
          _buildTrendAnalysis(),
        ],
      ),
    );
  }

  Widget _buildCategoriesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCategoryFilters(),
          _buildCategoryBreakdown(),
        ],
      ),
    );
  }

  Widget _buildTopItemsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTopItemsHeader(),
          _buildTopValuedItemsList(),
        ],
      ),
    );
  }

  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildReportOptions(),
          _buildReportGeneration(),
        ],
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
        spacing: spSm,
        children: [
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
                  label: "Valuation Method",
                  items: valuationMethods,
                  value: selectedMethod,
                  onChanged: (value, label) {
                    selectedMethod = value;
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

  Widget _buildCategoryFilters() {
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
            icon: Icons.refresh,
            label: "Refresh",
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildTopItemsHeader() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Text(
            "Top Valued Items",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Spacer(),
          QButton(
            icon: Icons.download,
            label: "Export",
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildValuationSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Valuation Summary",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: valuationSummary.map((summary) => _buildSummaryCard(summary)).toList(),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(Map<String, dynamic> summary) {
    bool isPositive = (summary["change"] as double) > 0;
    
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
                  color: (summary["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  summary["icon"],
                  color: summary["color"],
                  size: 20,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: (isPositive ? successColor : dangerColor).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isPositive ? Icons.trending_up : Icons.trending_down,
                      color: isPositive ? successColor : dangerColor,
                      size: 12,
                    ),
                    SizedBox(width: 2),
                    Text(
                      "${(summary["change"] as double).abs().toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: isPositive ? successColor : dangerColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text(
            "\$${((summary["value"] as double)).currency}",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "${summary["title"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Text(
            "${summary["subtitle"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildValuationChart() {
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
            "Inventory Value Trend",
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
                    Icons.show_chart,
                    size: 48,
                    color: primaryColor.withAlpha(100),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Valuation Trend Chart",
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

  Widget _buildTrendAnalysis() {
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
            "Trend Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.trending_up, color: successColor, size: 16),
                          SizedBox(width: spXs),
                          Text(
                            "Growth Rate",
                            style: TextStyle(
                              fontSize: 12,
                              color: successColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "+12.5%",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "This Quarter",
                        style: TextStyle(
                          fontSize: 10,
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
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.rotate_right, color: infoColor, size: 16),
                          SizedBox(width: spXs),
                          Text(
                            "Turnover Rate",
                            style: TextStyle(
                              fontSize: 12,
                              color: infoColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "3.2x",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Annual Average",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
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

  Widget _buildCategoryBreakdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Category Breakdown",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...categoryBreakdown.map((category) => _buildCategoryCard(category)),
      ],
    );
  }

  Widget _buildCategoryCard(Map<String, dynamic> category) {
    bool isPositiveTrend = category["trend"] == "up";
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 60,
            decoration: BoxDecoration(
              color: category["color"],
              borderRadius: BorderRadius.circular(radiusXs),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Text(
                      "${category["category"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: (isPositiveTrend ? successColor : dangerColor).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isPositiveTrend ? Icons.trending_up : Icons.trending_down,
                            color: isPositiveTrend ? successColor : dangerColor,
                            size: 12,
                          ),
                          SizedBox(width: 2),
                          Text(
                            "${(category["trendValue"] as double).abs().toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: isPositiveTrend ? successColor : dangerColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Text(
                  "\$${((category["totalValue"] as double)).currency}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "${(category["percentage"] as double).toStringAsFixed(1)}% of total",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${category["itemCount"]} items",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Avg Value: \$${((category["avgValue"] as double)).currency}",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopValuedItemsList() {
    return Column(
      spacing: spSm,
      children: topValuedItems.map((item) => _buildTopValuedItem(item)).toList(),
    );
  }

  Widget _buildTopValuedItem(Map<String, dynamic> item) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusSm),
            child: Image.network(
              "${item["image"]}",
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "${item["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "SKU: ${item["sku"]} • ${item["category"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Qty: ${item["quantity"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Turnover: ${item["turnoverRate"]}x",
                      style: TextStyle(
                        fontSize: 11,
                        color: infoColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            spacing: spXs,
            children: [
              Text(
                "\$${((item["totalValue"] as double)).currency}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "${(item["markup"] as double).toStringAsFixed(1)}% markup",
                style: TextStyle(
                  fontSize: 11,
                  color: successColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "\$${((item["unitPrice"] as double)).currency}/unit",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReportOptions() {
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
            "Available Reports",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          _buildReportOption("Inventory Valuation Summary", "Complete valuation breakdown by category", Icons.summarize),
          _buildReportOption("Top Valued Items Report", "Detailed list of highest valued inventory", Icons.star),
          _buildReportOption("Dead Stock Analysis", "Items with low turnover rates", Icons.warning),
          _buildReportOption("Category Performance", "Category-wise valuation trends", Icons.category),
        ],
      ),
    );
  }

  Widget _buildReportOption(String title, String description, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: primaryColor,
            size: 20,
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
              ],
            ),
          ),
          QButton(
            label: "Generate",
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildReportGeneration() {
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
            "Custom Report",
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
                  label: "Report Type",
                  items: [
                    {"label": "Summary Report", "value": "summary"},
                    {"label": "Detailed Report", "value": "detailed"},
                    {"label": "Comparative Report", "value": "comparative"},
                  ],
                  value: "summary",
                  onChanged: (value, label) {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Format",
                  items: [
                    {"label": "PDF", "value": "pdf"},
                    {"label": "Excel", "value": "excel"},
                    {"label": "CSV", "value": "csv"},
                  ],
                  value: "pdf",
                  onChanged: (value, label) {},
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Generate Custom Report",
              icon: Icons.file_download,
              size: bs.md,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
