import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaEmailMarketingView extends StatefulWidget {
  const RmaEmailMarketingView({super.key});

  @override
  State<RmaEmailMarketingView> createState() => _RmaEmailMarketingViewState();
}

class _RmaEmailMarketingViewState extends State<RmaEmailMarketingView> {
  int selectedTab = 0;
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedTemplate = "All";

  List<Map<String, dynamic>> emailCampaignsData = [
    {
      "id": "EMAIL001",
      "name": "Summer Newsletter 2024",
      "subject": "☀️ Beat the Heat with Our Summer Collection!",
      "template": "Newsletter",
      "status": "Sent",
      "sent_date": "2024-06-15",
      "sent_count": 15420,
      "delivered_count": 14985,
      "opened_count": 7492,
      "clicked_count": 1874,
      "unsubscribed_count": 23,
      "bounced_count": 435,
      "open_rate": 50.0,
      "click_rate": 25.0,
      "unsubscribe_rate": 0.15,
      "bounce_rate": 2.8,
      "revenue_generated": 8450.75,
      "conversions": 156,
      "content_preview": "Discover our amazing summer collection with exclusive deals just for you! From beachwear to outdoor essentials, we have everything you need to make this summer unforgettable.",
      "segments": ["All Subscribers", "Active Customers"],
      "tags": ["Summer", "Newsletter", "Seasonal"],
      "image": "https://picsum.photos/300/200?random=1&keyword=summer"
    },
    {
      "id": "EMAIL002",
      "name": "Welcome Series - Email 1",
      "subject": "Welcome to our community! Here's your 15% off",
      "template": "Welcome",
      "status": "Active",
      "sent_date": "2024-06-01",
      "sent_count": 2840,
      "delivered_count": 2789,
      "opened_count": 1950,
      "clicked_count": 975,
      "unsubscribed_count": 8,
      "bounced_count": 51,
      "open_rate": 69.9,
      "click_rate": 50.0,
      "unsubscribe_rate": 0.29,
      "bounce_rate": 1.8,
      "revenue_generated": 4275.50,
      "conversions": 195,
      "content_preview": "Thank you for joining us! We're excited to have you as part of our community. As a welcome gift, enjoy 15% off your first purchase with code WELCOME15.",
      "segments": ["New Subscribers"],
      "tags": ["Welcome", "Automated", "Discount"],
      "image": "https://picsum.photos/300/200?random=2&keyword=welcome"
    },
    {
      "id": "EMAIL003",
      "name": "Flash Sale Alert",
      "subject": "⚡ 48 Hours Only: Up to 40% OFF Everything!",
      "template": "Promotional",
      "status": "Sent",
      "sent_date": "2024-05-25",
      "sent_count": 22750,
      "delivered_count": 22180,
      "opened_count": 13308,
      "clicked_count": 3327,
      "unsubscribed_count": 45,
      "bounced_count": 570,
      "open_rate": 60.0,
      "click_rate": 25.0,
      "unsubscribe_rate": 0.20,
      "bounce_rate": 2.5,
      "revenue_generated": 21850.25,
      "conversions": 425,
      "content_preview": "Don't miss out! Our biggest flash sale of the year is here. Shop now and save up to 40% on everything in store. Limited time only - sale ends Sunday midnight!",
      "segments": ["VIP Customers", "Active Customers"],
      "tags": ["Flash Sale", "Urgent", "Discount"],
      "image": "https://picsum.photos/300/200?random=3&keyword=sale"
    },
    {
      "id": "EMAIL004",
      "name": "Cart Abandonment Reminder",
      "subject": "You left something behind... Complete your order?",
      "template": "Automation",
      "status": "Active",
      "sent_date": "2024-06-10",
      "sent_count": 8950,
      "delivered_count": 8680,
      "opened_count": 3472,
      "clicked_count": 1041,
      "unsubscribed_count": 12,
      "bounced_count": 270,
      "open_rate": 40.0,
      "click_rate": 30.0,
      "unsubscribe_rate": 0.14,
      "bounce_rate": 3.0,
      "revenue_generated": 5620.80,
      "conversions": 89,
      "content_preview": "We noticed you were interested in some amazing items in your cart. Complete your purchase now and enjoy free shipping on orders over \$50!",
      "segments": ["Cart Abandoners"],
      "tags": ["Automation", "Cart Recovery", "Reminder"],
      "image": "https://picsum.photos/300/200?random=4&keyword=cart"
    },
    {
      "id": "EMAIL005",
      "name": "Monthly Product Updates",
      "subject": "New Arrivals & Updates You'll Love",
      "template": "Newsletter",
      "status": "Draft",
      "sent_date": "",
      "sent_count": 0,
      "delivered_count": 0,
      "opened_count": 0,
      "clicked_count": 0,
      "unsubscribed_count": 0,
      "bounced_count": 0,
      "open_rate": 0.0,
      "click_rate": 0.0,
      "unsubscribe_rate": 0.0,
      "bounce_rate": 0.0,
      "revenue_generated": 0.0,
      "conversions": 0,
      "content_preview": "Check out our latest product arrivals and updates. From innovative gadgets to fashion trends, discover what's new this month.",
      "segments": ["All Subscribers"],
      "tags": ["Newsletter", "Products", "Updates"],
      "image": "https://picsum.photos/300/200?random=5&keyword=products"
    },
    {
      "id": "EMAIL006",
      "name": "Re-engagement Campaign",
      "subject": "We miss you! Here's 20% off to come back",
      "template": "Re-engagement",
      "status": "Scheduled",
      "sent_date": "2024-06-25",
      "sent_count": 0,
      "delivered_count": 0,
      "opened_count": 0,
      "clicked_count": 0,
      "unsubscribed_count": 0,
      "bounced_count": 0,
      "open_rate": 0.0,
      "click_rate": 0.0,
      "unsubscribe_rate": 0.0,
      "bounce_rate": 0.0,
      "revenue_generated": 0.0,
      "conversions": 0,
      "content_preview": "It's been a while since your last visit. We have some exciting new products and a special 20% discount just for you. Come back and see what's new!",
      "segments": ["Inactive Customers"],
      "tags": ["Re-engagement", "Discount", "Win-back"],
      "image": "https://picsum.photos/300/200?random=6&keyword=comeback"
    }
  ];

