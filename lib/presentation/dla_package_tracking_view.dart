import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaPackageTrackingView extends StatefulWidget {
  const DlaPackageTrackingView({super.key});

  @override
  State<DlaPackageTrackingView> createState() => _DlaPackageTrackingViewState();
}

class _DlaPackageTrackingViewState extends State<DlaPackageTrackingView> {
  String trackingNumber = "";
  bool isLoading = false;
  Map<String, dynamic>? packageInfo;
  
  List<Map<String, dynamic>> trackingHistory = [
    {
      "status": "Delivered",
      "description": "Package delivered to recipient",
      "location": "123 Main St, Springfield, IL",
      "timestamp": "2024-01-15 14:30:00",
      "icon": Icons.check_circle,
      "color": Colors.green,
      "completed": true,
    },
    {
      "status": "Out for Delivery",
      "description": "Package is out for delivery",
      "location": "Springfield Distribution Center",
      "timestamp": "2024-01-15 08:45:00",
      "icon": Icons.local_shipping,
      "color": Colors.blue,
      "completed": true,
    },
    {
      "status": "In Transit",
      "description": "Package is in transit to destination facility",
      "location": "Chicago Transit Hub",
      "timestamp": "2024-01-14 22:15:00",
      "icon": Icons.airport_shuttle,
      "color": Colors.orange,
      "completed": true,
    },
    {
      "status": "Processed",
      "description": "Package processed at sorting facility",
      "location": "Chicago Processing Center",
      "timestamp": "2024-01-14 16:20:00",
      "icon": Icons.inventory,
      "color": Colors.purple,
      "completed": true,
    },
    {
      "status": "Picked Up",
      "description": "Package picked up from sender",
      "location": "New York Pickup Point",
      "timestamp": "2024-01-14 10:00:00",
      "icon": Icons.where_to_vote,
      "color": Colors.indigo,
      "completed": true,
    },
  ];

  List<Map<String, dynamic>> recentTrackings = [
    {
      "trackingNumber": "DLA123456789",
      "status": "Delivered",
      "destination": "Springfield, IL",
      "lastUpdate": "2024-01-15 14:30",
    },
    {
      "trackingNumber": "DLA987654321",
      "status": "In Transit",
      "destination": "Boston, MA",
      "lastUpdate": "2024-01-15 12:45",
    },
    {
      "trackingNumber": "DLA456789123",
      "status": "Processing",
      "destination": "Seattle, WA",
      "lastUpdate": "2024-01-15 09:20",
    },
  ];

  void _trackPackage() async {
    if (trackingNumber.isEmpty) {
      se("Please enter a tracking number");
      return;
    }

    isLoading = true;
    setState(() {});

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    packageInfo = {
      "trackingNumber": trackingNumber,
      "status": "In Transit",
      "sender": "ABC Company",
      "recipient": "John Doe",
      "destination": "123 Main St, Springfield, IL 62701",
      "estimatedDelivery": "2024-01-16 15:00",
      "weight": "2.5 kg",
      "dimensions": "30x20x15 cm",
      "serviceType": "Express Delivery",
    };

    isLoading = false;
    setState(() {});
    ss("Package information retrieved successfully");
  }

  void _scanBarcode() async {
    // Simulate barcode scanning
    await Future.delayed(Duration(milliseconds: 500));
    trackingNumber = "DLA${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}";
    setState(() {});
    _trackPackage();
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'delivered':
        return successColor;
      case 'in transit':
      case 'out for delivery':
        return infoColor;
      case 'processing':
      case 'processed':
        return warningColor;
      case 'picked up':
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Package Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code_scanner),
            onPressed: _scanBarcode,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Section
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
                    "Track Your Package",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Tracking Number",
                          value: trackingNumber,
                          hint: "Enter tracking number (e.g., DLA123456789)",
                          onChanged: (value) {
                            trackingNumber = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.qr_code_scanner,
                        size: bs.sm,
                        onPressed: _scanBarcode,
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: isLoading ? "Tracking..." : "Track Package",
                      onPressed: isLoading ? null : _trackPackage,
                    ),
                  ),
                ],
              ),
            ),

            if (packageInfo != null) ...[
              SizedBox(height: spMd),
              
              // Package Information
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
                    Row(
                      children: [
                        Icon(
                          Icons.local_shipping,
                          color: primaryColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Tracking #${packageInfo!["trackingNumber"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${packageInfo!["status"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: _getStatusColor("${packageInfo!["status"]}"),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    
                    // Package Details
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          _buildInfoRow("From", "${packageInfo!["sender"]}"),
                          _buildInfoRow("To", "${packageInfo!["recipient"]}"),
                          _buildInfoRow("Destination", "${packageInfo!["destination"]}"),
                          _buildInfoRow("Service", "${packageInfo!["serviceType"]}"),
                          _buildInfoRow("Weight", "${packageInfo!["weight"]}"),
                          _buildInfoRow("Dimensions", "${packageInfo!["dimensions"]}"),
                          _buildInfoRow("Est. Delivery", "${packageInfo!["estimatedDelivery"]}", isLast: true),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: spMd),

              // Tracking Timeline
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
                      "Tracking History",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    
                    ...trackingHistory.asMap().entries.map((entry) {
                      int index = entry.key;
                      Map<String, dynamic> item = entry.value;
                      bool isLast = index == trackingHistory.length - 1;
                      
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: (item["completed"] as bool) 
                                      ? (item["color"] as Color)
                                      : disabledColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  item["icon"] as IconData,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              if (!isLast)
                                Container(
                                  width: 2,
                                  height: 40,
                                  color: (item["completed"] as bool) 
                                      ? (item["color"] as Color)
                                      : disabledColor,
                                ),
                            ],
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(bottom: isLast ? 0 : spSm),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${item["status"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: (item["completed"] as bool) 
                                          ? primaryColor
                                          : disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${item["description"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        size: 14,
                                        color: disabledColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Expanded(
                                        child: Text(
                                          "${item["location"]}",
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: disabledColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${item["timestamp"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ),
            ],

            SizedBox(height: spMd),

            // Recent Trackings
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
                  Row(
                    children: [
                      Text(
                        "Recent Trackings",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          si("View all trackings");
                        },
                        child: Text(
                          "View All",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),

                  ...recentTrackings.map((tracking) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: disabledOutlineBorderColor),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.local_shipping,
                            color: primaryColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${tracking["trackingNumber"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _getStatusColor("${tracking["status"]}").withAlpha(51),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${tracking["status"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: _getStatusColor("${tracking["status"]}"),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Text(
                                      "to ${tracking["destination"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "Updated: ${tracking["lastUpdate"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              trackingNumber = "${tracking["trackingNumber"]}";
                              setState(() {});
                              _trackPackage();
                            },
                            child: Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(51),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Icon(
                                Icons.search,
                                color: primaryColor,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isLast = false}) {
    return Container(
      padding: EdgeInsets.only(bottom: isLast ? 0 : spXs),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: disabledBoldColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            ": ",
            style: TextStyle(
              fontSize: 13,
              color: disabledBoldColor,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 13,
                color: primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
