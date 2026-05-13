import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsCampaignOverviewView extends StatefulWidget {
  const DmsCampaignOverviewView({super.key});

  @override
  State<DmsCampaignOverviewView> createState() => _DmsCampaignOverviewViewState();
}

class _DmsCampaignOverviewViewState extends State<DmsCampaignOverviewView> {
  int selectedPeriod = 0;
  String searchQuery = "";
  String selectedCampaignType = "";
  
  final List<Map<String, dynamic>> periods = [
    {"label": "Last 7 Days", "value": "7d"},
    {"label": "Last 30 Days", "value": "30d"},
    {"label": "Last 3 Months", "value": "3m"},
    {"label": "Last Year", "value": "1y"},
  ];

  final List<Map<String, dynamic>> campaignTypes = [
    {"label": "All Campaigns", "value": ""},
    {"label": "Social Media", "value": "social"},
    {"label": "Email Marketing", "value": "email"},
    {"label": "PPC", "value": "ppc"},
    {"label": "Content Marketing", "value": "content"},
  ];

  final List<Map<String, dynamic>> campaigns = [
    {
      "id": 1,
      "name": "Summer Sale 2024",
      "type": "social",
      "status": "active",
      "budget": 5000.0,
      "spent": 3750.0,
      "impressions": 125000,
      "clicks": 2800,
      "conversions": 180,
      "roas": 4.2,
      "startDate": "2024-06-01",
      "endDate": "2024-07-31",
      "progress": 0.75,
    },
    {
      "id": 2,
      "name": "Product Launch Email",
      "type": "email",
      "status": "active",
      "budget": 2000.0,
      "spent": 1200.0,
      "impressions": 50000,
      "clicks": 1500,
      "conversions": 95,
      "roas": 3.8,
      "startDate": "2024-06-15",
      "endDate": "2024-08-15",
      "progress": 0.6,
    },
    {
      "id": 3,
      "name": "Google Ads Campaign",
      "type": "ppc",
      "status": "paused",
      "budget": 8000.0,
      "spent": 4800.0,
      "impressions": 200000,
      "clicks": 4200,
      "conversions": 320,
      "roas": 5.1,
      "startDate": "2024-05-01",
      "endDate": "2024-07-01",
      "progress": 0.6,
    },
    {
      "id": 4,
      "name": "Blog Content Series",
      "type": "content",
      "status": "completed",
      "budget": 3000.0,
      "spent": 3000.0,
      "impressions": 75000,
      "clicks": 1800,
      "conversions": 110,
      "roas": 3.2,
      "startDate": "2024-04-01",
      "endDate": "2024-06-01",
      "progress": 1.0,
    },
    {
      "id": 5,
      "name": "Holiday Campaign",
      "type": "social",
      "status": "scheduled",
      "budget": 6000.0,
      "spent": 0.0,
      "impressions": 0,
      "clicks": 0,
      "conversions": 0,
      "roas": 0.0,
      "startDate": "2024-12-01",
      "endDate": "2024-12-31",
      "progress": 0.0,
    },
  ];

  List<Map<String, dynamic>> get filteredCampaigns {
    return campaigns.where((campaign) {
      final matchesSearch = "${campaign["name"]}".toLowerCase().contains(searchQuery.toLowerCase());
      final matchesType = selectedCampaignType.isEmpty || campaign["type"] == selectedCampaignType;
      return matchesSearch && matchesType;
    }).toList();
  }

  Widget _buildOverviewCards() {
    final totalBudget = campaigns.fold(0.0, (sum, campaign) => sum + (campaign["budget"] as double));
    final totalSpent = campaigns.fold(0.0, (sum, campaign) => sum + (campaign["spent"] as double));
    final totalImpressions = campaigns.fold(0, (sum, campaign) => sum + (campaign["impressions"] as int));
    final totalClicks = campaigns.fold(0, (sum, campaign) => sum + (campaign["clicks"] as int));
    final totalConversions = campaigns.fold(0, (sum, campaign) => sum + (campaign["conversions"] as int));
    final avgRoas = campaigns.where((c) => (c["roas"] as double) > 0).isEmpty
        ? 0.0
        : campaigns.where((c) => (c["roas"] as double) > 0).map((c) => c["roas"] as double).reduce((a, b) => a + b) / campaigns.where((c) => (c["roas"] as double) > 0).length;

    return Column(
      spacing: spSm,
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.account_balance_wallet, color: primaryColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Total Budget",
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
                      "\$${totalBudget.currency}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Spent: \$${totalSpent.currency}",
                      style: TextStyle(
                        fontSize: 10,
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
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.visibility, color: successColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Impressions",
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
                      "${(totalImpressions / 1000).toStringAsFixed(1)}K",
                      style: TextStyle(
                        fontSize: 18,
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
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.mouse, color: infoColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Clicks",
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
                      "${(totalClicks / 1000).toStringAsFixed(1)}K",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
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
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.trending_up, color: warningColor, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "Conversions",
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
                      "$totalConversions",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "ROAS: ${avgRoas.toStringAsFixed(1)}x",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCampaignCard(Map<String, dynamic> campaign) {
    Color statusColor;
    String statusText;
    
    switch (campaign["status"]) {
      case "active":
        statusColor = successColor;
        statusText = "Active";
        break;
      case "paused":
        statusColor = warningColor;
        statusText = "Paused";
        break;
      case "completed":
        statusColor = infoColor;
        statusText = "Completed";
        break;
      case "scheduled":
        statusColor = primaryColor;
        statusText = "Scheduled";
        break;
      default:
        statusColor = disabledBoldColor;
        statusText = "Unknown";
    }

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
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
                      "${campaign["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            statusText,
                            style: TextStyle(
                              fontSize: 10,
                              color: statusColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: disabledColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${campaign["type"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Budget",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${(campaign["budget"] as double).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
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
                      "Spent",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${(campaign["spent"] as double).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: warningColor,
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
                      "ROAS",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${(campaign["roas"] as double).toStringAsFixed(1)}x",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if ((campaign["progress"] as double) > 0) ...[
            SizedBox(height: spSm),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Progress",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${((campaign["progress"] as double) * 100).toInt()}%",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: disabledColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: campaign["progress"] as double,
                    child: Container(
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
          SizedBox(height: spSm),
          Row(
            children: [
              Text(
                "${campaign["startDate"]} - ${campaign["endDate"]}",
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    "${campaign["conversions"]} conversions",
                    style: TextStyle(
                      fontSize: 10,
                      color: successColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Campaign Overview"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {},
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Period Selection
            QCategoryPicker(
              label: "Time Period",
              items: periods,
              value: periods[selectedPeriod]["value"],
              onChanged: (index, label, value, item) {
                selectedPeriod = index;
                setState(() {});
              },
            ),

            // Overview Cards
            _buildOverviewCards(),

            // Search and Filters
            Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search campaigns...",
                        value: searchQuery,
                        onChanged: (value) {
                          searchQuery = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.search,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
                QDropdownField(
                  label: "Campaign Type",
                  items: campaignTypes,
                  value: selectedCampaignType,
                  onChanged: (value, label) {
                    selectedCampaignType = value;
                    setState(() {});
                  },
                ),
              ],
            ),

            // Campaign List Header
            Row(
              children: [
                Text(
                  "Campaigns (${filteredCampaigns.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                QButton(
                  icon: Icons.tune,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),

            // Campaign List
            if (filteredCampaigns.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.campaign,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No campaigns found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your search or filters",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              Column(
                children: filteredCampaigns.map((campaign) => _buildCampaignCard(campaign)).toList(),
              ),
          ],
        ),
      ),
    );
  }
}
