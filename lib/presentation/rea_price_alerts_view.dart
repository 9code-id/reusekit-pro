import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaPriceAlertsView extends StatefulWidget {
  const ReaPriceAlertsView({super.key});

  @override
  State<ReaPriceAlertsView> createState() => _ReaPriceAlertsViewState();
}

class _ReaPriceAlertsViewState extends State<ReaPriceAlertsView> {
  List<Map<String, dynamic>> priceAlerts = [
    {
      "id": 1,
      "propertyTitle": "Sunset Boulevard Villa",
      "location": "West Hollywood, CA",
      "targetPrice": 1200000,
      "currentPrice": 1350000,
      "difference": -150000,
      "percentage": -11.1,
      "alertType": "price_drop",
      "isActive": true,
      "dateCreated": "2024-01-15",
      "lastTriggered": "2 hours ago",
      "image": "https://picsum.photos/300/200?random=1&keyword=villa",
      "bedrooms": 4,
      "bathrooms": 3,
      "area": 2800,
      "propertyType": "Villa",
    },
    {
      "id": 2,
      "propertyTitle": "Downtown Loft Apartment",
      "location": "Downtown, LA",
      "targetPrice": 750000,
      "currentPrice": 820000,
      "difference": 70000,
      "percentage": 9.3,
      "alertType": "price_increase",
      "isActive": true,
      "dateCreated": "2024-01-10",
      "lastTriggered": "5 hours ago",
      "image": "https://picsum.photos/300/200?random=2&keyword=loft",
      "bedrooms": 2,
      "bathrooms": 2,
      "area": 1400,
      "propertyType": "Apartment",
    },
    {
      "id": 3,
      "propertyTitle": "Beachfront Condo",
      "location": "Santa Monica, CA",
      "targetPrice": 950000,
      "currentPrice": 950000,
      "difference": 0,
      "percentage": 0,
      "alertType": "price_match",
      "isActive": true,
      "dateCreated": "2024-01-20",
      "lastTriggered": "1 day ago",
      "image": "https://picsum.photos/300/200?random=3&keyword=beach",
      "bedrooms": 3,
      "bathrooms": 2,
      "area": 1600,
      "propertyType": "Condo",
    },
    {
      "id": 4,
      "propertyTitle": "Mountain View House",
      "location": "Malibu, CA",
      "targetPrice": 2000000,
      "currentPrice": 2150000,
      "difference": 150000,
      "percentage": 7.5,
      "alertType": "price_increase",
      "isActive": false,
      "dateCreated": "2024-01-05",
      "lastTriggered": "3 days ago",
      "image": "https://picsum.photos/300/200?random=4&keyword=mountain",
      "bedrooms": 5,
      "bathrooms": 4,
      "area": 3500,
      "propertyType": "House",
    },
    {
      "id": 5,
      "propertyTitle": "City Center Penthouse",
      "location": "Century City, CA",
      "targetPrice": 3500000,
      "currentPrice": 3200000,
      "difference": -300000,
      "percentage": -8.6,
      "alertType": "price_drop",
      "isActive": true,
      "dateCreated": "2024-01-25",
      "lastTriggered": "4 days ago",
      "image": "https://picsum.photos/300/200?random=5&keyword=penthouse",
      "bedrooms": 4,
      "bathrooms": 3,
      "area": 2800,
      "propertyType": "Penthouse",
    },
  ];

  List<Map<String, dynamic>> alertFilters = [
    {
      "label": "All Alerts",
      "value": "all",
      "icon": Icons.notifications,
      "count": 24,
    },
    {
      "label": "Price Drops",
      "value": "price_drop",
      "icon": Icons.trending_down,
      "count": 15,
    },
    {
      "label": "Price Increases",
      "value": "price_increase",
      "icon": Icons.trending_up,
      "count": 6,
    },
    {
      "label": "Price Matches",
      "value": "price_match",
      "icon": Icons.check_circle,
      "count": 3,
    },
  ];

