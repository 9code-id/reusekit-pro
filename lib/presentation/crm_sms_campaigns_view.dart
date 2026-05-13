import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmSmsCampaignsView extends StatefulWidget {
  const CrmSmsCampaignsView({super.key});

  @override
  State<CrmSmsCampaignsView> createState() => _CrmSmsCampaignsViewState();
}

class _CrmSmsCampaignsViewState extends State<CrmSmsCampaignsView> {
  String searchQuery = "";
  String selectedStatus = "all";
  String selectedType = "all";
  bool loading = false;

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Draft", "value": "draft"},
    {"label": "Scheduled", "value": "scheduled"},
    {"label": "Sending", "value": "sending"},
    {"label": "Sent", "value": "sent"},
    {"label": "Completed", "value": "completed"},
    {"label": "Failed", "value": "failed"},
  ];

  List<Map<String, dynamic>> typeOptions = [
    {"label": "All Types", "value": "all"},
    {"label": "Promotional", "value": "promotional"},
    {"label": "Transactional", "value": "transactional"},
    {"label": "Reminder", "value": "reminder"},
    {"label": "Alert", "value": "alert"},
    {"label": "Survey", "value": "survey"},
  ];

  List<Map<String, dynamic>> smsCampaigns = [
    {
      "id": "sms_001",
      "name": "Summer Sale SMS Blast",
      "type": "promotional",
      "status": "completed",
      "message": "🌞 Summer Sale Alert! Get 30% off on all items. Use code SUMMER30. Shop now: link.co/sale",
      "recipients": 15420,
      "delivered": 15385,
      "clicked": 1847,
      "unsubscribed": 23,
      "failed": 35,
      "createdAt": "2024-06-15T09:00:00Z",
      "sentAt": "2024-06-15T10:30:00Z",
      "completedAt": "2024-06-15T11:15:00Z",
      "budget": 924.00,
      "cost": 923.10,
      "deliveryRate": 99.77,
      "clickRate": 12.0,
      "optOutRate": 0.15,
      "tags": ["summer", "sale", "promotional"],
    },
    {
      "id": "sms_002",
      "name": "Order Confirmation Alerts",
      "type": "transactional",
      "status": "sending",
      "message": "Hi {name}, your order #{order_id} has been confirmed. Total: \${amount}. Track: link.co/track",
      "recipients": 2847,
      "delivered": 2821,
      "clicked": 312,
      "unsubscribed": 0,
      "failed": 26,
      "createdAt": "2024-06-18T14:20:00Z",
      "sentAt": "2024-06-18T14:25:00Z",
      "completedAt": null,
      "budget": 170.82,
      "cost": 169.26,
      "deliveryRate": 99.09,
      "clickRate": 11.06,
      "optOutRate": 0.0,
      "tags": ["order", "confirmation", "transactional"],
    },
    {
      "id": "sms_003",
      "name": "Product Launch Announcement",
      "type": "promotional",
      "status": "scheduled",
      "message": "🚀 Exciting News! Our new product is launching tomorrow. Be the first to get it with early bird pricing: link.co/launch",
      "recipients": 8735,
      "delivered": 0,
      "clicked": 0,
      "unsubscribed": 0,
      "failed": 0,
      "createdAt": "2024-06-19T16:30:00Z",
      "sentAt": null,
      "completedAt": null,
      "budget": 524.10,
      "cost": 0.0,
      "deliveryRate": 0.0,
      "clickRate": 0.0,
      "optOutRate": 0.0,
      "tags": ["product", "launch", "announcement"],
    },
    {
      "id": "sms_004",
      "name": "Payment Reminder Campaign",
      "type": "reminder",
      "status": "sent",
      "message": "Reminder: Your payment of \${amount} is due on {due_date}. Pay now to avoid late fees: link.co/pay",
      "recipients": 1247,
      "delivered": 1235,
      "clicked": 892,
      "unsubscribed": 5,
      "failed": 12,
      "createdAt": "2024-06-17T11:15:00Z",
      "sentAt": "2024-06-17T12:00:00Z",
      "completedAt": "2024-06-17T12:45:00Z",
      "budget": 74.82,
      "cost": 74.10,
      "deliveryRate": 99.04,
      "clickRate": 72.23,
      "optOutRate": 0.40,
      "tags": ["payment", "reminder", "billing"],
    },
    {
      "id": "sms_005",
      "name": "Customer Satisfaction Survey",
      "type": "survey",
      "status": "draft",
      "message": "We value your feedback! Please take 2 minutes to rate your recent experience with us: link.co/survey",
      "recipients": 5200,
      "delivered": 0,
      "clicked": 0,
      "unsubscribed": 0,
      "failed": 0,
      "createdAt": "2024-06-19T13:45:00Z",
      "sentAt": null,
      "completedAt": null,
      "budget": 312.00,
      "cost": 0.0,
      "deliveryRate": 0.0,
      "clickRate": 0.0,
      "optOutRate": 0.0,
      "tags": ["survey", "feedback", "customer"],
    },
  ];

  List<Map<String, dynamic>> get filteredCampaigns {
    return smsCampaigns.where((campaign) {
      bool matchesSearch = campaign["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          campaign["message"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "all" || campaign["status"] == selectedStatus;
      bool matchesType = selectedType == "all" || campaign["type"] == selectedType;
      
      return matchesSearch && matchesStatus && matchesType;
    }).toList();
  }

  Map<String, dynamic> get campaignStats {
    int totalCampaigns = smsCampaigns.length;
    int activeCampaigns = smsCampaigns.where((c) => c["status"] == "sending" || c["status"] == "scheduled").length;
    int totalSent = smsCampaigns.fold(0, (sum, c) => sum + (c["delivered"] as int));
    double totalBudget = smsCampaigns.fold(0.0, (sum, c) => sum + (c["budget"] as double));
    double totalCost = smsCampaigns.fold(0.0, (sum, c) => sum + (c["cost"] as double));
    double avgDeliveryRate = smsCampaigns.where((c) => c["delivered"] > 0)
        .fold(0.0, (sum, c) => sum + (c["deliveryRate"] as double)) / 
        smsCampaigns.where((c) => c["delivered"] > 0).length;
    
    return {
      "totalCampaigns": totalCampaigns,
      "activeCampaigns": activeCampaigns,
      "totalSent": totalSent,
      "totalBudget": totalBudget,
      "totalCost": totalCost,
      "avgDeliveryRate": avgDeliveryRate.isNaN ? 0.0 : avgDeliveryRate,
    };
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "draft":
        return disabledColor;
      case "scheduled":
        return warningColor;
      case "sending":
        return infoColor;
      case "sent":
        return primaryColor;
      case "completed":
        return successColor;
      case "failed":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "promotional":
        return primaryColor;
      case "transactional":
        return successColor;
      case "reminder":
        return warningColor;
      case "alert":
        return dangerColor;
      case "survey":
        return infoColor;
      default:
        return disabledColor;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case "draft":
        return "Draft";
      case "scheduled":
        return "Scheduled";
      case "sending":
        return "Sending";
      case "sent":
        return "Sent";
      case "completed":
        return "Completed";
      case "failed":
        return "Failed";
      default:
        return "Unknown";
    }
  }

  String _getTypeLabel(String type) {
    switch (type) {
      case "promotional":
        return "Promotional";
      case "transactional":
        return "Transactional";
      case "reminder":
        return "Reminder";
      case "alert":
        return "Alert";
      case "survey":
        return "Survey";
      default:
        return "Unknown";
    }
  }

  void _createNewCampaign() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String campaignName = "";
        String campaignType = "promotional";
        String message = "";
        String recipients = "";
        
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(
                "Create SMS Campaign",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    QTextField(
                      label: "Campaign Name",
                      value: campaignName,
                      hint: "Enter campaign name",
                      onChanged: (value) {
                        campaignName = value;
                        setDialogState(() {});
                      },
                    ),
                    SizedBox(height: spSm),
                    QDropdownField(
                      label: "Campaign Type",
                      items: typeOptions.where((t) => t["value"] != "all").toList(),
                      value: campaignType,
                      onChanged: (value, label) {
                        campaignType = value;
                        setDialogState(() {});
                      },
                    ),
                    SizedBox(height: spSm),
                    QMemoField(
                      label: "SMS Message",
                      value: message,
                      hint: "Enter your SMS message (max 160 characters)",
                      onChanged: (value) {
                        message = value;
                        setDialogState(() {});
                      },
                    ),
                    SizedBox(height: spSm),
                    QTextField(
                      label: "Number of Recipients",
                      value: recipients,
                      hint: "Enter number of recipients",
                      onChanged: (value) {
                        recipients = value;
                        setDialogState(() {});
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                QButton(
                  label: "Cancel",
                  size: bs.sm,
                  onPressed: () => Navigator.of(context).pop(),
                ),
                QButton(
                  label: "Create Campaign",
                  size: bs.sm,
                  onPressed: () {
                    if (campaignName.isNotEmpty && message.isNotEmpty) {
                      Navigator.of(context).pop();
                      ss("SMS campaign '$campaignName' created successfully");
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _viewCampaignDetails(Map<String, dynamic> campaign) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Campaign Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDetailRow("Name", "${campaign["name"]}"),
                _buildDetailRow("Type", _getTypeLabel("${campaign["type"]}")),
                _buildDetailRow("Status", _getStatusLabel("${campaign["status"]}")),
                SizedBox(height: spSm),
                Text(
                  "Message:",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: disabledColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${campaign["message"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                    ),
                  ),
                ),
                SizedBox(height: spSm),
                _buildDetailRow("Recipients", "${campaign["recipients"]}"),
                _buildDetailRow("Delivered", "${campaign["delivered"]}"),
                _buildDetailRow("Clicked", "${campaign["clicked"]}"),
                _buildDetailRow("Failed", "${campaign["failed"]}"),
                _buildDetailRow("Budget", "\$${(campaign["budget"] as double).toStringAsFixed(2)}"),
                _buildDetailRow("Cost", "\$${(campaign["cost"] as double).toStringAsFixed(2)}"),
                _buildDetailRow("Delivery Rate", "${(campaign["deliveryRate"] as double).toStringAsFixed(2)}%"),
                _buildDetailRow("Click Rate", "${(campaign["clickRate"] as double).toStringAsFixed(2)}%"),
              ],
            ),
          ),
          actions: [
            QButton(
              label: "Close",
              size: bs.sm,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              "$label:",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _deleteCampaign(Map<String, dynamic> campaign) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this SMS campaign?");
    if (isConfirmed) {
      setState(() {
        smsCampaigns.removeWhere((c) => c["id"] == campaign["id"]);
      });
      ss("SMS campaign deleted successfully");
    }
  }

  void _duplicateCampaign(Map<String, dynamic> campaign) {
    Map<String, dynamic> newCampaign = Map.from(campaign);
    newCampaign["id"] = "sms_${DateTime.now().millisecondsSinceEpoch}";
    newCampaign["name"] = "${campaign["name"]} (Copy)";
    newCampaign["status"] = "draft";
    newCampaign["delivered"] = 0;
    newCampaign["clicked"] = 0;
    newCampaign["failed"] = 0;
    newCampaign["cost"] = 0.0;
    newCampaign["sentAt"] = null;
    newCampaign["completedAt"] = null;
    
    setState(() {
      smsCampaigns.insert(0, newCampaign);
    });
    ss("SMS campaign duplicated successfully");
  }

  @override
  Widget build(BuildContext context) {
    final stats = campaignStats;
    
    return Scaffold(
      appBar: AppBar(
        title: Text("SMS Campaigns"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _createNewCampaign,
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "SMS Campaign Overview",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: [
                      _buildStatCard(
                        "Total Campaigns",
                        "${stats["totalCampaigns"]}",
                        Icons.campaign,
                        primaryColor,
                      ),
                      _buildStatCard(
                        "Active Campaigns",
                        "${stats["activeCampaigns"]}",
                        Icons.trending_up,
                        successColor,
                      ),
                      _buildStatCard(
                        "Messages Sent",
                        "${(stats["totalSent"] as int).toString()}",
                        Icons.send,
                        infoColor,
                      ),
                      _buildStatCard(
                        "Avg Delivery Rate",
                        "${(stats["avgDeliveryRate"] as double).toStringAsFixed(1)}%",
                        Icons.done_all,
                        warningColor,
                      ),
                    ],
                  ),
                  SizedBox(height: spLg),
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search campaigns...",
                          value: searchQuery,
                          hint: "Search by name or message",
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
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Filter by Status",
                          items: statusOptions,
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
                          label: "Filter by Type",
                          items: typeOptions,
                          value: selectedType,
                          onChanged: (value, label) {
                            selectedType = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spLg),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "SMS Campaigns (${filteredCampaigns.length})",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      QButton(
                        label: "Create Campaign",
                        size: bs.sm,
                        onPressed: _createNewCampaign,
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredCampaigns.length,
                    itemBuilder: (context, index) {
                      final campaign = filteredCampaigns[index];
                      return _buildCampaignCard(campaign);
                    },
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "SMS",
                  style: TextStyle(
                    fontSize: 10,
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCampaignCard(Map<String, dynamic> campaign) {
    Color statusColor = _getStatusColor("${campaign["status"]}");
    Color typeColor = _getTypeColor("${campaign["type"]}");
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
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
                    Text(
                      "${campaign["name"]}",
                      style: TextStyle(
                        fontSize: 16,
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
                            color: typeColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            _getTypeLabel("${campaign["type"]}"),
                            style: TextStyle(
                              fontSize: 10,
                              color: typeColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            _getStatusLabel("${campaign["status"]}"),
                            style: TextStyle(
                              fontSize: 10,
                              color: statusColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                icon: Icon(Icons.more_vert, color: disabledBoldColor),
                onSelected: (value) {
                  switch (value) {
                    case 'view':
                      _viewCampaignDetails(campaign);
                      break;
                    case 'duplicate':
                      _duplicateCampaign(campaign);
                      break;
                    case 'delete':
                      _deleteCampaign(campaign);
                      break;
                  }
                },
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(value: 'view', child: Text('View Details')),
                  PopupMenuItem(value: 'duplicate', child: Text('Duplicate')),
                  PopupMenuItem(value: 'delete', child: Text('Delete')),
                ],
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "${campaign["message"]}",
              style: TextStyle(
                fontSize: 13,
                color: disabledBoldColor,
                fontStyle: FontStyle.italic,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Recipients: ${campaign["recipients"]} | Delivered: ${campaign["delivered"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Budget: \$${(campaign["budget"] as double).toStringAsFixed(2)} | Cost: \$${(campaign["cost"] as double).toStringAsFixed(2)}",
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
                    "Delivery: ${(campaign["deliveryRate"] as double).toStringAsFixed(1)}%",
                    style: TextStyle(
                      fontSize: 12,
                      color: successColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Click: ${(campaign["clickRate"] as double).toStringAsFixed(1)}%",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
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
}
