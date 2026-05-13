import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaFastSlowMovingView extends StatefulWidget {
  const ImaFastSlowMovingView({super.key});

  @override
  State<ImaFastSlowMovingView> createState() => _ImaFastSlowMovingViewState();
}

class _ImaFastSlowMovingViewState extends State<ImaFastSlowMovingView> {
  String searchQuery = "";
  String selectedPeriod = "last_3_months";
  String selectedCategory = "all";
  String selectedMovementType = "all";

  List<Map<String, dynamic>> movementAnalysis = [
    {
      "id": "FSM001",
      "product_name": "iPhone 15 Pro Case",
      "sku": "IP15P-CASE",
      "category": "Accessories",
      "movement_type": "fast",
      "turnover_ratio": 24.5,
      "days_to_sell": 15,
      "monthly_sales": 285,
      "current_stock": 120,
      "stock_cover_days": 12,
      "velocity_score": 94.2,
      "demand_trend": "increasing",
      "avg_daily_sales": 9.5,
      "peak_sales_month": "December",
      "sales_consistency": 87.3,
      "reorder_frequency": "weekly",
      "profit_margin": 35.5,
      "revenue_contribution": 8.2,
      "last_sale_date": "2024-01-15",
      "stock_status": "optimal"
    },
    {
      "id": "FSM002", 
      "product_name": "Wireless Charger Pad",
      "sku": "WC-PAD",
      "category": "Electronics",
      "movement_type": "fast",
      "turnover_ratio": 18.7,
      "days_to_sell": 20,
      "monthly_sales": 195,
      "current_stock": 130,
      "stock_cover_days": 20,
      "velocity_score": 89.1,
      "demand_trend": "stable",
      "avg_daily_sales": 6.5,
      "peak_sales_month": "November",
      "sales_consistency": 92.1,
      "reorder_frequency": "bi_weekly",
      "profit_margin": 42.8,
      "revenue_contribution": 5.9,
      "last_sale_date": "2024-01-14",
      "stock_status": "low"
    },
    {
      "id": "FSM003",
      "product_name": "Ergonomic Keyboard",
      "sku": "ERG-KB",
      "category": "Peripherals", 
      "movement_type": "medium",
      "turnover_ratio": 8.4,
      "days_to_sell": 43,
      "monthly_sales": 45,
      "current_stock": 65,
      "stock_cover_days": 43,
      "velocity_score": 62.5,
      "demand_trend": "stable",
      "avg_daily_sales": 1.5,
      "peak_sales_month": "September",
      "sales_consistency": 78.9,
      "reorder_frequency": "monthly",
      "profit_margin": 28.3,
      "revenue_contribution": 2.8,
      "last_sale_date": "2024-01-13",
      "stock_status": "optimal"
    },
    {
      "id": "FSM004",
      "product_name": "Vintage Camera Lens",
      "sku": "VC-LENS",
      "category": "Photography",
      "movement_type": "slow",
      "turnover_ratio": 2.1,
      "days_to_sell": 174,
      "monthly_sales": 5,
      "current_stock": 30,
      "stock_cover_days": 180,
      "velocity_score": 18.7,
      "demand_trend": "decreasing",
      "avg_daily_sales": 0.17,
      "peak_sales_month": "June",
      "sales_consistency": 45.2,
      "reorder_frequency": "quarterly",
      "profit_margin": 65.0,
      "revenue_contribution": 0.8,
      "last_sale_date": "2024-01-02",
      "stock_status": "excess"
    },
    {
      "id": "FSM005",
      "product_name": "Smart Home Hub Gen 1",
      "sku": "SH-HUB1",
      "category": "Smart Home",
      "movement_type": "slow",
      "turnover_ratio": 1.8,
      "days_to_sell": 203,
      "monthly_sales": 3,
      "current_stock": 22,
      "stock_cover_days": 220,
      "velocity_score": 12.4,
      "demand_trend": "declining",
      "avg_daily_sales": 0.1,
      "peak_sales_month": "March",
      "sales_consistency": 32.1,
      "reorder_frequency": "annual",
      "profit_margin": 15.2,
      "revenue_contribution": 0.3,
      "last_sale_date": "2023-12-28",
      "stock_status": "excess"
    }
  ];

