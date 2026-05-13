import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsKeywordClusteringView extends StatefulWidget {
  const DmsKeywordClusteringView({super.key});

  @override
  State<DmsKeywordClusteringView> createState() => _DmsKeywordClusteringViewState();
}

class _DmsKeywordClusteringViewState extends State<DmsKeywordClusteringView> {
  String keywordList = "";
  String selectedMethod = "semantic";
  int currentTab = 0;
  bool loading = false;

  List<Map<String, dynamic>> clusteringMethods = [
    {"label": "Semantic Clustering", "value": "semantic"},
    {"label": "SERP Clustering", "value": "serp"},
    {"label": "Intent Clustering", "value": "intent"},
    {"label": "Topic Clustering", "value": "topic"},
  ];

  List<Map<String, dynamic>> keywordClusters = [
    {
      "name": "Digital Marketing Strategy",
      "keywords": 45,
      "primaryKeyword": "digital marketing strategy",
      "difficulty": 78,
      "volume": 27100,
      "intent": "Informational",
      "keywords_list": [
        "digital marketing strategy",
        "digital marketing plan",
        "online marketing strategy",
        "digital strategy framework",
        "marketing strategy template"
      ]
    },
    {
      "name": "Social Media Marketing",
      "keywords": 38,
      "primaryKeyword": "social media marketing",
      "difficulty": 82,
      "volume": 165000,
      "intent": "Commercial",
      "keywords_list": [
        "social media marketing",
        "social marketing",
        "social media strategy",
        "social media advertising",
        "social media management"
      ]
    },
    {
      "name": "Content Marketing",
      "keywords": 52,
      "primaryKeyword": "content marketing",
      "difficulty": 75,
      "volume": 74000,
      "intent": "Informational",
      "keywords_list": [
        "content marketing",
        "content strategy",
        "blog marketing",
        "content creation",
        "content planning"
      ]
    },
    {
      "name": "Email Marketing",
      "keywords": 29,
      "primaryKeyword": "email marketing",
      "difficulty": 71,
      "volume": 49500,
      "intent": "Commercial",
      "keywords_list": [
        "email marketing",
        "email campaigns",
        "newsletter marketing",
        "email automation",
        "email marketing tools"
      ]
    }
  ];

  List<Map<String, dynamic>> orphanKeywords = [
    {
      "keyword": "marketing analytics dashboard",
      "volume": 1200,
      "difficulty": 45,
      "reason": "Low search volume"
    },
    {
      "keyword": "b2b marketing automation",
      "volume": 890,
      "difficulty": 67,
      "reason": "Unique intent"
    },
    {
      "keyword": "viral marketing examples",
      "volume": 2100,
      "difficulty": 38,
      "reason": "Different topic"
    }
  ];

