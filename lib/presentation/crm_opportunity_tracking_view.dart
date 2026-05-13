import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmOpportunityTrackingView extends StatefulWidget {
  const CrmOpportunityTrackingView({super.key});

  @override
  State<CrmOpportunityTrackingView> createState() => _CrmOpportunityTrackingViewState();
}

class _CrmOpportunityTrackingViewState extends State<CrmOpportunityTrackingView> {
  String selectedTimeframe = "This Month";
  String selectedSource = "All";
  String selectedStage = "All";

  List<Map<String, dynamic>> opportunities = [
    {
      "id": "OPP001",
      "title": "Enterprise ERP Implementation",
      "company": "Manufacturing Corp",
      "value": 250000.0,
      "stage": "Proposal",
      "probability": 70,
      "source": "Referral",
      "owner": "Sarah Wilson",
      "created": "2024-01-01",
      "lastContact": "2024-01-08",
      "nextAction": "Follow-up call scheduled",
      "nextActionDate": "2024-01-10",
      "score": 85,
      "priority": "High",
      "avatar": "https://picsum.photos/50/50?random=1",
      "tags": ["Enterprise", "ERP", "Manufacturing"],
      "activities": 15,
      "documents": 8,
      "contacts": 4,
    },
    {
      "id": "OPP002",
      "title": "Cloud Migration Project",
      "company": "TechStartup Inc",
      "value": 120000.0,
      "stage": "Qualified",
      "probability": 60,
      "source": "Website",
      "owner": "Mike Johnson",
      "created": "2024-01-03",
      "lastContact": "2024-01-07",
      "nextAction": "Technical demo",
      "nextActionDate": "2024-01-12",
      "score": 78,
      "priority": "Medium",
      "avatar": "https://picsum.photos/50/50?random=2",
      "tags": ["Cloud", "Migration", "SaaS"],
      "activities": 12,
      "documents": 5,
      "contacts": 3,
    },
    {
      "id": "OPP003",
      "title": "Security Audit & Compliance",
      "company": "Financial Services Ltd",
      "value": 85000.0,
      "stage": "Discovery",
      "probability": 45,
      "source": "Cold Call",
      "owner": "Emily Chen",
      "created": "2024-01-05",
      "lastContact": "2024-01-06",
      "nextAction": "Send proposal",
      "nextActionDate": "2024-01-11",
      "score": 65,
      "priority": "High",
      "avatar": "https://picsum.photos/50/50?random=3",
      "tags": ["Security", "Compliance", "Audit"],
      "activities": 8,
      "documents": 3,
      "contacts": 2,
    },
    {
      "id": "OPP004",
      "title": "Mobile App Development",
      "company": "Retail Chain",
      "value": 95000.0,
      "stage": "Negotiation",
      "probability": 85,
      "source": "Partner",
      "owner": "David Brown",
      "created": "2023-12-20",
      "lastContact": "2024-01-09",
      "nextAction": "Contract review",
      "nextActionDate": "2024-01-10",
      "score": 92,
      "priority": "Critical",
      "avatar": "https://picsum.photos/50/50?random=4",
      "tags": ["Mobile", "Retail", "E-commerce"],
      "activities": 25,
      "documents": 12,
      "contacts": 6,
    },
    {
      "id": "OPP005",
      "title": "Data Analytics Solution",
      "company": "Healthcare Group",
      "value": 180000.0,
      "stage": "Proposal",
      "probability": 75,
      "source": "Trade Show",
      "owner": "Lisa Wang",
      "created": "2023-12-28",
      "lastContact": "2024-01-08",
      "nextAction": "Board presentation",
      "nextActionDate": "2024-01-15",
      "score": 88,
      "priority": "High",
      "avatar": "https://picsum.photos/50/50?random=5",
      "tags": ["Analytics", "Healthcare", "BI"],
      "activities": 18,
      "documents": 10,
      "contacts": 5,
    },
  ];

  List<Map<String, dynamic>> sourceOptions = [
    {"label": "All Sources", "value": "All"},
    {"label": "Website", "value": "Website"},
    {"label": "Referral", "value": "Referral"},
    {"label": "Cold Call", "value": "Cold Call"},
    {"label": "Email Campaign", "value": "Email Campaign"},
    {"label": "Social Media", "value": "Social Media"},
    {"label": "Trade Show", "value": "Trade Show"},
    {"label": "Partner", "value": "Partner"},
  ];

