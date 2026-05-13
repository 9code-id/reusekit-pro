import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaFailedDeliveryView extends StatefulWidget {
  const DlaFailedDeliveryView({Key? key}) : super(key: key);

  @override
  State<DlaFailedDeliveryView> createState() => _DlaFailedDeliveryViewState();
}

class _DlaFailedDeliveryViewState extends State<DlaFailedDeliveryView> {
  String searchQuery = "";
  String selectedReason = "All";
  String selectedPriority = "All";
  String sortBy = "Latest";

  List<Map<String, dynamic>> failedDeliveries = [
    {
      "id": "DEL001",
      "orderId": "ORD-2024-001",
      "customerName": "Sarah Johnson",
      "address": "123 Main St, Downtown",
      "reason": "Customer Not Available",
      "failedAt": "2024-01-15T14:30:00",
      "attempts": 2,
      "priority": "High",
      "contact": "+1 234 567 8901",
      "value": 245.50,
      "items": ["Wireless Headphones", "Phone Case"],
      "status": "Pending Retry",
      "driverNotes": "Customer not at home during delivery window",
      "nextAttempt": "2024-01-16T10:00:00",
    },
    {
      "id": "DEL002", 
      "orderId": "ORD-2024-002",
      "customerName": "Michael Chen",
      "address": "456 Oak Ave, Suburb",
      "reason": "Wrong Address",
      "failedAt": "2024-01-15T11:15:00",
      "attempts": 1,
      "priority": "Medium",
      "contact": "+1 234 567 8902",
      "value": 89.99,
      "items": ["Book Set"],
      "status": "Address Verification Required",
      "driverNotes": "Address doesn't exist, customer needs to confirm",
      "nextAttempt": null,
    },
    {
      "id": "DEL003",
      "orderId": "ORD-2024-003", 
      "customerName": "Emily Davis",
      "address": "789 Pine St, City Center",
      "reason": "Refused Delivery",
      "failedAt": "2024-01-14T16:45:00",
      "attempts": 1,
      "priority": "Low",
      "contact": "+1 234 567 8903",
      "value": 156.75,
      "items": ["Kitchen Appliance", "Cookware"],
      "status": "Return to Sender",
      "driverNotes": "Customer refused package, claims didn't order",
      "nextAttempt": null,
    },
    {
      "id": "DEL004",
      "orderId": "ORD-2024-004",
      "customerName": "Robert Wilson",
      "address": "321 Elm Dr, Residential",
      "reason": "Security Issues", 
      "failedAt": "2024-01-14T13:20:00",
      "attempts": 2,
      "priority": "High",
      "contact": "+1 234 567 8904",
      "value": 1299.00,
      "items": ["Laptop", "Accessories"],
      "status": "Special Handling Required",
      "driverNotes": "Gated community, no access code provided",
      "nextAttempt": "2024-01-16T15:00:00",
    },
    {
      "id": "DEL005",
      "orderId": "ORD-2024-005",
      "customerName": "Lisa Anderson",
      "address": "654 Maple Rd, Outskirts",
      "reason": "Damaged Package",
      "failedAt": "2024-01-13T09:30:00",
      "attempts": 1,
      "priority": "Medium",
      "contact": "+1 234 567 8905", 
      "value": 78.25,
      "items": ["Fragile Items", "Glassware"],
      "status": "Replacement Processing",
      "driverNotes": "Package damaged during transport, needs replacement",
      "nextAttempt": null,
    },
  ];

