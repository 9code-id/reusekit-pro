import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaYieldEstimationView extends StatefulWidget {
  const AmaYieldEstimationView({super.key});

  @override
  State<AmaYieldEstimationView> createState() => _AmaYieldEstimationViewState();
}

class _AmaYieldEstimationViewState extends State<AmaYieldEstimationView> {
  String selectedCrop = "Organic Tomatoes";
  String selectedModel = "AI Enhanced";
  String selectedTimeframe = "Current Season";
  double confidenceThreshold = 85.0;
  bool useWeatherData = true;
  bool useSoilData = true;
  bool useHistoricalData = true;
  
  List<String> crops = ["Organic Tomatoes", "Sweet Corn", "Bell Peppers", "Winter Wheat", "Strawberries"];
  List<String> estimationModels = ["AI Enhanced", "Statistical", "Expert System", "Hybrid"];
  List<String> timeframes = ["Current Season", "Next Season", "Annual", "5-Year Projection"];
  
  Map<String, dynamic> currentEstimation = {
    "crop": "Organic Tomatoes",
    "area": 45.0,
    "estimated_yield": 125.5,
    "min_yield": 110.2,
    "max_yield": 142.8,
    "confidence": 87.5,
    "last_updated": "2024-11-22 10:30:00",
    "factors": {
      "weather": 0.25,
      "soil_quality": 0.22,
      "irrigation": 0.18,
      "fertilization": 0.15,
      "pest_control": 0.12,
      "genetics": 0.08,
    },
    "market_value": 3.50,
    "projected_revenue": 439250.0,
  };

  List<Map<String, dynamic>> yieldPredictions = [
    {
      "crop": "Organic Tomatoes",
      "current_yield": 125.5,
      "predicted_yield": 132.8,
      "variance": 5.8,
      "confidence": 87.5,
      "factors_impact": "Weather +15%, Soil Quality +8%",
      "last_update": "2024-11-22 10:30:00",
      "status": "improving",
    },
    {
      "crop": "Sweet Corn",
      "current_yield": 178.2,
      "predicted_yield": 171.4,
      "variance": -3.8,
      "confidence": 82.1,
      "factors_impact": "Drought Risk -8%, Disease Pressure -2%",
      "last_update": "2024-11-22 09:15:00",
      "status": "declining",
    },
    {
      "crop": "Bell Peppers",
      "current_yield": 89.7,
      "predicted_yield": 92.3,
      "variance": 2.9,
      "confidence": 90.2,
      "factors_impact": "Optimal Conditions +5%",
      "last_update": "2024-11-22 08:45:00",
      "status": "stable",
    },
    {
      "crop": "Winter Wheat",
      "current_yield": 0.0,
      "predicted_yield": 348.5,
      "variance": 0.0,
      "confidence": 75.8,
      "factors_impact": "Early Planting Season Projection",
      "last_update": "2024-11-22 07:20:00",
      "status": "projected",
    },
  ];

  List<Map<String, dynamic>> influencingFactors = [
    {
      "factor": "Weather Conditions",
      "impact": 25.2,
      "status": "favorable",
      "description": "Temperature and rainfall within optimal range",
      "trend": "improving",
      "weight": 0.25,
    },
    {
      "factor": "Soil Quality",
      "impact": 22.1,
      "status": "excellent",
      "description": "Nutrient levels and pH optimal for crop growth",
      "trend": "stable",
      "weight": 0.22,
    },
    {
      "factor": "Irrigation System",
      "impact": 18.5,
      "status": "good",
      "description": "Consistent water supply and distribution",
      "trend": "stable",
      "weight": 0.18,
    },
    {
      "factor": "Fertilization",
      "impact": 15.3,
      "status": "adequate",
      "description": "Balanced nutrient application schedule",
      "trend": "improving",
      "weight": 0.15,
    },
    {
      "factor": "Pest Control",
      "impact": 12.7,
      "status": "controlled",
      "description": "Integrated pest management effective",
      "trend": "stable",
      "weight": 0.12,
    },
    {
      "factor": "Crop Genetics",
      "impact": 8.2,
      "status": "superior",
      "description": "High-yield variety with disease resistance",
      "trend": "stable",
      "weight": 0.08,
    },
  ];

