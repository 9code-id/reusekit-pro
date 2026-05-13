import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaChannelManagementView extends StatefulWidget {
  const HhaChannelManagementView({super.key});

  @override
  State<HhaChannelManagementView> createState() => _HhaChannelManagementViewState();
}

class _HhaChannelManagementViewState extends State<HhaChannelManagementView> {
  String selectedChannel = "All";
  String selectedStatus = "All";

  List<Map<String, dynamic>> channels = [
    {
      "id": "CH001",
      "name": "Booking.com",
      "type": "OTA",
      "logo": "https://picsum.photos/60/40?random=1&keyword=booking",
      "status": "Active",
      "connectionStatus": "Connected",
      "commission": 15.0,
      "totalBookings": 245,
      "totalRevenue": 127500.0,
      "averageRating": 8.7,
      "lastSync": "2024-06-15 10:30",
      "inventory": {"rooms": 45, "available": 42},
      "ratesPushed": true,
      "inventoryPushed": true,
      "restrictionsPushed": true,
    },
    {
      "id": "CH002",
      "name": "Expedia",
      "type": "OTA",
      "logo": "https://picsum.photos/60/40?random=2&keyword=travel",
      "status": "Active",
      "connectionStatus": "Connected",
      "commission": 18.0,
      "totalBookings": 189,
      "totalRevenue": 98700.0,
      "averageRating": 8.4,
      "lastSync": "2024-06-15 09:45",
      "inventory": {"rooms": 45, "available": 38},
      "ratesPushed": true,
      "inventoryPushed": false,
      "restrictionsPushed": true,
    },
    {
      "id": "CH003",
      "name": "Agoda",
      "type": "OTA",
      "logo": "https://picsum.photos/60/40?random=3&keyword=hotel",
      "status": "Active",
      "connectionStatus": "Connected",
      "commission": 16.5,
      "totalBookings": 156,
      "totalRevenue": 78900.0,
      "averageRating": 8.2,
      "lastSync": "2024-06-15 11:15",
      "inventory": {"rooms": 45, "available": 44},
      "ratesPushed": true,
      "inventoryPushed": true,
      "restrictionsPushed": false,
    },
    {
      "id": "CH004",
      "name": "Direct Website",
      "type": "Direct",
      "logo": "https://picsum.photos/60/40?random=4&keyword=website",
      "status": "Active",
      "connectionStatus": "Connected",
      "commission": 0.0,
      "totalBookings": 89,
      "totalRevenue": 65400.0,
      "averageRating": 9.1,
      "lastSync": "2024-06-15 12:00",
      "inventory": {"rooms": 45, "available": 45},
      "ratesPushed": true,
      "inventoryPushed": true,
      "restrictionsPushed": true,
    },
    {
      "id": "CH005",
      "name": "Travel Agent Portal",
      "type": "B2B",
      "logo": "https://picsum.photos/60/40?random=5&keyword=business",
      "status": "Active",
      "connectionStatus": "Connected",
      "commission": 12.0,
      "totalBookings": 67,
      "totalRevenue": 45800.0,
      "averageRating": 8.9,
      "lastSync": "2024-06-15 08:30",
      "inventory": {"rooms": 45, "available": 40},
      "ratesPushed": false,
      "inventoryPushed": true,
      "restrictionsPushed": true,
    },
    {
      "id": "CH006",
      "name": "Hotels.com",
      "type": "OTA",
      "logo": "https://picsum.photos/60/40?random=6&keyword=accommodation",
      "status": "Inactive",
      "connectionStatus": "Disconnected",
      "commission": 17.0,
      "totalBookings": 0,
      "totalRevenue": 0.0,
      "averageRating": 0.0,
      "lastSync": "2024-05-20 14:22",
      "inventory": {"rooms": 0, "available": 0},
      "ratesPushed": false,
      "inventoryPushed": false,
      "restrictionsPushed": false,
    },
  ];

