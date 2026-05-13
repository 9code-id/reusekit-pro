import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaWishlistAlertsView extends StatefulWidget {
  const ReaWishlistAlertsView({super.key});

  @override
  State<ReaWishlistAlertsView> createState() => _ReaWishlistAlertsViewState();
}

class _ReaWishlistAlertsViewState extends State<ReaWishlistAlertsView> {
  List<Map<String, dynamic>> wishlistAlerts = [
    {
      "id": 1,
      "propertyTitle": "Modern Downtown Apartment",
      "alertType": "price_drop",
      "originalPrice": 850000,
      "currentPrice": 795000,
      "discount": 6.5,
      "location": "Downtown, LA",
      "bedrooms": 2,
      "bathrooms": 2,
      "area": 1200,
      "image": "https://picsum.photos/300/200?random=1&keyword=apartment",
      "alertTime": "2 hours ago",
      "isUrgent": true,
    },
    {
      "id": 2,
      "propertyTitle": "Luxury Villa with Pool",
      "alertType": "back_in_stock",
      "originalPrice": 2500000,
      "currentPrice": 2500000,
      "location": "Beverly Hills, CA",
      "bedrooms": 5,
      "bathrooms": 4,
      "area": 4500,
      "image": "https://picsum.photos/300/200?random=2&keyword=villa",
      "alertTime": "4 hours ago",
      "isUrgent": false,
    },
    {
      "id": 3,
      "propertyTitle": "Cozy Family Home",
      "alertType": "similar_property",
      "originalPrice": 650000,
      "currentPrice": 620000,
      "discount": 4.6,
      "location": "Suburban, CA",
      "bedrooms": 3,
      "bathrooms": 2,
      "area": 1800,
      "image": "https://picsum.photos/300/200?random=3&keyword=house",
      "alertTime": "1 day ago",
      "isUrgent": false,
    },
    {
      "id": 4,
      "propertyTitle": "Waterfront Condo",
      "alertType": "price_match",
      "originalPrice": 950000,
      "currentPrice": 890000,
      "discount": 6.3,
      "location": "Marina, CA",
      "bedrooms": 2,
      "bathrooms": 2,
      "area": 1400,
      "image": "https://picsum.photos/300/200?random=4&keyword=condo",
      "alertTime": "2 days ago",
      "isUrgent": true,
    },
    {
      "id": 5,
      "propertyTitle": "Penthouse Suite",
      "alertType": "open_house",
      "originalPrice": 3200000,
      "currentPrice": 3200000,
      "location": "Hollywood Hills, CA",
      "bedrooms": 4,
      "bathrooms": 3,
      "area": 3200,
      "image": "https://picsum.photos/300/200?random=5&keyword=penthouse",
      "alertTime": "3 days ago",
      "openHouseDate": "This Saturday",
      "isUrgent": false,
    },
  ];

  List<Map<String, dynamic>> alertTypes = [
    {
      "label": "All Alerts",
      "value": "all",
      "icon": Icons.notifications,
      "count": 25,
    },
    {
      "label": "Price Drops",
      "value": "price_drop",
      "icon": Icons.trending_down,
      "count": 12,
    },
    {
      "label": "Back in Stock",
      "value": "back_in_stock",
      "icon": Icons.inventory,
      "count": 5,
    },
    {
      "label": "Similar Properties",
      "value": "similar_property",
      "icon": Icons.compare,
      "count": 8,
    },
  ];