  String selectedFilter = "all";
  bool showActiveOnly = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Price Alerts"),
        actions: [
          IconButton(
            icon: Icon(Icons.add_alert),
            onPressed: () => _createPriceAlert(),
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => _showAlertSettings(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPriceAlertSummary(),
            SizedBox(height: spLg),
            _buildPriceAlertFilters(),
            SizedBox(height: spLg),
            _buildActiveToggle(),
            SizedBox(height: spLg),
            _buildPriceAlertsList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createPriceAlert(),
        backgroundColor: primaryColor,
        child: Icon(Icons.add),
      ),
    );
  }
  Widget _buildPriceAlertSummary() {
    int activealerts = priceAlerts.where((alert) => alert["isActive"] as bool).length;
    double totalSavings = priceAlerts
        .where((alert) => (alert["difference"] as int) < 0)
        .fold(0.0, (sum, alert) => sum + (alert["difference"] as int).abs().toDouble());

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF4CAF50),
            Color(0xFF4CAF50).withAlpha(180),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.trending_down,
                color: Colors.white,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Price Alert Dashboard",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: _buildSummaryCard("Active Alerts", "$activealerts", Icons.notifications_active),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildSummaryCard("Total Saved", "\$${totalSavings.currency}", Icons.savings),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildSummaryCard("Avg. Drop", "7.2%", Icons.trending_down),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(51),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withAlpha(204),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceAlertFilters() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Filter by Alert Type",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        QHorizontalScroll(
          children: alertFilters.map((filter) {
            bool isSelected = selectedFilter == filter["value"];
            return Container(
              margin: EdgeInsets.only(right: spSm),
              child: GestureDetector(
                onTap: () {
                  selectedFilter = filter["value"];
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor : Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: isSelected ? primaryColor : disabledOutlineBorderColor,
                    ),
                    boxShadow: isSelected ? [shadowSm] : [],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        filter["icon"] as IconData,
                        color: isSelected ? Colors.white : disabledBoldColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${filter["label"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spXs),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: isSelected 
                              ? Colors.white.withAlpha(51) 
                              : disabledColor.withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${filter["count"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildActiveToggle() {
    return Row(
      children: [
        Icon(
          Icons.filter_alt,
          color: primaryColor,
          size: 20,
        ),
        SizedBox(width: spXs),
        Text(
          "Show Active Alerts Only",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
        Spacer(),
        Switch(
          value: showActiveOnly,
          onChanged: (value) {
            showActiveOnly = value;
            setState(() {});
          },
          activeColor: primaryColor,
        ),
      ],
    );
  }

  Widget _buildPriceAlertsList() {
    List<Map<String, dynamic>> filteredAlerts = priceAlerts.where((alert) {
      if (showActiveOnly && !(alert["isActive"] as bool)) return false;
      if (selectedFilter != "all" && alert["alertType"] != selectedFilter) return false;
      return true;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Your Price Alerts",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            Text(
              "${filteredAlerts.length} alerts",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
        SizedBox(height: spSm),
        ...filteredAlerts.map((alert) => _buildPriceAlertCard(alert)).toList(),
      ],
    );
  }

  Widget _buildPriceAlertCard(Map<String, dynamic> alert) {
    Color alertColor = _getAlertColor(alert["alertType"]);
    IconData alertIcon = _getAlertIcon(alert["alertType"]);

    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: alertColor,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Alert Header
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: alertColor.withAlpha(51),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    alertIcon,
                    color: alertColor,
                    size: 20,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${alert["propertyTitle"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: disabledBoldColor,
                            size: 14,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${alert["location"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: (alert["isActive"] as bool) 
                        ? successColor.withAlpha(51) 
                        : disabledColor.withAlpha(51),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    (alert["isActive"] as bool) ? "Active" : "Paused",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: (alert["isActive"] as bool) ? successColor : disabledBoldColor,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: spMd),

            // Property Details
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      _buildPropertySpec(Icons.bed, "${alert["bedrooms"]}"),
                      SizedBox(width: spSm),
                      _buildPropertySpec(Icons.bathroom, "${alert["bathrooms"]}"),
                      SizedBox(width: spSm),
                      _buildPropertySpec(Icons.square_foot, "${alert["area"]}"),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(51),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${alert["propertyType"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: infoColor,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: spMd),

            // Price Information
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: alertColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Target Price:",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),                      Text(
                        "\$${((alert["targetPrice"] as int).toDouble()).currency}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Text(
                        "Current Price:",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),                      Text(
                        "\$${((alert["currentPrice"] as int).toDouble()).currency}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Divider(height: 1),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Text(
                        "Difference:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Row(
                        children: [                          Text(
                            "${(alert["difference"] as int) >= 0 ? '+' : ''}\$${((alert["difference"] as int).abs().toDouble()).currency}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: alertColor,
                            ),
                          ),
                          SizedBox(width: spXs),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: alertColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),                            child: Text(
                              "${(alert["percentage"] as num) >= 0 ? '+' : ''}${(alert["percentage"] as num).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Alert Information
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Created: ${alert["dateCreated"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
                Text(
                  "Last triggered: ${alert["lastTriggered"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),

            SizedBox(height: spMd),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "View Property",
                    size: bs.sm,
                    onPressed: () => _viewProperty(alert),
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: (alert["isActive"] as bool) ? Icons.pause : Icons.play_arrow,
                  size: bs.sm,
                  onPressed: () => _toggleAlert(alert),
                ),
                SizedBox(width: spXs),
                QButton(
                  icon: Icons.edit,
                  size: bs.sm,
                  onPressed: () => _editAlert(alert),
                ),
                SizedBox(width: spXs),
                QButton(
                  icon: Icons.delete,
                  size: bs.sm,
                  onPressed: () => _deleteAlert(alert),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPropertySpec(IconData icon, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: disabledBoldColor,
          size: 16,
        ),
        SizedBox(width: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Color _getAlertColor(String alertType) {
    switch (alertType) {
      case "price_drop":
        return successColor;
      case "price_increase":
        return dangerColor;
      case "price_match":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getAlertIcon(String alertType) {
    switch (alertType) {
      case "price_drop":
        return Icons.trending_down;
      case "price_increase":
        return Icons.trending_up;
      case "price_match":
        return Icons.check_circle;
      default:
        return Icons.notifications;
    }
  }

  void _createPriceAlert() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Create Price Alert",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            // Price alert creation form
          ],
        ),
      ),
    );
  }

  void _showAlertSettings() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Alert Settings",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            // Alert settings implementation
          ],
        ),
      ),
    );
  }

  void _viewProperty(Map<String, dynamic> alert) {
    // Navigate to property details
  }

  void _toggleAlert(Map<String, dynamic> alert) {
    alert["isActive"] = !(alert["isActive"] as bool);
    setState(() {});
    ss((alert["isActive"] as bool) ? "Alert activated" : "Alert paused");
  }

  void _editAlert(Map<String, dynamic> alert) {
    // Edit alert functionality
  }

  void _deleteAlert(Map<String, dynamic> alert) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this price alert?");
    if (isConfirmed) {
      priceAlerts.removeWhere((item) => item["id"] == alert["id"]);
      setState(() {});
      ss("Price alert deleted successfully");
    }
  }
}
