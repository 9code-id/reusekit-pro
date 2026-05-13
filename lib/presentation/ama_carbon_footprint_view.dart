import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaCarbonFootprintView extends StatefulWidget {
  const AmaCarbonFootprintView({super.key});

  @override
  State<AmaCarbonFootprintView> createState() => _AmaCarbonFootprintViewState();
}

class _AmaCarbonFootprintViewState extends State<AmaCarbonFootprintView> {
  int selectedPeriod = 0;
  
  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Month", "value": 0},
    {"label": "Last 3 Months", "value": 1},
    {"label": "This Year", "value": 2},
    {"label": "All Time", "value": 3},
  ];
  
  Map<String, dynamic> carbonData = {
    "totalEmissions": 45.8,
    "monthlyTarget": 40.0,
    "yearlyTarget": 480.0,
    "reduction": -12.5,
    "offsetCredits": 15.2,
    "netEmissions": 30.6,
  };
  
  List<Map<String, dynamic>> emissionSources = [
    {
      "category": "Fuel & Energy",
      "emissions": 18.4,
      "percentage": 40.2,
      "trend": -8.5,
      "color": dangerColor,
      "icon": Icons.local_gas_station,
      "details": [
        {"source": "Diesel Tractors", "amount": 12.1},
        {"source": "Irrigation Pumps", "amount": 4.3},
        {"source": "Facility Electricity", "amount": 2.0},
      ],
    },
    {
      "category": "Fertilizers & Chemicals",
      "emissions": 12.7,
      "percentage": 27.7,
      "trend": -15.2,
      "color": warningColor,
      "icon": Icons.science,
      "details": [
        {"source": "Nitrogen Fertilizers", "amount": 8.4},
        {"source": "Pesticides", "amount": 2.8},
        {"source": "Soil Amendments", "amount": 1.5},
      ],
    },
    {
      "category": "Transportation",
      "emissions": 8.9,
      "percentage": 19.4,
      "trend": -5.8,
      "color": infoColor,
      "icon": Icons.local_shipping,
      "details": [
        {"source": "Product Distribution", "amount": 5.2},
        {"source": "Supply Deliveries", "amount": 2.4},
        {"source": "Staff Commuting", "amount": 1.3},
      ],
    },
    {
      "category": "Waste Management",
      "emissions": 5.8,
      "percentage": 12.7,
      "trend": -22.1,
      "color": successColor,
      "icon": Icons.delete,
      "details": [
        {"source": "Organic Waste", "amount": 3.1},
        {"source": "Packaging Materials", "amount": 1.8},
        {"source": "Chemical Containers", "amount": 0.9},
      ],
    },
  ];
  
  List<Map<String, dynamic>> reductionStrategies = [
    {
      "title": "Renewable Energy Transition",
      "description": "Switch to solar-powered irrigation and facility operations",
      "potentialReduction": 8.2,
      "implementationCost": "High",
      "timeframe": "6 months",
      "status": "In Progress",
      "progress": 35,
      "icon": Icons.solar_power,
      "color": warningColor,
    },
    {
      "title": "Precision Agriculture",
      "description": "Use GPS-guided equipment and variable rate application",
      "potentialReduction": 5.4,
      "implementationCost": "Medium",
      "timeframe": "3 months",
      "status": "Completed",
      "progress": 100,
      "icon": Icons.gps_fixed,
      "color": successColor,
    },
    {
      "title": "Cover Crop Program",
      "description": "Plant cover crops to sequester carbon and improve soil health",
      "potentialReduction": 12.1,
      "implementationCost": "Low",
      "timeframe": "1 season",
      "status": "Active",
      "progress": 78,
      "icon": Icons.grass,
      "color": primaryColor,
    },
    {
      "title": "Composting System",
      "description": "Convert organic waste into compost to reduce methane emissions",
      "potentialReduction": 3.7,
      "implementationCost": "Medium",
      "timeframe": "2 months",
      "status": "Planning",
      "progress": 15,
      "icon": Icons.compost,
      "color": infoColor,
    },
  ];
  
  List<Map<String, dynamic>> monthlyData = [
    {"month": "Jan", "emissions": 52.3, "target": 50.0},
    {"month": "Feb", "emissions": 48.7, "target": 48.0},
    {"month": "Mar", "emissions": 46.2, "target": 46.0},
    {"month": "Apr", "emissions": 44.8, "target": 44.0},
    {"month": "May", "emissions": 43.1, "target": 42.0},
    {"month": "Jun", "emissions": 45.8, "target": 40.0},
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "Completed":
        return successColor;
      case "Active":
      case "In Progress":
        return primaryColor;
      case "Planning":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getCostColor(String cost) {
    switch (cost) {
      case "Low":
        return successColor;
      case "Medium":
        return warningColor;
      case "High":
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carbon Footprint"),
        actions: [
          QButton(
            icon: Icons.download,
            size: bs.sm,
            onPressed: () {},
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Carbon Overview
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [dangerColor, warningColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.eco,
                    size: 48,
                    color: Colors.white,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Carbon Footprint Tracking",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Monitor and reduce your farm's environmental impact",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${(carbonData["totalEmissions"] as double).toStringAsFixed(1)}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "tons CO₂ this month",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.trending_down,
                                  size: 16,
                                  color: Colors.white,
                                ),
                                Text(
                                  "${(carbonData["reduction"] as double).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "vs last month",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
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
            
            // Period Filter
            QCategoryPicker(
              items: periodOptions,
              value: selectedPeriod,
              onChanged: (index, label, value, item) {
                selectedPeriod = value as int;
                setState(() {});
              },
            ),
            
            // Key Metrics
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                Container(
                  padding: EdgeInsets.all(spMd),
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
                          Icon(
                            Icons.gps_fixed,
                            size: 24,
                            color: primaryColor,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Monthly Target",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${(carbonData["monthlyTarget"] as double).toStringAsFixed(1)} tons CO₂",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      LinearProgressIndicator(
                        value: ((carbonData["totalEmissions"] as double) / (carbonData["monthlyTarget"] as double)).clamp(0.0, 1.0),
                        backgroundColor: disabledOutlineBorderColor,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          (carbonData["totalEmissions"] as double) > (carbonData["monthlyTarget"] as double) 
                            ? dangerColor : successColor
                        ),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Current: ${(carbonData["totalEmissions"] as double).toStringAsFixed(1)} tons",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                
                Container(
                  padding: EdgeInsets.all(spMd),
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
                          Icon(
                            Icons.nature,
                            size: 24,
                            color: successColor,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Carbon Offsets",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${(carbonData["offsetCredits"] as double).toStringAsFixed(1)} tons CO₂",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Net Emissions:",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${(carbonData["netEmissions"] as double).toStringAsFixed(1)} tons CO₂",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            // Emission Sources
            Text(
              "Emission Sources",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            ...List.generate(emissionSources.length, (index) {
              final source = emissionSources[index];
              return Container(
                padding: EdgeInsets.all(spMd),
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
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: (source["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            source["icon"] as IconData,
                            size: 24,
                            color: source["color"] as Color,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${source["category"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${(source["percentage"] as double).toStringAsFixed(1)}% of total emissions",
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
                              "${(source["emissions"] as double).toStringAsFixed(1)} tons",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: source["color"] as Color,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.trending_down,
                                  size: 12,
                                  color: successColor,
                                ),
                                Text(
                                  "${(source["trend"] as double).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    
                    LinearProgressIndicator(
                      value: (source["percentage"] as double) / 100,
                      backgroundColor: disabledOutlineBorderColor,
                      valueColor: AlwaysStoppedAnimation<Color>(source["color"] as Color),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    
                    // Detailed breakdown
                    Column(
                      children: (source["details"] as List<Map<String, dynamic>>).map((detail) {
                        return Padding(
                          padding: EdgeInsets.only(top: spXs),
                          child: Row(
                            children: [
                              SizedBox(width: spMd),
                              Expanded(
                                child: Text(
                                  "${detail["source"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ),
                              Text(
                                "${(detail["amount"] as double).toStringAsFixed(1)} tons",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
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
            }),
            
            // Reduction Strategies
            Text(
              "Carbon Reduction Strategies",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            ...List.generate(reductionStrategies.length, (index) {
              final strategy = reductionStrategies[index];
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: (strategy["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            strategy["icon"] as IconData,
                            size: 24,
                            color: strategy["color"] as Color,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${strategy["title"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${strategy["description"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: _getStatusColor(strategy["status"] as String).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${strategy["status"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: _getStatusColor(strategy["status"] as String),
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: successColor.withAlpha(30)),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.eco,
                            size: 16,
                            color: successColor,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Potential Reduction: ${(strategy["potentialReduction"] as double).toStringAsFixed(1)} tons CO₂/year",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: _getCostColor(strategy["implementationCost"] as String).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${strategy["implementationCost"]} Cost",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: _getCostColor(strategy["implementationCost"] as String),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "⏱ ${strategy["timeframe"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spSm),
                              Text(
                                "Progress: ${strategy["progress"]}%",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: strategy["color"] as Color,
                                ),
                              ),
                              LinearProgressIndicator(
                                value: (strategy["progress"] as int) / 100,
                                backgroundColor: disabledOutlineBorderColor,
                                valueColor: AlwaysStoppedAnimation<Color>(strategy["color"] as Color),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: spMd),
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
            }),
            
            // Monthly Trend Chart Placeholder
            Container(
              padding: EdgeInsets.all(spMd),
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
                    "Monthly Emissions Trend",
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
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: primaryColor.withAlpha(30)),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.trending_down,
                            size: 48,
                            color: successColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Emissions Trending Down",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "12.5% reduction over 6 months",
                            style: TextStyle(
                              fontSize: 14,
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
          ],
        ),
      ),
    );
  }
}
