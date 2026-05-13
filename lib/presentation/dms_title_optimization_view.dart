import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsTitleOptimizationView extends StatefulWidget {
  const DmsTitleOptimizationView({super.key});

  @override
  State<DmsTitleOptimizationView> createState() => _DmsTitleOptimizationViewState();
}

class _DmsTitleOptimizationViewState extends State<DmsTitleOptimizationView> {
  String selectedPage = "all_pages";
  String selectedIssue = "all_issues";
  int selectedFilter = 0;

  List<Map<String, dynamic>> pageOptions = [
    {"label": "All Pages", "value": "all_pages"},
    {"label": "Product Pages", "value": "product_pages"},
    {"label": "Blog Posts", "value": "blog_posts"},
    {"label": "Category Pages", "value": "category_pages"},
    {"label": "Landing Pages", "value": "landing_pages"},
  ];

  List<Map<String, dynamic>> issueOptions = [
    {"label": "All Issues", "value": "all_issues"},
    {"label": "Missing Titles", "value": "missing_titles"},
    {"label": "Duplicate Titles", "value": "duplicate_titles"},
    {"label": "Too Long", "value": "too_long"},
    {"label": "Too Short", "value": "too_short"},
    {"label": "Missing Keywords", "value": "missing_keywords"},
  ];

  List<Map<String, dynamic>> titleData = [
    {
      "url": "/products/wireless-headphones",
      "current_title": "Premium Wireless Headphones - Best Sound Quality",
      "suggested_title": "Premium Wireless Headphones | High-Quality Audio | Brand Name",
      "length": 48,
      "optimal_length": "50-60",
      "issues": ["too_short", "missing_brand"],
      "priority": "high",
      "target_keywords": ["wireless headphones", "premium audio", "noise cancelling"],
      "search_volume": 8900,
      "current_ranking": 12,
      "potential_ranking": 6,
      "traffic_impact": "+45%",
      "status": "needs_optimization",
    },
    {
      "url": "/blog/seo-best-practices-2024",
      "current_title": "SEO Best Practices",
      "suggested_title": "SEO Best Practices 2024: Complete Guide to Rank Higher",
      "length": 19,
      "optimal_length": "50-60",
      "issues": ["too_short", "missing_year", "vague"],
      "priority": "high",
      "target_keywords": ["SEO best practices", "SEO guide 2024", "search optimization"],
      "search_volume": 12400,
      "current_ranking": 18,
      "potential_ranking": 4,
      "traffic_impact": "+78%",
      "status": "needs_optimization",
    },
    {
      "url": "/services/digital-marketing",
      "current_title": "Digital Marketing Services | Professional SEO & PPC Agency Solutions",
      "suggested_title": "Digital Marketing Services | SEO & PPC Agency | Brand Name",
      "length": 72,
      "optimal_length": "50-60",
      "issues": ["too_long"],
      "priority": "medium",
      "target_keywords": ["digital marketing", "SEO services", "PPC management"],
      "search_volume": 6700,
      "current_ranking": 8,
      "potential_ranking": 5,
      "traffic_impact": "+25%",
      "status": "needs_optimization",
    },
    {
      "url": "/products/smartphone-case",
      "current_title": "Premium iPhone 15 Pro Case | Drop Protection | Fast Shipping",
      "suggested_title": "iPhone 15 Pro Case | Premium Protection | Brand Name",
      "length": 58,
      "optimal_length": "50-60",
      "issues": [],
      "priority": "low",
      "target_keywords": ["iPhone 15 case", "phone protection", "premium case"],
      "search_volume": 4200,
      "current_ranking": 5,
      "potential_ranking": 3,
      "traffic_impact": "+15%",
      "status": "optimized",
    },
    {
      "url": "/about-us",
      "current_title": "",
      "suggested_title": "About Us | Leading Digital Marketing Agency | Brand Name",
      "length": 0,
      "optimal_length": "50-60",
      "issues": ["missing_title"],
      "priority": "critical",
      "target_keywords": ["digital marketing agency", "about us", "company"],
      "search_volume": 1800,
      "current_ranking": null,
      "potential_ranking": 8,
      "traffic_impact": "+120%",
      "status": "critical",
    },
    {
      "url": "/category/electronics",
      "current_title": "Electronics",
      "suggested_title": "Electronics Store | Latest Gadgets & Tech | Brand Name",
      "length": 11,
      "optimal_length": "50-60",
      "issues": ["too_short", "missing_keywords"],
      "priority": "high",
      "target_keywords": ["electronics store", "gadgets", "technology"],
      "search_volume": 5600,
      "current_ranking": 15,
      "potential_ranking": 7,
      "traffic_impact": "+55%",
      "status": "needs_optimization",
    },
  ];

