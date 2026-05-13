import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmDealStagesView extends StatefulWidget {
  const CrmDealStagesView({super.key});

  @override
  State<CrmDealStagesView> createState() => _CrmDealStagesViewState();
}

class _CrmDealStagesViewState extends State<CrmDealStagesView> {
  String selectedFilter = "All";
  String selectedOwner = "All";

  List<Map<String, dynamic>> stages = [
    {
      "id": "stage_1",
      "name": "Discovery",
      "description": "Initial contact and needs assessment",
      "color": infoColor,
      "order": 1,
      "probability": 20,
      "averageDuration": "7 days",
      "dealCount": 8,
      "totalValue": 420000.0,
    },
    {
      "id": "stage_2",
      "name": "Qualified",
      "description": "Lead qualification and budget confirmation",
      "color": warningColor,
      "order": 2,
      "probability": 40,
      "averageDuration": "14 days",
      "dealCount": 5,
      "totalValue": 320000.0,
    },
    {
      "id": "stage_3",
      "name": "Proposal",
      "description": "Proposal preparation and presentation",
      "color": primaryColor,
      "order": 3,
      "probability": 65,
      "averageDuration": "10 days",
      "dealCount": 3,
      "totalValue": 285000.0,
    },
    {
      "id": "stage_4",
      "name": "Negotiation",
      "description": "Contract negotiation and finalization",
      "color": successColor,
      "order": 4,
      "probability": 85,
      "averageDuration": "5 days",
      "dealCount": 2,
      "totalValue": 110000.0,
    },
    {
      "id": "stage_5",
      "name": "Closed Won",
      "description": "Deal successfully closed",
      "color": successColor,
      "order": 5,
      "probability": 100,
      "averageDuration": "-",
      "dealCount": 12,
      "totalValue": 980000.0,
    },
    {
      "id": "stage_6",
      "name": "Closed Lost",
      "description": "Deal lost or cancelled",
      "color": dangerColor,
      "order": 6,
      "probability": 0,
      "averageDuration": "-",
      "dealCount": 4,
      "totalValue": 0.0,
    },
  ];

  List<Map<String, dynamic>> pipelineDeals = [
    {
      "id": "DEAL001",
      "title": "Enterprise Software License",
      "company": "TechCorp Solutions",
      "value": 85000.0,
      "stage": "Proposal",
      "probability": 75,
      "owner": "Sarah Wilson",
      "lastActivity": "2024-01-08",
      "avatar": "https://picsum.photos/40/40?random=1",
    },
    {
      "id": "DEAL002",
      "title": "Digital Marketing Campaign",
      "company": "StartupHub Inc",
      "value": 25000.0,
      "stage": "Negotiation",
      "probability": 90,
      "owner": "Mike Johnson",
      "lastActivity": "2024-01-09",
      "avatar": "https://picsum.photos/40/40?random=2",
    },
    {
      "id": "DEAL003",
      "title": "Cloud Infrastructure Setup",
      "company": "Global Finance Ltd",
      "value": 120000.0,
      "stage": "Qualified",
      "probability": 60,
      "owner": "Emily Chen",
      "lastActivity": "2024-01-07",
      "avatar": "https://picsum.photos/40/40?random=3",
    },
    {
      "id": "DEAL004",
      "title": "Mobile App Development",
      "company": "Retail Masters",
      "value": 65000.0,
      "stage": "Discovery",
      "probability": 40,
      "owner": "David Brown",
      "lastActivity": "2024-01-06",
      "avatar": "https://picsum.photos/40/40?random=4",
    },
    {
      "id": "DEAL005",
      "title": "Data Analytics Platform",
      "company": "Healthcare Innovations",
      "value": 95000.0,
      "stage": "Discovery",
      "probability": 35,
      "owner": "Lisa Wang",
      "lastActivity": "2024-01-05",
      "avatar": "https://picsum.photos/40/40?random=5",
    },
    {
      "id": "DEAL006",
      "title": "Security Audit Service",
      "company": "Financial Corp",
      "value": 45000.0,
      "stage": "Qualified",
      "probability": 55,
      "owner": "Sarah Wilson",
      "lastActivity": "2024-01-04",
      "avatar": "https://picsum.photos/40/40?random=6",
    },
  ];

