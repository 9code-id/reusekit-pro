import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmSalesForecastingView extends StatefulWidget {
  const CrmSalesForecastingView({super.key});

  @override
  State<CrmSalesForecastingView> createState() => _CrmSalesForecastingViewState();
}

class _CrmSalesForecastingViewState extends State<CrmSalesForecastingView> {
  String selectedPeriod = "quarterly";
  String selectedTeam = "all";
  String selectedRegion = "all";
  bool loading = false;
  int currentTab = 0;

  List<Map<String, dynamic>> periodItems = [
    {"label": "Monthly", "value": "monthly"},
    {"label": "Quarterly", "value": "quarterly"},
    {"label": "Yearly", "value": "yearly"},
  ];

  List<Map<String, dynamic>> teamItems = [
    {"label": "All Teams", "value": "all"},
    {"label": "Sales Team A", "value": "team_a"},
    {"label": "Sales Team B", "value": "team_b"},
    {"label": "Enterprise Team", "value": "enterprise"},
    {"label": "SMB Team", "value": "smb"},
  ];

  List<Map<String, dynamic>> regionItems = [
    {"label": "All Regions", "value": "all"},
    {"label": "North America", "value": "na"},
    {"label": "Europe", "value": "eu"},
    {"label": "Asia Pacific", "value": "apac"},
    {"label": "Latin America", "value": "latam"},
  ];

  Map<String, dynamic> forecastData = {
    "currentQuarter": {
      "target": 2500000.0,
      "forecasted": 2650000.0,
      "actual": 1850000.0,
      "confidence": 85,
      "probability": 92,
    },
    "nextQuarter": {
      "target": 2800000.0,
      "forecasted": 2950000.0,
      "actual": 0.0,
      "confidence": 78,
      "probability": 88,
    },
    "pipeline": {
      "total": 4500000.0,
      "weighted": 2800000.0,
      "bestCase": 3200000.0,
      "worstCase": 1900000.0,
    }
  };

  List<Map<String, dynamic>> monthlyData = [
    {"month": "Jan", "target": 800000.0, "forecasted": 850000.0, "actual": 820000.0, "confidence": 92},
    {"month": "Feb", "target": 850000.0, "forecasted": 880000.0, "actual": 865000.0, "confidence": 90},
    {"month": "Mar", "target": 900000.0, "forecasted": 920000.0, "actual": 885000.0, "confidence": 88},
    {"month": "Apr", "target": 950000.0, "forecasted": 980000.0, "actual": 945000.0, "confidence": 89},
    {"month": "May", "target": 1000000.0, "forecasted": 1050000.0, "actual": 1020000.0, "confidence": 91},
    {"month": "Jun", "target": 1100000.0, "forecasted": 1150000.0, "actual": 0.0, "confidence": 85},
    {"month": "Jul", "target": 1200000.0, "forecasted": 1250000.0, "actual": 0.0, "confidence": 82},
    {"month": "Aug", "target": 1300000.0, "forecasted": 1350000.0, "actual": 0.0, "confidence": 80},
    {"month": "Sep", "target": 1400000.0, "forecasted": 1450000.0, "actual": 0.0, "confidence": 78},
    {"month": "Oct", "target": 1500000.0, "forecasted": 1550000.0, "actual": 0.0, "confidence": 75},
    {"month": "Nov", "target": 1600000.0, "forecasted": 1650000.0, "actual": 0.0, "confidence": 73},
    {"month": "Dec", "target": 1700000.0, "forecasted": 1750000.0, "actual": 0.0, "confidence": 70},
  ];

