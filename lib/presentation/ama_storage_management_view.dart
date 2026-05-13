import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaStorageManagementView extends StatefulWidget {
  const AmaStorageManagementView({super.key});

  @override
  State<AmaStorageManagementView> createState() => _AmaStorageManagementViewState();
}

class _AmaStorageManagementViewState extends State<AmaStorageManagementView> {
  String selectedWarehouse = "Warehouse A";
  String selectedCommodity = "Rice";
  String stockAlert = "5 tons";
  String storageTemp = "25°C";
  String humidity = "60%";

  List<Map<String, dynamic>> warehouses = [
    {
      "name": "Warehouse A",
      "location": "Jakarta",
      "capacity": "1000 tons",
      "occupied": "750 tons",
      "occupancy": 75,
      "status": "Active",
      "commodities": ["Rice", "Corn", "Wheat"],
      "lastUpdate": "2024-01-15 10:30",
    },
    {
      "name": "Warehouse B", 
      "location": "Surabaya",
      "capacity": "800 tons",
      "occupied": "600 tons",
      "occupancy": 75,
      "status": "Active",
      "commodities": ["Soybeans", "Coffee", "Sugar"],
      "lastUpdate": "2024-01-15 09:45",
    },
    {
      "name": "Warehouse C",
      "location": "Medan",
      "capacity": "1200 tons",
      "occupied": "480 tons", 
      "occupancy": 40,
      "status": "Maintenance",
      "commodities": ["Palm Oil", "Cocoa", "Rubber"],
      "lastUpdate": "2024-01-14 16:20",
    },
  ];

  List<Map<String, dynamic>> storedCommodities = [
    {
      "commodity": "Rice",
      "warehouse": "Warehouse A",
      "quantity": "250 tons",
      "quality": "Grade A",
      "entryDate": "2024-01-10",
      "expiryDate": "2024-06-10",
      "storageTemp": "25°C",
      "humidity": "60%",
      "value": 500000000,
      "location": "A-01-15",
    },
    {
      "commodity": "Corn",
      "warehouse": "Warehouse A", 
      "quantity": "300 tons",
      "quality": "Grade B",
      "entryDate": "2024-01-12",
      "expiryDate": "2024-05-12",
      "storageTemp": "22°C",
      "humidity": "55%",
      "value": 350000000,
      "location": "A-02-20",
    },
    {
      "commodity": "Soybeans",
      "warehouse": "Warehouse B",
      "quantity": "200 tons",
      "quality": "Grade A",
      "entryDate": "2024-01-08",
      "expiryDate": "2024-07-08",
      "storageTemp": "20°C",
      "humidity": "50%",
      "value": 600000000,
      "location": "B-01-10",
    },
  ];

  List<Map<String, dynamic>> storageAlerts = [
    {
      "type": "Low Stock",
      "commodity": "Rice",
      "warehouse": "Warehouse A",
      "message": "Stock below minimum threshold",
      "priority": "High",
      "timestamp": "2024-01-15 08:30",
      "icon": Icons.warning,
      "color": warningColor,
    },
    {
      "type": "Temperature Alert",
      "commodity": "Coffee",
      "warehouse": "Warehouse B", 
      "message": "Temperature exceeds optimal range",
      "priority": "Medium",
      "timestamp": "2024-01-15 07:15",
      "icon": Icons.thermostat,
      "color": dangerColor,
    },
    {
      "type": "Expiry Warning",
      "commodity": "Corn",
      "warehouse": "Warehouse A",
      "message": "Product expires in 30 days",
      "priority": "Medium",
      "timestamp": "2024-01-15 06:00",
      "icon": Icons.schedule,
      "color": warningColor,
    },
  ];

  List<Map<String, dynamic>> warehouseItems = [
    {
      "label": "Warehouse A",
      "value": "Warehouse A",
    },
    {
      "label": "Warehouse B", 
      "value": "Warehouse B",
    },
    {
      "label": "Warehouse C",
      "value": "Warehouse C",
    },
  ];

