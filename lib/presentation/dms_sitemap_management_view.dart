import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsSitemapManagementView extends StatefulWidget {
  const DmsSitemapManagementView({super.key});

  @override
  State<DmsSitemapManagementView> createState() => _DmsSitemapManagementViewState();
}

class _DmsSitemapManagementViewState extends State<DmsSitemapManagementView> {
  String selectedSitemapType = "all";
  String selectedStatus = "all";
  int selectedFilter = 0;

  List<Map<String, dynamic>> sitemapTypeOptions = [
    {"label": "All Types", "value": "all"},
    {"label": "Main Sitemap", "value": "main"},
    {"label": "Product Sitemap", "value": "product"},
    {"label": "Blog Sitemap", "value": "blog"},
    {"label": "Image Sitemap", "value": "image"},
    {"label": "Video Sitemap", "value": "video"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Pending", "value": "pending"},
    {"label": "Error", "value": "error"},
    {"label": "Outdated", "value": "outdated"},
  ];

  List<Map<String, dynamic>> sitemapData = [
    {
      "id": "SM001",
      "name": "Main Website Sitemap",
      "url": "/sitemap.xml",
      "type": "main",
      "status": "active",
      "last_generated": "2024-06-16T08:30:00",
      "file_size": "2.4 MB",
      "url_count": 1250,
      "indexed_count": 1180,
      "error_count": 15,
      "priority": "high",
      "frequency": "daily",
      "compression": true,
      "submitted_to_google": true,
      "submitted_to_bing": true,
      "last_crawled": "2024-06-16T10:15:00",
      "crawl_errors": [
        "404 errors on 8 URLs",
        "Redirect chains on 7 URLs"
      ],
      "coverage": 94.4,
      "description": "Primary sitemap containing all main pages and posts",
    },
    {
      "id": "SM002",
      "name": "Product Catalog Sitemap",
      "url": "/product-sitemap.xml",
      "type": "product",
      "status": "active",
      "last_generated": "2024-06-16T06:00:00",
      "file_size": "8.7 MB",
      "url_count": 3420,
      "indexed_count": 3280,
      "error_count": 45,
      "priority": "high",
      "frequency": "hourly",
      "compression": true,
      "submitted_to_google": true,
      "submitted_to_bing": true,
      "last_crawled": "2024-06-16T09:45:00",
      "crawl_errors": [
        "Out of stock products indexed",
        "Duplicate product URLs"
      ],
      "coverage": 95.9,
      "description": "E-commerce product catalog with pricing and availability",
    },
    {
      "id": "SM003",
      "name": "Blog Content Sitemap",
      "url": "/blog-sitemap.xml",
      "type": "blog",
      "status": "active",
      "last_generated": "2024-06-15T20:30:00",
      "file_size": "1.2 MB",
      "url_count": 680,
      "indexed_count": 650,
      "error_count": 8,
      "priority": "medium",
      "frequency": "weekly",
      "compression": true,
      "submitted_to_google": true,
      "submitted_to_bing": false,
      "last_crawled": "2024-06-16T07:20:00",
      "crawl_errors": [
        "Draft posts included",
        "Missing canonical tags"
      ],
      "coverage": 95.6,
      "description": "Blog articles and news content sitemap",
    },
    {
      "id": "SM004",
      "name": "Image Resources Sitemap",
      "url": "/image-sitemap.xml",
      "type": "image",
      "status": "pending",
      "last_generated": "2024-06-14T14:00:00",
      "file_size": "5.1 MB",
      "url_count": 2100,
      "indexed_count": 1850,
      "error_count": 120,
      "priority": "medium",
      "frequency": "daily",
      "compression": true,
      "submitted_to_google": false,
      "submitted_to_bing": false,
      "last_crawled": "2024-06-15T16:30:00",
      "crawl_errors": [
        "Broken image links",
        "Missing alt text metadata",
        "Large file sizes affecting crawl"
      ],
      "coverage": 88.1,
      "description": "Product images and media content sitemap",
    },
    {
      "id": "SM005",
      "name": "Video Content Sitemap",
      "url": "/video-sitemap.xml",
      "type": "video",
      "status": "error",
      "last_generated": "2024-06-12T10:15:00",
      "file_size": "890 KB",
      "url_count": 145,
      "indexed_count": 98,
      "error_count": 47,
      "priority": "low",
      "frequency": "monthly",
      "compression": false,
      "submitted_to_google": true,
      "submitted_to_bing": false,
      "last_crawled": "2024-06-14T12:00:00",
      "crawl_errors": [
        "Video files not accessible",
        "Missing video metadata",
        "Unsupported video formats"
      ],
      "coverage": 67.6,
      "description": "Tutorial and promotional video content",
    },
    {
      "id": "SM006",
      "name": "News Articles Sitemap",
      "url": "/news-sitemap.xml",
      "type": "blog",
      "status": "outdated",
      "last_generated": "2024-05-28T12:00:00",
      "file_size": "340 KB",
      "url_count": 180,
      "indexed_count": 165,
      "error_count": 3,
      "priority": "low",
      "frequency": "daily",
      "compression": true,
      "submitted_to_google": true,
      "submitted_to_bing": true,
      "last_crawled": "2024-06-10T08:45:00",
      "crawl_errors": [
        "Old articles still indexed"
      ],
      "coverage": 91.7,
      "description": "Time-sensitive news and announcements",
    },
  ];

  List<Map<String, dynamic>> get filteredSitemaps {
    List<Map<String, dynamic>> filtered = sitemapData;

    if (selectedSitemapType != "all") {
      filtered = filtered.where((item) => item["type"] == selectedSitemapType).toList();
    }

    if (selectedStatus != "all") {
      filtered = filtered.where((item) => item["status"] == selectedStatus).toList();
    }

    switch (selectedFilter) {
      case 1: // High Priority
        filtered = filtered.where((item) => item["priority"] == "high").toList();
        break;
      case 2: // With Errors
        filtered = filtered.where((item) => (item["error_count"] as int) > 20).toList();
        break;
      case 3: // Recent Updates
        filtered = filtered.where((item) => DateTime.parse(item["last_generated"]).isAfter(DateTime.now().subtract(Duration(days: 2)))).toList();
        break;
    }

    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "pending":
        return warningColor;
      case "error":
        return dangerColor;
      case "outdated":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "main":
        return primaryColor;
      case "product":
        return successColor;
      case "blog":
        return infoColor;
      case "image":
        return warningColor;
      case "video":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sitemap Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Create new sitemap
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              // Regenerate all sitemaps
            },
          ),
          IconButton(
            icon: Icon(Icons.upload),
            onPressed: () {
              // Submit to search engines
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
                    label: "Sitemap Type",
                    items: sitemapTypeOptions,
                    value: selectedSitemapType,
                    onChanged: (value, label) {
                      selectedSitemapType = value;
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
                {"label": "All Sitemaps", "value": 0},
                {"label": "High Priority", "value": 1},
                {"label": "With Errors", "value": 2},
                {"label": "Recent Updates", "value": 3},
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
                          "Total URLs",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${((sitemapData.map((s) => s["url_count"] as int).reduce((a, b) => a + b)) / 1000).toStringAsFixed(1)}K",
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
                          "Indexed",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${((sitemapData.map((s) => s["indexed_count"] as int).reduce((a, b) => a + b)) / 1000).toStringAsFixed(1)}K",
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
                          "Avg Coverage",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${((sitemapData.map((s) => s["coverage"] as double).reduce((a, b) => a + b)) / sitemapData.length).toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),

            // Sitemap List
            Text(
              "Sitemap Files",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            ...filteredSitemaps.map((sitemap) {
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
                      color: _getStatusColor(sitemap["status"] as String),
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
                                      color: _getTypeColor(sitemap["type"] as String).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${sitemap["type"]}".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: _getTypeColor(sitemap["type"] as String),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor(sitemap["status"] as String).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${sitemap["status"]}".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: _getStatusColor(sitemap["status"] as String),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spSm),
                              Text(
                                "${sitemap["name"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${sitemap["url"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                  fontFamily: 'monospace',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "${((sitemap["url_count"] as int) / 1000).toStringAsFixed(1)}K",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "URLs",
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

                    // Description
                    Text(
                      "${sitemap["description"]}",
                      style: TextStyle(
                        fontSize: 13,
                        color: disabledBoldColor,
                      ),
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
                                "Coverage",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${sitemap["coverage"]}%",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: (sitemap["coverage"] as double) > 90 ? successColor : warningColor,
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
                                "File Size",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${sitemap["file_size"]}",
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
                                "Errors",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${sitemap["error_count"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: (sitemap["error_count"] as int) < 10 ? successColor : dangerColor,
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
                                "Frequency",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${sitemap["frequency"]}",
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

                    // Search Engine Submission Status
                    Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: sitemap["submitted_to_google"] ? successColor : disabledBoldColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Google",
                          style: TextStyle(
                            fontSize: 12,
                            color: sitemap["submitted_to_google"] ? successColor : disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Icon(
                          Icons.search,
                          color: sitemap["submitted_to_bing"] ? successColor : disabledBoldColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Bing",
                          style: TextStyle(
                            fontSize: 12,
                            color: sitemap["submitted_to_bing"] ? successColor : disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Spacer(),
                        if (sitemap["compression"]) ...[
                          Icon(
                            Icons.compress,
                            color: infoColor,
                            size: 16,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Compressed",
                            style: TextStyle(
                              fontSize: 12,
                              color: infoColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: spSm),

                    // Crawl Errors
                    if ((sitemap["crawl_errors"] as List).isNotEmpty) ...[
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
                            Text(
                              "Crawl Errors:",
                              style: TextStyle(
                                fontSize: 12,
                                color: dangerColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: spXs),
                            ...(sitemap["crawl_errors"] as List).map((error) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: spXs),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "• ",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: dangerColor,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "$error",
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
                    ],

                    // Last Generated
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.schedule,
                            color: infoColor,
                            size: 16,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Last Generated: ${DateTime.parse(sitemap["last_generated"]).dMMMy}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: infoColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "Last Crawled: ${DateTime.parse(sitemap["last_crawled"]).dMMMy}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
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
                            label: "Regenerate",
                            size: bs.sm,
                            onPressed: () {
                              // Regenerate sitemap
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.download,
                          size: bs.sm,
                          onPressed: () {
                            // Download sitemap
                          },
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.upload,
                          size: bs.sm,
                          onPressed: () {
                            // Submit to search engines
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
