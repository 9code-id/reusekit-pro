import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaClientAnalyticsView extends StatefulWidget {
  const LcaClientAnalyticsView({super.key});

  @override
  State<LcaClientAnalyticsView> createState() => _LcaClientAnalyticsViewState();
}

class _LcaClientAnalyticsViewState extends State<LcaClientAnalyticsView> {
  int currentTab = 0;
  String selectedPeriod = "month";
  String selectedSegment = "all";

  List<Map<String, dynamic>> clientMetrics = [
    {
      "title": "Total Clients",
      "value": 248,
      "change": 12.5,
      "icon": Icons.group,
      "color": primaryColor,
    },
    {
      "title": "Active Cases",
      "value": 156,
      "change": 8.3,
      "icon": Icons.folder_open,
      "color": warningColor,
    },
    {
      "title": "Client Satisfaction",
      "value": 94.2,
      "change": 2.8,
      "icon": Icons.star,
      "color": successColor,
      "unit": "%",
    },
    {
      "title": "Revenue per Client",
      "value": 4250,
      "change": 15.7,
      "icon": Icons.attach_money,
      "color": infoColor,
      "unit": "\$",
    },
  ];

  List<Map<String, dynamic>> clientSegments = [
    {
      "segment": "Corporate",
      "clients": 45,
      "revenue": 285000,
      "satisfaction": 96.5,
      "color": primaryColor,
    },
    {
      "segment": "Individual",
      "clients": 128,
      "revenue": 425000,
      "satisfaction": 93.2,
      "color": successColor,
    },
    {
      "segment": "Small Business",
      "clients": 75,
      "revenue": 312000,
      "satisfaction": 94.8,
      "color": warningColor,
    },
  ];

  List<Map<String, dynamic>> topClients = [
    {
      "name": "TechCorp Industries",
      "type": "Corporate",
      "revenue": 85000,
      "cases": 15,
      "satisfaction": 98.5,
      "lastActivity": "2 days ago",
    },
    {
      "name": "Johnson Family Trust",
      "type": "Individual",
      "revenue": 45000,
      "cases": 8,
      "satisfaction": 96.2,
      "lastActivity": "1 week ago",
    },
    {
      "name": "Green Solutions LLC",
      "type": "Small Business",
      "revenue": 38000,
      "cases": 12,
      "satisfaction": 95.8,
      "lastActivity": "3 days ago",
    },
    {
      "name": "Martinez Estate",
      "type": "Individual",
      "revenue": 32000,
      "cases": 6,
      "satisfaction": 97.1,
      "lastActivity": "5 days ago",
    },
  ];

  List<Map<String, dynamic>> clientAcquisition = [
    {"month": "Jan", "new": 18, "retained": 92},
    {"month": "Feb", "new": 22, "retained": 94},
    {"month": "Mar", "new": 25, "retained": 91},
    {"month": "Apr", "new": 28, "retained": 95},
    {"month": "May", "new": 32, "retained": 93},
    {"month": "Jun", "new": 35, "retained": 96},
  ];

  List<Map<String, dynamic>> satisfactionTrends = [
    {"month": "Jan", "score": 89.2},
    {"month": "Feb", "score": 90.8},
    {"month": "Mar", "score": 91.5},
    {"month": "Apr", "score": 92.8},
    {"month": "May", "score": 93.6},
    {"month": "Jun", "score": 94.2},
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"},
    {"label": "This Quarter", "value": "quarter"},
    {"label": "This Year", "value": "year"},
  ];

