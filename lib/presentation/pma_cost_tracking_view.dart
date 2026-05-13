import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaCostTrackingView extends StatefulWidget {
  const PmaCostTrackingView({super.key});

  @override
  State<PmaCostTrackingView> createState() => _PmaCostTrackingViewState();
}

class _PmaCostTrackingViewState extends State<PmaCostTrackingView> {
  String selectedProject = "all";
  String selectedTimeRange = "thisMonth";
  String selectedCostType = "all";

  List<Map<String, dynamic>> projectOptions = [
    {"label": "All Projects", "value": "all"},
    {"label": "E-commerce Platform", "value": "ecommerce"},
    {"label": "Mobile App Development", "value": "mobile"},
    {"label": "Website Redesign", "value": "website"},
    {"label": "CRM System", "value": "crm"},
  ];

  List<Map<String, dynamic>> timeRangeOptions = [
    {"label": "This Week", "value": "thisWeek"},
    {"label": "This Month", "value": "thisMonth"},
    {"label": "Last Month", "value": "lastMonth"},
    {"label": "This Quarter", "value": "thisQuarter"},
    {"label": "This Year", "value": "thisYear"},
  ];

  List<Map<String, dynamic>> costTypeOptions = [
    {"label": "All Types", "value": "all"},
    {"label": "Labor Costs", "value": "labor"},
    {"label": "Material Costs", "value": "material"},
    {"label": "Equipment", "value": "equipment"},
    {"label": "External Services", "value": "external"},
    {"label": "Overhead", "value": "overhead"},
  ];

  List<Map<String, dynamic>> projectCosts = [
    {
      "project": "E-commerce Platform",
      "totalCost": 45000.0,
      "budgetedCost": 50000.0,
      "variance": -5000.0,
      "progress": 85,
      "status": "on_track",
      "dueDate": "2024-07-15",
      "costs": [
        {
          "type": "labor",
          "category": "Development",
          "amount": 25000.0,
          "hours": 400,
          "rate": 62.5,
        },
        {
          "type": "labor",
          "category": "Design",
          "amount": 8000.0,
          "hours": 100,
          "rate": 80.0,
        },
        {
          "type": "material",
          "category": "Software Licenses",
          "amount": 3500.0,
          "hours": 0,
          "rate": 0.0,
        },
        {
          "type": "external",
          "category": "Third-party APIs",
          "amount": 2500.0,
          "hours": 0,
          "rate": 0.0,
        },
        {
          "type": "equipment",
          "category": "Hardware",
          "amount": 6000.0,
          "hours": 0,
          "rate": 0.0,
        },
      ],
    },
    {
      "project": "Mobile App Development",
      "totalCost": 32000.0,
      "budgetedCost": 35000.0,
      "variance": -3000.0,
      "progress": 70,
      "status": "at_risk",
      "dueDate": "2024-08-30",
      "costs": [
        {
          "type": "labor",
          "category": "Development",
          "amount": 20000.0,
          "hours": 320,
          "rate": 62.5,
        },
        {
          "type": "labor",
          "category": "Testing",
          "amount": 5000.0,
          "hours": 80,
          "rate": 62.5,
        },
        {
          "type": "material",
          "category": "App Store Fees",
          "amount": 2000.0,
          "hours": 0,
          "rate": 0.0,
        },
        {
          "type": "external",
          "category": "Marketing",
          "amount": 5000.0,
          "hours": 0,
          "rate": 0.0,
        },
      ],
    },
    {
      "project": "Website Redesign",
      "totalCost": 18500.0,
      "budgetedCost": 20000.0,
      "variance": -1500.0,
      "progress": 95,
      "status": "completed",
      "dueDate": "2024-06-30",
      "costs": [
        {
          "type": "labor",
          "category": "Design",
          "amount": 12000.0,
          "hours": 150,
          "rate": 80.0,
        },
        {
          "type": "labor",
          "category": "Development",
          "amount": 4500.0,
          "hours": 72,
          "rate": 62.5,
        },
        {
          "type": "material",
          "category": "Images & Assets",
          "amount": 2000.0,
          "hours": 0,
          "rate": 0.0,
        },
      ],
    },
  ];

  double get totalProjectCosts => filteredProjects.fold(0.0, (sum, project) => sum + (project["totalCost"] as double));
  double get totalBudgetedCosts => filteredProjects.fold(0.0, (sum, project) => sum + (project["budgetedCost"] as double));
  double get totalVariance => totalBudgetedCosts - totalProjectCosts;

