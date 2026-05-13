import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlGraph6View extends StatefulWidget {
  @override
  State<GrlGraph6View> createState() => _GrlGraph6ViewState();
}

class _GrlGraph6ViewState extends State<GrlGraph6View> {
  List<Map<String, dynamic>> energyData = [
    {"hour": "00", "solar": 0, "wind": 15, "hydro": 45, "nuclear": 85},
    {"hour": "04", "solar": 0, "wind": 22, "hydro": 48, "nuclear": 85},
    {"hour": "08", "solar": 35, "wind": 18, "hydro": 52, "nuclear": 85},
    {"hour": "12", "solar": 95, "wind": 12, "hydro": 45, "nuclear": 85},
    {"hour": "16", "solar": 78, "wind": 28, "hydro": 42, "nuclear": 85},
    {"hour": "20", "solar": 25, "wind": 35, "hydro": 48, "nuclear": 85},
  ];

  List<Map<String, dynamic>> consumptionData = [
    {"region": "North", "consumption": 245, "efficiency": 87, "renewable": 65},
    {"region": "South", "consumption": 312, "efficiency": 92, "renewable": 78},
    {"region": "East", "consumption": 198, "efficiency": 83, "renewable": 55},
    {"region": "West", "consumption": 267, "efficiency": 89, "renewable": 82},
    {"region": "Central", "consumption": 423, "efficiency": 94, "renewable": 73},
  ];

  List<Map<String, dynamic>> sustainabilityMetrics = [
    {"metric": "Carbon Footprint", "value": 2.4, "unit": "tons CO₂", "target": 2.0, "color": dangerColor},
    {"metric": "Renewable Energy", "value": 72, "unit": "%", "target": 80, "color": successColor},
    {"metric": "Energy Efficiency", "value": 89, "unit": "%", "target": 85, "color": primaryColor},
    {"metric": "Waste Reduction", "value": 64, "unit": "%", "target": 70, "color": warningColor},
  ];

