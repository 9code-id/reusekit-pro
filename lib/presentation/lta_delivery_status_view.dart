import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaDeliveryStatusView extends StatefulWidget {
  const LtaDeliveryStatusView({super.key});

  @override
  State<LtaDeliveryStatusView> createState() => _LtaDeliveryStatusViewState();
}

class _LtaDeliveryStatusViewState extends State<LtaDeliveryStatusView> {
  bool loading = true;
  String selectedTimeframe = "Today";
  String selectedStatus = "All Statuses";
  String selectedDriver = "All Drivers";

  List<Map<String, dynamic>> timeframeOptions = [
    {"label": "Today", "value": "Today"},
    {"label": "Yesterday", "value": "Yesterday"},
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Statuses", "value": "All Statuses"},
    {"label": "Delivered", "value": "delivered"},
    {"label": "Out for Delivery", "value": "out_for_delivery"},
    {"label": "Failed", "value": "failed"},
    {"label": "Returned", "value": "returned"},
  ];

  List<Map<String, dynamic>> driverOptions = [
    {"label": "All Drivers", "value": "All Drivers"},
    {"label": "John Smith", "value": "john_smith"},
    {"label": "Maria Garcia", "value": "maria_garcia"},
    {"label": "David Johnson", "value": "david_johnson"},
    {"label": "Sarah Wilson", "value": "sarah_wilson"},
  ];

  List<Map<String, dynamic>> deliveries = [
    {
      "id": "DEL-001",
      "trackingNumber": "LTA1234567890",
      "customerName": "Acme Corporation",
      "customerPhone": "+1-555-0123",
      "address": "123 Business St, San Francisco, CA 94105",
      "status": "delivered",
      "driver": "John Smith",
      "vehicle": "Truck TR-001",
      "scheduledTime": "2024-03-15T14:00:00Z",
      "actualTime": "2024-03-15T13:45:00Z",
      "deliveryNote": "Delivered to reception desk. Signed by John Doe.",
      "packages": 3,
      "weight": 25.5,
      "signature": "data:image/base64,signature_data",
      "photo": "https://picsum.photos/400/300?random=1",
      "rating": 5,
      "feedback": "Excellent service, on time delivery!",
    },
    {
      "id": "DEL-002",
      "trackingNumber": "LTA1234567891",
      "customerName": "Tech Solutions Inc",
      "customerPhone": "+1-555-0124",
      "address": "456 Innovation Blvd, Sacramento, CA 95814",
      "status": "out_for_delivery",
      "driver": "Maria Garcia",
      "vehicle": "Van VN-002",
      "scheduledTime": "2024-03-15T16:00:00Z",
      "actualTime": null,
      "deliveryNote": null,
      "packages": 2,
      "weight": 12.8,
      "signature": null,
      "photo": null,
      "rating": null,
      "feedback": null,
    },
    {
      "id": "DEL-003",
      "trackingNumber": "LTA1234567892",
      "customerName": "Global Manufacturing",
      "customerPhone": "+1-555-0125",
      "address": "789 Industrial Way, Modesto, CA 95354",
      "status": "failed",
      "driver": "David Johnson",
      "vehicle": "Cargo CG-004",
      "scheduledTime": "2024-03-15T12:00:00Z",
      "actualTime": "2024-03-15T12:15:00Z",
      "deliveryNote": "Customer not available. Left delivery notice.",
      "packages": 1,
      "weight": 45.2,
      "signature": null,
      "photo": "https://picsum.photos/400/300?random=2",
      "rating": null,
      "feedback": null,
      "failureReason": "Customer unavailable",
      "nextAttempt": "2024-03-16T10:00:00Z",
    },
    {
      "id": "DEL-004",
      "trackingNumber": "LTA1234567893",
      "customerName": "Retail Chain Co",
      "customerPhone": "+1-555-0126",
      "address": "321 Commerce Dr, Bakersfield, CA 93301",
      "status": "delivered",
      "driver": "Sarah Wilson",
      "vehicle": "Pickup PK-003",
      "scheduledTime": "2024-03-15T10:30:00Z",
      "actualTime": "2024-03-15T10:25:00Z",
      "deliveryNote": "Package delivered to store manager. No issues.",
      "packages": 5,
      "weight": 18.7,
      "signature": "data:image/base64,signature_data",
      "photo": "https://picsum.photos/400/300?random=3",
      "rating": 4,
      "feedback": "Good service, but could be faster.",
    },
    {
      "id": "DEL-005",
      "trackingNumber": "LTA1234567894",
      "customerName": "Medical Supplies Ltd",
      "customerPhone": "+1-555-0127",
      "address": "654 Health Plaza, Fresno, CA 93720",
      "status": "returned",
      "driver": "John Smith",
      "vehicle": "Truck TR-001",
      "scheduledTime": "2024-03-14T15:00:00Z",
      "actualTime": "2024-03-14T15:30:00Z",
      "deliveryNote": "Address incorrect. Package returned to depot.",
      "packages": 2,
      "weight": 8.3,
      "signature": null,
      "photo": "https://picsum.photos/400/300?random=4",
      "rating": null,
      "feedback": null,
      "returnReason": "Incorrect address",
    },
    {
      "id": "DEL-006",
      "trackingNumber": "LTA1234567895",
      "customerName": "Food Distribution Co",
      "customerPhone": "+1-555-0128",
      "address": "987 Market Street, Oakland, CA 94607",
      "status": "delivered",
      "driver": "Maria Garcia",
      "vehicle": "Van VN-002",
      "scheduledTime": "2024-03-15T09:00:00Z",
      "actualTime": "2024-03-15T08:55:00Z",
      "deliveryNote": "Early morning delivery as requested. Left at loading dock.",
      "packages": 8,
      "weight": 67.4,
      "signature": "data:image/base64,signature_data",
      "photo": "https://picsum.photos/400/300?random=5",
      "rating": 5,
      "feedback": "Perfect timing and professional service!",
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadDeliveries();
  }

  void _loadDeliveries() async {
    await Future.delayed(Duration(seconds: 1));
    loading = false;
    setState(() {});
  }

  List<Map<String, dynamic>> get filteredDeliveries {
    return deliveries.where((delivery) {
      bool matchesStatus = selectedStatus == "All Statuses" || 
          delivery["status"] == selectedStatus;
      
      bool matchesDriver = selectedDriver == "All Drivers" || 
          "${delivery["driver"]}".toLowerCase().replaceAll(" ", "_") == selectedDriver;
      
      return matchesStatus && matchesDriver;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "delivered":
        return successColor;
      case "out_for_delivery":
        return infoColor;
      case "failed":
        return dangerColor;
      case "returned":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "delivered":
        return Icons.check_circle;
      case "out_for_delivery":
        return Icons.local_shipping;
      case "failed":
        return Icons.error;
      case "returned":
        return Icons.keyboard_return;
      default:
        return Icons.help_outline;
    }
  }

  String _formatTime(String? timeString) {
    if (timeString == null) return "Pending";
    DateTime time = DateTime.parse(timeString);
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
  }

  String _formatDateTime(String timeString) {
    DateTime time = DateTime.parse(timeString);
    return "${time.day}/${time.month}/${time.year} ${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
  }

  void _viewDeliveryDetails(Map<String, dynamic> delivery) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          width: 500,
          height: 600,
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Delivery Details",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Status Badge
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor("${delivery["status"]}").withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              _getStatusIcon("${delivery["status"]}"),
                              size: 16,
                              color: _getStatusColor("${delivery["status"]}"),
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${delivery["status"]}".toUpperCase().replaceAll("_", " "),
                              style: TextStyle(
                                fontSize: 14,
                                color: _getStatusColor("${delivery["status"]}"),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: spMd),
                      
                      // Delivery Information
                      Text(
                        "Delivery Information",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Tracking: ${delivery["trackingNumber"]}", style: TextStyle(fontWeight: FontWeight.w600)),
                            Text("Customer: ${delivery["customerName"]}"),
                            Text("Phone: ${delivery["customerPhone"]}"),
                            Text("Address: ${delivery["address"]}"),
                            Text("Driver: ${delivery["driver"]}"),
                            Text("Vehicle: ${delivery["vehicle"]}"),
                            Text("Packages: ${delivery["packages"]}"),
                            Text("Weight: ${delivery["weight"]} kg"),
                          ],
                        ),
                      ),
                      SizedBox(height: spMd),
                      
