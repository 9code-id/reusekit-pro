import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsInternalLinkingView extends StatefulWidget {
  const DmsInternalLinkingView({super.key});

  @override
  State<DmsInternalLinkingView> createState() => _DmsInternalLinkingViewState();
}

class _DmsInternalLinkingViewState extends State<DmsInternalLinkingView> {
  String selectedIssueType = "all_issues";
  String selectedPageType = "all_pages";
  int selectedFilter = 0;

  List<Map<String, dynamic>> issueTypeOptions = [
    {"label": "All Issues", "value": "all_issues"},
    {"label": "Missing Links", "value": "missing_links"},
    {"label": "Broken Links", "value": "broken_links"},
    {"label": "Orphan Pages", "value": "orphan_pages"},
    {"label": "Over-Optimized", "value": "over_optimized"},
    {"label": "Poor Anchor Text", "value": "poor_anchor"},
  ];

  List<Map<String, dynamic>> pageTypeOptions = [
    {"label": "All Pages", "value": "all_pages"},
    {"label": "Blog Posts", "value": "blog_posts"},
    {"label": "Product Pages", "value": "product_pages"},
    {"label": "Service Pages", "value": "service_pages"},
    {"label": "Category Pages", "value": "category_pages"},
  ];

  List<Map<String, dynamic>> linkingData = [
    {
      "source_url": "/blog/digital-marketing-strategies",
      "source_title": "10 Digital Marketing Strategies That Work",
      "page_type": "blog_posts",
      "internal_links_count": 3,
      "optimal_links_count": "8-12",
      "outbound_links": 2,
      "inbound_links": 15,
      "page_authority": 45,
      "issues": ["missing_links"],
      "priority": "high",
      "traffic": 2800,
      "suggested_links": [
        {
          "target_url": "/services/seo-optimization",
          "anchor_text": "SEO optimization services",
          "relevance_score": 92,
          "reason": "Highly relevant to content marketing strategy"
        },
        {
          "target_url": "/blog/content-marketing-guide",
          "anchor_text": "content marketing guide",
          "relevance_score": 88,
          "reason": "Complementary topic for digital marketing"
        },
        {
          "target_url": "/tools/keyword-research",
          "anchor_text": "keyword research tools",
          "relevance_score": 85,
          "reason": "Essential tool for digital marketing"
        }
      ],
      "current_links": [
        {
          "target_url": "/about-us",
          "anchor_text": "about our team",
          "quality": "poor"
        },
        {
          "target_url": "/contact",
          "anchor_text": "contact us",
          "quality": "poor"
        },
        {
          "target_url": "/blog/social-media-tips",
          "anchor_text": "social media marketing tips",
          "quality": "good"
        }
      ],
    },
    {
      "source_url": "/products/marketing-software",
      "source_title": "Marketing Automation Software Suite",
      "page_type": "product_pages",
      "internal_links_count": 1,
      "optimal_links_count": "5-8",
      "outbound_links": 0,
      "inbound_links": 8,
      "page_authority": 38,
      "issues": ["missing_links", "orphan_pages"],
      "priority": "critical",
      "traffic": 1200,
      "suggested_links": [
        {
          "target_url": "/features/email-automation",
          "anchor_text": "email automation features",
          "relevance_score": 95,
          "reason": "Direct feature of the product"
        },
        {
          "target_url": "/pricing",
          "anchor_text": "view pricing plans",
          "relevance_score": 90,
          "reason": "Essential for product conversion"
        },
        {
          "target_url": "/case-studies/marketing-automation",
          "anchor_text": "marketing automation success stories",
          "relevance_score": 87,
          "reason": "Social proof for product"
        }
      ],
      "current_links": [
        {
          "target_url": "/contact",
          "anchor_text": "get started",
          "quality": "average"
        }
      ],
    },
    {
      "source_url": "/services/content-marketing",
      "source_title": "Professional Content Marketing Services",
      "page_type": "service_pages",
      "internal_links_count": 18,
      "optimal_links_count": "8-12",
      "outbound_links": 5,
      "inbound_links": 22,
      "page_authority": 62,
      "issues": ["over_optimized"],
      "priority": "medium",
      "traffic": 3500,
      "suggested_links": [],
      "current_links": [
        {
          "target_url": "/blog/content-strategy",
          "anchor_text": "content strategy",
          "quality": "good"
        },
        {
          "target_url": "/tools/content-calendar",
          "anchor_text": "content calendar tool",
          "quality": "excellent"
        }
      ],
    },
    {
      "source_url": "/blog/seo-trends-2024",
      "source_title": "SEO Trends That Will Dominate 2024",
      "page_type": "blog_posts",
      "internal_links_count": 6,
      "optimal_links_count": "8-12",
      "outbound_links": 3,
      "inbound_links": 12,
      "page_authority": 51,
      "issues": ["poor_anchor"],
      "priority": "medium",
      "traffic": 4200,
      "suggested_links": [
        {
          "target_url": "/services/technical-seo",
          "anchor_text": "technical SEO services",
          "relevance_score": 89,
          "reason": "Directly related to SEO trends"
        }
      ],
      "current_links": [
        {
          "target_url": "/blog/keyword-research",
          "anchor_text": "click here",
          "quality": "poor"
        },
        {
          "target_url": "/tools/seo-audit",
          "anchor_text": "this tool",
          "quality": "poor"
        }
      ],
    },
    {
      "source_url": "/category/digital-marketing-tools",
      "source_title": "Digital Marketing Tools & Resources",
      "page_type": "category_pages",
      "internal_links_count": 12,
      "optimal_links_count": "10-15",
      "outbound_links": 1,
      "inbound_links": 18,
      "page_authority": 48,
      "issues": [],
      "priority": "low",
      "traffic": 2100,
      "suggested_links": [],
      "current_links": [
        {
          "target_url": "/tools/keyword-planner",
          "anchor_text": "keyword planning tool",
          "quality": "excellent"
        },
        {
          "target_url": "/tools/analytics-dashboard",
          "anchor_text": "analytics dashboard",
          "quality": "good"
        }
      ],
    },
    {
      "source_url": "/landing/free-seo-audit",
      "source_title": "Free SEO Audit Tool - Analyze Your Website",
      "page_type": "landing_pages",
      "internal_links_count": 0,
      "optimal_links_count": "3-5",
      "outbound_links": 0,
      "inbound_links": 5,
      "page_authority": 25,
      "issues": ["orphan_pages", "missing_links"],
      "priority": "critical",
      "traffic": 890,
      "suggested_links": [
        {
          "target_url": "/services/seo-optimization",
          "anchor_text": "professional SEO services",
          "relevance_score": 93,
          "reason": "Natural progression from free audit"
        },
        {
          "target_url": "/blog/seo-checklist",
          "anchor_text": "complete SEO checklist",
          "relevance_score": 88,
          "reason": "Educational content for audit users"
        }
      ],
      "current_links": [],
    },
  ];