  List<Map<String, dynamic>> segmentOptions = [
    {"label": "All Segments", "value": "all"},
    {"label": "Corporate", "value": "corporate"},
    {"label": "Individual", "value": "individual"},
    {"label": "Small Business", "value": "small_business"},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Client Analytics",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Segments", icon: Icon(Icons.pie_chart)),
        Tab(text: "Top Clients", icon: Icon(Icons.star)),
        Tab(text: "Insights", icon: Icon(Icons.insights)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildSegmentsTab(),
        _buildTopClientsTab(),
        _buildInsightsTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildFilterSection(),
          _buildClientMetrics(),
          _buildAcquisitionChart(),
          _buildSatisfactionTrend(),
        ],
      ),
    );
  }

  Widget _buildSegmentsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildSegmentOverview(),
          _buildSegmentComparison(),
          _buildSegmentInsights(),
        ],
      ),
    );
  }

  Widget _buildTopClientsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildTopClientsHeader(),
          _buildClientsList(),
          _buildClientActions(),
        ],
      ),
    );
  }

  Widget _buildInsightsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildClientInsights(),
          _buildRecommendations(),
          _buildRiskAnalysis(),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
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
              label: "Period",
              items: periodOptions,
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
              label: "Segment",
              items: segmentOptions,
              value: selectedSegment,
              onChanged: (value, label) {
                selectedSegment = value;
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClientMetrics() {
    return ResponsiveGridView(
      minItemWidth: 200,
      children: clientMetrics.map((metric) {
        return Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
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
                      color: (metric["color"] as Color).withAlpha(20),
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
                    child: Text(
                      "${metric["title"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Text(
                    "${metric["unit"] ?? ""}${metric["value"]}",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: (metric["change"] as double) >= 0 ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          (metric["change"] as double) >= 0 ? Icons.trending_up : Icons.trending_down,
                          size: 12,
                          color: (metric["change"] as double) >= 0 ? successColor : dangerColor,
                        ),
                        SizedBox(width: 2),
                        Text(
                          "${(metric["change"] as double).abs().toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: (metric["change"] as double) >= 0 ? successColor : dangerColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: spXs),
              Text(
                "vs previous ${selectedPeriod}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledColor,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAcquisitionChart() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Client Acquisition & Retention",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            height: 200,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: clientAcquisition.map((data) {
                final maxNew = clientAcquisition.map((d) => d["new"] as int).reduce((a, b) => a > b ? a : b);
                final newHeight = ((data["new"] as int) / maxNew) * 150;
                
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: newHeight,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${data["month"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${data["new"]} new",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSatisfactionTrend() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Client Satisfaction Trend",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            height: 150,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: satisfactionTrends.map((trend) {
                final height = ((trend["score"] as double) / 100) * 120;
                
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: height,
                          decoration: BoxDecoration(
                            color: successColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${trend["month"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: successColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
              SizedBox(width: spXs),
              Text(
                "Satisfaction Score",
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

  Widget _buildSegmentOverview() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Client Segments Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...clientSegments.map((segment) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: (segment["color"] as Color).withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: (segment["color"] as Color).withAlpha(30)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: segment["color"] as Color,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      Icons.group,
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
                          "${segment["segment"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${segment["clients"]} clients",
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
                        "\$${((segment["revenue"] as int) / 1000).toStringAsFixed(0)}K",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: segment["color"] as Color,
                        ),
                      ),
                      Text(
                        "${(segment["satisfaction"] as double).toStringAsFixed(1)}% satisfaction",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildSegmentComparison() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Revenue by Segment",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            height: 200,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: clientSegments.map((segment) {
                final maxRevenue = clientSegments.map((s) => s["revenue"] as int).reduce((a, b) => a > b ? a : b);
                final height = ((segment["revenue"] as int) / maxRevenue) * 150;
                
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: spXs),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: height,
                          decoration: BoxDecoration(
                            color: segment["color"] as Color,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${segment["segment"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "\$${((segment["revenue"] as int) / 1000).toStringAsFixed(0)}K",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSegmentInsights() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Segment Insights",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          _buildInsightItem(
            "Corporate clients generate the highest revenue per client",
            Icons.trending_up,
            successColor,
          ),
          _buildInsightItem(
            "Individual clients show the highest growth rate",
            Icons.show_chart,
            primaryColor,
          ),
          _buildInsightItem(
            "Small business segment has the best satisfaction scores",
            Icons.star,
            warningColor,
          ),
        ],
      ),
    );
  }

  Widget _buildInsightItem(String text, IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 16,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopClientsHeader() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Icon(
              Icons.star,
              color: primaryColor,
              size: 32,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Top Performing Clients",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Based on revenue and case volume",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClientsList() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: topClients.map((client) {
          return Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: disabledColor.withAlpha(30),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Center(
                    child: Text(
                      "${client["name"]}".substring(0, 1),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${client["name"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "${client["type"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "•",
                            style: TextStyle(
                              color: disabledColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "${client["cases"]} cases",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledColor,
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
                      "\$${((client["revenue"] as int) / 1000).toStringAsFixed(0)}K",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.star,
                          size: 12,
                          color: warningColor,
                        ),
                        SizedBox(width: 2),
                        Text(
                          "${(client["satisfaction"] as double).toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildClientActions() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Client Management Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Export Client Data",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Client Outreach",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildClientInsights() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Client Insights",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            minItemWidth: 200,
            children: [
              _buildInsightCard("Client Retention", "96.5%", Icons.people, successColor),
              _buildInsightCard("Avg Case Value", "\$2,850", Icons.attach_money, primaryColor),
              _buildInsightCard("Response Time", "2.4 hours", Icons.schedule, warningColor),
              _buildInsightCard("Referral Rate", "28%", Icons.share, infoColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInsightCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
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
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendations() {
    List<Map<String, dynamic>> recommendations = [
      {
        "title": "Increase Corporate Engagement",
        "description": "Focus on expanding services for corporate clients to maximize revenue per client",
        "priority": "High",
        "color": dangerColor,
      },
      {
        "title": "Improve Individual Client Experience",
        "description": "Implement personalized communication strategies for individual clients",
        "priority": "Medium",
        "color": warningColor,
      },
      {
        "title": "Leverage Small Business Growth",
        "description": "Develop specialized packages for small business legal needs",
        "priority": "Medium",
        "color": infoColor,
      },
    ];

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recommendations",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...recommendations.map((rec) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: (rec["color"] as Color).withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: (rec["color"] as Color).withAlpha(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${rec["title"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: rec["color"] as Color,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${rec["priority"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${rec["description"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildRiskAnalysis() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Client Risk Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Low Risk",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "85%",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "of clients",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledColor,
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
                    color: warningColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Medium Risk",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "12%",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "of clients",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledColor,
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
                    color: dangerColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "High Risk",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "3%",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "of clients",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