  List<Map<String, dynamic>> get filteredData {
    return movementAnalysis.where((item) {
      bool matchesSearch = "${item["product_name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${item["sku"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "all" || item["category"] == selectedCategory;
      
      bool matchesMovement = selectedMovementType == "all" || item["movement_type"] == selectedMovementType;
      
      return matchesSearch && matchesCategory && matchesMovement;
    }).toList();
  }

  Color _getMovementColor(String movementType) {
    switch (movementType) {
      case "fast": return successColor;
      case "medium": return warningColor;
      case "slow": return dangerColor;
      default: return disabledBoldColor;
    }
  }

  Color _getTrendColor(String trend) {
    switch (trend) {
      case "increasing": return successColor;
      case "stable": return infoColor;
      case "decreasing": return warningColor;
      case "declining": return dangerColor;
      default: return disabledBoldColor;
    }
  }

  Color _getStockStatusColor(String status) {
    switch (status) {
      case "optimal": return successColor;
      case "low": return warningColor;
      case "excess": return dangerColor;
      default: return disabledBoldColor;
    }
  }

  Widget _buildSummaryCard() {
    int fastMoving = filteredData.where((item) => item["movement_type"] == "fast").length;
    int mediumMoving = filteredData.where((item) => item["movement_type"] == "medium").length;
    int slowMoving = filteredData.where((item) => item["movement_type"] == "slow").length;
    double avgTurnover = filteredData.fold(0.0, (sum, item) => sum + (item["turnover_ratio"] as double)) / filteredData.length;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Movement Analysis Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Fast Moving",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "$fastMoving",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
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
                    color: warningColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Medium Moving",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "$mediumMoving",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
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
                    color: dangerColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Slow Moving",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "$slowMoving",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.speed,
                  color: infoColor,
                  size: 20,
                ),
                SizedBox(width: spSm),
                Text(
                  "Average Turnover Ratio: ${avgTurnover.toStringAsFixed(1)}x",
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
    );
  }

  Widget _buildFilterSection() {
    List<Map<String, dynamic>> periodOptions = [
      {"label": "Last Month", "value": "last_month"},
      {"label": "Last 3 Months", "value": "last_3_months"},
      {"label": "Last 6 Months", "value": "last_6_months"},
      {"label": "Last Year", "value": "last_year"},
    ];

    List<Map<String, dynamic>> categoryOptions = [
      {"label": "All Categories", "value": "all"},
      {"label": "Accessories", "value": "Accessories"},
      {"label": "Electronics", "value": "Electronics"},
      {"label": "Peripherals", "value": "Peripherals"},
      {"label": "Photography", "value": "Photography"},
      {"label": "Smart Home", "value": "Smart Home"},
    ];

    List<Map<String, dynamic>> movementOptions = [
      {"label": "All Movement Types", "value": "all"},
      {"label": "Fast Moving", "value": "fast"},
      {"label": "Medium Moving", "value": "medium"},
      {"label": "Slow Moving", "value": "slow"},
    ];

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Analysis Filters",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          QTextField(
            label: "Search Products",
            value: searchQuery,
            hint: "Search by product name or SKU",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Analysis Period",
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
          SizedBox(height: spSm),
          QDropdownField(
            label: "Movement Type",
            items: movementOptions,
            value: selectedMovementType,
            onChanged: (value, label) {
              selectedMovementType = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMovementCard(Map<String, dynamic> item) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getMovementColor("${item["movement_type"]}"),
          ),
        ),
      ),
      child: ExpansionTile(
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              decoration: BoxDecoration(
                color: _getMovementColor("${item["movement_type"]}").withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "${item["movement_type"]}".toUpperCase(),
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: _getMovementColor("${item["movement_type"]}"),
                ),
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${item["product_name"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "SKU: ${item["sku"]} • ${item["category"]}",
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
        subtitle: Padding(
          padding: EdgeInsets.only(top: spSm),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Turnover: ${(item["turnover_ratio"] as double).toStringAsFixed(1)}x",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Days to Sell: ${item["days_to_sell"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getStockStatusColor("${item["stock_status"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${item["stock_status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: _getStockStatusColor("${item["stock_status"]}"),
                  ),
                ),
              ),
            ],
          ),
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              children: [
                // Sales Performance Chart
                Container(
                  height: 160,
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Sales Performance Trend",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Expanded(
                        child: Center(
                          child: Text(
                            "Chart: Monthly Sales Movement\nVelocity Score: ${(item["velocity_score"] as double).toStringAsFixed(1)}/100",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: spSm),
                
                // Movement Metrics
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: _getMovementColor("${item["movement_type"]}").withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Movement Analysis",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: _getMovementColor("${item["movement_type"]}"),
                        ),
                      ),
                      SizedBox(height: spSm),
                      ResponsiveGridView(
                        padding: EdgeInsets.zero,
                        minItemWidth: 150,
                        children: [
                          _buildMetricItem("Monthly Sales", "${item["monthly_sales"]} units"),
                          _buildMetricItem("Current Stock", "${item["current_stock"]} units"),
                          _buildMetricItem("Stock Cover", "${item["stock_cover_days"]} days"),
                          _buildMetricItem("Daily Sales", "${(item["avg_daily_sales"] as double).toStringAsFixed(1)} units"),
                          _buildMetricItem("Velocity Score", "${(item["velocity_score"] as double).toStringAsFixed(1)}/100"),
                          _buildMetricItem("Sales Consistency", "${(item["sales_consistency"] as double).toStringAsFixed(1)}%"),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: spSm),
                
                // Business Impact
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Business Impact",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "${(item["profit_margin"] as double).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                                Text(
                                  "Profit Margin",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "${(item["revenue_contribution"] as double).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: infoColor,
                                  ),
                                ),
                                Text(
                                  "Revenue Share",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "${item["reorder_frequency"]}".replaceAll('_', ' '),
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "Reorder Freq.",
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
                    ],
                  ),
                ),
                SizedBox(height: spSm),
                
                // Trend Analysis
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: _getTrendColor("${item["demand_trend"]}").withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: _getTrendColor("${item["demand_trend"]}").withAlpha(50),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.trending_up,
                        color: _getTrendColor("${item["demand_trend"]}"),
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Demand Trend: ${item["demand_trend"]}".toUpperCase(),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: _getTrendColor("${item["demand_trend"]}"),
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Peak Season: ${item["peak_sales_month"]} • Last Sale: ${item["last_sale_date"]}",
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
                ),
                SizedBox(height: spSm),
                
                // Recommendations
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.lightbulb,
                            color: infoColor,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Recommendations:",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: infoColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        _getRecommendation("${item["movement_type"]}", "${item["stock_status"]}"),
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: spSm),
                
                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Adjust Stock",
                        size: bs.sm,
                        onPressed: () {
                          ss("Stock adjusted for ${item["product_name"]}");
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Pricing Strategy",
                        size: bs.sm,
                        onPressed: () {
                          ss("Pricing strategy for ${item["product_name"]}");
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "View Details",
                        size: bs.sm,
                        onPressed: () {
                          ss("Details opened for ${item["product_name"]}");
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

  Widget _buildMetricItem(String label, String value) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  String _getRecommendation(String movementType, String stockStatus) {
    if (movementType == "fast") {
      if (stockStatus == "low") {
        return "Increase stock levels immediately. Consider bulk ordering for better pricing.";
      } else if (stockStatus == "optimal") {
        return "Maintain current strategy. Monitor for demand spikes.";
      } else {
        return "Review demand forecast. Current stock may be over-optimized.";
      }
    } else if (movementType == "medium") {
      if (stockStatus == "excess") {
        return "Consider promotional campaigns to increase turnover.";
      } else {
        return "Optimize reorder points. Review seasonal patterns.";
      }
    } else {
      return "Consider discontinuation or deep discounting. Evaluate storage costs vs. potential revenue.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fast/Slow Moving Analysis"),
        actions: [
          IconButton(
            icon: Icon(Icons.speed),
            onPressed: () {
              ss("Movement velocity analysis opened");
            },
          ),
          IconButton(
            icon: Icon(Icons.insights),
            onPressed: () {
              ss("Movement insights opened");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummaryCard(),
            SizedBox(height: spMd),
            _buildFilterSection(),
            SizedBox(height: spMd),
            
            // Movement Velocity Chart
            Container(
              height: 220,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Text(
                    "Movement Velocity Distribution",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Expanded(
                    child: Center(
                      child: Text(
                        "Chart: Turnover Ratio vs Stock Cover Days\n(Bubble chart showing movement classification)",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),
            
            // Movement Analysis Results List
            Text(
              "Movement Analysis Results (${filteredData.length} products)",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            ...filteredData.map((item) => _buildMovementCard(item)).toList(),
          ],
        ),
      ),
    );
  }
}