  List<Map<String, dynamic>> get filteredDeliveries {
    List<Map<String, dynamic>> filtered = failedDeliveries;

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((delivery) {
        return "${delivery["customerName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
               "${delivery["orderId"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
               "${delivery["address"]}".toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    if (selectedReason != "All") {
      filtered = filtered.where((delivery) => delivery["reason"] == selectedReason).toList();
    }

    if (selectedPriority != "All") {
      filtered = filtered.where((delivery) => delivery["priority"] == selectedPriority).toList();
    }

    if (sortBy == "Latest") {
      filtered.sort((a, b) => DateTime.parse("${b["failedAt"]}").compareTo(DateTime.parse("${a["failedAt"]}")));
    } else if (sortBy == "Priority") {
      Map<String, int> priorityOrder = {"High": 3, "Medium": 2, "Low": 1};
      filtered.sort((a, b) => (priorityOrder[b["priority"]] ?? 0).compareTo(priorityOrder[a["priority"]] ?? 0));
    } else if (sortBy == "Value") {
      filtered.sort((a, b) => (b["value"] as double).compareTo(a["value"] as double));
    }

    return filtered;
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

  Color _getStatusColor(String status) {
    switch (status) {
      case "Pending Retry":
        return warningColor;
      case "Address Verification Required":
        return infoColor;
      case "Return to Sender":
        return dangerColor;
      case "Special Handling Required":
        return warningColor;
      case "Replacement Processing":
        return infoColor;
      default:
        return disabledColor;
    }
  }

  void _showDeliveryDetails(Map<String, dynamic> delivery) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
      ),
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
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
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.close, color: disabledBoldColor),
                ),
              ],
            ),
            SizedBox(height: spMd),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: _getPriorityColor("${delivery["priority"]}").withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: _getPriorityColor("${delivery["priority"]}"),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.priority_high,
                            color: _getPriorityColor("${delivery["priority"]}"),
                            size: 20,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${delivery["priority"]} Priority",
                            style: TextStyle(
                              color: _getPriorityColor("${delivery["priority"]}"),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        Expanded(
                          child: _buildDetailItem("Order ID", "${delivery["orderId"]}"),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: _buildDetailItem("Delivery ID", "${delivery["id"]}"),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    _buildDetailItem("Customer", "${delivery["customerName"]}"),
                    SizedBox(height: spSm),
                    _buildDetailItem("Contact", "${delivery["contact"]}"),
                    SizedBox(height: spSm),
                    _buildDetailItem("Address", "${delivery["address"]}"),
                    SizedBox(height: spSm),
                    _buildDetailItem("Failure Reason", "${delivery["reason"]}"),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: _buildDetailItem("Failed At", DateTime.parse("${delivery["failedAt"]}").dMMMy),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: _buildDetailItem("Attempts", "${delivery["attempts"]}"),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    _buildDetailItem("Order Value", "\$${(delivery["value"] as double).currency}"),
                    SizedBox(height: spSm),
                    _buildDetailItem("Items", (delivery["items"] as List).join(", ")),
                    SizedBox(height: spSm),
                    _buildDetailItem("Driver Notes", "${delivery["driverNotes"]}"),
                    if (delivery["nextAttempt"] != null) ...[
                      SizedBox(height: spSm),
                      _buildDetailItem("Next Attempt", DateTime.parse("${delivery["nextAttempt"]}").dMMMy),
                    ],
                    SizedBox(height: spLg),
                    Text(
                      "Available Actions",
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
                          child: QButton(
                            label: "Schedule Retry",
                            icon: Icons.schedule,
                            size: bs.sm,
                            onPressed: () {
                              Navigator.pop(context);
                              _scheduleRetry(delivery);
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Contact Customer",
                            icon: Icons.phone,
                            size: bs.sm,
                            onPressed: () {
                              Navigator.pop(context);
                              _contactCustomer(delivery);
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Mark as Resolved",
                        icon: Icons.check_circle,
                        size: bs.sm,
                        onPressed: () {
                          Navigator.pop(context);
                          _markAsResolved(delivery);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: primaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  void _scheduleRetry(Map<String, dynamic> delivery) {
    ss("Retry scheduled for ${delivery["customerName"]}");
  }

  void _contactCustomer(Map<String, dynamic> delivery) {
    ss("Calling ${delivery["customerName"]}...");
  }

  void _markAsResolved(Map<String, dynamic> delivery) {
    ss("Delivery marked as resolved");
    setState(() {
      failedDeliveries.removeWhere((d) => d["id"] == delivery["id"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Failed Deliveries"),
        actions: [
          GestureDetector(
            onTap: () {
              // Navigate to reports
            },
            child: Icon(Icons.analytics),
          ),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
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
                    hint: "Order ID, customer name, address",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.filter_list,
                  size: bs.sm,
                  onPressed: () => _showFilterOptions(),
                ),
              ],
            ),
            SizedBox(height: spMd),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: dangerColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: dangerColor.withAlpha(100)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.error, color: dangerColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "${filteredDeliveries.length} Failed Deliveries",
                        style: TextStyle(
                          color: dangerColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Text(
                  "Sort: $sortBy",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
                SizedBox(width: spXs),
                GestureDetector(
                  onTap: () => _showSortOptions(),
                  child: Icon(
                    Icons.sort,
                    color: primaryColor,
                    size: 16,
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            ...filteredDeliveries.map((delivery) => Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: _getPriorityColor("${delivery["priority"]}"),
                  ),
                ),
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
                            Row(
                              children: [
                                Text(
                                  "${delivery["orderId"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getPriorityColor("${delivery["priority"]}").withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${delivery["priority"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: _getPriorityColor("${delivery["priority"]}"),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${delivery["customerName"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
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
                            "\$${(delivery["value"] as double).currency}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Attempt ${delivery["attempts"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: disabledBoldColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "${delivery["address"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: dangerColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "${delivery["reason"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: dangerColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: disabledBoldColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Failed: ${DateTime.parse("${delivery["failedAt"]}").dMMMy}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: spXs),
                    decoration: BoxDecoration(
                      color: _getStatusColor("${delivery["status"]}").withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${delivery["status"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: _getStatusColor("${delivery["status"]}"),
                        fontWeight: FontWeight.w600,
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
                          onPressed: () => _showDeliveryDetails(delivery),
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.phone,
                        size: bs.sm,
                        onPressed: () => _contactCustomer(delivery),
                      ),
                      SizedBox(width: spXs),
                      QButton(
                        icon: Icons.schedule,
                        size: bs.sm,
                        onPressed: () => _scheduleRetry(delivery),
                      ),
                    ],
                  ),
                ],
              ),
            )).toList(),
            if (filteredDeliveries.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 64,
                      color: successColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No Failed Deliveries",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "All deliveries are running smoothly!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Filter Options",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            QDropdownField(
              label: "Failure Reason",
              items: [
                {"label": "All", "value": "All"},
                {"label": "Customer Not Available", "value": "Customer Not Available"},
                {"label": "Wrong Address", "value": "Wrong Address"},
                {"label": "Refused Delivery", "value": "Refused Delivery"},
                {"label": "Security Issues", "value": "Security Issues"},
                {"label": "Damaged Package", "value": "Damaged Package"},
              ],
              value: selectedReason,
              onChanged: (value, label) {
                selectedReason = value;
                setState(() {});
                Navigator.pop(context);
              },
            ),
            SizedBox(height: spSm),
            QDropdownField(
              label: "Priority Level",
              items: [
                {"label": "All", "value": "All"},
                {"label": "High", "value": "High"},
                {"label": "Medium", "value": "Medium"},
                {"label": "Low", "value": "Low"},
              ],
              value: selectedPriority,
              onChanged: (value, label) {
                selectedPriority = value;
                setState(() {});
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Sort By",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            ...["Latest", "Priority", "Value"].map((option) => GestureDetector(
              onTap: () {
                sortBy = option;
                setState(() {});
                Navigator.pop(context);
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(spSm),
                margin: EdgeInsets.only(bottom: spXs),
                decoration: BoxDecoration(
                  color: sortBy == option ? primaryColor.withAlpha(20) : Colors.transparent,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Icon(
                      sortBy == option ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                      color: sortBy == option ? primaryColor : disabledBoldColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      option,
                      style: TextStyle(
                        color: sortBy == option ? primaryColor : disabledBoldColor,
                        fontWeight: sortBy == option ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }
}
