import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaOpportunityStagesView extends StatefulWidget {
  const CmaOpportunityStagesView({super.key});

  @override
  State<CmaOpportunityStagesView> createState() => _CmaOpportunityStagesViewState();
}

class _CmaOpportunityStagesViewState extends State<CmaOpportunityStagesView> {
  String selectedStage = "All Stages";
  
  List<Map<String, dynamic>> stageFilters = [
    {"label": "All Stages", "value": "All Stages"},
    {"label": "Prospecting", "value": "Prospecting"},
    {"label": "Qualification", "value": "Qualification"},
    {"label": "Needs Analysis", "value": "Needs Analysis"},
    {"label": "Proposal", "value": "Proposal"},
    {"label": "Negotiation", "value": "Negotiation"},
    {"label": "Closed Won", "value": "Closed Won"},
    {"label": "Closed Lost", "value": "Closed Lost"},
  ];
  
  List<Map<String, dynamic>> stageStats = [
    {
      "stage": "Prospecting",
      "count": 24,
      "totalValue": 850000,
      "avgDeal": 35416,
      "color": Colors.blue,
      "icon": Icons.search,
      "conversionRate": 45.8,
    },
    {
      "stage": "Qualification",
      "count": 18,
      "totalValue": 720000,
      "avgDeal": 40000,
      "color": Colors.orange,
      "icon": Icons.verified,
      "conversionRate": 62.5,
    },
    {
      "stage": "Needs Analysis",
      "count": 12,
      "totalValue": 540000,
      "avgDeal": 45000,
      "color": Colors.purple,
      "icon": Icons.analytics,
      "conversionRate": 75.0,
    },
    {
      "stage": "Proposal",
      "count": 8,
      "totalValue": 480000,
      "avgDeal": 60000,
      "color": Colors.indigo,
      "icon": Icons.description,
      "conversionRate": 85.7,
    },
    {
      "stage": "Negotiation",
      "count": 5,
      "totalValue": 350000,
      "avgDeal": 70000,
      "color": Colors.teal,
      "icon": Icons.handshake,
      "conversionRate": 90.0,
    },
    {
      "stage": "Closed Won",
      "count": 15,
      "totalValue": 1200000,
      "avgDeal": 80000,
      "color": successColor,
      "icon": Icons.check_circle,
      "conversionRate": 100.0,
    },
    {
      "stage": "Closed Lost",
      "count": 6,
      "totalValue": 0,
      "avgDeal": 0,
      "color": dangerColor,
      "icon": Icons.cancel,
      "conversionRate": 0.0,
    },
  ];
  
  List<Map<String, dynamic>> opportunities = [
    {
      "id": "OPP-001",
      "name": "Enterprise Software Solution",
      "account": "TechCorp Inc.",
      "stage": "Proposal",
      "value": 125000,
      "probability": 75,
      "closeDate": "2024-02-15",
      "owner": "John Smith",
      "lastActivity": "2024-01-20",
      "priority": "High",
    },
    {
      "id": "OPP-002",
      "name": "Digital Transformation Project",
      "account": "Global Industries",
      "stage": "Negotiation",
      "value": 250000,
      "probability": 90,
      "closeDate": "2024-01-30",
      "owner": "Sarah Johnson",
      "lastActivity": "2024-01-19",
      "priority": "Critical",
    },
    {
      "id": "OPP-003",
      "name": "Cloud Migration Services",
      "account": "StartupXYZ",
      "stage": "Qualification",
      "value": 45000,
      "probability": 50,
      "closeDate": "2024-03-10",
      "owner": "Mike Wilson",
      "lastActivity": "2024-01-18",
      "priority": "Medium",
    },
    {
      "id": "OPP-004",
      "name": "Security Audit Package",
      "account": "SecureBank Ltd",
      "stage": "Needs Analysis",
      "value": 75000,
      "probability": 65,
      "closeDate": "2024-02-28",
      "owner": "Lisa Chen",
      "lastActivity": "2024-01-17",
      "priority": "High",
    },
    {
      "id": "OPP-005",
      "name": "Mobile App Development",
      "account": "RetailChain Co",
      "stage": "Prospecting",
      "value": 95000,
      "probability": 25,
      "closeDate": "2024-04-15",
      "owner": "David Brown",
      "lastActivity": "2024-01-16",
      "priority": "Low",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Opportunity Stages"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {
              // Navigate to add opportunity
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Stage Overview Section
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
                    "Sales Pipeline Overview",
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
                          "Total Opportunities",
                          "${stageStats.fold(0, (sum, stage) => sum + (stage["count"] as int))}",
                          Icons.business,
                          primaryColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildMetricCard(
                          "Pipeline Value",
                          "\$${((stageStats.fold(0.0, (sum, stage) => sum + (stage["totalValue"] as int))).toDouble()).currency}",
                          Icons.attach_money,
                          successColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Stage Statistics Section
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
                    "Stage Performance",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...stageStats.map((stage) => _buildStageCard(stage)),
                ],
              ),
            ),
            
            // Filter and Opportunities List
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
                          "Opportunities by Stage",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Container(
                        width: 150,
                        child: QDropdownField(
                          label: "Filter by Stage",
                          items: stageFilters,
                          value: selectedStage,
                          onChanged: (value, label) {
                            selectedStage = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  ...opportunities
                      .where((opp) => selectedStage == "All Stages" || opp["stage"] == selectedStage)
                      .map((opportunity) => _buildOpportunityCard(opportunity)),
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
          Icon(icon, color: color, size: 32),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
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
  
  Widget _buildStageCard(Map<String, dynamic> stage) {
    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: (stage["color"] as Color).withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: (stage["color"] as Color).withAlpha(100)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: stage["color"] as Color,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Icon(
              stage["icon"] as IconData,
              color: Colors.white,
              size: 16,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${stage["stage"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${stage["count"]} opportunities",
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
                "\$${((stage["totalValue"] as int).toDouble()).currency}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Text(
                "${(stage["conversionRate"] as num).toStringAsFixed(1)}% conversion",
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
    Color priorityColor = _getPriorityColor(opportunity["priority"] as String);
    
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
        spacing: spXs,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${opportunity["name"]}",
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
                  color: priorityColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${opportunity["priority"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: priorityColor,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "${opportunity["account"]} • ${opportunity["id"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Stage: ${opportunity["stage"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Owner: ${opportunity["owner"]}",
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
                    "\$${((opportunity["value"] as int).toDouble()).currency}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  Text(
                    "${opportunity["probability"]}% probability",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.schedule, size: 12, color: disabledBoldColor),
              SizedBox(width: 4),
              Text(
                "Close: ${opportunity["closeDate"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "Last activity: ${opportunity["lastActivity"]}",
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
  
  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Critical":
        return dangerColor;
      case "High":
        return warningColor;
      case "Medium":
        return infoColor;
      case "Low":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }
}
