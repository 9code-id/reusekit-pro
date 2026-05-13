import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaAdvertisingView extends StatefulWidget {
  const SmaAdvertisingView({super.key});

  @override
  State<SmaAdvertisingView> createState() => _SmaAdvertisingViewState();
}

class _SmaAdvertisingViewState extends State<SmaAdvertisingView> {
  int selectedTab = 0;

  List<Map<String, dynamic>> activeCampaigns = [
    {
      "id": "1",
      "title": "Summer Hits Promotion",
      "type": "Music Promotion",
      "budget": 2500.0,
      "spent": 1840.0,
      "reach": 125000,
      "engagement": 8.5,
      "status": "Active",
      "startDate": "2024-06-01",
      "endDate": "2024-06-30",
      "targetAudience": "18-35, Pop Music Lovers",
      "image": "https://picsum.photos/300/200?random=1&keyword=music",
    },
    {
      "id": "2",
      "title": "New Album Launch",
      "type": "Album Promotion",
      "budget": 5000.0,
      "spent": 3200.0,
      "reach": 285000,
      "engagement": 12.3,
      "status": "Active",
      "startDate": "2024-05-15",
      "endDate": "2024-07-15",
      "targetAudience": "25-45, All Music Genres",
      "image": "https://picsum.photos/300/200?random=2&keyword=album",
    },
  ];

  List<Map<String, dynamic>> campaignHistory = [
    {
      "id": "3",
      "title": "Spring Concert Series",
      "type": "Event Promotion",
      "budget": 1800.0,
      "spent": 1800.0,
      "reach": 95000,
      "engagement": 6.8,
      "status": "Completed",
      "startDate": "2024-03-01",
      "endDate": "2024-04-30",
      "targetAudience": "20-40, Live Music Fans",
      "image": "https://picsum.photos/300/200?random=3&keyword=concert",
    },
    {
      "id": "4",
      "title": "Acoustic Sessions",
      "type": "Content Promotion",
      "budget": 800.0,
      "spent": 650.0,
      "status": "Paused",
      "reach": 42000,
      "engagement": 4.2,
      "startDate": "2024-04-10",
      "endDate": "2024-05-10",
      "targetAudience": "25-50, Acoustic Music",
      "image": "https://picsum.photos/300/200?random=4&keyword=acoustic",
    },
  ];