  List<Map<String, dynamic>> salesRepData = [
    {
      "name": "John Smith",
      "team": "Enterprise",
      "region": "North America",
      "target": 500000.0,
      "forecasted": 520000.0,
      "actual": 380000.0,
      "confidence": 88,
      "deals": 12,
      "pipelineValue": 750000.0,
      "conversionRate": 0.65,
      "averageDealSize": 45000.0,
    },
    {
      "name": "Sarah Johnson",
      "team": "SMB",
      "region": "North America",
      "target": 350000.0,
      "forecasted": 365000.0,
      "actual": 290000.0,
      "confidence": 91,
      "deals": 28,
      "pipelineValue": 420000.0,
      "conversionRate": 0.72,
      "averageDealSize": 15000.0,
    },
    {
      "name": "Mike Wilson",
      "team": "Enterprise",
      "region": "Europe",
      "target": 450000.0,
      "forecasted": 470000.0,
      "actual": 325000.0,
      "confidence": 85,
      "deals": 8,
      "pipelineValue": 680000.0,
      "conversionRate": 0.58,
      "averageDealSize": 52000.0,
    },
    {
      "name": "Emma Davis",
      "team": "SMB",
      "region": "Asia Pacific",
      "target": 300000.0,
      "forecasted": 315000.0,
      "actual": 245000.0,
      "confidence": 89,
      "deals": 22,
      "pipelineValue": 380000.0,
      "conversionRate": 0.68,
      "averageDealSize": 18000.0,
    },
    {
      "name": "David Brown",
      "team": "Enterprise",
      "region": "Latin America",
      "target": 400000.0,
      "forecasted": 420000.0,
      "actual": 310000.0,
      "confidence": 82,
      "deals": 9,
      "pipelineValue": 590000.0,
      "conversionRate": 0.62,
      "averageDealSize": 48000.0,
    },
  ];

  List<Map<String, dynamic>> get filteredSalesReps {
    return salesRepData.where((rep) {
      final matchesTeam = selectedTeam == "all" || rep["team"].toString().toLowerCase().contains(selectedTeam.replaceAll("_", " "));
      final matchesRegion = selectedRegion == "all" || rep["region"].toString().toLowerCase().contains(_getRegionLabel(selectedRegion).toLowerCase());
      return matchesTeam && matchesRegion;
    }).toList();
  }

  String _getRegionLabel(String region) {
    switch (region) {
      case "na": return "North America";
      case "eu": return "Europe";
      case "apac": return "Asia Pacific";
      case "latam": return "Latin America";
      default: return region;
    }
  }

  String _getConfidenceColor(double confidence) {
    if (confidence >= 85) return "success";
    if (confidence >= 70) return "warning";
    return "danger";
  }

  void _updateFilters() {
    setState(() {});
  }

