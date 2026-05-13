import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaNewListingAlertsView extends StatefulWidget {
  const ReaNewListingAlertsView({super.key});

  @override
  State<ReaNewListingAlertsView> createState() => _ReaNewListingAlertsViewState();
}

class _ReaNewListingAlertsViewState extends State<ReaNewListingAlertsView> {
  bool enableAlerts = true;
  bool enableEmailNotifications = true;
  bool enablePushNotifications = true;
  bool enableSmsNotifications = false;
  
  String selectedPropertyType = "All Types";
  String selectedPriceRange = "Any";
  String selectedLocation = "Any";
  String selectedBedrooms = "Any";
  String selectedBathrooms = "Any";
  String alertFrequency = "Immediately";
  
  double minPrice = 100000;
  double maxPrice = 1000000;
  
  List<Map<String, dynamic>> propertyTypes = [
    {"label": "All Types", "value": "All Types"},
    {"label": "House", "value": "House"},
    {"label": "Apartment", "value": "Apartment"},
    {"label": "Condo", "value": "Condo"},
    {"label": "Townhouse", "value": "Townhouse"},
    {"label": "Villa", "value": "Villa"},
  ];

  List<Map<String, dynamic>> priceRanges = [
    {"label": "Any", "value": "Any"},
    {"label": "Under \$200K", "value": "Under \$200K"},
    {"label": "\$200K - \$500K", "value": "\$200K - \$500K"},
    {"label": "\$500K - \$1M", "value": "\$500K - \$1M"},
    {"label": "Over \$1M", "value": "Over \$1M"},
    {"label": "Custom Range", "value": "Custom Range"},
  ];

  List<Map<String, dynamic>> locations = [
    {"label": "Any", "value": "Any"},
    {"label": "Downtown", "value": "Downtown"},
    {"label": "Suburbs", "value": "Suburbs"},
    {"label": "Waterfront", "value": "Waterfront"},
    {"label": "City Center", "value": "City Center"},
    {"label": "Residential Areas", "value": "Residential Areas"},
  ];

  List<Map<String, dynamic>> bedroomOptions = [
    {"label": "Any", "value": "Any"},
    {"label": "1+", "value": "1+"},
    {"label": "2+", "value": "2+"},
    {"label": "3+", "value": "3+"},
    {"label": "4+", "value": "4+"},
    {"label": "5+", "value": "5+"},
  ];

  List<Map<String, dynamic>> bathroomOptions = [
    {"label": "Any", "value": "Any"},
    {"label": "1+", "value": "1+"},
    {"label": "2+", "value": "2+"},
    {"label": "3+", "value": "3+"},
    {"label": "4+", "value": "4+"},
  ];

  List<Map<String, dynamic>> frequencyOptions = [
    {"label": "Immediately", "value": "Immediately"},
    {"label": "Daily Digest", "value": "Daily Digest"},
    {"label": "Weekly Summary", "value": "Weekly Summary"},
    {"label": "Bi-weekly", "value": "Bi-weekly"},
  ];

  List<Map<String, dynamic>> activeAlerts = [
    {
      "id": 1,
      "name": "Downtown Condos",
      "type": "Condo",
      "location": "Downtown",
      "priceRange": "\$500K - \$1M",
      "bedrooms": "2+",
      "bathrooms": "2+",
      "frequency": "Immediately",
      "isActive": true,
      "created": DateTime.now().subtract(Duration(days: 5)),
      "matches": 12,
      "lastTriggered": DateTime.now().subtract(Duration(hours: 3)),
    },
    {
      "id": 2,
      "name": "Family Houses",
      "type": "House",
      "location": "Suburbs",
      "priceRange": "\$200K - \$500K",
      "bedrooms": "3+",
      "bathrooms": "2+",
      "frequency": "Daily Digest",
      "isActive": true,
      "created": DateTime.now().subtract(Duration(days: 12)),
      "matches": 8,
      "lastTriggered": DateTime.now().subtract(Duration(days: 1)),
    },
    {
      "id": 3,
      "name": "Waterfront Properties",
      "type": "All Types",
      "location": "Waterfront",
      "priceRange": "Over \$1M",
      "bedrooms": "Any",
      "bathrooms": "Any",
      "frequency": "Weekly Summary",
      "isActive": false,
      "created": DateTime.now().subtract(Duration(days: 20)),
      "matches": 3,
      "lastTriggered": DateTime.now().subtract(Duration(days: 7)),
    },
  ];