  List<Map<String, dynamic>> get filteredCampaigns {
    return emailCampaignsData.where((campaign) {
      bool matchesSearch = "${campaign["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${campaign["subject"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesStatus = selectedStatus == "All" || campaign["status"] == selectedStatus;
      bool matchesTemplate = selectedTemplate == "All" || campaign["template"] == selectedTemplate;
      
      return matchesSearch && matchesStatus && matchesTemplate;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Email Marketing",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Campaigns", icon: Icon(Icons.email)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "Templates", icon: Icon(Icons.dashboard_customize)),
        Tab(text: "Lists", icon: Icon(Icons.group)),
      ],
      tabChildren: [
        _buildCampaignsTab(),
        _buildAnalyticsTab(),
        _buildTemplatesTab(),
        _buildListsTab(),
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
          hint: "Search by campaign name or subject",
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
                  {"label": "Sent", "value": "Sent"},
                  {"label": "Draft", "value": "Draft"},
                  {"label": "Scheduled", "value": "Scheduled"},
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
                label: "Template",
                items: [
                  {"label": "All", "value": "All"},
                  {"label": "Newsletter", "value": "Newsletter"},
                  {"label": "Promotional", "value": "Promotional"},
                  {"label": "Welcome", "value": "Welcome"},
                  {"label": "Automation", "value": "Automation"},
                  {"label": "Re-engagement", "value": "Re-engagement"},
                ],
                value: selectedTemplate,
                onChanged: (value, label) {
                  selectedTemplate = value;
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
    int totalSent = emailCampaignsData.fold(0, (sum, c) => sum + (c["sent_count"] as int));
    int totalOpened = emailCampaignsData.fold(0, (sum, c) => sum + (c["opened_count"] as int));
    int totalClicked = emailCampaignsData.fold(0, (sum, c) => sum + (c["clicked_count"] as int));
    double avgOpenRate = emailCampaignsData.where((c) => (c["sent_count"] as int) > 0)
        .fold(0.0, (sum, c) => sum + (c["open_rate"] as double)) / 
        emailCampaignsData.where((c) => (c["sent_count"] as int) > 0).length;

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
                  "${(totalSent / 1000).toStringAsFixed(0)}K",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Total Sent",
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
                  "${avgOpenRate.toStringAsFixed(1)}%",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Avg Open Rate",
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
                  "${(totalClicked / 1000).toStringAsFixed(1)}K",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: warningColor,
                  ),
                ),
                SizedBox(height: spXs),
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
                          "${campaign["template"]}",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if ("${campaign["sent_date"]}".isNotEmpty)
                          Text(
                            "Sent: ${campaign["sent_date"]}",
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
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "Subject: ${campaign["subject"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: infoColor,
                      ),
                    ),
                    Text(
                      "${campaign["content_preview"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if ((campaign["sent_count"] as int) > 0) ...[
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
                                  "${(campaign["sent_count"] as int)}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "Sent",
                                  style: TextStyle(fontSize: 10, color: disabledBoldColor),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "${(campaign["delivered_count"] as int)}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: successColor,
                                  ),
                                ),
                                Text(
                                  "Delivered",
                                  style: TextStyle(fontSize: 10, color: disabledBoldColor),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "${(campaign["opened_count"] as int)}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: infoColor,
                                  ),
                                ),
                                Text(
                                  "Opened",
                                  style: TextStyle(fontSize: 10, color: disabledBoldColor),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "${(campaign["clicked_count"] as int)}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: warningColor,
                                  ),
                                ),
                                Text(
                                  "Clicked",
                                  style: TextStyle(fontSize: 10, color: disabledBoldColor),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Open Rate: ${(campaign["open_rate"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(fontSize: 11, color: disabledBoldColor),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "Click Rate: ${(campaign["click_rate"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(fontSize: 11, color: disabledBoldColor),
                            ),
                          ),
                        ],
                      ),
                      if ((campaign["revenue_generated"] as double) > 0)
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Revenue: \$${((campaign["revenue_generated"] as double).toDouble()).currency}",
                                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: successColor),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "Conversions: ${campaign["conversions"]}",
                                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: warningColor),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Segments: ${(campaign["segments"] as List).join(", ")}",
                      style: TextStyle(fontSize: 11, color: disabledBoldColor),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  QHorizontalScroll(
                    children: (campaign["tags"] as List).map((tag) {
                      return Container(
                        margin: EdgeInsets.only(right: spXs),
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: secondaryColor.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "$tag",
                          style: TextStyle(
                            fontSize: 10,
                            color: secondaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList(),
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
                  if (campaign["status"] == "Draft") ...[
                    QButton(
                      label: "Send",
                      size: bs.sm,
                      onPressed: () {
                        // Send campaign
                      },
                    ),
                    SizedBox(width: spXs),
                  ],
                  QButton(
                    icon: Icons.copy,
                    size: bs.sm,
                    onPressed: () {
                      // Duplicate campaign
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

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildPerformanceMetrics(),
          _buildEngagementTrends(),
          _buildTopPerformers(),
        ],
      ),
    );
  }

  Widget _buildPerformanceMetrics() {
    int totalSent = emailCampaignsData.fold(0, (sum, c) => sum + (c["sent_count"] as int));
    int totalDelivered = emailCampaignsData.fold(0, (sum, c) => sum + (c["delivered_count"] as int));
    int totalOpened = emailCampaignsData.fold(0, (sum, c) => sum + (c["opened_count"] as int));
    int totalClicked = emailCampaignsData.fold(0, (sum, c) => sum + (c["clicked_count"] as int));
    int totalUnsubscribed = emailCampaignsData.fold(0, (sum, c) => sum + (c["unsubscribed_count"] as int));
    double totalRevenue = emailCampaignsData.fold(0.0, (sum, c) => sum + (c["revenue_generated"] as double));

    double deliveryRate = totalSent > 0 ? (totalDelivered / totalSent) * 100 : 0;
    double openRate = totalDelivered > 0 ? (totalOpened / totalDelivered) * 100 : 0;
    double clickRate = totalOpened > 0 ? (totalClicked / totalOpened) * 100 : 0;
    double unsubscribeRate = totalSent > 0 ? (totalUnsubscribed / totalSent) * 100 : 0;

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
            "Performance Metrics",
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
                      "${deliveryRate.toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Delivery Rate",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${(totalDelivered / 1000).toStringAsFixed(0)}K delivered",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledColor,
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
                      "${openRate.toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Open Rate",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${(totalOpened / 1000).toStringAsFixed(0)}K opened",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledColor,
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
                      "${clickRate.toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                    Text(
                      "Click Rate",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${(totalClicked / 1000).toStringAsFixed(1)}K clicked",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledColor,
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
                      "\$${(totalRevenue.toDouble()).currency}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                    Text(
                      "Total Revenue",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "From email campaigns",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
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
  }

  Widget _buildEngagementTrends() {
    Map<String, Map<String, dynamic>> templateStats = {};
    
    for (var campaign in emailCampaignsData) {
      String template = campaign["template"] as String;
      if (!templateStats.containsKey(template)) {
        templateStats[template] = {
          "count": 0,
          "sent": 0,
          "opened": 0,
          "clicked": 0,
          "revenue": 0.0,
        };
      }
      templateStats[template]!["count"] += 1;
      templateStats[template]!["sent"] += (campaign["sent_count"] as int);
      templateStats[template]!["opened"] += (campaign["opened_count"] as int);
      templateStats[template]!["clicked"] += (campaign["clicked_count"] as int);
      templateStats[template]!["revenue"] += (campaign["revenue_generated"] as double);
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
            "Performance by Template Type",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          ...templateStats.entries.map((entry) {
            double openRate = (entry.value["sent"] as int) > 0 
                ? ((entry.value["opened"] as int) / (entry.value["sent"] as int)) * 100 
                : 0;
            double clickRate = (entry.value["opened"] as int) > 0 
                ? ((entry.value["clicked"] as int) / (entry.value["opened"] as int)) * 100 
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
                  Row(
                    children: [
                      Text(
                        entry.key,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${entry.value["count"]} campaigns",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Open Rate: ${openRate.toStringAsFixed(1)}%",
                          style: TextStyle(fontSize: 11, color: disabledBoldColor),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Click Rate: ${clickRate.toStringAsFixed(1)}%",
                          style: TextStyle(fontSize: 11, color: disabledBoldColor),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Revenue: \$${((entry.value["revenue"] as double).toDouble()).currency}",
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: successColor),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildTopPerformers() {
    var sortedCampaigns = List<Map<String, dynamic>>.from(emailCampaignsData.where((c) => (c["sent_count"] as int) > 0));
    sortedCampaigns.sort((a, b) => (b["open_rate"] as double).compareTo(a["open_rate"] as double));

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
                          "${campaign["sent_count"]} sent • ${campaign["opened_count"]} opened",
                          style: TextStyle(
                            fontSize: 11,
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
                        "${(campaign["open_rate"] as double).toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Open Rate",
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
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildTemplatesTab() {
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
                  "Email Templates",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 200,
                  children: [
                    _buildTemplateCard("Newsletter Template", "Perfect for regular updates and news", Icons.newspaper),
                    _buildTemplateCard("Promotional Template", "Great for sales and special offers", Icons.local_offer),
                    _buildTemplateCard("Welcome Template", "Onboard new subscribers", Icons.waving_hand),
                    _buildTemplateCard("Cart Recovery", "Recover abandoned carts", Icons.shopping_cart),
                    _buildTemplateCard("Re-engagement", "Win back inactive customers", Icons.favorite),
                    _buildTemplateCard("Product Launch", "Announce new products", Icons.rocket_launch),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTemplateCard(String title, String description, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 48,
            color: primaryColor,
          ),
          SizedBox(height: spSm),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          QButton(
            label: "Use Template",
            size: bs.sm,
            onPressed: () {
              // Use template
            },
          ),
        ],
      ),
    );
  }

  Widget _buildListsTab() {
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
                  "Email Lists & Segments",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildListItem("All Subscribers", 15420, "Everyone who subscribed", successColor),
                _buildListItem("Active Customers", 8950, "Purchased in last 90 days", primaryColor),
                _buildListItem("VIP Customers", 1250, "High-value customers", warningColor),
                _buildListItem("New Subscribers", 2840, "Joined in last 30 days", infoColor),
                _buildListItem("Inactive Customers", 3680, "No purchase in 6+ months", dangerColor),
                SizedBox(height: spSm),
                QButton(
                  label: "Create New Segment",
                  size: bs.md,
                  onPressed: () {
                    // Create new segment
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(String name, int count, String description, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "${(count / 1000).toStringAsFixed(1)}K",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: color,
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
      case "Sent":
        return infoColor;
      case "Draft":
        return warningColor;
      case "Scheduled":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }
}
