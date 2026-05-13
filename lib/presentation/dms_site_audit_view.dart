import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsSiteAuditView extends StatefulWidget {
  const DmsSiteAuditView({super.key});

  @override
  State<DmsSiteAuditView> createState() => _DmsSiteAuditViewState();
}

class _DmsSiteAuditViewState extends State<DmsSiteAuditView> {
  String selectedSite = "all";
  String selectedPriority = "all";
  String selectedCategory = "all";
  String selectedStatus = "all";

  List<Map<String, dynamic>> siteItems = [
    {"label": "All Sites", "value": "all"},
    {"label": "Main Website", "value": "main"},
    {"label": "Blog", "value": "blog"},
    {"label": "E-commerce", "value": "ecommerce"},
    {"label": "Landing Pages", "value": "landing"},
  ];

  List<Map<String, dynamic>> priorityItems = [
    {"label": "All Priorities", "value": "all"},
    {"label": "Critical", "value": "critical"},
    {"label": "High", "value": "high"},
    {"label": "Medium", "value": "medium"},
    {"label": "Low", "value": "low"},
  ];

  List<Map<String, dynamic>> categoryItems = [
    {"label": "All Categories", "value": "all"},
    {"label": "SEO Issues", "value": "seo"},
    {"label": "Performance", "value": "performance"},
    {"label": "Accessibility", "value": "accessibility"},
    {"label": "Security", "value": "security"},
    {"label": "Usability", "value": "usability"},
    {"label": "Content", "value": "content"},
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "All Status", "value": "all"},
    {"label": "New", "value": "new"},
    {"label": "In Progress", "value": "progress"},
    {"label": "Fixed", "value": "fixed"},
    {"label": "Ignored", "value": "ignored"},
  ];

  List<Map<String, dynamic>> auditData = [
    {
      "id": "audit001",
      "url": "https://example.com/products",
      "title": "Missing Meta Description",
      "category": "seo",
      "priority": "high",
      "status": "new",
      "description": "Page is missing meta description which impacts search engine visibility",
      "impact": "High impact on search rankings and click-through rates",
      "recommendation": "Add compelling meta description between 150-160 characters",
      "lastChecked": "2024-01-15",
      "estimatedFix": "5 minutes",
      "siteType": "main",
      "score": 65,
      "traffic": 1250,
      "conversions": 45,
    },
    {
      "id": "audit002", 
      "url": "https://example.com/blog/article-1",
      "title": "Large Image File Size",
      "category": "performance",
      "priority": "medium",
      "status": "progress",
      "description": "Images are not optimized and significantly impact page load speed",
      "impact": "Slower page load times affecting user experience and SEO",
      "recommendation": "Compress images and use next-gen formats like WebP",
      "lastChecked": "2024-01-14",
      "estimatedFix": "30 minutes",
      "siteType": "blog",
      "score": 72,
      "traffic": 890,
      "conversions": 12,
    },
    {
      "id": "audit003",
      "url": "https://example.com/contact",
      "title": "Missing Alt Text on Images",
      "category": "accessibility",
      "priority": "high",
      "status": "new",
      "description": "Multiple images lack alternative text for screen readers",
      "impact": "Poor accessibility and potential SEO impact",
      "recommendation": "Add descriptive alt text to all images",
      "lastChecked": "2024-01-15",
      "estimatedFix": "15 minutes",
      "siteType": "main",
      "score": 58,
      "traffic": 567,
      "conversions": 8,
    },
    {
      "id": "audit004",
      "url": "https://shop.example.com/checkout",
      "title": "Insecure Form Submission",
      "category": "security",
      "priority": "critical",
      "status": "new",
      "description": "Contact form is not using HTTPS encryption",
      "impact": "Security vulnerability and loss of user trust",
      "recommendation": "Implement SSL certificate and force HTTPS redirect",
      "lastChecked": "2024-01-15",
      "estimatedFix": "2 hours",
      "siteType": "ecommerce",
      "score": 45,
      "traffic": 2100,
      "conversions": 125,
    },
    {
      "id": "audit005",
      "url": "https://example.com/services",
      "title": "Poor Mobile Navigation",
      "category": "usability",
      "priority": "medium",
      "status": "fixed",
      "description": "Navigation menu is difficult to use on mobile devices",
      "impact": "High mobile bounce rate and poor user experience",
      "recommendation": "Implement mobile-friendly hamburger menu",
      "lastChecked": "2024-01-13",
      "estimatedFix": "4 hours",
      "siteType": "main",
      "score": 85,
      "traffic": 1450,
      "conversions": 67,
    },
    {
      "id": "audit006",
      "url": "https://example.com/about",
      "title": "Duplicate H1 Tags",
      "category": "seo",
      "priority": "high",
      "status": "progress",
      "description": "Multiple H1 tags found on the same page",
      "impact": "Confuses search engines about page topic",
      "recommendation": "Use only one H1 tag per page with proper hierarchy",
      "lastChecked": "2024-01-14",
      "estimatedFix": "10 minutes",
      "siteType": "main",
      "score": 68,
      "traffic": 890,
      "conversions": 23,
    },
    {
      "id": "audit007",
      "url": "https://example.com/landing/promo",
      "title": "Missing Schema Markup",
      "category": "seo",
      "priority": "medium",
      "status": "new",
      "description": "Page lacks structured data for better search visibility",
      "impact": "Missed opportunities for rich snippets",
      "recommendation": "Add appropriate schema markup for content type",
      "lastChecked": "2024-01-15",
      "estimatedFix": "45 minutes",
      "siteType": "landing",
      "score": 70,
      "traffic": 678,
      "conversions": 34,
    },
    {
      "id": "audit008",
      "url": "https://example.com/blog/category/tech",
      "title": "Slow Database Queries",
      "category": "performance",
      "priority": "high",
      "status": "new",
      "description": "Page load time exceeds 3 seconds due to inefficient queries",
      "impact": "Poor user experience and lower search rankings",
      "recommendation": "Optimize database queries and implement caching",
      "lastChecked": "2024-01-15",
      "estimatedFix": "3 hours",
      "siteType": "blog",
      "score": 55,
      "traffic": 1200,
      "conversions": 15,
    },
  ];

  List<Map<String, dynamic>> filteredAuditData = [];

  @override
  void initState() {
    super.initState();
    _filterAuditData();
  }

  void _filterAuditData() {
    filteredAuditData = auditData.where((audit) {
      bool siteMatch = selectedSite == "all" || audit["siteType"] == selectedSite;
      bool priorityMatch = selectedPriority == "all" || audit["priority"] == selectedPriority;
      bool categoryMatch = selectedCategory == "all" || audit["category"] == selectedCategory;
      bool statusMatch = selectedStatus == "all" || audit["status"] == selectedStatus;
      
      return siteMatch && priorityMatch && categoryMatch && statusMatch;
    }).toList();
    
    setState(() {});
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "critical": return dangerColor;
      case "high": return warningColor;
      case "medium": return infoColor;
      case "low": return successColor;
      default: return disabledColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "new": return dangerColor;
      case "progress": return warningColor;
      case "fixed": return successColor;
      case "ignored": return disabledColor;
      default: return disabledColor;
    }
  }

  String _formatPriority(String priority) {
    return priority[0].toUpperCase() + priority.substring(1);
  }

  String _formatStatus(String status) {
    switch (status) {
      case "progress": return "In Progress";
      default: return status[0].toUpperCase() + status.substring(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    int totalIssues = filteredAuditData.length;
    int criticalIssues = filteredAuditData.where((audit) => audit["priority"] == "critical").length;
    int fixedIssues = filteredAuditData.where((audit) => audit["status"] == "fixed").length;
    double avgScore = totalIssues > 0 
      ? (filteredAuditData.map((audit) => audit["score"] as int).reduce((a, b) => a + b)) / totalIssues 
      : 0;

    return Scaffold(
      appBar: AppBar(
        title: Text("Site Audit"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Filters Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Audit Filters",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Site",
                          items: siteItems,
                          value: selectedSite,
                          onChanged: (value, label) {
                            selectedSite = value;
                            _filterAuditData();
                          },
                        ),
                      ),
                      Expanded(
                        child: QDropdownField(
                          label: "Priority",
                          items: priorityItems,
                          value: selectedPriority,
                          onChanged: (value, label) {
                            selectedPriority = value;
                            _filterAuditData();
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Category",
                          items: categoryItems,
                          value: selectedCategory,
                          onChanged: (value, label) {
                            selectedCategory = value;
                            _filterAuditData();
                          },
                        ),
                      ),
                      Expanded(
                        child: QDropdownField(
                          label: "Status",
                          items: statusItems,
                          value: selectedStatus,
                          onChanged: (value, label) {
                            selectedStatus = value;
                            _filterAuditData();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Summary Statistics
            Row(
              spacing: spSm,
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
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "$totalIssues",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "$criticalIssues",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
                          "Fixed",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "$fixedIssues",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${avgScore.toStringAsFixed(0)}%",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: avgScore >= 80 ? successColor : avgScore >= 60 ? warningColor : dangerColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Audit Issues List
            ...filteredAuditData.map((audit) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: _getPriorityColor(audit["priority"]),
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${audit["title"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: _getPriorityColor(audit["priority"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            _formatPriority(audit["priority"]),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _getPriorityColor(audit["priority"]),
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: _getStatusColor(audit["status"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            _formatStatus(audit["status"]),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _getStatusColor(audit["status"]),
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: disabledColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${audit["url"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),

                    Text(
                      "${audit["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: dangerColor.withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: dangerColor.withAlpha(20),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "Impact:",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: dangerColor,
                            ),
                          ),
                          Text(
                            "${audit["impact"]}",
                            style: TextStyle(
                              fontSize: 13,
                              color: dangerColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: successColor.withAlpha(20),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "Recommendation:",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "${audit["recommendation"]}",
                            style: TextStyle(
                              fontSize: 13,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Score: ${audit["score"]}%",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: (audit["score"] as int) >= 80 ? successColor : (audit["score"] as int) >= 60 ? warningColor : dangerColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Traffic: ${(audit["traffic"] as int).toString()} visits",
                                style: TextStyle(
                                  fontSize: 12,
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
                                "Est. Fix: ${audit["estimatedFix"]}",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: infoColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Conversions: ${audit["conversions"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              QButton(
                                label: audit["status"] == "fixed" ? "View Fix" : "Fix Issue",
                                size: bs.sm,
                                onPressed: () {
                                  if (audit["status"] == "fixed") {
                                    si("Issue has been resolved");
                                  } else {
                                    ss("Starting fix process for ${audit["title"]}");
                                  }
                                },
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "Last checked: ${audit["lastChecked"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),

            if (filteredAuditData.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 48,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No audit issues found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your filters or run a new site audit",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
