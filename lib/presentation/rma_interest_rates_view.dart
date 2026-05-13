import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaInterestRatesView extends StatefulWidget {
  const RmaInterestRatesView({Key? key}) : super(key: key);

  @override
  State<RmaInterestRatesView> createState() => _RmaInterestRatesViewState();
}

class _RmaInterestRatesViewState extends State<RmaInterestRatesView> {
  String selectedTimeframe = "30_days";
  String selectedLoanType = "conventional";
  
  List<Map<String, dynamic>> timeframes = [
    {"label": "Last 30 Days", "value": "30_days"},
    {"label": "Last 90 Days", "value": "90_days"},
    {"label": "Last 6 Months", "value": "6_months"},
    {"label": "Last Year", "value": "1_year"},
  ];

  List<Map<String, dynamic>> loanTypes = [
    {"label": "Conventional", "value": "conventional"},
    {"label": "FHA", "value": "fha"},
    {"label": "VA", "value": "va"},
    {"label": "Jumbo", "value": "jumbo"},
  ];

  List<Map<String, dynamic>> currentRates = [
    {
      "loanType": "30-Year Fixed",
      "rate": "6.75%",
      "change": "+0.15%",
      "trend": "up",
      "apr": "6.89%",
    },
    {
      "loanType": "15-Year Fixed",
      "rate": "6.25%",
      "change": "+0.10%",
      "trend": "up",
      "apr": "6.35%",
    },
    {
      "loanType": "5/1 ARM",
      "rate": "5.95%",
      "change": "-0.05%",
      "trend": "down",
      "apr": "6.85%",
    },
    {
      "loanType": "Jumbo 30-Year",
      "rate": "6.85%",
      "change": "+0.20%",
      "trend": "up",
      "apr": "6.95%",
    },
  ];

  List<Map<String, dynamic>> rateHistory = [
    {"date": "2024-12-01", "rate": 6.60},
    {"date": "2024-12-08", "rate": 6.55},
    {"date": "2024-12-15", "rate": 6.70},
    {"date": "2024-12-22", "rate": 6.75},
    {"date": "2024-12-29", "rate": 6.75},
  ];

  List<Map<String, dynamic>> marketFactors = [
    {
      "factor": "Federal Reserve Policy",
      "impact": "High",
      "status": "Raising rates to combat inflation",
      "color": dangerColor,
    },
    {
      "factor": "Inflation Rate",
      "impact": "High",
      "status": "Currently at 3.2%, trending down",
      "color": warningColor,
    },
    {
      "factor": "Economic Growth",
      "impact": "Medium",
      "status": "GDP growth slowing but stable",
      "color": infoColor,
    },
    {
      "factor": "Employment",
      "impact": "Medium",
      "status": "Unemployment at historic lows",
      "color": successColor,
    },
  ];

  List<Map<String, dynamic>> predictions = [
    {
      "period": "Next Month",
      "prediction": "Rates likely to remain stable",
      "confidence": "High",
      "range": "6.5% - 6.8%",
    },
    {
      "period": "Next Quarter",
      "prediction": "Slight increase expected",
      "confidence": "Medium",
      "range": "6.7% - 7.1%",
    },
    {
      "period": "Next Year",
      "prediction": "Gradual decline anticipated",
      "confidence": "Low",
      "range": "6.0% - 6.5%",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Interest Rates"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Rate Filters
            Container(
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
                      Expanded(
                        child: QDropdownField(
                          label: "Time Period",
                          items: timeframes,
                          value: selectedTimeframe,
                          onChanged: (value, label) {
                            selectedTimeframe = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Loan Type",
                          items: loanTypes,
                          value: selectedLoanType,
                          onChanged: (value, label) {
                            selectedLoanType = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Current Rates
            Container(
              padding: EdgeInsets.all(spMd),
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
                    "Current Interest Rates",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...currentRates.map((rate) {
                    Color trendColor = rate["trend"] == "up" ? dangerColor : successColor;
                    IconData trendIcon = rate["trend"] == "up" ? Icons.trending_up : Icons.trending_down;
                    
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        border: Border.all(color: disabledColor),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${rate["loanType"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "APR: ${rate["apr"]}",
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
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "${rate["rate"]}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(
                                      trendIcon,
                                      size: 16,
                                      color: trendColor,
                                    ),
                                    SizedBox(width: spXxs),
                                    Text(
                                      "${rate["change"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: trendColor,
                                        fontWeight: FontWeight.w600,
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
                  }).toList(),
                ],
              ),
            ),

            // Rate Trend Chart
            Container(
              padding: EdgeInsets.all(spMd),
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
                    "Rate Trend (30-Year Fixed)",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Stack(
                      children: [
                        // Chart placeholder
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.trending_up,
                                size: 48,
                                color: primaryColor.withAlpha(100),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Interactive Rate Chart",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Rate points
                        ...rateHistory.asMap().entries.map((entry) {
                          int index = entry.key;
                          double rate = (entry.value["rate"] as num).toDouble();
                          double left = (index / (rateHistory.length - 1)) * (MediaQuery.of(context).size.width - spMd * 4);
                          double top = ((7.0 - rate) / 1.0) * 150;
                          
                          return Positioned(
                            left: left,
                            top: top,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Market Factors
            Container(
              padding: EdgeInsets.all(spMd),
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
                    "Market Factors Affecting Rates",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...marketFactors.map((factor) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            width: 4,
                            color: factor["color"] as Color,
                          ),
                        ),
                        color: (factor["color"] as Color).withAlpha(20),
                      ),
                      child: Column(
                        spacing: spXs,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${factor["factor"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: spXxs),
                                decoration: BoxDecoration(
                                  color: factor["color"] as Color,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${factor["impact"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${factor["status"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Rate Predictions
            Container(
              padding: EdgeInsets.all(spMd),
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
                    "Rate Predictions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...predictions.map((prediction) {
                    Color confidenceColor;
                    switch (prediction["confidence"]) {
                      case "High":
                        confidenceColor = successColor;
                        break;
                      case "Medium":
                        confidenceColor = warningColor;
                        break;
                      default:
                        confidenceColor = dangerColor;
                    }
                    
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        border: Border.all(color: disabledColor),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        spacing: spXs,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${prediction["period"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: spXxs),
                                decoration: BoxDecoration(
                                  color: confidenceColor.withAlpha(30),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${prediction["confidence"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: confidenceColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${prediction["prediction"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Expected Range: ${prediction["range"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Rate Alert Setup
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.notifications,
                        color: primaryColor,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Get Rate Alerts",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Stay updated when rates change in your favor. Set up personalized alerts based on your loan preferences.",
                    style: TextStyle(
                      color: disabledBoldColor,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Set Up Alerts",
                      size: bs.md,
                      onPressed: () {},
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
