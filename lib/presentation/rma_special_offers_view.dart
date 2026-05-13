import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaSpecialOffersView extends StatefulWidget {
  const RmaSpecialOffersView({super.key});

  @override
  State<RmaSpecialOffersView> createState() => _RmaSpecialOffersViewState();
}

class _RmaSpecialOffersViewState extends State<RmaSpecialOffersView> {
  String selectedStatus = "all";
  String selectedType = "all";
  
  List<Map<String, dynamic>> specialOffers = [
    {
      "id": "offer_1",
      "title": "Happy Hour 50% Off",
      "description": "50% discount on all beverages during happy hour",
      "type": "percentage",
      "value": 50.0,
      "status": "active",
      "startDate": "2025-06-01T15:00:00Z",
      "endDate": "2025-06-30T18:00:00Z",
      "applicableItems": ["beverages"],
      "minOrderAmount": 0.0,
      "usageCount": 245,
      "maxUsage": 1000,
      "daysOfWeek": ["monday", "tuesday", "wednesday", "thursday", "friday"],
      "color": successColor,
    },
    {
      "id": "offer_2",
      "title": "Buy 2 Get 1 Free Pizza",
      "description": "Get one pizza free when you buy two pizzas",
      "type": "buy_x_get_y",
      "buyQuantity": 2,
      "getQuantity": 1,
      "status": "active",
      "startDate": "2025-06-15T00:00:00Z",
      "endDate": "2025-07-15T23:59:59Z",
      "applicableItems": ["pizzas"],
      "minOrderAmount": 25.0,
      "usageCount": 89,
      "maxUsage": 500,
      "daysOfWeek": ["saturday", "sunday"],
      "color": primaryColor,
    },
    {
      "id": "offer_3",
      "title": "\$5 Off Orders Over \$30",
      "description": "Get \$5 discount on orders over \$30",
      "type": "fixed_amount",
      "value": 5.0,
      "status": "active",
      "startDate": "2025-06-10T00:00:00Z",
      "endDate": "2025-06-25T23:59:59Z",
      "applicableItems": ["all"],
      "minOrderAmount": 30.0,
      "usageCount": 156,
      "maxUsage": 2000,
      "daysOfWeek": ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"],
      "color": warningColor,
    },
    {
      "id": "offer_4",
      "title": "Free Dessert with Entree",
      "description": "Get a free dessert when you order any entree",
      "type": "combo",
      "status": "scheduled",
      "startDate": "2025-06-20T00:00:00Z",
      "endDate": "2025-07-20T23:59:59Z",
      "applicableItems": ["entrees", "desserts"],
      "minOrderAmount": 15.0,
      "usageCount": 0,
      "maxUsage": 300,
      "daysOfWeek": ["friday", "saturday", "sunday"],
      "color": infoColor,
    },
    {
      "id": "offer_5",
      "title": "30% Off Appetizers",
      "description": "30% discount on all appetizers",
      "type": "percentage",
      "value": 30.0,
      "status": "expired",
      "startDate": "2025-05-01T00:00:00Z",
      "endDate": "2025-05-31T23:59:59Z",
      "applicableItems": ["appetizers"],
      "minOrderAmount": 0.0,
      "usageCount": 421,
      "maxUsage": 500,
      "daysOfWeek": ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"],
      "color": disabledBoldColor,
    },
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Scheduled", "value": "scheduled"},
    {"label": "Expired", "value": "expired"},
    {"label": "Paused", "value": "paused"},
  ];

  List<Map<String, dynamic>> typeOptions = [
    {"label": "All Types", "value": "all"},
    {"label": "Percentage Discount", "value": "percentage"},
    {"label": "Fixed Amount", "value": "fixed_amount"},
    {"label": "Buy X Get Y", "value": "buy_x_get_y"},
    {"label": "Combo Deals", "value": "combo"},
  ];

