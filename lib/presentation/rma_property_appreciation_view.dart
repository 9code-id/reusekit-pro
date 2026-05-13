import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaPropertyAppreciationView extends StatefulWidget {
  const RmaPropertyAppreciationView({super.key});

  @override
  State<RmaPropertyAppreciationView> createState() => _RmaPropertyAppreciationViewState();
}

class _RmaPropertyAppreciationViewState extends State<RmaPropertyAppreciationView> {
  String selectedProperty = "all";
  String selectedTimeframe = "5years";
  int currentTab = 0;

  List<Map<String, dynamic>> propertyOptions = [
    {"label": "All Properties", "value": "all"},
    {"label": "Sunset Apartments", "value": "sunset"},
    {"label": "Marina Plaza", "value": "marina"},
    {"label": "Downtown Office", "value": "downtown"},
    {"label": "Oakwood Residences", "value": "oakwood"},
  ];

  List<Map<String, dynamic>> timeframeOptions = [
    {"label": "1 Year", "value": "1year"},
    {"label": "3 Years", "value": "3years"},
    {"label": "5 Years", "value": "5years"},
    {"label": "10 Years", "value": "10years"},
  ];

  List<Map<String, dynamic>> propertyData = [
    {
      "id": "sunset",
      "name": "Sunset Apartments",
      "purchase_price": 850000,
      "current_value": 1245000,
      "appreciation": 46.5,
      "annual_growth": 8.1,
      "type": "Residential",
      "location": "Downtown",
      "sqft": 12500,
      "units": 24,
      "purchase_date": "2019-03-15",
      "last_appraisal": "2024-01-15"
    },
    {
      "id": "marina",
      "name": "Marina Plaza",
      "purchase_price": 1250000,
      "current_value": 1875000,
      "appreciation": 50.0,
      "annual_growth": 9.2,
      "type": "Commercial",
      "location": "Waterfront",
      "sqft": 25000,
      "units": 8,
      "purchase_date": "2018-08-20",
      "last_appraisal": "2024-02-10"
    },
    {
      "id": "downtown",
      "name": "Downtown Office Complex",
      "purchase_price": 2100000,
      "current_value": 2940000,
      "appreciation": 40.0,
      "annual_growth": 7.5,
      "type": "Commercial",
      "location": "Business District",
      "sqft": 45000,
      "units": 12,
      "purchase_date": "2019-11-05",
      "last_appraisal": "2023-12-20"
    },
    {
      "id": "oakwood",
      "name": "Oakwood Residences",
      "purchase_price": 675000,
      "current_value": 892000,
      "appreciation": 32.1,
      "annual_growth": 5.8,
      "type": "Residential",
      "location": "Suburban",
      "sqft": 8500,
      "units": 16,
      "purchase_date": "2020-06-12",
      "last_appraisal": "2024-01-08"
    },
  ];

  List<Map<String, dynamic>> valueHistory = [
    {"year": "2019", "total_value": 4875000, "appreciation": 0},
    {"year": "2020", "total_value": 5247000, "appreciation": 7.6},
    {"year": "2021", "total_value": 5689000, "appreciation": 8.4},
    {"year": "2022", "total_value": 6124000, "appreciation": 7.6},
    {"year": "2023", "total_value": 6645000, "appreciation": 8.5},
    {"year": "2024", "total_value": 6952000, "appreciation": 4.6},
  ];