  List<Map<String, dynamic>> get filteredProjects {
    List<Map<String, dynamic>> filtered = projectCosts;
    
    if (selectedProject != "all") {
      filtered = filtered.where((project) => 
        (project["project"] as String).toLowerCase().contains(selectedProject.toLowerCase())
      ).toList();
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cost Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: _viewAnalytics,
          ),
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: _exportReport,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildCostOverview(),
            _buildFiltersSection(),
            _buildCostBreakdown(),
            _buildProjectsList(),
            _buildCostTrends(),
          ],
        ),
      ),
    );
  }

  Widget _buildCostOverview() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(200)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.trending_up,
                color: Colors.white,
                size: 28,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Project Costs",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                    Text(
                      "\$${totalProjectCosts.currency}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: totalVariance >= 0 ? successColor.withAlpha(40) : dangerColor.withAlpha(40),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${totalVariance >= 0 ? 'Under' : 'Over'} Budget",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Divider(color: Colors.white.withAlpha(100)),
          Row(
            children: [
              Expanded(
                child: _buildOverviewMetric(
                  "Budgeted",
                  "\$${totalBudgetedCosts.currency}",
                  Icons.account_balance,
                ),
              ),
              Container(
                height: 40,
                width: 1,
                color: Colors.white.withAlpha(100),
              ),
              Expanded(
                child: _buildOverviewMetric(
                  "Variance",
                  "${totalVariance >= 0 ? '+' : ''}\$${totalVariance.currency}",
                  totalVariance >= 0 ? Icons.trending_up : Icons.trending_down,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewMetric(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withAlpha(200),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFiltersSection() {
    return Container(
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
            "Filters",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Project",
                  items: projectOptions,
                  value: selectedProject,
                  onChanged: (value, label) {
                    selectedProject = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Time Range",
                  items: timeRangeOptions,
                  value: selectedTimeRange,
                  onChanged: (value, label) {
                    selectedTimeRange = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Cost Type",
            items: costTypeOptions,
            value: selectedCostType,
            onChanged: (value, label) {
              selectedCostType = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCostBreakdown() {
    Map<String, double> costsByType = {};
    
    for (var project in filteredProjects) {
      List<Map<String, dynamic>> costs = project["costs"] as List<Map<String, dynamic>>;
      for (var cost in costs) {
        String type = cost["type"];
        double amount = cost["amount"] as double;
        costsByType[type] = (costsByType[type] ?? 0) + amount;
      }
    }

    return Container(
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
            "Cost Breakdown by Type",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          ...costsByType.entries.map((entry) => _buildCostTypeItem(entry.key, entry.value)).toList(),
        ],
      ),
    );
  }

  Widget _buildCostTypeItem(String type, double amount) {
    Color color = _getCostTypeColor(type);
    IconData icon = _getCostTypeIcon(type);
    double percentage = totalProjectCosts > 0 ? (amount / totalProjectCosts) * 100 : 0;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(100)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
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
                  _getCostTypeLabel(type),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "${percentage.toStringAsFixed(1)}% of total costs",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "\$${amount.currency}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Project Costs",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
          ),
        ),
        ...filteredProjects.map((project) => _buildProjectCard(project)).toList(),
      ],
    );
  }

  Widget _buildProjectCard(Map<String, dynamic> project) {
    double totalCost = project["totalCost"] as double;
    double budgetedCost = project["budgetedCost"] as double;
    double variance = project["variance"] as double;
    int progress = project["progress"] as int;
    String status = project["status"];
    
    Color statusColor = _getStatusColor(status);

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${project["project"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Due: ${project["dueDate"]}",
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
                    "\$${totalCost.currency}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: statusColor),
                    ),
                    child: Text(
                      status.replaceAll('_', ' ').toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                      ),
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
                      "Progress",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "$progress%",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Budget",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${budgetedCost.currency}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
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
                      "Variance",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${variance >= 0 ? '+' : ''}\$${variance.currency}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: variance >= 0 ? successColor : dangerColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: disabledColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: LinearProgressIndicator(
              value: progress / 100,
              backgroundColor: Colors.transparent,
              color: statusColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCostTrends() {
    return Container(
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
            "Cost Trends & Insights",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          _buildTrendItem(
            "Labor Costs Increasing",
            "Development hourly rates up 8% this quarter",
            Icons.trending_up,
            warningColor,
          ),
          _buildTrendItem(
            "Material Costs Stable",
            "Software licensing costs remain consistent",
            Icons.trending_flat,
            successColor,
          ),
          _buildTrendItem(
            "Equipment Budget Efficient",
            "Hardware purchases 15% under budget",
            Icons.trending_down,
            infoColor,
          ),
        ],
      ),
    );
  }

  Widget _buildTrendItem(String title, String description, IconData icon, Color color) {
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
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
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

  Color _getCostTypeColor(String type) {
    switch (type) {
      case "labor":
        return primaryColor;
      case "material":
        return successColor;
      case "equipment":
        return infoColor;
      case "external":
        return warningColor;
      case "overhead":
        return secondaryColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getCostTypeIcon(String type) {
    switch (type) {
      case "labor":
        return Icons.people;
      case "material":
        return Icons.inventory;
      case "equipment":
        return Icons.computer;
      case "external":
        return Icons.business;
      case "overhead":
        return Icons.account_balance;
      default:
        return Icons.attach_money;
    }
  }

  String _getCostTypeLabel(String type) {
    switch (type) {
      case "labor":
        return "Labor Costs";
      case "material":
        return "Material Costs";
      case "equipment":
        return "Equipment";
      case "external":
        return "External Services";
      case "overhead":
        return "Overhead";
      default:
        return "Other";
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "on_track":
        return successColor;
      case "at_risk":
        return warningColor;
      case "completed":
        return infoColor;
      case "delayed":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _viewAnalytics() {
    si("View detailed cost analytics");
  }

  void _exportReport() {
    si("Export cost tracking report");
  }
}