  List<Map<String, dynamic>> historicalComparison = [
    {"year": "2020", "yield": 118.5, "revenue": 414750.0},
    {"year": "2021", "yield": 122.3, "revenue": 428050.0},
    {"year": "2022", "yield": 115.8, "revenue": 405300.0},
    {"year": "2023", "yield": 128.7, "revenue": 450450.0},
    {"year": "2024 (Est)", "yield": 125.5, "revenue": 439250.0},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yield Estimation"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              ss("Yield estimation updated with latest data");
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              si("Estimation model settings");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Estimation Overview
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
                      Expanded(
                        child: Text(
                          "Current Yield Estimation",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: _getConfidenceColor(currentEstimation["confidence"]).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Text(
                          "${(currentEstimation["confidence"] as double).toStringAsFixed(1)}% Confidence",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: _getConfidenceColor(currentEstimation["confidence"]),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  // Main Yield Display
                  Center(
                    child: Column(
                      children: [
                        Text(
                          "${(currentEstimation["estimated_yield"] as double).toStringAsFixed(1)} tons",
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${currentEstimation["crop"]} • ${(currentEstimation["area"] as double).toStringAsFixed(0)} acres",
                          style: TextStyle(
                            fontSize: 16,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Range: ${(currentEstimation["min_yield"] as double).toStringAsFixed(1)} - ${(currentEstimation["max_yield"] as double).toStringAsFixed(1)} tons",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Revenue Projection
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: successColor.withAlpha(30)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.attach_money, color: successColor),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Projected Revenue",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "\$${((currentEstimation["projected_revenue"] as double)).currency}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "@ \$${(currentEstimation["market_value"] as double).toStringAsFixed(2)}/kg",
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
            ),
            
            SizedBox(height: spMd),
            
            // Estimation Configuration
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
                  Text(
                    "Estimation Configuration",
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
                          label: "Crop",
                          value: selectedCrop,
                          items: crops.map((crop) => {
                            "label": crop,
                            "value": crop,
                          }).toList(),
                          onChanged: (value, label) {
                            selectedCrop = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Model",
                          value: selectedModel,
                          items: estimationModels.map((model) => {
                            "label": model,
                            "value": model,
                          }).toList(),
                          onChanged: (value, label) {
                            selectedModel = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spSm),
                  
                  QDropdownField(
                    label: "Timeframe",
                    value: selectedTimeframe,
                    items: timeframes.map((timeframe) => {
                      "label": timeframe,
                      "value": timeframe,
                    }).toList(),
                    onChanged: (value, label) {
                      selectedTimeframe = value;
                      setState(() {});
                    },
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Text(
                    "Data Sources",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  SizedBox(height: spSm),
                  
                  Column(
                    children: [
                      QSwitch(
                        items: [
                          {
                            "label": "Use Weather Data",
                            "value": useWeatherData,
                            "checked": useWeatherData,
                          }
                        ],
                        value: useWeatherData ? [{"label": "Use Weather Data", "value": useWeatherData, "checked": true}] : [],
                        onChanged: (values, ids) {
                          useWeatherData = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                      SizedBox(height: spSm),
                      QSwitch(
                        items: [
                          {
                            "label": "Use Soil Analysis Data",
                            "value": useSoilData,
                            "checked": useSoilData,
                          }
                        ],
                        value: useSoilData ? [{"label": "Use Soil Analysis Data", "value": useSoilData, "checked": true}] : [],
                        onChanged: (values, ids) {
                          useSoilData = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                      SizedBox(height: spSm),
                      QSwitch(
                        items: [
                          {
                            "label": "Use Historical Data",
                            "value": useHistoricalData,
                            "checked": useHistoricalData,
                          }
                        ],
                        value: useHistoricalData ? [{"label": "Use Historical Data", "value": useHistoricalData, "checked": true}] : [],
                        onChanged: (values, ids) {
                          useHistoricalData = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Crop Predictions Overview
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
                  Text(
                    "All Crop Predictions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  ...List.generate(yieldPredictions.length, (index) {
                    final prediction = yieldPredictions[index];
                    final isProjected = prediction["status"] == "projected";
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: _getStatusColor(prediction["status"]).withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: _getStatusColor(prediction["status"]).withAlpha(30)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: _getStatusColor(prediction["status"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              _getStatusIcon(prediction["status"]),
                              color: _getStatusColor(prediction["status"]),
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${prediction["crop"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                if (!isProjected)
                                  Text(
                                    "Current: ${(prediction["current_yield"] as double).toStringAsFixed(1)} tons",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                Text(
                                  "${isProjected ? "Projected" : "Predicted"}: ${(prediction["predicted_yield"] as double).toStringAsFixed(1)} tons",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${prediction["factors_impact"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              if (!isProjected)
                                Text(
                                  "${(prediction["variance"] as double) >= 0 ? '+' : ''}${(prediction["variance"] as double).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: (prediction["variance"] as double) >= 0 ? successColor : dangerColor,
                                  ),
                                ),
                              Text(
                                "${(prediction["confidence"] as double).toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: _getConfidenceColor(prediction["confidence"]),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(prediction["status"]),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${prediction["status"]}".toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Influencing Factors
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
                  Text(
                    "Yield Influencing Factors",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  ...List.generate(influencingFactors.length, (index) {
                    final factor = influencingFactors[index];
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: disabledOutlineBorderColor),
                        boxShadow: [shadowXs],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${factor["factor"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: _getFactorStatusColor(factor["status"]).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusLg),
                                ),
                                child: Text(
                                  "${factor["status"]}".toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: _getFactorStatusColor(factor["status"]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${factor["description"]}",
                            style: TextStyle(
                              fontSize: 13,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Impact Weight",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Container(
                                      height: 6,
                                      decoration: BoxDecoration(
                                        color: disabledColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: FractionallySizedBox(
                                        alignment: Alignment.centerLeft,
                                        widthFactor: factor["weight"] as double,
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
                              SizedBox(width: spMd),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "${(factor["impact"] as double).toStringAsFixed(1)}%",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        _getTrendIcon(factor["trend"]),
                                        size: 12,
                                        color: _getTrendColor(factor["trend"]),
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${factor["trend"]}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: _getTrendColor(factor["trend"]),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Historical Comparison
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
                  Text(
                    "Historical Yield Comparison",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  ...List.generate(historicalComparison.length, (index) {
                    final data = historicalComparison[index];
                    final isCurrentYear = (data["year"] as String).contains("2024");
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: isCurrentYear ? primaryColor.withAlpha(10) : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: isCurrentYear ? primaryColor.withAlpha(30) : disabledOutlineBorderColor,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${data["year"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isCurrentYear ? primaryColor : disabledBoldColor,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "${(data["yield"] as double).toStringAsFixed(1)} tons",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "\$${((data["revenue"] as double) / 1000).toStringAsFixed(0)}K",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: successColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
            
            SizedBox(height: spXl),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ss("Generating new yield estimation...");
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.calculate, color: Colors.white),
      ),
    );
  }

  Color _getConfidenceColor(double confidence) {
    if (confidence >= 80) return successColor;
    if (confidence >= 60) return warningColor;
    return dangerColor;
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'improving':
        return successColor;
      case 'declining':
        return dangerColor;
      case 'stable':
        return infoColor;
      case 'projected':
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'improving':
        return Icons.trending_up;
      case 'declining':
        return Icons.trending_down;
      case 'stable':
        return Icons.trending_flat;
      case 'projected':
        return Icons.timeline;
      default:
        return Icons.help;
    }
  }

  Color _getFactorStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'excellent':
      case 'superior':
        return successColor;
      case 'good':
      case 'favorable':
        return infoColor;
      case 'adequate':
      case 'controlled':
        return warningColor;
      case 'poor':
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  IconData _getTrendIcon(String trend) {
    switch (trend.toLowerCase()) {
      case 'improving':
        return Icons.arrow_upward;
      case 'declining':
        return Icons.arrow_downward;
      case 'stable':
        return Icons.remove;
      default:
        return Icons.help;
    }
  }

  Color _getTrendColor(String trend) {
    switch (trend.toLowerCase()) {
      case 'improving':
        return successColor;
      case 'declining':
        return dangerColor;
      case 'stable':
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }
}
