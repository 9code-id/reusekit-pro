import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaDepreciationTrackerView extends StatefulWidget {
  const CmaDepreciationTrackerView({super.key});

  @override
  State<CmaDepreciationTrackerView> createState() => _CmaDepreciationTrackerViewState();
}

class _CmaDepreciationTrackerViewState extends State<CmaDepreciationTrackerView> {
  int currentTab = 0;
  String selectedVehicle = "";
  String timeRange = "1_year";

  List<Map<String, dynamic>> vehicles = [
    {
      "id": "1",
      "make": "Honda",
      "model": "Civic",
      "year": "2020",
      "trim": "LX",
      "purchaseDate": "2020-03-15",
      "purchasePrice": 22000.00,
      "currentValue": 18500.00,
      "image": "https://picsum.photos/300/200?random=1&keyword=civic",
      "depreciationData": [
        {"date": "2020-03", "value": 22000.00, "mileage": 10},
        {"date": "2020-06", "value": 21200.00, "mileage": 3500},
        {"date": "2020-09", "value": 20800.00, "mileage": 7200},
        {"date": "2020-12", "value": 20300.00, "mileage": 11000},
        {"date": "2021-03", "value": 19800.00, "mileage": 15500},
        {"date": "2021-06", "value": 19500.00, "mileage": 19200},
        {"date": "2021-09", "value": 19200.00, "mileage": 23800},
        {"date": "2021-12", "value": 18900.00, "mileage": 27500},
        {"date": "2022-03", "value": 18700.00, "mileage": 31200},
        {"date": "2022-06", "value": 18600.00, "mileage": 34800},
        {"date": "2022-09", "value": 18550.00, "mileage": 38500},
        {"date": "2022-12", "value": 18500.00, "mileage": 42100},
        {"date": "2023-03", "value": 18450.00, "mileage": 45800},
        {"date": "2023-06", "value": 18400.00, "mileage": 49200},
        {"date": "2023-09", "value": 18350.00, "mileage": 52800},
        {"date": "2023-12", "value": 18300.00, "mileage": 56500},
        {"date": "2024-03", "value": 18250.00, "mileage": 60100},
        {"date": "2024-06", "value": 18200.00, "mileage": 63800},
        {"date": "2024-09", "value": 18150.00, "mileage": 67200},
        {"date": "2024-12", "value": 18500.00, "mileage": 70800},
      ],
    },
    {
      "id": "2",
      "make": "Toyota",
      "model": "Camry",
      "year": "2019",
      "trim": "LE",
      "purchaseDate": "2019-08-20",
      "purchasePrice": 25500.00,
      "currentValue": 21200.00,
      "image": "https://picsum.photos/300/200?random=2&keyword=camry",
      "depreciationData": [
        {"date": "2019-08", "value": 25500.00, "mileage": 25},
        {"date": "2019-11", "value": 24800.00, "mileage": 4200},
        {"date": "2020-02", "value": 24200.00, "mileage": 8500},
        {"date": "2020-05", "value": 23800.00, "mileage": 12800},
        {"date": "2020-08", "value": 23400.00, "mileage": 17200},
        {"date": "2020-11", "value": 23000.00, "mileage": 21500},
        {"date": "2021-02", "value": 22600.00, "mileage": 25800},
        {"date": "2021-05", "value": 22300.00, "mileage": 30200},
        {"date": "2021-08", "value": 22000.00, "mileage": 34500},
        {"date": "2021-11", "value": 21800.00, "mileage": 38800},
        {"date": "2022-02", "value": 21600.00, "mileage": 43200},
        {"date": "2022-05", "value": 21450.00, "mileage": 47500},
        {"date": "2022-08", "value": 21350.00, "mileage": 51800},
        {"date": "2022-11", "value": 21280.00, "mileage": 56200},
        {"date": "2023-02", "value": 21220.00, "mileage": 60500},
        {"date": "2023-05", "value": 21180.00, "mileage": 64800},
        {"date": "2023-08", "value": 21150.00, "mileage": 69200},
        {"date": "2023-11", "value": 21130.00, "mileage": 73500},
        {"date": "2024-02", "value": 21110.00, "mileage": 77800},
        {"date": "2024-05", "value": 21100.00, "mileage": 82200},
        {"date": "2024-08", "value": 21150.00, "mileage": 86500},
        {"date": "2024-11", "value": 21200.00, "mileage": 90800},
      ],
    },
  ];