  int selectedTimeframe = 0;
  String selectedRegion = "All";
  bool showProjections = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Energy & Sustainability Dashboard"),
        actions: [
          IconButton(
            icon: Icon(Icons.eco),
            onPressed: () {
              // Show sustainability tips
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Open settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildControlPanel(),
            _buildEnergyOverview(),
            _buildEnergyMixChart(),
            _buildRegionalConsumption(),
            _buildSustainabilityMetrics(),
            _buildEfficiencyTrends(),
            _buildActionCenter(),
          ],
        ),
      ),
    );
  }

  Widget _buildControlPanel() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.tune,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Dashboard Controls",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
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
                      "Time Period",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    QDropdownField(
                      items: [
                        {"label": "Today", "value": 0},
                        {"label": "This Week", "value": 1},
                        {"label": "This Month", "value": 2},
                      ],
                      value: selectedTimeframe,
                      onChanged: (value, label) {
                        selectedTimeframe = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Region Filter",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    QDropdownField(
                      items: [
                        {"label": "All Regions", "value": "All"},
                        {"label": "North", "value": "North"},
                        {"label": "South", "value": "South"},
                        {"label": "East", "value": "East"},
                        {"label": "West", "value": "West"},
                        {"label": "Central", "value": "Central"},
                      ],
                      value: selectedRegion,
                      onChanged: (value, label) {
                        selectedRegion = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Show Projections",
                      "value": true,
                      "checked": showProjections,
                    }
                  ],
                  value: [if (showProjections) {"label": "Show Projections", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    showProjections = values.isNotEmpty;
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

  Widget _buildEnergyOverview() {
    double totalProduction = 237.5;
    double totalConsumption = 289.2;
    double efficiency = 82.1;
    double renewablePercentage = 71.4;

    return Row(
      children: [
        Expanded(
          child: _buildOverviewCard(
            "Total Production",
            "${totalProduction.toStringAsFixed(1)} MW",
            Icons.flash_on,
            successColor,
            "+5.2%",
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildOverviewCard(
            "Consumption",
            "${totalConsumption.toStringAsFixed(1)} MW",
            Icons.power,
            primaryColor,
            "+2.8%",
          ),
        ),
      ],
    );
  }

  Widget _buildOverviewCard(String title, String value, IconData icon, Color color, String change) {
    return Container(
      padding: EdgeInsets.all(spSm),
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
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 16,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  change,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: successColor,
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
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnergyMixChart() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
              Icon(
                Icons.pie_chart,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Energy Mix - 24 Hour Profile",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              _buildLegendItem("Solar", warningColor),
              SizedBox(width: spSm),
              _buildLegendItem("Wind", infoColor),
              SizedBox(width: spSm),
              _buildLegendItem("Hydro", successColor),
              SizedBox(width: spSm),
              _buildLegendItem("Nuclear", primaryColor),
            ],
          ),
          SizedBox(height: spMd),
          Container(
            height: 220,
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: energyData.map((data) {
                      double solarHeight = ((data["solar"] as int) / 95) * 160;
                      double windHeight = ((data["wind"] as int) / 95) * 160;
                      double hydroHeight = ((data["hydro"] as int) / 95) * 160;
                      double nuclearHeight = ((data["nuclear"] as int) / 95) * 160;
                      
                      return Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 2),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: nuclearHeight,
                                    decoration: BoxDecoration(
                                      color: primaryColor.withAlpha(200),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: hydroHeight,
                                    decoration: BoxDecoration(
                                      color: successColor.withAlpha(200),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: windHeight,
                                    decoration: BoxDecoration(
                                      color: infoColor.withAlpha(200),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: solarHeight,
                                    decoration: BoxDecoration(
                                      color: warningColor.withAlpha(200),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${data["hour"]}:00",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
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
        SizedBox(width: 4),
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

  Widget _buildRegionalConsumption() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
              Icon(
                Icons.location_on,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Regional Consumption",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Column(
            children: consumptionData.map((region) {
              double efficiencyPercent = (region["efficiency"] as int) / 100;
              double renewablePercent = (region["renewable"] as int) / 100;
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Center(
                            child: Text(
                              "${region["region"]}".substring(0, 1),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${region["region"]} Region",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${region["consumption"]} MW consumed",
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
                            Row(
                              children: [
                                Icon(
                                  Icons.eco,
                                  color: successColor,
                                  size: 16,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${region["renewable"]}%",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.speed,
                                  color: primaryColor,
                                  size: 16,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${region["efficiency"]}%",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Efficiency",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: 4),
                              Container(
                                height: 6,
                                decoration: BoxDecoration(
                                  color: disabledColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: FractionallySizedBox(
                                  alignment: Alignment.centerLeft,
                                  widthFactor: efficiencyPercent,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Renewable",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: 4),
                              Container(
                                height: 6,
                                decoration: BoxDecoration(
                                  color: disabledColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: FractionallySizedBox(
                                  alignment: Alignment.centerLeft,
                                  widthFactor: renewablePercent,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: successColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                  ),
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
          ),
        ],
      ),
    );
  }

  Widget _buildSustainabilityMetrics() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
              Icon(
                Icons.eco_outlined,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Sustainability Metrics",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: sustainabilityMetrics.map((metric) {
              double progress = (metric["value"] as num) / (metric["target"] as num);
              bool isOnTarget = progress >= 1.0;
              
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: isOnTarget ? successColor.withAlpha(100) : warningColor.withAlpha(100),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: (metric["color"] as Color).withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(
                            isOnTarget ? Icons.check : Icons.trending_up,
                            color: metric["color"] as Color,
                            size: 16,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          isOnTarget ? Icons.check_circle : Icons.warning,
                          color: isOnTarget ? successColor : warningColor,
                          size: 16,
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${metric["value"]} ${metric["unit"]}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${metric["metric"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Text(
                          "Target: ${metric["target"]} ${metric["unit"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Container(
                      height: 4,
                      decoration: BoxDecoration(
                        color: disabledColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: progress > 1 ? 1 : progress,
                        child: Container(
                          decoration: BoxDecoration(
                            color: isOnTarget ? successColor : warningColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildEfficiencyTrends() {
    List<Map<String, dynamic>> trends = [
      {"month": "Jan", "efficiency": 82, "renewable": 64},
      {"month": "Feb", "efficiency": 84, "renewable": 67},
      {"month": "Mar", "efficiency": 86, "renewable": 69},
      {"month": "Apr", "efficiency": 88, "renewable": 72},
      {"month": "May", "efficiency": 87, "renewable": 71},
      {"month": "Jun", "efficiency": 89, "renewable": 74},
    ];

    return Container(
      padding: EdgeInsets.all(spSm),
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
              Icon(
                Icons.trending_up,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Efficiency Trends",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Row(
                children: [
                  _buildLegendItem("Efficiency", primaryColor),
                  SizedBox(width: spSm),
                  _buildLegendItem("Renewable", successColor),
                ],
              ),
            ],
          ),
          SizedBox(height: spMd),
          Container(
            height: 150,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: trends.map((trend) {
                double efficiencyHeight = ((trend["efficiency"] as int) / 100) * 120;
                double renewableHeight = ((trend["renewable"] as int) / 100) * 120;
                
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: efficiencyHeight,
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(200),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                              ),
                            ),
                            SizedBox(width: 2),
                            Expanded(
                              child: Container(
                                height: renewableHeight,
                                decoration: BoxDecoration(
                                  color: successColor.withAlpha(200),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${trend["month"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCenter() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
              Icon(
                Icons.psychology,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Action Center",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Optimize Grid",
                  icon: Icons.grid_on,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Generate Report",
                  icon: Icons.description,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Set Alerts",
                  icon: Icons.notifications_active,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Export Data",
                  icon: Icons.download,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