  List<Map<String, dynamic>> get filteredChannels {
    return channels.where((channel) {
      final matchesChannel = selectedChannel == "All" || channel["type"] == selectedChannel;
      final matchesStatus = selectedStatus == "All" || channel["status"] == selectedStatus;
      return matchesChannel && matchesStatus;
    }).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Inactive":
        return dangerColor;
      case "Pending":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  Color getConnectionStatusColor(String status) {
    switch (status) {
      case "Connected":
        return successColor;
      case "Disconnected":
        return dangerColor;
      case "Error":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Channel Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.sync),
            onPressed: () {
              //syncAllChannels()
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              //navigateTo('AddChannelView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Overview Stats
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
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
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.layers, color: primaryColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Total Channels",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${channels.length}",
                        style: TextStyle(
                          fontSize: fsH4,
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
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.check_circle, color: successColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Active Channels",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${channels.where((c) => c["status"] == "Active").length}",
                        style: TextStyle(
                          fontSize: fsH4,
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
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.hotel, color: infoColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Total Bookings",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${channels.fold(0, (sum, c) => sum + (c["totalBookings"] as int))}",
                        style: TextStyle(
                          fontSize: fsH4,
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
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.attach_money, color: successColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Total Revenue",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "\$${((channels.fold(0.0, (sum, c) => sum + (c["totalRevenue"] as double))) / 1000).toStringAsFixed(0)}K",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
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
                  child: QDropdownField(
                    label: "Channel Type",
                    items: [
                      {"label": "All", "value": "All"},
                      {"label": "OTA", "value": "OTA"},
                      {"label": "Direct", "value": "Direct"},
                      {"label": "B2B", "value": "B2B"},
                    ],
                    value: selectedChannel,
                    onChanged: (value, label) {
                      selectedChannel = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Status",
                    items: [
                      {"label": "All", "value": "All"},
                      {"label": "Active", "value": "Active"},
                      {"label": "Inactive", "value": "Inactive"},
                      {"label": "Pending", "value": "Pending"},
                    ],
                    value: selectedStatus,
                    onChanged: (value, label) {
                      selectedStatus = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Channels List
            ...filteredChannels.map((channel) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Padding(
                  padding: EdgeInsets.all(spSm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      // Header
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusSm),
                            child: Image.network(
                              "${channel["logo"]}",
                              width: 60,
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
                                  "${channel["name"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: infoColor.withAlpha(30),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${channel["type"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: infoColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Text(
                                      "ID: ${channel["id"]}",
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: getStatusColor(channel["status"]),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${channel["status"]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Icon(
                                    Icons.sync,
                                    size: 12,
                                    color: getConnectionStatusColor(channel["connectionStatus"]),
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    "${channel["connectionStatus"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: getConnectionStatusColor(channel["connectionStatus"]),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Performance Metrics
                      ResponsiveGridView(
                        padding: EdgeInsets.zero,
                        minItemWidth: 200,
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Total Bookings",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${channel["totalBookings"]}",
                                  style: TextStyle(
                                    fontSize: 16,
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
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Total Revenue",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "\$${((channel["totalRevenue"] as double) / 1000).toStringAsFixed(1)}K",
                                  style: TextStyle(
                                    fontSize: 16,
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
                              color: warningColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Commission",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${channel["commission"]}%",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: warningColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (channel["averageRating"] > 0)
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: infoColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Avg Rating",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${channel["averageRating"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: infoColor,
                                        ),
                                      ),
                                      SizedBox(width: 2),
                                      Icon(
                                        Icons.star,
                                        size: 14,
                                        color: warningColor,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),

                      // Inventory Status
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: disabledColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "Inventory & Sync Status",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Available Rooms: ${channel["inventory"]["available"]}/${channel["inventory"]["rooms"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  "Last Sync: ${channel["lastSync"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.attach_money,
                                        size: 12,
                                        color: channel["ratesPushed"] ? successColor : dangerColor,
                                      ),
                                      SizedBox(width: 2),
                                      Text(
                                        "Rates",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: channel["ratesPushed"] ? successColor : dangerColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.inventory,
                                        size: 12,
                                        color: channel["inventoryPushed"] ? successColor : dangerColor,
                                      ),
                                      SizedBox(width: 2),
                                      Text(
                                        "Inventory",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: channel["inventoryPushed"] ? successColor : dangerColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.block,
                                        size: 12,
                                        color: channel["restrictionsPushed"] ? successColor : dangerColor,
                                      ),
                                      SizedBox(width: 2),
                                      Text(
                                        "Restrictions",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: channel["restrictionsPushed"] ? successColor : dangerColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Actions
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "Manage",
                              size: bs.sm,
                              onPressed: () {
                                //navigateTo('ManageChannelView', arguments: channel)
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QButton(
                              label: "Sync Now",
                              size: bs.sm,
                              onPressed: () {
                                //syncChannel(channel)
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          QButton(
                            icon: Icons.settings,
                            size: bs.sm,
                            onPressed: () {
                              //navigateTo('ChannelSettingsView', arguments: channel)
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
