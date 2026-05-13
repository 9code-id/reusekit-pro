import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsCrawlErrorsView extends StatefulWidget {
  const DmsCrawlErrorsView({super.key});

  @override
  State<DmsCrawlErrorsView> createState() => _DmsCrawlErrorsViewState();
}

class _DmsCrawlErrorsViewState extends State<DmsCrawlErrorsView> {
  String selectedErrorType = "all";
  String selectedSeverity = "all";
  String selectedStatus = "all";
  String selectedDateRange = "7days";

  List<Map<String, dynamic>> errorTypeItems = [
    {"label": "All Error Types", "value": "all"},
    {"label": "404 Not Found", "value": "404"},
    {"label": "500 Server Error", "value": "500"},
    {"label": "403 Forbidden", "value": "403"},
    {"label": "Soft 404", "value": "soft404"},
    {"label": "Redirect Errors", "value": "redirect"},
    {"label": "DNS Errors", "value": "dns"},
  ];

  List<Map<String, dynamic>> severityItems = [
    {"label": "All Severities", "value": "all"},
    {"label": "Critical", "value": "critical"},
    {"label": "High", "value": "high"},
    {"label": "Medium", "value": "medium"},
    {"label": "Low", "value": "low"},
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "All Status", "value": "all"},
    {"label": "New", "value": "new"},
    {"label": "Investigating", "value": "investigating"},
    {"label": "Fixed", "value": "fixed"},
    {"label": "Ignored", "value": "ignored"},
  ];

  List<Map<String, dynamic>> dateRangeItems = [
    {"label": "Last 7 Days", "value": "7days"},
    {"label": "Last 30 Days", "value": "30days"},
    {"label": "Last 90 Days", "value": "90days"},
    {"label": "All Time", "value": "all"},
  ];

  List<Map<String, dynamic>> crawlErrorsData = [
    {
      "id": "err001",
      "url": "https://example.com/old-product-page",
      "errorType": "404",
      "errorCode": 404,
      "severity": "high",
      "status": "new",
      "firstDetected": "2024-01-15",
      "lastSeen": "2024-01-15",
      "occurrences": 127,
      "description": "Page not found - removed product page still receiving traffic",
      "referringSources": 15,
      "linkedFrom": ["https://example.com/products", "https://example.com/search?q=shoes"],
      "seoImpact": "High traffic loss and poor user experience",
      "recommendedAction": "Set up 301 redirect to similar product or category page",
      "userAgent": "Googlebot",
      "crawlDate": "2024-01-15",
    },
    {
      "id": "err002",
      "url": "https://example.com/blog/category/news",
      "errorType": "500",
      "errorCode": 500,
      "severity": "critical",
      "status": "investigating",
      "firstDetected": "2024-01-14",
      "lastSeen": "2024-01-15",
      "occurrences": 45,
      "description": "Internal server error preventing page access",
      "referringSources": 8,
      "linkedFrom": ["https://example.com/blog", "https://example.com/sitemap.xml"],
      "seoImpact": "Complete loss of page indexing and rankings",
      "recommendedAction": "Fix server configuration or database issues",
      "userAgent": "Googlebot",
      "crawlDate": "2024-01-15",
    },
    {
      "id": "err003",
      "url": "https://example.com/admin/dashboard",
      "errorType": "403",
      "errorCode": 403,
      "severity": "low",
      "status": "ignored",
      "firstDetected": "2024-01-10",
      "lastSeen": "2024-01-15",
      "occurrences": 23,
      "description": "Access forbidden to admin area",
      "referringSources": 2,
      "linkedFrom": [],
      "seoImpact": "No SEO impact - intentionally restricted area",
      "recommendedAction": "Add to robots.txt to prevent crawling",
      "userAgent": "Googlebot",
      "crawlDate": "2024-01-15",
    },
    {
      "id": "err004",
      "url": "https://example.com/promotions/summer-sale",
      "errorType": "soft404",
      "errorCode": 200,
      "severity": "medium",
      "status": "new",
      "firstDetected": "2024-01-13",
      "lastSeen": "2024-01-15",
      "occurrences": 67,
      "description": "Page returns 200 but contains 'not found' content",
      "referringSources": 12,
      "linkedFrom": ["https://example.com/promotions", "Social media links"],
      "seoImpact": "Confuses search engines and users",
      "recommendedAction": "Return proper 404 status code or create relevant content",
      "userAgent": "Googlebot",
      "crawlDate": "2024-01-15",
    },
    {
      "id": "err005",
      "url": "https://example.com/redirect-loop",
      "errorType": "redirect",
      "errorCode": 302,
      "severity": "high",
      "status": "new",
      "firstDetected": "2024-01-14",
      "lastSeen": "2024-01-15",
      "occurrences": 89,
      "description": "Redirect chain exceeds maximum length",
      "referringSources": 6,
      "linkedFrom": ["https://example.com/services"],
      "seoImpact": "Page cannot be crawled or indexed",
      "recommendedAction": "Fix redirect chain and implement direct 301 redirect",
      "userAgent": "Googlebot",
      "crawlDate": "2024-01-15",
    },
    {
      "id": "err006",
      "url": "https://subdomain.example.com/api/data",
      "errorType": "dns",
      "errorCode": 0,
      "severity": "critical",
      "status": "new",
      "firstDetected": "2024-01-15",
      "lastSeen": "2024-01-15",
      "occurrences": 156,
      "description": "DNS resolution failed for subdomain",
      "referringSources": 3,
      "linkedFrom": ["https://example.com/contact"],
      "seoImpact": "Complete inability to access subdomain resources",
      "recommendedAction": "Fix DNS configuration for subdomain",
      "userAgent": "Googlebot",
      "crawlDate": "2024-01-15",
    },
    {
      "id": "err007",
      "url": "https://example.com/legacy/old-section",
      "errorType": "404",
      "errorCode": 404,
      "severity": "medium",
      "status": "fixed",
      "firstDetected": "2024-01-12",
      "lastSeen": "2024-01-13",
      "occurrences": 34,
      "description": "Old section removed without proper redirect",
      "referringSources": 5,
      "linkedFrom": ["https://example.com/sitemap.xml"],
      "seoImpact": "Lost historical SEO value",
      "recommendedAction": "Redirect implemented to relevant current section",
      "userAgent": "Googlebot",
      "crawlDate": "2024-01-13",
    },
    {
      "id": "err008",
      "url": "https://example.com/images/missing-banner.jpg",
      "errorType": "404",
      "errorCode": 404,
      "severity": "low",
      "status": "new",
      "firstDetected": "2024-01-14",
      "lastSeen": "2024-01-15",
      "occurrences": 78,
      "description": "Missing image file causing broken image display",
      "referringSources": 11,
      "linkedFrom": ["https://example.com/home", "https://example.com/about"],
      "seoImpact": "Minor impact on page quality signals",
      "recommendedAction": "Upload missing image or update image references",
      "userAgent": "Googlebot",
      "crawlDate": "2024-01-15",
    },
  ];

  List<Map<String, dynamic>> filteredErrorsData = [];

  @override
  void initState() {
    super.initState();
    _filterErrorsData();
  }

  void _filterErrorsData() {
    filteredErrorsData = crawlErrorsData.where((error) {
      bool typeMatch = selectedErrorType == "all" || error["errorType"] == selectedErrorType;
      bool severityMatch = selectedSeverity == "all" || error["severity"] == selectedSeverity;
      bool statusMatch = selectedStatus == "all" || error["status"] == selectedStatus;
      
      return typeMatch && severityMatch && statusMatch;
    }).toList();
    
    setState(() {});
  }

  Color _getSeverityColor(String severity) {
    switch (severity) {
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
      case "investigating": return warningColor;
      case "fixed": return successColor;
      case "ignored": return disabledColor;
      default: return disabledColor;
    }
  }

  Color _getErrorTypeColor(String errorType) {
    switch (errorType) {
      case "404": return warningColor;
      case "500": return dangerColor;
      case "403": return infoColor;
      case "soft404": return warningColor;
      case "redirect": return infoColor;
      case "dns": return dangerColor;
      default: return disabledColor;
    }
  }

  String _formatSeverity(String severity) {
    return severity[0].toUpperCase() + severity.substring(1);
  }

  String _formatStatus(String status) {
    return status[0].toUpperCase() + status.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    int totalErrors = filteredErrorsData.length;
    int criticalErrors = filteredErrorsData.where((error) => error["severity"] == "critical").length;
    int newErrors = filteredErrorsData.where((error) => error["status"] == "new").length;
    int totalOccurrences = totalErrors > 0 
      ? filteredErrorsData.map((error) => error["occurrences"] as int).reduce((a, b) => a + b)
      : 0;

    return Scaffold(
      appBar: AppBar(
        title: Text("Crawl Errors"),
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
                    "Error Filters",
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
                          label: "Error Type",
                          items: errorTypeItems,
                          value: selectedErrorType,
                          onChanged: (value, label) {
                            selectedErrorType = value;
                            _filterErrorsData();
                          },
                        ),
                      ),
                      Expanded(
                        child: QDropdownField(
                          label: "Severity",
                          items: severityItems,
                          value: selectedSeverity,
                          onChanged: (value, label) {
                            selectedSeverity = value;
                            _filterErrorsData();
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
                          label: "Status",
                          items: statusItems,
                          value: selectedStatus,
                          onChanged: (value, label) {
                            selectedStatus = value;
                            _filterErrorsData();
                          },
                        ),
                      ),
                      Expanded(
                        child: QDropdownField(
                          label: "Date Range",
                          items: dateRangeItems,
                          value: selectedDateRange,
                          onChanged: (value, label) {
                            selectedDateRange = value;
                            setState(() {});
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
                          "Total Errors",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "$totalErrors",
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
                          "$criticalErrors",
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
                          "New",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "$newErrors",
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

            // Crawl Errors List
            ...filteredErrorsData.map((error) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: _getSeverityColor(error["severity"]),
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
                            color: _getErrorTypeColor(error["errorType"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            error["errorType"] == "soft404" ? "Soft 404" : "${error["errorType"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _getErrorTypeColor(error["errorType"]),
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: _getSeverityColor(error["severity"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            _formatSeverity(error["severity"]),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _getSeverityColor(error["severity"]),
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: _getStatusColor(error["status"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            _formatStatus(error["status"]),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _getStatusColor(error["status"]),
                            ),
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${error["occurrences"]} occurrences",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: warningColor,
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
                        "${error["url"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),

                    Text(
                      "${error["description"]}",
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
                                  "SEO Impact:",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: dangerColor,
                                  ),
                                ),
                                Text(
                                  "${error["seoImpact"]}",
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
                                  "Recommended Action:",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                ),
                                Text(
                                  "${error["recommendedAction"]}",
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
                        color: infoColor.withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: infoColor.withAlpha(20),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spSm,
                        children: [
                          Text(
                            "Error Details:",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: infoColor,
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
                                      "First Detected: ${error["firstDetected"]}",
                                      style: TextStyle(fontSize: 12, color: infoColor),
                                    ),
                                    Text(
                                      "Last Seen: ${error["lastSeen"]}",
                                      style: TextStyle(fontSize: 12, color: infoColor),
                                    ),
                                    Text(
                                      "User Agent: ${error["userAgent"]}",
                                      style: TextStyle(fontSize: 12, color: infoColor),
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
                                      "Referring Sources: ${error["referringSources"]}",
                                      style: TextStyle(fontSize: 12, color: infoColor),
                                    ),
                                    Text(
                                      "Error Code: ${error["errorCode"]}",
                                      style: TextStyle(fontSize: 12, color: infoColor),
                                    ),
                                    Text(
                                      "Crawl Date: ${error["crawlDate"]}",
                                      style: TextStyle(fontSize: 12, color: infoColor),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    if ((error["linkedFrom"] as List).isNotEmpty)
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
                          spacing: spXs,
                          children: [
                            Text(
                              "Linked From:",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: warningColor,
                              ),
                            ),
                            ...(error["linkedFrom"] as List).take(3).map((link) => 
                              Text(
                                "• $link",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: warningColor,
                                ),
                              ),
                            ).toList(),
                            if ((error["linkedFrom"] as List).length > 3)
                              Text(
                                "... and ${(error["linkedFrom"] as List).length - 3} more",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: warningColor,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                          ],
                        ),
                      ),

                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: error["status"] == "fixed" ? "View Fix" : "Mark as Fixed",
                            size: bs.sm,
                            onPressed: () {
                              if (error["status"] == "fixed") {
                                si("Error has been resolved");
                              } else {
                                ss("Marking error as fixed");
                              }
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Ignore Error",
                            size: bs.sm,
                            onPressed: () {
                              sw("Error marked as ignored");
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "View Details",
                            size: bs.sm,
                            onPressed: () {
                              si("Opening detailed error analysis");
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),

            if (filteredErrorsData.isEmpty)
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
                      Icons.error_outline,
                      size: 48,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No crawl errors found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Great! Your site has no crawl errors in the selected filters",
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
