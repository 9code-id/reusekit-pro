import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmSalesPipelineView extends StatefulWidget {
  const CrmSalesPipelineView({super.key});

  @override
  State<CrmSalesPipelineView> createState() => _CrmSalesPipelineViewState();
}

class _CrmSalesPipelineViewState extends State<CrmSalesPipelineView> {
  int currentTab = 0;
  
  // Filters
  String selectedPeriod = "this_month";
  String selectedSalesperson = "all";
  String selectedSource = "all";
  String searchQuery = "";
  
  // Pipeline configuration
  String stageName = "";
  String stageDescription = "";
  int stageDuration = 7;
  bool requiresApproval = false;
  
  List<Map<String, dynamic>> pipelineStages = [
    {
      "id": 1,
      "name": "Lead Qualification",
      "deals_count": 45,
      "total_value": 125000,
      "avg_duration": 5,
      "conversion_rate": 78,
      "color": infoColor,
      "order": 1,
    },
    {
      "id": 2,
      "name": "Initial Contact",
      "deals_count": 32,
      "total_value": 98000,
      "avg_duration": 3,
      "conversion_rate": 85,
      "color": primaryColor,
      "order": 2,
    },
    {
      "id": 3,
      "name": "Proposal Sent",
      "deals_count": 18,
      "total_value": 78000,
      "avg_duration": 10,
      "conversion_rate": 65,
      "color": warningColor,
      "order": 3,
    },
    {
      "id": 4,
      "name": "Negotiation",
      "deals_count": 12,
      "total_value": 54000,
      "avg_duration": 7,
      "conversion_rate": 72,
      "color": secondaryColor,
      "order": 4,
    },
    {
      "id": 5,
      "name": "Closed Won",
      "deals_count": 8,
      "total_value": 42000,
      "avg_duration": 2,
      "conversion_rate": 100,
      "color": successColor,
      "order": 5,
    },
  ];

  List<Map<String, dynamic>> pipelineDeals = [
    {
      "id": 1,
      "company": "TechCorp Solutions",
      "contact": "John Smith",
      "value": 25000,
      "stage": "Proposal Sent",
      "probability": 70,
      "source": "Website",
      "salesperson": "Sarah Johnson",
      "created_date": "2024-01-15",
      "next_action": "Follow up on proposal",
      "next_action_date": "2024-01-20",
      "priority": "high",
    },
    {
      "id": 2,
      "company": "Global Industries",
      "contact": "Emily Davis",
      "value": 45000,
      "stage": "Negotiation",
      "probability": 85,
      "source": "Referral",
      "salesperson": "Mike Wilson",
      "created_date": "2024-01-10",
      "next_action": "Send contract",
      "next_action_date": "2024-01-18",
      "priority": "high",
    },
    {
      "id": 3,
      "company": "StartupXYZ",
      "contact": "Alex Chen",
      "value": 15000,
      "stage": "Initial Contact",
      "probability": 45,
      "source": "Cold Email",
      "salesperson": "Sarah Johnson",
      "created_date": "2024-01-12",
      "next_action": "Schedule demo",
      "next_action_date": "2024-01-19",
      "priority": "medium",
    },
    {
      "id": 4,
      "company": "Enterprise Co",
      "contact": "Lisa Brown",
      "value": 75000,
      "stage": "Lead Qualification",
      "probability": 30,
      "source": "Trade Show",
      "salesperson": "Tom Anderson",
      "created_date": "2024-01-08",
      "next_action": "Qualify budget",
      "next_action_date": "2024-01-21",
      "priority": "low",
    },
  ];

  List<Map<String, dynamic>> pipelineMetrics = [
    {"label": "Total Pipeline Value", "value": "\$425,000", "change": "+12%", "trend": "up"},
    {"label": "Number of Deals", "value": "115", "change": "+8%", "trend": "up"},
    {"label": "Average Deal Size", "value": "\$3,696", "change": "+3%", "trend": "up"},
    {"label": "Win Rate", "value": "24%", "change": "+2%", "trend": "up"},
    {"label": "Average Sales Cycle", "value": "32 days", "change": "-3 days", "trend": "down"},
    {"label": "Monthly Recurring Revenue", "value": "\$28,500", "change": "+15%", "trend": "up"},
  ];

