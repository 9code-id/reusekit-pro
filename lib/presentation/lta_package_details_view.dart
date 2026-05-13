import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaPackageDetailsView extends StatefulWidget {
  const LtaPackageDetailsView({super.key});

  @override
  State<LtaPackageDetailsView> createState() => _LtaPackageDetailsViewState();
}

class _LtaPackageDetailsViewState extends State<LtaPackageDetailsView> {
  int currentTab = 0;

  // Package Information
  Map<String, dynamic> packageData = {
    "tracking_id": "LTA001234567",
    "status": "In Transit",
    "sender": {
      "name": "John Smith",
      "phone": "+1234567890",
      "email": "john.smith@email.com",
      "address": "123 Main Street, New York, NY 10001",
    },
    "recipient": {
      "name": "Sarah Johnson",
      "phone": "+1987654321",
      "email": "sarah.johnson@email.com",
      "address": "456 Oak Avenue, Los Angeles, CA 90210",
    },
    "package": {
      "type": "Electronics",
      "description": "Smartphone and accessories",
      "weight": "2.5 kg",
      "dimensions": "30 x 20 x 15 cm",
      "value": "\$850.00",
      "is_fragile": true,
      "requires_signature": true,
    },
    "service": {
      "type": "Express",
      "priority": "High",
      "insurance": "\$1000",
      "estimated_delivery": "2024-12-17 14:00",
      "cost": "\$45.50",
    },
    "dates": {
      "created": "2024-12-15 09:30",
      "pickup": "2024-12-15 11:45",
      "in_transit": "2024-12-15 13:20",
      "estimated_delivery": "2024-12-17 14:00",
    },
    "driver": {
      "name": "Mike Wilson",
      "phone": "+1555123456",
      "vehicle": "Van - ABC123",
      "current_location": "Highway 101, near Downtown",
    },
    "progress": 0.65,
  };

  List<Map<String, dynamic>> trackingHistory = [
    {
      "status": "Package Created",
      "timestamp": "2024-12-15 09:30",
      "location": "New York, NY",
      "description": "Shipment information received",
      "icon": Icons.receipt,
      "color": infoColor,
    },
    {
      "status": "Package Picked Up",
      "timestamp": "2024-12-15 11:45",
      "location": "123 Main Street, New York",
      "description": "Package collected from sender",
      "icon": Icons.inventory,
      "color": successColor,
    },
    {
      "status": "In Transit",
      "timestamp": "2024-12-15 13:20",
      "location": "Distribution Center, Newark",
      "description": "Package departed from origin facility",
      "icon": Icons.local_shipping,
      "color": primaryColor,
    },
    {
      "status": "In Transit",
      "timestamp": "2024-12-16 08:15",
      "location": "Chicago, IL",
      "description": "Package arrived at intermediate facility",
      "icon": Icons.warehouse,
      "color": primaryColor,
    },
    {
      "status": "In Transit",
      "timestamp": "2024-12-16 16:30",
      "location": "Denver, CO",
      "description": "Package departed from intermediate facility",
      "icon": Icons.local_shipping,
      "color": primaryColor,
    },
    {
      "status": "Out for Delivery",
      "timestamp": "2024-12-17 09:00",
      "location": "Los Angeles, CA",
      "description": "Package loaded for delivery",
      "icon": Icons.delivery_dining,
      "color": warningColor,
    },
  ];

  List<Map<String, dynamic>> additionalServices = [
    {
      "name": "Insurance Coverage",
      "value": "\$1,000",
      "icon": Icons.security,
      "color": successColor,
    },
    {
      "name": "Signature Required",
      "value": "Yes",
      "icon": Icons.edit,
      "color": warningColor,
    },
    {
      "name": "Fragile Handling",
      "value": "Applied",
      "icon": Icons.warning,
      "color": dangerColor,
    },
    {
      "name": "Real-time Tracking",
      "value": "Active",
      "icon": Icons.gps_fixed,
      "color": infoColor,
    },
  ];

