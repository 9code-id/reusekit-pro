import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaDeliveryView extends StatefulWidget {
  const ImaDeliveryView({super.key});

  @override
  State<ImaDeliveryView> createState() => _ImaDeliveryViewState();
}

class _ImaDeliveryViewState extends State<ImaDeliveryView> {
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedType = "All";
  String selectedPriority = "All";
  int currentTab = 0;

  List<Map<String, dynamic>> statusItems = [
    {"label": "All Status", "value": "All"},
    {"label": "Out for Delivery", "value": "Out for Delivery"},
    {"label": "Delivered", "value": "Delivered"},
    {"label": "Failed Delivery", "value": "Failed Delivery"},
    {"label": "Returned", "value": "Returned"},
    {"label": "Rescheduled", "value": "Rescheduled"},
  ];

  List<Map<String, dynamic>> typeItems = [
    {"label": "All Types", "value": "All"},
    {"label": "Standard", "value": "Standard"},
    {"label": "Express", "value": "Express"},
    {"label": "Same Day", "value": "Same Day"},
    {"label": "Scheduled", "value": "Scheduled"},
  ];

  List<Map<String, dynamic>> priorityItems = [
    {"label": "All Priority", "value": "All"},
    {"label": "High", "value": "High"},
    {"label": "Medium", "value": "Medium"},
    {"label": "Low", "value": "Low"},
  ];

  List<Map<String, dynamic>> deliveries = [
    {
      "id": "DEL-2024-001",
      "trackingNumber": "1Z999AA1234567890",
      "orderNumber": "ORD-45892",
      "customer": "John Doe",
      "address": "123 Main Street, Los Angeles, CA 90210",
      "phone": "+1 555-0123",
      "status": "Out for Delivery",
      "type": "Express",
      "priority": "High",
      "deliveryDate": "2024-06-19",
      "timeSlot": "10:00 AM - 12:00 PM",
      "driver": "Mike Johnson",
      "vehicle": "Truck-001",
      "estimatedArrival": "11:30 AM",
      "actualDelivery": null,
      "signature": null,
      "deliveryInstructions": "Ring doorbell twice, leave at front door if no answer",
      "specialRequirements": "Signature required",
      "items": 4,
      "weight": 12.5,
      "value": 2450.00,
      "attempts": 1,
      "maxAttempts": 3,
      "deliveryProof": null,
      "coordinates": {"lat": 34.0522, "lng": -118.2437},
    },
    {
      "id": "DEL-2024-002",
      "trackingNumber": "1234567890123456",
      "orderNumber": "ORD-45893",
      "customer": "Sarah Smith",
      "address": "456 Oak Avenue, Miami, FL 33101",
      "phone": "+1 555-0124",
      "status": "Delivered",
      "type": "Standard",
      "priority": "Medium",
      "deliveryDate": "2024-06-18",
      "timeSlot": "2:00 PM - 4:00 PM",
      "driver": "Lisa Davis",
      "vehicle": "Van-001",
      "estimatedArrival": "3:00 PM",
      "actualDelivery": "2024-06-18 14:45",
      "signature": "Sarah Smith",
      "deliveryInstructions": "Leave with reception",
      "specialRequirements": null,
      "items": 6,
      "weight": 8.2,
      "value": 1200.00,
      "attempts": 1,
      "maxAttempts": 3,
      "deliveryProof": "https://picsum.photos/300/200?random=1",
      "coordinates": {"lat": 25.7617, "lng": -80.1918},
    },
    {
      "id": "DEL-2024-003",
      "trackingNumber": "9876543210987654",
      "orderNumber": "ORD-45894",
      "customer": "Tech Solutions Ltd",
      "address": "789 Business Plaza, Suite 500, New York, NY 10001",
      "phone": "+1 555-0125",
      "status": "Failed Delivery",
      "type": "Express",
      "priority": "High",
      "deliveryDate": "2024-06-19",
      "timeSlot": "9:00 AM - 11:00 AM",
      "driver": "David Brown",
      "vehicle": "Truck-002",
      "estimatedArrival": "10:00 AM",
      "actualDelivery": null,
      "signature": null,
      "deliveryInstructions": "Business hours only, call before delivery",
      "specialRequirements": "ID verification required",
      "items": 12,
      "weight": 25.8,
      "value": 3200.00,
      "attempts": 2,
      "maxAttempts": 3,
      "failureReason": "Recipient not available",
      "rescheduleDate": "2024-06-20",
      "coordinates": {"lat": 40.7128, "lng": -74.0060},
    },
    {
      "id": "DEL-2024-004",
      "trackingNumber": "DHL123456789",
      "orderNumber": "ORD-45895",
      "customer": "Home Appliances Co",
      "address": "321 Elm Street, Dallas, TX 75201",
      "phone": "+1 555-0126",
      "status": "Delivered",
      "type": "Scheduled",
      "priority": "Low",
      "deliveryDate": "2024-06-17",
      "timeSlot": "1:00 PM - 3:00 PM",
      "driver": "Emma Wilson",
      "vehicle": "Van-002",
      "estimatedArrival": "2:00 PM",
      "actualDelivery": "2024-06-17 13:30",
      "signature": "Reception",
      "deliveryInstructions": "Delivery to loading dock",
      "specialRequirements": "Heavy items - forklift required",
      "items": 3,
      "weight": 45.2,
      "value": 1800.00,
      "attempts": 1,
      "maxAttempts": 3,
      "deliveryProof": "https://picsum.photos/300/200?random=2",
      "coordinates": {"lat": 32.7767, "lng": -96.7970},
    },
    {
      "id": "DEL-2024-005",
      "trackingNumber": "EXP987654321",
      "orderNumber": "ORD-45896",
      "customer": "Fashion Boutique",
      "address": "654 Cedar Avenue, Portland, OR 97201",
      "phone": "+1 555-0127",
      "status": "Rescheduled",
      "type": "Same Day",
      "priority": "High",
      "deliveryDate": "2024-06-19",
      "timeSlot": "4:00 PM - 6:00 PM",
      "driver": "Chris Anderson",
      "vehicle": "Bike-001",
      "estimatedArrival": "5:00 PM",
      "actualDelivery": null,
      "signature": null,
      "deliveryInstructions": "Ring buzzer for apartment 3B",
      "specialRequirements": null,
      "items": 2,
      "weight": 3.5,
      "value": 450.00,
      "attempts": 1,
      "maxAttempts": 3,
      "rescheduleDate": "2024-06-20",
      "rescheduleReason": "Customer request",
      "coordinates": {"lat": 45.5152, "lng": -122.6784},
    },
  ];