  Widget _buildOffersOverview() {
    final activeOffers = specialOffers.where((offer) => offer["status"] == "active").length;
    final scheduledOffers = specialOffers.where((offer) => offer["status"] == "scheduled").length;
    final totalUsage = specialOffers.fold(0, (sum, offer) => sum + (offer["usageCount"] as int));
    final avgUsage = totalUsage / specialOffers.length;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Offers Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            minItemWidth: 200,
            children: [
              _buildOverviewCard(
                "Active Offers",
                "$activeOffers",
                Icons.local_offer,
                successColor,
              ),
              _buildOverviewCard(
                "Scheduled",
                "$scheduledOffers",
                Icons.schedule,
                infoColor,
              ),
              _buildOverviewCard(
                "Total Usage",
                "$totalUsage",
                Icons.trending_up,
                primaryColor,
              ),
              _buildOverviewCard(
                "Avg Usage",
                "${avgUsage.toInt()}",
                Icons.analytics,
                warningColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 32,
          ),
          SizedBox(height: spSm),
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
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
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
          SizedBox(width: spSm),
          QButton(
            label: "Create Offer",
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {
              //navigateTo('RmaCreateSpecialOfferView')
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOfferCard(Map<String, dynamic> offer) {
    final usagePercentage = (offer["usageCount"] as int) / (offer["maxUsage"] as int) * 100;
    final statusColor = _getStatusColor(offer["status"] as String);
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: offer["color"] as Color,
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
                        Text(
                          "${offer["title"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            "${offer["status"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: statusColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${offer["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  QButton(
                    icon: Icons.edit,
                    size: bs.sm,
                    onPressed: () {
                      //navigateTo('RmaEditSpecialOfferView')
                    },
                  ),
                  SizedBox(height: spSm),
                  QButton(
                    icon: offer["status"] == "active" ? Icons.pause : Icons.play_arrow,
                    size: bs.sm,
                    onPressed: () {
                      //navigateTo('RmaToggleOfferView')
                    },
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spMd),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    _buildOfferDetail("Type", _getOfferTypeDisplay(offer)),
                    _buildOfferDetail("Min Order", "\$${((offer["minOrderAmount"] as double)).currency}"),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    _buildOfferDetail("Start Date", DateTime.parse(offer["startDate"] as String).dMMMy),
                    _buildOfferDetail("End Date", DateTime.parse(offer["endDate"] as String).dMMMy),
                  ],
                ),
                SizedBox(height: spSm),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Usage: ${offer["usageCount"]}/${offer["maxUsage"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${usagePercentage.toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Container(
                      height: 4,
                      decoration: BoxDecoration(
                        color: disabledColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: usagePercentage / 100,
                        child: Container(
                          decoration: BoxDecoration(
                            color: offer["color"] as Color,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Text(
                      "Days: ",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        (offer["daysOfWeek"] as List).map((day) => day.toString().substring(0, 3).toUpperCase()).join(", "),
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOfferDetail(String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "scheduled":
        return infoColor;
      case "expired":
        return disabledBoldColor;
      case "paused":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getOfferTypeDisplay(Map<String, dynamic> offer) {
    switch (offer["type"]) {
      case "percentage":
        return "${(offer["value"] as double).toInt()}% Off";
      case "fixed_amount":
        return "\$${(offer["value"] as double).toStringAsFixed(0)} Off";
      case "buy_x_get_y":
        return "Buy ${offer["buyQuantity"]} Get ${offer["getQuantity"]}";
      case "combo":
        return "Combo Deal";
      default:
        return "Unknown";
    }
  }

  List<Map<String, dynamic>> get filteredOffers {
    return specialOffers.where((offer) {
      if (selectedStatus != "all" && offer["status"] != selectedStatus) {
        return false;
      }
      if (selectedType != "all" && offer["type"] != selectedType) {
        return false;
      }
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Special Offers"),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              //navigateTo('RmaOffersAnalyticsView')
            },
          ),
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              //navigateTo('RmaOffersHistoryView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildOffersOverview(),
            _buildFilters(),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Active & Scheduled Offers (${filteredOffers.length})",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  if (filteredOffers.isEmpty)
                    Container(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        children: [
                          Icon(
                            Icons.local_offer,
                            size: 64,
                            color: disabledColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "No offers found",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Create your first special offer to boost sales",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Column(
                      children: filteredOffers.map((offer) => _buildOfferCard(offer)).toList(),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
