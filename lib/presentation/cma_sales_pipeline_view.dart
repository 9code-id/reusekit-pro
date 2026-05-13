import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaSalesPipelineView extends StatefulWidget {
  const CmaSalesPipelineView({super.key});

  @override
  State<CmaSalesPipelineView> createState() => _CmaSalesPipelineViewState();
}

class _CmaSalesPipelineViewState extends State<CmaSalesPipelineView> {
  String selectedPeriod = "This Quarter";
  String selectedTeam = "All Teams";
  
  List<Map<String, dynamic>> periodItems = [
    {"label": "This Month", "value": "This Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
    {"label": "Last Month", "value": "Last Month"},
    {"label": "Last Quarter", "value": "Last Quarter"},
  ];
  
  List<Map<String, dynamic>> teamItems = [
    {"label": "All Teams", "value": "All Teams"},
    {"label": "Enterprise Sales", "value": "Enterprise Sales"},
    {"label": "SMB Sales", "value": "SMB Sales"},
    {"label": "Channel Partners", "value": "Channel Partners"},
    {"label": "Inside Sales", "value": "Inside Sales"},
  ];
  
  Map<String, dynamic> pipelineMetrics = {
    "totalOpportunities": 88,
    "pipelineValue": 4285000,
    "averageDealSize": 48693,
    "conversionRate": 24.5,
    "averageSalesLength": 45,
    "forecastRevenue": 1050000,
    "wonDeals": 21,
    "lostDeals": 15,
  };
  
  List<Map<String, dynamic>> pipelineStages = [
    {
      "stage": "Prospecting",
      "count": 24,
      "value": 850000,
      "percentage": 19.8,
      "color": Colors.blue,
      "velocity": 8.5,
      "conversionRate": 45.8,
    },
    {
      "stage": "Qualification",
      "count": 18,
      "value": 720000,
      "percentage": 16.8,
      "color": Colors.orange,
      "velocity": 12.3,
      "conversionRate": 62.5,
    },
    {
      "stage": "Needs Analysis",
      "count": 12,
      "value": 540000,
      "percentage": 12.6,
      "color": Colors.purple,
      "velocity": 18.7,
      "conversionRate": 75.0,
    },
    {
      "stage": "Proposal",
      "count": 8,
      "value": 480000,
      "percentage": 11.2,
      "color": Colors.indigo,
      "velocity": 22.4,
      "conversionRate": 85.7,
    },
    {
      "stage": "Negotiation",
      "count": 5,
      "value": 350000,
      "percentage": 8.2,
      "color": Colors.teal,
      "velocity": 28.9,
      "conversionRate": 90.0,
    },
    {
      "stage": "Closed Won",
      "count": 21,
      "value": 1345000,
      "percentage": 31.4,
      "color": successColor,
      "velocity": 0,
      "conversionRate": 100.0,
    },
  ];
  
  List<Map<String, dynamic>> topOpportunities = [
    {
      "name": "Enterprise Software Solution",
      "account": "TechCorp Inc.",
      "value": 250000,
      "stage": "Negotiation",
      "probability": 90,
      "owner": "John Smith",
      "closeDate": "2024-02-15",
      "lastActivity": "Contract review meeting",
    },
    {
      "name": "Digital Transformation Project",
      "account": "Global Industries",
      "value": 185000,
      "stage": "Proposal",
      "probability": 75,
      "owner": "Sarah Johnson",
      "closeDate": "2024-02-28",
      "lastActivity": "Proposal presentation",
    },
    {
      "name": "Cloud Migration Services",
      "account": "StartupXYZ",
      "value": 125000,
      "stage": "Needs Analysis",
      "probability": 65,
      "owner": "Mike Wilson",
      "closeDate": "2024-03-10",
      "lastActivity": "Requirements workshop",
    },
    {
      "name": "Security Audit Package",
      "account": "SecureBank Ltd",
      "value": 95000,
      "stage": "Qualification",
      "probability": 50,
      "owner": "Lisa Chen",
      "closeDate": "2024-03-15",
      "lastActivity": "Discovery call",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sales Pipeline"),
        actions: [
          QButton(
            icon: Icons.refresh,
            size: bs.sm,
            onPressed: () => _refreshPipeline(),
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
                  Expanded(
                    child: QDropdownField(
                      label: "Sales Team",
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
            ),
            
            // Key Metrics Section
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
                    "Pipeline Overview",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildMetricCard(
                          "Total Pipeline Value",
                          "\$${((pipelineMetrics["pipelineValue"] as int).toDouble()).currency}",
                          Icons.trending_up,
                          primaryColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildMetricCard(
                          "Forecast Revenue",
                          "\$${((pipelineMetrics["forecastRevenue"] as int).toDouble()).currency}",
                          Icons.analytics,
                          successColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: _buildMetricCard(
                          "Avg Deal Size",
                          "\$${((pipelineMetrics["averageDealSize"] as int).toDouble()).currency}",
                          Icons.attach_money,
                          infoColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildMetricCard(
                          "Conversion Rate",
                          "${(pipelineMetrics["conversionRate"] as num).toStringAsFixed(1)}%",
                          Icons.percent,
                          warningColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Pipeline Visualization Section
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
                          "Pipeline by Stage",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Text(
                        "${pipelineStages.fold(0, (sum, stage) => sum + (stage["count"] as int))} opportunities",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  // Pipeline stages visualization
                  ...pipelineStages.map((stage) => _buildPipelineStageCard(stage)),
                ],
              ),
            ),
            
            // Top Opportunities Section
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
                          "Top Opportunities",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      QButton(
                        label: "View All",
                        size: bs.sm,
                        onPressed: () {
                          // Navigate to full opportunities list
                        },
                      ),
                    ],
                  ),
                  ...topOpportunities.map((opportunity) => _buildOpportunityCard(opportunity)),
                ],
              ),
            ),
            
            // Performance Insights Section
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
                    "Performance Insights",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  _buildInsightCard(
                    "Sales Velocity",
                    "Average time to close is ${pipelineMetrics["averageSalesLength"]} days",
                    Icons.speed,
                    infoColor,
                  ),
                  _buildInsightCard(
                    "Win Rate",
                    "${pipelineMetrics["wonDeals"]} won vs ${pipelineMetrics["lostDeals"]} lost opportunities",
                    Icons.emoji_events,
                    successColor,
                  ),
                  _buildInsightCard(
                    "Pipeline Health",
                    "Strong pipeline with ${pipelineStages.length - 1} active stages",
                    Icons.health_and_safety,
                    primaryColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(100)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildPipelineStageCard(Map<String, dynamic> stage) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: stage["color"] as Color,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "${stage["stage"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
              Text(
                "${stage["count"]} deals",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "\$${((stage["value"] as int).toDouble()).currency}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: disabledColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: FractionallySizedBox(
              widthFactor: (stage["percentage"] as num) / 100,
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: BoxDecoration(
                  color: stage["color"] as Color,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ),
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Text(
                "${(stage["percentage"] as num).toStringAsFixed(1)}% of pipeline",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "${(stage["conversionRate"] as num).toStringAsFixed(1)}% conversion rate",
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
  
  Widget _buildOpportunityCard(Map<String, dynamic> opportunity) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${opportunity["name"]}",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Text(
                "\$${((opportunity["value"] as int).toDouble()).currency}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "${opportunity["account"]}",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                " • ",
                style: TextStyle(color: disabledBoldColor),
              ),
              Text(
                "${opportunity["stage"]}",
                style: TextStyle(
                  fontSize: 13,
                  color: infoColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              Text(
                "${opportunity["probability"]}% probability",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.person, size: 12, color: disabledBoldColor),
              SizedBox(width: 4),
              Text(
                "${opportunity["owner"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Icon(Icons.schedule, size: 12, color: disabledBoldColor),
              SizedBox(width: 4),
              Text(
                "${opportunity["closeDate"]}",
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
  
  Widget _buildInsightCard(String title, String description, IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(100)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text(
                  description,
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
    );
  }
  
  void _refreshPipeline() {
    ss("Pipeline data refreshed");
  }
}
