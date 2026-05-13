import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlTracking1View extends StatefulWidget {
  const GrlTracking1View({super.key});

  @override
  State<GrlTracking1View> createState() => _GrlTracking1ViewState();
}

class _GrlTracking1ViewState extends State<GrlTracking1View> {
  String trackingNumber = "";
  String selectedCarrier = "DHL";
  Map<String, dynamic>? trackingResult;
  bool isLoading = false;

  List<Map<String, dynamic>> carriers = [
    {"label": "DHL Express", "value": "DHL"},
    {"label": "FedEx", "value": "FEDEX"},
    {"label": "UPS", "value": "UPS"},
    {"label": "USPS", "value": "USPS"},
    {"label": "TNT", "value": "TNT"},
    {"label": "Aramex", "value": "ARAMEX"},
  ];

  List<Map<String, dynamic>> recentTracking = [
    {
      "id": "DHL123456789",
      "carrier": "DHL",
      "status": "In Transit",
      "lastUpdate": "2024-01-15 14:30",
      "destination": "New York, NY",
      "estimatedDelivery": "2024-01-17",
    },
    {
      "id": "FDX987654321",
      "carrier": "FedEx",
      "status": "Out for Delivery",
      "lastUpdate": "2024-01-15 09:15",
      "destination": "Los Angeles, CA",
      "estimatedDelivery": "2024-01-15",
    },
    {
      "id": "UPS456789123",
      "carrier": "UPS",
      "status": "Delivered",
      "lastUpdate": "2024-01-14 16:45",
      "destination": "Chicago, IL",
      "estimatedDelivery": "2024-01-14",
    },
  ];

  Map<String, dynamic> mockTrackingResult = {
    "trackingNumber": "DHL123456789",
    "carrier": "DHL",
    "status": "In Transit",
    "statusCode": "IT",
    "estimatedDelivery": "2024-01-17",
    "currentLocation": "Cincinnati, OH - Hub",
    "lastUpdate": "2024-01-15 14:30",
    "recipient": "John Doe",
    "sender": "TechStore Inc.",
    "weight": "2.5 kg",
    "service": "DHL Express Worldwide",
    "trackingHistory": [
      {
        "date": "2024-01-15 14:30",
        "location": "Cincinnati, OH - Hub",
        "status": "In transit to next facility",
        "description": "Shipment has departed from a DHL facility"
      },
      {
        "date": "2024-01-15 08:15",
        "location": "Cincinnati, OH - Hub",
        "status": "Processed at facility",
        "description": "Shipment processed at DHL facility"
      },
      {
        "date": "2024-01-14 19:45",
        "location": "Los Angeles, CA - Origin",
        "status": "Shipment picked up",
        "description": "Shipment picked up from sender"
      },
      {
        "date": "2024-01-14 16:30",
        "location": "Los Angeles, CA",
        "status": "Shipment information received",
        "description": "Electronic notification received from shipper"
      },
    ]
  };

  void _trackPackage() async {
    if (trackingNumber.isEmpty) {
      se("Please enter a tracking number");
      return;
    }

    isLoading = true;
    setState(() {});

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    trackingResult = mockTrackingResult;
    isLoading = false;
    setState(() {});
  }

  void _clearResult() {
    trackingResult = null;
    trackingNumber = "";
    setState(() {});
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'delivered':
        return successColor;
      case 'out for delivery':
        return infoColor;
      case 'in transit':
        return warningColor;
      case 'exception':
      case 'delayed':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'delivered':
        return Icons.check_circle;
      case 'out for delivery':
        return Icons.local_shipping;
      case 'in transit':
        return Icons.directions;
      case 'exception':
      case 'delayed':
        return Icons.warning;
      default:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Package Tracking"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Tracking Form
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Track Your Package",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  QDropdownField(
                    label: "Carrier",
                    items: carriers,
                    value: selectedCarrier,
                    onChanged: (value, label) {
                      selectedCarrier = value;
                      setState(() {});
                    },
                  ),
                  QTextField(
                    label: "Tracking Number",
                    value: trackingNumber,
                    hint: "Enter your tracking number",
                    onChanged: (value) {
                      trackingNumber = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QButton(
                          label: isLoading ? "Tracking..." : "Track Package",
                          onPressed: isLoading ? null : _trackPackage,
                        ),
                      ),
                      if (trackingResult != null)
                        QButton(
                          label: "Clear",
                          icon: Icons.clear,
                          size: bs.sm,
                          onPressed: _clearResult,
                        ),
                    ],
                  ),
                ],
              ),
            ),

            // Loading Indicator
            if (isLoading)
              Center(
                child: Column(
                  spacing: spSm,
                  children: [
                    CircularProgressIndicator(),
                    Text(
                      "Tracking your package...",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),

            // Tracking Result
            if (trackingResult != null && !isLoading)
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    // Package Info Header
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${trackingResult!["trackingNumber"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${trackingResult!["carrier"]} • ${trackingResult!["service"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                ),
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
                            color: _getStatusColor(trackingResult!["status"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            spacing: spXs,
                            children: [
                              Icon(
                                _getStatusIcon(trackingResult!["status"]),
                                size: 16,
                                color: _getStatusColor(trackingResult!["status"]),
                              ),
                              Text(
                                "${trackingResult!["status"]}",
                                style: TextStyle(
                                  color: _getStatusColor(trackingResult!["status"]),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // Delivery Info
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
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
                                  "Estimated Delivery",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${trackingResult!["estimatedDelivery"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Current Location",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${trackingResult!["currentLocation"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Package Details
                    Row(
                      children: [
                        Expanded(
                          child: _buildInfoCard("Recipient", "${trackingResult!["recipient"]}", Icons.person),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: _buildInfoCard("Weight", "${trackingResult!["weight"]}", Icons.scale),
                        ),
                      ],
                    ),

                    // Tracking History
                    Text(
                      "Tracking History",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ...List.generate((trackingResult!["trackingHistory"] as List).length, (index) {
                      final event = (trackingResult!["trackingHistory"] as List)[index];
                      final isLast = index == (trackingResult!["trackingHistory"] as List).length - 1;
                      
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: index == 0 ? primaryColor : disabledColor,
                                  shape: BoxShape.circle,
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${event["status"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: index == 0 ? primaryColor : null,
                                  ),
                                ),
                                Text(
                                  "${event["description"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      size: 12,
                                      color: disabledBoldColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${event["location"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "${event["date"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
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

            // Recent Tracking
            if (trackingResult == null && !isLoading)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Recent Tracking",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ...recentTracking.map((tracking) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        boxShadow: [shadowSm],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: _getStatusColor(tracking["status"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              _getStatusIcon(tracking["status"]),
                              color: _getStatusColor(tracking["status"]),
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
                                      "${tracking["id"]}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "${tracking["carrier"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "${tracking["status"]} • ${tracking["destination"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
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
                              trackingNumber = tracking["id"];
                              selectedCarrier = tracking["carrier"];
                              setState(() {});
                            },
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: disabledBoldColor,
          ),
          SizedBox(width: spXs),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
