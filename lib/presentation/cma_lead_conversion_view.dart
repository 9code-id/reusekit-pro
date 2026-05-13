import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaLeadConversionView extends StatefulWidget {
  const CmaLeadConversionView({super.key});

  @override
  State<CmaLeadConversionView> createState() => _CmaLeadConversionViewState();
}

class _CmaLeadConversionViewState extends State<CmaLeadConversionView> {
  String selectedPeriod = "This Month";
  String selectedStage = "All";
  
  List<Map<String, dynamic>> periodItems = [
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
    {"label": "Last 30 Days", "value": "Last 30 Days"},
    {"label": "Last 90 Days", "value": "Last 90 Days"},
  ];
  
  List<Map<String, dynamic>> stageItems = [
    {"label": "All", "value": "All"},
    {"label": "Lead", "value": "Lead"},
    {"label": "Qualified", "value": "Qualified"},
    {"label": "Opportunity", "value": "Opportunity"},
    {"label": "Proposal", "value": "Proposal"},
    {"label": "Won", "value": "Won"},
  ];

  List<Map<String, dynamic>> conversions = [
    {
      "id": "1",
      "leadName": "John Smith",
      "company": "Tech Solutions Inc",
      "email": "john.smith@company.com",
      "initialSource": "Website",
      "conversionDate": "2024-01-15",
      "dealValue": 25000,
      "timeToConvert": 45,
      "stages": [
        {"name": "Lead", "date": "2023-12-01", "duration": 7},
        {"name": "Qualified", "date": "2023-12-08", "duration": 14},
        {"name": "Opportunity", "date": "2023-12-22", "duration": 10},
        {"name": "Proposal", "date": "2024-01-01", "duration": 8},
        {"name": "Won", "date": "2024-01-09", "duration": 6},
      ],
      "avatar": "https://picsum.photos/50/50?random=1",
      "status": "Won",
    },
    {
      "id": "2",
      "leadName": "Sarah Johnson",
      "company": "Marketing Pro",
      "email": "sarah.j@marketing.com",
      "initialSource": "Referral",
      "conversionDate": "2024-01-12",
      "dealValue": 15000,
      "timeToConvert": 32,
      "stages": [
        {"name": "Lead", "date": "2023-12-11", "duration": 5},
        {"name": "Qualified", "date": "2023-12-16", "duration": 12},
        {"name": "Opportunity", "date": "2023-12-28", "duration": 8},
        {"name": "Proposal", "date": "2024-01-05", "duration": 7},
        {"name": "Won", "date": "2024-01-12", "duration": 0},
      ],
      "avatar": "https://picsum.photos/50/50?random=2",
      "status": "Won",
    },
    {
      "id": "3",
      "leadName": "Michael Chen",
      "company": "Innovation Startup",
      "email": "m.chen@startup.io",
      "initialSource": "Social Media",
      "conversionDate": "2024-01-10",
      "dealValue": 50000,
      "timeToConvert": 28,
      "stages": [
        {"name": "Lead", "date": "2023-12-13", "duration": 3},
        {"name": "Qualified", "date": "2023-12-16", "duration": 8},
        {"name": "Opportunity", "date": "2023-12-24", "duration": 7},
        {"name": "Proposal", "date": "2023-12-31", "duration": 10},
        {"name": "Won", "date": "2024-01-10", "duration": 0},
      ],
      "avatar": "https://picsum.photos/50/50?random=3",
      "status": "Won",
    },
  ];

  List<Map<String, dynamic>> conversionFunnel = [
    {"stage": "Lead", "count": 150, "converted": 120, "rate": 80.0},
    {"stage": "Qualified", "count": 120, "converted": 85, "rate": 70.8},
    {"stage": "Opportunity", "count": 85, "converted": 45, "rate": 52.9},
    {"stage": "Proposal", "count": 45, "converted": 28, "rate": 62.2},
    {"stage": "Won", "count": 28, "converted": 28, "rate": 100.0},
  ];

  double get totalConversionRate {
    if (conversionFunnel.isEmpty) return 0.0;
    int initialLeads = conversionFunnel.first["count"];
    int finalWon = conversionFunnel.last["converted"];
    return (finalWon / initialLeads) * 100;
  }

  double get averageTimeToConvert {
    if (conversions.isEmpty) return 0.0;
    int totalTime = conversions.fold(0, (sum, conv) => sum + (conv["timeToConvert"] as int));
    return totalTime / conversions.length;
  }

