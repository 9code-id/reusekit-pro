import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmDemandForecastingView extends StatefulWidget {
  const IwmDemandForecastingView({super.key});

  @override
  State<IwmDemandForecastingView> createState() => _IwmDemandForecastingViewState();
}

class _IwmDemandForecastingViewState extends State<IwmDemandForecastingView> {
  int selectedTab = 0;
  String selectedWarehouse = "all";
  String selectedPeriod = "monthly";
  String selectedCategory = "all";

  List<Map<String, dynamic>> warehouseFilters = [
    {"label": "All Warehouses", "value": "all"},
    {"label": "Main Warehouse", "value": "main"},
    {"label": "Distribution Center", "value": "dist"},
    {"label": "Regional Hub", "value": "regional"},
  ];

  List<Map<String, dynamic>> periodFilters = [
    {"label": "Monthly", "value": "monthly"},
    {"label": "Quarterly", "value": "quarterly"},
    {"label": "Yearly", "value": "yearly"},
  ];

  List<Map<String, dynamic>> categoryFilters = [
    {"label": "All Categories", "value": "all"},
    {"label": "Electronics", "value": "electronics"},
    {"label": "Clothing", "value": "clothing"},
    {"label": "Home & Garden", "value": "home"},
  ];

  List<Map<String, dynamic>> forecastingSummary = [
    {
      "title": "Forecast Accuracy",
      "value": 89.5,
      "subtitle": "Last 30 days",
      "icon": Icons.trending_up,
      "color": successColor,
      "unit": "%"
    },
    {
      "title": "Items Forecasted",
      "value": 245,
      "subtitle": "Active forecasts",
      "icon": Icons.analytics,
      "color": primaryColor,
      "unit": ""
    },
    {
      "title": "Demand Variance",
      "value": 12.3,
      "subtitle": "vs prediction",
      "icon": Icons.timeline,
      "color": warningColor,
      "unit": "%"
    },
    {
      "title": "Stock Optimization",
      "value": 94.2,
      "subtitle": "Efficiency score",
      "icon": Icons.inventory,
      "color": infoColor,
      "unit": "%"
    },
  ];

  List<Map<String, dynamic>> demandForecasts = [
    {
      "productId": "PRD-001",
      "productName": "Wireless Headphones",
      "category": "Electronics",
      "currentStock": 125,
      "forecastedDemand": 180,
      "suggestedOrder": 85,
      "confidence": 92.5,
      "trend": "increasing",
      "seasonality": "High",
      "leadTime": 7,
      "monthlyData": [45, 52, 48, 65, 72, 78, 85, 92, 88, 95, 102, 115],
      "predictedData": [118, 125, 132, 140, 148, 155]
    },
    {
      "productId": "PRD-002",
      "productName": "Cotton T-Shirt",
      "category": "Clothing",
      "currentStock": 89,
      "forecastedDemand": 65,
      "suggestedOrder": 0,
      "confidence": 87.3,
      "trend": "decreasing",
      "seasonality": "Medium",
      "leadTime": 14,
      "monthlyData": [120, 115, 95, 85, 75, 68, 62, 58, 65, 72, 78, 85],
      "predictedData": [82, 78, 75, 70, 68, 65]
    },
    {
      "productId": "PRD-003",
      "productName": "Garden Tools Set",
      "category": "Home & Garden",
      "currentStock": 45,
      "forecastedDemand": 150,
      "suggestedOrder": 125,
      "confidence": 95.8,
      "trend": "seasonal",
      "seasonality": "Very High",
      "leadTime": 10,
      "monthlyData": [15, 18, 35, 85, 120, 135, 145, 140, 125, 95, 55, 25],
      "predictedData": [30, 45, 95, 135, 150, 145]
    },
  ];

  List<Map<String, dynamic>> forecastingModels = [
    {
      "modelName": "ARIMA Seasonal",
      "accuracy": 89.5,
      "applicability": "High seasonality products",
      "status": "Active",
      "lastUpdated": "2024-01-16 08:00",
      "itemsTracked": 85
    },
    {
      "modelName": "Linear Regression",
      "accuracy": 84.2,
      "applicability": "Stable trend products",
      "status": "Active",
      "lastUpdated": "2024-01-16 08:00",
      "itemsTracked": 92
    },
    {
      "modelName": "Neural Network",
      "accuracy": 91.3,
      "applicability": "Complex pattern products",
      "status": "Testing",
      "lastUpdated": "2024-01-16 07:30",
      "itemsTracked": 68
    },
  ];

