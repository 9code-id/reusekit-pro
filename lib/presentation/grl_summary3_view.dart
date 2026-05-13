import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSummary3View extends StatefulWidget {
  @override
  State<GrlSummary3View> createState() => _GrlSummary3ViewState();
}

class _GrlSummary3ViewState extends State<GrlSummary3View> {
  String selectedTimeframe = "Last 30 Days";
  String selectedComparison = "Previous Period";
  String selectedView = "Executive";

  List<Map<String, dynamic>> timeframeOptions = [
    {"label": "Last 7 Days", "value": "Last 7 Days"},
    {"label": "Last 30 Days", "value": "Last 30 Days"},
    {"label": "Last 90 Days", "value": "Last 90 Days"},
    {"label": "Year to Date", "value": "Year to Date"},
  ];

  List<Map<String, dynamic>> comparisonOptions = [
    {"label": "Previous Period", "value": "Previous Period"},
    {"label": "Same Period Last Year", "value": "Same Period Last Year"},
    {"label": "Industry Average", "value": "Industry Average"},
    {"label": "Benchmark Target", "value": "Benchmark Target"},
  ];

  List<Map<String, dynamic>> viewOptions = [
    {"label": "Executive", "value": "Executive"},
    {"label": "Detailed", "value": "Detailed"},
    {"label": "Comparative", "value": "Comparative"},
    {"label": "Forecasting", "value": "Forecasting"},
  ];

  List<Map<String, dynamic>> executiveMetrics = [
    {
      "title": "Total Revenue",
      "value": 4890000,
      "change": 18.5,
      "trend": "up",
      "icon": Icons.attach_money,
      "color": Colors.green,
      "subtitle": "Quarterly Performance",
      "target": 5000000,
    },
    {
      "title": "Net Profit Margin",
      "value": 23.4,
      "change": 2.8,
      "trend": "up",
      "icon": Icons.trending_up,
      "color": Colors.blue,
      "subtitle": "Profitability Ratio",
      "target": 25.0,
    },
    {
      "title": "Customer Growth",
      "value": 12847,
      "change": 15.2,
      "trend": "up",
      "icon": Icons.people,
      "color": Colors.purple,
      "subtitle": "Active Customer Base",
      "target": 15000,
    },
    {
      "title": "Market Share",
      "value": 34.7,
      "change": 4.1,
      "trend": "up",
      "icon": Icons.pie_chart,
      "color": Colors.orange,
      "subtitle": "Industry Position",
      "target": 40.0,
    },
  ];

  List<Map<String, dynamic>> businessHealth = [
    {
      "category": "Financial Health",
      "score": 92,
      "status": "Excellent",
      "metrics": [
        {"name": "Revenue Growth", "value": "18.5%", "status": "excellent"},
        {"name": "Profit Margin", "value": "23.4%", "status": "good"},
        {"name": "Cash Flow", "value": "Positive", "status": "excellent"},
        {"name": "Debt Ratio", "value": "12.3%", "status": "excellent"},
      ],
    },
    {
      "category": "Operational Efficiency",
      "score": 87,
      "status": "Good",
      "metrics": [
        {"name": "Process Efficiency", "value": "89.2%", "status": "good"},
        {"name": "Resource Utilization", "value": "85.6%", "status": "good"},
        {"name": "Quality Score", "value": "94.1%", "status": "excellent"},
        {"name": "Delivery Performance", "value": "91.8%", "status": "excellent"},
      ],
    },
    {
      "category": "Customer Satisfaction",
      "score": 94,
      "status": "Excellent",
      "metrics": [
        {"name": "NPS Score", "value": "67", "status": "excellent"},
        {"name": "Customer Retention", "value": "89.4%", "status": "good"},
        {"name": "Support Rating", "value": "4.6/5", "status": "excellent"},
        {"name": "Resolution Time", "value": "2.1 hrs", "status": "good"},
      ],
    },
    {
      "category": "Growth Potential",
      "score": 89,
      "status": "Good",
      "metrics": [
        {"name": "Market Expansion", "value": "High", "status": "excellent"},
        {"name": "Innovation Index", "value": "8.2/10", "status": "good"},
        {"name": "Competitive Edge", "value": "Strong", "status": "good"},
        {"name": "Investment ROI", "value": "34.7%", "status": "excellent"},
      ],
    },
  ];

