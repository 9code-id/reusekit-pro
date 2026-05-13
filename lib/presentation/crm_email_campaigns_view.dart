import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmEmailCampaignsView extends StatefulWidget {
  const CrmEmailCampaignsView({super.key});

  @override
  State<CrmEmailCampaignsView> createState() => _CrmEmailCampaignsViewState();
}

class _CrmEmailCampaignsViewState extends State<CrmEmailCampaignsView> {
  String searchQuery = "";
  String selectedStatus = "all";
  bool loading = false;

  List<Map<String, dynamic>> campaigns = [
    {
      "id": "1",
      "name": "Summer Sale 2024",
      "description": "Promotional campaign for summer collection with special discounts",
      "status": "active",
      "type": "promotional",
      "recipients": 5240,
      "sent": 5240,
      "delivered": 5186,
      "opened": 3759,
      "clicked": 642,
      "bounced": 54,
      "unsubscribed": 12,
      "open_rate": 72.5,
      "click_rate": 12.3,
      "bounce_rate": 1.0,
      "created_at": "2024-06-15T10:00:00",
      "sent_at": "2024-06-16T09:00:00",
      "budget": 2500.0,
      "spent": 1850.0,
      "template_id": "summer_sale",
      "segments": ["vip_customers", "regular_customers"]
    },
    {
      "id": "2",
      "name": "Welcome Series - New Customers",
      "description": "Automated welcome emails for new customer onboarding",
      "status": "active",
      "type": "automation",
      "recipients": 1890,
      "sent": 1890,
      "delivered": 1878,
      "opened": 1598,
      "clicked": 423,
      "bounced": 12,
      "unsubscribed": 3,
      "open_rate": 85.2,
      "click_rate": 22.5,
      "bounce_rate": 0.6,
      "created_at": "2024-05-20T14:30:00",
      "sent_at": "2024-05-21T10:00:00",
      "budget": 1200.0,
      "spent": 945.0,
      "template_id": "welcome_series",
      "segments": ["new_customers"]
    },
    {
      "id": "3",
      "name": "Product Update Newsletter",
      "description": "Monthly newsletter featuring new products and updates",
      "status": "completed",
      "type": "newsletter",
      "recipients": 8750,
      "sent": 8750,
      "delivered": 8642,
      "opened": 5944,
      "clicked": 1037,
      "bounced": 108,
      "unsubscribed": 28,
      "open_rate": 68.9,
      "click_rate": 12.0,
      "bounce_rate": 1.2,
      "created_at": "2024-05-01T11:00:00",
      "sent_at": "2024-05-02T08:00:00",
      "budget": 3500.0,
      "spent": 3200.0,
      "template_id": "newsletter_monthly",
      "segments": ["subscribers", "customers"]
    },
    {
      "id": "4",
      "name": "Abandoned Cart Recovery",
      "description": "Recover abandoned shopping carts with personalized offers",
      "status": "paused",
      "type": "automation",
      "recipients": 2345,
      "sent": 1890,
      "delivered": 1845,
      "opened": 1198,
      "clicked": 234,
      "bounced": 45,
      "unsubscribed": 7,
      "open_rate": 65.0,
      "click_rate": 12.7,
      "bounce_rate": 2.4,
      "created_at": "2024-06-10T16:00:00",
      "sent_at": "2024-06-11T12:00:00",
      "budget": 1800.0,
      "spent": 1156.0,
      "template_id": "cart_recovery",
      "segments": ["cart_abandoners"]
    },
    {
      "id": "5",
      "name": "Holiday Special Offer",
      "description": "Special holiday promotion for loyal customers",
      "status": "draft",
      "type": "promotional",
      "recipients": 3200,
      "sent": 0,
      "delivered": 0,
      "opened": 0,
      "clicked": 0,
      "bounced": 0,
      "unsubscribed": 0,
      "open_rate": 0.0,
      "click_rate": 0.0,
      "bounce_rate": 0.0,
      "created_at": "2024-06-18T09:30:00",
      "sent_at": null,
      "budget": 2000.0,
      "spent": 0.0,
      "template_id": "holiday_special",
      "segments": ["loyal_customers", "vip_customers"]
    },
    {
      "id": "6",
      "name": "Re-engagement Campaign",
      "description": "Win back inactive subscribers with special incentives",
      "status": "scheduled",
      "type": "re-engagement",
      "recipients": 4560,
      "sent": 0,
      "delivered": 0,
      "opened": 0,
      "clicked": 0,
      "bounced": 0,
      "unsubscribed": 0,
      "open_rate": 0.0,
      "click_rate": 0.0,
      "bounce_rate": 0.0,
      "created_at": "2024-06-17T13:15:00",
      "sent_at": "2024-06-22T10:00:00",
      "budget": 2800.0,
      "spent": 0.0,
      "template_id": "re_engagement",
      "segments": ["inactive_subscribers"]
    }
  ];

