import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsTechnicalSeoView extends StatefulWidget {
  const DmsTechnicalSeoView({super.key});

  @override
  State<DmsTechnicalSeoView> createState() => _DmsTechnicalSeoViewState();
}

class _DmsTechnicalSeoViewState extends State<DmsTechnicalSeoView> {
  String selectedIssueType = "all_issues";
  String selectedSeverity = "all_severity";
  int selectedFilter = 0;

  List<Map<String, dynamic>> issueTypeOptions = [
    {"label": "All Issues", "value": "all_issues"},
    {"label": "Crawlability", "value": "crawlability"},
    {"label": "Indexability", "value": "indexability"},
    {"label": "Site Structure", "value": "site_structure"},
    {"label": "URL Structure", "value": "url_structure"},
    {"label": "Redirects", "value": "redirects"},
    {"label": "SSL & Security", "value": "ssl_security"},
  ];

  List<Map<String, dynamic>> severityOptions = [
    {"label": "All Severity", "value": "all_severity"},
    {"label": "Critical", "value": "critical"},
    {"label": "High", "value": "high"},
    {"label": "Medium", "value": "medium"},
    {"label": "Low", "value": "low"},
  ];

  List<Map<String, dynamic>> technicalSeoData = [
    {
      "url": "/robots.txt",
      "title": "Robots.txt Configuration",
      "issue_type": "crawlability",
      "severity": "critical",
      "status": "error",
      "description": "Robots.txt file is blocking important pages",
      "impact": "Search engines cannot crawl product pages",
      "blocked_pages": 150,
      "affected_traffic": 8500,
      "details": {
        "blocked_directories": ["/products/", "/services/", "/blog/category/"],
        "user_agents": ["*", "Googlebot", "Bingbot"],
        "disallow_rules": ["User-agent: *", "Disallow: /products/", "Disallow: /admin/"],
        "recommendation": "Remove blocking rules for public product and service pages",
      },
      "fix_complexity": "easy",
      "estimated_fix_time": "30 minutes",
      "priority": "critical",
    },
    {
      "url": "/sitemap.xml",
      "title": "XML Sitemap Issues",
      "issue_type": "indexability",
      "severity": "high",
      "status": "warning",
      "description": "Sitemap contains 404 URLs and missing pages",
      "impact": "Search engines receive outdated indexing information",
      "blocked_pages": 0,
      "affected_traffic": 3200,
      "details": {
        "total_urls": 450,
        "error_urls": 25,
        "missing_important_pages": 18,
        "last_modified": "2024-01-15",
        "submission_status": {
          "google": "submitted",
          "bing": "not_submitted",
        },
        "recommendation": "Update sitemap with current URLs and submit to all search engines",
      },
      "fix_complexity": "medium",
      "estimated_fix_time": "2 hours",
      "priority": "high",
    },
    {
      "url": "/products/",
      "title": "URL Structure Inconsistencies",
      "issue_type": "url_structure",
      "severity": "medium",
      "status": "warning",
      "description": "Inconsistent URL structure across product pages",
      "impact": "Reduced crawl efficiency and user experience",
      "blocked_pages": 0,
      "affected_traffic": 2100,
      "details": {
        "url_patterns": [
          "/products/category-product-name/",
          "/product/product-name/",
          "/products/product-name-id/",
        ],
        "inconsistencies": 85,
        "missing_breadcrumbs": 42,
        "duplicate_content_risk": "medium",
        "recommendation": "Standardize URL structure to /products/category/product-name/",
      },
      "fix_complexity": "hard",
      "estimated_fix_time": "1 week",
      "priority": "medium",
    },
    {
      "url": "/",
      "title": "SSL Certificate Configuration",
      "issue_type": "ssl_security",
      "severity": "medium",
      "status": "warning",
      "description": "SSL certificate issues affecting SEO signals",
      "impact": "Potential ranking penalty and user trust issues",
      "blocked_pages": 0,
      "affected_traffic": 1500,
      "details": {
        "certificate_status": "valid",
        "mixed_content_issues": 8,
        "http_redirects": "incomplete",
        "hsts_enabled": false,
        "security_headers": {
          "x_frame_options": "missing",
          "x_content_type_options": "present",
          "strict_transport_security": "missing",
        },
        "recommendation": "Enable HSTS and fix mixed content issues",
      },
      "fix_complexity": "medium",
      "estimated_fix_time": "4 hours",
      "priority": "medium",
    },
    {
      "url": "/blog/",
      "title": "Internal Link Structure",
      "issue_type": "site_structure",
      "severity": "medium",
      "status": "warning",
      "description": "Poor internal linking hierarchy affecting crawl depth",
      "impact": "Important pages require too many clicks to reach",
      "blocked_pages": 0,
      "affected_traffic": 4200,
      "details": {
        "average_click_depth": 4.2,
        "orphan_pages": 15,
        "deep_pages": 28,
        "crawl_budget_waste": "15%",
        "link_equity_distribution": "uneven",
        "recommendation": "Implement strategic internal linking and improve navigation structure",
      },
      "fix_complexity": "medium",
      "estimated_fix_time": "1 week",
      "priority": "medium",
    },
    {
      "url": "/old-product-url/",
      "title": "Redirect Chain Issues",
      "issue_type": "redirects",
      "severity": "high",
      "status": "error",
      "description": "Multiple redirect chains causing crawl inefficiency",
      "impact": "Link equity loss and poor user experience",
      "blocked_pages": 0,
      "affected_traffic": 5800,
      "details": {
        "redirect_chains": 12,
        "redirect_loops": 2,
        "max_chain_length": 5,
        "redirect_types": {
          "301": 45,
          "302": 8,
          "404": 15,
        },
        "link_equity_loss": "estimated 25%",
        "recommendation": "Implement direct 301 redirects and fix redirect loops",
      },
      "fix_complexity": "medium",
      "estimated_fix_time": "6 hours",
      "priority": "high",
    },
    {
      "url": "/search/",
      "title": "Pagination Implementation",
      "issue_type": "site_structure",
      "severity": "low",
      "status": "info",
      "description": "Missing rel=prev/next tags on paginated content",
      "impact": "Potential duplicate content issues on search results",
      "blocked_pages": 0,
      "affected_traffic": 800,
      "details": {
        "paginated_sections": ["/blog/", "/products/", "/search/"],
        "missing_rel_tags": 35,
        "canonical_implementation": "partial",
        "infinite_scroll": false,
        "recommendation": "Implement proper pagination markup and canonical tags",
      },
      "fix_complexity": "easy",
      "estimated_fix_time": "2 hours",
      "priority": "low",
    },
    {
      "url": "/",
      "title": "Core Web Vitals Technical Issues",
      "issue_type": "crawlability",
      "severity": "high",
      "status": "warning",
      "description": "Technical issues affecting Core Web Vitals scores",
      "impact": "Ranking factor impact and user experience degradation",
      "blocked_pages": 0,
      "affected_traffic": 12500,
      "details": {
        "lcp_issues": ["Largest element rendering delayed", "Critical resource loading"],
        "cls_issues": ["Layout shift from dynamic content", "Missing image dimensions"],
        "fid_issues": ["JavaScript blocking main thread", "Heavy third-party scripts"],
        "server_response_time": 1.8,
        "recommendation": "Optimize resource loading and reduce JavaScript execution time",
      },
      "fix_complexity": "hard",
      "estimated_fix_time": "2 weeks",
      "priority": "high",
    },
  ];

