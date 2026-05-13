import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaAuctionAlertsView extends StatefulWidget {
  const ReaAuctionAlertsView({super.key});

  @override
  State<ReaAuctionAlertsView> createState() => _ReaAuctionAlertsViewState();
}

class _ReaAuctionAlertsViewState extends State<ReaAuctionAlertsView> {
  bool enableAuctionAlerts = true;
  bool enableEmailNotifications = true;
  bool enablePushNotifications = true;
  bool enableSmsNotifications = false;
  bool enablePreAuctionAlerts = true;
  bool enableResultsAlerts = true;
  
  String selectedAuctionType = "All Types";
  String selectedPriceRange = "Any";
  String selectedLocation = "Any";
  String timeBeforeAuction = "24 hours";
  
  List<Map<String, dynamic>> auctionTypes = [
    {"label": "All Types", "value": "All Types"},
    {"label": "Residential", "value": "Residential"},
    {"label": "Commercial", "value": "Commercial"},
    {"label": "Land", "value": "Land"},
    {"label": "Investment", "value": "Investment"},
    {"label": "Distressed", "value": "Distressed"},
  ];

  List<Map<String, dynamic>> priceRanges = [
    {"label": "Any", "value": "Any"},
    {"label": "Under \$100K", "value": "Under \$100K"},
    {"label": "\$100K - \$300K", "value": "\$100K - \$300K"},
    {"label": "\$300K - \$500K", "value": "\$300K - \$500K"},
    {"label": "\$500K - \$1M", "value": "\$500K - \$1M"},
    {"label": "Over \$1M", "value": "Over \$1M"},
  ];

  List<Map<String, dynamic>> locations = [
    {"label": "Any", "value": "Any"},
    {"label": "Downtown", "value": "Downtown"},
    {"label": "Suburbs", "value": "Suburbs"},
    {"label": "City Center", "value": "City Center"},
    {"label": "Waterfront", "value": "Waterfront"},
    {"label": "Commercial District", "value": "Commercial District"},
  ];

  List<Map<String, dynamic>> timeOptions = [
    {"label": "1 hour", "value": "1 hour"},
    {"label": "6 hours", "value": "6 hours"},
    {"label": "12 hours", "value": "12 hours"},
    {"label": "24 hours", "value": "24 hours"},
    {"label": "48 hours", "value": "48 hours"},
    {"label": "1 week", "value": "1 week"},
  ];

  List<Map<String, dynamic>> activeAuctionAlerts = [
    {
      "id": 1,
      "name": "Downtown Commercial",
      "type": "Commercial",
      "location": "Downtown",
      "priceRange": "\$500K - \$1M",
      "timeBeforeAuction": "24 hours",
      "isActive": true,
      "created": DateTime.now().subtract(Duration(days: 10)),
      "matches": 5,
      "lastTriggered": DateTime.now().subtract(Duration(hours: 12)),
    },
    {
      "id": 2,
      "name": "Residential Properties",
      "type": "Residential",
      "location": "Suburbs",
      "priceRange": "\$300K - \$500K",
      "timeBeforeAuction": "48 hours",
      "isActive": true,
      "created": DateTime.now().subtract(Duration(days: 18)),
      "matches": 12,
      "lastTriggered": DateTime.now().subtract(Duration(days: 2)),
    },
    {
      "id": 3,
      "name": "Investment Opportunities",
      "type": "Investment",
      "location": "Any",
      "priceRange": "Any",
      "timeBeforeAuction": "1 week",
      "isActive": false,
      "created": DateTime.now().subtract(Duration(days: 25)),
      "matches": 8,
      "lastTriggered": DateTime.now().subtract(Duration(days: 7)),
    },
  ];