  List<Map<String, dynamic>> recentMatches = [
    {
      "id": 1,
      "title": "Modern Downtown Condo",
      "price": 750000,
      "location": "Downtown District",
      "bedrooms": 2,
      "bathrooms": 2,
      "sqft": 1200,
      "type": "Condo",
      "image": "https://picsum.photos/300/200?random=1&keyword=condo",
      "listedDate": DateTime.now().subtract(Duration(hours: 2)),
      "alertName": "Downtown Condos",
      "isNew": true,
    },
    {
      "id": 2,
      "title": "Spacious Family Home",
      "price": 425000,
      "location": "Maple Street",
      "bedrooms": 4,
      "bathrooms": 3,
      "sqft": 2500,
      "type": "House",
      "image": "https://picsum.photos/300/200?random=2&keyword=house",
      "listedDate": DateTime.now().subtract(Duration(hours: 5)),
      "alertName": "Family Houses",
      "isNew": true,
    },
    {
      "id": 3,
      "title": "Luxury Townhouse",
      "price": 680000,
      "location": "Oak Avenue",
      "bedrooms": 3,
      "bathrooms": 2,
      "sqft": 1800,
      "type": "Townhouse",
      "image": "https://picsum.photos/300/200?random=3&keyword=townhouse",
      "listedDate": DateTime.now().subtract(Duration(days: 1)),
      "alertName": "Downtown Condos",
      "isNew": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Listing Alerts"),
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
                          "Stay Updated",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Get notified instantly when new properties match your criteria",
                          style: TextStyle(
                            color: Colors.white.withAlpha(204),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.notifications_active,
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
                              "Enable Alerts",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Turn on/off all listing alerts",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: enableAlerts,
                        onChanged: (value) {
                          enableAlerts = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),

                  if (enableAlerts) ...[
                    Divider(height: spLg * 2),

                    // Notification Types
                    Text(
                      "Notification Methods",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spMd),

                    _buildNotificationSwitch(
                      "Email Notifications",
                      "Get alerts via email",
                      enableEmailNotifications,
                      (value) {
                        enableEmailNotifications = value;
                        setState(() {});
                      },
                    ),

                    _buildNotificationSwitch(
                      "Push Notifications",
                      "Get alerts on your device",
                      enablePushNotifications,
                      (value) {
                        enablePushNotifications = value;
                        setState(() {});
                      },
                    ),

                    _buildNotificationSwitch(
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

            // Active Alerts Section
            Row(
              children: [
                Text(
                  "Active Alerts (${activeAlerts.where((alert) => alert["isActive"]).length})",
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
              itemCount: activeAlerts.length,
              itemBuilder: (context, index) {
                final alert = activeAlerts[index];
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
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: _buildAlertDetail("Bedrooms", "${alert["bedrooms"]}"),
                                ),
                                Expanded(
                                  child: _buildAlertDetail("Bathrooms", "${alert["bathrooms"]}"),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildAlertDetail("Frequency", "${alert["frequency"]}"),
                                ),
                                Expanded(
                                  child: _buildAlertDetail("Matches", "${alert["matches"]}"),
                                ),
                              ],
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

            // Recent Matches Section
            Text(
              "Recent Matches",
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
              itemCount: recentMatches.length,
              itemBuilder: (context, index) {
                final match = recentMatches[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: match["isNew"] 
                        ? Border.all(color: successColor.withAlpha(77), width: 2)
                        : null,
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusSm),
                        child: Image.network(
                          "${match["image"]}",
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
                                if (match["isNew"])
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: successColor,
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "NEW",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                if (match["isNew"]) SizedBox(width: spSm),
                                Expanded(
                                  child: Text(
                                    "${match["title"]}",
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
                              "\$${((match["price"] as int).toDouble()).currency}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${match["location"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Text(
                                  "${match["bedrooms"]}bd • ${match["bathrooms"]}ba • ${match["sqft"]}sqft",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${(match["listedDate"] as DateTime).dMMMy}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(26),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "Alert: ${match["alertName"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: spSm),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // View property details
                            },
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
                          SizedBox(height: spSm),
                          GestureDetector(
                            onTap: () {
                              // Save property
                            },
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: dangerColor.withAlpha(26),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                Icons.favorite_border,
                                color: dangerColor,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
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

  Widget _buildNotificationSwitch(
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

  void _showCreateAlertDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Create New Alert",
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
                hint: "e.g., Downtown Condos",
                onChanged: (value) {},
              ),
              SizedBox(height: spMd),
              QDropdownField(
                label: "Property Type",
                items: propertyTypes,
                value: selectedPropertyType,
                onChanged: (value, label) {
                  selectedPropertyType = value;
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
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Bedrooms",
                      items: bedroomOptions,
                      value: selectedBedrooms,
                      onChanged: (value, label) {
                        selectedBedrooms = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: QDropdownField(
                      label: "Bathrooms",
                      items: bathroomOptions,
                      value: selectedBathrooms,
                      onChanged: (value, label) {
                        selectedBathrooms = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              QDropdownField(
                label: "Alert Frequency",
                items: frequencyOptions,
                value: alertFrequency,
                onChanged: (value, label) {
                  alertFrequency = value;
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
              ss("New alert created successfully!");
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
          activeAlerts.remove(alert);
          setState(() {});
          ss("Alert deleted successfully");
        }
        break;
    }
  }
}
