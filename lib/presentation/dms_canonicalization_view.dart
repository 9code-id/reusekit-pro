import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsCanonicalizationView extends StatefulWidget {
  const DmsCanonicalizationView({super.key});

  @override
  State<DmsCanonicalizationView> createState() => _DmsCanonicalizationViewState();
}

class _DmsCanonicalizationViewState extends State<DmsCanonicalizationView> {
  String selectedIssueType = "all";
  String selectedStatus = "all";
  int selectedFilter = 0;

  List<Map<String, dynamic>> issueTypeOptions = [
    {"label": "All Issues", "value": "all"},
    {"label": "Missing Canonical", "value": "missing"},
    {"label": "Self-Referencing", "value": "self"},
    {"label": "Chain Issues", "value": "chain"},
    {"label": "Non-Canonical", "value": "non_canonical"},
    {"label": "Cross-Domain", "value": "cross_domain"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Critical", "value": "critical"},
    {"label": "Warning", "value": "warning"},
    {"label": "Fixed", "value": "fixed"},
    {"label": "Ignored", "value": "ignored"},
  ];

  List<Map<String, dynamic>> canonicalData = [
    {
      "id": "C001",
      "url": "https://example.com/products/wireless-headphones",
      "canonical_url": "https://example.com/products/wireless-headphones",
      "issue_type": "self",
      "status": "warning",
      "page_title": "Premium Wireless Headphones - High Quality Audio",
      "meta_description": "Experience premium sound quality with our wireless headphones...",
      "http_status": 200,
      "discovery_date": "2024-06-10",
      "last_checked": "2024-06-16",
      "priority": "medium",
      "seo_impact": "low",
      "duplicate_count": 3,
      "duplicate_urls": [
        "https://example.com/products/wireless-headphones?color=black",
        "https://example.com/products/wireless-headphones?ref=promo",
        "https://example.com/products/wireless-headphones/index.html"
      ],
      "recommendations": [
        "Remove unnecessary parameters from canonical URL",
        "Ensure all variants point to the main product page",
        "Consider implementing parameter handling in canonical tags"
      ],
      "search_metrics": {
        "impressions": 12500,
        "clicks": 890,
        "average_position": 8.2,
        "ctr": 7.1
      }
    },
    {
      "id": "C002",
      "url": "https://example.com/blog/seo-tips",
      "canonical_url": null,
      "issue_type": "missing",
      "status": "critical",
      "page_title": "Essential SEO Tips for Better Rankings",
      "meta_description": "Learn proven SEO strategies to improve your website rankings...",
      "http_status": 200,
      "discovery_date": "2024-06-15",
      "last_checked": "2024-06-16",
      "priority": "high",
      "seo_impact": "high",
      "duplicate_count": 5,
      "duplicate_urls": [
        "https://example.com/blog/seo-tips/",
        "https://example.com/blog/seo-tips.html",
        "https://example.com/articles/seo-tips",
        "https://blog.example.com/seo-tips",
        "https://example.com/blog/seo-tips?utm_source=newsletter"
      ],
      "recommendations": [
        "Add canonical tag pointing to preferred URL version",
        "Choose single URL structure for blog posts",
        "Implement 301 redirects for alternative URLs",
        "Update internal links to use canonical version"
      ],
      "search_metrics": {
        "impressions": 25400,
        "clicks": 1850,
        "average_position": 5.7,
        "ctr": 7.3
      }
    },
    {
      "id": "C003",
      "url": "https://example.com/services/digital-marketing",
      "canonical_url": "https://main.example.com/services/digital-marketing",
      "issue_type": "cross_domain",
      "status": "warning",
      "page_title": "Professional Digital Marketing Services",
      "meta_description": "Boost your online presence with our comprehensive digital marketing...",
      "http_status": 200,
      "discovery_date": "2024-06-08",
      "last_checked": "2024-06-16",
      "priority": "medium",
      "seo_impact": "medium",
      "duplicate_count": 2,
      "duplicate_urls": [
        "https://www.example.com/services/digital-marketing",
        "https://main.example.com/services/digital-marketing"
      ],
      "recommendations": [
        "Verify cross-domain canonical implementation",
        "Ensure domain authority transfer is intentional",
        "Consider consolidating to single domain",
        "Monitor search engine interpretation"
      ],
      "search_metrics": {
        "impressions": 8900,
        "clicks": 645,
        "average_position": 6.4,
        "ctr": 7.2
      }
    },
    {
      "id": "C004",
      "url": "https://example.com/category/electronics",
      "canonical_url": "https://example.com/category/electronics?page=1",
      "issue_type": "non_canonical",
      "status": "critical",
      "page_title": "Electronics Category - Latest Tech Products",
      "meta_description": "Browse our extensive collection of electronics and tech gadgets...",
      "http_status": 200,
      "discovery_date": "2024-06-12",
      "last_checked": "2024-06-16",
      "priority": "high",
      "seo_impact": "high",
      "duplicate_count": 8,
      "duplicate_urls": [
        "https://example.com/category/electronics?page=1",
        "https://example.com/category/electronics?sort=price",
        "https://example.com/category/electronics?view=grid",
        "https://example.com/electronics",
        "https://example.com/shop/electronics",
        "https://example.com/category/electronics/",
        "https://example.com/category/electronics?filter=brand",
        "https://example.com/category/electronics.html"
      ],
      "recommendations": [
        "Set canonical to clean category URL without parameters",
        "Implement consistent pagination canonical strategy",
        "Use rel=prev/next for paginated content",
        "Consolidate multiple category URL structures"
      ],
      "search_metrics": {
        "impressions": 45200,
        "clicks": 2340,
        "average_position": 12.8,
        "ctr": 5.2
      }
    },
    {
      "id": "C005",
      "url": "https://example.com/about/company-history",
      "canonical_url": "https://example.com/about/company-history/page2",
      "issue_type": "chain",
      "status": "warning",
      "page_title": "Our Company History - About Example Corp",
      "meta_description": "Learn about the history and evolution of Example Corp...",
      "http_status": 200,
      "discovery_date": "2024-06-05",
      "last_checked": "2024-06-16",
      "priority": "low",
      "seo_impact": "low",
      "duplicate_count": 3,
      "duplicate_urls": [
        "https://example.com/about/company-history/page1",
        "https://example.com/about/company-history/page2",
        "https://example.com/about/history"
      ],
      "recommendations": [
        "Review canonical chain logic",
        "Ensure canonical points to most relevant page",
        "Consider consolidating paginated content",
        "Implement proper pagination signals"
      ],
      "search_metrics": {
        "impressions": 1250,
        "clicks": 89,
        "average_position": 15.2,
        "ctr": 7.1
      }
    },
    {
      "id": "C006",
      "url": "https://example.com/products/laptop-deals",
      "canonical_url": "https://example.com/products/laptop-deals",
      "issue_type": "self",
      "status": "fixed",
      "page_title": "Best Laptop Deals - Discounted Laptops",
      "meta_description": "Find amazing deals on premium laptops with huge discounts...",
      "http_status": 200,
      "discovery_date": "2024-05-28",
      "last_checked": "2024-06-16",
      "priority": "low",
      "seo_impact": "resolved",
      "duplicate_count": 1,
      "duplicate_urls": [
        "https://example.com/products/laptop-deals"
      ],
      "recommendations": [
        "Issue resolved - canonical properly implemented",
        "Monitor for future parameter variations",
        "Continue regular canonical audits"
      ],
      "search_metrics": {
        "impressions": 18700,
        "clicks": 1240,
        "average_position": 7.9,
        "ctr": 6.6
      }
    },
  ];

  List<Map<String, dynamic>> get filteredCanonicals {
    List<Map<String, dynamic>> filtered = canonicalData;

    if (selectedIssueType != "all") {
      filtered = filtered.where((item) => item["issue_type"] == selectedIssueType).toList();
    }

    if (selectedStatus != "all") {
      filtered = filtered.where((item) => item["status"] == selectedStatus).toList();
    }

    switch (selectedFilter) {
      case 1: // Critical Issues
        filtered = filtered.where((item) => item["status"] == "critical").toList();
        break;
      case 2: // High Impact
        filtered = filtered.where((item) => item["seo_impact"] == "high").toList();
        break;
      case 3: // Multiple Duplicates
        filtered = filtered.where((item) => (item["duplicate_count"] as int) > 3).toList();
        break;
    }

    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "critical":
        return dangerColor;
      case "warning":
        return warningColor;
      case "fixed":
        return successColor;
      case "ignored":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getIssueTypeColor(String type) {
    switch (type) {
      case "missing":
        return dangerColor;
      case "self":
        return warningColor;
      case "chain":
        return infoColor;
      case "non_canonical":
        return dangerColor;
      case "cross_domain":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getImpactColor(String impact) {
    switch (impact) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return successColor;
      case "resolved":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Canonicalization"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Scan for canonical issues
            },
          ),
          IconButton(
            icon: Icon(Icons.auto_fix_high),
            onPressed: () {
              // Auto-fix canonical issues
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              // Export canonical report
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
                    label: "Status",
                    items: statusOptions,
                    value: selectedStatus,
                    onChanged: (value, label) {
                      selectedStatus = value;
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
                {"label": "High Impact", "value": 2},
                {"label": "Many Duplicates", "value": 3},
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
                          "${canonicalData.length}",
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
                          "Critical",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${canonicalData.where((c) => c["status"] == "critical").length}",
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
                          "Duplicates",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${canonicalData.map((c) => c["duplicate_count"] as int).reduce((a, b) => a + b)}",
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

            // Canonical Issues List
            Text(
              "Canonical URL Issues",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            ...filteredCanonicals.map((canonical) {
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
                      color: _getStatusColor(canonical["status"] as String),
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
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: _getIssueTypeColor(canonical["issue_type"] as String).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${canonical["issue_type"]}".replaceAll("_", " ").toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: _getIssueTypeColor(canonical["issue_type"] as String),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: _getImpactColor(canonical["seo_impact"] as String).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${canonical["seo_impact"]} IMPACT",
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: _getImpactColor(canonical["seo_impact"] as String),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spSm),
                              Text(
                                "${canonical["page_title"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "ID: ${canonical["id"]}",
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
                              "${canonical["duplicate_count"]}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "Duplicates",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),

                    // URL Information
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.link,
                                color: primaryColor,
                                size: 16,
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Current URL:",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "${canonical["url"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: primaryColor,
                                        fontFamily: 'monospace',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          if (canonical["canonical_url"] != null) ...[
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Icon(
                                  Icons.arrow_downward,
                                  color: canonical["canonical_url"] != canonical["url"] ? warningColor : successColor,
                                  size: 16,
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Canonical URL:",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: disabledBoldColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "${canonical["canonical_url"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: canonical["canonical_url"] != canonical["url"] ? warningColor : successColor,
                                          fontFamily: 'monospace',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                    SizedBox(height: spSm),

                    // Search Metrics
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Impressions",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${((canonical["search_metrics"]["impressions"] as int) / 1000).toStringAsFixed(1)}K",
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
                                "Clicks",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${canonical["search_metrics"]["clicks"]}",
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
                                "Avg Position",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${canonical["search_metrics"]["average_position"]}",
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
                                "CTR",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${canonical["search_metrics"]["ctr"]}%",
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

                    // Duplicate URLs
                    if ((canonical["duplicate_urls"] as List).isNotEmpty) ...[
                      Text(
                        "Duplicate URLs (${(canonical["duplicate_urls"] as List).length}):",
                        style: TextStyle(
                          fontSize: 12,
                          color: warningColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: spXs),
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
                          children: (canonical["duplicate_urls"] as List).take(3).map((url) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: spXs),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "• ",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: warningColor,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "$url",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: primaryColor,
                                        fontFamily: 'monospace',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      if ((canonical["duplicate_urls"] as List).length > 3) ...[
                        SizedBox(height: spXs),
                        Text(
                          "+${(canonical["duplicate_urls"] as List).length - 3} more duplicates",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
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
                          ...(canonical["recommendations"] as List).map((rec) {
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

                    // Meta Information
                    Row(
                      children: [
                        Text(
                          "Discovered: ${DateTime.parse(canonical["discovery_date"]).dMMMy}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "Last Checked: ${DateTime.parse(canonical["last_checked"]).dMMMy}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
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
                            label: "Fix Issue",
                            size: bs.sm,
                            onPressed: () {
                              // Open canonical fix dialog
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.visibility,
                          size: bs.sm,
                          onPressed: () {
                            // View page
                          },
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.analytics,
                          size: bs.sm,
                          onPressed: () {
                            // View detailed analytics
                          },
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.list,
                          size: bs.sm,
                          onPressed: () {
                            // View all duplicates
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
