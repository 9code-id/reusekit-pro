import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaLeadSourcesView extends StatefulWidget {
  const CmaLeadSourcesView({super.key});

  @override
  State<CmaLeadSourcesView> createState() => _CmaLeadSourcesViewState();
}

class _CmaLeadSourcesViewState extends State<CmaLeadSourcesView> {
  String selectedPeriod = "This Month";
  String selectedMetric = "Leads";
  
  List<Map<String, dynamic>> periodItems = [
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
    {"label": "Last 30 Days", "value": "Last 30 Days"},
    {"label": "Last 90 Days", "value": "Last 90 Days"},
  ];
  
  List<Map<String, dynamic>> metricItems = [
    {"label": "Leads", "value": "Leads"},
    {"label": "Conversion Rate", "value": "Conversion Rate"},
    {"label": "Revenue", "value": "Revenue"},
    {"label": "Cost Per Lead", "value": "Cost Per Lead"},
  ];

  List<Map<String, dynamic>> leadSources = [
    {
      "id": "1",
      "name": "Website",
      "description": "Organic website visitors and contact form submissions",
      "leads": 145,
      "conversions": 23,
      "revenue": 125000,
      "cost": 8500,
      "trend": "up",
      "trendValue": 12.5,
      "icon": Icons.language,
      "color": primaryColor,
      "isActive": true,
    },
    {
      "id": "2",
      "name": "Social Media",
      "description": "Facebook, LinkedIn, Twitter, and Instagram campaigns",
      "leads": 89,
      "conversions": 18,
      "revenue": 95000,
      "cost": 12000,
      "trend": "up",
      "trendValue": 8.3,
      "icon": Icons.share,
      "color": infoColor,
      "isActive": true,
    },
    {
      "id": "3",
      "name": "Email Campaign",
      "description": "Newsletter and targeted email marketing campaigns",
      "leads": 67,
      "conversions": 15,
      "revenue": 78000,
      "cost": 3500,
      "trend": "stable",
      "trendValue": 0.0,
      "icon": Icons.email,
      "color": successColor,
      "isActive": true,
    },
    {
      "id": "4",
      "name": "Referral",
      "description": "Customer referrals and word-of-mouth marketing",
      "leads": 34,
      "conversions": 12,
      "revenue": 85000,
      "cost": 2000,
      "trend": "up",
      "trendValue": 15.2,
      "icon": Icons.people,
      "color": warningColor,
      "isActive": true,
    },
    {
      "id": "5",
      "name": "Paid Ads",
      "description": "Google Ads, Facebook Ads, and other paid advertising",
      "leads": 156,
      "conversions": 19,
      "revenue": 98000,
      "cost": 25000,
      "trend": "down",
      "trendValue": -5.7,
      "icon": Icons.campaign,
      "color": dangerColor,
      "isActive": true,
    },
    {
      "id": "6",
      "name": "Trade Shows",
      "description": "Industry events and trade show participation",
      "leads": 45,
      "conversions": 8,
      "revenue": 65000,
      "cost": 15000,
      "trend": "up",
      "trendValue": 22.1,
      "icon": Icons.event,
      "color": secondaryColor,
      "isActive": false,
    },
    {
      "id": "7",
      "name": "Cold Outreach",
      "description": "Cold calling and direct sales outreach",
      "leads": 28,
      "conversions": 5,
      "revenue": 45000,
      "cost": 8000,
      "trend": "down",
      "trendValue": -12.3,
      "icon": Icons.phone,
      "color": disabledBoldColor,
      "isActive": true,
    },
  ];

  double get totalLeads {
    return leadSources.fold(0.0, (sum, source) => sum + (source["leads"] as int));
  }

  double get totalConversions {
    return leadSources.fold(0.0, (sum, source) => sum + (source["conversions"] as int));
  }

  double get totalRevenue {
    return leadSources.fold(0.0, (sum, source) => sum + (source["revenue"] as int));
  }

  double get totalCost {
    return leadSources.fold(0.0, (sum, source) => sum + (source["cost"] as int));
  }

  double get overallConversionRate {
    if (totalLeads == 0) return 0.0;
    return (totalConversions / totalLeads) * 100;
  }

  double get overallROI {
    if (totalCost == 0) return 0.0;
    return ((totalRevenue - totalCost) / totalCost) * 100;
  }

  Color _getTrendColor(String trend) {
    switch (trend) {
      case "up":
        return successColor;
      case "down":
        return dangerColor;
      case "stable":
        return warningColor;
      default:
        return disabledColor;
    }
  }

  IconData _getTrendIcon(String trend) {
    switch (trend) {
      case "up":
        return Icons.trending_up;
      case "down":
        return Icons.trending_down;
      case "stable":
        return Icons.trending_flat;
      default:
        return Icons.trending_flat;
    }
  }

  void _addNewSource() {
    //navigateTo('CmaAddLeadSourceView')
  }

  void _editSource(Map<String, dynamic> source) {
    //navigateTo('CmaEditLeadSourceView')
  }

  void _viewSourceAnalytics(Map<String, dynamic> source) {
    //navigateTo('CmaLeadSourceAnalyticsView')
  }

