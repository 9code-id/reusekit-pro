import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsContentOptimizationView extends StatefulWidget {
  const DmsContentOptimizationView({super.key});

  @override
  State<DmsContentOptimizationView> createState() => _DmsContentOptimizationViewState();
}

class _DmsContentOptimizationViewState extends State<DmsContentOptimizationView> {
  String selectedContentType = "all_content";
  String selectedIssue = "all_issues";
  int selectedFilter = 0;

  List<Map<String, dynamic>> contentTypeOptions = [
    {"label": "All Content", "value": "all_content"},
    {"label": "Blog Posts", "value": "blog_posts"},
    {"label": "Product Descriptions", "value": "product_descriptions"},
    {"label": "Service Pages", "value": "service_pages"},
    {"label": "Landing Pages", "value": "landing_pages"},
  ];

  List<Map<String, dynamic>> issueOptions = [
    {"label": "All Issues", "value": "all_issues"},
    {"label": "Thin Content", "value": "thin_content"},
    {"label": "Duplicate Content", "value": "duplicate_content"},
    {"label": "Missing Keywords", "value": "missing_keywords"},
    {"label": "Poor Readability", "value": "poor_readability"},
    {"label": "Missing Meta Description", "value": "missing_meta"},
  ];

  List<Map<String, dynamic>> contentData = [
    {
      "url": "/blog/digital-marketing-trends-2024",
      "title": "Digital Marketing Trends That Will Shape 2024",
      "content_type": "blog_posts",
      "word_count": 450,
      "optimal_word_count": "1500-2500",
      "readability_score": 65,
      "keyword_density": 2.1,
      "target_keywords": ["digital marketing trends", "marketing 2024", "digital strategy"],
      "missing_keywords": ["AI marketing", "social commerce", "voice search"],
      "issues": ["thin_content", "missing_keywords"],
      "priority": "high",
      "search_volume": 12800,
      "current_ranking": 15,
      "potential_ranking": 5,
      "content_score": 45,
      "recommendations": [
        "Expand content to 1500+ words",
        "Add section on AI marketing trends",
        "Include statistics and data",
        "Add internal links to related articles"
      ],
      "competitor_analysis": {
        "top_competitor_word_count": 2100,
        "average_word_count": 1800,
        "content_gap": "Missing AI and automation sections"
      },
    },
    {
      "url": "/products/wireless-earbuds",
      "title": "Premium Wireless Earbuds with Noise Cancellation",
      "content_type": "product_descriptions",
      "word_count": 150,
      "optimal_word_count": "300-500",
      "readability_score": 72,
      "keyword_density": 3.8,
      "target_keywords": ["wireless earbuds", "noise cancellation", "premium audio"],
      "missing_keywords": ["bluetooth earbuds", "waterproof", "battery life"],
      "issues": ["thin_content", "missing_keywords"],
      "priority": "medium",
      "search_volume": 8900,
      "current_ranking": 8,
      "potential_ranking": 3,
      "content_score": 55,
      "recommendations": [
        "Add detailed specifications",
        "Include customer testimonials",
        "Add comparison with competitors",
        "Expand on features and benefits"
      ],
      "competitor_analysis": {
        "top_competitor_word_count": 480,
        "average_word_count": 320,
        "content_gap": "Missing technical specifications"
      },
    },
    {
      "url": "/services/seo-optimization",
      "title": "Professional SEO Optimization Services",
      "content_type": "service_pages",
      "word_count": 2100,
      "optimal_word_count": "1000-2000",
      "readability_score": 68,
      "keyword_density": 2.5,
      "target_keywords": ["SEO services", "search optimization", "SEO agency"],
      "missing_keywords": ["local SEO", "technical SEO", "SEO audit"],
      "issues": ["missing_keywords", "poor_readability"],
      "priority": "medium",
      "search_volume": 15600,
      "current_ranking": 6,
      "potential_ranking": 2,
      "content_score": 78,
      "recommendations": [
        "Add local SEO section",
        "Include case studies",
        "Improve content structure",
        "Add FAQ section"
      ],
      "competitor_analysis": {
        "top_competitor_word_count": 1950,
        "average_word_count": 1650,
        "content_gap": "Missing local SEO focus"
      },
    },
    {
      "url": "/blog/content-marketing-strategy",
      "title": "Ultimate Content Marketing Strategy Guide",
      "content_type": "blog_posts",
      "word_count": 3200,
      "optimal_word_count": "2000-3000",
      "readability_score": 75,
      "keyword_density": 2.8,
      "target_keywords": ["content marketing", "content strategy", "marketing guide"],
      "missing_keywords": [],
      "issues": [],
      "priority": "low",
      "search_volume": 9400,
      "current_ranking": 3,
      "potential_ranking": 1,
      "content_score": 92,
      "recommendations": [
        "Add more recent examples",
        "Update statistics",
        "Include video content",
        "Add downloadable templates"
      ],
      "competitor_analysis": {
        "top_competitor_word_count": 2800,
        "average_word_count": 2400,
        "content_gap": "Well-optimized content"
      },
    },
    {
      "url": "/landing/email-marketing-course",
      "title": "Master Email Marketing: Complete Course",
      "content_type": "landing_pages",
      "word_count": 800,
      "optimal_word_count": "800-1200",
      "readability_score": 71,
      "keyword_density": 3.2,
      "target_keywords": ["email marketing course", "email marketing training", "marketing course"],
      "missing_keywords": ["email automation", "email templates", "conversion optimization"],
      "issues": ["missing_keywords"],
      "priority": "medium",
      "search_volume": 5600,
      "current_ranking": 9,
      "potential_ranking": 4,
      "content_score": 68,
      "recommendations": [
        "Add course curriculum details",
        "Include student testimonials",
        "Add pricing information",
        "Include preview videos"
      ],
      "competitor_analysis": {
        "top_competitor_word_count": 1100,
        "average_word_count": 950,
        "content_gap": "Missing detailed curriculum"
      },
    },
    {
      "url": "/about-us",
      "title": "About Our Digital Marketing Agency",
      "content_type": "service_pages",
      "word_count": 250,
      "optimal_word_count": "500-800",
      "readability_score": 69,
      "keyword_density": 1.8,
      "target_keywords": ["digital marketing agency", "marketing team", "about us"],
      "missing_keywords": ["experience", "clients", "awards", "team expertise"],
      "issues": ["thin_content", "missing_keywords"],
      "priority": "high",
      "search_volume": 2400,
      "current_ranking": 12,
      "potential_ranking": 6,
      "content_score": 42,
      "recommendations": [
        "Add team member profiles",
        "Include company history",
        "Add client success stories",
        "Include awards and certifications"
      ],
      "competitor_analysis": {
        "top_competitor_word_count": 650,
        "average_word_count": 480,
        "content_gap": "Missing team and achievement details"
      },
    },
  ];