  List<Map<String, dynamic>> stageOptions = [
    {"label": "All Stages", "value": "All"},
    {"label": "Discovery", "value": "Discovery"},
    {"label": "Qualified", "value": "Qualified"},
    {"label": "Proposal", "value": "Proposal"},
    {"label": "Negotiation", "value": "Negotiation"},
  ];

  List<Map<String, dynamic>> timeframeOptions = [
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "Last 30 Days", "value": "Last 30 Days"},
    {"label": "Last 90 Days", "value": "Last 90 Days"},
  ];

  List<Map<String, dynamic>> get filteredOpportunities {
    return opportunities.where((opp) {
      bool matchesSource = selectedSource == "All" || opp["source"] == selectedSource;
      bool matchesStage = selectedStage == "All" || opp["stage"] == selectedStage;
      return matchesSource && matchesStage;
    }).toList();
  }

  Color _getStageColor(String stage) {
    switch (stage) {
      case "Discovery":
        return infoColor;
      case "Qualified":
        return warningColor;
      case "Proposal":
        return primaryColor;
      case "Negotiation":
        return successColor;
      default:
        return disabledColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Critical":
        return dangerColor;
      case "High":
        return warningColor;
      case "Medium":
        return primaryColor;
      case "Low":
        return successColor;
      default:
        return disabledColor;
    }
  }

  Color _getScoreColor(int score) {
    if (score >= 80) return successColor;
    if (score >= 60) return warningColor;
    return dangerColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Opportunity Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              _showAnalyticsDialog();
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              _showMoreActions();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Summary Cards
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${filteredOpportunities.length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Opportunities",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "\$${((filteredOpportunities.fold(0.0, (sum, opp) => sum + (opp["value"] as double))) / 1000).toStringAsFixed(0)}K",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Total Value",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${(filteredOpportunities.fold(0, (sum, opp) => sum + (opp["score"] as int)) / filteredOpportunities.length).toStringAsFixed(0)}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Avg Score",
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

            // Filters
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
                    label: "Source",
                    items: sourceOptions,
                    value: selectedSource,
                    onChanged: (value, label) {
                      selectedSource = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Stage",
                    items: stageOptions,
                    value: selectedStage,
                    onChanged: (value, label) {
                      selectedStage = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.refresh,
                  size: bs.sm,
                  onPressed: () {
                    selectedSource = "All";
                    selectedStage = "All";
                    setState(() {});
                  },
                ),
              ],
            ),

            // Opportunity Heat Map
            Container(
              width: double.infinity,
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
                    "Opportunity Heat Map",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Container(
                    height: 120,
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        childAspectRatio: 1,
                        crossAxisSpacing: spXs,
                        mainAxisSpacing: spXs,
                      ),
                      itemCount: 25,
                      itemBuilder: (context, index) {
                        double intensity = (index % 4) / 3; // Mock data
                        return Container(
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha((intensity * 255).toInt()),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        );
                      },
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Less",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "More",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Top Opportunities by Score
            Container(
              width: double.infinity,
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
                    "Top Opportunities by Score",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...filteredOpportunities
                      .where((opp) => (opp["score"] as int) >= 80)
                      .map((opp) => _buildTopOpportunityCard(opp)),
                ],
              ),
            ),

            // Opportunities List
            ...filteredOpportunities.map((opportunity) => _buildOpportunityCard(opportunity)),

            // Next Actions Summary
            Container(
              width: double.infinity,
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
                    "Upcoming Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...filteredOpportunities
                      .where((opp) => opp["nextActionDate"] != null)
                      .map((opp) => _buildNextActionItem(opp)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOpportunityCard(Map<String, dynamic> opportunity) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
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
          // Header Row
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage("${opportunity["avatar"]}"),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${opportunity["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${opportunity["company"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getScoreColor(opportunity["score"] as int).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "Score: ${opportunity["score"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _getScoreColor(opportunity["score"] as int),
                      ),
                    ),
                  ),
                  SizedBox(height: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getPriorityColor("${opportunity["priority"]}").withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${opportunity["priority"]}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: _getPriorityColor("${opportunity["priority"]}"),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Value and Probability
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Value",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${(opportunity["value"] as double).currency}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: successColor,
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
                      "Probability",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "${opportunity["probability"]}%",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: LinearProgressIndicator(
                            value: (opportunity["probability"] as int) / 100,
                            backgroundColor: disabledColor,
                            valueColor: AlwaysStoppedAnimation(primaryColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStageColor("${opportunity["stage"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${opportunity["stage"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getStageColor("${opportunity["stage"]}"),
                  ),
                ),
              ),
            ],
          ),

          // Details Row
          Row(
            children: [
              Icon(
                Icons.person,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${opportunity["owner"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spSm),
              Icon(
                Icons.source,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${opportunity["source"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "Last: ${opportunity["lastContact"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),

          // Next Action
          if (opportunity["nextAction"] != null)
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.schedule,
                    size: 16,
                    color: warningColor,
                  ),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "${opportunity["nextAction"]} - ${opportunity["nextActionDate"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: warningColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // Activity Summary
          Row(
            children: [
              _buildActivityBadge(Icons.sports, "${opportunity["activities"]}", "Activities"),
              SizedBox(width: spSm),
              _buildActivityBadge(Icons.folder, "${opportunity["documents"]}", "Documents"),
              SizedBox(width: spSm),
              _buildActivityBadge(Icons.people, "${opportunity["contacts"]}", "Contacts"),
              Spacer(),
              QButton(
                icon: Icons.visibility,
                size: bs.sm,
                onPressed: () {
                  //navigateTo opportunity detail view
                },
              ),
            ],
          ),

          // Tags
          if ((opportunity["tags"] as List).isNotEmpty)
            Wrap(
              spacing: spXs,
              children: (opportunity["tags"] as List).map((tag) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "$tag",
                    style: TextStyle(
                      fontSize: 10,
                      color: infoColor,
                    ),
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildActivityBadge(IconData icon, String count, String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: primaryColor,
          ),
          SizedBox(width: 4),
          Text(
            count,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopOpportunityCard(Map<String, dynamic> opportunity) {
    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        color: successColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: successColor.withAlpha(30)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage("${opportunity["avatar"]}"),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${opportunity["title"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${opportunity["company"]}",
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
                "Score: ${opportunity["score"]}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
              Text(
                "\$${((opportunity["value"] as double) / 1000).toStringAsFixed(0)}K",
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

  Widget _buildNextActionItem(Map<String, dynamic> opportunity) {
    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        color: warningColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: warningColor.withAlpha(30)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.schedule,
            size: 18,
            color: warningColor,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${opportunity["nextAction"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${opportunity["title"]} - ${opportunity["nextActionDate"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            icon: Icons.check,
            size: bs.sm,
            onPressed: () {
              ss("Action marked as completed");
            },
          ),
        ],
      ),
    );
  }

  void _showAnalyticsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Opportunity Analytics"),
          content: Container(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: spSm,
              children: [
                _buildAnalyticsRow("Total Opportunities", "${opportunities.length}"),
                _buildAnalyticsRow("Average Deal Size", "\$${(opportunities.fold(0.0, (sum, opp) => sum + (opp["value"] as double)) / opportunities.length / 1000).toStringAsFixed(0)}K"),
                _buildAnalyticsRow("High Priority Deals", "${opportunities.where((opp) => opp["priority"] == "High" || opp["priority"] == "Critical").length}"),
                _buildAnalyticsRow("Win Rate", "${((opportunities.where((opp) => opp["stage"] == "Negotiation").length / opportunities.length) * 100).toStringAsFixed(0)}%"),
                _buildAnalyticsRow("Average Score", "${(opportunities.fold(0, (sum, opp) => sum + (opp["score"] as int)) / opportunities.length).toStringAsFixed(0)}"),
              ],
            ),
          ),
          actions: [
            QButton(
              label: "Close",
              size: bs.sm,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildAnalyticsRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  void _showMoreActions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              Text(
                "More Actions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ListTile(
                leading: Icon(Icons.file_download),
                title: Text("Export Opportunities"),
                onTap: () {
                  Navigator.pop(context);
                  ss("Opportunities exported successfully");
                },
              ),
              ListTile(
                leading: Icon(Icons.email),
                title: Text("Send Weekly Report"),
                onTap: () {
                  Navigator.pop(context);
                  ss("Weekly report sent successfully");
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text("Configure Tracking"),
                onTap: () {
                  Navigator.pop(context);
                  //navigateTo tracking settings
                },
              ),
              ListTile(
                leading: Icon(Icons.notifications),
                title: Text("Setup Alerts"),
                onTap: () {
                  Navigator.pop(context);
                  //navigateTo alert settings
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
