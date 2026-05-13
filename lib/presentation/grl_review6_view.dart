import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlReview6View extends StatefulWidget {
  @override
  State<GrlReview6View> createState() => _GrlReview6ViewState();
}

class _GrlReview6ViewState extends State<GrlReview6View> {
  String selectedFilter = "all";
  String searchQuery = "";
  
  List<Map<String, dynamic>> reviewRequests = [
    {
      "id": 1,
      "type": "product",
      "item": "Wireless Bluetooth Earbuds",
      "customer": "John Smith",
      "email": "john.smith@email.com",
      "order_date": DateTime.now().subtract(Duration(days: 7)),
      "status": "pending",
      "purchase_verified": true,
      "reminders_sent": 1,
      "order_value": 89.99,
      "customer_tier": "gold",
    },
    {
      "id": 2,
      "type": "service",
      "item": "Home Cleaning Service",
      "customer": "Sarah Johnson",
      "email": "sarah.j@email.com",
      "order_date": DateTime.now().subtract(Duration(days: 3)),
      "status": "completed",
      "purchase_verified": true,
      "reminders_sent": 0,
      "order_value": 150.00,
      "customer_tier": "platinum",
    },
    {
      "id": 3,
      "type": "product",
      "item": "Smart Home Camera",
      "customer": "Mike Wilson",
      "email": "mike.w@email.com",
      "order_date": DateTime.now().subtract(Duration(days: 14)),
      "status": "expired",
      "purchase_verified": true,
      "reminders_sent": 3,
      "order_value": 199.99,
      "customer_tier": "silver",
    },
    {
      "id": 4,
      "type": "service",
      "item": "Car Detailing",
      "customer": "Emma Davis",
      "email": "emma.davis@email.com",
      "order_date": DateTime.now().subtract(Duration(days: 2)),
      "status": "pending",
      "purchase_verified": true,
      "reminders_sent": 0,
      "order_value": 120.00,
      "customer_tier": "gold",
    },
  ];
  
  Map<String, dynamic> campaignStats = {
    "total_requests": 1247,
    "response_rate": 23.5,
    "pending_requests": 892,
    "completed_reviews": 293,
    "expired_requests": 62,
  };