  List<Map<String, dynamic>> topPerformers = [
    {
      "name": "Sarah Johnson",
      "deals_closed": 12,
      "revenue_generated": 185000,
      "win_rate": 78,
      "avg_deal_size": 15416,
    },
    {
      "name": "Mike Wilson",
      "deals_closed": 10,
      "revenue_generated": 165000,
      "win_rate": 72,
      "avg_deal_size": 16500,
    },
    {
      "name": "Tom Anderson",
      "deals_closed": 8,
      "revenue_generated": 145000,
      "win_rate": 65,
      "avg_deal_size": 18125,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Sales Pipeline",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Pipeline", icon: Icon(Icons.timeline)),
        Tab(text: "Deals", icon: Icon(Icons.handshake)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "Settings", icon: Icon(Icons.settings)),
      ],
      tabChildren: [
        _buildPipelineTab(),
        _buildDealsTab(),
        _buildAnalyticsTab(),
        _buildSettingsTab(),
      ],
    );
  }

  Widget _buildPipelineTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildPipelineOverviewCard(),
          _buildPipelineStagesCard(),
        ],
      ),
    );
  }

  Widget _buildPipelineOverviewCard() {
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
          Text(
            "Pipeline Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildOverviewMetric("Total Value", "\$425K", successColor),
              ),
              Expanded(
                child: _buildOverviewMetric("Active Deals", "115", primaryColor),
              ),
              Expanded(
                child: _buildOverviewMetric("Win Rate", "24%", infoColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewMetric(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
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

  Widget _buildPipelineStagesCard() {
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
              Expanded(
                child: Text(
                  "Pipeline Stages",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              QButton(
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          QHorizontalScroll(
            children: pipelineStages.map((stage) => _buildPipelineStageCard(stage)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPipelineStageCard(Map<String, dynamic> stage) {
    return Container(
      width: 200,
      margin: EdgeInsets.only(right: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: (stage["color"] as Color).withAlpha(10),
        border: Border.all(color: stage["color"] as Color),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
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
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${stage["name"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "${stage["deals_count"]} deals",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 12,
            ),
          ),
          Text(
            "\$${((stage["total_value"] as int) / 1000).toInt()}K",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "${stage["avg_duration"]} days avg",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 10,
                  ),
                ),
              ),
              Text(
                "${stage["conversion_rate"]}%",
                style: TextStyle(
                  color: stage["color"] as Color,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDealsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildDealsFiltersCard(),
          _buildDealsListCard(),
        ],
      ),
    );
  }

  Widget _buildDealsFiltersCard() {
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
          Text(
            "Filter Deals",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          QTextField(
            label: "Search deals",
            value: searchQuery,
            hint: "Company name, contact, or deal ID",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Salesperson",
                  value: selectedSalesperson,
                  items: [
                    {"label": "All Salespeople", "value": "all"},
                    {"label": "Sarah Johnson", "value": "sarah"},
                    {"label": "Mike Wilson", "value": "mike"},
                    {"label": "Tom Anderson", "value": "tom"},
                  ],
                  onChanged: (value, label) {
                    selectedSalesperson = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Source",
                  value: selectedSource,
                  items: [
                    {"label": "All Sources", "value": "all"},
                    {"label": "Website", "value": "website"},
                    {"label": "Referral", "value": "referral"},
                    {"label": "Cold Email", "value": "cold_email"},
                    {"label": "Trade Show", "value": "trade_show"},
                  ],
                  onChanged: (value, label) {
                    selectedSource = value;
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

  Widget _buildDealsListCard() {
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
              Expanded(
                child: Text(
                  "Active Deals",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              QButton(
                label: "Add Deal",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          ...pipelineDeals.map((deal) => _buildDealItem(deal)),
        ],
      ),
    );
  }

  Widget _buildDealItem(Map<String, dynamic> deal) {
    Color priorityColor = deal["priority"] == "high" 
        ? dangerColor 
        : deal["priority"] == "medium" 
        ? warningColor 
        : successColor;

    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${deal["company"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
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
                  "${deal["priority"]}".toUpperCase(),
                  style: TextStyle(
                    color: priorityColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "${deal["contact"]} • ${deal["salesperson"]}",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 12,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "\$${((deal["value"] as int).toDouble()).currency}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Text(
                "${deal["probability"]}% probability",
                style: TextStyle(
                  color: successColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.schedule,
                  color: infoColor,
                  size: 14,
                ),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "${deal["next_action"]} - ${deal["next_action_date"]}",
                    style: TextStyle(
                      color: infoColor,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${deal["stage"]}",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: spXs),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: secondaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${deal["source"]}",
                  style: TextStyle(
                    color: secondaryColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Spacer(),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildAnalyticsFiltersCard(),
          _buildMetricsCard(),
          _buildPerformanceCard(),
        ],
      ),
    );
  }

  Widget _buildAnalyticsFiltersCard() {
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
          Text(
            "Analytics Period",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          QDropdownField(
            label: "Time Period",
            value: selectedPeriod,
            items: [
              {"label": "This Month", "value": "this_month"},
              {"label": "Last Month", "value": "last_month"},
              {"label": "This Quarter", "value": "this_quarter"},
              {"label": "This Year", "value": "this_year"},
            ],
            onChanged: (value, label) {
              selectedPeriod = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMetricsCard() {
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
          Text(
            "Key Metrics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          Column(
            spacing: spXs,
            children: pipelineMetrics.map((metric) {
              Color trendColor = metric["trend"] == "up" 
                  ? successColor 
                  : metric["trend"] == "down" 
                  ? dangerColor 
                  : disabledBoldColor;
              IconData trendIcon = metric["trend"] == "up" 
                  ? Icons.trending_up 
                  : metric["trend"] == "down" 
                  ? Icons.trending_down 
                  : Icons.trending_flat;

              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  border: Border.all(color: disabledOutlineBorderColor),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        "${metric["label"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${metric["value"]}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            trendIcon,
                            color: trendColor,
                            size: 16,
                          ),
                          SizedBox(width: 2),
                          Text(
                            "${metric["change"]}",
                            style: TextStyle(
                              color: trendColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
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

  Widget _buildPerformanceCard() {
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
          Text(
            "Top Performers",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          ...topPerformers.map((performer) => _buildPerformerItem(performer)),
        ],
      ),
    );
  }

  Widget _buildPerformerItem(Map<String, dynamic> performer) {
    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person,
                  color: primaryColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${performer["name"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "${performer["deals_closed"]} deals closed",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "\$${((performer["revenue_generated"] as int) / 1000).toInt()}K",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Win Rate: ${performer["win_rate"]}%",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  "Avg Deal: \$${((performer["avg_deal_size"] as int).toDouble()).currency}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildStageManagementCard(),
          _buildPipelineSettingsCard(),
        ],
      ),
    );
  }

  Widget _buildStageManagementCard() {
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
          Text(
            "Add New Stage",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          QTextField(
            label: "Stage Name",
            value: stageName,
            hint: "e.g., Proposal Review",
            onChanged: (value) {
              stageName = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Stage Description",
            value: stageDescription,
            hint: "Describe what happens in this stage",
            onChanged: (value) {
              stageDescription = value;
              setState(() {});
            },
          ),
          QNumberField(
            label: "Average Duration (days)",
            value: stageDuration.toString(),
            onChanged: (value) {
              stageDuration = int.tryParse(value) ?? 0;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Requires Approval",
                      "value": true,
                      "checked": requiresApproval,
                    }
                  ],
                  value: [
                    if (requiresApproval)
                      {
                        "label": "Requires Approval",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    requiresApproval = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Add Stage",
              size: bs.md,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPipelineSettingsCard() {
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
          Text(
            "Pipeline Configuration",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Current Stages",
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          ...pipelineStages.map((stage) => _buildStageConfigItem(stage)),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Save Configuration",
              size: bs.md,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStageConfigItem(Map<String, dynamic> stage) {
    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
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
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            "${stage["avg_duration"]} days",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 12,
            ),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.edit,
            size: bs.sm,
            onPressed: () {},
          ),
          SizedBox(width: spXs),
          QButton(
            icon: Icons.delete,
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