  List<Map<String, dynamic>> get filteredContent {
    List<Map<String, dynamic>> filtered = contentData;

    if (selectedContentType != "all_content") {
      filtered = filtered.where((item) => item["content_type"] == selectedContentType).toList();
    }

    if (selectedIssue != "all_issues") {
      filtered = filtered.where((item) {
        List<String> issues = (item["issues"] as List).cast<String>();
        return issues.contains(selectedIssue);
      }).toList();
    }

    switch (selectedFilter) {
      case 1: // High Priority
        filtered = filtered.where((item) => item["priority"] == "high").toList();
        break;
      case 2: // Low Content Score
        filtered = filtered.where((item) => (item["content_score"] as int) < 60).toList();
        break;
      case 3: // Optimized
        filtered = filtered.where((item) => (item["issues"] as List).isEmpty).toList();
        break;
    }

    return filtered;
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getScoreColor(int score) {
    if (score >= 80) return successColor;
    if (score >= 60) return infoColor;
    if (score >= 40) return warningColor;
    return dangerColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Content Optimization"),
        actions: [
          IconButton(
            icon: Icon(Icons.auto_fix_high),
            onPressed: () {
              // Auto-optimize content
            },
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              // Content analytics
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              // Export content report
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter Controls
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Content Type",
                    items: contentTypeOptions,
                    value: selectedContentType,
                    onChanged: (value, label) {
                      selectedContentType = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Issue Type",
                    items: issueOptions,
                    value: selectedIssue,
                    onChanged: (value, label) {
                      selectedIssue = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),

            // Filter Tabs
            QCategoryPicker(
              items: [
                {"label": "All Content", "value": 0},
                {"label": "High Priority", "value": 1},
                {"label": "Low Score", "value": 2},
                {"label": "Optimized", "value": 3},
              ],
              value: selectedFilter,
              onChanged: (index, label, value, item) {
                selectedFilter = value;
                setState(() {});
              },
            ),
            SizedBox(height: spMd),

            // Summary Statistics
            Row(
              children: [
                Expanded(
                  child: Container(
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
                          "Total Pages",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${contentData.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Avg Score",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${(contentData.map((c) => c["content_score"] as int).reduce((a, b) => a + b) / contentData.length).toStringAsFixed(0)}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Need Work",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${contentData.where((c) => (c["issues"] as List).isNotEmpty).length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),

            // Content Optimization List
            Text(
              "Content Analysis & Recommendations",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            ...filteredContent.map((content) {
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
                      color: _getPriorityColor(content["priority"] as String),
                    ),
                  ),
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
                                "${content["title"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${content["url"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: _getScoreColor(content["content_score"] as int).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${content["content_score"]}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: _getScoreColor(content["content_score"] as int),
                                ),
                              ),
                              Text(
                                "Score",
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
                    SizedBox(height: spSm),

                    // Content Metrics
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Word Count",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${content["word_count"]} words",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Target: ${content["optimal_word_count"]}",
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Readability",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${content["readability_score"]}/100",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Keyword Density",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${content["keyword_density"]}%",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Ranking",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "#${content["current_ranking"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),

                    // Issues
                    if ((content["issues"] as List).isNotEmpty) ...[
                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs,
                        children: (content["issues"] as List).map((issue) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: dangerColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${issue}".replaceAll("_", " ").toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: dangerColor,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: spSm),
                    ],

                    // Recommendations
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: infoColor.withAlpha(30),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Recommendations:",
                            style: TextStyle(
                              fontSize: 12,
                              color: infoColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: spXs),
                          ...(content["recommendations"] as List).map((rec) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: spXs),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "• ",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: infoColor,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "$rec",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                    SizedBox(height: spSm),

                    // Missing Keywords
                    if ((content["missing_keywords"] as List).isNotEmpty) ...[
                      Text(
                        "Missing Keywords:",
                        style: TextStyle(
                          fontSize: 12,
                          color: warningColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs,
                        children: (content["missing_keywords"] as List).map((keyword) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: warningColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "$keyword",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: warningColor,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: spSm),
                    ],

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Optimize Content",
                            size: bs.sm,
                            onPressed: () {
                              // Open content editor
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.analytics,
                          size: bs.sm,
                          onPressed: () {
                            // View detailed analytics
                          },
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.compare,
                          size: bs.sm,
                          onPressed: () {
                            // Compare with competitors
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
