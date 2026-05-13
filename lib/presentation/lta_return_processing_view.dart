import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaReturnProcessingView extends StatefulWidget {
  const LtaReturnProcessingView({super.key});

  @override
  State<LtaReturnProcessingView> createState() => _LtaReturnProcessingViewState();
}

class _LtaReturnProcessingViewState extends State<LtaReturnProcessingView> {
  bool loading = false;
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedReason = "All";
  String sortBy = "Date";
  int currentTab = 0;

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Pending", "value": "Pending"},
    {"label": "In Transit", "value": "In Transit"},
    {"label": "Processed", "value": "Processed"},
    {"label": "Completed", "value": "Completed"},
    {"label": "Cancelled", "value": "Cancelled"},
  ];

  List<Map<String, dynamic>> reasonOptions = [
    {"label": "All", "value": "All"},
    {"label": "Customer Refused", "value": "Customer Refused"},
    {"label": "Address Not Found", "value": "Address Not Found"},
    {"label": "Damaged Package", "value": "Damaged Package"},
    {"label": "Wrong Item", "value": "Wrong Item"},
    {"label": "Customer Request", "value": "Customer Request"},
    {"label": "Delivery Failed", "value": "Delivery Failed"},
    {"label": "Other", "value": "Other"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Date", "value": "Date"},
    {"label": "Status", "value": "Status"},
    {"label": "Customer", "value": "Customer"},
    {"label": "Value", "value": "Value"},
  ];

  List<Map<String, dynamic>> returns = [
    {
      "id": "RTN-2024-001234",
      "originalDeliveryId": "DEL-2024-001523",
      "trackingNumber": "LTA-RTN-456789",
      "customerName": "John Mitchell",
      "customerPhone": "+1 (555) 123-4567",
      "returnDate": "2024-01-15",
      "returnTime": "16:45",
      "reason": "Customer Refused",
      "description": "Customer was not expecting the package",
      "packageType": "Standard Package",
      "packageWeight": "2.5 kg",
      "packageValue": 150.00,
      "returnLocation": "125 Business Plaza, Suite 402",
      "status": "Pending",
      "priority": "High",
      "driverName": "Michael Rodriguez",
      "vehicleNumber": "LTA-VH-234",
      "returnToSender": true,
      "senderName": "TechMart Electronics",
      "senderAddress": "789 Commerce Street, Business District",
      "refundRequired": true,
      "refundAmount": 150.00,
      "returnFee": 15.00,
      "lastUpdated": "2024-01-15T16:45:00.000Z",
    },
    {
      "id": "RTN-2024-001235",
      "originalDeliveryId": "DEL-2024-001524",
      "trackingNumber": "LTA-RTN-456790",
      "customerName": "Sarah Williams",
      "customerPhone": "+1 (555) 234-5678",
      "returnDate": "2024-01-15",
      "returnTime": "14:20",
      "reason": "Damaged Package",
      "description": "Package was damaged during transit - box crushed",
      "packageType": "Fragile Package",
      "packageWeight": "1.8 kg",
      "packageValue": 89.99,
      "returnLocation": "567 Residential Ave, Apartment 3B",
      "status": "In Transit",
      "priority": "Medium",
      "driverName": "David Chen",
      "vehicleNumber": "LTA-VH-189",
      "returnToSender": true,
      "senderName": "GlassWorks Studio",
      "senderAddress": "234 Artist Lane, Creative Quarter",
      "refundRequired": true,
      "refundAmount": 89.99,
      "returnFee": 0.00,
      "lastUpdated": "2024-01-15T15:30:00.000Z",
    },
    {
      "id": "RTN-2024-001236",
      "originalDeliveryId": "DEL-2024-001525",
      "trackingNumber": "LTA-RTN-456791",
      "customerName": "Robert Johnson",
      "customerPhone": "+1 (555) 345-6789",
      "returnDate": "2024-01-14",
      "returnTime": "11:15",
      "reason": "Wrong Item",
      "description": "Customer received incorrect product - ordered blue, received red",
      "packageType": "Standard Package",
      "packageWeight": "0.8 kg",
      "packageValue": 45.50,
      "returnLocation": "890 Oak Street, House 12",
      "status": "Processed",
      "priority": "Low",
      "driverName": "Lisa Thompson",
      "vehicleNumber": "LTA-VH-156",
      "returnToSender": true,
      "senderName": "Fashion Forward",
      "senderAddress": "456 Style Boulevard, Shopping Center",
      "refundRequired": false,
      "refundAmount": 0.00,
      "returnFee": 8.50,
      "lastUpdated": "2024-01-14T16:22:00.000Z",
    },
    {
      "id": "RTN-2024-001237",
      "originalDeliveryId": "DEL-2024-001526",
      "trackingNumber": "LTA-RTN-456792",
      "customerName": "Emily Davis",
      "customerPhone": "+1 (555) 456-7890",
      "returnDate": "2024-01-13",
      "returnTime": "09:30",
      "reason": "Customer Request",
      "description": "Customer changed mind about purchase",
      "packageType": "Express Package",
      "packageWeight": "3.2 kg",
      "packageValue": 299.99,
      "returnLocation": "123 Main Street, Office Building",
      "status": "Completed",
      "priority": "Medium",
      "driverName": "James Wilson",
      "vehicleNumber": "LTA-VH-201",
      "returnToSender": true,
      "senderName": "HomeDecor Plus",
      "senderAddress": "678 Design Avenue, Furniture District",
      "refundRequired": true,
      "refundAmount": 284.99,
      "returnFee": 15.00,
      "lastUpdated": "2024-01-13T17:45:00.000Z",
    },
  ];

  List<Map<String, dynamic>> get filteredReturns {
    List<Map<String, dynamic>> filtered = returns;

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((returnItem) {
        return (returnItem["id"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
               (returnItem["customerName"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
               (returnItem["trackingNumber"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    if (selectedStatus != "All") {
      filtered = filtered.where((returnItem) => returnItem["status"] == selectedStatus).toList();
    }

    if (selectedReason != "All") {
      filtered = filtered.where((returnItem) => returnItem["reason"] == selectedReason).toList();
    }

    return filtered;
  }

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() async {
    loading = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 1));

    loading = false;
    setState(() {});
  }

  void _processReturn(Map<String, dynamic> returnItem) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Process Return",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Return ID: ${returnItem["id"]}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Customer: ${returnItem["customerName"]}",
              style: TextStyle(fontSize: 12, color: disabledBoldColor),
            ),
            Text(
              "Reason: ${returnItem["reason"]}",
              style: TextStyle(fontSize: 12, color: disabledBoldColor),
            ),
            Text(
              "Value: \$${(returnItem["packageValue"] as double).currency}",
              style: TextStyle(fontSize: 12, color: disabledBoldColor),
            ),
            SizedBox(height: spSm),
            Text(
              "Select action to process this return:",
              style: TextStyle(fontSize: 12, color: disabledBoldColor),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Accept",
            size: bs.sm,
            onPressed: () {
              back();
              _updateReturnStatus(returnItem["id"], "In Transit");
            },
          ),
          QButton(
            label: "Reject",
            size: bs.sm,
            onPressed: () {
              back();
              _showRejectDialog(returnItem);
            },
          ),
        ],
      ),
    );
  }

  void _showRejectDialog(Map<String, dynamic> returnItem) {
    String rejectionReason = "";
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Reject Return",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: dangerColor,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Please provide reason for rejecting this return:",
              style: TextStyle(fontSize: 12, color: disabledBoldColor),
            ),
            SizedBox(height: spSm),
            QMemoField(
              label: "Rejection Reason",
              value: rejectionReason,
              hint: "Explain why this return is being rejected",
              onChanged: (value) {
                rejectionReason = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Reject Return",
            size: bs.sm,
            onPressed: () {
              back();
              _updateReturnStatus(returnItem["id"], "Cancelled");
              ss("Return rejected");
            },
          ),
        ],
      ),
    );
  }

  void _updateReturnStatus(String returnId, String newStatus) {
    int index = returns.indexWhere((item) => item["id"] == returnId);
    if (index != -1) {
      returns[index]["status"] = newStatus;
      returns[index]["lastUpdated"] = DateTime.now().toIso8601String();
      setState(() {});
      ss("Return status updated to $newStatus");
    }
  }

  void _viewReturnDetails(Map<String, dynamic> returnItem) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Return Details",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        content: Container(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow("Return ID", returnItem["id"]),
                _buildDetailRow("Original Delivery", returnItem["originalDeliveryId"]),
                _buildDetailRow("Tracking Number", returnItem["trackingNumber"]),
                _buildDetailRow("Customer", returnItem["customerName"]),
                _buildDetailRow("Phone", returnItem["customerPhone"]),
                _buildDetailRow("Return Date", "${returnItem["returnDate"]} ${returnItem["returnTime"]}"),
                _buildDetailRow("Reason", returnItem["reason"]),
                _buildDetailRow("Description", returnItem["description"]),
                _buildDetailRow("Package Type", returnItem["packageType"]),
                _buildDetailRow("Weight", returnItem["packageWeight"]),
                _buildDetailRow("Value", "\$${(returnItem["packageValue"] as double).currency}"),
                _buildDetailRow("Location", returnItem["returnLocation"]),
                _buildDetailRow("Status", returnItem["status"]),
                _buildDetailRow("Priority", returnItem["priority"]),
                _buildDetailRow("Driver", returnItem["driverName"]),
                _buildDetailRow("Vehicle", returnItem["vehicleNumber"]),
                if (returnItem["returnToSender"] == true) ...[
                  _buildDetailRow("Sender", returnItem["senderName"]),
                  _buildDetailRow("Sender Address", returnItem["senderAddress"]),
                ],
                if (returnItem["refundRequired"] == true) ...[
                  _buildDetailRow("Refund Amount", "\$${(returnItem["refundAmount"] as double).currency}"),
                ],
                _buildDetailRow("Return Fee", "\$${(returnItem["returnFee"] as double).currency}"),
                _buildDetailRow("Last Updated", returnItem["lastUpdated"]),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Close"),
          ),
          if (returnItem["status"] == "Pending")
            QButton(
              label: "Process",
              size: bs.sm,
              onPressed: () {
                back();
                _processReturn(returnItem);
              },
            ),
        ],
      ),
    );
  }

  void _createNewReturn() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Create New Return",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        content: Text(
          "This will open the return creation form with delivery tracking and customer information.",
          style: TextStyle(fontSize: 14, color: disabledBoldColor),
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Continue",
            size: bs.sm,
            onPressed: () {
              back();
              //navigateTo ('')
              ss("Opening return creation form");
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Return Processing"),
        actions: [
          IconButton(
            onPressed: _createNewReturn,
            icon: Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              // Export reports
            },
            icon: Icon(Icons.file_download),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Statistics Cards
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    "Total Returns",
                    "${returns.length}",
                    Icons.assignment_return,
                    primaryColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildStatCard(
                    "Pending",
                    "${returns.where((r) => r["status"] == "Pending").length}",
                    Icons.pending,
                    warningColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildStatCard(
                    "Completed",
                    "${returns.where((r) => r["status"] == "Completed").length}",
                    Icons.check_circle,
                    successColor,
                  ),
                ),
              ],
            ),

            SizedBox(height: spMd),

            // Value Summary
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    "Total Value",
                    "\$${returns.fold(0.0, (sum, r) => sum + (r["packageValue"] as double)).toStringAsFixed(2)}",
                    Icons.attach_money,
                    infoColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildStatCard(
                    "Refunds Due",
                    "\$${returns.where((r) => r["refundRequired"] == true).fold(0.0, (sum, r) => sum + (r["refundAmount"] as double)).toStringAsFixed(2)}",
                    Icons.money_off,
                    dangerColor,
                  ),
                ),
              ],
            ),

            SizedBox(height: spMd),

            // Search and Filters
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search Returns",
                    value: searchQuery,
                    hint: "Search by ID, customer, or tracking number",
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
                    label: "Reason",
                    items: reasonOptions,
                    value: selectedReason,
                    onChanged: (value, label) {
                      selectedReason = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Sort By",
                    items: sortOptions,
                    value: sortBy,
                    onChanged: (value, label) {
                      sortBy = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: spMd),

            // Returns List
            Text(
              "Returns (${filteredReturns.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            if (filteredReturns.isEmpty) ...[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  border: Border.all(color: disabledOutlineBorderColor),
                  borderRadius: BorderRadius.circular(radiusSm),
                  color: Colors.grey[50],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.assignment_return,
                      size: 64,
                      color: disabledBoldColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No returns found",
                      style: TextStyle(
                        fontSize: 16,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your search criteria or create a new return",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
              ...List.generate(filteredReturns.length, (index) {
                final returnItem = filteredReturns[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: disabledOutlineBorderColor),
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
                                  returnItem["id"],
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${returnItem["customerName"]} • ${returnItem["returnDate"]}",
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
                              color: _getStatusColor(returnItem["status"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                              border: Border.all(
                                color: _getStatusColor(returnItem["status"]).withAlpha(50),
                              ),
                            ),
                            child: Text(
                              returnItem["status"],
                              style: TextStyle(
                                fontSize: 10,
                                color: _getStatusColor(returnItem["status"]),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: spSm),

                      Row(
                        children: [
                          Icon(Icons.inventory, size: 16, color: disabledBoldColor),
                          SizedBox(width: spXs),
                          Text(
                            "${returnItem["packageType"]} (${returnItem["packageWeight"]})",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "\$${(returnItem["packageValue"] as double).currency}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: spXs),

                      Row(
                        children: [
                          Icon(Icons.info, size: 16, color: disabledBoldColor),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "${returnItem["reason"]}: ${returnItem["description"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                        ],
                      ),

                      if (returnItem["refundRequired"] == true) ...[
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Icon(Icons.payment, size: 16, color: warningColor),
                            SizedBox(width: spXs),
                            Text(
                              "Refund Required: \$${(returnItem["refundAmount"] as double).currency}",
                              style: TextStyle(
                                fontSize: 12,
                                color: warningColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],

                      SizedBox(height: spSm),

                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "View Details",
                              icon: Icons.visibility,
                              size: bs.sm,
                              onPressed: () => _viewReturnDetails(returnItem),
                            ),
                          ),
                          SizedBox(width: spSm),
                          if (returnItem["status"] == "Pending")
                            Expanded(
                              child: QButton(
                                label: "Process",
                                icon: Icons.play_arrow,
                                size: bs.sm,
                                onPressed: () => _processReturn(returnItem),
                              ),
                            ),
                          if (returnItem["status"] != "Pending")
                            Expanded(
                              child: QButton(
                                label: "Track",
                                icon: Icons.location_on,
                                size: bs.sm,
                                onPressed: () {
                                  // Track return
                                },
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              "$label:",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12,
                color: primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Pending":
        return warningColor;
      case "In Transit":
        return infoColor;
      case "Processed":
        return primaryColor;
      case "Completed":
        return successColor;
      case "Cancelled":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }
}