                      // Timing Information
                      Text(
                        "Timing",
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
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: infoColor.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Scheduled",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: infoColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    _formatTime("${delivery["scheduledTime"]}"),
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: infoColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: _getStatusColor("${delivery["status"]}").withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Actual",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: _getStatusColor("${delivery["status"]}"),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    _formatTime(delivery["actualTime"]),
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: _getStatusColor("${delivery["status"]}"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spMd),
                      
                      // Delivery Note
                      if (delivery["deliveryNote"] != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Delivery Note",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.grey.withValues(alpha: 0.05),
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(
                                  color: Colors.grey.withValues(alpha: 0.2),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                "${delivery["deliveryNote"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            SizedBox(height: spMd),
                          ],
                        ),
                      
                      // Customer Feedback
                      if (delivery["rating"] != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Customer Feedback",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: successColor.withValues(alpha: 0.05),
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(
                                  color: successColor.withValues(alpha: 0.2),
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Rating: ",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Row(
                                        children: List.generate(5, (index) {
                                          return Icon(
                                            index < (delivery["rating"] as int) ? Icons.star : Icons.star_border,
                                            size: 16,
                                            color: warningColor,
                                          );
                                        }),
                                      ),
                                    ],
                                  ),
                                  if (delivery["feedback"] != null) ...[
                                    SizedBox(height: spXs),
                                    Text(
                                      "${delivery["feedback"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: primaryColor,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            SizedBox(height: spMd),
                          ],
                        ),
                      