  Color getStatusColor(String status) {
    switch (status) {
      case "Package Created":
        return infoColor;
      case "Package Picked Up":
        return successColor;
      case "In Transit":
        return primaryColor;
      case "Out for Delivery":
        return warningColor;
      case "Delivered":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Package Details",
      selectedIndex: currentTab,
      actions: [
        IconButton(
          icon: Icon(Icons.share),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: () {},
        ),
      ],
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.info)),
        Tab(text: "Tracking", icon: Icon(Icons.timeline)),
        Tab(text: "Documents", icon: Icon(Icons.description)),
        Tab(text: "Support", icon: Icon(Icons.help)),
      ],
      tabChildren: [
        // Overview Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              // Package Status Header
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryColor, primaryColor.withAlpha(180)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${packageData["tracking_id"]}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(50),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${packageData["status"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${packageData["service"]["type"]} Delivery • ${packageData["service"]["priority"]} Priority",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                    // Progress Bar
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Delivery Progress",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(180),
                              ),
                            ),
                            Text(
                              "${((packageData["progress"] as double) * 100).toInt()}%",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 6,
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(50),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: FractionallySizedBox(
                            widthFactor: packageData["progress"] as double,
                            alignment: Alignment.centerLeft,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Expected delivery: ${packageData["service"]["estimated_delivery"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withAlpha(180),
                      ),
                    ),
                  ],
                ),
              ),

              // Quick Actions
              Text(
                "Quick Actions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                spacing: spSm,
                children: [
                  Expanded(
                    child: QButton(
                      label: "Track Live",
                      icon: Icons.gps_fixed,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ),
                  Expanded(
                    child: QButton(
                      label: "Contact Driver",
                      icon: Icons.call,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ),
                  Expanded(
                    child: QButton(
                      label: "Reschedule",
                      icon: Icons.schedule,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),

              // Package Information
              Text(
                "Package Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Package Type:",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${packageData["package"]["type"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Divider(height: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Description:",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "${packageData["package"]["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                    Divider(height: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Weight:",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${packageData["package"]["weight"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Divider(height: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Dimensions:",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${packageData["package"]["dimensions"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Divider(height: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Declared Value:",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${packageData["package"]["value"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Sender & Recipient Info
              Text(
                "Sender & Recipient",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                spacing: spSm,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spSm,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.person_pin,
                                color: primaryColor,
                                size: 20,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "SENDER",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${packageData["sender"]["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${packageData["sender"]["phone"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${packageData["sender"]["email"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${packageData["sender"]["address"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spSm,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: successColor,
                                size: 20,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "RECIPIENT",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${packageData["recipient"]["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${packageData["recipient"]["phone"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${packageData["recipient"]["email"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${packageData["recipient"]["address"]}",
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

              // Service Information
              Text(
                "Service Details",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Service Type:",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${packageData["service"]["type"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Divider(height: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Priority:",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${packageData["service"]["priority"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: warningColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(height: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Insurance:",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${packageData["service"]["insurance"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Divider(height: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Cost:",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${packageData["service"]["cost"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Additional Services
              Text(
                "Additional Services",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: additionalServices.map((service) {
                  return Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: (service["color"] as Color).withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            service["icon"] as IconData,
                            color: service["color"] as Color,
                            size: 20,
                          ),
                        ),
                        Text(
                          "${service["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${service["value"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: service["color"] as Color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),

              // Driver Information
              if (packageData["status"] == "In Transit" || packageData["status"] == "Out for Delivery")
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Text(
                      "Driver Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                        border: Border(
                          left: BorderSide(
                            width: 4,
                            color: infoColor,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spSm,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spXs,
                                children: [
                                  Text(
                                    "${packageData["driver"]["name"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "${packageData["driver"]["phone"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              QButton(
                                icon: Icons.call,
                                size: bs.sm,
                                onPressed: () {},
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.local_shipping, size: 16, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text(
                                "${packageData["driver"]["vehicle"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${packageData["driver"]["current_location"]}",
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
                  ],
                ),
            ],
          ),
        ),

        // Tracking Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Text(
                "Tracking History",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                spacing: spSm,
                children: trackingHistory.map((event) {
                  return Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                      border: Border(
                        left: BorderSide(
                          width: 4,
                          color: event["color"] as Color,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: (event["color"] as Color).withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            event["icon"] as IconData,
                            color: event["color"] as Color,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Text(
                                "${event["status"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${event["description"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${event["location"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${event["timestamp"]}",
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
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),

        // Documents Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Text(
                "Package Documents",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Documents content would go here
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Text(
                  "Shipping documents, invoices, and receipts will be displayed here",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Support Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Text(
                "Customer Support",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Support content would go here
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Text(
                  "Customer support options and help resources will be displayed here",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