  void _toggleSourceStatus(Map<String, dynamic> source) async {
    showLoading();
    await Future.delayed(Duration(seconds: 1));
    hideLoading();
    
    source["isActive"] = !source["isActive"];
    setState(() {});
    
    String status = source["isActive"] ? "activated" : "deactivated";
    ss("Lead source ${source["name"]} has been $status");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lead Sources"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: _addNewSource,
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.analytics,
            size: bs.sm,
            onPressed: () {
              //navigateTo('CmaLeadSourcesAnalyticsView')
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildHeader(),
            _buildFilters(),
            _buildOverallStats(),
            _buildSourcesOverview(),
            _buildSourcesList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(200)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Row(
        children: [
          Icon(
            Icons.source,
            color: Colors.white,
            size: 32,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Lead Source Analytics",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Track and optimize your lead generation channels",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withAlpha(200),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              "${leadSources.length} Sources",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Row(
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
            label: "Sort by Metric",
            items: metricItems,
            value: selectedMetric,
            onChanged: (value, label) {
              selectedMetric = value;
              setState(() {});
            },
          ),
        ),
      ],
    );
  }

  Widget _buildOverallStats() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            title: "Total Leads",
            value: "${totalLeads.toInt()}",
            icon: Icons.people,
            color: primaryColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard(
            title: "Conversion Rate",
            value: "${overallConversionRate.toStringAsFixed(1)}%",
            icon: Icons.percent,
            color: successColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard(
            title: "Total Revenue",
            value: "\$${(totalRevenue / 1000).toStringAsFixed(0)}K",
            icon: Icons.attach_money,
            color: warningColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard(
            title: "ROI",
            value: "${overallROI.toStringAsFixed(0)}%",
            icon: Icons.trending_up,
            color: infoColor,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH6,
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

  Widget _buildSourcesOverview() {
    List<Map<String, dynamic>> activeLeads = leadSources.where((source) => source["isActive"]).toList();
    activeLeads.sort((a, b) => (b["leads"] as int).compareTo(a["leads"] as int));
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.bar_chart,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Top Performing Sources",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QHorizontalScroll(
            children: List.generate(activeLeads.take(5).length, (index) {
              final source = activeLeads[index];
              return Container(
                width: 160,
                margin: EdgeInsets.only(right: index < 4 ? spSm : 0),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: (source["color"] as Color).withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: source["color"],
                    width: 1,
                  ),
                ),
                child: Column(
                  spacing: spXs,
                  children: [
                    Icon(
                      source["icon"],
                      color: source["color"],
                      size: 24,
                    ),
                    Text(
                      "${source["name"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: source["color"],
                      ),
                    ),
                    Text(
                      "${source["leads"]} leads",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${((source["conversions"] as int) / (source["leads"] as int) * 100).toStringAsFixed(1)}% conv.",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildSourcesList() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.list,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "All Lead Sources",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Column(
            spacing: spSm,
            children: List.generate(leadSources.length, (index) {
              final source = leadSources[index];
              return _buildSourceCard(source);
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildSourceCard(Map<String, dynamic> source) {
    double conversionRate = (source["conversions"] as int) / (source["leads"] as int) * 100;
    double costPerLead = (source["cost"] as int) / (source["leads"] as int);
    double roi = ((source["revenue"] as int) - (source["cost"] as int)) / (source["cost"] as int) * 100;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: source["isActive"] ? Colors.white : disabledColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: source["isActive"] 
            ? (source["color"] as Color).withAlpha(100)
            : disabledOutlineBorderColor,
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: (source["color"] as Color).withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(
                  source["icon"],
                  color: source["color"],
                  size: 24,
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
                            "${source["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: source["isActive"] ? primaryColor : disabledBoldColor,
                            ),
                          ),
                        ),
                        if (!source["isActive"])
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: disabledColor.withAlpha(100),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "INACTIVE",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        SizedBox(width: spXs),
                        Row(
                          children: [
                            Icon(
                              _getTrendIcon(source["trend"]),
                              size: 16,
                              color: _getTrendColor(source["trend"]),
                            ),
                            Text(
                              "${source["trendValue"].abs().toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: _getTrendColor(source["trend"]),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      "${source["description"]}",
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
          Divider(color: disabledOutlineBorderColor),
          Row(
            children: [
              Expanded(
                child: _buildMetricColumn("Leads", "${source["leads"]}", Icons.people),
              ),
              Expanded(
                child: _buildMetricColumn("Conv. Rate", "${conversionRate.toStringAsFixed(1)}%", Icons.percent),
              ),
              Expanded(
                child: _buildMetricColumn("Revenue", "\$${((source["revenue"] as int) / 1000).toStringAsFixed(0)}K", Icons.attach_money),
              ),
              Expanded(
                child: _buildMetricColumn("Cost/Lead", "\$${costPerLead.toStringAsFixed(0)}", Icons.payment),
              ),
              Expanded(
                child: _buildMetricColumn("ROI", "${roi.toStringAsFixed(0)}%", Icons.trending_up),
              ),
            ],
          ),
          Divider(color: disabledOutlineBorderColor),
          Row(
            children: [
              QButton(
                label: source["isActive"] ? "Deactivate" : "Activate",
                size: bs.sm,
                onPressed: () => _toggleSourceStatus(source),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Edit",
                size: bs.sm,
                onPressed: () => _editSource(source),
              ),
              Spacer(),
              QButton(
                icon: Icons.analytics,
                size: bs.sm,
                onPressed: () => _viewSourceAnalytics(source),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricColumn(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          size: 16,
          color: primaryColor,
        ),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }
}
