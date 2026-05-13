import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsOnPageSeoView extends StatefulWidget {
  const DmsOnPageSeoView({super.key});

  @override
  State<DmsOnPageSeoView> createState() => _DmsOnPageSeoViewState();
}

class _DmsOnPageSeoViewState extends State<DmsOnPageSeoView> {
  String selectedPage = "homepage";
  String targetUrl = "";
  int selectedSeoIssueFilter = 0;

  List<Map<String, dynamic>> pageOptions = [
    {"label": "Homepage", "value": "homepage"},
    {"label": "Product Pages", "value": "product"},
    {"label": "Blog Posts", "value": "blog"},
    {"label": "Service Pages", "value": "service"},
    {"label": "Category Pages", "value": "category"},
  ];

  List<Map<String, dynamic>> onPageData = [
    {
      "url": "/",
      "page_title": "Digital Marketing Agency - Professional SEO & PPC Services",
      "page_type": "homepage",
      "target_keyword": "digital marketing agency",
      "seo_score": 78,
      "issues": [
        {
          "type": "critical",
          "issue": "Missing H1 tag",
          "description": "Page doesn't have a proper H1 heading tag",
          "impact": "high",
          "fix": "Add a single H1 tag with target keyword",
        },
        {
          "type": "warning",
          "issue": "Title too long",
          "description": "Page title exceeds 60 characters",
          "impact": "medium",
          "fix": "Reduce title length to under 60 characters",
        },
      ],
      "optimizations": {
        "title_length": 62,
        "meta_description_length": 155,
        "h1_present": false,
        "h2_count": 4,
        "h3_count": 6,
        "internal_links": 15,
        "external_links": 3,
        "images_without_alt": 2,
        "page_speed": 75,
        "mobile_friendly": true,
        "word_count": 1250,
        "keyword_density": 2.1,
      },
      "recommendations": [
        "Add target keyword to H1",
        "Optimize meta description",
        "Add alt text to images",
        "Improve page loading speed",
        "Add schema markup",
      ],
    },
    {
      "url": "/services/seo",
      "page_title": "Professional SEO Services - Boost Your Rankings",
      "page_type": "service",
      "target_keyword": "seo services",
      "seo_score": 85,
      "issues": [
        {
          "type": "warning",
          "issue": "Low keyword density",
          "description": "Target keyword appears only 0.8% in content",
          "impact": "medium",
          "fix": "Increase keyword usage naturally to 1.5-2%",
        },
        {
          "type": "info",
          "issue": "Missing schema markup",
          "description": "No structured data for service page",
          "impact": "low",
          "fix": "Add Service schema markup",
        },
      ],
      "optimizations": {
        "title_length": 52,
        "meta_description_length": 148,
        "h1_present": true,
        "h2_count": 5,
        "h3_count": 8,
        "internal_links": 22,
        "external_links": 1,
        "images_without_alt": 0,
        "page_speed": 82,
        "mobile_friendly": true,
        "word_count": 1850,
        "keyword_density": 0.8,
      },
      "recommendations": [
        "Increase keyword density slightly",
        "Add FAQ schema",
        "Optimize images further",
        "Add more internal links",
        "Update content freshness",
      ],
    },
    {
      "url": "/blog/content-marketing-strategy",
      "page_title": "Complete Content Marketing Strategy Guide 2024",
      "page_type": "blog",
      "target_keyword": "content marketing strategy",
      "seo_score": 92,
      "issues": [
        {
          "type": "info",
          "issue": "Could improve readability",
          "description": "Average sentence length is 22 words",
          "impact": "low",
          "fix": "Break down complex sentences for better readability",
        },
      ],
      "optimizations": {
        "title_length": 48,
        "meta_description_length": 152,
        "h1_present": true,
        "h2_count": 7,
        "h3_count": 12,
        "internal_links": 18,
        "external_links": 5,
        "images_without_alt": 0,
        "page_speed": 88,
        "mobile_friendly": true,
        "word_count": 2850,
        "keyword_density": 1.8,
      },
      "recommendations": [
        "Add table of contents",
        "Include more external authority links",
        "Update with latest trends",
        "Add video content",
        "Improve social sharing",
      ],
    },
    {
      "url": "/services/ppc-advertising",
      "page_title": "PPC Advertising Services | Google Ads Management",
      "page_type": "service",
      "target_keyword": "ppc advertising",
      "seo_score": 65,
      "issues": [
        {
          "type": "critical",
          "issue": "Duplicate content",
          "description": "Similar content found on 2 other pages",
          "impact": "high",
          "fix": "Rewrite content to be unique and specific",
        },
        {
          "type": "critical",
          "issue": "Slow page speed",
          "description": "Page loads in 4.2 seconds",
          "impact": "high",
          "fix": "Optimize images and reduce server response time",
        },
        {
          "type": "warning",
          "issue": "Missing meta description",
          "description": "No meta description tag found",
          "impact": "medium",
          "fix": "Add compelling meta description with target keyword",
        },
      ],
      "optimizations": {
        "title_length": 55,
        "meta_description_length": 0,
        "h1_present": true,
        "h2_count": 3,
        "h3_count": 4,
        "internal_links": 8,
        "external_links": 0,
        "images_without_alt": 5,
        "page_speed": 42,
        "mobile_friendly": true,
        "word_count": 890,
        "keyword_density": 2.8,
      },
      "recommendations": [
        "Rewrite unique content",
        "Add meta description",
        "Optimize page speed",
        "Add more internal links",
        "Include case studies",
      ],
    },
    {
      "url": "/about",
      "page_title": "About Our Digital Marketing Team | Company Info",
      "page_type": "page",
      "target_keyword": "digital marketing company",
      "seo_score": 58,
      "issues": [
        {
          "type": "critical",
          "issue": "Thin content",
          "description": "Page has only 320 words",
          "impact": "high",
          "fix": "Expand content to at least 800 words",
        },
        {
          "type": "warning",
          "issue": "No H2 headings",
          "description": "Content lacks proper heading structure",
          "impact": "medium",
          "fix": "Add H2 and H3 headings to structure content",
        },
        {
          "type": "warning",
          "issue": "Few internal links",
          "description": "Only 2 internal links found",
          "impact": "medium",
          "fix": "Add relevant internal links to services and blog",
        },
      ],
      "optimizations": {
        "title_length": 51,
        "meta_description_length": 128,
        "h1_present": true,
        "h2_count": 0,
        "h3_count": 1,
        "internal_links": 2,
        "external_links": 1,
        "images_without_alt": 3,
        "page_speed": 78,
        "mobile_friendly": true,
        "word_count": 320,
        "keyword_density": 1.2,
      },
      "recommendations": [
        "Expand content significantly",
        "Add team member profiles",
        "Include company history",
        "Add testimonials section",
        "Improve heading structure",
      ],
    },
  ];