  List<Map<String, dynamic>> get filteredDeliveries {
    return deliveries.where((delivery) {
      final matchesSearch = delivery["id"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          delivery["customer"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          delivery["trackingNumber"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          delivery["orderNumber"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      final matchesStatus = selectedStatus == "All" || delivery["status"] == selectedStatus;
      final matchesType = selectedType == "All" || delivery["type"] == selectedType;
      final matchesPriority = selectedPriority == "All" || delivery["priority"] == selectedPriority;
      
      return matchesSearch && matchesStatus && matchesType && matchesPriority;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Delivered":
        return successColor;
      case "Out for Delivery":
        return primaryColor;
      case "Failed Delivery":
        return dangerColor;
      case "Returned":
        return warningColor;
      case "Rescheduled":
        return infoColor;
      default:
        return disabledColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return disabledColor;
    }
  }

  void _confirmDelivery(Map<String, dynamic> delivery) async {
    bool isConfirmed = await confirm("Confirm delivery for ${delivery["id"]}?");
    if (isConfirmed) {
      delivery["status"] = "Delivered";
      delivery["actualDelivery"] = DateTime.now().toString();
      delivery["signature"] = delivery["customer"];
      setState(() {});
      ss("Delivery confirmed for ${delivery["id"]}");
    }
  }

  void _markAsFailedDelivery(Map<String, dynamic> delivery) {
    showDialog(
      context: context,
      builder: (context) {
        String failureReason = "Recipient not available";
        List<String> reasons = [
          "Recipient not available",
          "Wrong address",
          "Refused delivery",
          "Access denied",
          "Weather conditions",
          "Vehicle breakdown",
          "Other"
        ];
        
        return AlertDialog(
          title: Text("Mark as Failed Delivery"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Select failure reason:"),
              SizedBox(height: spSm),
              ...reasons.map((reason) => ListTile(
                title: Text(reason),
                leading: Radio<String>(
                  value: reason,
                  groupValue: failureReason,
                  onChanged: (value) {
                    Navigator.pop(context);
                    delivery["status"] = "Failed Delivery";
                    delivery["failureReason"] = value;
                    delivery["attempts"] = (delivery["attempts"] as int) + 1;
                    setState(() {});
                    ss("Delivery marked as failed: $value");
                  },
                ),
              )),
            ],
          ),
          actions: [
            QButton(
              label: "Cancel",
              size: bs.sm,
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  void _rescheduleDelivery(Map<String, dynamic> delivery) {
    showDialog(
      context: context,
      builder: (context) {
        DateTime selectedDate = DateTime.now().add(Duration(days: 1));
        String timeSlot = "9:00 AM - 11:00 AM";
        
        List<String> timeSlots = [
          "9:00 AM - 11:00 AM",
          "11:00 AM - 1:00 PM",
          "1:00 PM - 3:00 PM",
          "3:00 PM - 5:00 PM",
          "5:00 PM - 7:00 PM"
        ];
        
        return StatefulBuilder(
          builder: (context, setDialogState) => AlertDialog(
            title: Text("Reschedule Delivery"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                QDatePicker(
                  label: "New Delivery Date",
                  value: selectedDate,
                  onChanged: (value) {
                    selectedDate = value;
                    setDialogState(() {});
                  },
                ),
                SizedBox(height: spSm),
                QDropdownField(
                  label: "Time Slot",
                  items: timeSlots.map((slot) => {"label": slot, "value": slot}).toList(),
                  value: timeSlot,
                  onChanged: (value, label) {
                    timeSlot = value;
                    setDialogState(() {});
                  },
                ),
              ],
            ),
            actions: [
              QButton(
                label: "Cancel",
                size: bs.sm,
                onPressed: () => Navigator.pop(context),
              ),
              QButton(
                label: "Reschedule",
                size: bs.sm,
                onPressed: () {
                  delivery["status"] = "Rescheduled";
                  delivery["rescheduleDate"] = selectedDate.toIso8601String().split('T')[0];
                  delivery["timeSlot"] = timeSlot;
                  setState(() {});
                  Navigator.pop(context);
                  ss("Delivery rescheduled for ${delivery["id"]}");
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _viewDeliveryDetails(Map<String, dynamic> delivery) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delivery Details"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("ID: ${delivery["id"]}", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: spXs),
              Text("Tracking: ${delivery["trackingNumber"]}"),
              Text("Order: ${delivery["orderNumber"]}"),
              Text("Customer: ${delivery["customer"]}"),
              Text("Phone: ${delivery["phone"]}"),
              Text("Status: ${delivery["status"]}"),
              Text("Type: ${delivery["type"]}"),
              Text("Priority: ${delivery["priority"]}"),
              Text("Address: ${delivery["address"]}"),
              Text("Driver: ${delivery["driver"]}"),
              Text("Vehicle: ${delivery["vehicle"]}"),
              Text("Items: ${delivery["items"]}"),
              Text("Weight: ${delivery["weight"]} kg"),
              Text("Value: \$${(delivery["value"] as double).currency}"),
              Text("Attempts: ${delivery["attempts"]}/${delivery["maxAttempts"]}"),
              if (delivery["deliveryInstructions"] != null)
                Text("Instructions: ${delivery["deliveryInstructions"]}"),
              if (delivery["specialRequirements"] != null)
                Text("Requirements: ${delivery["specialRequirements"]}"),
              if (delivery["actualDelivery"] != null)
                Text("Delivered: ${delivery["actualDelivery"]}"),
              if (delivery["signature"] != null)
                Text("Signature: ${delivery["signature"]}"),
              if (delivery["failureReason"] != null)
                Text("Failure Reason: ${delivery["failureReason"]}"),
            ],
          ),
        ),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _viewDeliveryProof(Map<String, dynamic> delivery) {
    if (delivery["deliveryProof"] != null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Delivery Proof"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                "${delivery["deliveryProof"]}",
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              SizedBox(height: spSm),
              Text("Delivered: ${delivery["actualDelivery"]}"),
              Text("Signature: ${delivery["signature"]}"),
            ],
          ),
          actions: [
            QButton(
              label: "Close",
              size: bs.sm,
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildDeliveryCard(Map<String, dynamic> delivery) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
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
                    Text(
                      "${delivery["id"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${delivery["customer"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor(delivery["status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${delivery["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor(delivery["status"]),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.local_shipping, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${delivery["type"]}",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: _getPriorityColor(delivery["priority"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${delivery["priority"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: _getPriorityColor(delivery["priority"]),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusXs),
              border: Border.all(color: primaryColor.withAlpha(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.place, size: 14, color: primaryColor),
                    SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        "${delivery["address"]}",
                        style: TextStyle(fontSize: 11, color: disabledBoldColor),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(Icons.phone, size: 14, color: disabledBoldColor),
                    SizedBox(width: 4),
                    Text(
                      "${delivery["phone"]}",
                      style: TextStyle(fontSize: 11, color: disabledBoldColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.person, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${delivery["driver"]}",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
              Spacer(),
              Icon(Icons.schedule, size: 16, color: warningColor),
              SizedBox(width: spXs),
              Text(
                "${delivery["timeSlot"]}",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.inventory, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${delivery["items"]} items",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
              Spacer(),
              Icon(Icons.attach_money, size: 16, color: successColor),
              SizedBox(width: spXs),
              Text(
                "\$${(delivery["value"] as double).currency}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
            ],
          ),
          if (delivery["attempts"] > 1) ...[
            SizedBox(height: spSm),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning, size: 16, color: warningColor),
                  SizedBox(width: spXs),
                  Text(
                    "Attempt ${delivery["attempts"]}/${delivery["maxAttempts"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: warningColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
          if (delivery["deliveryInstructions"] != null) ...[
            SizedBox(height: spSm),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                children: [
                  Icon(Icons.info, size: 16, color: infoColor),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "${delivery["deliveryInstructions"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: infoColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Details",
                  size: bs.sm,
                  onPressed: () => _viewDeliveryDetails(delivery),
                ),
              ),
              SizedBox(width: spSm),
              if (delivery["status"] == "Out for Delivery") ...[
                QButton(
                  label: "Delivered",
                  size: bs.sm,
                  onPressed: () => _confirmDelivery(delivery),
                ),
                SizedBox(width: spSm),
                QButton(
                  label: "Failed",
                  size: bs.sm,
                  onPressed: () => _markAsFailedDelivery(delivery),
                ),
              ] else if (delivery["status"] == "Failed Delivery") ...[
                QButton(
                  label: "Reschedule",
                  size: bs.sm,
                  onPressed: () => _rescheduleDelivery(delivery),
                ),
              ] else if (delivery["status"] == "Delivered" && delivery["deliveryProof"] != null) ...[
                QButton(
                  label: "View Proof",
                  size: bs.sm,
                  onPressed: () => _viewDeliveryProof(delivery),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    int totalDeliveries = deliveries.length;
    int outForDelivery = deliveries.where((d) => d["status"] == "Out for Delivery").length;
    int delivered = deliveries.where((d) => d["status"] == "Delivered").length;
    int failed = deliveries.where((d) => d["status"] == "Failed Delivery").length;
    int rescheduled = deliveries.where((d) => d["status"] == "Rescheduled").length;

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.local_shipping, color: primaryColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "$totalDeliveries",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Total Deliveries",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.delivery_dining, color: warningColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "$outForDelivery",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                    Text(
                      "Out for Delivery",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.check_circle, color: successColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "$delivered",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Delivered",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: dangerColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.error, color: dangerColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "$failed",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                    Text(
                      "Failed",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spLg),
          Text(
            "Today's Deliveries",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...deliveries.where((d) => d["deliveryDate"] == "2024-06-19").map((delivery) => _buildDeliveryCard(delivery)),
        ],
      ),
    );
  }

  Widget _buildActiveTab() {
    List<Map<String, dynamic>> activeDeliveries = deliveries.where((d) => 
        d["status"] == "Out for Delivery" || d["status"] == "Rescheduled").toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search deliveries...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Filter by Status",
                  items: statusItems,
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
                  label: "Filter by Type",
                  items: typeItems,
                  value: selectedType,
                  onChanged: (value, label) {
                    selectedType = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spLg),
          if (activeDeliveries.isEmpty)
            Center(
              child: Column(
                children: [
                  Icon(Icons.inbox, size: 64, color: disabledColor),
                  SizedBox(height: spSm),
                  Text(
                    "No active deliveries found",
                    style: TextStyle(color: disabledBoldColor),
                  ),
                ],
              ),
            )
          else
            ...filteredDeliveries.where((d) => d["status"] == "Out for Delivery" || d["status"] == "Rescheduled").map((delivery) => _buildDeliveryCard(delivery)),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    List<Map<String, dynamic>> completedDeliveries = deliveries.where((d) => 
        d["status"] == "Delivered" || d["status"] == "Failed Delivery" || d["status"] == "Returned").toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search delivery history...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spLg),
          if (completedDeliveries.isEmpty)
            Center(
              child: Column(
                children: [
                  Icon(Icons.history, size: 64, color: disabledColor),
                  SizedBox(height: spSm),
                  Text(
                    "No delivery history found",
                    style: TextStyle(color: disabledBoldColor),
                  ),
                ],
              ),
            )
          else
            ...completedDeliveries.map((delivery) => _buildDeliveryCard(delivery)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Delivery",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Active", icon: Icon(Icons.delivery_dining)),
        Tab(text: "History", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildActiveTab(),
        _buildHistoryTab(),
      ],
    );
  }
}
