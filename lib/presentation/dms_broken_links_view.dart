import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsBrokenLinksView extends StatefulWidget {
  const DmsBrokenLinksView({super.key});

  @override
  State<DmsBrokenLinksView> createState() => _DmsBrokenLinksViewState();
}

class _DmsBrokenLinksViewState extends State<DmsBrokenLinksView> {
  String selectedLinkType = "all";
  String selectedStatus = "all";
  String selectedPriority = "all";
  String selectedSource = "all";

  List<Map<String, dynamic>> linkTypeItems = [
    {"label": "All Link Types", "value": "all"},
    {"label": "Internal Links", "value": "internal"},
    {"label": "External Links", "value": "external"},
    {"label": "Image Links", "value": "image"},
    {"label": "CSS/JS Files", "value": "resource"},
    {"label": "PDF/Documents", "value": "document"},
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "All Status", "value": "all"},
    {"label": "Broken", "value": "broken"},
    {"label": "Fixed", "value": "fixed"},
    {"label": "Ignored", "value": "ignored"},
    {"label": "Investigating", "value": "investigating"},
  ];

  List<Map<String, dynamic>> priorityItems = [
    {"label": "All Priorities", "value": "all"},
    {"label": "Critical", "value": "critical"},
    {"label": "High", "value": "high"},
    {"label": "Medium", "value": "medium"},
    {"label": "Low", "value": "low"},
  ];

  List<Map<String, dynamic>> sourceItems = [
    {"label": "All Sources", "value": "all"},
    {"label": "Homepage", "value": "homepage"},
    {"label": "Product Pages", "value": "product"},
    {"label": "Blog Posts", "value": "blog"},
    {"label": "Footer", "value": "footer"},
    {"label": "Navigation", "value": "navigation"},
  ];

  List<Map<String, dynamic>> brokenLinksData = [
    {
      "id": "link001",
      "brokenUrl": "https://example.com/old-service-page",
      "sourceUrl": "https://example.com/services",
      "linkText": "Learn More About Our Services",
      "linkType": "internal",
      "status": "broken",
      "priority": "high",
      "source": "navigation",
      "httpStatus": 404,
      "firstDetected": "2024-01-15",
      "lastChecked": "2024-01-15",
      "occurrences": 23,
      "description": "Internal link pointing to removed service page",
      "impact": "Users encounter 404 error when trying to access service information",
      "recommendedFix": "Update link to current services page or remove if no longer relevant",
      "linkPosition": "Main navigation menu",
      "pageViews": 1250,
      "clickRate": 0.15,
    },
    {
      "id": "link002",
      "brokenUrl": "https://external-site.com/invalid-resource",
      "sourceUrl": "https://example.com/blog/industry-insights",
      "linkText": "Industry Research Report 2023",
      "linkType": "external",
      "status": "broken",
      "priority": "medium",
      "source": "blog",
      "httpStatus": 404,
      "firstDetected": "2024-01-14",
      "lastChecked": "2024-01-15",
      "occurrences": 8,
      "description": "External link to removed research report",
      "impact": "Broken external reference reduces content credibility",
      "recommendedFix": "Find alternative source or remove the link",
      "linkPosition": "Within blog content",
      "pageViews": 890,
      "clickRate": 0.05,
    },
    {
      "id": "link003",
      "brokenUrl": "https://example.com/images/product-banner-old.jpg",
      "sourceUrl": "https://example.com/products/laptop",
      "linkText": "Product Banner Image",
      "linkType": "image",
      "status": "broken",
      "priority": "high",
      "source": "product",
      "httpStatus": 404,
      "firstDetected": "2024-01-15",
      "lastChecked": "2024-01-15",
      "occurrences": 156,
      "description": "Missing product banner image",
      "impact": "Broken image affects product page visual appeal and conversion",
      "recommendedFix": "Upload correct image or update image path",
      "linkPosition": "Product gallery",
      "pageViews": 2100,
      "clickRate": 0.25,
    },
    {
      "id": "link004",
      "brokenUrl": "https://example.com/assets/styles/old-theme.css",
      "sourceUrl": "https://example.com/checkout",
      "linkText": "Stylesheet Link",
      "linkType": "resource",
      "status": "broken",
      "priority": "critical",
      "source": "homepage",
      "httpStatus": 404,
      "firstDetected": "2024-01-14",
      "lastChecked": "2024-01-15",
      "occurrences": 567,
      "description": "Missing CSS file affecting page styling",
      "impact": "Pages display incorrectly without proper styling",
      "recommendedFix": "Update CSS file path or restore missing file",
      "linkPosition": "HTML head section",
      "pageViews": 3200,
      "clickRate": 0.0,
    },
    {
      "id": "link005",
      "brokenUrl": "https://example.com/downloads/user-manual.pdf",
      "sourceUrl": "https://example.com/support",
      "linkText": "Download User Manual",
      "linkType": "document",
      "status": "investigating",
      "priority": "medium",
      "source": "footer",
      "httpStatus": 404,
      "firstDetected": "2024-01-13",
      "lastChecked": "2024-01-15",
      "occurrences": 45,
      "description": "User manual PDF file not found",
      "impact": "Customers cannot access product documentation",
      "recommendedFix": "Upload new user manual or fix file path",
      "linkPosition": "Support section footer",
      "pageViews": 678,
      "clickRate": 0.12,
    },
    {
      "id": "link006",
      "brokenUrl": "https://partner-site.com/integration-guide",
      "sourceUrl": "https://example.com/integrations",
      "linkText": "View Integration Guide",
      "linkType": "external",
      "status": "fixed",
      "priority": "low",
      "source": "product",
      "httpStatus": 200,
      "firstDetected": "2024-01-12",
      "lastChecked": "2024-01-14",
      "occurrences": 12,
      "description": "Previously broken external integration guide link",
      "impact": "Link now works correctly after partner site update",
      "recommendedFix": "No action needed - link has been restored",
      "linkPosition": "Integration section",
      "pageViews": 445,
      "clickRate": 0.08,
    },
    {
      "id": "link007",
      "brokenUrl": "https://example.com/legacy/contact-form",
      "sourceUrl": "https://example.com/contact",
      "linkText": "Submit Inquiry",
      "linkType": "internal",
      "status": "broken",
      "priority": "high",
      "source": "navigation",
      "httpStatus": 500,
      "firstDetected": "2024-01-15",
      "lastChecked": "2024-01-15",
      "occurrences": 89,
      "description": "Contact form submission URL returns server error",
      "impact": "Customers cannot submit contact inquiries",
      "recommendedFix": "Fix server configuration or update form action URL",
      "linkPosition": "Contact form action",
      "pageViews": 1450,
      "clickRate": 0.18,
    },
    {
      "id": "link008",
      "brokenUrl": "https://example.com/images/team/former-employee.jpg",
      "sourceUrl": "https://example.com/about/team",
      "linkText": "Team Member Photo",
      "linkType": "image",
      "status": "ignored",
      "priority": "low",
      "source": "blog",
      "httpStatus": 404,
      "firstDetected": "2024-01-10",
      "lastChecked": "2024-01-15",
      "occurrences": 5,
      "description": "Former employee photo no longer available",
      "impact": "Minimal impact - employee no longer with company",
      "recommendedFix": "Remove image reference from team page",
      "linkPosition": "Team member profile",
      "pageViews": 234,
      "clickRate": 0.02,
    },
  ];

  List<Map<String, dynamic>> filteredLinksData = [];

  @override
  void initState() {
    super.initState();
    _filterLinksData();
  }

  void _filterLinksData() {
    filteredLinksData = brokenLinksData.where((link) {
      bool typeMatch = selectedLinkType == "all" || link["linkType"] == selectedLinkType;
      bool statusMatch = selectedStatus == "all" || link["status"] == selectedStatus;
      bool priorityMatch = selectedPriority == "all" || link["priority"] == selectedPriority;
      bool sourceMatch = selectedSource == "all" || link["source"] == selectedSource;
      
      return typeMatch && statusMatch && priorityMatch && sourceMatch;
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
      case "broken": return dangerColor;
      case "investigating": return warningColor;
      case "fixed": return successColor;
      case "ignored": return disabledColor;
      default: return disabledColor;
    }
  }

  Color _getLinkTypeColor(String linkType) {
    switch (linkType) {
      case "internal": return primaryColor;
      case "external": return infoColor;
      case "image": return warningColor;
      case "resource": return dangerColor;
      case "document": return successColor;
      default: return disabledColor;
    }
  }

  String _formatPriority(String priority) {
    return priority[0].toUpperCase() + priority.substring(1);
  }

  String _formatStatus(String status) {
    return status[0].toUpperCase() + status.substring(1);
  }

  String _formatLinkType(String linkType) {
    switch (linkType) {
      case "resource": return "CSS/JS";
      default: return linkType[0].toUpperCase() + linkType.substring(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    int totalLinks = filteredLinksData.length;
    int brokenLinks = filteredLinksData.where((link) => link["status"] == "broken").length;
    int criticalLinks = filteredLinksData.where((link) => link["priority"] == "critical").length;
    int totalOccurrences = totalLinks > 0 
      ? filteredLinksData.map((link) => link["occurrences"] as int).reduce((a, b) => a + b)
      : 0;

    return Scaffold(
      appBar: AppBar(
        title: Text("Broken Links"),
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
                    "Link Filters",
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
                          label: "Link Type",
                          items: linkTypeItems,
                          value: selectedLinkType,
                          onChanged: (value, label) {
                            selectedLinkType = value;
                            _filterLinksData();
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
                            _filterLinksData();
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
                          label: "Priority",
                          items: priorityItems,
                          value: selectedPriority,
                          onChanged: (value, label) {
                            selectedPriority = value;
                            _filterLinksData();
                          },
                        ),
                      ),
                      Expanded(
                        child: QDropdownField(
                          label: "Source",
                          items: sourceItems,
                          value: selectedSource,
                          onChanged: (value, label) {
                            selectedSource = value;
                            _filterLinksData();
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
                          "Total Links",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "$totalLinks",
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
                          "Broken",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "$brokenLinks",
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
                          "Critical",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "$criticalLinks",
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
                          "Occurrences",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${totalOccurrences.toString()}",
                          style: TextStyle(
                            fontSize: 24,
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

            // Broken Links List
            ...filteredLinksData.map((link) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: _getPriorityColor(link["priority"]),
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: _getLinkTypeColor(link["linkType"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            _formatLinkType(link["linkType"]),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _getLinkTypeColor(link["linkType"]),
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: _getPriorityColor(link["priority"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            _formatPriority(link["priority"]),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _getPriorityColor(link["priority"]),
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: _getStatusColor(link["status"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            _formatStatus(link["status"]),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _getStatusColor(link["status"]),
                            ),
                          ),
                        ),
                        Spacer(),
                        Text(
                          "HTTP ${link["httpStatus"]}",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: (link["httpStatus"] as int) == 200 ? successColor : dangerColor,
                          ),
                        ),
                      ],
                    ),
                    
                    if (link["linkText"] != null && (link["linkText"] as String).isNotEmpty)
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "Link Text: ${link["linkText"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),

                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: dangerColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "Broken URL:",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: dangerColor,
                            ),
                          ),
                          Text(
                            "${link["brokenUrl"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: dangerColor,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "Found on:",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: infoColor,
                            ),
                          ),
                          Text(
                            "${link["sourceUrl"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: infoColor,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ],
                      ),
                    ),

                    Text(
                      "${link["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                      ),
                    ),

                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: Container(
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
                                  "${link["impact"]}",
                                  style: TextStyle(
                                    fontSize: 13,
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
                                  "Recommended Fix:",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                ),
                                Text(
                                  "${link["recommendedFix"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: warningColor.withAlpha(20),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spSm,
                        children: [
                          Text(
                            "Link Details:",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: warningColor,
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: spXs,
                                  children: [
                                    Text(
                                      "Position: ${link["linkPosition"]}",
                                      style: TextStyle(fontSize: 12, color: warningColor),
                                    ),
                                    Text(
                                      "Occurrences: ${link["occurrences"]}",
                                      style: TextStyle(fontSize: 12, color: warningColor),
                                    ),
                                    Text(
                                      "First Detected: ${link["firstDetected"]}",
                                      style: TextStyle(fontSize: 12, color: warningColor),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: spXs,
                                  children: [
                                    Text(
                                      "Page Views: ${(link["pageViews"] as int).toString()}",
                                      style: TextStyle(fontSize: 12, color: warningColor),
                                    ),
                                    Text(
                                      "Click Rate: ${((link["clickRate"] as double) * 100).toStringAsFixed(1)}%",
                                      style: TextStyle(fontSize: 12, color: warningColor),
                                    ),
                                    Text(
                                      "Last Checked: ${link["lastChecked"]}",
                                      style: TextStyle(fontSize: 12, color: warningColor),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: link["status"] == "fixed" ? "View Fix" : "Fix Link",
                            size: bs.sm,
                            onPressed: () {
                              if (link["status"] == "fixed") {
                                si("Link has been fixed");
                              } else {
                                ss("Starting link fix process");
                              }
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Test Link",
                            size: bs.sm,
                            onPressed: () {
                              si("Testing link status...");
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Ignore",
                            size: bs.sm,
                            onPressed: () {
                              sw("Link marked as ignored");
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),

            if (filteredLinksData.isEmpty)
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
                      Icons.link_off,
                      size: 48,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No broken links found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Excellent! All links are working properly with the current filters",
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