  List<Map<String, dynamic>> get filteredOnPageData {
    List<Map<String, dynamic>> filtered = onPageData;

    if (targetUrl.isNotEmpty) {
      filtered = filtered.where((page) =>
          (page["url"] as String)
              .toLowerCase()
              .contains(targetUrl.toLowerCase()) ||
          (page["page_title"] as String)
              .toLowerCase()
              .contains(targetUrl.toLowerCase())).toList();
    }

    if (selectedPage != "homepage") {
      filtered = filtered.where((page) => page["page_type"] == selectedPage).toList();
    }

    switch (selectedSeoIssueFilter) {
      case 1: // Critical Issues
        filtered = filtered.where((page) => 
            (page["issues"] as List).any((issue) => issue["type"] == "critical")).toList();
        break;
      case 2: // Low Scores
        filtered = filtered.where((page) => (page["seo_score"] as int) < 70).toList();
        break;
      case 3: // High Performance
        filtered = filtered.where((page) => (page["seo_score"] as int) > 80).toList();
        break;
    }

    filtered.sort((a, b) => (a["seo_score"] as int).compareTo(b["seo_score"] as int));
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("On-Page SEO"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showAddPageDialog();
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              // Export SEO report
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // URL Analysis Input
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Analyze URL",
                    value: targetUrl,
                    hint: "Enter URL or search pages...",
                    onChanged: (value) {
                      targetUrl = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.analytics,
                  size: bs.sm,
                  onPressed: () {
                    // Analyze URL
                  },
                ),
              ],
            ),
            SizedBox(height: spSm),

            QDropdownField(
              label: "Page Type Filter",
              items: pageOptions,
              value: selectedPage,
              onChanged: (value, label) {
                selectedPage = value;
                setState(() {});
              },
            ),
            SizedBox(height: spMd),

            // SEO Issue Filter Tabs
            QCategoryPicker(
              items: [
                {"label": "All Pages", "value": 0},
                {"label": "Critical Issues", "value": 1},
                {"label": "Low Scores", "value": 2},
                {"label": "High Performance", "value": 3},
              ],
              value: selectedSeoIssueFilter,
              onChanged: (index, label, value, item) {
                selectedSeoIssueFilter = value;
                setState(() {});
              },
            ),
            SizedBox(height: spMd),