  List<Map<String, dynamic>> marketComparisons = [
    {"metric": "Local Market Average", "value": 6.2, "vs_portfolio": 1.9},
    {"metric": "National Average", "value": 4.8, "vs_portfolio": 3.3},
    {"metric": "Property Type Average", "value": 7.1, "vs_portfolio": 1.0},
    {"metric": "Inflation Rate", "value": 3.2, "vs_portfolio": 4.9},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Property Appreciation",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.trending_up)),
        Tab(text: "Properties", icon: Icon(Icons.business)),
        Tab(text: "Analysis", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildPropertiesTab(),
        _buildAnalysisTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildFilters(),
          _buildPortfolioSummary(),
          _buildAppreciationChart(),
          _buildTopPerformers(),
        ],
      ),
    );
  }

  Widget _buildPropertiesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildPropertyComparison(),
          _buildPropertyDetails(),
        ],
      ),
    );
  }

  Widget _buildAnalysisTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildMarketComparison(),
          _buildTrendAnalysis(),
          _buildProjections(),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Row(
      spacing: spMd,
      children: [
        Expanded(
          child: QDropdownField(
            label: "Property",
            items: propertyOptions,
            value: selectedProperty,
            onChanged: (value, label) {
              selectedProperty = value;
              setState(() {});
            },
          ),
        ),
        Expanded(
          child: QDropdownField(
            label: "Timeframe",
            items: timeframeOptions,
            value: selectedTimeframe,
            onChanged: (value, label) {
              selectedTimeframe = value;
              setState(() {});
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPortfolioSummary() {
    double totalPurchasePrice = propertyData.fold(0.0, (sum, item) => sum + (item["purchase_price"] as int).toDouble());
    double totalCurrentValue = propertyData.fold(0.0, (sum, item) => sum + (item["current_value"] as int).toDouble());
    double totalAppreciation = ((totalCurrentValue - totalPurchasePrice) / totalPurchasePrice) * 100;
    double averageAnnualGrowth = propertyData.fold(0.0, (sum, item) => sum + (item["annual_growth"] as double)) / propertyData.length;

    return ResponsiveGridView(
      minItemWidth: 200,
      children: [
        _buildSummaryCard("Total Portfolio Value", totalCurrentValue.currency, Icons.account_balance, primaryColor),
        _buildSummaryCard("Total Appreciation", "${totalAppreciation.toStringAsFixed(1)}%", Icons.trending_up, successColor),
        _buildSummaryCard("Average Annual Growth", "${averageAnnualGrowth.toStringAsFixed(1)}%", Icons.show_chart, infoColor),
        _buildSummaryCard("Equity Gained", (totalCurrentValue - totalPurchasePrice).currency, Icons.attach_money, warningColor),
      ],
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spLg),
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
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              Spacer(),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
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

  Widget _buildAppreciationChart() {
    return Container(
      padding: EdgeInsets.all(spLg),
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
              Text(
                "Portfolio Value Growth",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                icon: Icons.fullscreen,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: spLg),
          Container(
            height: 250,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(5),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.timeline,
                        size: 64,
                        color: primaryColor.withAlpha(60),
                      ),
                      SizedBox(height: spMd),
                      Text(
                        "Value Appreciation Chart",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "5-Year Portfolio Growth Trend",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildChartLegendItem("Portfolio Value", primaryColor),
              _buildChartLegendItem("Market Average", warningColor),
              _buildChartLegendItem("Growth Rate", successColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChartLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radiusXs),
          ),
        ),
        SizedBox(width: spXs),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildTopPerformers() {
    List<Map<String, dynamic>> sortedProperties = List.from(propertyData);
    sortedProperties.sort((a, b) => (b["annual_growth"] as double).compareTo(a["annual_growth"] as double));

    return Container(
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Top Performers",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spLg),
          ...sortedProperties.take(3).map((property) => _buildPerformerRow(property)),
        ],
      ),
    );
  }

  Widget _buildPerformerRow(Map<String, dynamic> property) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: successColor.withAlpha(5),
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
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: successColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              Icons.star,
              color: successColor,
              size: 20,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${property["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "${property["type"]} • ${property["location"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${(property["annual_growth"] as double).toStringAsFixed(1)}% annually",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
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
    );
  }

  Widget _buildPropertyComparison() {
    return Container(
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Property Comparison",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spLg),
          ...propertyData.map((property) => _buildPropertyComparisonRow(property)),
        ],
      ),
    );
  }

  Widget _buildPropertyComparisonRow(Map<String, dynamic> property) {
    double appreciationValue = ((property["current_value"] as int) - (property["purchase_price"] as int)).toDouble();
    Color performanceColor = (property["annual_growth"] as double) > 7.0 ? successColor : 
                           (property["annual_growth"] as double) > 5.0 ? warningColor : dangerColor;

    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: performanceColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border(
          left: BorderSide(
            width: 4,
            color: performanceColor,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${property["name"]}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: performanceColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${(property["appreciation"] as double).toStringAsFixed(1)}%",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: performanceColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Purchase Price",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${((property["purchase_price"] as int).toDouble()).currency}",
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
                      "Current Value",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${((property["current_value"] as int).toDouble()).currency}",
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
                      "Equity Gained",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${appreciationValue.currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Text(
                "${property["type"]} • ${property["units"]} units • ${(property["sqft"] as int).toString()} sq ft",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "${(property["annual_growth"] as double).toStringAsFixed(1)}% annually",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: performanceColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyDetails() {
    return Container(
      height: 300,
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Property Performance Visualization",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spLg),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.pie_chart,
                    size: 48,
                    color: primaryColor.withAlpha(60),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Performance Breakdown Chart",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 16,
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

  Widget _buildMarketComparison() {
    return Container(
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Market Comparison",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spLg),
          ...marketComparisons.map((comparison) => _buildComparisonRow(comparison)),
        ],
      ),
    );
  }

  Widget _buildComparisonRow(Map<String, dynamic> comparison) {
    bool outperforming = (comparison["vs_portfolio"] as double) > 0;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: outperforming ? successColor.withAlpha(5) : warningColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${comparison["metric"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${(comparison["value"] as double).toStringAsFixed(1)}% average",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Icon(
                    outperforming ? Icons.trending_up : Icons.trending_down,
                    color: outperforming ? successColor : warningColor,
                    size: 20,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "${outperforming ? '+' : ''}${(comparison["vs_portfolio"] as double).toStringAsFixed(1)}%",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: outperforming ? successColor : warningColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spXs),
              Text(
                outperforming ? "Outperforming" : "Underperforming",
                style: TextStyle(
                  fontSize: 12,
                  color: outperforming ? successColor : warningColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTrendAnalysis() {
    return Container(
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
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
          SizedBox(height: spLg),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.insights,
                  size: 48,
                  color: primaryColor.withAlpha(60),
                ),
                SizedBox(height: spSm),
                Text(
                  "Trend Analysis Chart",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjections() {
    List<Map<String, dynamic>> projections = [
      {"period": "Next 12 Months", "projected_growth": 8.5, "confidence": "High"},
      {"period": "2-3 Years", "projected_growth": 7.2, "confidence": "Medium"},
      {"period": "5+ Years", "projected_growth": 6.8, "confidence": "Medium"},
    ];

    return Container(
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Growth Projections",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spLg),
          ...projections.map((projection) => Container(
            margin: EdgeInsets.only(bottom: spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${projection["period"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Projected Growth: ${(projection["projected_growth"] as double).toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: projection["confidence"] == "High" ? successColor.withAlpha(20) : warningColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${projection["confidence"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: projection["confidence"] == "High" ? successColor : warningColor,
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
