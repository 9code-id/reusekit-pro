import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsLinkBuildingView extends StatefulWidget {
  const DmsLinkBuildingView({super.key});

  @override
  State<DmsLinkBuildingView> createState() => _DmsLinkBuildingViewState();
}

class _DmsLinkBuildingViewState extends State<DmsLinkBuildingView> {
  String selectedCampaignType = "all";
  String selectedStatus = "all";
  int selectedFilter = 0;

  List<Map<String, dynamic>> campaignTypeOptions = [
    {"label": "All Campaigns", "value": "all"},
    {"label": "Guest Posting", "value": "guest_posting"},
    {"label": "Resource Page", "value": "resource_page"},
    {"label": "Broken Link", "value": "broken_link"},
    {"label": "Competitor Analysis", "value": "competitor"},
    {"label": "HARO/PR", "value": "haro"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Pending", "value": "pending"},
    {"label": "Completed", "value": "completed"},
    {"label": "Paused", "value": "paused"},
  ];

  List<Map<String, dynamic>> campaignData = [
    {
      "id": "LB001",
      "campaign_name": "Tech Blog Guest Posting Q2 2024",
      "campaign_type": "guest_posting",
      "status": "active",
      "start_date": "2024-04-01",
      "end_date": "2024-06-30",
      "target_links": 25,
      "acquired_links": 12,
      "pending_outreach": 8,
      "success_rate": 48.0,
      "average_da": 75,
      "total_budget": 5000,
      "spent_budget": 2400,
      "cost_per_link": 200,
      "target_keywords": ["digital marketing", "SEO tools", "content strategy"],
      "target_domains": [
        {
          "domain": "techcrunch.com",
          "da": 92,
          "status": "completed",
          "contact_email": "editorial@techcrunch.com",
          "pitch_sent": "2024-05-15",
          "response_date": "2024-05-20",
          "article_published": "2024-06-10",
          "link_acquired": true
        },
        {
          "domain": "marketingland.com",
          "da": 85,
          "status": "pending",
          "contact_email": "editor@marketingland.com",
          "pitch_sent": "2024-06-12",
          "response_date": null,
          "article_published": null,
          "link_acquired": false
        },
        {
          "domain": "searchengineland.com",
          "da": 88,
          "status": "active",
          "contact_email": "content@searchengineland.com",
          "pitch_sent": "2024-06-05",
          "response_date": "2024-06-08",
          "article_published": null,
          "link_acquired": false
        }
      ],
      "performance_metrics": {
        "referral_traffic": 1250,
        "ranking_improvement": "+12 positions avg",
        "domain_authority_gain": "+2 points",
        "brand_mentions": 18
      },
      "next_actions": [
        "Follow up with 3 pending prospects",
        "Draft article for SearchEngineLand",
        "Research 5 new target domains"
      ]
    },
    {
      "id": "LB002",
      "campaign_name": "Resource Page Link Building - Marketing Tools",
      "campaign_type": "resource_page",
      "status": "active",
      "start_date": "2024-05-01",
      "end_date": "2024-07-31",
      "target_links": 40,
      "acquired_links": 18,
      "pending_outreach": 15,
      "success_rate": 45.0,
      "average_da": 68,
      "total_budget": 3000,
      "spent_budget": 1350,
      "cost_per_link": 75,
      "target_keywords": ["marketing tools", "SEO software", "analytics platform"],
      "target_domains": [
        {
          "domain": "buffer.com",
          "da": 82,
          "status": "completed",
          "contact_email": "team@buffer.com",
          "pitch_sent": "2024-05-20",
          "response_date": "2024-05-25",
          "article_published": "2024-06-02",
          "link_acquired": true
        },
        {
          "domain": "hubspot.com",
          "da": 91,
          "status": "pending",
          "contact_email": "content@hubspot.com",
          "pitch_sent": "2024-06-10",
          "response_date": null,
          "article_published": null,
          "link_acquired": false
        }
      ],
      "performance_metrics": {
        "referral_traffic": 890,
        "ranking_improvement": "+8 positions avg",
        "domain_authority_gain": "+1 point",
        "brand_mentions": 12
      },
      "next_actions": [
        "Research university resource pages",
        "Update tool descriptions for better appeal",
        "Follow up with HubSpot team"
      ]
    },
    {
      "id": "LB003",
      "campaign_name": "Broken Link Building - Web Dev Resources",
      "campaign_type": "broken_link",
      "status": "completed",
      "start_date": "2024-03-01",
      "end_date": "2024-05-31",
      "target_links": 30,
      "acquired_links": 22,
      "pending_outreach": 0,
      "success_rate": 73.3,
      "average_da": 71,
      "total_budget": 2500,
      "spent_budget": 2500,
      "cost_per_link": 114,
      "target_keywords": ["web development", "coding resources", "developer tools"],
      "target_domains": [
        {
          "domain": "css-tricks.com",
          "da": 79,
          "status": "completed",
          "contact_email": "chris@css-tricks.com",
          "pitch_sent": "2024-03-15",
          "response_date": "2024-03-20",
          "article_published": "2024-04-05",
          "link_acquired": true
        },
        {
          "domain": "smashingmagazine.com",
          "da": 86,
          "status": "completed",
          "contact_email": "editors@smashingmagazine.com",
          "pitch_sent": "2024-04-02",
          "response_date": "2024-04-10",
          "article_published": "2024-04-25",
          "link_acquired": true
        }
      ],
      "performance_metrics": {
        "referral_traffic": 1580,
        "ranking_improvement": "+15 positions avg",
        "domain_authority_gain": "+3 points",
        "brand_mentions": 25
      },
      "next_actions": [
        "Analyze performance data",
        "Document successful strategies",
        "Plan follow-up campaigns"
      ]
    },
    {
      "id": "LB004",
      "campaign_name": "HARO Link Building - Business & Finance",
      "campaign_type": "haro",
      "status": "active",
      "start_date": "2024-06-01",
      "end_date": "2024-08-31",
      "target_links": 15,
      "acquired_links": 4,
      "pending_outreach": 6,
      "success_rate": 26.7,
      "average_da": 82,
      "total_budget": 1500,
      "spent_budget": 400,
      "cost_per_link": 100,
      "target_keywords": ["business strategy", "financial planning", "entrepreneurship"],
      "target_domains": [
        {
          "domain": "entrepreneur.com",
          "da": 90,
          "status": "completed",
          "contact_email": "reporter@entrepreneur.com",
          "pitch_sent": "2024-06-08",
          "response_date": "2024-06-12",
          "article_published": "2024-06-15",
          "link_acquired": true
        },
        {
          "domain": "inc.com",
          "da": 89,
          "status": "pending",
          "contact_email": "journalist@inc.com",
          "pitch_sent": "2024-06-14",
          "response_date": null,
          "article_published": null,
          "link_acquired": false
        }
      ],
      "performance_metrics": {
        "referral_traffic": 420,
        "ranking_improvement": "+5 positions avg",
        "domain_authority_gain": "+1 point",
        "brand_mentions": 8
      },
      "next_actions": [
        "Respond to 3 active HARO queries",
        "Improve response template",
        "Track journalist relationships"
      ]
    },
    {
      "id": "LB005",
      "campaign_name": "Competitor Backlink Analysis & Acquisition",
      "campaign_type": "competitor",
      "status": "paused",
      "start_date": "2024-05-15",
      "end_date": "2024-07-15",
      "target_links": 20,
      "acquired_links": 6,
      "pending_outreach": 4,
      "success_rate": 30.0,
      "average_da": 77,
      "total_budget": 4000,
      "spent_budget": 1200,
      "cost_per_link": 200,
      "target_keywords": ["digital agency", "marketing services", "SEO consulting"],
      "target_domains": [
        {
          "domain": "moz.com",
          "da": 91,
          "status": "completed",
          "contact_email": "community@moz.com",
          "pitch_sent": "2024-05-25",
          "response_date": "2024-06-02",
          "article_published": "2024-06-10",
          "link_acquired": true
        }
      ],
      "performance_metrics": {
        "referral_traffic": 680,
        "ranking_improvement": "+7 positions avg",
        "domain_authority_gain": "+1 point",
        "brand_mentions": 10
      },
      "next_actions": [
        "Review campaign performance",
        "Analyze competitor changes",
        "Decide on campaign continuation"
      ]
    },
  ];

  List<Map<String, dynamic>> get filteredCampaigns {
    List<Map<String, dynamic>> filtered = campaignData;

    if (selectedCampaignType != "all") {
      filtered = filtered.where((item) => item["campaign_type"] == selectedCampaignType).toList();
    }

    if (selectedStatus != "all") {
      filtered = filtered.where((item) => item["status"] == selectedStatus).toList();
    }

    switch (selectedFilter) {
      case 1: // High Performance
        filtered = filtered.where((item) => (item["success_rate"] as double) > 50.0).toList();
        break;
      case 2: // Budget Efficient
        filtered = filtered.where((item) => (item["cost_per_link"] as int) < 150).toList();
        break;
      case 3: // Recent Activity
        filtered = filtered.where((item) => DateTime.parse(item["start_date"]).isAfter(DateTime.now().subtract(Duration(days: 60)))).toList();
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
      case "completed":
        return infoColor;
      case "paused":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getCampaignTypeColor(String type) {
    switch (type) {
      case "guest_posting":
        return primaryColor;
      case "resource_page":
        return successColor;
      case "broken_link":
        return warningColor;
      case "competitor":
        return infoColor;
      case "haro":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Link Building"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Create new campaign
            },
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              // View campaign analytics
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              // Export campaign report
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
                    label: "Campaign Type",
                    items: campaignTypeOptions,
                    value: selectedCampaignType,
                    onChanged: (value, label) {
                      selectedCampaignType = value;
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
                {"label": "All Campaigns", "value": 0},
                {"label": "High Performance", "value": 1},
                {"label": "Budget Efficient", "value": 2},
                {"label": "Recent Activity", "value": 3},
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
                          "Active Campaigns",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${campaignData.where((c) => c["status"] == "active").length}",
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
                          "Links Acquired",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${campaignData.map((c) => c["acquired_links"] as int).reduce((a, b) => a + b)}",
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
                          "${((campaignData.map((c) => c["success_rate"] as double).reduce((a, b) => a + b)) / campaignData.length).toStringAsFixed(1)}%",
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

            // Campaign List
            Text(
              "Link Building Campaigns",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            ...filteredCampaigns.map((campaign) {
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
                      color: _getStatusColor(campaign["status"] as String),
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
                                      color: _getCampaignTypeColor(campaign["campaign_type"] as String).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${campaign["campaign_type"]}".replaceAll("_", " ").toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: _getCampaignTypeColor(campaign["campaign_type"] as String),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor(campaign["status"] as String).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${campaign["status"]}".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: _getStatusColor(campaign["status"] as String),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spSm),
                              Text(
                                "${campaign["campaign_name"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "ID: ${campaign["id"]}",
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
                              "${campaign["acquired_links"]}/${campaign["target_links"]}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Links",
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

                    // Progress Bar
                    Container(
                      width: double.infinity,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.grey.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: (campaign["acquired_links"] as int) / (campaign["target_links"] as int),
                        child: Container(
                          decoration: BoxDecoration(
                            color: _getStatusColor(campaign["status"] as String),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: spSm),

                    // Key Metrics
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
                                "${campaign["success_rate"]}%",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: (campaign["success_rate"] as double) > 50 ? successColor : warningColor,
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
                                "Avg DA",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${campaign["average_da"]}",
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
                                "Cost/Link",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "\$${campaign["cost_per_link"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
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
                                "Budget Used",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${((campaign["spent_budget"] as int) * 100 / (campaign["total_budget"] as int)).toStringAsFixed(0)}%",
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

                    // Target Keywords
                    Text(
                      "Target Keywords:",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: (campaign["target_keywords"] as List).map((keyword) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "$keyword",
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

                    // Performance Metrics
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
                            "Performance Impact:",
                            style: TextStyle(
                              fontSize: 12,
                              color: successColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Referral Traffic",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${((campaign["performance_metrics"]["referral_traffic"] as int) / 1000).toStringAsFixed(1)}K",
                                      style: TextStyle(
                                        fontSize: 13,
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
                                      "Ranking Improvement",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${campaign["performance_metrics"]["ranking_improvement"]}",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: successColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "DA Gain",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${campaign["performance_metrics"]["domain_authority_gain"]}",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: successColor,
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
                                      "Brand Mentions",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${campaign["performance_metrics"]["brand_mentions"]}",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: spSm),

                    // Top Target Domains
                    Text(
                      "Key Target Domains:",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spXs),

                    ...(campaign["target_domains"] as List).take(2).map((domain) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spXs),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: _getStatusColor(domain["status"] as String).withAlpha(30),
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
                                    "${domain["domain"]}",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "DA: ${domain["da"]} • Pitch: ${DateTime.parse(domain["pitch_sent"]).dMMMy}",
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
                                color: _getStatusColor(domain["status"] as String).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${domain["status"]}".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: _getStatusColor(domain["status"] as String),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),

                    // Next Actions
                    if ((campaign["next_actions"] as List).isNotEmpty) ...[
                      SizedBox(height: spSm),
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
                              "Next Actions:",
                              style: TextStyle(
                                fontSize: 12,
                                color: warningColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: spXs),
                            ...(campaign["next_actions"] as List).map((action) {
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
                                        "$action",
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
                    ],
                    SizedBox(height: spSm),

                    // Campaign Dates and Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${DateTime.parse(campaign["start_date"]).dMMMy} - ${DateTime.parse(campaign["end_date"]).dMMMy}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                        QButton(
                          label: "View Details",
                          size: bs.sm,
                          onPressed: () {
                            // View campaign details
                          },
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.analytics,
                          size: bs.sm,
                          onPressed: () {
                            // View analytics
                          },
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.edit,
                          size: bs.sm,
                          onPressed: () {
                            // Edit campaign
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
