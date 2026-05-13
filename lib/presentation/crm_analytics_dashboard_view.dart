import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmAnalyticsDashboardView extends StatefulWidget {
  const CrmAnalyticsDashboardView({super.key});

  @override
  State<CrmAnalyticsDashboardView> createState() => _CrmAnalyticsDashboardViewState();
}

class _CrmAnalyticsDashboardViewState extends State<CrmAnalyticsDashboardView> {
  String selectedPeriod = "This Month";
  String selectedDepartment = "All Departments";
  int currentTab = 0;
  
  List<Map<String, dynamic>> periodOptions = [
    {"label": "Today", "value": "Today"},
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
    {"label": "Custom Range", "value": "Custom Range"},
  ];

  List<Map<String, dynamic>> departments = [
    {"label": "All Departments", "value": "All Departments"},
    {"label": "Customer Service", "value": "Customer Service"},
    {"label": "Technical Support", "value": "Technical Support"},
    {"label": "Sales", "value": "Sales"},
    {"label": "Billing", "value": "Billing"},
    {"label": "Management", "value": "Management"},
  ];

  Map<String, dynamic> analyticsData = {
    "overview": {
      "total_leads": 2847,
      "converted_leads": 1254,
      "conversion_rate": 44.0,
      "total_revenue": 485750.00,
      "avg_deal_size": 3420.00,
      "active_deals": 156,
      "deals_closed": 89,
      "deals_lost": 23,
    },
    "performance": {
      "calls_made": 15847,
      "emails_sent": 8756,
      "meetings_scheduled": 432,
      "demos_conducted": 156,
      "proposals_sent": 89,
      "contracts_signed": 67,
    },
    "team_metrics": [
      {
        "name": "Sarah Johnson",
        "department": "Sales",
        "calls": 287,
        "deals_closed": 12,
        "revenue": 42500.00,
        "conversion_rate": 38.5,
      },
      {
        "name": "Michael Chen",
        "department": "Customer Service",
        "calls": 445,
        "deals_closed": 8,
        "revenue": 28750.00,
        "conversion_rate": 31.2,
      },
      {
        "name": "Emily Davis",
        "department": "Technical Support",
        "calls": 356,
        "deals_closed": 15,
        "revenue": 51200.00,
        "conversion_rate": 42.1,
      },
      {
        "name": "David Wilson",
        "department": "Sales",
        "calls": 398,
        "deals_closed": 18,
        "revenue": 65800.00,
        "conversion_rate": 45.2,
      },
      {
        "name": "Lisa Zhang",
        "department": "Billing",
        "calls": 234,
        "deals_closed": 6,
        "revenue": 18900.00,
        "conversion_rate": 28.7,
      },
    ],
    "trends": {
      "monthly_revenue": [
        {"month": "Jan", "revenue": 385000},
        {"month": "Feb", "revenue": 412000},
        {"month": "Mar", "revenue": 398000},
        {"month": "Apr", "revenue": 445000},
        {"month": "May", "revenue": 467000},
        {"month": "Jun", "revenue": 485750},
      ],
      "conversion_trends": [
        {"month": "Jan", "rate": 38.5},
        {"month": "Feb", "rate": 41.2},
        {"month": "Mar", "rate": 39.8},
        {"month": "Apr", "rate": 42.1},
        {"month": "May", "rate": 43.7},
        {"month": "Jun", "rate": 44.0},
      ],
    },
    "pipeline": [
      {"stage": "Lead", "count": 234, "value": 156780.00},
      {"stage": "Qualified", "count": 156, "value": 234560.00},
      {"stage": "Proposal", "count": 89, "value": 187650.00},
      {"stage": "Negotiation", "count": 34, "value": 145890.00},
      {"stage": "Closed Won", "count": 67, "value": 298760.00},
    ],
  };

