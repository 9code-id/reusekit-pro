import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmPromotionalToolsView extends StatefulWidget {
  const EcmPromotionalToolsView({super.key});

  @override
  State<EcmPromotionalToolsView> createState() => _EcmPromotionalToolsViewState();
}

class _EcmPromotionalToolsViewState extends State<EcmPromotionalToolsView> {
  int currentTab = 0;
  
  // Discount Codes Data
  List<Map<String, dynamic>> discountCodes = [
    {
      "id": "early_bird_2024",
      "code": "EARLY2024",
      "title": "Early Bird Special",
      "description": "30% off for early registrations",
      "discountType": "percentage",
      "discountValue": 30,
      "minAmount": 100.0,
      "maxUses": 500,
      "usedCount": 342,
      "validFrom": "2024-01-01T00:00:00Z",
      "validUntil": "2024-02-15T23:59:59Z",
      "status": "active",
      "applicableTickets": ["vip", "standard", "premium"],
      "revenue": 45600.0,
    },
    {
      "id": "group_discount",
      "code": "GROUP10",
      "title": "Group Discount",
      "description": "10% off for groups of 5 or more",
      "discountType": "percentage",
      "discountValue": 10,
      "minAmount": 500.0,
      "maxUses": 100,
      "usedCount": 67,
      "validFrom": "2024-01-01T00:00:00Z",
      "validUntil": "2024-03-01T23:59:59Z",
      "status": "active",
      "applicableTickets": ["standard", "premium"],
      "revenue": 12400.0,
    },
    {
      "id": "student_promo",
      "code": "STUDENT50",
      "title": "Student Discount",
      "description": "\$50 off for students with valid ID",
      "discountType": "fixed",
      "discountValue": 50,
      "minAmount": 100.0,
      "maxUses": 200,
      "usedCount": 156,
      "validFrom": "2024-01-01T00:00:00Z",
      "validUntil": "2024-02-28T23:59:59Z",
      "status": "active",
      "applicableTickets": ["standard"],
      "revenue": 7800.0,
    },
    {
      "id": "vip_upgrade",
      "code": "VIPUP25",
      "title": "VIP Upgrade Promo",
      "description": "25% off VIP ticket upgrades",
      "discountType": "percentage",
      "discountValue": 25,
      "minAmount": 200.0,
      "maxUses": 50,
      "usedCount": 23,
      "validFrom": "2024-01-15T00:00:00Z",
      "validUntil": "2024-02-01T23:59:59Z",
      "status": "active",
      "applicableTickets": ["vip"],
      "revenue": 8900.0,
    },
    {
      "id": "expired_promo",
      "code": "HOLIDAY23",
      "title": "Holiday Special",
      "description": "Holiday season discount",
      "discountType": "percentage",
      "discountValue": 20,
      "minAmount": 150.0,
      "maxUses": 300,
      "usedCount": 289,
      "validFrom": "2023-12-01T00:00:00Z",
      "validUntil": "2024-01-01T23:59:59Z",
      "status": "expired",
      "applicableTickets": ["standard", "premium"],
      "revenue": 34500.0,
    },
  ];

  // Promotional Campaigns Data
  List<Map<String, dynamic>> campaigns = [
    {
      "id": "launch_campaign",
      "name": "Event Launch Campaign",
      "description": "Multi-channel campaign for event announcement",
      "status": "active",
      "budget": 15000.0,
      "spent": 8750.0,
      "startDate": "2024-01-01T00:00:00Z",
      "endDate": "2024-02-15T23:59:59Z",
      "channels": ["social_media", "email", "paid_ads"],
      "metrics": {
        "impressions": 245000,
        "clicks": 12300,
        "conversions": 890,
        "ctr": 5.02,
        "conversionRate": 7.24,
        "costPerConversion": 9.83,
      },
      "targetAudience": "Tech professionals, entrepreneurs",
      "creative": "https://picsum.photos/400/300?random=1&keyword=campaign",
    },
    {
      "id": "speaker_spotlight",
      "name": "Speaker Spotlight Series",
      "description": "Weekly speaker announcements and interviews",
      "status": "active",
      "budget": 8000.0,
      "spent": 4200.0,
      "startDate": "2024-01-10T00:00:00Z",
      "endDate": "2024-02-28T23:59:59Z",
      "channels": ["social_media", "video"],
      "metrics": {
        "impressions": 156000,
        "clicks": 8900,
        "conversions": 456,
        "ctr": 5.71,
        "conversionRate": 5.12,
        "costPerConversion": 9.21,
      },
      "targetAudience": "Industry professionals, students",
      "creative": "https://picsum.photos/400/300?random=2&keyword=speaker",
    },
    {
      "id": "early_bird_push",
      "name": "Early Bird Final Call",
      "description": "Last chance promotion for early bird pricing",
      "status": "completed",
      "budget": 5000.0,
      "spent": 4890.0,
      "startDate": "2024-02-01T00:00:00Z",
      "endDate": "2024-02-14T23:59:59Z",
      "channels": ["email", "paid_ads"],
      "metrics": {
        "impressions": 89000,
        "clicks": 5600,
        "conversions": 234,
        "ctr": 6.29,
        "conversionRate": 4.18,
        "costPerConversion": 20.90,
      },
      "targetAudience": "Previous attendees, email subscribers",
      "creative": "https://picsum.photos/400/300?random=3&keyword=urgent",
    },
  ];

