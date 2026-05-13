import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaPackageDetailView extends StatefulWidget {
  const DlaPackageDetailView({super.key});

  @override
  State<DlaPackageDetailView> createState() => _DlaPackageDetailViewState();
}

class _DlaPackageDetailViewState extends State<DlaPackageDetailView> {
  String selectedTab = "details";
  
  final Map<String, dynamic> packageData = {
    "id": "PKG-2024-001",
    "trackingNumber": "DLA001234567890",
    "packageName": "Samsung Galaxy S24",
    "description": "Samsung Galaxy S24 128GB Black - Brand new smartphone with warranty",
    "category": "electronics",
    "weight": 0.8,
    "dimensions": "16 x 8 x 1 cm",
    "value": 12000000,
    "priority": "express",
    "status": "delivered",
    "senderName": "Tech Store Jakarta",
    "senderPhone": "+62 21 8765 4321",
    "senderAddress": "Jl. Thamrin No. 10, Jakarta Pusat",
    "recipientName": "John Smith",
    "recipientPhone": "+62 812 3456 7890",
    "recipientAddress": "Jl. Sudirman No. 45, Jakarta Pusat, DKI Jakarta 10110",
    "recipientEmail": "john.smith@email.com",
    "createdDate": "2024-01-10 09:00:00",
    "shippedDate": "2024-01-10 15:30:00",
    "deliveredDate": "2024-01-12 14:30:00",
    "estimatedDelivery": "2024-01-12",
    "actualDelivery": "2024-01-12 14:30",
    "fragile": true,
    "requiresSignature": true,
    "cashOnDelivery": false,
    "insuranceAmount": 12000000,
    "shippingCost": 45000,
    "driverName": "Ahmad Santoso",
    "driverPhone": "+62 817 1234 5678",
    "vehicleId": "DLA-001",
    "vehiclePlate": "B 1234 ABC",
    "routeOptimized": true,
    "deliveryAttempts": 1,
    "signedBy": "John Smith",
    "deliveryPhoto": "https://picsum.photos/400/300?random=1",
    "deliveryNotes": "Package delivered successfully to recipient at front door",
    "barcode": "||||| |||| | |||| |||||",
    "qrCode": "QR_CODE_DATA_HERE",
  };