  List<Map<String, dynamic>> get filteredTitles {
    List<Map<String, dynamic>> filtered = titleData;

    if (selectedPage != "all_pages") {
      filtered = filtered.where((item) {
        String url = item["url"] as String;
        switch (selectedPage) {
          case "product_pages":
            return url.contains("/products/");
          case "blog_posts":
            return url.contains("/blog/");
          case "category_pages":
            return url.contains("/category/");
          case "landing_pages":
            return url.contains("/landing/");
          default:
            return true;
        }
      }).toList();
    }

    if (selectedIssue != "all_issues") {
      filtered = filtered.where((item) {
        List<String> issues = (item["issues"] as List).cast<String>();
        return issues.contains(selectedIssue);
      }).toList();
    }

    switch (selectedFilter) {
      case 1: // Critical Issues
        filtered = filtered.where((item) => item["priority"] == "critical").toList();
        break;
      case 2: // High Priority
        filtered = filtered.where((item) => item["priority"] == "high").toList();
        break;
      case 3: // Optimized
        filtered = filtered.where((item) => item["status"] == "optimized").toList();
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

  Color _getStatusColor(String status) {
    switch (status) {
      case "critical":
        return dangerColor;
      case "needs_optimization":
        return warningColor;
      case "optimized":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Title Optimization"),
        actions: [
          IconButton(
            icon: Icon(Icons.auto_fix_high),
            onPressed: () {
              // Auto-optimize titles
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              // Export optimization report
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
                    items: pageOptions,
                    value: selectedPage,
                    onChanged: (value, label) {
                      selectedPage = value;
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
                {"label": "All Pages", "value": 0},
                {"label": "Critical", "value": 1},
                {"label": "High Priority", "value": 2},
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
                          "${titleData.length}",
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
                          "Need Optimization",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${titleData.where((t) => t["status"] != "optimized").length}",
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
                          "Avg Length",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${(titleData.where((t) => (t["length"] as int) > 0).map((t) => t["length"] as int).reduce((a, b) => a + b) / titleData.where((t) => (t["length"] as int) > 0).length).toStringAsFixed(0)}",
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

            // Title Optimization List
            Text(
              "Title Optimization Analysis",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            ...filteredTitles.map((title) {
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
                      color: _getPriorityColor(title["priority"] as String),
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
                                "${title["url"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: spXs),
                              if ((title["current_title"] as String).isNotEmpty)
                                Text(
                                  "Current: ${title["current_title"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: disabledBoldColor,
                                  ),
                                )
                              else
                                Text(
                                  "Current: [Missing Title]",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: dangerColor,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: _getStatusColor(title["status"] as String).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${title["priority"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: _getPriorityColor(title["priority"] as String),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),

                    // Suggested Title
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
                            "Suggested Title:",
                            style: TextStyle(
                              fontSize: 12,
                              color: successColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${title["suggested_title"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: spSm),

                    // Issues
                    if ((title["issues"] as List).isNotEmpty)
                      Wrap(
                        spacing: spXs,
                        runSpacing: spXs,
                        children: (title["issues"] as List).map((issue) {
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

                    // Metrics
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Length",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${title["length"]} chars",
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
                                "Search Volume",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${((title["search_volume"] as int) / 1000).toStringAsFixed(1)}K",
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
                                "Current Rank",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                title["current_ranking"] != null ? "#${title["current_ranking"]}" : "N/A",
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
                                "Traffic Impact",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${title["traffic_impact"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Apply Suggestion",
                            size: bs.sm,
                            onPressed: () {
                              // Apply suggested title
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.edit,
                          size: bs.sm,
                          onPressed: () {
                            // Edit title manually
                          },
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.preview,
                          size: bs.sm,
                          onPressed: () {
                            // Preview in search results
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