  List<Map<String, dynamic>> adFormats = [
    {
      "title": "Audio Ad",
      "description": "15-30 second audio advertisement",
      "price": 0.12,
      "unit": "per play",
      "icon": Icons.volume_up,
    },
    {
      "title": "Banner Ad",
      "description": "Visual banner displayed in app",
      "price": 2.50,
      "unit": "per 1000 views",
      "icon": Icons.crop_landscape,
    },
    {
      "title": "Sponsored Content",
      "description": "Promoted posts in user feeds",
      "price": 5.00,
      "unit": "per 1000 views",
      "icon": Icons.featured_play_list,
    },
    {
      "title": "Video Ad",
      "description": "Short video advertisement",
      "price": 8.00,
      "unit": "per 1000 views",
      "icon": Icons.play_circle,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Advertising"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {
              si("Create new campaign");
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Overview Stats
            Container(
              width: double.infinity,
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
                  Text(
                    "Campaign Overview",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.trending_up,
                                color: primaryColor,
                                size: 24,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "410K",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Total Reach",
                                style: TextStyle(
                                  fontSize: 12,
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
                            color: successColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.attach_money,
                                color: successColor,
                                size: 24,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "\$5,040",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "Total Spent",
                                style: TextStyle(
                                  fontSize: 12,
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
                            color: warningColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.mouse,
                                color: warningColor,
                                size: 24,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "10.4%",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                              Text(
                                "Avg. Engagement",
                                style: TextStyle(
                                  fontSize: 12,
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
              ),
            ),

            // Ad Formats
            Container(
              width: double.infinity,
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
                  Text(
                    "Advertisement Formats",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...List.generate(adFormats.length, (index) {
                    final format = adFormats[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: spXs),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: disabledOutlineBorderColor,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Icon(
                              format["icon"] as IconData,
                              color: primaryColor,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${format["title"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${format["description"]}",
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
                                "\$${(format["price"] as double).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${format["unit"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),

            // Campaign Tabs
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            selectedTab = 0;
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: spSm),
                            decoration: BoxDecoration(
                              color: selectedTab == 0 ? primaryColor : Colors.transparent,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(radiusMd),
                                bottomLeft: selectedTab == 0 ? Radius.circular(radiusSm) : Radius.zero,
                              ),
                            ),
                            child: Text(
                              "Active Campaigns (${activeCampaigns.length})",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: selectedTab == 0 ? Colors.white : disabledBoldColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            selectedTab = 1;
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: spSm),
                            decoration: BoxDecoration(
                              color: selectedTab == 1 ? primaryColor : Colors.transparent,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(radiusMd),
                                bottomRight: selectedTab == 1 ? Radius.circular(radiusSm) : Radius.zero,
                              ),
                            ),
                            child: Text(
                              "History (${campaignHistory.length})",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: selectedTab == 1 ? Colors.white : disabledBoldColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(spMd),
                    child: selectedTab == 0 ? _buildActiveCampaigns() : _buildCampaignHistory(),
                  ),
                ],
              ),
            ),

            // Create Campaign Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Create New Campaign",
                size: bs.md,
                onPressed: () {
                  si("Create new advertising campaign");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveCampaigns() {
    return Column(
      spacing: spSm,
      children: List.generate(activeCampaigns.length, (index) {
        final campaign = activeCampaigns[index];
        final budgetUsed = ((campaign["spent"] as double) / (campaign["budget"] as double)) * 100;
        
        return Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(
              color: disabledOutlineBorderColor,
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusXs),
                    child: Image.network(
                      "${campaign["image"]}",
                      width: 60,
                      height: 40,
                      fit: BoxFit.cover,
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
                                "${campaign["title"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: successColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${campaign["status"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${campaign["type"]}",
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
              
              // Budget Progress
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Budget: \$${((campaign["spent"] as double)).toStringAsFixed(0)} / \$${((campaign["budget"] as double)).toStringAsFixed(0)}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${budgetUsed.toInt()}%",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Container(
                    height: 4,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: budgetUsed / 100,
                      child: Container(
                        decoration: BoxDecoration(
                          color: budgetUsed > 80 ? warningColor : primaryColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              
              // Performance Metrics
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Reach",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${((campaign["reach"] as int) / 1000).toInt()}K",
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
                          "Engagement",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${(campaign["engagement"] as double).toStringAsFixed(1)}%",
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
                          "Duration",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${DateTime.parse(campaign["startDate"]).dMMMy} - ${DateTime.parse(campaign["endDate"]).dMMMy}",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  QButton(
                    icon: Icons.more_vert,
                    size: bs.sm,
                    onPressed: () {
                      si("Campaign options for ${campaign["title"]}");
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildCampaignHistory() {
    return Column(
      spacing: spSm,
      children: List.generate(campaignHistory.length, (index) {
        final campaign = campaignHistory[index];
        final statusColor = campaign["status"] == "Completed" ? successColor : warningColor;
        
        return Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(
              color: disabledOutlineBorderColor,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusXs),
                child: Image.network(
                  "${campaign["image"]}",
                  width: 60,
                  height: 40,
                  fit: BoxFit.cover,
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
                            "${campaign["title"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${campaign["status"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2),
                    Text(
                      "${campaign["type"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          "Spent: \$${((campaign["spent"] as double)).toStringAsFixed(0)}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Reach: ${((campaign["reach"] as int) / 1000).toInt()}K",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${(campaign["engagement"] as double).toStringAsFixed(1)}%",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "engagement",
                    style: TextStyle(
                      fontSize: 10,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