  void _refreshForecast() async {
    loading = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 2));
    
    loading = false;
    setState(() {});
    
    ss("Forecast data refreshed successfully");
  }

  void _exportForecast() {
    si("Exporting forecast to Excel...");
  }

  void _createForecastModel() {
    showDialog(
      context: context,
      builder: (context) => _buildCreateModelDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sales Forecasting"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refreshForecast,
          ),
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: _createForecastModel,
                child: ListTile(
                  leading: Icon(Icons.model_training),
                  title: Text("Create Model"),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              PopupMenuItem(
                onTap: _exportForecast,
                child: ListTile(
                  leading: Icon(Icons.download),
                  title: Text("Export"),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ],
      ),
      body: loading ? 
        Center(child: CircularProgressIndicator()) : 
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              _buildFiltersSection(),
              _buildOverviewCards(),
              _buildForecastChart(),
              _buildQuarterlyComparison(),
              _buildPipelineAnalysis(),
              _buildSalesRepPerformance(),
            ],
          ),
        ),
    );
  }

  Widget _buildFiltersSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Period",
                  items: periodItems,
                  value: selectedPeriod,
                  onChanged: (value, label) {
                    selectedPeriod = value;
                    _updateFilters();
                  },
                ),
              ),
              Expanded(
                child: QDropdownField(
                  label: "Team",
                  items: teamItems,
                  value: selectedTeam,
                  onChanged: (value, label) {
                    selectedTeam = value;
                    _updateFilters();
                  },
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Region",
            items: regionItems,
            value: selectedRegion,
            onChanged: (value, label) {
              selectedRegion = value;
              _updateFilters();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCards() {
    final currentQuarter = forecastData["currentQuarter"];
    final nextQuarter = forecastData["nextQuarter"];
    final pipeline = forecastData["pipeline"];

    return Column(
      spacing: spSm,
      children: [
        Row(
          spacing: spSm,
          children: [
            Expanded(
              child: _buildOverviewCard(
                "Current Quarter",
                "\$${((currentQuarter["forecasted"] as double) / 1000000).toStringAsFixed(1)}M",
                "vs \$${((currentQuarter["target"] as double) / 1000000).toStringAsFixed(1)}M target",
                Icons.trending_up,
                (currentQuarter["forecasted"] as double) > (currentQuarter["target"] as double) ? successColor : warningColor,
                "${currentQuarter["confidence"]}% confidence",
              ),
            ),
            Expanded(
              child: _buildOverviewCard(
                "Next Quarter",
                "\$${((nextQuarter["forecasted"] as double) / 1000000).toStringAsFixed(1)}M",
                "vs \$${((nextQuarter["target"] as double) / 1000000).toStringAsFixed(1)}M target",
                Icons.rocket_launch,
                (nextQuarter["forecasted"] as double) > (nextQuarter["target"] as double) ? successColor : warningColor,
                "${nextQuarter["confidence"]}% confidence",
              ),
            ),
          ],
        ),
        Row(
          spacing: spSm,
          children: [
            Expanded(
              child: _buildOverviewCard(
                "Pipeline Value",
                "\$${((pipeline["weighted"] as double) / 1000000).toStringAsFixed(1)}M",
                "of \$${((pipeline["total"] as double) / 1000000).toStringAsFixed(1)}M total",
                Icons.filter_list,
                primaryColor,
                "Weighted pipeline",
              ),
            ),
            Expanded(
              child: _buildOverviewCard(
                "Best Case",
                "\$${((pipeline["bestCase"] as double) / 1000000).toStringAsFixed(1)}M",
                "Worst: \$${((pipeline["worstCase"] as double) / 1000000).toStringAsFixed(1)}M",
                Icons.analytics,
                successColor,
                "Scenario planning",
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOverviewCard(String title, String value, String subtitle, IconData icon, Color color, String footer) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spXs,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: spXs,
            children: [
              Icon(icon, color: color, size: 20),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              footer,
              style: TextStyle(
                fontSize: 10,
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForecastChart() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Monthly Forecast Trend",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "High Accuracy",
                  style: TextStyle(
                    fontSize: 10,
                    color: successColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 200,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: spXs,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: monthlyData.map((data) {
                  final isActual = (data["actual"] as double) > 0;
                  final maxValue = monthlyData.map((d) => (d["forecasted"] as double)).reduce((a, b) => a > b ? a : b);
                  final targetHeight = ((data["target"] as double) / maxValue) * 160;
                  final forecastedHeight = ((data["forecasted"] as double) / maxValue) * 160;
                  final actualHeight = isActual ? ((data["actual"] as double) / maxValue) * 160 : 0.0;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    spacing: spXs,
                    children: [
                      SizedBox(
                        height: 160,
                        width: 60,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            // Target bar
                            Positioned(
                              bottom: 0,
                              child: Container(
                                width: 15,
                                height: targetHeight,
                                decoration: BoxDecoration(
                                  color: disabledColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                              ),
                            ),
                            // Forecasted bar
                            Positioned(
                              bottom: 0,
                              left: 20,
                              child: Container(
                                width: 15,
                                height: forecastedHeight,
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                              ),
                            ),
                            // Actual bar
                            if (isActual)
                              Positioned(
                                bottom: 0,
                                right: 5,
                                child: Container(
                                  width: 15,
                                  height: actualHeight,
                                  decoration: BoxDecoration(
                                    color: successColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      Text(
                        "${data["month"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                        decoration: BoxDecoration(
                          color: _getConfidenceColor((data["confidence"] as num).toDouble()) == "success" ? successColor.withAlpha(20) :
                                _getConfidenceColor((data["confidence"] as num).toDouble()) == "warning" ? warningColor.withAlpha(20) :
                                dangerColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${data["confidence"]}%",
                          style: TextStyle(
                            fontSize: 8,
                            color: _getConfidenceColor((data["confidence"] as num).toDouble()) == "success" ? successColor :
                                   _getConfidenceColor((data["confidence"] as num).toDouble()) == "warning" ? warningColor :
                                   dangerColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
          Row(
            spacing: spMd,
            children: [
              _buildLegendItem("Target", disabledColor),
              _buildLegendItem("Forecasted", primaryColor),
              _buildLegendItem("Actual", successColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      spacing: spXs,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radiusXs),
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildQuarterlyComparison() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Quarterly Performance",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: _buildQuarterCard(
                  "Q1 2024",
                  2200000.0,
                  2050000.0,
                  2100000.0,
                  95,
                  true,
                ),
              ),
              Expanded(
                child: _buildQuarterCard(
                  "Q2 2024",
                  2500000.0,
                  1850000.0,
                  2650000.0,
                  85,
                  false,
                ),
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: _buildQuarterCard(
                  "Q3 2024",
                  2800000.0,
                  0.0,
                  2950000.0,
                  78,
                  false,
                ),
              ),
              Expanded(
                child: _buildQuarterCard(
                  "Q4 2024",
                  3000000.0,
                  0.0,
                  3200000.0,
                  72,
                  false,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuarterCard(String quarter, double target, double actual, double forecasted, int confidence, bool isCompleted) {
    final achievement = isCompleted ? (actual / target) * 100 : 0.0;
    final forecastVsTarget = (forecasted / target) * 100;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: isCompleted ? successColor.withAlpha(10) : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(radiusXs),
        border: Border.all(
          color: isCompleted ? successColor.withAlpha(50) : disabledOutlineBorderColor,
        ),
      ),
      child: Column(
        spacing: spXs,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                quarter,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              if (isCompleted)
                Icon(Icons.check_circle, size: 16, color: successColor)
              else
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
                  decoration: BoxDecoration(
                    color: _getConfidenceColor(confidence.toDouble()) == "success" ? successColor.withAlpha(20) :
                           _getConfidenceColor(confidence.toDouble()) == "warning" ? warningColor.withAlpha(20) :
                           dangerColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "$confidence%",
                    style: TextStyle(
                      fontSize: 10,
                      color: _getConfidenceColor(confidence.toDouble()) == "success" ? successColor :
                             _getConfidenceColor(confidence.toDouble()) == "warning" ? warningColor :
                             dangerColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          Text(
            "Target: \$${(target / 1000000).toStringAsFixed(1)}M",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          if (isCompleted) ...[
            Text(
              "Actual: \$${(actual / 1000000).toStringAsFixed(1)}M",
              style: TextStyle(
                fontSize: 12,
                color: achievement >= 100 ? successColor : warningColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "Achievement: ${achievement.toStringAsFixed(1)}%",
              style: TextStyle(
                fontSize: 11,
                color: achievement >= 100 ? successColor : warningColor,
              ),
            ),
          ] else ...[
            Text(
              "Forecast: \$${(forecasted / 1000000).toStringAsFixed(1)}M",
              style: TextStyle(
                fontSize: 12,
                color: forecastVsTarget >= 100 ? successColor : warningColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "vs Target: ${forecastVsTarget.toStringAsFixed(1)}%",
              style: TextStyle(
                fontSize: 11,
                color: forecastVsTarget >= 100 ? successColor : warningColor,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPipelineAnalysis() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Pipeline Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: _buildPipelineMetric(
                  "Total Pipeline",
                  "\$${((forecastData["pipeline"]["total"] as double) / 1000000).toStringAsFixed(1)}M",
                  Icons.filter_list,
                  primaryColor,
                ),
              ),
              Expanded(
                child: _buildPipelineMetric(
                  "Weighted Value",
                  "\$${((forecastData["pipeline"]["weighted"] as double) / 1000000).toStringAsFixed(1)}M",
                  Icons.balance,
                  successColor,
                ),
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: _buildPipelineMetric(
                  "Best Case",
                  "\$${((forecastData["pipeline"]["bestCase"] as double) / 1000000).toStringAsFixed(1)}M",
                  Icons.trending_up,
                  successColor,
                ),
              ),
              Expanded(
                child: _buildPipelineMetric(
                  "Worst Case",
                  "\$${((forecastData["pipeline"]["worstCase"] as double) / 1000000).toStringAsFixed(1)}M",
                  Icons.trending_down,
                  dangerColor,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Row(
              children: [
                Icon(Icons.lightbulb, color: warningColor, size: 16),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "Pipeline weighted at 62% probability based on historical conversion rates",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
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

  Widget _buildPipelineMetric(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusXs),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Icon(icon, color: color, size: 20),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSalesRepPerformance() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Sales Rep Performance",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...filteredSalesReps.map((rep) => _buildSalesRepCard(rep)),
        ],
      ),
    );
  }

  Widget _buildSalesRepCard(Map<String, dynamic> rep) {
    final achievement = ((rep["actual"] as double) / (rep["target"] as double)) * 100;
    final forecastVsTarget = ((rep["forecasted"] as double) / (rep["target"] as double)) * 100;

    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: primaryColor.withAlpha(20),
                child: Text(
                  "${rep["name"]}".split(' ').map((n) => n[0]).join(''),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "${rep["name"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${rep["team"]} • ${rep["region"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: _getConfidenceColor((rep["confidence"] as num).toDouble()) == "success" ? successColor.withAlpha(20) :
                         _getConfidenceColor((rep["confidence"] as num).toDouble()) == "warning" ? warningColor.withAlpha(20) :
                         dangerColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${rep["confidence"]}%",
                  style: TextStyle(
                    fontSize: 10,
                    color: _getConfidenceColor((rep["confidence"] as num).toDouble()) == "success" ? successColor :
                           _getConfidenceColor((rep["confidence"] as num).toDouble()) == "warning" ? warningColor :
                           dangerColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "Target: \$${((rep["target"] as double) / 1000).toStringAsFixed(0)}K",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                    Text(
                      "Actual: \$${((rep["actual"] as double) / 1000).toStringAsFixed(0)}K",
                      style: TextStyle(
                        fontSize: 12,
                        color: achievement >= 100 ? successColor : warningColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "Forecast: \$${((rep["forecasted"] as double) / 1000).toStringAsFixed(0)}K",
                      style: TextStyle(
                        fontSize: 12,
                        color: forecastVsTarget >= 100 ? successColor : primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Pipeline: \$${((rep["pipelineValue"] as double) / 1000).toStringAsFixed(0)}K",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "${rep["deals"]} deals",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                    Text(
                      "${((rep["conversionRate"] as double) * 100).toStringAsFixed(0)}% conv.",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
          LinearProgressIndicator(
            value: achievement / 100,
            backgroundColor: disabledColor,
            valueColor: AlwaysStoppedAnimation<Color>(
              achievement >= 100 ? successColor : 
              achievement >= 75 ? warningColor : dangerColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreateModelDialog() {
    String modelName = "";
    String modelType = "linear";
    List<String> selectedFactors = ["historical_data"];

    List<Map<String, dynamic>> modelTypeItems = [
      {"label": "Linear Regression", "value": "linear"},
      {"label": "Time Series", "value": "time_series"},
      {"label": "Machine Learning", "value": "ml"},
      {"label": "Weighted Pipeline", "value": "weighted"},
    ];

    List<Map<String, dynamic>> factorItems = [
      {"label": "Historical Data", "value": "historical_data", "checked": true},
      {"label": "Seasonality", "value": "seasonality", "checked": false},
      {"label": "Market Trends", "value": "market_trends", "checked": false},
      {"label": "Lead Sources", "value": "lead_sources", "checked": false},
      {"label": "Economic Indicators", "value": "economic", "checked": false},
    ];

    return StatefulBuilder(
      builder: (context, setDialogState) {
        return AlertDialog(
          title: Text("Create Forecast Model"),
          content: SingleChildScrollView(
            child: Column(
              spacing: spSm,
              children: [
                QTextField(
                  label: "Model Name",
                  value: modelName,
                  onChanged: (value) => modelName = value,
                ),
                QDropdownField(
                  label: "Model Type",
                  items: modelTypeItems,
                  value: modelType,
                  onChanged: (value, label) {
                    modelType = value;
                    setDialogState(() {});
                  },
                ),
                QSwitch(
                  label: "Factors to Include",
                  items: factorItems,
                  value: factorItems.where((item) => item["checked"] == true).toList(),
                  onChanged: (values, ids) {
                    for (var item in factorItems) {
                      item["checked"] = values.any((v) => v["value"] == item["value"]);
                    }
                    setDialogState(() {});
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            QButton(
              label: "Create Model",
              onPressed: () {
                if (modelName.isNotEmpty) {
                  Navigator.pop(context);
                  showLoading();
                  Future.delayed(Duration(seconds: 3), () {
                    hideLoading();
                    ss("Forecast model '$modelName' created successfully");
                  });
                }
              },
            ),
          ],
        );
      },
    );
  }
}
