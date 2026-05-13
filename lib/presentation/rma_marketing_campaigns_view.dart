import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaMarketingCampaignsView extends StatefulWidget {
  const RmaMarketingCampaignsView({super.key});

  @override
  State<RmaMarketingCampaignsView> createState() => _RmaMarketingCampaignsViewState();
}

class _RmaMarketingCampaignsViewState extends State<RmaMarketingCampaignsView> {
  int selectedTab = 0;
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedType = "All";

  List<Map<String, dynamic>> campaignsData = [
    {
      "id": "CAMP001",
      "name": "Summer Sale 2024",
      "type": "Email",
      "status": "Active",
      "start_date": "2024-06-01",
      "end_date": "2024-06-30",
      "target_audience": "All Customers",
      "budget": 5000.0,
      "spent": 3250.75,
      "impressions": 125000,
      "clicks": 8500,
      "conversions": 342,
      "revenue": 18650.50,
      "ctr": 6.8,
      "conversion_rate": 4.02,
      "roi": 274.0,
      "description": "Promote summer products with 25% discount for all categories",
      "image": "https://picsum.photos/300/200?random=1&keyword=summer",
      "channels": ["Email", "Social Media", "Display Ads"],
      "segments": ["Regular", "Premium", "VIP"],
      "products": ["Fashion", "Sports", "Outdoor"]
    },
    {
      "id": "CAMP002",
      "name": "New Customer Welcome",
      "type": "Automated",
      "status": "Active",
      "start_date": "2024-01-01",
      "end_date": "2024-12-31",
      "target_audience": "New Customers",
      "budget": 2000.0,
      "spent": 1456.20,
      "impressions": 45000,
      "clicks": 3200,
      "conversions": 185,
      "revenue": 6750.25,
      "ctr": 7.1,
      "conversion_rate": 5.78,
      "roi": 363.5,
      "description": "Automated welcome series for new customers with 15% first purchase discount",
      "image": "https://picsum.photos/300/200?random=2&keyword=welcome",
      "channels": ["Email", "Push Notification"],
      "segments": ["New"],
      "products": ["All Categories"]
    },
    {
      "id": "CAMP003",
      "name": "Flash Weekend Deal",
      "type": "Social Media",
      "status": "Completed",
      "start_date": "2024-05-25",
      "end_date": "2024-05-27",
      "target_audience": "VIP Customers",
      "budget": 1500.0,
      "spent": 1500.0,
      "impressions": 85000,
      "clicks": 6800,
      "conversions": 425,
      "revenue": 21250.00,
      "ctr": 8.0,
      "conversion_rate": 6.25,
      "roi": 1315.7,
      "description": "48-hour flash sale for electronics with up to 40% off",
      "image": "https://picsum.photos/300/200?random=3&keyword=flash",
      "channels": ["Instagram", "Facebook", "Twitter"],
      "segments": ["VIP", "Premium"],
      "products": ["Electronics", "Gadgets"]
    },
    {
      "id": "CAMP004",
      "name": "Back to School",
      "type": "Display",
      "status": "Scheduled",
      "start_date": "2024-08-01",
      "end_date": "2024-08-31",
      "target_audience": "Students & Parents",
      "budget": 8000.0,
      "spent": 0.0,
      "impressions": 0,
      "clicks": 0,
      "conversions": 0,
      "revenue": 0.0,
      "ctr": 0.0,
      "conversion_rate": 0.0,
      "roi": 0.0,
      "description": "Target students and parents with school supplies and electronics",
      "image": "https://picsum.photos/300/200?random=4&keyword=school",
      "channels": ["Google Ads", "Display Network", "YouTube"],
      "segments": ["Students", "Parents"],
      "products": ["Books", "Electronics", "Fashion"]
    },
    {
      "id": "CAMP005",
      "name": "Loyalty Rewards Program",
      "type": "Email",
      "status": "Paused",
      "start_date": "2024-03-01",
      "end_date": "2024-12-31",
      "target_audience": "Loyal Customers",
      "budget": 3000.0,
      "spent": 1875.45,
      "impressions": 65000,
      "clicks": 4550,
      "conversions": 228,
      "revenue": 12450.75,
      "ctr": 7.0,
      "conversion_rate": 5.01,
      "roi": 563.9,
      "description": "Reward loyal customers with exclusive offers and early access",
      "image": "https://picsum.photos/300/200?random=5&keyword=loyalty",
      "channels": ["Email", "In-App", "SMS"],
      "segments": ["VIP", "Premium"],
      "products": ["All Categories"]
    }
  ];