  List<Map<String, dynamic>> upcomingAuctions = [
    {
      "id": 1,
      "title": "Modern Office Building",
      "type": "Commercial",
      "location": "Business District",
      "startingBid": 850000,
      "estimatedValue": 1200000,
      "auctionDate": DateTime.now().add(Duration(hours: 18)),
      "auctionTime": "10:00 AM",
      "image": "https://picsum.photos/300/200?random=1&keyword=office",
      "alertName": "Downtown Commercial",
      "status": "Upcoming",
      "bidders": 12,
      "inspectionDate": DateTime.now().add(Duration(hours: 6)),
      "auctioneer": "Premier Auctions",
      "propertyType": "Office",
      "sqft": 5000,
    },
    {
      "id": 2,
      "title": "Family Home with Pool",
      "type": "Residential",
      "location": "Maple Street",
      "startingBid": 425000,
      "estimatedValue": 580000,
      "auctionDate": DateTime.now().add(Duration(days: 2)),
      "auctionTime": "2:00 PM",
      "image": "https://picsum.photos/300/200?random=2&keyword=house",
      "alertName": "Residential Properties",
      "status": "Upcoming",
      "bidders": 8,
      "inspectionDate": DateTime.now().add(Duration(days: 1)),
      "auctioneer": "City Auctions",
      "propertyType": "House",
      "sqft": 2200,
    },
    {
      "id": 3,
      "title": "Luxury Condo Downtown",
      "type": "Residential",
      "location": "City Center",
      "startingBid": 650000,
      "estimatedValue": 750000,
      "auctionDate": DateTime.now().add(Duration(days: 5)),
      "auctionTime": "11:00 AM",
      "image": "https://picsum.photos/300/200?random=3&keyword=condo",
      "alertName": "Downtown Commercial",
      "status": "Upcoming",
      "bidders": 15,
      "inspectionDate": DateTime.now().add(Duration(days: 3)),
      "auctioneer": "Elite Auctions",
      "propertyType": "Condo",
      "sqft": 1500,
    },
  ];