  List<Map<String, dynamic>> timeRanges = [
    {"label": "Last 6 Months", "value": "6_months"},
    {"label": "Last Year", "value": "1_year"},
    {"label": "Last 2 Years", "value": "2_years"},
    {"label": "All Time", "value": "all_time"},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Depreciation Tracker",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Dashboard", icon: Icon(Icons.dashboard)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "Compare", icon: Icon(Icons.compare)),
      ],
      tabChildren: [
        _buildDashboardTab(),
        _buildAnalyticsTab(),
        _buildCompareTab(),
      ],
      onInit: (tabController) {},
    );
  }

  Widget _buildDashboardTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            "Vehicle Depreciation Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          // Summary Cards
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildSummaryCard(
                "Total Fleet Value",
                "\$${vehicles.fold(0.0, (sum, v) => sum + (v["currentValue"] as double)).toStringAsFixed(0)}",
                Icons.account_balance_wallet,
                primaryColor,
              ),
              _buildSummaryCard(
                "Total Depreciation",
                "\$${vehicles.fold(0.0, (sum, v) => sum + ((v["purchasePrice"] as double) - (v["currentValue"] as double))).toStringAsFixed(0)}",
                Icons.trending_down,
                dangerColor,
              ),
              _buildSummaryCard(
                "Average Annual Rate",
                "${_calculateAverageDepreciationRate().toStringAsFixed(1)}%",
                Icons.percent,
                warningColor,
              ),
              _buildSummaryCard(
                "Vehicles Tracked",
                "${vehicles.length}",
                Icons.directions_car,
                infoColor,
              ),
            ],
          ),

          // Vehicle List
          ...vehicles.map((vehicle) => _buildVehicleCard(vehicle)),

          // Add Vehicle Button
          Container(
            width: double.infinity,
            child: QButton(
              label: "Add Vehicle to Track",
              size: bs.md,
              onPressed: _addVehicle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
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
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: color.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              Spacer(),
              Icon(Icons.more_vert, color: disabledBoldColor, size: 20),
            ],
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleCard(Map<String, dynamic> vehicle) {
    double totalDepreciation = (vehicle["purchasePrice"] as double) - (vehicle["currentValue"] as double);
    double depreciationPercent = (totalDepreciation / (vehicle["purchasePrice"] as double)) * 100;
    
    // Calculate depreciation rate
    DateTime purchaseDate = DateTime.parse(vehicle["purchaseDate"] as String);
    double yearsOwned = DateTime.now().difference(purchaseDate).inDays / 365.25;
    double annualDepreciationRate = depreciationPercent / yearsOwned;

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
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${vehicle["image"]}",
                  width: 80,
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
                      "${vehicle["year"]} ${vehicle["make"]} ${vehicle["model"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    if ((vehicle["trim"] as String).isNotEmpty)
                      Text(
                        "${vehicle["trim"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    Text(
                      "Purchased: ${vehicle["purchaseDate"]}",
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

          // Value Information
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
                      "\$${(vehicle["purchasePrice"] as double).toStringAsFixed(0)}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Current Value",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${(vehicle["currentValue"] as double).toStringAsFixed(0)}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Total Loss",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${totalDepreciation.toStringAsFixed(0)}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: dangerColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Depreciation Stats
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "Total Depreciation",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${depreciationPercent.toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "Annual Rate",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${annualDepreciationRate.toStringAsFixed(1)}%/yr",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "Years Owned",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${yearsOwned.toStringAsFixed(1)}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Actions
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () => _viewVehicleDetails(vehicle),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.show_chart,
                size: bs.sm,
                onPressed: () => _showDepreciationChart(vehicle),
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showVehicleOptions(vehicle),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Select Vehicle",
                  items: [
                    {"label": "All Vehicles", "value": ""},
                    ...vehicles.map((v) => {
                      "label": "${v["year"]} ${v["make"]} ${v["model"]}",
                      "value": v["id"],
                    }),
                  ],
                  value: selectedVehicle,
                  onChanged: (value, label) {
                    selectedVehicle = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Time Range",
                  items: timeRanges,
                  value: timeRange,
                  onChanged: (value, label) {
                    timeRange = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          // Depreciation Chart Placeholder
          Container(
            height: 250,
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
                  "Depreciation Trend",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      spacing: spSm,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.show_chart,
                          size: 60,
                          color: disabledBoldColor,
                        ),
                        Text(
                          "Depreciation Chart",
                          style: TextStyle(
                            fontSize: 16,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "Interactive chart showing value decline over time",
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

          // Analytics Summary
          if (selectedVehicle.isNotEmpty) ...[
            Container(
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
                    "Analytics Summary",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  _buildAnalyticRow("Steepest Decline Period", "Months 1-6 (-12.3%)"),
                  _buildAnalyticRow("Slowest Decline Period", "Months 25-30 (-1.8%)"),
                  _buildAnalyticRow("Current Depreciation Rate", "1.2% per year"),
                  _buildAnalyticRow("Projected Value (1 year)", "\$17,800"),
                  _buildAnalyticRow("Market Performance", "5% above average"),
                ],
              ),
            ),
          ],

          // Depreciation Factors
          Container(
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
                  "Depreciation Factors",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                _buildFactorRow("Age", "35%", primaryColor),
                _buildFactorRow("Mileage", "25%", warningColor),
                _buildFactorRow("Market Demand", "20%", successColor),
                _buildFactorRow("Condition", "15%", infoColor),
                _buildFactorRow("Brand Reputation", "5%", disabledBoldColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildFactorRow(String factor, String percentage, Color color) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            factor,
            style: TextStyle(fontSize: 14),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            height: 8,
            decoration: BoxDecoration(
              color: disabledColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: double.parse(percentage.replaceAll('%', '')) / 100,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: spSm),
        Text(
          percentage,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildCompareTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Vehicle Comparison",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          if (vehicles.length < 2)
            Container(
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Center(
                child: Column(
                  spacing: spMd,
                  children: [
                    Icon(
                      Icons.compare,
                      size: 80,
                      color: disabledBoldColor,
                    ),
                    Text(
                      "Need at least 2 vehicles to compare",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Add more vehicles to your tracker to compare their depreciation rates",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    QButton(
                      label: "Add Vehicle",
                      size: bs.sm,
                      onPressed: _addVehicle,
                    ),
                  ],
                ),
              ),
            )
          else
            Container(
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
                    "Depreciation Comparison",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  // Comparison Table
                  Table(
                    columnWidths: {
                      0: FlexColumnWidth(3),
                      1: FlexColumnWidth(2),
                      2: FlexColumnWidth(2),
                      3: FlexColumnWidth(2),
                    },
                    children: [
                      TableRow(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                        ),
                        children: [
                          Padding(
                            padding: EdgeInsets.all(spSm),
                            child: Text(
                              "Vehicle",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(spSm),
                            child: Text(
                              "Total Loss",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(spSm),
                            child: Text(
                              "Annual Rate",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(spSm),
                            child: Text(
                              "Performance",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      ...vehicles.map((vehicle) {
                        double totalLoss = (vehicle["purchasePrice"] as double) - (vehicle["currentValue"] as double);
                        double depreciationPercent = (totalLoss / (vehicle["purchasePrice"] as double)) * 100;
                        DateTime purchaseDate = DateTime.parse(vehicle["purchaseDate"] as String);
                        double yearsOwned = DateTime.now().difference(purchaseDate).inDays / 365.25;
                        double annualRate = depreciationPercent / yearsOwned;
                        
                        return TableRow(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(spSm),
                              child: Text("${vehicle["year"]} ${vehicle["make"]} ${vehicle["model"]}"),
                            ),
                            Padding(
                              padding: EdgeInsets.all(spSm),
                              child: Text(
                                "\$${totalLoss.toStringAsFixed(0)}",
                                style: TextStyle(color: dangerColor),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(spSm),
                              child: Text(
                                "${annualRate.toStringAsFixed(1)}%",
                                style: TextStyle(color: warningColor),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(spSm),
                              child: Icon(
                                annualRate < 15 ? Icons.trending_up : Icons.trending_down,
                                color: annualRate < 15 ? successColor : dangerColor,
                                size: 20,
                              ),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ),

          // Market Comparison
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: infoColor),
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.info, color: infoColor),
                    SizedBox(width: spSm),
                    Text(
                      "Market Comparison",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "• Honda Civic: Performing 5% better than market average",
                  style: TextStyle(fontSize: 14, color: infoColor),
                ),
                Text(
                  "• Toyota Camry: Performing 8% better than market average",
                  style: TextStyle(fontSize: 14, color: infoColor),
                ),
                Text(
                  "• Market average depreciation: 15-20% annually",
                  style: TextStyle(fontSize: 14, color: infoColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  double _calculateAverageDepreciationRate() {
    if (vehicles.isEmpty) return 0.0;
    
    double totalRate = 0.0;
    for (var vehicle in vehicles) {
      double totalLoss = (vehicle["purchasePrice"] as double) - (vehicle["currentValue"] as double);
      double depreciationPercent = (totalLoss / (vehicle["purchasePrice"] as double)) * 100;
      DateTime purchaseDate = DateTime.parse(vehicle["purchaseDate"] as String);
      double yearsOwned = DateTime.now().difference(purchaseDate).inDays / 365.25;
      double annualRate = depreciationPercent / yearsOwned;
      totalRate += annualRate;
    }
    
    return totalRate / vehicles.length;
  }

  void _addVehicle() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Vehicle"),
        content: Text("Vehicle addition form would open here"),
        actions: [
          QButton(
            label: "Cancel",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
          QButton(
            label: "Add",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Vehicle added to depreciation tracker");
            },
          ),
        ],
      ),
    );
  }

  void _viewVehicleDetails(Map<String, dynamic> vehicle) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${vehicle["year"]} ${vehicle["make"]} ${vehicle["model"]}"),
        content: SingleChildScrollView(
          child: Column(
            spacing: spSm,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Purchase Date: ${vehicle["purchaseDate"]}"),
              Text("Purchase Price: \$${(vehicle["purchasePrice"] as double).toStringAsFixed(2)}"),
              Text("Current Value: \$${(vehicle["currentValue"] as double).toStringAsFixed(2)}"),
              Text("Total Depreciation: \$${((vehicle["purchasePrice"] as double) - (vehicle["currentValue"] as double)).toStringAsFixed(2)}"),
            ],
          ),
        ),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _showDepreciationChart(Map<String, dynamic> vehicle) {
    si("Opening depreciation chart for ${vehicle["year"]} ${vehicle["make"]} ${vehicle["model"]}");
  }

  void _showVehicleOptions(Map<String, dynamic> vehicle) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Vehicle Options"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.edit),
              title: Text("Edit Vehicle"),
              onTap: () {
                Navigator.pop(context);
                si("Edit vehicle functionality");
              },
            ),
            ListTile(
              leading: Icon(Icons.update),
              title: Text("Update Value"),
              onTap: () {
                Navigator.pop(context);
                si("Update vehicle value");
              },
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text("Remove Vehicle"),
              onTap: () async {
                Navigator.pop(context);
                bool isConfirmed = await confirm("Remove this vehicle from tracking?");
                if (isConfirmed) {
                  vehicles.removeWhere((v) => v["id"] == vehicle["id"]);
                  setState(() {});
                  se("Vehicle removed from tracking");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