  List<Map<String, dynamic>> get filteredCampaigns {
    return campaignsData.where((campaign) {
      bool matchesSearch = "${campaign["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${campaign["description"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesStatus = selectedStatus == "All" || campaign["status"] == selectedStatus;
      bool matchesType = selectedType == "All" || campaign["type"] == selectedType;
      
      return matchesSearch && matchesStatus && matchesType;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Marketing Campaigns",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Campaigns", icon: Icon(Icons.campaign)),
        Tab(text: "Performance", icon: Icon(Icons.analytics)),
        Tab(text: "Create", icon: Icon(Icons.add_circle)),
      ],
      tabChildren: [
        _buildCampaignsTab(),
        _buildPerformanceTab(),
        _buildCreateTab(),
      ],
    );
  }

  Widget _buildCampaignsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildSearchAndFilters(),
          _buildCampaignStats(),
          _buildCampaignsList(),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Column(
      spacing: spSm,
      children: [
        QTextField(
          label: "Search campaigns",
          value: searchQuery,
          hint: "Search by name or description",
          onChanged: (value) {
            searchQuery = value;
            setState(() {});
          },
        ),
        Row(
          children: [
            Expanded(
              child: QDropdownField(
                label: "Status",
                items: [
                  {"label": "All", "value": "All"},
                  {"label": "Active", "value": "Active"},
                  {"label": "Completed", "value": "Completed"},
                  {"label": "Scheduled", "value": "Scheduled"},
                  {"label": "Paused", "value": "Paused"},
                ],
                value: selectedStatus,
                onChanged: (value, label) {
                  selectedStatus = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QDropdownField(
                label: "Type",
                items: [
                  {"label": "All", "value": "All"},
                  {"label": "Email", "value": "Email"},
                  {"label": "Social Media", "value": "Social Media"},
                  {"label": "Display", "value": "Display"},
                  {"label": "Automated", "value": "Automated"},
                ],
                value: selectedType,
                onChanged: (value, label) {
                  selectedType = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCampaignStats() {
    double totalBudget = campaignsData.fold(0.0, (sum, c) => sum + (c["budget"] as double));
    double totalSpent = campaignsData.fold(0.0, (sum, c) => sum + (c["spent"] as double));
    double totalRevenue = campaignsData.fold(0.0, (sum, c) => sum + (c["revenue"] as double));
    double avgROI = campaignsData.where((c) => (c["roi"] as double) > 0).fold(0.0, (sum, c) => sum + (c["roi"] as double)) / 
                   campaignsData.where((c) => (c["roi"] as double) > 0).length;

    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Text(
                  "\$${totalBudget.toStringAsFixed(0)}",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Total Budget",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Text(
                  "\$${totalRevenue.toStringAsFixed(0)}",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Total Revenue",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Text(
                  "${avgROI.toStringAsFixed(0)}%",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: warningColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Avg ROI",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCampaignsList() {
    return Column(
      spacing: spSm,
      children: filteredCampaigns.map((campaign) {
        return Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Row(
                children: [
                  Container(
                    width: 80,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusSm),
                      image: DecorationImage(
                        image: NetworkImage("${campaign["image"]}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${campaign["name"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: fsH6,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: _getStatusColor(campaign["status"]).withAlpha(50),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${campaign["status"]}",
                                style: TextStyle(
                                  color: _getStatusColor(campaign["status"]),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${campaign["type"]} • ${campaign["target_audience"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "${campaign["start_date"]} - ${campaign["end_date"]}",
                          style: TextStyle(
                            color: disabledColor,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Text(
                "${campaign["description"]}",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "\$${((campaign["budget"] as double).toDouble()).currency}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Budget",
                                style: TextStyle(fontSize: 10, color: disabledBoldColor),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "\$${((campaign["spent"] as double).toDouble()).currency}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: warningColor,
                                ),
                              ),
                              Text(
                                "Spent",
                                style: TextStyle(fontSize: 10, color: disabledBoldColor),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "\$${((campaign["revenue"] as double).toDouble()).currency}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "Revenue",
                                style: TextStyle(fontSize: 10, color: disabledBoldColor),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "${(campaign["roi"] as double).toStringAsFixed(0)}%",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: infoColor,
                                ),
                              ),
                              Text(
                                "ROI",
                                style: TextStyle(fontSize: 10, color: disabledBoldColor),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if ((campaign["impressions"] as int) > 0) ...[
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "${((campaign["impressions"] as int) / 1000).toStringAsFixed(0)}K",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "Impressions",
                                  style: TextStyle(fontSize: 9, color: disabledBoldColor),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "${campaign["clicks"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "Clicks",
                                  style: TextStyle(fontSize: 9, color: disabledBoldColor),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "${(campaign["ctr"] as double).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "CTR",
                                  style: TextStyle(fontSize: 9, color: disabledBoldColor),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "${campaign["conversions"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "Conversions",
                                  style: TextStyle(fontSize: 9, color: disabledBoldColor),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Row(
                    children: [
                      Text(
                        "Channels: ",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 11,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          (campaign["channels"] as List).join(", "),
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Segments: ",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 11,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          (campaign["segments"] as List).join(", "),
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "View Details",
                      size: bs.sm,
                      onPressed: () {
                        // View campaign details
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    icon: campaign["status"] == "Active" ? Icons.pause : Icons.play_arrow,
                    size: bs.sm,
                    onPressed: () {
                      // Toggle campaign status
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
    );
  }

  Widget _buildPerformanceTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildPerformanceOverview(),
          _buildChannelPerformance(),
          _buildTopCampaigns(),
        ],
      ),
    );
  }

  Widget _buildPerformanceOverview() {
    int totalImpressions = campaignsData.fold(0, (sum, c) => sum + (c["impressions"] as int));
    int totalClicks = campaignsData.fold(0, (sum, c) => sum + (c["clicks"] as int));
    int totalConversions = campaignsData.fold(0, (sum, c) => sum + (c["conversions"] as int));
    double avgCTR = totalImpressions > 0 ? (totalClicks / totalImpressions) * 100 : 0;
    double avgConversionRate = totalClicks > 0 ? (totalConversions / totalClicks) * 100 : 0;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Performance Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  children: [
                    Text(
                      "${(totalImpressions / 1000).toStringAsFixed(0)}K",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Total Impressions",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  children: [
                    Text(
                      "$totalClicks",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                    Text(
                      "Total Clicks",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  children: [
                    Text(
                      "${avgCTR.toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Average CTR",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  children: [
                    Text(
                      "${avgConversionRate.toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                    Text(
                      "Conversion Rate",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
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
  }

  Widget _buildChannelPerformance() {
    Map<String, Map<String, dynamic>> channelStats = {};
    
    for (var campaign in campaignsData) {
      for (var channel in (campaign["channels"] as List)) {
        if (!channelStats.containsKey(channel)) {
          channelStats[channel] = {
            "impressions": 0,
            "clicks": 0,
            "conversions": 0,
            "revenue": 0.0,
          };
        }
        channelStats[channel]!["impressions"] += (campaign["impressions"] as int);
        channelStats[channel]!["clicks"] += (campaign["clicks"] as int);
        channelStats[channel]!["conversions"] += (campaign["conversions"] as int);
        channelStats[channel]!["revenue"] += (campaign["revenue"] as double);
      }
    }

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Channel Performance",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          ...channelStats.entries.map((entry) {
            double ctr = (entry.value["impressions"] as int) > 0 
                ? ((entry.value["clicks"] as int) / (entry.value["impressions"] as int)) * 100 
                : 0;
            
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                border: Border.all(color: disabledOutlineBorderColor),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Text(
                    entry.key,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Impressions: ${((entry.value["impressions"] as int) / 1000).toStringAsFixed(0)}K",
                          style: TextStyle(fontSize: 11, color: disabledBoldColor),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Clicks: ${entry.value["clicks"]}",
                          style: TextStyle(fontSize: 11, color: disabledBoldColor),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "CTR: ${ctr.toStringAsFixed(1)}%",
                          style: TextStyle(fontSize: 11, color: disabledBoldColor),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Revenue: \$${((entry.value["revenue"] as double).toDouble()).currency}",
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: successColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildTopCampaigns() {
    var sortedCampaigns = List<Map<String, dynamic>>.from(campaignsData);
    sortedCampaigns.sort((a, b) => (b["roi"] as double).compareTo(a["roi"] as double));

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Top Performing Campaigns",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          ...sortedCampaigns.take(3).map((campaign) {
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${campaign["name"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          "Revenue: \$${((campaign["revenue"] as double).toDouble()).currency}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "${(campaign["roi"] as double).toStringAsFixed(0)}% ROI",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: successColor,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildCreateTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Create New Campaign",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                QButton(
                  label: "Email Campaign",
                  size: bs.md,
                  onPressed: () {
                    // Create email campaign
                  },
                ),
                QButton(
                  label: "Social Media Campaign",
                  size: bs.md,
                  onPressed: () {
                    // Create social media campaign
                  },
                ),
                QButton(
                  label: "Display Ad Campaign",
                  size: bs.md,
                  onPressed: () {
                    // Create display campaign
                  },
                ),
                QButton(
                  label: "Automated Campaign",
                  size: bs.md,
                  onPressed: () {
                    // Create automated campaign
                  },
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Campaign Templates",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                QButton(
                  label: "Welcome Series Template",
                  size: bs.md,
                  onPressed: () {
                    // Use welcome template
                  },
                ),
                QButton(
                  label: "Product Launch Template",
                  size: bs.md,
                  onPressed: () {
                    // Use launch template
                  },
                ),
                QButton(
                  label: "Seasonal Sale Template",
                  size: bs.md,
                  onPressed: () {
                    // Use seasonal template
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Completed":
        return infoColor;
      case "Scheduled":
        return warningColor;
      case "Paused":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }
}