  List<Map<String, dynamic>> get filteredData {
    List<Map<String, dynamic>> filtered = technicalSeoData;

    if (selectedIssueType != "all_issues") {
      filtered = filtered.where((item) => item["issue_type"] == selectedIssueType).toList();
    }

    if (selectedSeverity != "all_severity") {
      filtered = filtered.where((item) => item["severity"] == selectedSeverity).toList();
    }

    switch (selectedFilter) {
      case 1: // Critical Issues
        filtered = filtered.where((item) => item["severity"] == "critical").toList();
        break;
      case 2: // Blocking Issues
        filtered = filtered.where((item) => (item["blocked_pages"] as int) > 0).toList();
        break;
      case 3: // Fixed Issues
        filtered = filtered.where((item) => item["status"] == "fixed").toList();
        break;
    }

    return filtered;
  }

  Color _getSeverityColor(String severity) {
    switch (severity) {
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
      case "error":
        return dangerColor;
      case "warning":
        return warningColor;
      case "info":
        return infoColor;
      case "fixed":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getComplexityColor(String complexity) {
    switch (complexity) {
      case "easy":
        return successColor;
      case "medium":
        return warningColor;
      case "hard":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Technical SEO"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              // Refresh technical scan
            },
          ),
          IconButton(
            icon: Icon(Icons.build),
            onPressed: () {
              // Technical SEO tools
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              // Export technical report
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
                    label: "Issue Type",
                    items: issueTypeOptions,
                    value: selectedIssueType,
                    onChanged: (value, label) {
                      selectedIssueType = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Severity",
                    items: severityOptions,
                    value: selectedSeverity,
                    onChanged: (value, label) {
                      selectedSeverity = value;
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
                {"label": "All Issues", "value": 0},
                {"label": "Critical", "value": 1},
                {"label": "Blocking Pages", "value": 2},
                {"label": "Fixed", "value": 3},
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
                          "Total Issues",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${technicalSeoData.length}",
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
                          "Critical Issues",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${technicalSeoData.where((t) => t["severity"] == "critical").length}",
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
                          "Blocked Pages",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${technicalSeoData.map((t) => t["blocked_pages"] as int).reduce((a, b) => a + b)}",
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
              ],
            ),
            SizedBox(height: spMd),

            // Technical SEO Issues
            Text(
              "Technical SEO Analysis",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            ...filteredData.map((techIssue) {
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
                      color: _getSeverityColor(techIssue["severity"] as String),
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
                                "${techIssue["title"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${techIssue["url"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: _getSeverityColor(techIssue["severity"] as String).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${techIssue["severity"]}".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: _getSeverityColor(techIssue["severity"] as String),
                                ),
                              ),
                            ),
                            SizedBox(height: spXs),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: _getStatusColor(techIssue["status"] as String).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${techIssue["status"]}".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: _getStatusColor(techIssue["status"] as String),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),

                    // Issue Description
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: warningColor.withAlpha(30),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Issue:",
                            style: TextStyle(
                              fontSize: 12,
                              color: warningColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${techIssue["description"]}",
                            style: TextStyle(
                              fontSize: 13,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Impact: ${techIssue["impact"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: dangerColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: spSm),

                    // Impact Metrics
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Blocked Pages",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${techIssue["blocked_pages"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: (techIssue["blocked_pages"] as int) > 0 ? dangerColor : successColor,
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
                                "Affected Traffic",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${((techIssue["affected_traffic"] as int) / 1000).toStringAsFixed(1)}K",
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
                                "Fix Complexity",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${techIssue["fix_complexity"]}".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: _getComplexityColor(techIssue["fix_complexity"] as String),
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
                                "Est. Fix Time",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${techIssue["estimated_fix_time"]}",
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

                    // Technical Details
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
                            "Technical Details:",
                            style: TextStyle(
                              fontSize: 12,
                              color: infoColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: spXs),
                          // Specific details based on issue type
                          if (techIssue["issue_type"] == "crawlability") ...[
                            ..._buildCrawlabilityDetails(techIssue["details"] as Map),
                          ] else if (techIssue["issue_type"] == "indexability") ...[
                            ..._buildIndexabilityDetails(techIssue["details"] as Map),
                          ] else if (techIssue["issue_type"] == "url_structure") ...[
                            ..._buildUrlStructureDetails(techIssue["details"] as Map),
                          ] else if (techIssue["issue_type"] == "ssl_security") ...[
                            ..._buildSslSecurityDetails(techIssue["details"] as Map),
                          ] else if (techIssue["issue_type"] == "site_structure") ...[
                            ..._buildSiteStructureDetails(techIssue["details"] as Map),
                          ] else if (techIssue["issue_type"] == "redirects") ...[
                            ..._buildRedirectDetails(techIssue["details"] as Map),
                          ],
                        ],
                      ),
                    ),
                    SizedBox(height: spSm),

                    // Recommendation
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
                            "Recommendation:",
                            style: TextStyle(
                              fontSize: 12,
                              color: successColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${(techIssue["details"] as Map)["recommendation"]}",
                            style: TextStyle(
                              fontSize: 13,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: spSm),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Fix Issue",
                            size: bs.sm,
                            onPressed: () {
                              // Open fix wizard
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.info,
                          size: bs.sm,
                          onPressed: () {
                            // View detailed info
                          },
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.build,
                          size: bs.sm,
                          onPressed: () {
                            // Technical tools
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

  List<Widget> _buildCrawlabilityDetails(Map details) {
    return [
      if (details.containsKey("blocked_directories"))
        Text(
          "Blocked: ${(details["blocked_directories"] as List).join(", ")}",
          style: TextStyle(fontSize: 12, color: primaryColor),
        ),
      if (details.containsKey("lcp_issues"))
        ...(details["lcp_issues"] as List).map((issue) => Text(
          "• $issue",
          style: TextStyle(fontSize: 12, color: primaryColor),
        )).toList(),
    ];
  }

  List<Widget> _buildIndexabilityDetails(Map details) {
    return [
      Text(
        "Total URLs: ${details["total_urls"]}",
        style: TextStyle(fontSize: 12, color: primaryColor),
      ),
      Text(
        "Error URLs: ${details["error_urls"]}",
        style: TextStyle(fontSize: 12, color: dangerColor),
      ),
      Text(
        "Missing Pages: ${details["missing_important_pages"]}",
        style: TextStyle(fontSize: 12, color: warningColor),
      ),
    ];
  }

  List<Widget> _buildUrlStructureDetails(Map details) {
    return [
      Text(
        "Inconsistencies: ${details["inconsistencies"]}",
        style: TextStyle(fontSize: 12, color: primaryColor),
      ),
      Text(
        "Missing Breadcrumbs: ${details["missing_breadcrumbs"]}",
        style: TextStyle(fontSize: 12, color: warningColor),
      ),
      Text(
        "Duplicate Risk: ${details["duplicate_content_risk"]}",
        style: TextStyle(fontSize: 12, color: infoColor),
      ),
    ];
  }

  List<Widget> _buildSslSecurityDetails(Map details) {
    return [
      Text(
        "Certificate: ${details["certificate_status"]}",
        style: TextStyle(fontSize: 12, color: successColor),
      ),
      Text(
        "Mixed Content: ${details["mixed_content_issues"]} issues",
        style: TextStyle(fontSize: 12, color: warningColor),
      ),
      Text(
        "HSTS: ${details["hsts_enabled"] ? "Enabled" : "Disabled"}",
        style: TextStyle(fontSize: 12, color: details["hsts_enabled"] ? successColor : dangerColor),
      ),
    ];
  }

  List<Widget> _buildSiteStructureDetails(Map details) {
    return [
      Text(
        "Avg Click Depth: ${details["average_click_depth"]}",
        style: TextStyle(fontSize: 12, color: primaryColor),
      ),
      Text(
        "Orphan Pages: ${details["orphan_pages"]}",
        style: TextStyle(fontSize: 12, color: dangerColor),
      ),
      Text(
        "Deep Pages: ${details["deep_pages"]}",
        style: TextStyle(fontSize: 12, color: warningColor),
      ),
    ];
  }

  List<Widget> _buildRedirectDetails(Map details) {
    return [
      Text(
        "Redirect Chains: ${details["redirect_chains"]}",
        style: TextStyle(fontSize: 12, color: warningColor),
      ),
      Text(
        "Redirect Loops: ${details["redirect_loops"]}",
        style: TextStyle(fontSize: 12, color: dangerColor),
      ),
      Text(
        "Link Equity Loss: ${details["link_equity_loss"]}",
        style: TextStyle(fontSize: 12, color: dangerColor),
      ),
    ];
  }
}
