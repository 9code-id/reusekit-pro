import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaDeliveryDetailView extends StatefulWidget {
  const DlaDeliveryDetailView({super.key});

  @override
  State<DlaDeliveryDetailView> createState() => _DlaDeliveryDetailViewState();
}

class _DlaDeliveryDetailViewState extends State<DlaDeliveryDetailView> {
  Map<String, dynamic> delivery = {
    "id": "DLV-2024-001",
    "customer": {
      "name": "John Smith",
      "phone": "+1 (555) 123-4567",
      "email": "john.smith@email.com",
      "address": "123 Main Street, Downtown, CA 90210"
    },
    "driver": {
      "name": "Mike Johnson",
      "phone": "+1 (555) 987-6543",
      "vehicle": "Ford Transit - ABC 123",
      "photo": "https://picsum.photos/80/80?random=1&keyword=person"
    },
    "status": "in_transit",
    "priority": "high",
    "estimated_delivery": "2024-01-15 14:30",
    "distance_remaining": 2.5,
    "packages": [
      {
        "id": "PKG-001",
        "description": "Electronics Package",
        "weight": 2.5,
        "dimensions": "30x25x15 cm",
        "fragile": true
      },
      {
        "id": "PKG-002", 
        "description": "Documents",
        "weight": 0.2,
        "dimensions": "25x35x2 cm",
        "fragile": false
      }
    ],
    "tracking_history": [
      {
        "timestamp": "2024-01-15 08:00",
        "status": "picked_up",
        "location": "Warehouse A",
        "description": "Package picked up and loaded"
      },
      {
        "timestamp": "2024-01-15 09:30",
        "status": "in_transit",
        "location": "Route 101",
        "description": "Out for delivery"
      },
      {
        "timestamp": "2024-01-15 12:15",
        "status": "in_transit",
        "location": "Downtown Area",
        "description": "Arrived in delivery zone"
      }
    ]
  };

  String getStatusColor(String status) {
    switch (status) {
      case 'delivered':
        return 'success';
      case 'in_transit':
        return 'info';
      case 'delayed':
        return 'warning';
      case 'failed':
        return 'danger';
      default:
        return 'primary';
    }
  }

  String getStatusText(String status) {
    switch (status) {
      case 'picked_up':
        return 'Picked Up';
      case 'in_transit':
        return 'In Transit';
      case 'delivered':
        return 'Delivered';
      case 'delayed':
        return 'Delayed';
      case 'failed':
        return 'Failed';
      default:
        return 'Unknown';
    }
  }

  Color getStatusColorValue(String colorName) {
    switch (colorName) {
      case 'success':
        return successColor;
      case 'info':
        return infoColor;
      case 'warning':
        return warningColor;
      case 'danger':
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delivery Details"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              ss("Delivery details refreshed");
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              ss("Sharing delivery details");
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
            // Status Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: getStatusColorValue(getStatusColor("${delivery["status"]}")).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          getStatusText("${delivery["status"]}"),
                          style: TextStyle(
                            color: getStatusColorValue(getStatusColor("${delivery["status"]}")),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Spacer(),
                      if (delivery["priority"] == "high")
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "HIGH PRIORITY",
                            style: TextStyle(
                              color: dangerColor,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  Text(
                    "Delivery ID: ${delivery["id"]}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Est. Delivery: ${delivery["estimated_delivery"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "${(delivery["distance_remaining"] as num).toStringAsFixed(1)} km remaining",
                    style: TextStyle(
                      fontSize: 14,
                      color: infoColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // Progress Tracker
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Delivery Progress",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...List.generate((delivery["tracking_history"] as List).length, (index) {
                    final item = (delivery["tracking_history"] as List)[index];
                    final isLast = index == (delivery["tracking_history"] as List).length - 1;
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: isLast ? infoColor : successColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            if (!isLast)
                              Container(
                                width: 2,
                                height: 30,
                                color: disabledColor,
                              ),
                          ],
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${item["description"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${item["location"]} • ${item["timestamp"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              if (!isLast) SizedBox(height: spSm),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),

            // Customer Information
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Customer Information",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.person, color: primaryColor, size: 20),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${(delivery["customer"] as Map)["name"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${(delivery["customer"] as Map)["email"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      QButton(
                        icon: Icons.phone,
                        size: bs.sm,
                        onPressed: () {
                          ss("Calling customer");
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: primaryColor, size: 20),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "${(delivery["customer"] as Map)["address"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      QButton(
                        icon: Icons.directions,
                        size: bs.sm,
                        onPressed: () {
                          ss("Opening directions");
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Driver Information
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Driver Information",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusSm),
                        child: Image.network(
                          "${(delivery["driver"] as Map)["photo"]}",
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${(delivery["driver"] as Map)["name"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${(delivery["driver"] as Map)["vehicle"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      QButton(
                        icon: Icons.phone,
                        size: bs.sm,
                        onPressed: () {
                          ss("Calling driver");
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Package Details
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Package Details",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...List.generate((delivery["packages"] as List).length, (index) {
                    final package = (delivery["packages"] as List)[index];
                    return Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: disabledColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        spacing: spXs,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${package["id"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Spacer(),
                              if (package["fragile"] == true)
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: warningColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "FRAGILE",
                                    style: TextStyle(
                                      color: warningColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          Text(
                            "${package["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Weight: ${(package["weight"] as num).toStringAsFixed(1)} kg • Dimensions: ${package["dimensions"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),

            // Action Buttons
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Track Live",
                    icon: Icons.gps_fixed,
                    size: bs.md,
                    onPressed: () {
                      ss("Opening live tracking");
                    },
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Contact Customer",
                    icon: Icons.message,
                    size: bs.md,
                    onPressed: () {
                      ss("Opening customer chat");
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