  // Affiliate Program Data
  List<Map<String, dynamic>> affiliates = [
    {
      "id": "partner_1",
      "name": "TechBlog Network",
      "email": "partnerships@techblog.com",
      "joinDate": "2024-01-05T00:00:00Z",
      "status": "active",
      "commissionRate": 15.0,
      "totalReferrals": 89,
      "totalRevenue": 23450.0,
      "totalCommission": 3517.50,
      "lastSale": "2024-01-14T16:30:00Z",
      "paymentStatus": "pending",
      "referralCode": "TECHBLOG15",
      "tier": "gold",
    },
    {
      "id": "partner_2",
      "name": "Sarah Chen",
      "email": "sarah.chen@email.com",
      "joinDate": "2024-01-08T00:00:00Z",
      "status": "active",
      "commissionRate": 10.0,
      "totalReferrals": 45,
      "totalRevenue": 8900.0,
      "totalCommission": 890.0,
      "lastSale": "2024-01-13T09:15:00Z",
      "paymentStatus": "paid",
      "referralCode": "SARAH10",
      "tier": "silver",
    },
    {
      "id": "partner_3",
      "name": "Industry Leaders Hub",
      "email": "info@industryleaders.com",
      "joinDate": "2024-01-12T00:00:00Z",
      "status": "active",
      "commissionRate": 20.0,
      "totalReferrals": 156,
      "totalRevenue": 67800.0,
      "totalCommission": 13560.0,
      "lastSale": "2024-01-15T14:22:00Z",
      "paymentStatus": "pending",
      "referralCode": "LEADERS20",
      "tier": "platinum",
    },
    {
      "id": "partner_4",
      "name": "Mike Rodriguez",
      "email": "mike.r@consulting.com",
      "joinDate": "2024-01-03T00:00:00Z",
      "status": "inactive",
      "commissionRate": 12.0,
      "totalReferrals": 12,
      "totalRevenue": 1800.0,
      "totalCommission": 216.0,
      "lastSale": "2024-01-05T11:45:00Z",
      "paymentStatus": "paid",
      "referralCode": "MIKE12",
      "tier": "bronze",
    },
  ];

  // Promotional Analytics
  Map<String, dynamic> promotionalAnalytics = {
    "totalPromotionalRevenue": 109250.0,
    "totalDiscountGiven": 34750.0,
    "totalCampaignSpend": 17840.0,
    "totalAffiliateCommissions": 18183.50,
    "totalPromotionalROI": 3.8,
    "bestPerformingCode": "EARLY2024",
    "bestPerformingCampaign": "Event Launch Campaign",
    "topAffiliate": "Industry Leaders Hub",
  };

