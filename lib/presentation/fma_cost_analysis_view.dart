import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaCostAnalysisView extends StatefulWidget {
  const FmaCostAnalysisView({super.key});

  @override
  State<FmaCostAnalysisView> createState() => _FmaCostAnalysisViewState();
}

class _FmaCostAnalysisViewState extends State<FmaCostAnalysisView> {
  int currentTab = 0;
  String selectedPeriod = "This Month";
  String selectedCategory = "All";
  
  List<Map<String, dynamic>> periodItems = [
    {"label": "This Week", "value": "Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "Last Month", "value": "Last Month"},
    {"label": "This Quarter", "value": "Quarter"},
    {"label": "This Year", "value": "Year"},
    {"label": "Custom", "value": "Custom"},
  ];
  
  List<Map<String, dynamic>> categoryItems = [
    {"label": "All", "value": "All"},
    {"label": "Food Costs", "value": "Food"},
    {"label": "Labor", "value": "Labor"},
    {"label": "Overhead", "value": "Overhead"},
    {"label": "Marketing", "value": "Marketing"},
    {"label": "Equipment", "value": "Equipment"},
  ];

  List<Map<String, dynamic>> costData = [
    {
      "category": "Food Costs",
      "amount": 12450.00,
      "percentage": 32.5,
      "change": -2.3,
      "budget": 13000.00,
      "variance": -550.00,
      "items": ["Meat & Seafood", "Fresh Produce", "Dairy Products", "Beverages"],
    },
    {
      "category": "Labor",
      "amount": 15600.00,
      "percentage": 40.8,
      "change": 1.5,
      "budget": 15000.00,
      "variance": 600.00,
      "items": ["Salaries", "Benefits", "Overtime", "Training"],
    },
    {
      "category": "Overhead",
      "amount": 6200.00,
      "percentage": 16.2,
      "change": 0.5,
      "budget": 6000.00,
      "variance": 200.00,
      "items": ["Rent", "Utilities", "Insurance", "Supplies"],
    },
    {
      "category": "Marketing",
      "amount": 2800.00,
      "percentage": 7.3,
      "change": 15.2,
      "budget": 2500.00,
      "variance": 300.00,
      "items": ["Digital Ads", "Promotions", "Events", "Social Media"],
    },
    {
      "category": "Equipment",
      "amount": 1200.00,
      "percentage": 3.2,
      "change": -8.1,
      "budget": 1500.00,
      "variance": -300.00,
      "items": ["Maintenance", "New Equipment", "Repairs", "Upgrades"],
    },
  ];

  Color _getVarianceColor(double variance) {
    if (variance > 0) return dangerColor;
    if (variance < 0) return successColor;
    return disabledBoldColor;
  }

  Color _getChangeColor(double change) {
    if (change > 0) return dangerColor;
    if (change < 0) return successColor;
    return disabledBoldColor;
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Cost Analysis",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.pie_chart)),
        Tab(text: "Categories", icon: Icon(Icons.category)),
        Tab(text: "Trends", icon: Icon(Icons.trending_up)),
        Tab(text: "Budget", icon: Icon(Icons.account_balance)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildCategoriesTab(),
        _buildTrendsTab(),
        _buildBudgetTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Period Filter
          Container(
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
                    label: "Time Period",
                    items: periodItems,
                    value: selectedPeriod,
                    onChanged: (value, label) {
                      selectedPeriod = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.download,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
          ),

          // Total Cost Summary
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
              border: Border(
                left: BorderSide(width: 4, color: primaryColor),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.attach_money, color: primaryColor, size: 24),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "Total Operating Costs",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "\$38,250",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(
                      Icons.trending_up,
                      color: dangerColor,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "+2.1% vs last month",
                      style: TextStyle(
                        fontSize: 12,
                        color: dangerColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Key Metrics
          Row(
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
                    children: [
                      Text(
                        "Food Cost %",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "32.5%",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Icon(Icons.trending_down, color: successColor, size: 12),
                          SizedBox(width: spXs),
                          Text(
                            "-2.3%",
                            style: TextStyle(
                              fontSize: 10,
                              color: successColor,
                            ),
                          ),
                        ],
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
                    children: [
                      Text(
                        "Labor Cost %",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "40.8%",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Icon(Icons.trending_up, color: dangerColor, size: 12),
                          SizedBox(width: spXs),
                          Text(
                            "+1.5%",
                            style: TextStyle(
                              fontSize: 10,
                              color: dangerColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Cost Breakdown
          Container(
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
                  "Cost Breakdown",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...costData.map((cost) => Container(
                  padding: EdgeInsets.symmetric(vertical: spSm),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: disabledOutlineBorderColor),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: cost["category"] == "Food Costs" ? warningColor :
                                 cost["category"] == "Labor" ? primaryColor :
                                 cost["category"] == "Overhead" ? infoColor :
                                 cost["category"] == "Marketing" ? successColor : dangerColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${cost["category"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${(cost["percentage"] as num).toStringAsFixed(1)}% of total",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "\$${((cost["amount"] as num).toDouble()).currency}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Icon(
                                (cost["change"] as num) > 0 ? Icons.trending_up : Icons.trending_down,
                                color: _getChangeColor((cost["change"] as num).toDouble()),
                                size: 12,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${(cost["change"] as num) > 0 ? '+' : ''}${(cost["change"] as num).toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: _getChangeColor((cost["change"] as num).toDouble()),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                )).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Category Filter
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: QDropdownField(
              label: "Select Category",
              items: categoryItems,
              value: selectedCategory,
              onChanged: (value, label) {
                selectedCategory = value;
                setState(() {});
              },
            ),
          ),

          // Detailed Category Analysis
          ...costData.map((cost) => Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: (cost["category"] == "Food Costs" ? warningColor :
                               cost["category"] == "Labor" ? primaryColor :
                               cost["category"] == "Overhead" ? infoColor :
                               cost["category"] == "Marketing" ? successColor : dangerColor).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        cost["category"] == "Food Costs" ? Icons.restaurant :
                        cost["category"] == "Labor" ? Icons.people :
                        cost["category"] == "Overhead" ? Icons.business :
                        cost["category"] == "Marketing" ? Icons.campaign : Icons.build,
                        color: cost["category"] == "Food Costs" ? warningColor :
                               cost["category"] == "Labor" ? primaryColor :
                               cost["category"] == "Overhead" ? infoColor :
                               cost["category"] == "Marketing" ? successColor : dangerColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${cost["category"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${(cost["percentage"] as num).toStringAsFixed(1)}% of total costs",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "\$${((cost["amount"] as num).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Budget",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "\$${((cost["budget"] as num).toDouble()).currency}",
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
                              children: [
                                Text(
                                  "Variance",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${(cost["variance"] as num) > 0 ? '+' : ''}\$${((cost["variance"] as num).abs().toDouble()).currency}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: _getVarianceColor((cost["variance"] as num).toDouble()),
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
                                  "Change",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Icon(
                                      (cost["change"] as num) > 0 ? Icons.trending_up : Icons.trending_down,
                                      color: _getChangeColor((cost["change"] as num).toDouble()),
                                      size: 14,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${(cost["change"] as num) > 0 ? '+' : ''}${(cost["change"] as num).toStringAsFixed(1)}%",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: _getChangeColor((cost["change"] as num).toDouble()),
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
                ),
                SizedBox(height: spSm),
                Text(
                  "Sub-categories:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: (cost["items"] as List).map((item) => Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      item,
                      style: TextStyle(
                        fontSize: 10,
                        color: primaryColor,
                      ),
                    ),
                  )).toList(),
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildTrendsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Monthly Trends
          Container(
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
                  "6-Month Cost Trends",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.show_chart, color: primaryColor, size: 48),
                        SizedBox(height: spSm),
                        Text(
                          "Cost Trend Chart",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Interactive chart showing monthly cost trends",
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
          ),

          // Trend Analysis
          Container(
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
                  "Trend Analysis",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: successColor),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.trending_down, color: successColor),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Food Costs Decreasing",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "2.3% reduction due to better supplier negotiations",
                              style: TextStyle(
                                fontSize: 12,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: warningColor),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.trending_up, color: warningColor),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Marketing Spend Increased",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "15.2% increase for summer promotion campaign",
                              style: TextStyle(
                                fontSize: 12,
                                color: warningColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Seasonal Patterns
          Container(
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
                  "Seasonal Cost Patterns",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...["Summer: Higher cooling costs", "Winter: Increased heating expenses", "Holidays: Peak labor costs", "Spring: Equipment maintenance"].map((pattern) => 
                  Container(
                    padding: EdgeInsets.symmetric(vertical: spSm),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: disabledOutlineBorderColor),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: pattern.contains("Summer") ? warningColor :
                                   pattern.contains("Winter") ? infoColor :
                                   pattern.contains("Holidays") ? dangerColor : successColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            pattern,
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Text(
                          pattern.contains("Summer") ? "+12%" :
                          pattern.contains("Winter") ? "+8%" :
                          pattern.contains("Holidays") ? "+25%" : "+5%",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: pattern.contains("Summer") ? warningColor :
                                   pattern.contains("Winter") ? infoColor :
                                   pattern.contains("Holidays") ? dangerColor : successColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBudgetTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Budget vs Actual
          Container(
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
                  "Budget vs Actual",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total Budget",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "\$38,000",
                              style: TextStyle(
                                fontSize: 18,
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
                              "Actual Spend",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "\$38,250",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
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
                              "Variance",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "+\$250",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Budget Alerts
          Container(
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
                  "Budget Alerts",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: dangerColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: dangerColor),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.warning, color: dangerColor),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Labor Costs Over Budget",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                              ),
                            ),
                            Text(
                              "Exceeded by \$600 (4% over budget)",
                              style: TextStyle(
                                fontSize: 12,
                                color: dangerColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: warningColor),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info, color: warningColor),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Marketing Budget Alert",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "80% of monthly budget used",
                              style: TextStyle(
                                fontSize: 12,
                                color: warningColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Cost Control Recommendations
          Container(
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
                  "Cost Control Recommendations",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...["Optimize staff scheduling to reduce overtime", "Renegotiate supplier contracts", "Implement energy-saving measures", "Review marketing ROI for better allocation"].map((recommendation) => 
                  Container(
                    padding: EdgeInsets.all(spSm),
                    margin: EdgeInsets.only(bottom: spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: disabledOutlineBorderColor),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(
                            Icons.lightbulb,
                            size: 14,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            recommendation,
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        QButton(
                          icon: Icons.arrow_forward,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
