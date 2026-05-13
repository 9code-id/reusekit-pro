import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsSeoAnalysisView extends StatefulWidget {
  const DmsSeoAnalysisView({super.key});

  @override
  State<DmsSeoAnalysisView> createState() => _DmsSeoAnalysisViewState();
}

class _DmsSeoAnalysisViewState extends State<DmsSeoAnalysisView> {
  String website = "";
  int currentTab = 0;
  bool loading = false;

  List<Map<String, dynamic>> analysisResults = [
    {
      "metric": "SEO Score",
      "value": 87,
      "status": "Good",
      "color": successColor,
      "icon": Icons.trending_up,
      "description": "Overall SEO performance is good with room for improvement"
    },
    {
      "metric": "Page Speed",
      "value": 72,
      "status": "Fair",
      "color": warningColor,
      "icon": Icons.speed,
      "description": "Page loading speed needs optimization"
    },
    {
      "metric": "Mobile Friendly",
      "value": 95,
      "status": "Excellent",
      "color": successColor,
      "icon": Icons.phone_android,
      "description": "Website is fully optimized for mobile devices"
    },
    {
      "metric": "SSL Certificate",
      "value": 100,
      "status": "Secure",
      "color": successColor,
      "icon": Icons.security,
      "description": "SSL certificate is properly configured"
    }
  ];

  List<Map<String, dynamic>> technicalIssues = [
    {
      "issue": "Missing Meta Descriptions",
      "pages": 15,
      "severity": "High",
      "color": dangerColor,
      "icon": Icons.warning
    },
    {
      "issue": "Broken Internal Links",
      "pages": 3,
      "severity": "Medium",
      "color": warningColor,
      "icon": Icons.link_off
    },
    {
      "issue": "Large Image Files",
      "pages": 8,
      "severity": "Medium",
      "color": warningColor,
      "icon": Icons.image
    },
    {
      "issue": "Missing Alt Text",
      "pages": 12,
      "severity": "Low",
      "color": infoColor,
      "icon": Icons.accessibility
    }
  ];

  List<Map<String, dynamic>> recommendations = [
    {
      "title": "Optimize Meta Descriptions",
      "description": "Add compelling meta descriptions to improve click-through rates",
      "priority": "High",
      "effort": "Medium",
      "icon": Icons.description
    },
    {
      "title": "Improve Page Speed",
      "description": "Compress images and minify CSS/JS files",
      "priority": "High",
      "effort": "High",
      "icon": Icons.speed
    },
    {
      "title": "Fix Broken Links",
      "description": "Update or remove broken internal and external links",
      "priority": "Medium",
      "effort": "Low",
      "icon": Icons.link
    },
    {
      "title": "Add Schema Markup",
      "description": "Implement structured data for better search visibility",
      "priority": "Medium",
      "effort": "High",
      "icon": Icons.code
    }
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "SEO Analysis",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.analytics)),
        Tab(text: "Issues", icon: Icon(Icons.warning)),
        Tab(text: "Recommendations", icon: Icon(Icons.lightbulb)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildIssuesTab(),
        _buildRecommendationsTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildAnalysisForm(),
          if (website.isNotEmpty) ...[
            _buildScoreOverview(),
            _buildMetricsGrid(),
            _buildProgressChart(),
          ]
        ],
      ),
    );
  }

  Widget _buildAnalysisForm() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Website Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Website URL",
                  value: website,
                  hint: "Enter your website URL",
                  onChanged: (value) {
                    website = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Analyze",
                size: bs.md,
                onPressed: () => _analyzeWebsite(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScoreOverview() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: successColor.withAlpha(20),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "87",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  Text(
                    "SEO Score",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "Good Performance",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Your website has a good SEO foundation with several areas for improvement.",
                  style: TextStyle(
                    color: disabledBoldColor,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: spSm),
                  child: Row(
                    children: [
                      Icon(
                        Icons.trending_up,
                        color: successColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "15% improvement this month",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricsGrid() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: analysisResults.map((metric) {
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
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: (metric["color"] as Color).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      metric["icon"] as IconData,
                      color: metric["color"] as Color,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${metric["metric"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${metric["status"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: metric["color"] as Color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Text(
                "${metric["value"]}%",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "${metric["description"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildProgressChart() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "SEO Score Trend",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            height: 200,
            child: Center(
              child: Text(
                "Interactive chart showing SEO score progression over time",
                style: TextStyle(
                  color: disabledBoldColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIssuesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildIssuesSummary(),
          _buildIssuesList(),
        ],
      ),
    );
  }

  Widget _buildIssuesSummary() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Technical Issues Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildIssueSummaryCard("High Priority", "3", dangerColor),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildIssueSummaryCard("Medium Priority", "5", warningColor),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildIssueSummaryCard("Low Priority", "2", infoColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIssueSummaryCard(String title, String count, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        children: [
          Text(
            count,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIssuesList() {
    return Column(
      spacing: spSm,
      children: technicalIssues.map((issue) {
        return Container(
          padding: EdgeInsets.all(spMd),
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
                  color: (issue["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  issue["icon"] as IconData,
                  color: issue["color"] as Color,
                  size: 20,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${issue["issue"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${issue["pages"]} pages affected",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: (issue["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${issue["severity"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: issue["color"] as Color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "Fix",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildRecommendationsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spSm,
        children: recommendations.map((recommendation) {
          return Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        recommendation["icon"] as IconData,
                        color: primaryColor,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${recommendation["title"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${recommendation["description"]}",
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
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: dangerColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "Priority: ${recommendation["priority"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: dangerColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "Effort: ${recommendation["effort"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: infoColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "Learn More",
                      size: bs.sm,
                      onPressed: () {},
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

  void _analyzeWebsite() {
    if (website.isEmpty) {
      se("Please enter a website URL");
      return;
    }
    
    loading = true;
    setState(() {});
    
    // Simulate analysis
    Future.delayed(Duration(seconds: 2), () {
      loading = false;
      setState(() {});
      ss("Website analysis completed successfully");
    });
  }
}