  List<Map<String, dynamic>> ownerOptions = [
    {"label": "All Owners", "value": "All"},
    {"label": "Sarah Wilson", "value": "Sarah Wilson"},
    {"label": "Mike Johnson", "value": "Mike Johnson"},
    {"label": "Emily Chen", "value": "Emily Chen"},
    {"label": "David Brown", "value": "David Brown"},
    {"label": "Lisa Wang", "value": "Lisa Wang"},
  ];

  List<Map<String, dynamic>> getDealsForStage(String stageName) {
    return pipelineDeals.where((deal) {
      bool matchesStage = deal["stage"] == stageName;
      bool matchesOwner = selectedOwner == "All" || deal["owner"] == selectedOwner;
      return matchesStage && matchesOwner;
    }).toList();
  }

  double getTotalPipelineValue() {
    return pipelineDeals
        .where((deal) => deal["stage"] != "Closed Lost")
        .fold(0.0, (sum, deal) => sum + (deal["value"] as double));
  }

  double getWeightedPipelineValue() {
    return pipelineDeals
        .where((deal) => deal["stage"] != "Closed Lost" && deal["stage"] != "Closed Won")
        .fold(0.0, (sum, deal) => sum + ((deal["value"] as double) * (deal["probability"] as int) / 100));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Deal Stages"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showAddStageDialog();
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterDialog();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Pipeline Summary
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
                        child: Column(
                          children: [
                            Text(
                              "\$${(getTotalPipelineValue() / 1000).toStringAsFixed(0)}K",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Total Pipeline",
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
                          children: [
                            Text(
                              "\$${(getWeightedPipelineValue() / 1000).toStringAsFixed(0)}K",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Weighted Pipeline",
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
                          children: [
                            Text(
                              "${pipelineDeals.where((d) => d["stage"] != "Closed Lost" && d["stage"] != "Closed Won").length}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "Active Deals",
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
                ],
              ),
            ),

            // Filter Options
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Filter by Owner",
                    items: ownerOptions,
                    value: selectedOwner,
                    onChanged: (value, label) {
                      selectedOwner = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.refresh,
                  size: bs.sm,
                  onPressed: () {
                    selectedOwner = "All";
                    setState(() {});
                  },
                ),
              ],
            ),

            // Stage Pipeline
            ...stages.map((stage) => _buildStageCard(stage)),

            // Stage Statistics
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
                    "Stage Performance",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...stages.where((s) => s["name"] != "Closed Won" && s["name"] != "Closed Lost").map((stage) => 
                    _buildStagePerformanceRow(stage)
                  ),
                ],
              ),
            ),

