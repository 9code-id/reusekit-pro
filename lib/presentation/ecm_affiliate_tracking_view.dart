import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmAffiliateTrackingView extends StatefulWidget {
  const EcmAffiliateTrackingView({super.key});

  @override
  State<EcmAffiliateTrackingView> createState() => _EcmAffiliateTrackingViewState();
}

class _EcmAffiliateTrackingViewState extends State<EcmAffiliateTrackingView> {
  String filterPeriod = "30";
  String filterStatus = "all";
  String searchQuery = "";
  
  final List<Map<String, dynamic>> affiliates = [
    {
      "id": "AFF001",
      "name": "TechInfluencer Pro",
      "email": "tech@influence.com",
      "status": "active",
      "commissionRate": 12.5,
      "totalSales": 35000.0,
      "totalCommission": 4375.0,
      "referrals": 156,
      "joinDate": "2024-01-15",
      "lastActivity": "2024-06-18",
      "avatar": "https://picsum.photos/40/40?random=1&keyword=person"
    },
    {
      "id": "AFF002",
      "name": "DigitalMarket Hub",
      "email": "contact@digitalmarket.com",
      "status": "active",
      "commissionRate": 10.0,
      "totalSales": 28500.0,
      "totalCommission": 2850.0,
      "referrals": 98,
      "joinDate": "2024-02-20",
      "lastActivity": "2024-06-19",
      "avatar": "https://picsum.photos/40/40?random=2&keyword=business"
    },
    {
      "id": "AFF003",
      "name": "SocialBuzz Network",
      "email": "buzz@socialbuzz.net",
      "status": "pending",
      "commissionRate": 8.5,
      "totalSales": 12000.0,
      "totalCommission": 1020.0,
      "referrals": 45,
      "joinDate": "2024-05-10",
      "lastActivity": "2024-06-17",
      "avatar": "https://picsum.photos/40/40?random=3&keyword=social"
    },
    {
      "id": "AFF004",
      "name": "ContentCreator Elite",
      "email": "elite@contentcreator.io",
      "status": "inactive",
      "commissionRate": 15.0,
      "totalSales": 8200.0,
      "totalCommission": 1230.0,
      "referrals": 23,
      "joinDate": "2024-03-05",
      "lastActivity": "2024-05-30",
      "avatar": "https://picsum.photos/40/40?random=4&keyword=creator"
    }
  ];

  final List<Map<String, dynamic>> recentActivities = [
    {
      "affiliateId": "AFF001",
      "affiliateName": "TechInfluencer Pro",
      "action": "Sale Generated",
      "amount": 299.0,
      "commission": 37.38,
      "timestamp": "2 hours ago",
      "orderId": "ORD-2024-5501"
    },
    {
      "affiliateId": "AFF002", 
      "affiliateName": "DigitalMarket Hub",
      "action": "New Referral",
      "amount": 0.0,
      "commission": 0.0,
      "timestamp": "4 hours ago",
      "orderId": null
    },
    {
      "affiliateId": "AFF001",
      "affiliateName": "TechInfluencer Pro", 
      "action": "Commission Paid",
      "amount": 450.0,
      "commission": 450.0,
      "timestamp": "1 day ago",
      "orderId": "PAY-2024-1123"
    }
  ];

  List<Map<String, dynamic>> get filteredAffiliates {
    List<Map<String, dynamic>> filtered = List.from(affiliates);
    
    if (filterStatus != "all") {
      filtered = filtered.where((affiliate) => affiliate["status"] == filterStatus).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((affiliate) => 
        (affiliate["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (affiliate["email"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (affiliate["id"] as String).toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "pending":
        return warningColor;
      case "inactive":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case "active":
        return "Active";
      case "pending":
        return "Pending";
      case "inactive":
        return "Inactive";
      default:
        return "Unknown";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Affiliate Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.person_add),
            onPressed: () {
              // Navigate to add affiliate
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Overview Stats
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 160,
              children: [
                Container(
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
                          Icon(Icons.group, color: primaryColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Total Affiliates",
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
                        "${affiliates.length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
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
                            "Total Sales",
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
                        "\$${((affiliates.map((a) => a["totalSales"] as double).reduce((a, b) => a + b)) / 1000).toStringAsFixed(1)}K",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
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
                          Icon(Icons.payments, color: infoColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Commissions",
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
                        "\$${((affiliates.map((a) => a["totalCommission"] as double).reduce((a, b) => a + b)) / 1000).toStringAsFixed(1)}K",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
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
                          Icon(Icons.people_outline, color: warningColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Referrals",
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
                        "${affiliates.map((a) => a["referrals"] as int).reduce((a, b) => a + b)}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Filters
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: QTextField(
                    label: "Search affiliates...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Status",
                    items: [
                      {"label": "All Status", "value": "all"},
                      {"label": "Active", "value": "active"},
                      {"label": "Pending", "value": "pending"},
                      {"label": "Inactive", "value": "inactive"},
                    ],
                    value: filterStatus,
                    onChanged: (value, label) {
                      filterStatus = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Recent Activities
            Container(
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
                    "Recent Activities",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ...recentActivities.map((activity) {
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: spXs),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: disabledOutlineBorderColor,
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 6,
                            height: 40,
                            decoration: BoxDecoration(
                              color: _getActivityColor(activity["action"]),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${activity["affiliateName"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${activity["action"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              if ((activity["commission"] as double) > 0)
                                Text(
                                  "\$${(activity["commission"] as double).toStringAsFixed(2)}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                ),
                              Text(
                                "${activity["timestamp"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledColor,
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
            ),

            // Affiliates List
            Container(
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Affiliates (${filteredAffiliates.length})",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      QButton(
                        label: "Add New",
                        size: bs.sm,
                        onPressed: () {
                          // Navigate to add affiliate
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ...filteredAffiliates.map((affiliate) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: disabledOutlineBorderColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(radiusLg),
                                child: Image.network(
                                  "${affiliate["avatar"]}",
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${affiliate["name"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${affiliate["email"]}",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(affiliate["status"]).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  _getStatusText(affiliate["status"]),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: _getStatusColor(affiliate["status"]),
                                  ),
                                ),
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
                                      "Commission Rate",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${(affiliate["commissionRate"] as double).toStringAsFixed(1)}%",
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
                                      "Total Sales",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "\$${((affiliate["totalSales"] as double).toDouble()).currency}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
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
                                      "Commission",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "\$${((affiliate["totalCommission"] as double).toDouble()).currency}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: infoColor,
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
                                      "Referrals",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${affiliate["referrals"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: warningColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "View Details",
                                  size: bs.sm,
                                  onPressed: () {
                                    // Navigate to affiliate details
                                  },
                                ),
                              ),
                              SizedBox(width: spSm),
                              QButton(
                                icon: Icons.more_vert,
                                size: bs.sm,
                                onPressed: () {
                                  // Show options menu
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
          ],
        ),
      ),
    );
  }

  Color _getActivityColor(String action) {
    switch (action) {
      case "Sale Generated":
        return successColor;
      case "New Referral":
        return infoColor;
      case "Commission Paid":
        return warningColor;
      default:
        return disabledColor;
    }
  }
}
