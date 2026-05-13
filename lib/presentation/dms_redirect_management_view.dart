import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsRedirectManagementView extends StatefulWidget {
  const DmsRedirectManagementView({super.key});

  @override
  State<DmsRedirectManagementView> createState() => _DmsRedirectManagementViewState();
}

class _DmsRedirectManagementViewState extends State<DmsRedirectManagementView> {
  String selectedRedirectType = "all";
  String selectedStatus = "all";
  int selectedFilter = 0;

  List<Map<String, dynamic>> redirectTypeOptions = [
    {"label": "All Types", "value": "all"},
    {"label": "301 Permanent", "value": "301"},
    {"label": "302 Temporary", "value": "302"},
    {"label": "307 Temporary", "value": "307"},
    {"label": "Meta Refresh", "value": "meta"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Inactive", "value": "inactive"},
    {"label": "Error", "value": "error"},
    {"label": "Pending", "value": "pending"},
  ];

  List<Map<String, dynamic>> redirectData = [
    {
      "id": "R001",
      "source_url": "/old-blog/marketing-tips",
      "destination_url": "/blog/digital-marketing-tips",
      "redirect_type": "301",
      "status": "active",
      "created_date": "2024-01-15",
      "last_checked": "2024-06-15",
      "click_count": 1250,
      "success_rate": 98.5,
      "response_time": 120,
      "error_count": 18,
      "description": "Blog post URL structure change",
      "tags": ["blog", "marketing", "content"],
      "priority": "high",
      "notes": "Important redirect for SEO ranking preservation",
    },
    {
      "id": "R002",
      "source_url": "/products/old-category",
      "destination_url": "/shop/electronics",
      "redirect_type": "301",
      "status": "active",
      "created_date": "2024-02-20",
      "last_checked": "2024-06-14",
      "click_count": 890,
      "success_rate": 99.1,
      "response_time": 95,
      "error_count": 8,
      "description": "Product category restructure",
      "tags": ["products", "ecommerce", "category"],
      "priority": "medium",
      "notes": "Part of site architecture improvement",
    },
    {
      "id": "R003",
      "source_url": "/temp-promo",
      "destination_url": "/promotions/summer-sale",
      "redirect_type": "302",
      "status": "inactive",
      "created_date": "2024-05-01",
      "last_checked": "2024-06-10",
      "click_count": 2100,
      "success_rate": 97.8,
      "response_time": 110,
      "error_count": 46,
      "description": "Temporary promotional redirect",
      "tags": ["promotion", "temporary", "sale"],
      "priority": "low",
      "notes": "Promotion ended, redirect deactivated",
    },
    {
      "id": "R004",
      "source_url": "/old-about-us",
      "destination_url": "/company/about",
      "redirect_type": "301",
      "status": "error",
      "created_date": "2024-03-10",
      "last_checked": "2024-06-16",
      "click_count": 340,
      "success_rate": 85.2,
      "response_time": 450,
      "error_count": 102,
      "description": "About page URL update",
      "tags": ["company", "about", "info"],
      "priority": "high",
      "notes": "Destination page returning 404 errors",
    },
    {
      "id": "R005",
      "source_url": "/legacy/services",
      "destination_url": "/services/digital-marketing",
      "redirect_type": "301",
      "status": "active",
      "created_date": "2024-01-08",
      "last_checked": "2024-06-16",
      "click_count": 1580,
      "success_rate": 99.5,
      "response_time": 88,
      "error_count": 8,
      "description": "Legacy service page redirect",
      "tags": ["services", "legacy", "marketing"],
      "priority": "medium",
      "notes": "Excellent performance, well-optimized",
    },
    {
      "id": "R006",
      "source_url": "/contact-old",
      "destination_url": "/contact-us",
      "redirect_type": "meta",
      "status": "pending",
      "created_date": "2024-06-10",
      "last_checked": "2024-06-16",
      "click_count": 45,
      "success_rate": 92.0,
      "response_time": 200,
      "error_count": 4,
      "description": "Contact page URL cleanup",
      "tags": ["contact", "cleanup", "meta"],
      "priority": "low",
      "notes": "Recently created, monitoring performance",
    },
  ];

  List<Map<String, dynamic>> get filteredRedirects {
    List<Map<String, dynamic>> filtered = redirectData;

    if (selectedRedirectType != "all") {
      filtered = filtered.where((item) => item["redirect_type"] == selectedRedirectType).toList();
    }

    if (selectedStatus != "all") {
      filtered = filtered.where((item) => item["status"] == selectedStatus).toList();
    }

    switch (selectedFilter) {
      case 1: // High Traffic
        filtered = filtered.where((item) => (item["click_count"] as int) > 1000).toList();
        break;
      case 2: // Errors
        filtered = filtered.where((item) => item["status"] == "error" || (item["error_count"] as int) > 50).toList();
        break;
      case 3: // Recent
        filtered = filtered.where((item) => DateTime.parse(item["created_date"]).isAfter(DateTime.now().subtract(Duration(days: 30)))).toList();
        break;
    }

    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "inactive":
        return disabledBoldColor;
      case "error":
        return dangerColor;
      case "pending":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getRedirectTypeColor(String type) {
    switch (type) {
      case "301":
        return successColor;
      case "302":
        return infoColor;
      case "307":
        return warningColor;
      case "meta":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Redirect Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Add new redirect
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              // Check all redirects
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              // Export redirect report
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
                    label: "Redirect Type",
                    items: redirectTypeOptions,
                    value: selectedRedirectType,
                    onChanged: (value, label) {
                      selectedRedirectType = value;
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
                {"label": "All Redirects", "value": 0},
                {"label": "High Traffic", "value": 1},
                {"label": "With Errors", "value": 2},
                {"label": "Recent", "value": 3},
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
                          "Total Redirects",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${redirectData.length}",
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
                          "Total Clicks",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${((redirectData.map((r) => r["click_count"] as int).reduce((a, b) => a + b)) / 1000).toStringAsFixed(1)}K",
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
                          "Avg Success Rate",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${((redirectData.map((r) => r["success_rate"] as double).reduce((a, b) => a + b)) / redirectData.length).toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),

            // Redirect List
            Text(
              "Redirect Rules",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            ...filteredRedirects.map((redirect) {
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
                      color: _getStatusColor(redirect["status"] as String),
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
                                      color: _getRedirectTypeColor(redirect["redirect_type"] as String).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${redirect["redirect_type"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: _getRedirectTypeColor(redirect["redirect_type"] as String),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor(redirect["status"] as String).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${redirect["status"]}".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: _getStatusColor(redirect["status"] as String),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spSm),
                              Text(
                                "${redirect["description"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "ID: ${redirect["id"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "${((redirect["click_count"] as int) / 1000).toStringAsFixed(1)}K",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),

                    // URL Mapping
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
                                Icons.input,
                                color: disabledBoldColor,
                                size: 16,
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  "${redirect["source_url"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: primaryColor,
                                    fontFamily: 'monospace',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Icon(
                                Icons.arrow_downward,
                                color: successColor,
                                size: 16,
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  "${redirect["destination_url"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: successColor,
                                    fontFamily: 'monospace',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: spSm),

                    // Performance Metrics
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Success Rate",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${redirect["success_rate"]}%",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: (redirect["success_rate"] as double) > 95 ? successColor : warningColor,
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
                                "Response Time",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${redirect["response_time"]}ms",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: (redirect["response_time"] as int) < 200 ? successColor : warningColor,
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
                                "Errors",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${redirect["error_count"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: (redirect["error_count"] as int) < 20 ? successColor : dangerColor,
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
                                "Last Checked",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${DateTime.parse(redirect["last_checked"]).dMMMy}",
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

                    // Tags
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: (redirect["tags"] as List).map((tag) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "$tag",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: infoColor,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: spSm),

                    // Notes
                    if (redirect["notes"] != null && (redirect["notes"] as String).isNotEmpty) ...[
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
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.notes,
                              color: warningColor,
                              size: 16,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "${redirect["notes"]}",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: spSm),
                    ],

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Edit Redirect",
                            size: bs.sm,
                            onPressed: () {
                              // Edit redirect rule
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.play_arrow,
                          size: bs.sm,
                          onPressed: () {
                            // Test redirect
                          },
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.analytics,
                          size: bs.sm,
                          onPressed: () {
                            // View analytics
                          },
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.delete,
                          size: bs.sm,
                          onPressed: () {
                            // Delete redirect
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