  List<Map<String, dynamic>> contentRecommendations = [
    {
      "cluster": "Digital Marketing Strategy",
      "contentType": "Comprehensive Guide",
      "title": "Complete Digital Marketing Strategy Guide 2024",
      "priority": "High",
      "effort": "High",
      "wordCount": "3000-5000",
      "sections": [
        "Strategy Framework",
        "Goal Setting",
        "Channel Selection",
        "Implementation Plan"
      ]
    },
    {
      "cluster": "Social Media Marketing",
      "contentType": "Tutorial Series",
      "title": "Social Media Marketing Mastery Course",
      "priority": "Medium",
      "effort": "High",
      "wordCount": "2000-3000",
      "sections": [
        "Platform Selection",
        "Content Creation",
        "Engagement Strategies",
        "Analytics"
      ]
    },
    {
      "cluster": "Content Marketing",
      "contentType": "Resource Hub",
      "title": "Content Marketing Resource Library",
      "priority": "High",
      "effort": "Medium",
      "wordCount": "1500-2500",
      "sections": [
        "Planning Templates",
        "Content Calendar",
        "Best Practices",
        "Tools & Resources"
      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Keyword Clustering",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Clusters", icon: Icon(Icons.group_work)),
        Tab(text: "Analysis", icon: Icon(Icons.analytics)),
        Tab(text: "Content", icon: Icon(Icons.article)),
      ],
      tabChildren: [
        _buildClustersTab(),
        _buildAnalysisTab(),
        _buildContentTab(),
      ],
    );
  }

  Widget _buildClustersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildClusteringForm(),
          if (keywordList.isNotEmpty) ...[
            _buildClusteringOverview(),
            _buildClustersList(),
          ]
        ],
      ),
    );
  }

  Widget _buildClusteringForm() {
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
            "Keyword Clustering Setup",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QMemoField(
            label: "Keywords List",
            value: keywordList,
            hint: "Enter keywords separated by commas or new lines",
            onChanged: (value) {
              keywordList = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Clustering Method",
            items: clusteringMethods,
            value: selectedMethod,
            onChanged: (value, label) {
              selectedMethod = value;
              setState(() {});
            },
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Start Clustering",
              size: bs.md,
              onPressed: () => _startClustering(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClusteringOverview() {
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
            "Clustering Results",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildOverviewCard("Total Keywords", "164", primaryColor, Icons.list),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildOverviewCard("Clusters Found", "${keywordClusters.length}", successColor, Icons.group_work),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildOverviewCard("Orphan Keywords", "${orphanKeywords.length}", warningColor, Icons.error_outline),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildOverviewCard("Avg. Cluster Size", "32", infoColor, Icons.bar_chart),
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
              fontSize: 18,
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

  Widget _buildClustersList() {
    return Column(
      spacing: spMd,
      children: keywordClusters.map((cluster) {
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
                          "${cluster["name"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Primary: ${cluster["primaryKeyword"]}",
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
                      color: _getIntentColor("${cluster["intent"]}").withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${cluster["intent"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: _getIntentColor("${cluster["intent"]}"),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildClusterMetric("Keywords", "${cluster["keywords"]}", Icons.list),
                  ),
                  Expanded(
                    child: _buildClusterMetric("Volume", "${((cluster["volume"] as int) / 1000).toStringAsFixed(1)}K", Icons.search),
                  ),
                  Expanded(
                    child: _buildClusterMetric("Difficulty", "${cluster["difficulty"]}", Icons.speed),
                  ),
                  QButton(
                    label: "View Details",
                    size: bs.sm,
                    onPressed: () => _showClusterDetails(cluster),
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
                      "Related Keywords:",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: (cluster["keywords_list"] as List).take(5).map((keyword) {
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
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildClusterMetric(String label, String value, IconData icon) {
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

  Widget _buildAnalysisTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildClusterAnalysis(),
          _buildOrphanKeywords(),
        ],
      ),
    );
  }

  Widget _buildClusterAnalysis() {
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
            "Cluster Analysis",
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
                    Icons.pie_chart,
                    size: 48,
                    color: primaryColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Cluster Distribution Chart",
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Visual representation of keyword clusters by size and intent",
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
          Row(
            children: [
              Expanded(
                child: _buildAnalysisMetric("Largest Cluster", "Content Marketing (52)", successColor),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildAnalysisMetric("Smallest Cluster", "Email Marketing (29)", warningColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnalysisMetric(String label, String value, Color color) {
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
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrphanKeywords() {
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
              Text(
                "Orphan Keywords",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(width: spSm),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${orphanKeywords.length} keywords",
                  style: TextStyle(
                    fontSize: 11,
                    color: warningColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "Keywords that couldn't be grouped into clusters due to unique characteristics or low relevance.",
            style: TextStyle(
              color: disabledBoldColor,
            ),
          ),
          ...orphanKeywords.map((keyword) {
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(5),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: warningColor.withAlpha(20)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${keyword["keyword"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Reason: ${keyword["reason"]}",
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
                        "${keyword["volume"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Volume",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    label: "Assign",
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildContentTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildContentHeader(),
          _buildContentRecommendations(),
        ],
      ),
    );
  }

  Widget _buildContentHeader() {
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
            "Content Recommendations",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Based on your keyword clusters, here are content recommendations to maximize your SEO impact.",
            style: TextStyle(
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentRecommendations() {
    return Column(
      spacing: spMd,
      children: contentRecommendations.map((content) {
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
                          "Cluster: ${content["cluster"]}",
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
                      color: _getPriorityColor("${content["priority"]}").withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${content["priority"]} Priority",
                      style: TextStyle(
                        fontSize: 11,
                        color: _getPriorityColor("${content["priority"]}"),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildContentMetric("Type", "${content["contentType"]}"),
                  ),
                  Expanded(
                    child: _buildContentMetric("Word Count", "${content["wordCount"]}"),
                  ),
                  Expanded(
                    child: _buildContentMetric("Effort", "${content["effort"]}"),
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
                      "Suggested Sections:",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: (content["sections"] as List).map((section) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "$section",
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
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildContentMetric(String label, String value) {
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

  Color _getIntentColor(String intent) {
    switch (intent) {
      case "Commercial":
        return successColor;
      case "Informational":
        return infoColor;
      case "Transactional":
        return warningColor;
      default:
        return primaryColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return infoColor;
    }
  }

  void _startClustering() {
    if (keywordList.isEmpty) {
      se("Please enter keywords to cluster");
      return;
    }
    
    loading = true;
    setState(() {});
    
    // Simulate clustering process
    Future.delayed(Duration(seconds: 3), () {
      loading = false;
      setState(() {});
      ss("Keyword clustering completed successfully");
    });
  }

  void _showClusterDetails(Map<String, dynamic> cluster) {
    // Show cluster details modal
    ss("Showing details for ${cluster["name"]} cluster");
  }
}