  final List<Map<String, dynamic>> trackingHistory = [
    {
      "timestamp": "2024-01-12 14:30:00",
      "status": "delivered",
      "location": "Jakarta Pusat",
      "description": "Package delivered successfully to John Smith",
      "driverName": "Ahmad Santoso",
      "icon": Icons.check_circle,
      "color": "success",
    },
    {
      "timestamp": "2024-01-12 13:45:00",
      "status": "out_for_delivery",
      "location": "Jakarta Pusat Distribution Hub",
      "description": "Out for delivery - Driver: Ahmad Santoso (DLA-001)",
      "driverName": "Ahmad Santoso",
      "icon": Icons.local_shipping,
      "color": "info",
    },
    {
      "timestamp": "2024-01-12 08:00:00",
      "status": "arrived_at_hub",
      "location": "Jakarta Pusat Distribution Hub",
      "description": "Package arrived at delivery hub",
      "driverName": null,
      "icon": Icons.warehouse,
      "color": "warning",
    },
    {
      "timestamp": "2024-01-11 16:20:00",
      "status": "in_transit",
      "location": "Jakarta Highway",
      "description": "Package in transit from sorting facility",
      "driverName": "Budi Prakoso",
      "icon": Icons.directions_car,
      "color": "warning",
    },
    {
      "timestamp": "2024-01-11 10:15:00",
      "status": "sorted",
      "location": "Jakarta Sorting Facility",
      "description": "Package sorted and prepared for delivery",
      "driverName": null,
      "icon": Icons.sort,
      "color": "info",
    },
    {
      "timestamp": "2024-01-10 15:30:00",
      "status": "shipped",
      "location": "Tech Store Jakarta",
      "description": "Package picked up from sender",
      "driverName": "Sari Indah",
      "icon": Icons.inventory,
      "color": "warning",
    },
    {
      "timestamp": "2024-01-10 09:00:00",
      "status": "created",
      "location": "Tech Store Jakarta",
      "description": "Package created and ready for pickup",
      "driverName": null,
      "icon": Icons.add_circle,
      "color": "info",
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "created":
        return infoColor;
      case "in_transit":
        return warningColor;
      case "out_for_delivery":
        return primaryColor;
      case "delivered":
        return successColor;
      case "failed":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getTrackingColor(String colorName) {
    switch (colorName) {
      case "success":
        return successColor;
      case "warning":
        return warningColor;
      case "info":
        return infoColor;
      case "danger":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildPackageOverview() {
    Color statusColor = _getStatusColor(packageData["status"]);

    return Container(
      padding: EdgeInsets.all(spSm),
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
              Icon(Icons.inventory, color: primaryColor, size: 32),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${packageData["packageName"]}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${packageData["id"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${packageData["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Icon(Icons.qr_code, color: primaryColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "Tracking Number:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${packageData["trackingNumber"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${packageData["weight"]} kg",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Weight",
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
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${((packageData["value"] as int).toDouble()).currency}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Value",
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
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${packageData["priority"]}".toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Priority",
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
        ],
      ),
    );
  }

  Widget _buildPackageDetails() {
    return Column(
      spacing: spMd,
      children: [
        // Package Information
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Text(
                "Package Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              _buildDetailRow("Description", "${packageData["description"]}"),
              _buildDetailRow("Category", "${packageData["category"]}".toUpperCase()),
              _buildDetailRow("Dimensions", "${packageData["dimensions"]}"),
              _buildDetailRow("Insurance", "${((packageData["insuranceAmount"] as int).toDouble()).currency}"),
              _buildDetailRow("Shipping Cost", "${((packageData["shippingCost"] as int).toDouble()).currency}"),
              if (packageData["fragile"] == true || packageData["requiresSignature"] == true)
                Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Row(
                    spacing: spSm,
                    children: [
                      if (packageData["fragile"] == true)
                        Row(
                          children: [
                            Icon(Icons.warning, color: warningColor, size: 16),
                            SizedBox(width: spXs),
                            Text(
                              "Fragile Package",
                              style: TextStyle(
                                fontSize: 12,
                                color: warningColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      if (packageData["requiresSignature"] == true)
                        Row(
                          children: [
                            Icon(Icons.edit, color: infoColor, size: 16),
                            SizedBox(width: spXs),
                            Text(
                              "Signature Required",
                              style: TextStyle(
                                fontSize: 12,
                                color: infoColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),

        // Sender Information
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Text(
                "Sender Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              _buildDetailRow("Name", "${packageData["senderName"]}"),
              _buildDetailRow("Phone", "${packageData["senderPhone"]}"),
              _buildDetailRow("Address", "${packageData["senderAddress"]}"),
            ],
          ),
        ),

        // Recipient Information
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Text(
                "Recipient Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              _buildDetailRow("Name", "${packageData["recipientName"]}"),
              _buildDetailRow("Phone", "${packageData["recipientPhone"]}"),
              _buildDetailRow("Email", "${packageData["recipientEmail"]}"),
              _buildDetailRow("Address", "${packageData["recipientAddress"]}"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTrackingHistory() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Tracking History",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...trackingHistory.map((event) {
            Color eventColor = _getTrackingColor(event["color"]);
            bool isLast = trackingHistory.indexOf(event) == trackingHistory.length - 1;
            
            return Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: eventColor,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          event["icon"],
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                      if (!isLast)
                        Container(
                          width: 2,
                          height: 40,
                          color: disabledColor,
                        ),
                    ],
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(bottom: isLast ? 0 : spSm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "${event["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.location_on, color: disabledBoldColor, size: 14),
                              SizedBox(width: spXs),
                              Text(
                                "${event["location"]}",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${event["timestamp"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledColor,
                            ),
                          ),
                          if (event["driverName"] != null)
                            Text(
                              "Driver: ${event["driverName"]}",
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
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildDeliveryProof() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Delivery Proof",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusSm),
              image: DecorationImage(
                image: NetworkImage("${packageData["deliveryPhoto"]}"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          _buildDetailRow("Delivered to", "${packageData["signedBy"]}"),
          _buildDetailRow("Delivery Time", "${packageData["actualDelivery"]}"),
          _buildDetailRow("Driver", "${packageData["driverName"]}"),
          _buildDetailRow("Vehicle", "${packageData["vehicleId"]} (${packageData["vehiclePlate"]})"),
          if (packageData["deliveryNotes"] != null)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Delivery Notes:",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${packageData["deliveryNotes"]}",
                    style: TextStyle(
                      fontSize: 13,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            "$label:",
            style: TextStyle(
              fontSize: 13,
              color: disabledBoldColor,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 13,
              color: primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabContent() {
    switch (selectedTab) {
      case "details":
        return _buildPackageDetails();
      case "tracking":
        return _buildTrackingHistory();
      case "proof":
        return _buildDeliveryProof();
      default:
        return _buildPackageDetails();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Package Details"),
        actions: [
          QButton(
            icon: Icons.share,
            size: bs.sm,
            onPressed: () {
              si("Share package tracking info");
            },
          ),
          QButton(
            icon: Icons.print,
            size: bs.sm,
            onPressed: () {
              si("Print package label");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildPackageOverview(),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                spacing: spSm,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        selectedTab = "details";
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: spSm),
                        decoration: BoxDecoration(
                          color: selectedTab == "details" ? primaryColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "Details",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: selectedTab == "details" ? Colors.white : disabledBoldColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        selectedTab = "tracking";
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: spSm),
                        decoration: BoxDecoration(
                          color: selectedTab == "tracking" ? primaryColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "Tracking",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: selectedTab == "tracking" ? Colors.white : disabledBoldColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (packageData["status"] == "delivered")
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          selectedTab = "proof";
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: spSm),
                          decoration: BoxDecoration(
                            color: selectedTab == "proof" ? primaryColor : Colors.transparent,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "Proof",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: selectedTab == "proof" ? Colors.white : disabledBoldColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            _buildTabContent(),
          ],
        ),
      ),
    );
  }
}