  List<Map<String, dynamic>> demandAnalytics = [
    {
      "metric": "Peak Demand Period",
      "value": "March - May",
      "description": "Highest demand months across all categories",
      "impact": "High"
    },
    {
      "metric": "Lowest Demand Period",
      "value": "January - February",
      "description": "Seasonal low demand period",
      "impact": "Medium"
    },
    {
      "metric": "Top Growth Category",
      "value": "Electronics",
      "description": "15% growth year-over-year",
      "impact": "High"
    },
    {
      "metric": "Volatile Products",
      "value": "25 items",
      "description": "Products with >30% demand variance",
      "impact": "High"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Demand Forecasting",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Forecasts", icon: Icon(Icons.trending_up)),
        Tab(text: "Models", icon: Icon(Icons.model_training)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildForecastsTab(),
        _buildModelsTab(),
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
          _buildForecastingSummary(),
          _buildDemandTrends(),
          _buildDemandAnalytics(),
        ],
      ),
    );
  }

  Widget _buildForecastsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildForecastFilters(),
          _buildDemandForecastsList(),
        ],
      ),
    );
  }

  Widget _buildModelsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildModelHeader(),
          _buildForecastingModelsList(),
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
                  label: "Warehouse",
                  items: warehouseFilters,
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
                  label: "Period",
                  items: periodFilters,
                  value: selectedPeriod,
                  onChanged: (value, label) {
                    selectedPeriod = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Category",
            items: categoryFilters,
            value: selectedCategory,
            onChanged: (value, label) {
              selectedCategory = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildForecastFilters() {
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
              label: "Filter by Category",
              items: categoryFilters,
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

  Widget _buildModelHeader() {
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Forecasting Models",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "AI-powered demand prediction models",
                  style: TextStyle(
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            icon: Icons.add,
            label: "Add Model",
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildForecastingSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Forecasting Performance",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: forecastingSummary.map((summary) => _buildSummaryCard(summary)).toList(),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(Map<String, dynamic> summary) {
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
            ],
          ),
          Text(
            "${summary["value"]}${summary["unit"]}",
            style: TextStyle(
              fontSize: 24,
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

  Widget _buildDemandTrends() {
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
            "Demand Trends",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            height: 200,
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
                  SizedBox(height: spSm),
                  Text(
                    "Demand Trend Chart",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Historical vs Predicted Demand",
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
      ),
    );
  }

  Widget _buildDemandAnalytics() {
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
            "Demand Analytics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...demandAnalytics.map((analytic) => _buildAnalyticItem(analytic)),
        ],
      ),
    );
  }

  Widget _buildAnalyticItem(Map<String, dynamic> analytic) {
    Color impactColor = _getImpactColor(analytic["impact"]);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(3),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${analytic["metric"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: impactColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${analytic["impact"]}",
                        style: TextStyle(
                          color: impactColor,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "${analytic["value"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${analytic["description"]}",
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
    );
  }

  Widget _buildDemandForecastsList() {
    return Column(
      spacing: spSm,
      children: demandForecasts.map((forecast) => _buildForecastCard(forecast)).toList(),
    );
  }

  Widget _buildForecastCard(Map<String, dynamic> forecast) {
    Color trendColor = _getTrendColor(forecast["trend"]);
    Color confidenceColor = _getConfidenceColor(forecast["confidence"]);
    bool needsOrdering = (forecast["suggestedOrder"] as int) > 0;
    
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
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${forecast["productName"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${forecast["productId"]} • ${forecast["category"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: trendColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${forecast["trend"]}",
                      style: TextStyle(
                        color: trendColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  SizedBox(width: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: confidenceColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${(forecast["confidence"] as double).toStringAsFixed(1)}% confident",
                      style: TextStyle(
                        color: confidenceColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStockInfo("Current Stock", "${forecast["currentStock"]}", primaryColor),
              _buildStockInfo("Forecasted Demand", "${forecast["forecastedDemand"]}", infoColor),
              _buildStockInfo("Suggested Order", "${forecast["suggestedOrder"]}", 
                  needsOrdering ? warningColor : successColor),
              _buildStockInfo("Lead Time", "${forecast["leadTime"]} days", disabledBoldColor),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.trending_up,
                color: disabledBoldColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                "Seasonality: ${forecast["seasonality"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              if (needsOrdering)
                QButton(
                  label: "Create Order",
                  size: bs.sm,
                  onPressed: () {},
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStockInfo(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForecastingModelsList() {
    return Column(
      spacing: spSm,
      children: forecastingModels.map((model) => _buildModelCard(model)).toList(),
    );
  }

  Widget _buildModelCard(Map<String, dynamic> model) {
    Color statusColor = _getModelStatusColor(model["status"]);
    Color accuracyColor = _getAccuracyColor(model["accuracy"]);
    
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
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${model["modelName"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${model["applicability"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${model["status"]}",
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
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
                  children: [
                    Text(
                      "Accuracy",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${(model["accuracy"] as double).toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: accuracyColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spSm),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Items Tracked: ${model["itemsTracked"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Updated: ${model["lastUpdated"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Spacer(),
              QButton(
                label: "Configure",
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(width: spXs),
              QButton(
                label: "View Details",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getTrendColor(String trend) {
    switch (trend.toLowerCase()) {
      case 'increasing':
        return successColor;
      case 'decreasing':
        return dangerColor;
      case 'seasonal':
        return infoColor;
      case 'stable':
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getConfidenceColor(double confidence) {
    if (confidence >= 90) return successColor;
    if (confidence >= 75) return infoColor;
    if (confidence >= 60) return warningColor;
    return dangerColor;
  }

  Color _getImpactColor(String impact) {
    switch (impact.toLowerCase()) {
      case 'high':
        return dangerColor;
      case 'medium':
        return warningColor;
      case 'low':
        return successColor;
      default:
        return primaryColor;
    }
  }

  Color _getModelStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return successColor;
      case 'testing':
        return warningColor;
      case 'inactive':
        return disabledBoldColor;
      default:
        return primaryColor;
    }
  }

  Color _getAccuracyColor(double accuracy) {
    if (accuracy >= 90) return successColor;
    if (accuracy >= 80) return infoColor;
    if (accuracy >= 70) return warningColor;
    return dangerColor;
  }
}