  List<Map<String, dynamic>> get filteredCampaigns {
    return campaigns.where((campaign) {
      final matchesSearch = "${campaign["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                           "${campaign["description"]}".toLowerCase().contains(searchQuery.toLowerCase());
      final matchesStatus = selectedStatus == "all" || "${campaign["status"]}" == selectedStatus;
      return matchesSearch && matchesStatus;
    }).toList()..sort((a, b) => DateTime.parse("${b["created_at"]}").compareTo(DateTime.parse("${a["created_at"]}")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Email Campaigns"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showCreateCampaignDialog();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filter Section
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
                  icon: Icons.filter_list,
                  size: bs.sm,
                  onPressed: () {
                    _showFilterDialog();
                  },
                ),
              ],
            ),

            // Status Filter Chips
            QHorizontalScroll(
              children: [
                _buildStatusChip("All", "all"),
                _buildStatusChip("Active", "active"),
                _buildStatusChip("Completed", "completed"),
                _buildStatusChip("Paused", "paused"),
                _buildStatusChip("Draft", "draft"),
                _buildStatusChip("Scheduled", "scheduled"),
              ],
            ),

            // Campaign Statistics
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 150,
              children: [
                _buildStatCard("Total Campaigns", "${campaigns.length}", primaryColor, Icons.campaign),
                _buildStatCard("Active", "${campaigns.where((c) => c["status"] == "active").length}", successColor, Icons.play_circle),
                _buildStatCard("Total Sent", "${campaigns.fold(0, (sum, c) => sum + (c["sent"] as int))}", infoColor, Icons.send),
                _buildStatCard("Avg. Open Rate", "${_calculateAverageOpenRate().toStringAsFixed(1)}%", warningColor, Icons.open_in_new),
              ],
            ),

            // Performance Overview
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
                    "Campaign Performance Overview",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 120,
                    children: [
                      _buildMetricCard("Total Delivered", "${campaigns.fold(0, (sum, c) => sum + (c["delivered"] as int))}", successColor),
                      _buildMetricCard("Total Opened", "${campaigns.fold(0, (sum, c) => sum + (c["opened"] as int))}", infoColor),
                      _buildMetricCard("Total Clicked", "${campaigns.fold(0, (sum, c) => sum + (c["clicked"] as int))}", warningColor),
                      _buildMetricCard("Total Bounced", "${campaigns.fold(0, (sum, c) => sum + (c["bounced"] as int))}", dangerColor),
                    ],
                  ),
                ],
              ),
            ),

            // Campaigns List
            if (loading)
              Center(child: CircularProgressIndicator())
            else if (filteredCampaigns.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(Icons.campaign, size: 64, color: disabledColor),
                    SizedBox(height: spSm),
                    Text(
                      "No campaigns found",
                      style: TextStyle(
                        fontSize: fsH6,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...filteredCampaigns.map((campaign) => _buildCampaignCard(campaign)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreateCampaignDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildStatusChip(String label, String value) {
    final isSelected = selectedStatus == value;
    return GestureDetector(
      onTap: () {
        selectedStatus = value;
        setState(() {});
      },
      child: Container(
        margin: EdgeInsets.only(right: spSm),
        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(radiusLg),
          border: Border.all(
            color: isSelected ? primaryColor : disabledOutlineBorderColor,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : disabledBoldColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCampaignCard(Map<String, dynamic> campaign) {
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
            color: _getStatusColor("${campaign["status"]}"),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                _getCampaignTypeIcon("${campaign["type"]}"),
                color: _getCampaignTypeColor("${campaign["type"]}"),
                size: 20,
              ),
              SizedBox(width: spSm),
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
                    Text(
                      "${campaign["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor("${campaign["status"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${campaign["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: _getStatusColor("${campaign["status"]}"),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          
          // Campaign Metrics
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 80,
            children: [
              _buildCampaignMetric("Recipients", "${campaign["recipients"]}", Icons.people),
              _buildCampaignMetric("Sent", "${campaign["sent"]}", Icons.send),
              _buildCampaignMetric("Opened", "${campaign["opened"]}", Icons.open_in_new),
              _buildCampaignMetric("Clicked", "${campaign["clicked"]}", Icons.mouse),
            ],
          ),
          
          SizedBox(height: spSm),
          
          // Performance Rates
          Row(
            children: [
              Expanded(
                child: _buildRateIndicator("Open Rate", (campaign["open_rate"] as double), successColor),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildRateIndicator("Click Rate", (campaign["click_rate"] as double), infoColor),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildRateIndicator("Bounce Rate", (campaign["bounce_rate"] as double), dangerColor),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          // Budget and Spend Info
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(Icons.attach_money, size: 16, color: warningColor),
                SizedBox(width: spXs),
                Text(
                  "Budget: \$${(campaign["budget"] as double).currency} | Spent: \$${(campaign["spent"] as double).currency}",
                  style: TextStyle(
                    fontSize: 12,
                    color: warningColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: spSm),
          
          // Timestamps
          Row(
            children: [
              Icon(Icons.schedule, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Created: ${_formatTimestamp("${campaign["created_at"]}")}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              if (campaign["sent_at"] != null) ...[
                SizedBox(width: spSm),
                Icon(Icons.send, size: 16, color: disabledBoldColor),
                SizedBox(width: spXs),
                Text(
                  "Sent: ${_formatTimestamp("${campaign["sent_at"]}")}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ],
          ),
          
          SizedBox(height: spSm),
          
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: _getCampaignActionLabel("${campaign["status"]}"),
                  size: bs.sm,
                  onPressed: () {
                    _handleCampaignAction(campaign, "${campaign["status"]}");
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.analytics,
                size: bs.sm,
                onPressed: () {
                  _viewCampaignAnalytics(campaign);
                },
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {
                  _editCampaign(campaign);
                },
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  _showCampaignOptions(campaign);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCampaignMetric(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spXs),
      child: Column(
        children: [
          Icon(icon, size: 16, color: disabledBoldColor),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRateIndicator(String label, double rate, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Text(
              "${rate.toStringAsFixed(1)}%",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        SizedBox(height: spXs),
        Container(
          height: 4,
          decoration: BoxDecoration(
            color: disabledColor.withAlpha(30),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: rate / 100,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
            ),
          ),
        ),
      ],
    );
  }

  IconData _getCampaignTypeIcon(String type) {
    switch (type) {
      case "promotional":
        return Icons.local_offer;
      case "newsletter":
        return Icons.newspaper;
      case "automation":
        return Icons.auto_awesome;
      case "re-engagement":
        return Icons.refresh;
      default:
        return Icons.campaign;
    }
  }

  Color _getCampaignTypeColor(String type) {
    switch (type) {
      case "promotional":
        return warningColor;
      case "newsletter":
        return infoColor;
      case "automation":
        return successColor;
      case "re-engagement":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "completed":
        return infoColor;
      case "paused":
        return warningColor;
      case "draft":
        return disabledBoldColor;
      case "scheduled":
        return primaryColor;
      default:
        return disabledColor;
    }
  }

  String _getCampaignActionLabel(String status) {
    switch (status) {
      case "draft":
        return "Send Campaign";
      case "paused":
        return "Resume";
      case "active":
        return "Pause";
      case "scheduled":
        return "Edit Schedule";
      case "completed":
        return "Duplicate";
      default:
        return "View";
    }
  }

  double _calculateAverageOpenRate() {
    final activeCampaigns = campaigns.where((c) => c["sent"] > 0).toList();
    if (activeCampaigns.isEmpty) return 0.0;
    
    final totalOpenRate = activeCampaigns.fold(0.0, (sum, c) => sum + (c["open_rate"] as double));
    return totalOpenRate / activeCampaigns.length;
  }

  String _formatTimestamp(String timestamp) {
    try {
      final dateTime = DateTime.parse(timestamp);
      final now = DateTime.now();
      final difference = now.difference(dateTime);
      
      if (difference.inHours < 24) {
        return "${difference.inHours}h ago";
      } else if (difference.inDays < 7) {
        return "${difference.inDays}d ago";
      } else {
        return "${(difference.inDays / 7).round()}w ago";
      }
    } catch (e) {
      return timestamp;
    }
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Filter Campaigns"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CheckboxListTile(
              title: Text("High performing only"),
              value: false,
              onChanged: (value) {},
            ),
            CheckboxListTile(
              title: Text("Low budget campaigns"),
              value: false,
              onChanged: (value) {},
            ),
            CheckboxListTile(
              title: Text("Recently created"),
              value: false,
              onChanged: (value) {},
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Apply",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _showCreateCampaignDialog() {
    String campaignName = "";
    String campaignDescription = "";
    String campaignType = "promotional";
    String targetSegment = "";

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Create New Campaign"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QTextField(
              label: "Campaign Name",
              value: campaignName,
              onChanged: (value) => campaignName = value,
            ),
            SizedBox(height: spSm),
            QTextField(
              label: "Description",
              value: campaignDescription,
              onChanged: (value) => campaignDescription = value,
            ),
            SizedBox(height: spSm),
            QDropdownField(
              label: "Campaign Type",
              items: [
                {"label": "Promotional", "value": "promotional"},
                {"label": "Newsletter", "value": "newsletter"},
                {"label": "Automation", "value": "automation"},
                {"label": "Re-engagement", "value": "re-engagement"},
              ],
              value: campaignType,
              onChanged: (value, label) => campaignType = value,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Create",
            size: bs.sm,
            onPressed: () {
              if (campaignName.isNotEmpty) {
                Navigator.pop(context);
                _createCampaign(campaignName, campaignDescription, campaignType);
              }
            },
          ),
        ],
      ),
    );
  }

  void _handleCampaignAction(Map<String, dynamic> campaign, String status) {
    switch (status) {
      case "draft":
        _sendCampaign(campaign);
        break;
      case "paused":
        _resumeCampaign(campaign);
        break;
      case "active":
        _pauseCampaign(campaign);
        break;
      case "scheduled":
        _editSchedule(campaign);
        break;
      case "completed":
        _duplicateCampaign(campaign);
        break;
      default:
        _viewCampaign(campaign);
    }
  }

  void _viewCampaignAnalytics(Map<String, dynamic> campaign) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Campaign Analytics"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Campaign: ${campaign["name"]}", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: spSm),
              Text("Performance Metrics:", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("• Recipients: ${campaign["recipients"]}"),
              Text("• Delivered: ${campaign["delivered"]}"),
              Text("• Opened: ${campaign["opened"]} (${campaign["open_rate"]}%)"),
              Text("• Clicked: ${campaign["clicked"]} (${campaign["click_rate"]}%)"),
              Text("• Bounced: ${campaign["bounced"]} (${campaign["bounce_rate"]}%)"),
              Text("• Unsubscribed: ${campaign["unsubscribed"]}"),
              SizedBox(height: spSm),
              Text("Budget Information:", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("• Budget: \$${(campaign["budget"] as double).currency}"),
              Text("• Spent: \$${(campaign["spent"] as double).currency}"),
              Text("• Remaining: \$${((campaign["budget"] as double) - (campaign["spent"] as double)).currency}"),
            ],
          ),
        ),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _editCampaign(Map<String, dynamic> campaign) {
    ss("Campaign editor would open here");
  }

  void _showCampaignOptions(Map<String, dynamic> campaign) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.content_copy),
              title: Text("Duplicate Campaign"),
              onTap: () {
                Navigator.pop(context);
                _duplicateCampaign(campaign);
              },
            ),
            ListTile(
              leading: Icon(Icons.download),
              title: Text("Export Data"),
              onTap: () {
                Navigator.pop(context);
                _exportCampaignData(campaign);
              },
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text("Share Campaign"),
              onTap: () {
                Navigator.pop(context);
                _shareCampaign(campaign);
              },
            ),
            ListTile(
              leading: Icon(Icons.delete, color: dangerColor),
              title: Text("Delete Campaign", style: TextStyle(color: dangerColor)),
              onTap: () async {
                Navigator.pop(context);
                bool isConfirmed = await confirm("Are you sure you want to delete this campaign?");
                if (isConfirmed) {
                  _deleteCampaign(campaign);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _createCampaign(String name, String description, String type) {
    final newCampaign = {
      "id": "${campaigns.length + 1}",
      "name": name,
      "description": description,
      "status": "draft",
      "type": type,
      "recipients": 0,
      "sent": 0,
      "delivered": 0,
      "opened": 0,
      "clicked": 0,
      "bounced": 0,
      "unsubscribed": 0,
      "open_rate": 0.0,
      "click_rate": 0.0,
      "bounce_rate": 0.0,
      "created_at": DateTime.now().toString(),
      "sent_at": null,
      "budget": 1000.0,
      "spent": 0.0,
      "template_id": "",
      "segments": []
    };
    
    campaigns.insert(0, newCampaign);
    setState(() {});
    ss("Campaign created successfully");
  }

  void _sendCampaign(Map<String, dynamic> campaign) {
    campaign["status"] = "active";
    campaign["sent_at"] = DateTime.now().toString();
    setState(() {});
    ss("Campaign sent successfully");
  }

  void _pauseCampaign(Map<String, dynamic> campaign) {
    campaign["status"] = "paused";
    setState(() {});
    ss("Campaign paused");
  }

  void _resumeCampaign(Map<String, dynamic> campaign) {
    campaign["status"] = "active";
    setState(() {});
    ss("Campaign resumed");
  }

  void _editSchedule(Map<String, dynamic> campaign) {
    ss("Schedule editor would open here");
  }

  void _viewCampaign(Map<String, dynamic> campaign) {
    ss("Campaign details would be shown here");
  }

  void _duplicateCampaign(Map<String, dynamic> campaign) {
    final duplicatedCampaign = Map<String, dynamic>.from(campaign);
    duplicatedCampaign["id"] = "${campaigns.length + 1}";
    duplicatedCampaign["name"] = "${campaign["name"]} (Copy)";
    duplicatedCampaign["status"] = "draft";
    duplicatedCampaign["sent"] = 0;
    duplicatedCampaign["delivered"] = 0;
    duplicatedCampaign["opened"] = 0;
    duplicatedCampaign["clicked"] = 0;
    duplicatedCampaign["bounced"] = 0;
    duplicatedCampaign["unsubscribed"] = 0;
    duplicatedCampaign["spent"] = 0.0;
    duplicatedCampaign["created_at"] = DateTime.now().toString();
    duplicatedCampaign["sent_at"] = null;
    
    campaigns.insert(0, duplicatedCampaign);
    setState(() {});
    ss("Campaign duplicated successfully");
  }

  void _exportCampaignData(Map<String, dynamic> campaign) {
    ss("Campaign data export would be implemented here");
  }

  void _shareCampaign(Map<String, dynamic> campaign) {
    ss("Campaign sharing would be implemented here");
  }

  void _deleteCampaign(Map<String, dynamic> campaign) {
    campaigns.removeWhere((c) => c["id"] == campaign["id"]);
    setState(() {});
    ss("Campaign deleted successfully");
  }
}