  List<Map<String, dynamic>> get filteredData {
    List<Map<String, dynamic>> filtered = linkingData;

    if (selectedPageType != "all_pages") {
      filtered = filtered.where((item) => item["page_type"] == selectedPageType).toList();
    }

    if (selectedIssueType != "all_issues") {
      filtered = filtered.where((item) {
        List<String> issues = (item["issues"] as List).cast<String>();
        return issues.contains(selectedIssueType);
      }).toList();
    }

    switch (selectedFilter) {
      case 1: // Critical Issues
        filtered = filtered.where((item) => item["priority"] == "critical").toList();
        break;
      case 2: // High Priority
        filtered = filtered.where((item) => item["priority"] == "high").toList();
        break;
      case 3: // Well Optimized
        filtered = filtered.where((item) => (item["issues"] as List).isEmpty).toList();
        break;
    }

    return filtered;
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "critical":
        return dangerColor;
      case "high":
        return warningColor;
      case "medium":
        return infoColor;
      case "low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getLinkQualityColor(String quality) {
    switch (quality) {
      case "excellent":
        return successColor;
      case "good":
        return infoColor;
      case "average":
        return warningColor;
      case "poor":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Internal Linking"),
        actions: [
          IconButton(
            icon: Icon(Icons.auto_fix_high),
            onPressed: () {
              // Auto-generate link suggestions
            },
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              // Link analytics
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              // Export linking report
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
                    label: "Page Type",
                    items: pageTypeOptions,
                    value: selectedPageType,
                    onChanged: (value, label) {
                      selectedPageType = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Issue Type",
                    items: issueTypeOptions,
                    value: selectedIssueType,
                    onChanged: (value, label) {
                      selectedIssueType = value;
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
                {"label": "All Pages", "value": 0},
                {"label": "Critical", "value": 1},
                {"label": "High Priority", "value": 2},
                {"label": "Well Optimized", "value": 3},
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
                          "${linkingData.length}",
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
                          "Orphan Pages",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${linkingData.where((l) => (l["issues"] as List).contains("orphan_pages")).length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
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
                          "Avg Links",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${(linkingData.map((l) => l["internal_links_count"] as int).reduce((a, b) => a + b) / linkingData.length).toStringAsFixed(1)}",
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
              ],
            ),
            SizedBox(height: spMd),

            // Internal Linking Analysis
            Text(
              "Internal Linking Analysis",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            ...filteredData.map((linkData) {
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
                      color: _getPriorityColor(linkData["priority"] as String),
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
                                "${linkData["source_title"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${linkData["source_url"]}",
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
                            color: _getPriorityColor(linkData["priority"] as String).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${linkData["priority"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: _getPriorityColor(linkData["priority"] as String),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),

                    // Link Metrics
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Internal Links",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${linkData["internal_links_count"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Target: ${linkData["optimal_links_count"]}",
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
                                "Inbound Links",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${linkData["inbound_links"]}",
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
                                "Page Authority",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${linkData["page_authority"]}",
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
                                "Traffic",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${((linkData["traffic"] as int) / 1000).toStringAsFixed(1)}K",
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
                    if ((linkData["issues"] as List).isNotEmpty) ...[
                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs,
                        children: (linkData["issues"] as List).map((issue) {
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

                    // Suggested Links
                    if ((linkData["suggested_links"] as List).isNotEmpty) ...[
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: successColor.withAlpha(30),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Suggested Internal Links:",
                              style: TextStyle(
                                fontSize: 12,
                                color: successColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: spXs),
                            ...(linkData["suggested_links"] as List).map((link) {
                              return Container(
                                margin: EdgeInsets.only(bottom: spXs),
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  border: Border.all(
                                    color: successColor.withAlpha(50),
                                    width: 1,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "${link["anchor_text"]}",
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: primaryColor,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                          decoration: BoxDecoration(
                                            color: successColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "${link["relevance_score"]}%",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: successColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "→ ${link["target_url"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${link["reason"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                        fontStyle: FontStyle.italic,
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
                    ],

                    // Current Links
                    if ((linkData["current_links"] as List).isNotEmpty) ...[
                      Text(
                        "Current Internal Links:",
                        style: TextStyle(
                          fontSize: 12,
                          color: infoColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: spXs),
                      ...(linkData["current_links"] as List).map((link) {
                        return Container(
                          margin: EdgeInsets.only(bottom: spXs),
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: _getLinkQualityColor(link["quality"] as String).withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: _getLinkQualityColor(link["quality"] as String).withAlpha(30),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${link["anchor_text"]}",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "→ ${link["target_url"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: _getLinkQualityColor(link["quality"] as String).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${link["quality"]}".toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: _getLinkQualityColor(link["quality"] as String),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      SizedBox(height: spSm),
                    ],

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Apply Suggestions",
                            size: bs.sm,
                            onPressed: () {
                              // Apply suggested links
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.edit,
                          size: bs.sm,
                          onPressed: () {
                            // Edit links manually
                          },
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.analytics,
                          size: bs.sm,
                          onPressed: () {
                            // View link analytics
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