  List<Map<String, dynamic>> strategicInitiatives = [
    {
      "title": "Digital Transformation",
      "progress": 78,
      "status": "On Track",
      "completion": "Q4 2024",
      "impact": "High",
      "investment": 2500000,
      "roi": 156.7,
    },
    {
      "title": "Market Expansion",
      "progress": 65,
      "status": "On Track",
      "completion": "Q1 2025",
      "impact": "High",
      "investment": 1800000,
      "roi": 234.5,
    },
    {
      "title": "Product Innovation",
      "progress": 43,
      "status": "Delayed",
      "completion": "Q2 2025",
      "impact": "Medium",
      "investment": 950000,
      "roi": 189.2,
    },
    {
      "title": "Operational Excellence",
      "progress": 89,
      "status": "Ahead",
      "completion": "Q3 2024",
      "impact": "Medium",
      "investment": 650000,
      "roi": 298.4,
    },
  ];

  List<Map<String, dynamic>> riskAssessment = [
    {
      "risk": "Market Volatility",
      "probability": "Medium",
      "impact": "High",
      "mitigation": "Diversify revenue streams and build cash reserves",
      "status": "Monitored",
    },
    {
      "risk": "Supply Chain Disruption",
      "probability": "Low",
      "impact": "High",
      "mitigation": "Multiple supplier partnerships and inventory buffers",
      "status": "Mitigated",
    },
    {
      "risk": "Technology Obsolescence",
      "probability": "Medium",
      "impact": "Medium",
      "mitigation": "Continuous innovation and technology upgrades",
      "status": "Active",
    },
    {
      "risk": "Talent Retention",
      "probability": "Low",
      "impact": "Medium",
      "mitigation": "Enhanced compensation and career development programs",
      "status": "Mitigated",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Strategic Summary"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.print),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildControlPanel(),
            SizedBox(height: spLg),
            _buildExecutiveOverview(),
            SizedBox(height: spLg),
            _buildBusinessHealthScore(),
            SizedBox(height: spLg),
            _buildStrategicInitiatives(),
            SizedBox(height: spLg),
            _buildRiskAssessment(),
            SizedBox(height: spLg),
            _buildActionPlan(),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.dashboard,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Executive Dashboard Controls",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
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
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Comparison",
                  items: comparisonOptions,
                  value: selectedComparison,
                  onChanged: (value, label) {
                    selectedComparison = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          QDropdownField(
            label: "View Type",
            items: viewOptions,
            value: selectedView,
            onChanged: (value, label) {
              selectedView = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildExecutiveOverview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Executive Metrics Overview",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: executiveMetrics.map((metric) {
            double progress = 0.0;
            if (metric["title"] == "Total Revenue") {
              progress = (metric["value"] as int) / (metric["target"] as int);
            } else if (metric["title"] == "Customer Growth") {
              progress = (metric["value"] as int) / (metric["target"] as int);
            } else {
              progress = (metric["value"] as double) / (metric["target"] as double);
            }
            
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
                border: Border(
                  top: BorderSide(
                    width: 4,
                    color: metric["color"] as Color,
                  ),
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
                          color: (metric["color"] as Color).withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          metric["icon"] as IconData,
                          color: metric["color"] as Color,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${metric["title"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${metric["subtitle"]}",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  if (metric["title"] == "Total Revenue")
                    Text(
                      "\$${((metric["value"] as int) / 1000000).toStringAsFixed(1)}M",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    )
                  else if (metric["title"] == "Customer Growth")
                    Text(
                      "${(metric["value"] as int).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    )
                  else
                    Text(
                      "${(metric["value"] as double).toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Icon(
                        Icons.trending_up,
                        color: successColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "+${(metric["change"] as double).toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${(progress * 100).toStringAsFixed(0)}% of target",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  LinearProgressIndicator(
                    value: progress > 1.0 ? 1.0 : progress,
                    backgroundColor: disabledColor,
                    valueColor: AlwaysStoppedAnimation<Color>(metric["color"] as Color),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildBusinessHealthScore() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Business Health Assessment",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Column(
          children: businessHealth.map((health) {
            Color statusColor = health["score"] >= 90 ? successColor :
                              health["score"] >= 75 ? warningColor : dangerColor;
            
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
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
                      Text(
                        "${health["category"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: statusColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${health["score"]}/100",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: statusColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  LinearProgressIndicator(
                    value: (health["score"] as int) / 100,
                    backgroundColor: disabledColor,
                    valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                  ),
                  SizedBox(height: spSm),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: (health["metrics"] as List).map<Widget>((metric) {
                      Color metricColor = metric["status"] == "excellent" ? successColor :
                                        metric["status"] == "good" ? warningColor : dangerColor;
                      
                      return Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: metricColor.withAlpha(12),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: metricColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "${metric["name"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                            Text(
                              "${metric["value"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: metricColor,
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
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildStrategicInitiatives() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Strategic Initiatives Progress",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Column(
          children: strategicInitiatives.map((initiative) {
            Color statusColor = initiative["status"] == "Ahead" ? successColor :
                              initiative["status"] == "On Track" ? infoColor :
                              initiative["status"] == "Delayed" ? dangerColor : warningColor;
            
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
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
                      Expanded(
                        child: Text(
                          "${initiative["title"]}",
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
                          color: statusColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${initiative["status"]}",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: statusColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Text(
                        "${initiative["progress"]}% Complete",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Target: ${initiative["completion"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  LinearProgressIndicator(
                    value: (initiative["progress"] as int) / 100,
                    backgroundColor: disabledColor,
                    valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Investment",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "\$${((initiative["investment"] as int) / 1000000).toStringAsFixed(1)}M",
                              style: TextStyle(
                                fontSize: 14,
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
                              "Expected ROI",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${(initiative["roi"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: initiative["impact"] == "High" ? dangerColor.withAlpha(25) : warningColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${initiative["impact"]} Impact",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: initiative["impact"] == "High" ? dangerColor : warningColor,
                          ),
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
    );
  }

  Widget _buildRiskAssessment() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Risk Assessment & Mitigation",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Column(
          children: riskAssessment.map((risk) {
            Color riskColor = risk["probability"] == "High" ? dangerColor :
                            risk["probability"] == "Medium" ? warningColor : successColor;
            
            Color statusColor = risk["status"] == "Mitigated" ? successColor :
                              risk["status"] == "Active" ? warningColor : infoColor;
            
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: riskColor,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${risk["risk"]}",
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
                          color: statusColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${risk["status"]}",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: statusColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: riskColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${risk["probability"]} Probability",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: riskColor,
                          ),
                        ),
                      ),
                      SizedBox(width: spXs),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: risk["impact"] == "High" ? dangerColor.withAlpha(25) : warningColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${risk["impact"]} Impact",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: risk["impact"] == "High" ? dangerColor : warningColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Mitigation Strategy:",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${risk["mitigation"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildActionPlan() {
    List<Map<String, dynamic>> executiveActions = [
      {
        "action": "Board Presentation Preparation",
        "deadline": "Next Week",
        "priority": "High",
        "owner": "CEO Office",
        "description": "Prepare comprehensive quarterly board presentation with strategic insights",
      },
      {
        "action": "Digital Initiative Acceleration",
        "deadline": "End of Month",
        "priority": "High",
        "owner": "CTO",
        "description": "Fast-track digital transformation projects to maintain competitive advantage",
      },
      {
        "action": "Market Expansion Strategy Review",
        "deadline": "2 Weeks",
        "priority": "Medium",
        "owner": "Strategy Team",
        "description": "Comprehensive review of international expansion opportunities",
      },
      {
        "action": "Risk Management Framework Update",
        "deadline": "Next Month",
        "priority": "Medium",
        "owner": "Risk Committee",
        "description": "Update enterprise risk management protocols and response procedures",
      },
      {
        "action": "Stakeholder Communication Plan",
        "deadline": "Next Quarter",
        "priority": "Low",
        "owner": "Communications",
        "description": "Develop enhanced stakeholder engagement and communication strategy",
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Executive Action Plan",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Column(
          children: executiveActions.map((action) {
            Color priorityColor = action["priority"] == "High" ? dangerColor :
                                 action["priority"] == "Medium" ? warningColor : infoColor;
            
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Container(
                    width: 6,
                    height: 80,
                    decoration: BoxDecoration(
                      color: priorityColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${action["action"]}",
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
                                color: priorityColor.withAlpha(25),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${action["priority"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: priorityColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${action["description"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Icon(
                              Icons.person,
                              color: primaryColor,
                              size: 14,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${action["owner"]}",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Icon(
                              Icons.schedule,
                              color: disabledBoldColor,
                              size: 14,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${action["deadline"]}",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  QButton(
                    icon: Icons.assignment,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
