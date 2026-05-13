import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaMarketAlertsView extends StatefulWidget {
  const ReaMarketAlertsView({super.key});

  @override
  State<ReaMarketAlertsView> createState() => _ReaMarketAlertsViewState();
}

class _ReaMarketAlertsViewState extends State<ReaMarketAlertsView> {
  List<Map<String, dynamic>> marketAlerts = [
    {
      "id": 1,
      "title": "Price Drop Alert",
      "description": "Properties in Downtown area have dropped by 5%",
      "type": "price_drop",
      "location": "Downtown",
      "percentage": -5,
      "timestamp": "2 hours ago",
      "icon": Icons.trending_down,
      "color": Colors.red,
      "isActive": true,
    },
    {
      "id": 2,
      "title": "Market Surge",
      "description": "Luxury properties in Beverly Hills up by 8%",
      "type": "price_increase",
      "location": "Beverly Hills",
      "percentage": 8,
      "timestamp": "4 hours ago",
      "icon": Icons.trending_up,
      "color": Colors.green,
      "isActive": true,
    },
    {
      "id": 3,
      "title": "New Development Alert",
      "description": "5 new commercial projects announced in Tech District",
      "type": "new_development",
      "location": "Tech District",
      "count": 5,
      "timestamp": "1 day ago",
      "icon": Icons.apartment,
      "color": Colors.blue,
      "isActive": true,
    },
    {
      "id": 4,
      "title": "Investment Opportunity",
      "description": "Rental yields in Suburban areas increased to 12%",
      "type": "investment",
      "location": "Suburban",
      "percentage": 12,
      "timestamp": "2 days ago",
      "icon": Icons.trending_up,
      "color": Colors.orange,
      "isActive": false,
    },
    {
      "id": 5,
      "title": "Market Trend Alert",
      "description": "Demand for 2BHK apartments increased by 15%",
      "type": "demand_increase",
      "location": "City Center",
      "percentage": 15,
      "timestamp": "3 days ago",
      "icon": Icons.home,
      "color": Colors.purple,
      "isActive": true,
    },
  ];

  List<Map<String, dynamic>> alertCategories = [
    {
      "label": "All Alerts",
      "value": "all",
      "count": 25,
    },
    {
      "label": "Price Changes",
      "value": "price",
      "count": 12,
    },
    {
      "label": "New Listings",
      "value": "listings",
      "count": 8,
    },
    {
      "label": "Investment",
      "value": "investment",
      "count": 5,
    },
  ];

  String selectedCategory = "all";
  bool showActiveOnly = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Market Alerts"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () => _showFilterOptions(),
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
            _buildAlertSummary(),
            SizedBox(height: spLg),
            _buildCategoryFilter(),
            SizedBox(height: spLg),
            _buildActiveToggle(),
            SizedBox(height: spLg),
            _buildMarketAlertsList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createCustomAlert(),
        backgroundColor: primaryColor,
        child: Icon(Icons.add_alert),
      ),
    );
  }

  Widget _buildAlertSummary() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(180)],
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
                Icons.notifications_active,
                color: Colors.white,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Active Market Alerts",
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
                child: _buildSummaryCard("Total Alerts", "25", Icons.notifications),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildSummaryCard("Price Drops", "8", Icons.trending_down),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildSummaryCard("New Listings", "12", Icons.apartment),
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
              fontSize: fsH5,
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

  Widget _buildCategoryFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Alert Categories",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        QHorizontalScroll(
          children: alertCategories.map((category) {
            bool isSelected = selectedCategory == category["value"];
            return Container(
              margin: EdgeInsets.only(right: spSm),
              child: GestureDetector(
                onTap: () {
                  selectedCategory = category["value"];
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
                      Text(
                        "${category["label"]}",
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
                          "${category["count"]}",
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

  Widget _buildMarketAlertsList() {
    List<Map<String, dynamic>> filteredAlerts = marketAlerts.where((alert) {
      if (showActiveOnly && !(alert["isActive"] as bool)) return false;
      if (selectedCategory != "all") {
        // Filter by category logic here
      }
      return true;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recent Alerts",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        ...filteredAlerts.map((alert) => _buildAlertCard(alert)).toList(),
      ],
    );
  }

  Widget _buildAlertCard(Map<String, dynamic> alert) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: alert["color"] as Color,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: (alert["color"] as Color).withAlpha(51),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  alert["icon"] as IconData,
                  color: alert["color"] as Color,
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${alert["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${alert["timestamp"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              if (alert["isActive"] as bool)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(51),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "Active",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: successColor,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${alert["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              height: 1.4,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: disabledBoldColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                "${alert["location"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              if (alert.containsKey("percentage"))
                Spacer(),
              if (alert.containsKey("percentage"))
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: (alert["color"] as Color).withAlpha(51),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${(alert["percentage"] as int) > 0 ? '+' : ''}${alert["percentage"]}%",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: alert["color"] as Color,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Filter Options",
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

  void _createCustomAlert() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Create Custom Alert",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            // Custom alert creation form
          ],
        ),
      ),
    );
  }
}
