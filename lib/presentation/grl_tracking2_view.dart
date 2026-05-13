import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlTracking2View extends StatefulWidget {
  const GrlTracking2View({super.key});

  @override
  State<GrlTracking2View> createState() => _GrlTracking2ViewState();
}

class _GrlTracking2ViewState extends State<GrlTracking2View> {
  int selectedTab = 0;
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedCarrier = "All";
  String selectedPeriod = "Last 30 Days";

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Statuses", "value": "All"},
    {"label": "In Transit", "value": "In Transit"},
    {"label": "Out for Delivery", "value": "Out for Delivery"},
    {"label": "Delivered", "value": "Delivered"},
    {"label": "Exception", "value": "Exception"},
    {"label": "Pending", "value": "Pending"},
  ];

  List<Map<String, dynamic>> carrierOptions = [
    {"label": "All Carriers", "value": "All"},
    {"label": "DHL", "value": "DHL"},
    {"label": "FedEx", "value": "FedEx"},
    {"label": "UPS", "value": "UPS"},
    {"label": "USPS", "value": "USPS"},
    {"label": "Aramex", "value": "Aramex"},
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "Last 7 Days", "value": "Last 7 Days"},
    {"label": "Last 30 Days", "value": "Last 30 Days"},
    {"label": "Last 90 Days", "value": "Last 90 Days"},
    {"label": "This Year", "value": "This Year"},
  ];

  List<Map<String, dynamic>> trackingList = [
    {
      "id": "DHL123456789",
      "carrier": "DHL",
      "carrierLogo": "https://picsum.photos/40/40?random=1",
      "status": "In Transit",
      "recipient": "John Doe",
      "sender": "TechStore Inc.",
      "origin": "Los Angeles, CA",
      "destination": "New York, NY",
      "estimatedDelivery": "2024-01-17",
      "actualDelivery": null,
      "shipDate": "2024-01-14",
      "lastUpdate": "2024-01-15 14:30",
      "service": "DHL Express Worldwide",
      "weight": "2.5 kg",
      "value": "\$299.99",
      "progress": 60,
      "isUrgent": true,
    },
    {
      "id": "FDX987654321",
      "carrier": "FedEx",
      "carrierLogo": "https://picsum.photos/40/40?random=2",
      "status": "Out for Delivery",
      "recipient": "Sarah Wilson",
      "sender": "Fashion Hub",
      "origin": "Chicago, IL",
      "destination": "Boston, MA",
      "estimatedDelivery": "2024-01-15",
      "actualDelivery": null,
      "shipDate": "2024-01-13",
      "lastUpdate": "2024-01-15 09:15",
      "service": "FedEx Express Saver",
      "weight": "1.2 kg",
      "value": "\$149.99",
      "progress": 90,
      "isUrgent": false,
    },
    {
      "id": "UPS456789123",
      "carrier": "UPS",
      "carrierLogo": "https://picsum.photos/40/40?random=3",
      "status": "Delivered",
      "recipient": "Mike Johnson",
      "sender": "BookWorld",
      "origin": "Seattle, WA",
      "destination": "Portland, OR",
      "estimatedDelivery": "2024-01-14",
      "actualDelivery": "2024-01-14 16:45",
      "shipDate": "2024-01-12",
      "lastUpdate": "2024-01-14 16:45",
      "service": "UPS Ground",
      "weight": "0.8 kg",
      "value": "\$49.99",
      "progress": 100,
      "isUrgent": false,
    },
    {
      "id": "USPS789123456",
      "carrier": "USPS",
      "carrierLogo": "https://picsum.photos/40/40?random=4",
      "status": "Exception",
      "recipient": "Lisa Brown",
      "sender": "Home Decor Plus",
      "origin": "Denver, CO",
      "destination": "Phoenix, AZ",
      "estimatedDelivery": "2024-01-16",
      "actualDelivery": null,
      "shipDate": "2024-01-12",
      "lastUpdate": "2024-01-15 11:20",
      "service": "USPS Priority Mail",
      "weight": "3.1 kg",
      "value": "\$89.99",
      "progress": 40,
      "isUrgent": false,
    },
    {
      "id": "ARX321654987",
      "carrier": "Aramex",
      "carrierLogo": "https://picsum.photos/40/40?random=5",
      "status": "Pending",
      "recipient": "David Chen",
      "sender": "Electronics Pro",
      "origin": "Miami, FL",
      "destination": "Atlanta, GA",
      "estimatedDelivery": "2024-01-18",
      "actualDelivery": null,
      "shipDate": "2024-01-15",
      "lastUpdate": "2024-01-15 10:00",
      "service": "Aramex Express",
      "weight": "4.2 kg",
      "value": "\$599.99",
      "progress": 10,
      "isUrgent": true,
    },
  ];

  List<Map<String, dynamic>> get filteredTrackingList {
    return trackingList.where((tracking) {
      final matchesSearch = searchQuery.isEmpty ||
          tracking["id"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          tracking["recipient"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          tracking["destination"].toLowerCase().contains(searchQuery.toLowerCase());
      
      final matchesStatus = selectedStatus == "All" || tracking["status"] == selectedStatus;
      
      final matchesCarrier = selectedCarrier == "All" || tracking["carrier"] == selectedCarrier;
      
      return matchesSearch && matchesStatus && matchesCarrier;
    }).toList();
  }

  Map<String, int> get statusCounts {
    Map<String, int> counts = {
      "Total": trackingList.length,
      "In Transit": 0,
      "Out for Delivery": 0,
      "Delivered": 0,
      "Exception": 0,
      "Pending": 0,
    };

    for (var tracking in trackingList) {
      counts[tracking["status"]] = (counts[tracking["status"]] ?? 0) + 1;
    }

    return counts;
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
        return dangerColor;
      case 'pending':
        return disabledBoldColor;
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
        return Icons.warning;
      case 'pending':
        return Icons.schedule;
      default:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tracking Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to add tracking
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Stats Cards
          Container(
            padding: EdgeInsets.all(spMd),
            child: QHorizontalScroll(
              children: [
                _buildStatCard("Total", statusCounts["Total"].toString(), Icons.inventory, primaryColor),
                _buildStatCard("In Transit", statusCounts["In Transit"].toString(), Icons.directions, warningColor),
                _buildStatCard("Delivered", statusCounts["Delivered"].toString(), Icons.check_circle, successColor),
                _buildStatCard("Exceptions", statusCounts["Exception"].toString(), Icons.warning, dangerColor),
              ],
            ),
          ),

          // Search and Filters
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: Column(
              spacing: spSm,
              children: [
                QTextField(
                  label: "Search",
                  value: searchQuery,
                  hint: "Search by tracking number, recipient, or destination",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Status",
                        items: statusOptions,
                        value: selectedStatus,
                        onChanged: (value, label) {
                          selectedStatus = value;
                          setState(() {});
                        },
                      ),
                    ),
                    Expanded(
                      child: QDropdownField(
                        label: "Carrier",
                        items: carrierOptions,
                        value: selectedCarrier,
                        onChanged: (value, label) {
                          selectedCarrier = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: spMd),

          // Tracking List
          Expanded(
            child: filteredTrackingList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: spSm,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: disabledColor,
                        ),
                        Text(
                          "No tracking records found",
                          style: TextStyle(
                            fontSize: fsH6,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "Try adjusting your search or filters",
                          style: TextStyle(
                            color: disabledColor,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: spMd),
                    itemCount: filteredTrackingList.length,
                    itemBuilder: (context, index) {
                      final tracking = filteredTrackingList[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowSm],
                          border: tracking["isUrgent"] as bool
                              ? Border.all(color: dangerColor, width: 1)
                              : null,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spSm,
                          children: [
                            // Header Row
                            Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(radiusSm),
                                    image: DecorationImage(
                                      image: NetworkImage("${tracking["carrierLogo"]}"),
                                      fit: BoxFit.cover,
                                    ),
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
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          if (tracking["isUrgent"] as bool) ...[
                                            SizedBox(width: spXs),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: spXs,
                                                vertical: 2,
                                              ),
                                              decoration: BoxDecoration(
                                                color: dangerColor,
                                                borderRadius: BorderRadius.circular(radiusXs),
                                              ),
                                              child: Text(
                                                "URGENT",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                      Text(
                                        "${tracking["carrier"]} • ${tracking["service"]}",
                                        style: TextStyle(
                                          fontSize: 12,
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
                                    color: _getStatusColor(tracking["status"]).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    spacing: spXs,
                                    children: [
                                      Icon(
                                        _getStatusIcon(tracking["status"]),
                                        size: 14,
                                        color: _getStatusColor(tracking["status"]),
                                      ),
                                      Text(
                                        "${tracking["status"]}",
                                        style: TextStyle(
                                          color: _getStatusColor(tracking["status"]),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            // Progress Bar
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Progress: ${tracking["progress"]}%",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                LinearProgressIndicator(
                                  value: (tracking["progress"] as int) / 100,
                                  backgroundColor: disabledColor,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    _getStatusColor(tracking["status"]),
                                  ),
                                ),
                              ],
                            ),

                            // Route Info
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "From",
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Text(
                                          "${tracking["origin"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    size: 16,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "To",
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Text(
                                          "${tracking["destination"]}",
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
                            ),

                            // Details Row
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Recipient: ${tracking["recipient"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "Weight: ${tracking["weight"]} • Value: ${tracking["value"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      tracking["actualDelivery"] != null
                                          ? "Delivered: ${tracking["actualDelivery"]}"
                                          : "Est. Delivery: ${tracking["estimatedDelivery"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: tracking["actualDelivery"] != null
                                            ? successColor
                                            : disabledBoldColor,
                                        fontWeight: FontWeight.w600,
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
                              ],
                            ),

                            // Action Buttons
                            Row(
                              spacing: spSm,
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: "View Details",
                                    size: bs.sm,
                                    onPressed: () {
                                      // Navigate to tracking details
                                    },
                                  ),
                                ),
                                QButton(
                                  icon: Icons.share,
                                  size: bs.sm,
                                  onPressed: () {
                                    // Share tracking info
                                  },
                                ),
                                QButton(
                                  icon: Icons.notifications,
                                  size: bs.sm,
                                  onPressed: () {
                                    // Setup notifications
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      width: 120,
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(right: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Container(
            width: 36,
            height: 36,
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
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }
}