  Widget _buildKPICard(String title, String value, String change, IconData icon, Color color) {
    bool isPositive = change.startsWith('+');
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: isPositive ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isPositive ? Icons.trending_up : Icons.trending_down,
                      color: isPositive ? successColor : dangerColor,
                      size: 12,
                    ),
                    SizedBox(width: 2),
                    Text(
                      change,
                      style: TextStyle(
                        fontSize: 10,
                        color: isPositive ? successColor : dangerColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartCard(String title, String subtitle, Widget chart) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    if (subtitle.isNotEmpty)
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                  ],
                ),
              ),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  ss("Opening chart options");
                },
              ),
            ],
          ),
          SizedBox(height: spSm),
          chart,
        ],
      ),
    );
  }

  Widget _buildRevenueChart() {
    List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(analyticsData["trends"]["monthly_revenue"]);
    double maxRevenue = (data.map((d) => d["revenue"] as num).reduce((a, b) => a > b ? a : b)).toDouble();
    
    return Container(
      height: 200,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: data.map((item) {
          double height = ((item["revenue"] as num) / maxRevenue) * 180;
          return Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "\$${((item["revenue"] as num) / 1000).toStringAsFixed(0)}K",
                    style: TextStyle(
                      fontSize: 10,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Container(
                    height: height,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${item["month"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPipelineChart() {
    List<Map<String, dynamic>> pipeline = List<Map<String, dynamic>>.from(analyticsData["pipeline"]);
    double totalValue = pipeline.fold(0.0, (sum, stage) => sum + (stage["value"] as num));
    
    return Column(
      children: pipeline.map((stage) {
        double percentage = ((stage["value"] as num) / totalValue) * 100;
        return Container(
          margin: EdgeInsets.only(bottom: spSm),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "${stage["stage"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
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
                    "\$${((stage["value"] as num) / 1000).toStringAsFixed(0)}K",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spXs),
              Container(
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: percentage / 100,
                  child: Container(
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                  ),
                ),
              ),
              SizedBox(height: spXs),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "${percentage.toStringAsFixed(1)}%",
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTeamPerformanceCard(Map<String, dynamic> member) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.person,
              color: primaryColor,
              size: 24,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${member["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${member["department"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "${member["calls"]} calls",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${member["deals_closed"]} deals",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "\$${((member["revenue"] as num) / 1000).toStringAsFixed(0)}K",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "${(member["conversion_rate"] as num).toStringAsFixed(1)}%",
                style: TextStyle(
                  fontSize: 12,
                  color: successColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> overview = analyticsData["overview"];
    Map<String, dynamic> performance = analyticsData["performance"];
    List<Map<String, dynamic>> teamMetrics = List<Map<String, dynamic>>.from(analyticsData["team_metrics"]);

    return QTabBar(
      title: "CRM Analytics Dashboard",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Performance", icon: Icon(Icons.trending_up)),
        Tab(text: "Pipeline", icon: Icon(Icons.timeline)),
        Tab(text: "Team", icon: Icon(Icons.people)),
      ],
      tabChildren: [
        // Overview Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              // Filters
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Time Period",
                        items: periodOptions,
                        value: selectedPeriod,
                        onChanged: (value, label) {
                          selectedPeriod = value;
                          setState(() {});
                        },
                      ),
                    ),
                    Expanded(
                      child: QDropdownField(
                        label: "Department",
                        items: departments,
                        value: selectedDepartment,
                        onChanged: (value, label) {
                          selectedDepartment = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // KPI Cards
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 150,
                children: [
                  _buildKPICard(
                    "Total Leads",
                    "${overview["total_leads"]}",
                    "+12.5%",
                    Icons.people,
                    primaryColor,
                  ),
                  _buildKPICard(
                    "Conversion Rate",
                    "${(overview["conversion_rate"] as num).toStringAsFixed(1)}%",
                    "+2.3%",
                    Icons.trending_up,
                    successColor,
                  ),
                  _buildKPICard(
                    "Total Revenue",
                    "\$${((overview["total_revenue"] as num) / 1000).toStringAsFixed(0)}K",
                    "+8.7%",
                    Icons.attach_money,
                    infoColor,
                  ),
                  _buildKPICard(
                    "Avg Deal Size",
                    "\$${((overview["avg_deal_size"] as num)).toStringAsFixed(0)}",
                    "+5.2%",
                    Icons.monetization_on,
                    warningColor,
                  ),
                ],
              ),

              // Revenue Chart
              _buildChartCard(
                "Revenue Trend",
                "Monthly revenue performance",
                _buildRevenueChart(),
              ),

              // Quick Stats
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 150,
                children: [
                  _buildKPICard(
                    "Active Deals",
                    "${overview["active_deals"]}",
                    "+6.8%",
                    Icons.handshake,
                    primaryColor,
                  ),
                  _buildKPICard(
                    "Deals Closed",
                    "${overview["deals_closed"]}",
                    "+15.2%",
                    Icons.check_circle,
                    successColor,
                  ),
                  _buildKPICard(
                    "Deals Lost",
                    "${overview["deals_lost"]}",
                    "-3.1%",
                    Icons.cancel,
                    dangerColor,
                  ),
                  _buildKPICard(
                    "Win Rate",
                    "${(((overview["deals_closed"] as num) / ((overview["deals_closed"] as num) + (overview["deals_lost"] as num))) * 100).toStringAsFixed(1)}%",
                    "+4.5%",
                    Icons.emoji_events,
                    successColor,
                  ),
                ],
              ),
            ],
          ),
        ),

        // Performance Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 150,
                children: [
                  _buildKPICard(
                    "Calls Made",
                    "${performance["calls_made"]}",
                    "+18.3%",
                    Icons.phone,
                    primaryColor,
                  ),
                  _buildKPICard(
                    "Emails Sent",
                    "${performance["emails_sent"]}",
                    "+12.7%",
                    Icons.email,
                    infoColor,
                  ),
                  _buildKPICard(
                    "Meetings Scheduled",
                    "${performance["meetings_scheduled"]}",
                    "+9.2%",
                    Icons.event,
                    successColor,
                  ),
                  _buildKPICard(
                    "Demos Conducted",
                    "${performance["demos_conducted"]}",
                    "+22.1%",
                    Icons.slideshow,
                    warningColor,
                  ),
                  _buildKPICard(
                    "Proposals Sent",
                    "${performance["proposals_sent"]}",
                    "+7.5%",
                    Icons.description,
                    primaryColor,
                  ),
                  _buildKPICard(
                    "Contracts Signed",
                    "${performance["contracts_signed"]}",
                    "+14.8%",
                    Icons.assignment,
                    successColor,
                  ),
                ],
              ),
            ],
          ),
        ),

        // Pipeline Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              _buildChartCard(
                "Sales Pipeline",
                "Current pipeline value by stage",
                _buildPipelineChart(),
              ),
            ],
          ),
        ),

        // Team Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              Row(
                children: [
                  Text(
                    "Team Performance",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  QButton(
                    label: "View All",
                    size: bs.sm,
                    onPressed: () {
                      ss("Viewing all team members");
                    },
                  ),
                ],
              ),
              ...teamMetrics.map((member) => _buildTeamPerformanceCard(member)),
            ],
          ),
        ),
      ],
    );
  }
}