  List<Map<String, dynamic>> auctionResults = [
    {
      "id": 1,
      "title": "Suburban Villa",
      "finalPrice": 720000,
      "startingBid": 550000,
      "estimatedValue": 680000,
      "auctionDate": DateTime.now().subtract(Duration(days: 2)),
      "status": "Sold",
      "bidders": 18,
      "alertName": "Residential Properties",
      "image": "https://picsum.photos/300/200?random=4&keyword=villa",
      "hammer": true,
    },
    {
      "id": 2,
      "title": "Commercial Warehouse",
      "finalPrice": 0,
      "startingBid": 950000,
      "estimatedValue": 1100000,
      "auctionDate": DateTime.now().subtract(Duration(days: 5)),
      "status": "Passed In",
      "bidders": 6,
      "alertName": "Downtown Commercial",
      "image": "https://picsum.photos/300/200?random=5&keyword=warehouse",
      "hammer": false,
    },
    {
      "id": 3,
      "title": "Retail Space",
      "finalPrice": 380000,
      "startingBid": 320000,
      "estimatedValue": 420000,
      "auctionDate": DateTime.now().subtract(Duration(days: 8)),
      "status": "Sold",
      "bidders": 10,
      "alertName": "Downtown Commercial",
      "image": "https://picsum.photos/300/200?random=6&keyword=retail",
      "hammer": true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Auction Alerts"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showCreateAlertDialog(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(179)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Auction Alerts",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Never miss an auction opportunity with real-time alerts",
                          style: TextStyle(
                            color: Colors.white.withAlpha(204),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.gavel,
                    size: 60,
                    color: Colors.white.withAlpha(128),
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Alert Settings Section
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
                    "Alert Settings",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),

                  // Master Switch
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Enable Auction Alerts",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Turn on/off all auction notifications",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: enableAuctionAlerts,
                        onChanged: (value) {
                          enableAuctionAlerts = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),

                  if (enableAuctionAlerts) ...[
                    Divider(height: spLg * 2),

                    // Alert Types
                    Text(
                      "Alert Types",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spMd),

                    _buildAlertTypeSwitch(
                      "Pre-Auction Alerts",
                      "Get notified before auctions start",
                      enablePreAuctionAlerts,
                      (value) {
                        enablePreAuctionAlerts = value;
                        setState(() {});
                      },
                    ),

                    _buildAlertTypeSwitch(
                      "Results Alerts",
                      "Get notified of auction results",
                      enableResultsAlerts,
                      (value) {
                        enableResultsAlerts = value;
                        setState(() {});
                      },
                    ),

                    Divider(height: spLg * 2),

                    // Notification Methods
                    Text(
                      "Notification Methods",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spMd),

                    _buildAlertTypeSwitch(
                      "Email Notifications",
                      "Get alerts via email",
                      enableEmailNotifications,
                      (value) {
                        enableEmailNotifications = value;
                        setState(() {});
                      },
                    ),

                    _buildAlertTypeSwitch(
                      "Push Notifications",
                      "Get alerts on your device",
                      enablePushNotifications,
                      (value) {
                        enablePushNotifications = value;
                        setState(() {});
                      },
                    ),

                    _buildAlertTypeSwitch(
                      "SMS Notifications",
                      "Get alerts via text message",
                      enableSmsNotifications,
                      (value) {
                        enableSmsNotifications = value;
                        setState(() {});
                      },
                    ),
                  ],
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Quick Stats Section
            Row(
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
                        Icon(
                          Icons.schedule,
                          color: warningColor,
                          size: 32,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${upcomingAuctions.length}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Upcoming",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spMd),
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
                        Icon(
                          Icons.notifications_active,
                          color: successColor,
                          size: 32,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${activeAuctionAlerts.where((alert) => alert["isActive"]).length}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Active Alerts",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spMd),
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
                        Icon(
                          Icons.gavel,
                          color: primaryColor,
                          size: 32,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${auctionResults.where((result) => result["status"] == "Sold").length}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Recent Sales",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: spLg),

            // Upcoming Auctions Section
            Row(
              children: [
                Text(
                  "Upcoming Auctions",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    // View all auctions
                  },
                  child: Text(
                    "View All",
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: upcomingAuctions.length,
              itemBuilder: (context, index) {
                final auction = upcomingAuctions[index];
                final timeUntilAuction = (auction["auctionDate"] as DateTime).difference(DateTime.now());
                
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border.all(
                      color: timeUntilAuction.inHours < 24 
                          ? warningColor.withAlpha(77)
                          : disabledOutlineBorderColor,
                      width: timeUntilAuction.inHours < 24 ? 2 : 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusSm),
                            child: Image.network(
                              "${auction["image"]}",
                              width: 100,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    if (timeUntilAuction.inHours < 24)
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spSm,
                                          vertical: spXs,
                                        ),
                                        decoration: BoxDecoration(
                                          color: warningColor,
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Text(
                                          "SOON",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    if (timeUntilAuction.inHours < 24) SizedBox(width: spSm),
                                    Expanded(
                                      child: Text(
                                        "${auction["title"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${auction["location"]} • ${auction["propertyType"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "Starting bid: \$${((auction["startingBid"] as int).toDouble()).currency}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _viewAuctionDetails(auction),
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(26),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                Icons.visibility,
                                color: primaryColor,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: spMd),

                      // Auction Details
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(13),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: _buildAuctionDetail(
                                    "Date & Time", 
                                    "${(auction["auctionDate"] as DateTime).dMMMy} at ${auction["auctionTime"]}"
                                  ),
                                ),
                                Expanded(
                                  child: _buildAuctionDetail("Bidders", "${auction["bidders"]}"),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildAuctionDetail("Auctioneer", "${auction["auctioneer"]}"),
                                ),
                                Expanded(
                                  child: _buildAuctionDetail("Size", "${auction["sqft"]} sqft"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: spMd),

                      // Countdown and Actions
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: timeUntilAuction.inHours < 24 
                                  ? warningColor.withAlpha(26)
                                  : primaryColor.withAlpha(26),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              _formatTimeUntilAuction(timeUntilAuction),
                              style: TextStyle(
                                fontSize: 12,
                                color: timeUntilAuction.inHours < 24 ? warningColor : primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(26),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "Alert: ${auction["alertName"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: successColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Spacer(),
                          QButton(
                            label: "Register",
                            size: bs.sm,
                            onPressed: () {
                              ss("Registration for auction initiated");
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),

            SizedBox(height: spLg),

            // Active Alerts Section
            Row(
              children: [
                Text(
                  "My Alert Rules",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () => _showCreateAlertDialog(),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spSm,
                      vertical: spXs,
                    ),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(26),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.add,
                          color: primaryColor,
                          size: 16,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "New Alert",
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: activeAuctionAlerts.length,
              itemBuilder: (context, index) {
                final alert = activeAuctionAlerts[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border.all(
                      color: alert["isActive"] ? primaryColor.withAlpha(77) : disabledOutlineBorderColor,
                      width: 1,
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
                                      "${alert["name"]}",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spSm,
                                        vertical: spXs,
                                      ),
                                      decoration: BoxDecoration(
                                        color: alert["isActive"] 
                                            ? successColor.withAlpha(26)
                                            : disabledColor.withAlpha(26),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Text(
                                        alert["isActive"] ? "Active" : "Paused",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: alert["isActive"] ? successColor : disabledBoldColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spSm),
                                Text(
                                  "${alert["type"]} • ${alert["location"]} • ${alert["priceRange"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          PopupMenuButton(
                            icon: Icon(Icons.more_vert, color: disabledBoldColor),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 'edit',
                                child: Row(
                                  children: [
                                    Icon(Icons.edit, size: 20),
                                    SizedBox(width: spSm),
                                    Text("Edit"),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: 'toggle',
                                child: Row(
                                  children: [
                                    Icon(
                                      alert["isActive"] ? Icons.pause : Icons.play_arrow,
                                      size: 20,
                                    ),
                                    SizedBox(width: spSm),
                                    Text(alert["isActive"] ? "Pause" : "Resume"),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: 'delete',
                                child: Row(
                                  children: [
                                    Icon(Icons.delete, size: 20, color: dangerColor),
                                    SizedBox(width: spSm),
                                    Text("Delete", style: TextStyle(color: dangerColor)),
                                  ],
                                ),
                              ),
                            ],
                            onSelected: (value) => _handleAlertAction(value as String, alert),
                          ),
                        ],
                      ),

                      SizedBox(height: spMd),

                      // Alert Details
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(13),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: _buildAlertDetail("Notify Before", "${alert["timeBeforeAuction"]}"),
                            ),
                            Expanded(
                              child: _buildAlertDetail("Matches", "${alert["matches"]}"),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: spMd),

                      // Last Activity
                      Row(
                        children: [
                          Icon(
                            Icons.schedule,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Last triggered: ${(alert["lastTriggered"] as DateTime).dMMMy}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Created: ${(alert["created"] as DateTime).dMMMy}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),

            SizedBox(height: spLg),

            // Recent Results Section
            Text(
              "Recent Auction Results",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: auctionResults.length,
              itemBuilder: (context, index) {
                final result = auctionResults[index];
                final isSold = result["status"] == "Sold";
                
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusSm),
                        child: Image.network(
                          "${result["image"]}",
                          width: 80,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${result["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            if (isSold) ...[
                              Text(
                                "Sold for \$${((result["finalPrice"] as int).toDouble()).currency}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "Starting bid: \$${((result["startingBid"] as int).toDouble()).currency}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ] else ...[
                              Text(
                                "Passed In",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                              Text(
                                "Starting bid: \$${((result["startingBid"] as int).toDouble()).currency}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Text(
                                  "${result["bidders"]} bidders",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${(result["auctionDate"] as DateTime).dMMMy}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: isSold 
                              ? successColor.withAlpha(26)
                              : warningColor.withAlpha(26),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${result["status"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: isSold ? successColor : warningColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertTypeSwitch(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildAuctionDetail(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildAlertDetail(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  String _formatTimeUntilAuction(Duration duration) {
    if (duration.inDays > 0) {
      return "${duration.inDays} days left";
    } else if (duration.inHours > 0) {
      return "${duration.inHours} hours left";
    } else if (duration.inMinutes > 0) {
      return "${duration.inMinutes} minutes left";
    } else {
      return "Starting soon";
    }
  }

  void _showCreateAlertDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Create Auction Alert",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              QTextField(
                label: "Alert Name",
                value: "",
                hint: "e.g., Commercial Properties",
                onChanged: (value) {},
              ),
              SizedBox(height: spMd),
              QDropdownField(
                label: "Auction Type",
                items: auctionTypes,
                value: selectedAuctionType,
                onChanged: (value, label) {
                  selectedAuctionType = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spMd),
              QDropdownField(
                label: "Location",
                items: locations,
                value: selectedLocation,
                onChanged: (value, label) {
                  selectedLocation = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spMd),
              QDropdownField(
                label: "Price Range",
                items: priceRanges,
                value: selectedPriceRange,
                onChanged: (value, label) {
                  selectedPriceRange = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spMd),
              QDropdownField(
                label: "Notify Before Auction",
                items: timeOptions,
                value: timeBeforeAuction,
                onChanged: (value, label) {
                  timeBeforeAuction = value;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Create Alert",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Auction alert created successfully!");
            },
          ),
        ],
      ),
    );
  }

  void _viewAuctionDetails(Map<String, dynamic> auction) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "${auction["title"]}",
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${auction["image"]}",
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: spMd),
              _buildAuctionDetail("Location", "${auction["location"]}"),
              SizedBox(height: spSm),
              _buildAuctionDetail("Property Type", "${auction["propertyType"]}"),
              SizedBox(height: spSm),
              _buildAuctionDetail("Size", "${auction["sqft"]} sqft"),
              SizedBox(height: spSm),
              _buildAuctionDetail("Starting Bid", "\$${((auction["startingBid"] as int).toDouble()).currency}"),
              SizedBox(height: spSm),
              _buildAuctionDetail("Estimated Value", "\$${((auction["estimatedValue"] as int).toDouble()).currency}"),
              SizedBox(height: spSm),
              _buildAuctionDetail("Auction Date", "${(auction["auctionDate"] as DateTime).dMMMy} at ${auction["auctionTime"]}"),
              SizedBox(height: spSm),
              _buildAuctionDetail("Auctioneer", "${auction["auctioneer"]}"),
              SizedBox(height: spSm),
              _buildAuctionDetail("Registered Bidders", "${auction["bidders"]}"),
              SizedBox(height: spSm),
              _buildAuctionDetail("Inspection Date", "${(auction["inspectionDate"] as DateTime).dMMMy}"),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
          QButton(
            label: "Register to Bid",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Registration process initiated");
            },
          ),
        ],
      ),
    );
  }

  void _handleAlertAction(String action, Map<String, dynamic> alert) async {
    switch (action) {
      case 'edit':
        _showCreateAlertDialog();
        break;
      case 'toggle':
        alert["isActive"] = !alert["isActive"];
        setState(() {});
        ss(alert["isActive"] ? "Alert resumed" : "Alert paused");
        break;
      case 'delete':
        bool isConfirmed = await confirm("Are you sure you want to delete this alert?");
        if (isConfirmed) {
          activeAuctionAlerts.remove(alert);
          setState(() {});
          ss("Alert deleted successfully");
        }
        break;
    }
  }
}