  double get totalConvertedValue {
    return conversions.fold(0.0, (sum, conv) => sum + (conv["dealValue"] as int));
  }

  Color _getStageColor(String stage) {
    switch (stage) {
      case "Lead":
        return infoColor;
      case "Qualified":
        return secondaryColor;
      case "Opportunity":
        return warningColor;
      case "Proposal":
        return primaryColor;
      case "Won":
        return successColor;
      default:
        return disabledColor;
    }
  }

  void _viewConversionDetail(Map<String, dynamic> conversion) {
    //navigateTo('CmaConversionDetailView')
  }

  void _exportReport() async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    ss("Conversion report exported successfully");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lead Conversion"),
        actions: [
          QButton(
            icon: Icons.download,
            size: bs.sm,
            onPressed: _exportReport,
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.analytics,
            size: bs.sm,
            onPressed: () {
              //navigateTo('CmaConversionAnalyticsView')
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
            _buildConversionStats(),
            _buildConversionFunnel(),
            _buildConversionsList(),
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
          colors: [successColor, successColor.withAlpha(200)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Row(
        children: [
          Icon(
            Icons.trending_up,
            color: Colors.white,
            size: 32,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Lead Conversion Tracking",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Monitor and analyze your conversion funnel",
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
              "${totalConversionRate.toStringAsFixed(1)}%",
              style: TextStyle(
                fontSize: fsH6,
                color: Colors.white,
                fontWeight: FontWeight.bold,
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
            label: "Stage Filter",
            items: stageItems,
            value: selectedStage,
            onChanged: (value, label) {
              selectedStage = value;
              setState(() {});
            },
          ),
        ),
      ],
    );
  }

  Widget _buildConversionStats() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            title: "Conversion Rate",
            value: "${totalConversionRate.toStringAsFixed(1)}%",
            icon: Icons.percent,
            color: successColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard(
            title: "Avg Time",
            value: "${averageTimeToConvert.toStringAsFixed(0)} days",
            icon: Icons.access_time,
            color: primaryColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard(
            title: "Total Value",
            value: "\$${(totalConvertedValue / 1000).toStringAsFixed(0)}K",
            icon: Icons.attach_money,
            color: warningColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildStatCard(
            title: "Conversions",
            value: "${conversions.length}",
            icon: Icons.check_circle,
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

  Widget _buildConversionFunnel() {
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
                Icons.filter_list,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Conversion Funnel",
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
            children: List.generate(conversionFunnel.length, (index) {
              final stage = conversionFunnel[index];
              final isLast = index == conversionFunnel.length - 1;
              
              return Column(
                children: [
                  _buildFunnelStage(stage),
                  if (!isLast) _buildFunnelArrow(),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildFunnelStage(Map<String, dynamic> stage) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: _getStageColor(stage["stage"]).withAlpha(30),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: _getStageColor(stage["stage"]),
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.circle,
            color: _getStageColor(stage["stage"]),
            size: 16,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${stage["stage"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: _getStageColor(stage["stage"]),
                  ),
                ),
                Text(
                  "${stage["count"]} leads",
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
                "${stage["rate"].toStringAsFixed(1)}%",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: _getStageColor(stage["stage"]),
                ),
              ),
              Text(
                "${stage["converted"]} converted",
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

  Widget _buildFunnelArrow() {
    return Container(
      width: double.infinity,
      height: 30,
      child: Center(
        child: Icon(
          Icons.keyboard_arrow_down,
          color: disabledBoldColor,
          size: 24,
        ),
      ),
    );
  }

  Widget _buildConversionsList() {
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
                Icons.people,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Recent Conversions",
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
            children: List.generate(conversions.length, (index) {
              final conversion = conversions[index];
              return _buildConversionCard(conversion);
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildConversionCard(Map<String, dynamic> conversion) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: successColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: successColor.withAlpha(50),
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
                  borderRadius: BorderRadius.circular(radiusLg),
                  image: DecorationImage(
                    image: NetworkImage("${conversion["avatar"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${conversion["leadName"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${conversion["company"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Source: ${conversion["initialSource"]}",
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
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: successColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "WON",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "\$${((conversion["dealValue"] as int).toDouble()).currency}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Divider(color: disabledOutlineBorderColor),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${conversion["timeToConvert"]} days",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "Converted: ${conversion["conversionDate"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "View Details",
                size: bs.sm,
                onPressed: () => _viewConversionDetail(conversion),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
