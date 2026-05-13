import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsContentMarketingView extends StatefulWidget {
  const DmsContentMarketingView({super.key});

  @override
  State<DmsContentMarketingView> createState() => _DmsContentMarketingViewState();
}

class _DmsContentMarketingViewState extends State<DmsContentMarketingView> {
  String selectedCategory = "all";
  String selectedStatus = "all";
  int currentTab = 0;
  bool loading = false;

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "all"},
    {"label": "Blog Posts", "value": "blog"},
    {"label": "Videos", "value": "video"},
    {"label": "Infographics", "value": "infographic"},
    {"label": "Case Studies", "value": "case_study"},
    {"label": "Whitepapers", "value": "whitepaper"},
    {"label": "Social Media", "value": "social"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Published", "value": "published"},
    {"label": "Draft", "value": "draft"},
    {"label": "In Review", "value": "review"},
    {"label": "Scheduled", "value": "scheduled"},
  ];

  List<Map<String, dynamic>> contentPieces = [
    {
      "title": "Complete Guide to Digital Marketing in 2024",
      "type": "Blog Post",
      "status": "Published",
      "author": "Sarah Johnson",
      "publish_date": "2024-03-15",
      "views": 15420,
      "engagement": 8.7,
      "shares": 234,
      "leads": 45,
      "performance": "High",
      "tags": ["SEO", "Digital Marketing", "Strategy"]
    },
    {
      "title": "How We Increased ROI by 300%",
      "type": "Case Study",
      "status": "Published",
      "author": "Mike Chen",
      "publish_date": "2024-03-10",
      "views": 8930,
      "engagement": 12.3,
      "shares": 189,
      "leads": 67,
      "performance": "High",
      "tags": ["ROI", "Case Study", "Success"]
    },
    {
      "title": "Social Media Marketing Trends Video",
      "type": "Video",
      "status": "In Review",
      "author": "Emma Davis",
      "publish_date": "2024-03-20",
      "views": 0,
      "engagement": 0,
      "shares": 0,
      "leads": 0,
      "performance": "Pending",
      "tags": ["Social Media", "Trends", "Video"]
    },
    {
      "title": "Content Marketing Statistics 2024",
      "type": "Infographic",
      "status": "Draft",
      "author": "Alex Rodriguez",
      "publish_date": "2024-03-25",
      "views": 0,
      "engagement": 0,
      "shares": 0,
      "leads": 0,
      "performance": "Pending",
      "tags": ["Statistics", "Content Marketing", "Data"]
    }
  ];

  List<Map<String, dynamic>> performanceMetrics = [
    {"metric": "Total Views", "value": 245800, "change": 15.7, "period": "This Month"},
    {"metric": "Engagement Rate", "value": 9.2, "change": 23.4, "period": "Average"},
    {"metric": "Leads Generated", "value": 456, "change": 8.9, "period": "This Month"},
    {"metric": "Conversion Rate", "value": 3.8, "change": -2.1, "period": "Average"},
  ];

  List<Map<String, dynamic>> contentIdeas = [
    {
      "title": "AI Tools for Marketing Automation",
      "type": "Blog Post",
      "difficulty": "Medium",
      "potential_traffic": 8500,
      "competition": "Medium",
      "keywords": ["AI marketing", "automation tools", "marketing AI"],
      "status": "Suggested"
    },
    {
      "title": "Email Marketing Best Practices Guide",
      "type": "Whitepaper",
      "difficulty": "Low",
      "potential_traffic": 12000,
      "competition": "Low",
      "keywords": ["email marketing", "best practices", "email automation"],
      "status": "Suggested"
    },
    {
      "title": "Customer Success Story: SaaS Growth",
      "type": "Case Study",
      "difficulty": "Low",
      "potential_traffic": 4500,
      "competition": "Low",
      "keywords": ["SaaS growth", "customer success", "B2B marketing"],
      "status": "Approved"
    }
  ];

  List<Map<String, dynamic>> topPerformers = [
    {
      "title": "Ultimate SEO Checklist 2024",
      "views": 45600,
      "leads": 234,
      "conversion_rate": 5.1,
      "publish_date": "2024-02-01"
    },
    {
      "title": "Content Marketing ROI Calculator",
      "views": 38200,
      "leads": 189,
      "conversion_rate": 4.9,
      "publish_date": "2024-01-15"
    },
    {
      "title": "Social Media Automation Tools Review",
      "views": 32800,
      "leads": 156,
      "conversion_rate": 4.8,
      "publish_date": "2024-02-20"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Content Marketing",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Content Library", icon: Icon(Icons.library_books)),
        Tab(text: "Performance", icon: Icon(Icons.analytics)),
        Tab(text: "Ideas", icon: Icon(Icons.lightbulb)),
      ],
      tabChildren: [
        _buildContentLibraryTab(),
        _buildPerformanceTab(),
        _buildIdeasTab(),
      ],
    );
  }

  Widget _buildContentLibraryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildContentFilters(),
          _buildContentOverview(),
          _buildContentList(),
        ],
      ),
    );
  }

  Widget _buildContentFilters() {
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
            "Content Library",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: categoryOptions,
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: statusOptions,
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                label: "New Content",
                size: bs.md,
                icon: Icons.add,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContentOverview() {
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
            "Content Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildOverviewCard("Total Content", "${contentPieces.length}", primaryColor, Icons.article),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildOverviewCard("Published", "2", successColor, Icons.publish),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildOverviewCard("In Review", "1", warningColor, Icons.rate_review),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildOverviewCard("Draft", "1", infoColor, Icons.drafts),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(String title, String value, Color color, IconData icon) {
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
            size: 20,
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentList() {
    return Column(
      spacing: spSm,
      children: contentPieces.map((content) {
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${content["title"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${content["type"]} • By ${content["author"]}",
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
                      color: _getStatusColor("${content["status"]}").withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${content["status"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: _getStatusColor("${content["status"]}"),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              if (content["status"] == "Published") ...[
                Row(
                  children: [
                    Expanded(
                      child: _buildContentMetric("Views", "${((content["views"] as int) / 1000).toStringAsFixed(1)}K", Icons.visibility),
                    ),
                    Expanded(
                      child: _buildContentMetric("Engagement", "${(content["engagement"] as double).toStringAsFixed(1)}%", Icons.favorite),
                    ),
                    Expanded(
                      child: _buildContentMetric("Shares", "${content["shares"]}", Icons.share),
                    ),
                    Expanded(
                      child: _buildContentMetric("Leads", "${content["leads"]}", Icons.person_add),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: _getPerformanceColor("${content["performance"]}").withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _getPerformanceIcon("${content["performance"]}"),
                        color: _getPerformanceColor("${content["performance"]}"),
                        size: 16,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "${content["performance"]} Performance",
                        style: TextStyle(
                          fontSize: 12,
                          color: _getPerformanceColor("${content["performance"]}"),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              Wrap(
                spacing: spXs,
                runSpacing: spXs,
                children: (content["tags"] as List).map((tag) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "$tag",
                      style: TextStyle(
                        fontSize: 11,
                        color: primaryColor,
                      ),
                    ),
                  );
                }).toList(),
              ),
              Row(
                children: [
                  Text(
                    "Publish Date: ${content["publish_date"]}",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledBoldColor,
                    ),
                  ),
                  Spacer(),
                  QButton(
                    label: "Edit",
                    size: bs.sm,
                    icon: Icons.edit,
                    onPressed: () {},
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    label: "View",
                    size: bs.sm,
                    icon: Icons.visibility,
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildContentMetric(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 14,
          color: disabledBoldColor,
        ),
        SizedBox(width: spXs),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPerformanceTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildPerformanceMetrics(),
          _buildPerformanceChart(),
          _buildTopPerformers(),
        ],
      ),
    );
  }

  Widget _buildPerformanceMetrics() {
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
            "Performance Metrics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: performanceMetrics.map((metric) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(5),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: primaryColor.withAlpha(20)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "${metric["metric"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          metric["metric"].toString().contains("Rate") || metric["metric"].toString().contains("Conversion")
                            ? "${metric["value"]}%"
                            : metric["value"] is double
                            ? "${(metric["value"] as double).toStringAsFixed(1)}"
                            : "${((metric["value"] as int) / 1000).toStringAsFixed(0)}K",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: _getChangeColor((metric["change"] as double)).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                (metric["change"] as double) >= 0 ? Icons.trending_up : Icons.trending_down,
                                color: _getChangeColor((metric["change"] as double)),
                                size: 12,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${(metric["change"] as double).abs().toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: _getChangeColor((metric["change"] as double)),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${metric["period"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
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

  Widget _buildPerformanceChart() {
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
            "Content Performance Trend",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.show_chart,
                    size: 48,
                    color: primaryColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Performance Analytics Chart",
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Track content views, engagement, and conversions over time",
                    textAlign: TextAlign.center,
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
    );
  }

  Widget _buildTopPerformers() {
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
            "Top Performing Content",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...topPerformers.map((performer) {
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: successColor.withAlpha(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "${performer["title"]}",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildPerformerMetric("Views", "${((performer["views"] as int) / 1000).toStringAsFixed(1)}K"),
                      ),
                      Expanded(
                        child: _buildPerformerMetric("Leads", "${performer["leads"]}"),
                      ),
                      Expanded(
                        child: _buildPerformerMetric("Conv. Rate", "${(performer["conversion_rate"] as double).toStringAsFixed(1)}%"),
                      ),
                      Expanded(
                        child: _buildPerformerMetric("Published", "${performer["publish_date"]}"),
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

  Widget _buildPerformerMetric(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildIdeasTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildIdeasHeader(),
          _buildContentIdeasList(),
        ],
      ),
    );
  }

  Widget _buildIdeasHeader() {
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
            "Content Ideas",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "AI-generated content ideas based on trending keywords, competitor analysis, and your audience interests.",
            style: TextStyle(
              color: disabledBoldColor,
            ),
          ),
          Row(
            children: [
              QButton(
                label: "Generate New Ideas",
                size: bs.md,
                icon: Icons.auto_awesome,
                onPressed: () => _generateIdeas(),
              ),
              Spacer(),
              QButton(
                label: "View All Ideas",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContentIdeasList() {
    return Column(
      spacing: spSm,
      children: contentIdeas.map((idea) {
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${idea["title"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${idea["type"]}",
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
                      color: _getIdeaStatusColor("${idea["status"]}").withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${idea["status"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: _getIdeaStatusColor("${idea["status"]}"),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildIdeaMetric("Potential Traffic", "${((idea["potential_traffic"] as int) / 1000).toStringAsFixed(1)}K", Icons.trending_up),
                  ),
                  Expanded(
                    child: _buildIdeaMetric("Difficulty", "${idea["difficulty"]}", Icons.signal_cellular_alt),
                  ),
                  Expanded(
                    child: _buildIdeaMetric("Competition", "${idea["competition"]}", Icons.people),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(5),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Text(
                      "Target Keywords:",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: (idea["keywords"] as List).map((keyword) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "$keyword",
                            style: TextStyle(
                              fontSize: 11,
                              color: primaryColor,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Spacer(),
                  QButton(
                    label: "Create Content",
                    size: bs.sm,
                    onPressed: () {},
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    label: "Save Idea",
                    size: bs.sm,
                    icon: Icons.bookmark,
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildIdeaMetric(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 14,
          color: disabledBoldColor,
        ),
        SizedBox(width: spXs),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Published":
        return successColor;
      case "In Review":
        return warningColor;
      case "Draft":
        return infoColor;
      case "Scheduled":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPerformanceColor(String performance) {
    switch (performance) {
      case "High":
        return successColor;
      case "Medium":
        return warningColor;
      case "Low":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getPerformanceIcon(String performance) {
    switch (performance) {
      case "High":
        return Icons.trending_up;
      case "Medium":
        return Icons.trending_flat;
      case "Low":
        return Icons.trending_down;
      default:
        return Icons.help;
    }
  }

  Color _getChangeColor(double change) {
    return change >= 0 ? successColor : dangerColor;
  }

  Color _getIdeaStatusColor(String status) {
    switch (status) {
      case "Approved":
        return successColor;
      case "Suggested":
        return infoColor;
      case "In Progress":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  void _generateIdeas() {
    loading = true;
    setState(() {});
    
    // Simulate AI idea generation
    Future.delayed(Duration(seconds: 2), () {
      loading = false;
      setState(() {});
      ss("New content ideas generated successfully");
    });
  }
}