  String selectedAlertType = "all";
  bool showUrgentOnly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wishlist Alerts"),
        actions: [
          IconButton(
            icon: Icon(Icons.tune),
            onPressed: () => _showFilterDialog(),
          ),
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () => _viewWishlist(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWishlistSummary(),
            SizedBox(height: spLg),
            _buildAlertTypeFilter(),
            SizedBox(height: spLg),
            _buildUrgentToggle(),
            SizedBox(height: spLg),
            _buildWishlistAlertsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildWishlistSummary() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFE91E63),
            Color(0xFFE91E63).withAlpha(180),
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
                Icons.favorite,
                color: Colors.white,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Wishlist Alerts",
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
                child: _buildSummaryCard("Properties", "47", Icons.home),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildSummaryCard("Active Alerts", "25", Icons.notifications_active),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildSummaryCard("Avg. Savings", "8.5%", Icons.savings),
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
              fontSize: fsH6,
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

  Widget _buildAlertTypeFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Alert Types",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        QHorizontalScroll(
          children: alertTypes.map((type) {
            bool isSelected = selectedAlertType == type["value"];
            return Container(
              margin: EdgeInsets.only(right: spSm),
              child: GestureDetector(
                onTap: () {
                  selectedAlertType = type["value"];
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
                        type["icon"] as IconData,
                        color: isSelected ? Colors.white : disabledBoldColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${type["label"]}",
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
                          "${type["count"]}",
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

  Widget _buildUrgentToggle() {
    return Row(
      children: [
        Icon(
          Icons.priority_high,
          color: dangerColor,
          size: 20,
        ),
        SizedBox(width: spXs),
        Text(
          "Show Urgent Alerts Only",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
        Spacer(),
        Switch(
          value: showUrgentOnly,
          onChanged: (value) {
            showUrgentOnly = value;
            setState(() {});
          },
          activeColor: dangerColor,
        ),
      ],
    );
  }

  Widget _buildWishlistAlertsList() {
    List<Map<String, dynamic>> filteredAlerts = wishlistAlerts.where((alert) {
      if (showUrgentOnly && !(alert["isUrgent"] as bool)) return false;
      if (selectedAlertType != "all" && alert["alertType"] != selectedAlertType) return false;
      return true;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Recent Alerts",
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
        ...filteredAlerts.map((alert) => _buildWishlistAlertCard(alert)).toList(),
      ],
    );
  }

  Widget _buildWishlistAlertCard(Map<String, dynamic> alert) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Property Image
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
              image: DecorationImage(
                image: NetworkImage("${alert["image"]}"),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: spSm,
                  left: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: _getAlertTypeColor(alert["alertType"]),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      _getAlertTypeLabel(alert["alertType"]),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                if (alert["isUrgent"] as bool)
                  Positioned(
                    top: spSm,
                    right: spSm,
                    child: Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: dangerColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Icon(
                        Icons.priority_high,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                if (alert.containsKey("discount") && (alert["discount"] as double) > 0)
                  Positioned(
                    bottom: spSm,
                    right: spSm,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: successColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "-${(alert["discount"] as double).toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          
          // Property Details
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: disabledBoldColor,
                                size: 14,
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${alert["location"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "${alert["alertTime"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                // Property Specs
                Row(
                  children: [
                    _buildSpecItem(Icons.bed, "${alert["bedrooms"]} Bed"),
                    SizedBox(width: spMd),
                    _buildSpecItem(Icons.bathroom, "${alert["bathrooms"]} Bath"),
                    SizedBox(width: spMd),
                    _buildSpecItem(Icons.square_foot, "${alert["area"]} sqft"),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                // Price Information
                Row(
                  children: [
                    if (alert.containsKey("discount") && (alert["discount"] as double) > 0)
                      Text(
                        "\$${(alert["originalPrice"] as int).currency}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    if (alert.containsKey("discount") && (alert["discount"] as double) > 0)
                      SizedBox(width: spXs),
                    Text(
                      "\$${(alert["currentPrice"] as int).currency}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    if (alert.containsKey("openHouseDate"))
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${alert["openHouseDate"]}",
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
                
                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "View Details",
                        size: bs.sm,
                        onPressed: () => _viewPropertyDetails(alert),
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.favorite,
                      size: bs.sm,
                      onPressed: () => _removeFromWishlist(alert),
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      icon: Icons.share,
                      size: bs.sm,
                      onPressed: () => _shareProperty(alert),
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

  Widget _buildSpecItem(IconData icon, String text) {
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
          text,
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Color _getAlertTypeColor(String alertType) {
    switch (alertType) {
      case "price_drop":
        return successColor;
      case "back_in_stock":
        return infoColor;
      case "similar_property":
        return warningColor;
      case "price_match":
        return primaryColor;
      case "open_house":
        return Color(0xFF9C27B0);
      default:
        return disabledBoldColor;
    }
  }

  String _getAlertTypeLabel(String alertType) {
    switch (alertType) {
      case "price_drop":
        return "Price Drop";
      case "back_in_stock":
        return "Back in Stock";
      case "similar_property":
        return "Similar Property";
      case "price_match":
        return "Price Match";
      case "open_house":
        return "Open House";
      default:
        return "Alert";
    }
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Filter Alerts",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            // Filter options implementation
          ],
        ),
      ),
    );
  }

  void _viewWishlist() {
    // Navigate to full wishlist
  }

  void _viewPropertyDetails(Map<String, dynamic> property) {
    // Navigate to property details
  }

  void _removeFromWishlist(Map<String, dynamic> property) {
    // Remove property from wishlist
    ss("Property removed from wishlist");
  }

  void _shareProperty(Map<String, dynamic> property) {
    // Share property functionality
    si("Property shared successfully");
  }
}