  @override
  Widget build(BuildContext context) {
    final filteredRequests = _getFilteredRequests();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Review Requests"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showCreateCampaignModal();
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Campaign Stats
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        "Total Requests",
                        "${campaignStats["total_requests"]}",
                        Icons.mail,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildStatCard(
                        "Response Rate",
                        "${campaignStats["response_rate"]}%",
                        Icons.trending_up,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        "Pending",
                        "${campaignStats["pending_requests"]}",
                        Icons.schedule,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildStatCard(
                        "Completed",
                        "${campaignStats["completed_reviews"]}",
                        Icons.check_circle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Search and Filter
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search customers or products...",
                        value: searchQuery,
                        hint: "Enter name, email, or product",
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
                SizedBox(height: spMd),
                QHorizontalScroll(
                  children: [
                    'all', 'pending', 'completed', 'expired', 'high_value'
                  ].map((filter) => GestureDetector(
                    onTap: () {
                      selectedFilter = filter;
                      setState(() {});
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: spSm),
                      padding: EdgeInsets.symmetric(
                        horizontal: spMd,
                        vertical: spSm,
                      ),
                      decoration: BoxDecoration(
                        color: selectedFilter == filter ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusLg),
                        border: Border.all(
                          color: selectedFilter == filter ? primaryColor : disabledColor,
                        ),
                      ),
                      child: Text(
                        filter.toUpperCase().replaceAll('_', ' '),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: selectedFilter == filter ? Colors.white : disabledBoldColor,
                        ),
                      ),
                    ),
                  )).toList(),
                ),
              ],
            ),
          ),
          
          // Request List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(spMd),
              itemCount: filteredRequests.length,
              itemBuilder: (context, index) {
                final request = filteredRequests[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowMd],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: _getStatusColor(request["status"]),
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Request Header
                      Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: _getTypeColor(request["type"]).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                _getTypeIcon(request["type"]),
                                color: _getTypeColor(request["type"]),
                                size: 20,
                              ),
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${request["item"]}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Text(
                                        "${request["customer"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: primaryColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spSm,
                                          vertical: spXs,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _getTierColor(request["customer_tier"]).withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Text(
                                          "${request["customer_tier"]}".toUpperCase(),
                                          style: TextStyle(
                                            fontSize: 8,
                                            fontWeight: FontWeight.bold,
                                            color: _getTierColor(request["customer_tier"]),
                                          ),
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
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor(request["status"]).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${request["status"]}".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: _getStatusColor(request["status"]),
                                    ),
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "\$${((request["order_value"] as double).toDouble()).currency}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      
                      // Request Details
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(radiusLg),
                            bottomRight: Radius.circular(radiusLg),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.email, size: 16, color: primaryColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${request["email"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spMd),
                                Icon(Icons.calendar_today, size: 16, color: primaryColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${(request["order_date"] as DateTime).dMMMy}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Icon(Icons.verified, size: 16, color: successColor),
                                SizedBox(width: spXs),
                                Text(
                                  "Purchase Verified",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: successColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: spMd),
                                Icon(Icons.notification_important, size: 16, color: warningColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${request["reminders_sent"]} reminders sent",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: warningColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spMd),
                            Row(
                              children: [
                                if (request["status"] == "pending") ...[
                                  Expanded(
                                    child: QButton(
                                      label: "Send Reminder",
                                      size: bs.sm,
                                      onPressed: () {
                                        _sendReminder(request);
                                      },
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: QButton(
                                      label: "Follow Up",
                                      size: bs.sm,
                                      onPressed: () {
                                        _followUp(request);
                                      },
                                    ),
                                  ),
                                ] else if (request["status"] == "completed") ...[
                                  Expanded(
                                    child: QButton(
                                      label: "View Review",
                                      size: bs.sm,
                                      onPressed: () {},
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  QButton(
                                    icon: Icons.share,
                                    size: bs.sm,
                                    onPressed: () {},
                                  ),
                                ] else if (request["status"] == "expired") ...[
                                  Expanded(
                                    child: QButton(
                                      label: "Reactivate",
                                      size: bs.sm,
                                      onPressed: () {
                                        _reactivateRequest(request);
                                      },
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  QButton(
                                    icon: Icons.delete,
                                    size: bs.sm,
                                    onPressed: () {
                                      _deleteRequest(request);
                                    },
                                  ),
                                ],
                                SizedBox(width: spSm),
                                QButton(
                                  icon: Icons.more_vert,
                                  size: bs.sm,
                                  onPressed: () {
                                    _showRequestMenu(request);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showBulkActionsModal();
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.dynamic_feed,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(50),
        borderRadius: BorderRadius.circular(radiusLg),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredRequests() {
    List<Map<String, dynamic>> filtered = reviewRequests;
    
    if (selectedFilter != "all") {
      if (selectedFilter == "high_value") {
        filtered = filtered.where((r) => (r["order_value"] as double) > 100).toList();
      } else {
        filtered = filtered.where((r) => r["status"] == selectedFilter).toList();
      }
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((r) => 
        r["customer"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
        r["item"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
        r["email"].toString().toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return warningColor;
      case 'completed':
        return successColor;
      case 'expired':
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'product':
        return primaryColor;
      case 'service':
        return infoColor;
      default:
        return disabledColor;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case 'product':
        return Icons.shopping_bag;
      case 'service':
        return Icons.build;
      default:
        return Icons.help;
    }
  }

  Color _getTierColor(String tier) {
    switch (tier) {
      case 'platinum':
        return Color(0xFF9C27B0);
      case 'gold':
        return warningColor;
      case 'silver':
        return disabledBoldColor;
      default:
        return disabledColor;
    }
  }

  void _sendReminder(Map<String, dynamic> request) {
    ss("Reminder sent to ${request["customer"]}");
  }

  void _followUp(Map<String, dynamic> request) {
    ss("Follow-up email sent to ${request["customer"]}");
  }

  void _reactivateRequest(Map<String, dynamic> request) {
    ss("Request reactivated for ${request["customer"]}");
  }

  void _deleteRequest(Map<String, dynamic> request) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this request?");
    if (isConfirmed) {
      ss("Request deleted successfully");
    }
  }

  void _showRequestMenu(Map<String, dynamic> request) {
    // Show request options menu
  }

  void _showCreateCampaignModal() {
    // Show create campaign modal
  }

  void _showBulkActionsModal() {
    // Show bulk actions modal
  }
}