                      // Proof of Delivery
                      if (delivery["photo"] != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Proof of Delivery",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Container(
                              width: double.infinity,
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(radiusMd),
                                border: Border.all(
                                  color: Colors.grey.withValues(alpha: 0.3),
                                  width: 1,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(radiusMd),
                                child: Image.network(
                                  "${delivery["photo"]}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Delivery Status"),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    List<Map<String, dynamic>> displayDeliveries = filteredDeliveries;

    return Scaffold(
      appBar: AppBar(
        title: Text("Delivery Status"),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              // Open delivery analytics
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // Open advanced filters
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Status Overview
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Text(
                    "Today's Delivery Summary",
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
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: successColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${deliveries.where((d) => d["status"] == "delivered").length}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "Delivered",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: successColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: infoColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${deliveries.where((d) => d["status"] == "out_for_delivery").length}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
                                ),
                              ),
                              Text(
                                "Out for Delivery",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: infoColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: dangerColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${deliveries.where((d) => d["status"] == "failed").length}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: dangerColor,
                                ),
                              ),
                              Text(
                                "Failed",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: dangerColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: warningColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${deliveries.where((d) => d["status"] == "returned").length}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                              Text(
                                "Returned",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: warningColor,
                                  fontWeight: FontWeight.w600,
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
            ),

            // Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Timeframe",
                    items: timeframeOptions,
                    value: selectedTimeframe,
                    onChanged: (value, label) {
                      selectedTimeframe = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
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
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Driver",
                    items: driverOptions,
                    value: selectedDriver,
                    onChanged: (value, label) {
                      selectedDriver = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Performance Metrics
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Success Rate",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${((deliveries.where((d) => d["status"] == "delivered").length / deliveries.length) * 100).toInt()}%",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Avg. Rating",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "4.5",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(
                              Icons.star,
                              size: 20,
                              color: warningColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "On Time",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "89%",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Deliveries List
            if (displayDeliveries.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.local_shipping,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No deliveries found",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Adjust your filters to see more results",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              Column(
                children: displayDeliveries.map((delivery) {
                  String status = "${delivery["status"]}";
                  
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                      border: Border(
                        left: BorderSide(
                          color: _getStatusColor(status),
                          width: 4,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(status).withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  _getStatusIcon(status),
                                  size: 16,
                                  color: _getStatusColor(status),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${delivery["customerName"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${delivery["trackingNumber"]}",
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
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(status).withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  status.toUpperCase().replaceAll("_", " "),
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: _getStatusColor(status),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),

                          // Address
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 14,
                                color: primaryColor,
                              ),
                              SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  "${delivery["address"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: primaryColor,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),

                          // Driver and Vehicle
                          Row(
                            children: [
                              Icon(
                                Icons.person,
                                size: 14,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "${delivery["driver"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Icon(
                                Icons.local_shipping,
                                size: 14,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "${delivery["vehicle"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),

                          // Timing Information
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.schedule,
                                      size: 12,
                                      color: infoColor,
                                    ),
                                    SizedBox(width: 2),
                                    Text(
                                      "Scheduled: ${_formatTime("${delivery["scheduledTime"]}")}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: infoColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (delivery["actualTime"] != null)
                                Expanded(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.access_time,
                                        size: 12,
                                        color: _getStatusColor(status),
                                      ),
                                      SizedBox(width: 2),
                                      Text(
                                        "Actual: ${_formatTime(delivery["actualTime"])}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: _getStatusColor(status),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),

                          // Package Info
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Icon(
                                Icons.inventory_2,
                                size: 12,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: 2),
                              Text(
                                "${delivery["packages"]} packages",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Icon(
                                Icons.scale,
                                size: 12,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: 2),
                              Text(
                                "${delivery["weight"]} kg",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                              if (delivery["rating"] != null) ...[
                                SizedBox(width: spSm),
                                Row(
                                  children: List.generate((delivery["rating"] as int), (index) {
                                    return Icon(
                                      Icons.star,
                                      size: 12,
                                      color: warningColor,
                                    );
                                  }),
                                ),
                              ],
                            ],
                          ),

                          SizedBox(height: spSm),
                          // Action Buttons
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "View Details",
                                  size: bs.sm,
                                  onPressed: () => _viewDeliveryDetails(delivery),
                                ),
                              ),
                              SizedBox(width: spXs),
                              QButton(
                                icon: Icons.phone,
                                size: bs.sm,
                                onPressed: () {
                                  // Call customer
                                },
                              ),
                              SizedBox(width: spXs),
                              QButton(
                                icon: Icons.navigation,
                                size: bs.sm,
                                onPressed: () {
                                  // Get directions
                                },
                              ),
                              if (status == "failed" || status == "returned")
                                ...[
                                  SizedBox(width: spXs),
                                  QButton(
                                    icon: Icons.refresh,
                                    size: bs.sm,
                                    onPressed: () {
                                      // Retry delivery
                                    },
                                  ),
                                ],
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }
}