            // SEO Overview
            Container(
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
                    "On-Page SEO Overview",
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
                            Text(
                              "${onPageData.length}",
                              style: TextStyle(
                                fontSize: fsH4,
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
                              "Avg Score",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${(onPageData.map((p) => p["seo_score"] as int).reduce((a, b) => a + b) / onPageData.length).toStringAsFixed(1)}",
                              style: TextStyle(
                                fontSize: fsH4,
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
                              "Critical Issues",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${onPageData.map((p) => (p["issues"] as List).where((i) => i["type"] == "critical").length).reduce((a, b) => a + b)}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
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
                              "Optimized",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${onPageData.where((p) => (p["seo_score"] as int) > 80).length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Pages Analysis
            Text(
              "Page-by-Page Analysis",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            ...filteredOnPageData.map((page) {
              Color scoreColor = (page["seo_score"] as int) >= 80 
                  ? successColor 
                  : (page["seo_score"] as int) >= 60 
                      ? warningColor 
                      : dangerColor;

              int criticalIssues = (page["issues"] as List).where((issue) => issue["type"] == "critical").length;
              int warningIssues = (page["issues"] as List).where((issue) => issue["type"] == "warning").length;

              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: scoreColor,
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
                                "${page["page_title"]}",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${page["url"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Target: ${page["target_keyword"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: infoColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: scoreColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${page["seo_score"]}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: scoreColor,
                                  ),
                                ),
                                Text(
                                  "Score",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: scoreColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),

                    // Issues Summary
                    if ((page["issues"] as List).isNotEmpty)
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: dangerColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: dangerColor.withAlpha(30),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Issues Found:",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: dangerColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                if (criticalIssues > 0)
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: dangerColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "$criticalIssues Critical",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: dangerColor,
                                      ),
                                    ),
                                  ),
                                SizedBox(width: spXs),
                                if (warningIssues > 0)
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: warningColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "$warningIssues Warnings",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: warningColor,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            ...(page["issues"] as List).take(3).map((issue) {
                              Color issueColor = issue["type"] == "critical" 
                                  ? dangerColor 
                                  : issue["type"] == "warning" 
                                      ? warningColor 
                                      : infoColor;

                              return Container(
                                margin: EdgeInsets.only(bottom: spXs),
                                child: Row(
                                  children: [
                                    Icon(
                                      issue["type"] == "critical" ? Icons.error : Icons.warning,
                                      size: 16,
                                      color: issueColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${issue["issue"]}",
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                              color: issueColor,
                                            ),
                                          ),
                                          Text(
                                            "${issue["fix"]}",
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
                              );
                            }).toList(),
                          ],
                        ),
                      ),
                    if ((page["issues"] as List).isNotEmpty)
                      SizedBox(height: spSm),

                    // SEO Metrics
                    Text(
                      "SEO Metrics:",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Title Length",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${page["optimizations"]["title_length"]} chars",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: (page["optimizations"]["title_length"] as int) <= 60 ? successColor : dangerColor,
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
                                "Word Count",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${page["optimizations"]["word_count"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: (page["optimizations"]["word_count"] as int) >= 800 ? successColor : dangerColor,
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
                                "Page Speed",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${page["optimizations"]["page_speed"]}/100",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: (page["optimizations"]["page_speed"] as int) >= 70 ? successColor : dangerColor,
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
                                "Internal Links",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${page["optimizations"]["internal_links"]}",
                                style: TextStyle(
                                  fontSize: 12,
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

                    // Recommendations
                    Text(
                      "Top Recommendations:",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spXs),
                    ...(page["recommendations"] as List).take(3).map((recommendation) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spXs),
                        child: Row(
                          children: [
                            Icon(
                              Icons.lightbulb,
                              size: 14,
                              color: warningColor,
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "$recommendation",
                                style: TextStyle(
                                  fontSize: 11,
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
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  void _showAddPageDialog() {
    String newPageUrl = "";
    
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Analyze New Page"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              QTextField(
                label: "Page URL",
                value: newPageUrl,
                hint: "Enter full URL to analyze...",
                onChanged: (value) {
                  newPageUrl = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            QButton(
              label: "Analyze",
              size: bs.sm,
              onPressed: () {
                if (newPageUrl.isNotEmpty) {
                  // Add page analysis
                  Navigator.pop(context);
                  setState(() {});
                }
              },
            ),
          ],
        );
      },
    );
  }
}