  List<Map<String, dynamic>> commodityItems = [
    {
      "label": "Rice",
      "value": "Rice",
    },
    {
      "label": "Corn",
      "value": "Corn",
    },
    {
      "label": "Soybeans",
      "value": "Soybeans",
    },
    {
      "label": "Coffee",
      "value": "Coffee",
    },
    {
      "label": "Sugar",
      "value": "Sugar",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Storage Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to add storage
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Navigate to storage settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Storage Overview Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildStorageCard(
                  "Total Capacity",
                  "3,000 tons",
                  Icons.warehouse,
                  primaryColor,
                ),
                _buildStorageCard(
                  "Occupied Space",
                  "1,830 tons",
                  Icons.inventory,
                  successColor,
                ),
                _buildStorageCard(
                  "Available Space",
                  "1,170 tons",
                  Icons.space_bar,
                  infoColor,
                ),
                _buildStorageCard(
                  "Utilization Rate",
                  "61%",
                  Icons.analytics,
                  warningColor,
                ),
              ],
            ),

            // Filter Section
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Select Warehouse",
                    items: warehouseItems,
                    value: selectedWarehouse,
                    onChanged: (value, label) {
                      selectedWarehouse = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Commodity",
                    items: commodityItems,
                    value: selectedCommodity,
                    onChanged: (value, label) {
                      selectedCommodity = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Storage Alerts
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
                  Row(
                    children: [
                      Icon(
                        Icons.notification_important,
                        color: dangerColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Storage Alerts",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: dangerColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${storageAlerts.length}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: dangerColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ...storageAlerts.map((alert) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spXs),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: (alert["color"] as Color).withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border(
                          left: BorderSide(
                            width: 3,
                            color: alert["color"] as Color,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            alert["icon"] as IconData,
                            color: alert["color"] as Color,
                            size: 18,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${alert["type"]} - ${alert["commodity"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${alert["message"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${alert["warehouse"]} • ${alert["timestamp"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: (alert["color"] as Color).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${alert["priority"]}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: alert["color"] as Color,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),

            // Warehouse List
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
                  Row(
                    children: [
                      Icon(
                        Icons.warehouse,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Warehouse Status",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ...warehouses.map((warehouse) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: disabledOutlineBorderColor,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: warehouse["status"] == "Active" 
                                    ? successColor.withAlpha(20)
                                    : warningColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  Icons.warehouse,
                                  color: warehouse["status"] == "Active" 
                                    ? successColor
                                    : warningColor,
                                  size: 20,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "${warehouse["name"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spXs,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: warehouse["status"] == "Active" 
                                              ? successColor.withAlpha(20)
                                              : warningColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "${warehouse["status"]}",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                              color: warehouse["status"] == "Active" 
                                                ? successColor
                                                : warningColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "${warehouse["location"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Capacity",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledColor,
                                      ),
                                    ),
                                    Text(
                                      "${warehouse["capacity"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Occupied",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledColor,
                                      ),
                                    ),
                                    Text(
                                      "${warehouse["occupied"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Utilization",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledColor,
                                      ),
                                    ),
                                    Text(
                                      "${warehouse["occupancy"]}%",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Container(
                            width: double.infinity,
                            height: 6,
                            decoration: BoxDecoration(
                              color: disabledColor.withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: (warehouse["occupancy"] as int) / 100,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: warehouse["occupancy"] > 80 
                                    ? dangerColor
                                    : warehouse["occupancy"] > 60 
                                    ? warningColor
                                    : successColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "View Details",
                                  size: bs.sm,
                                  onPressed: () {
                                    // Navigate to warehouse details
                                  },
                                ),
                              ),
                              SizedBox(width: spSm),
                              QButton(
                                icon: Icons.more_vert,
                                size: bs.sm,
                                onPressed: () {
                                  // Show warehouse actions
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),

            // Stored Commodities
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
                  Row(
                    children: [
                      Icon(
                        Icons.inventory_2,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Stored Commodities",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ...storedCommodities.map((commodity) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: disabledOutlineBorderColor,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.grass,
                              color: primaryColor,
                              size: 24,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${commodity["commodity"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: successColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${commodity["quality"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: successColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "${commodity["warehouse"]} • ${commodity["location"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Text(
                                      "${commodity["quantity"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      " • ",
                                      style: TextStyle(
                                        color: disabledColor,
                                      ),
                                    ),
                                    Text(
                                      "\$${((commodity["value"] as int).toDouble()).currency}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: successColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${commodity["storageTemp"]} • ${commodity["humidity"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledColor,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "Expires: ${commodity["expiryDate"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: warningColor,
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
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStorageCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              Spacer(),
              Icon(
                Icons.trending_up,
                color: successColor,
                size: 16,
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