            // Conversion Funnel
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
                    "Conversion Funnel",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...stages.where((s) => s["name"] != "Closed Lost").map((stage) => 
                    _buildFunnelStage(stage)
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStageCard(Map<String, dynamic> stage) {
    List<Map<String, dynamic>> stageDeals = getDealsForStage(stage["name"]);
    double stageValue = stageDeals.fold(0.0, (sum, deal) => sum + (deal["value"] as double));

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stage Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: (stage["color"] as Color).withAlpha(20),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusMd),
                topRight: Radius.circular(radiusMd),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 40,
                  decoration: BoxDecoration(
                    color: stage["color"] as Color,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${stage["name"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: stage["color"] as Color,
                        ),
                      ),
                      Text(
                        "${stage["description"]}",
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
                      "${stageDeals.length} deals",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: stage["color"] as Color,
                      ),
                    ),
                    Text(
                      "\$${(stageValue / 1000).toStringAsFixed(0)}K",
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

          // Stage Metrics
          if (stage["name"] != "Closed Won" && stage["name"] != "Closed Lost")
            Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${stage["probability"]}%",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Probability",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${stage["averageDuration"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Avg Duration",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

          // Deals in Stage
          if (stageDeals.isNotEmpty)
            ...stageDeals.map((deal) => _buildStageDealCard(deal, stage["color"] as Color))
          else
            Container(
              padding: EdgeInsets.all(spSm),
              child: Text(
                "No deals in this stage",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStageDealCard(Map<String, dynamic> deal, Color stageColor) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: stageColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: stageColor.withAlpha(30)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage("${deal["avatar"]}"),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${deal["title"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${deal["company"]} • ${deal["owner"]}",
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
                "\$${((deal["value"] as double) / 1000).toStringAsFixed(0)}K",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
              Text(
                "${deal["probability"]}%",
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

  Widget _buildStagePerformanceRow(Map<String, dynamic> stage) {
    List<Map<String, dynamic>> stageDeals = getDealsForStage(stage["name"]);
    double conversionRate = stageDeals.isNotEmpty ? (stage["probability"] as int).toDouble() : 0.0;

    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      child: Row(
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
              "${stage["name"]}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: primaryColor,
              ),
            ),
          ),
          Text(
            "${stageDeals.length} deals",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(width: spSm),
          Container(
            width: 60,
            child: LinearProgressIndicator(
              value: conversionRate / 100,
              backgroundColor: disabledColor,
              valueColor: AlwaysStoppedAnimation(stage["color"] as Color),
            ),
          ),
          SizedBox(width: spSm),
          Text(
            "${conversionRate.toStringAsFixed(0)}%",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: stage["color"] as Color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFunnelStage(Map<String, dynamic> stage) {
    List<Map<String, dynamic>> stageDeals = getDealsForStage(stage["name"]);
    double maxDeals = stages.map((s) => getDealsForStage(s["name"]).length).reduce((a, b) => a > b ? a : b).toDouble();
    double width = stageDeals.length / maxDeals;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            children: [
              Text(
                "${stage["name"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${stageDeals.length} deals",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: 8,
            decoration: BoxDecoration(
              color: disabledColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: width,
              child: Container(
                decoration: BoxDecoration(
                  color: stage["color"] as Color,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text("Filter Deals"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: spSm,
                children: [
                  QDropdownField(
                    label: "Owner",
                    items: ownerOptions,
                    value: selectedOwner,
                    onChanged: (value, label) {
                      selectedOwner = value;
                      setDialogState(() {});
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    selectedOwner = "All";
                    setDialogState(() {});
                  },
                  child: Text("Clear"),
                ),
                QButton(
                  label: "Apply",
                  size: bs.sm,
                  onPressed: () {
                    setState(() {});
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showAddStageDialog() {
    String stageName = "";
    String stageDescription = "";
    String selectedColor = "blue";

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text("Add New Stage"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: spSm,
                children: [
                  QTextField(
                    label: "Stage Name",
                    value: stageName,
                    onChanged: (value) {
                      stageName = value;
                      setDialogState(() {});
                    },
                  ),
                  QTextField(
                    label: "Description",
                    value: stageDescription,
                    onChanged: (value) {
                      stageDescription = value;
                      setDialogState(() {});
                    },
                  ),
                  QDropdownField(
                    label: "Color Theme",
                    items: [
                      {"label": "Blue", "value": "blue"},
                      {"label": "Green", "value": "green"},
                      {"label": "Orange", "value": "orange"},
                      {"label": "Purple", "value": "purple"},
                      {"label": "Red", "value": "red"},
                    ],
                    value: selectedColor,
                    onChanged: (value, label) {
                      selectedColor = value;
                      setDialogState(() {});
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel"),
                ),
                QButton(
                  label: "Add Stage",
                  size: bs.sm,
                  onPressed: () {
                    Navigator.pop(context);
                    ss("Stage added successfully");
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