  String selectedCodeStatus = "all";
  String selectedCampaignStatus = "all";
  String selectedAffiliateStatus = "all";
  
  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Promotional Tools",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Discount Codes", icon: Icon(Icons.local_offer)),
        Tab(text: "Campaigns", icon: Icon(Icons.campaign)),
        Tab(text: "Affiliates", icon: Icon(Icons.people)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildDiscountCodesTab(),
        _buildCampaignsTab(),
        _buildAffiliatesTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildDiscountCodesTab() {
    List<Map<String, dynamic>> filteredCodes = selectedCodeStatus == "all" 
        ? discountCodes 
        : discountCodes.where((code) => code["status"] == selectedCodeStatus).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Discount Codes Overview
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Text(
                  "Discount Codes Overview",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard("Active Codes", "${discountCodes.where((c) => c["status"] == "active").length}", Icons.local_offer, successColor),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildStatCard("Total Revenue", "\$${((discountCodes.fold(0.0, (sum, code) => sum + (code["revenue"] as double))) / 1000).toStringAsFixed(1)}K", Icons.attach_money, infoColor),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Controls
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Filter by Status",
                    items: [
                      {"label": "All Codes", "value": "all"},
                      {"label": "Active", "value": "active"},
                      {"label": "Expired", "value": "expired"},
                      {"label": "Disabled", "value": "disabled"},
                    ],
                    value: selectedCodeStatus,
                    onChanged: (value, label) {
                      selectedCodeStatus = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  label: "Create Code",
                  icon: Icons.add,
                  size: bs.sm,
                  onPressed: () => _showCreateDiscountDialog(),
                ),
              ],
            ),
          ),

          // Discount Codes List
          Container(
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
                  "Discount Codes",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...filteredCodes.map((code) => _buildDiscountCodeCard(code)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDiscountCodeCard(Map<String, dynamic> code) {
    String status = code["status"] as String;
    Color statusColor = status == "active" ? successColor : 
                       status == "expired" ? dangerColor : 
                       disabledColor;
    
    double usagePercent = ((code["usedCount"] as int) / (code["maxUses"] as int) * 100);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${code["code"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: statusColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            status.toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${code["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${code["description"]}",
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
                    code["discountType"] == "percentage" 
                        ? "${(code["discountValue"] as int)}% OFF"
                        : "\$${(code["discountValue"] as int)} OFF",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  Text(
                    "\$${((code["revenue"] as double) / 1000).toStringAsFixed(1)}K revenue",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Usage: ${code["usedCount"]}/${code["maxUses"]} (${usagePercent.toStringAsFixed(1)}%)",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Container(
                      height: 4,
                      margin: EdgeInsets.only(top: 4),
                      decoration: BoxDecoration(
                        color: disabledColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: usagePercent / 100,
                        child: Container(
                          decoration: BoxDecoration(
                            color: usagePercent > 80 ? dangerColor : 
                                   usagePercent > 60 ? warningColor : successColor,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "Valid until ${DateTime.parse("${code["validUntil"]}").dMMMy}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showDiscountCodeOptions(code),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCampaignsTab() {
    List<Map<String, dynamic>> filteredCampaigns = selectedCampaignStatus == "all" 
        ? campaigns 
        : campaigns.where((campaign) => campaign["status"] == selectedCampaignStatus).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Campaign Overview
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Text(
                  "Campaign Performance",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard("Total Budget", "\$${((campaigns.fold(0.0, (sum, campaign) => sum + (campaign["budget"] as double))) / 1000).toStringAsFixed(1)}K", Icons.account_balance_wallet, infoColor),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildStatCard("Total Spent", "\$${((campaigns.fold(0.0, (sum, campaign) => sum + (campaign["spent"] as double))) / 1000).toStringAsFixed(1)}K", Icons.trending_down, warningColor),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Controls
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Filter by Status",
                    items: [
                      {"label": "All Campaigns", "value": "all"},
                      {"label": "Active", "value": "active"},
                      {"label": "Completed", "value": "completed"},
                      {"label": "Paused", "value": "paused"},
                    ],
                    value: selectedCampaignStatus,
                    onChanged: (value, label) {
                      selectedCampaignStatus = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  label: "New Campaign",
                  icon: Icons.add,
                  size: bs.sm,
                  onPressed: () => _showCreateCampaignDialog(),
                ),
              ],
            ),
          ),

          // Campaigns List
          Container(
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
                  "Promotional Campaigns",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...filteredCampaigns.map((campaign) => _buildCampaignCard(campaign)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCampaignCard(Map<String, dynamic> campaign) {
    String status = campaign["status"] as String;
    Color statusColor = status == "active" ? successColor : 
                       status == "completed" ? infoColor : 
                       status == "paused" ? warningColor : disabledColor;
    
    Map<String, dynamic> metrics = campaign["metrics"] as Map<String, dynamic>;
    double budgetUsed = ((campaign["spent"] as double) / (campaign["budget"] as double) * 100);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
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
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusSm),
                  image: DecorationImage(
                    image: NetworkImage("${campaign["creative"]}"),
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
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: statusColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            status.toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${campaign["description"]}",
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
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Budget: \$${((campaign["spent"] as double) / 1000).toStringAsFixed(1)}K / \$${((campaign["budget"] as double) / 1000).toStringAsFixed(1)}K",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Container(
                      height: 4,
                      margin: EdgeInsets.only(top: 4),
                      decoration: BoxDecoration(
                        color: disabledColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: budgetUsed / 100,
                        child: Container(
                          decoration: BoxDecoration(
                            color: budgetUsed > 90 ? dangerColor : 
                                   budgetUsed > 70 ? warningColor : successColor,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "${(metrics["conversions"] as int).toString()} conversions",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              _buildMetricChip("${((metrics["impressions"] as int) / 1000).toStringAsFixed(0)}K impressions", Icons.visibility),
              SizedBox(width: spXs),
              _buildMetricChip("${(metrics["ctr"] as double).toStringAsFixed(1)}% CTR", Icons.mouse),
              SizedBox(width: spXs),
              _buildMetricChip("${(metrics["conversionRate"] as double).toStringAsFixed(1)}% CR", Icons.trending_up),
              Spacer(),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showCampaignOptions(campaign),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAffiliatesTab() {
    List<Map<String, dynamic>> filteredAffiliates = selectedAffiliateStatus == "all" 
        ? affiliates 
        : affiliates.where((affiliate) => affiliate["status"] == selectedAffiliateStatus).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Affiliate Overview
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Text(
                  "Affiliate Program Performance",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard("Active Partners", "${affiliates.where((a) => a["status"] == "active").length}", Icons.people, successColor),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildStatCard("Total Commissions", "\$${((affiliates.fold(0.0, (sum, affiliate) => sum + (affiliate["totalCommission"] as double))) / 1000).toStringAsFixed(1)}K", Icons.account_balance_wallet, infoColor),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Controls
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Filter by Status",
                    items: [
                      {"label": "All Affiliates", "value": "all"},
                      {"label": "Active", "value": "active"},
                      {"label": "Inactive", "value": "inactive"},
                      {"label": "Suspended", "value": "suspended"},
                    ],
                    value: selectedAffiliateStatus,
                    onChanged: (value, label) {
                      selectedAffiliateStatus = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  label: "Invite Partner",
                  icon: Icons.person_add,
                  size: bs.sm,
                  onPressed: () => _showInviteAffiliateDialog(),
                ),
              ],
            ),
          ),

          // Affiliates List
          Container(
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
                  "Affiliate Partners",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...filteredAffiliates.map((affiliate) => _buildAffiliateCard(affiliate)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAffiliateCard(Map<String, dynamic> affiliate) {
    String status = affiliate["status"] as String;
    String tier = affiliate["tier"] as String;
    
    Color statusColor = status == "active" ? successColor : 
                       status == "inactive" ? warningColor : dangerColor;
    
    Color tierColor = tier == "platinum" ? Color(0xFFE5E4E7) : 
                     tier == "gold" ? Color(0xFFFFD700) : 
                     tier == "silver" ? Color(0xFFC0C0C0) : Color(0xFFCD7F32);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
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
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Center(
                  child: Text(
                    "${affiliate["name"]}".substring(0, 1).toUpperCase(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
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
                        Text(
                          "${affiliate["name"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: tierColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            tier.toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: statusColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            status.toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${affiliate["email"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "${(affiliate["commissionRate"] as double).toStringAsFixed(0)}%",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildAffiliateMetric("Referrals", "${affiliate["totalReferrals"]}", Icons.people),
              ),
              Expanded(
                child: _buildAffiliateMetric("Revenue", "\$${((affiliate["totalRevenue"] as double) / 1000).toStringAsFixed(1)}K", Icons.attach_money),
              ),
              Expanded(
                child: _buildAffiliateMetric("Commission", "\$${((affiliate["totalCommission"] as double) / 100).toStringAsFixed(0)}", Icons.account_balance_wallet),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "Code: ${affiliate["referralCode"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: affiliate["paymentStatus"] == "paid" ? successColor : warningColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${affiliate["paymentStatus"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showAffiliateOptions(affiliate),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Overall Promotional Analytics
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Text(
                  "Promotional Analytics Overview",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard("Total Revenue", "\$${((promotionalAnalytics["totalPromotionalRevenue"] as double) / 1000).toStringAsFixed(1)}K", Icons.attach_money, successColor),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildStatCard("ROI", "${(promotionalAnalytics["totalPromotionalROI"] as double).toStringAsFixed(1)}x", Icons.trending_up, infoColor),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard("Discounts Given", "\$${((promotionalAnalytics["totalDiscountGiven"] as double) / 1000).toStringAsFixed(1)}K", Icons.local_offer, warningColor),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildStatCard("Campaign Spend", "\$${((promotionalAnalytics["totalCampaignSpend"] as double) / 1000).toStringAsFixed(1)}K", Icons.campaign, dangerColor),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Best Performers
          Container(
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
                  "Top Performers",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                _buildPerformerItem("Best Discount Code", "${promotionalAnalytics["bestPerformingCode"]}", Icons.local_offer, successColor),
                _buildPerformerItem("Best Campaign", "${promotionalAnalytics["bestPerformingCampaign"]}", Icons.campaign, infoColor),
                _buildPerformerItem("Top Affiliate", "${promotionalAnalytics["topAffiliate"]}", Icons.people, warningColor),
              ],
            ),
          ),

          // Revenue Breakdown
          Container(
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
                  "Revenue Breakdown",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                _buildRevenueBreakdownChart(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Icon(icon, color: color, size: 24),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricChip(String text, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
      decoration: BoxDecoration(
        color: disabledColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: disabledBoldColor),
          SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAffiliateMetric(String title, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 16, color: disabledBoldColor),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildPerformerItem(String title, String name, IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRevenueBreakdownChart() {
    return Column(
      spacing: spSm,
      children: [
        _buildRevenueBar("Discount Codes", 65800.0, successColor),
        _buildRevenueBar("Affiliate Commissions", 18183.50, infoColor),
        _buildRevenueBar("Campaign Revenue", 25266.50, warningColor),
      ],
    );
  }

  Widget _buildRevenueBar(String title, double amount, Color color) {
    double percentage = (amount / (promotionalAnalytics["totalPromotionalRevenue"] as double)) * 100;
    
    return Column(
      children: [
        Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            Spacer(),
            Text(
              "\$${(amount / 1000).toStringAsFixed(1)}K (${percentage.toStringAsFixed(1)}%)",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
        SizedBox(height: spXs),
        Container(
          height: 8,
          decoration: BoxDecoration(
            color: disabledColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: percentage / 100,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showCreateDiscountDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Create Discount Code"),
        content: Text("Discount code creation form will be implemented here."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ss("Discount code created successfully!");
            },
            child: Text("Create"),
          ),
        ],
      ),
    );
  }

  void _showDiscountCodeOptions(Map<String, dynamic> code) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Code Options"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.edit),
              title: Text("Edit Code"),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.copy),
              title: Text("Copy Code"),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(code["status"] == "active" ? Icons.pause : Icons.play_arrow),
              title: Text(code["status"] == "active" ? "Disable" : "Enable"),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text("Delete"),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showCreateCampaignDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Create Campaign"),
        content: Text("Campaign creation form will be implemented here."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ss("Campaign created successfully!");
            },
            child: Text("Create"),
          ),
        ],
      ),
    );
  }

  void _showCampaignOptions(Map<String, dynamic> campaign) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Campaign Options"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.edit),
              title: Text("Edit Campaign"),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.analytics),
              title: Text("View Analytics"),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(campaign["status"] == "active" ? Icons.pause : Icons.play_arrow),
              title: Text(campaign["status"] == "active" ? "Pause" : "Resume"),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text("Delete"),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showInviteAffiliateDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Invite Affiliate Partner"),
        content: Text("Affiliate invitation form will be implemented here."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ss("Invitation sent successfully!");
            },
            child: Text("Send Invite"),
          ),
        ],
      ),
    );
  }

  void _showAffiliateOptions(Map<String, dynamic> affiliate) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Affiliate Options"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.person),
              title: Text("View Profile"),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.analytics),
              title: Text("View Performance"),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.payment),
              title: Text("Process Payment"),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.block),
              title: Text("Suspend Partner"),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
