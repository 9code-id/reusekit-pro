import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsBacklinkMonitoringView extends StatefulWidget {
  const DmsBacklinkMonitoringView({super.key});

  @override
  State<DmsBacklinkMonitoringView> createState() => _DmsBacklinkMonitoringViewState();
}

class _DmsBacklinkMonitoringViewState extends State<DmsBacklinkMonitoringView> {
  String selectedTimeRange = "last_7_days";
  String selectedStatus = "all";
  String selectedType = "all";
  String searchQuery = "";
  
  List<Map<String, dynamic>> timeRangeOptions = [
    {"label": "Last 7 Days", "value": "last_7_days"},
    {"label": "Last 30 Days", "value": "last_30_days"},
    {"label": "Last 3 Months", "value": "last_3_months"},
    {"label": "Last 6 Months", "value": "last_6_months"},
    {"label": "Last Year", "value": "last_year"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Lost", "value": "lost"},
    {"label": "New", "value": "new"},
    {"label": "Broken", "value": "broken"},
  ];

  List<Map<String, dynamic>> typeOptions = [
    {"label": "All Types", "value": "all"},
    {"label": "Dofollow", "value": "dofollow"},
    {"label": "Nofollow", "value": "nofollow"},
    {"label": "Sponsored", "value": "sponsored"},
    {"label": "UGC", "value": "ugc"},
  ];

  List<Map<String, dynamic>> backlinkChanges = [
    {
      "id": 1,
      "source_url": "https://techcrunch.com/article-123",
      "source_domain": "techcrunch.com",
      "target_url": "https://oursite.com/product/ai-tools",
      "anchor_text": "best AI tools 2024",
      "change_type": "new",
      "status": "active",
      "link_type": "dofollow",
      "discovery_date": DateTime.now().subtract(Duration(days: 2)),
      "domain_authority": 92,
      "spam_score": 1,
      "traffic_value": 1250,
      "referring_domains": 15420,
      "organic_keywords": 892000,
      "change_impact": "high",
      "previous_anchor": "",
      "link_position": "content",
      "page_authority": 78,
      "trust_flow": 65,
      "citation_flow": 72,
    },
    {
      "id": 2,
      "source_url": "https://blog.competitor.com/removed-link",
      "source_domain": "competitor.com",
      "target_url": "https://oursite.com/blog/seo-guide",
      "anchor_text": "",
      "change_type": "lost",
      "status": "lost",
      "link_type": "dofollow",
      "discovery_date": DateTime.now().subtract(Duration(days: 1)),
      "domain_authority": 67,
      "spam_score": 8,
      "traffic_value": 430,
      "referring_domains": 2840,
      "organic_keywords": 145000,
      "change_impact": "medium",
      "previous_anchor": "complete SEO guide",
      "link_position": "sidebar",
      "page_authority": 45,
      "trust_flow": 32,
      "citation_flow": 48,
    },
    {
      "id": 3,
      "source_url": "https://industry-news.com/feature-story",
      "source_domain": "industry-news.com",
      "target_url": "https://oursite.com/",
      "anchor_text": "oursite.com",
      "change_type": "modified",
      "status": "active",
      "link_type": "nofollow",
      "discovery_date": DateTime.now().subtract(Duration(hours: 8)),
      "domain_authority": 58,
      "spam_score": 3,
      "traffic_value": 680,
      "referring_domains": 1250,
      "organic_keywords": 78000,
      "change_impact": "low",
      "previous_anchor": "leading AI company",
      "link_position": "content",
      "page_authority": 62,
      "trust_flow": 45,
      "citation_flow": 54,
    },
    {
      "id": 4,
      "source_url": "https://broken-site.com/dead-page",
      "source_domain": "broken-site.com",
      "target_url": "https://oursite.com/contact",
      "anchor_text": "contact us",
      "change_type": "broken",
      "status": "broken",
      "link_type": "dofollow",
      "discovery_date": DateTime.now().subtract(Duration(days: 5)),
      "domain_authority": 42,
      "spam_score": 15,
      "traffic_value": 85,
      "referring_domains": 340,
      "organic_keywords": 12000,
      "change_impact": "low",
      "previous_anchor": "contact us",
      "link_position": "footer",
      "page_authority": 28,
      "trust_flow": 18,
      "citation_flow": 25,
    },
    {
      "id": 5,
      "source_url": "https://authoritative-journal.com/research-paper",
      "source_domain": "authoritative-journal.com",
      "target_url": "https://oursite.com/research/whitepaper",
      "anchor_text": "comprehensive research study",
      "change_type": "new",
      "status": "active",
      "link_type": "dofollow",
      "discovery_date": DateTime.now().subtract(Duration(hours: 3)),
      "domain_authority": 88,
      "spam_score": 0,
      "traffic_value": 2100,
      "referring_domains": 8750,
      "organic_keywords": 234000,
      "change_impact": "high",
      "previous_anchor": "",
      "link_position": "content",
      "page_authority": 85,
      "trust_flow": 82,
      "citation_flow": 79,
    },
  ];

  List<Map<String, dynamic>> get filteredBacklinkChanges {
    return backlinkChanges.where((change) {
      bool matchesStatus = selectedStatus == "all" || change["status"] == selectedStatus;
      bool matchesType = selectedType == "all" || change["link_type"] == selectedType;
      bool matchesSearch = searchQuery.isEmpty || 
          (change["source_domain"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (change["anchor_text"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (change["target_url"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      return matchesStatus && matchesType && matchesSearch;
    }).toList();
  }

  Color _getChangeTypeColor(String changeType) {
    switch (changeType) {
      case "new":
        return successColor;
      case "lost":
        return dangerColor;
      case "modified":
        return warningColor;
      case "broken":
        return Colors.orange;
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
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filtered = filteredBacklinkChanges;
    
    // Summary statistics
    int totalChanges = filtered.length;
    int newLinks = filtered.where((item) => item["change_type"] == "new").length;
    int lostLinks = filtered.where((item) => item["change_type"] == "lost").length;
    int brokenLinks = filtered.where((item) => item["change_type"] == "broken").length;
    
    double totalTrafficValue = filtered.fold(0.0, (sum, item) => sum + (item["traffic_value"] as int).toDouble());
    double avgDomainAuthority = filtered.isEmpty ? 0 : filtered.fold(0.0, (sum, item) => sum + (item["domain_authority"] as int).toDouble()) / filtered.length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Backlink Monitoring"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Summary Cards
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
                        Row(
                          children: [
                            Icon(Icons.trending_up, color: successColor, size: 20),
                            SizedBox(width: spXs),
                            Text(
                              "New Links",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "$newLinks",
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
                        Row(
                          children: [
                            Icon(Icons.trending_down, color: dangerColor, size: 20),
                            SizedBox(width: spXs),
                            Text(
                              "Lost Links",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "$lostLinks",
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
              ],
            ),
            
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
                        Row(
                          children: [
                            Icon(Icons.broken_image, color: warningColor, size: 20),
                            SizedBox(width: spXs),
                            Text(
                              "Broken Links",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "$brokenLinks",
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
                        Row(
                          children: [
                            Icon(Icons.traffic, color: infoColor, size: 20),
                            SizedBox(width: spXs),
                            Text(
                              "Traffic Value",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "\$${(totalTrafficValue / 1000).toStringAsFixed(1)}K",
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
              ],
            ),

            // Filters
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
                    "Filters",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search",
                          value: searchQuery,
                          hint: "Search by domain, anchor text, or URL",
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Time Range",
                          items: timeRangeOptions,
                          value: selectedTimeRange,
                          onChanged: (value, label) {
                            selectedTimeRange = value;
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
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Link Type",
                          items: typeOptions,
                          value: selectedType,
                          onChanged: (value, label) {
                            selectedType = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(top: 24),
                          child: QButton(
                            label: "Export Report",
                            icon: Icons.download,
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Results Summary
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Showing ${filtered.length} backlink changes",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Avg DA: ${avgDomainAuthority.toStringAsFixed(1)}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),

            // Backlink Changes List
            ...filtered.map((change) {
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
                      color: _getChangeTypeColor(change["change_type"]),
                    ),
                  ),
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${change["source_domain"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${(change["discovery_date"] as DateTime).dMMMy}",
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
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                              decoration: BoxDecoration(
                                color: _getChangeTypeColor(change["change_type"]).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${change["change_type"]}".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: _getChangeTypeColor(change["change_type"]),
                                ),
                              ),
                            ),
                            SizedBox(height: 2),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: _getImpactColor(change["change_impact"]).withAlpha(15),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${change["change_impact"]} impact".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.w600,
                                  color: _getImpactColor(change["change_impact"]),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // URLs and Anchor Text
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Column(
                        spacing: spXs,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (change["anchor_text"].toString().isNotEmpty) ...[
                            Row(
                              children: [
                                Icon(Icons.text_fields, color: disabledBoldColor, size: 14),
                                SizedBox(width: spXs),
                                Text(
                                  "Anchor Text:",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "\"${change["anchor_text"]}\"",
                              style: TextStyle(
                                fontSize: 13,
                                color: primaryColor,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                          if (change["previous_anchor"].toString().isNotEmpty) ...[
                            Row(
                              children: [
                                Icon(Icons.history, color: disabledBoldColor, size: 14),
                                SizedBox(width: spXs),
                                Text(
                                  "Previous:",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "\"${change["previous_anchor"]}\"",
                              style: TextStyle(
                                fontSize: 13,
                                color: disabledBoldColor,
                                fontStyle: FontStyle.italic,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                          Row(
                            children: [
                              Icon(Icons.link, color: disabledBoldColor, size: 14),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${change["target_url"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: infoColor,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Metrics Grid
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "${change["domain_authority"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "DA",
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
                            children: [
                              Text(
                                "${change["spam_score"]}%",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: (change["spam_score"] as int) > 10 ? dangerColor : successColor,
                                ),
                              ),
                              Text(
                                "Spam",
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
                            children: [
                              Text(
                                "\$${(change["traffic_value"] as int)}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Value",
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
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: change["link_type"] == "dofollow" ? successColor.withAlpha(20) : warningColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${change["link_type"]}".toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                    color: change["link_type"] == "dofollow" ? successColor : warningColor,
                                  ),
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                "${change["link_position"]}",
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

                    // Action Buttons
                    Row(
                      children: [
                        QButton(
                          label: "View Details",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          label: "Check Status",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                        Spacer(),
                        if (change["change_type"] == "lost") 
                          QButton(
                            label: "Request Restoration",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        if (change["change_type"] == "broken")
                          QButton(
                            label: "Report Issue",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),

            if (filtered.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.search_off,
                        size: 48,
                        color: disabledColor,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "No backlink changes found",
                        style: TextStyle(
                          fontSize: 16,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Try adjusting your filters or search criteria",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
