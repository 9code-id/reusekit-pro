import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaForecastView extends StatefulWidget {
  const CmaForecastView({super.key});

  @override
  State<CmaForecastView> createState() => _CmaForecastViewState();
}

class _CmaForecastViewState extends State<CmaForecastView> {
  String selectedPeriod = "This Quarter";
  String selectedTeam = "All Teams";
  String forecastType = "Revenue";
  
  List<Map<String, dynamic>> periodItems = [
    {"label": "This Month", "value": "This Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "Next Quarter", "value": "Next Quarter"},
    {"label": "This Year", "value": "This Year"},
    {"label": "Next Year", "value": "Next Year"},
  ];
  
  List<Map<String, dynamic>> teamItems = [
    {"label": "All Teams", "value": "All Teams"},
    {"label": "Enterprise Sales", "value": "Enterprise Sales"},
    {"label": "SMB Sales", "value": "SMB Sales"},
    {"label": "Channel Partners", "value": "Channel Partners"},
    {"label": "Inside Sales", "value": "Inside Sales"},
  ];
  
  List<Map<String, dynamic>> forecastTypeItems = [
    {"label": "Revenue", "value": "Revenue"},
    {"label": "Units", "value": "Units"},
    {"label": "Deals", "value": "Deals"},
  ];
  
  Map<String, dynamic> forecastSummary = {
    "targetRevenue": 2500000,
    "forecastRevenue": 2125000,
    "pipelineRevenue": 3850000,
    "bestCase": 2675000,
    "worstCase": 1825000,
    "achievementRate": 85.0,
    "confidence": 78.5,
    "lastUpdated": "2024-01-20",
  };
  
  List<Map<String, dynamic>> monthlyForecast = [
    {
      "month": "January",
      "target": 750000,
      "forecast": 695000,
      "actual": 725000,
      "pipeline": 1200000,
      "confidence": 82.5,
      "deals": 15,
    },
    {
      "month": "February",
      "target": 850000,
      "forecast": 780000,
      "actual": 0,
      "pipeline": 1350000,
      "confidence": 76.8,
      "deals": 18,
    },
    {
      "month": "March",
      "target": 900000,
      "forecast": 650000,
      "actual": 0,
      "pipeline": 1300000,
      "confidence": 74.2,
      "deals": 12,
    },
  ];
  
  List<Map<String, dynamic>> teamForecast = [
    {
      "name": "Enterprise Sales",
      "target": 1200000,
      "forecast": 1050000,
      "pipeline": 1850000,
      "achievement": 87.5,
      "confidence": 82.3,
      "deals": 8,
      "manager": "Robert Davis",
    },
    {
      "name": "SMB Sales",
      "target": 800000,
      "forecast": 720000,
      "pipeline": 1200000,
      "achievement": 90.0,
      "confidence": 85.1,
      "deals": 24,
      "manager": "Jennifer Lee",
    },
    {
      "name": "Channel Partners",
      "target": 500000,
      "forecast": 355000,
      "pipeline": 800000,
      "achievement": 71.0,
      "confidence": 68.5,
      "deals": 6,
      "manager": "Michael Torres",
    },
  ];
  
  List<Map<String, dynamic>> riskFactors = [
    {
      "risk": "Economic Uncertainty",
      "impact": "High",
      "probability": 65,
      "description": "Market volatility affecting enterprise spending",
      "mitigation": "Focus on smaller deals and existing customers",
      "color": dangerColor,
    },
    {
      "risk": "Competitor Pricing",
      "impact": "Medium",
      "probability": 45,
      "description": "Increased price competition in key segments",
      "mitigation": "Emphasize value proposition and ROI",
      "color": warningColor,
    },
    {
      "risk": "Resource Constraints",
      "impact": "Medium",
      "probability": 35,
      "description": "Limited sales engineering capacity",
      "mitigation": "Prioritize high-value opportunities",
      "color": infoColor,
    },
  ];
  
  List<Map<String, dynamic>> keyOpportunities = [
    {
      "name": "Enterprise Software Suite",
      "account": "MegaCorp Industries",
      "value": 350000,
      "probability": 85,
      "stage": "Negotiation",
      "closeDate": "2024-02-15",
      "impact": "High",
      "risk": "Low",
    },
    {
      "name": "Digital Transformation",
      "account": "Global Retail Chain",
      "value": 275000,
      "probability": 75,
      "stage": "Proposal",
      "closeDate": "2024-02-28",
      "impact": "High",
      "risk": "Medium",
    },
    {
      "name": "Security Upgrade Project",
      "account": "Financial Services Corp",
      "value": 185000,
      "probability": 90,
      "stage": "Negotiation",
      "closeDate": "2024-02-10",
      "impact": "Medium",
      "risk": "Low",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sales Forecast"),
        actions: [
          QButton(
            icon: Icons.refresh,
            size: bs.sm,
            onPressed: () => _refreshForecast(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Filters Section
            Container(
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
                      Expanded(
                        child: QDropdownField(
                          label: "Team",
                          items: teamItems,
                          value: selectedTeam,
                          onChanged: (value, label) {
                            selectedTeam = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  QDropdownField(
                    label: "Forecast Type",
                    items: forecastTypeItems,
                    value: forecastType,
                    onChanged: (value, label) {
                      forecastType = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            
            // Forecast Summary
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
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Forecast Summary",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: _getConfidenceColor((forecastSummary["confidence"] as num).toDouble()).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${(forecastSummary["confidence"] as num).toStringAsFixed(1)}% Confidence",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: _getConfidenceColor((forecastSummary["confidence"] as num).toDouble()),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildSummaryCard(
                          "Target",
                          "\$${((forecastSummary["targetRevenue"] as int).toDouble()).currency}",
                          Icons.flag,
                          primaryColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildSummaryCard(
                          "Forecast",
                          "\$${((forecastSummary["forecastRevenue"] as int).toDouble()).currency}",
                          Icons.trending_up,
                          successColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: _buildSummaryCard(
                          "Best Case",
                          "\$${((forecastSummary["bestCase"] as int).toDouble()).currency}",
                          Icons.trending_up,
                          infoColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildSummaryCard(
                          "Worst Case",
                          "\$${((forecastSummary["worstCase"] as int).toDouble()).currency}",
                          Icons.trending_down,
                          warningColor,
                        ),
                      ),
                    ],
                  ),
                  // Achievement Progress Bar
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Target Achievement",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${(forecastSummary["achievementRate"] as num).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 8,
                          decoration: BoxDecoration(
                            color: disabledColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: FractionallySizedBox(
                            widthFactor: (forecastSummary["achievementRate"] as num) / 100,
                            alignment: Alignment.centerLeft,
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
            ),
            
            // Monthly Breakdown
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
                    "Monthly Forecast Breakdown",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...monthlyForecast.map((month) => _buildMonthlyCard(month)),
                ],
              ),
            ),
            
            // Team Performance
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
                    "Team Forecast Performance",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...teamForecast.map((team) => _buildTeamCard(team)),
                ],
              ),
            ),
            
            // Key Opportunities
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
                    "Key Forecast Opportunities",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...keyOpportunities.map((opportunity) => _buildOpportunityCard(opportunity)),
                ],
              ),
            ),
            
            // Risk Factors
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
                    "Forecast Risk Factors",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...riskFactors.map((risk) => _buildRiskCard(risk)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(100)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildMonthlyCard(Map<String, dynamic> month) {
    bool isActual = (month["actual"] as int) > 0;
    double achievement = isActual 
        ? ((month["actual"] as int) / (month["target"] as int)) * 100
        : ((month["forecast"] as int) / (month["target"] as int)) * 100;
    Color achievementColor = achievement >= 100 ? successColor : 
                           achievement >= 80 ? warningColor : dangerColor;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${month["month"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: _getConfidenceColor((month["confidence"] as num).toDouble()).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${(month["confidence"] as num).toStringAsFixed(1)}%",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: _getConfidenceColor((month["confidence"] as num).toDouble()),
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
                      "Target: \$${((month["target"] as int).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${isActual ? 'Actual' : 'Forecast'}: \$${((isActual ? month["actual"] : month["forecast"]) as int).toDouble().currency}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isActual ? successColor : primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${achievement.toStringAsFixed(1)}%",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: achievementColor,
                    ),
                  ),
                  Text(
                    "${month["deals"]} deals",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildTeamCard(Map<String, dynamic> team) {
    Color achievementColor = (team["achievement"] as num) >= 85 ? successColor : 
                           (team["achievement"] as num) >= 70 ? warningColor : dangerColor;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${team["name"]}",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Manager: ${team["manager"]}",
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
                    "${(team["achievement"] as num).toStringAsFixed(1)}%",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: achievementColor,
                    ),
                  ),
                  Text(
                    "${(team["confidence"] as num).toStringAsFixed(1)}% conf.",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
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
                      "Target: \$${((team["target"] as int).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Forecast: \$${((team["forecast"] as int).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "${team["deals"]} deals",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildOpportunityCard(Map<String, dynamic> opportunity) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${opportunity["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${opportunity["account"]} • ${opportunity["stage"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "Close: ${opportunity["closeDate"]}",
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
              Text(
                "\$${((opportunity["value"] as int).toDouble()).currency}",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
              Text(
                "${opportunity["probability"]}% prob.",
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
  
  Widget _buildRiskCard(Map<String, dynamic> risk) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: (risk["color"] as Color).withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: (risk["color"] as Color).withAlpha(100)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${risk["risk"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: risk["color"] as Color,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: risk["color"] as Color,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${risk["impact"]} Impact",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "${risk["description"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Text(
            "Mitigation: ${risk["mitigation"]}",
            style: TextStyle(
              fontSize: 11,
              fontStyle: FontStyle.italic,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }
  
  Color _getConfidenceColor(double confidence) {
    if (confidence >= 80) return successColor;
    if (confidence >= 60) return warningColor;
    return dangerColor;
  }
  
  void _refreshForecast() {
    ss("Forecast data refreshed");
  }
}
