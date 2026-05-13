import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaReturnsView extends StatefulWidget {
  const ImaReturnsView({super.key});

  @override
  State<ImaReturnsView> createState() => _ImaReturnsViewState();
}

class _ImaReturnsViewState extends State<ImaReturnsView> {
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedReason = "All";
  String selectedType = "All";
  int currentTab = 0;

  List<Map<String, dynamic>> statusItems = [
    {"label": "All Status", "value": "All"},
    {"label": "Requested", "value": "Requested"},
    {"label": "Approved", "value": "Approved"},
    {"label": "Rejected", "value": "Rejected"},
    {"label": "In Transit", "value": "In Transit"},
    {"label": "Received", "value": "Received"},
    {"label": "Processed", "value": "Processed"},
    {"label": "Refunded", "value": "Refunded"},
  ];

  List<Map<String, dynamic>> reasonItems = [
    {"label": "All Reasons", "value": "All"},
    {"label": "Defective", "value": "Defective"},
    {"label": "Wrong Item", "value": "Wrong Item"},
    {"label": "Not as Described", "value": "Not as Described"},
    {"label": "Damaged in Transit", "value": "Damaged in Transit"},
    {"label": "Changed Mind", "value": "Changed Mind"},
    {"label": "Quality Issues", "value": "Quality Issues"},
    {"label": "Size Issues", "value": "Size Issues"},
  ];

  List<Map<String, dynamic>> typeItems = [
    {"label": "All Types", "value": "All"},
    {"label": "Refund", "value": "Refund"},
    {"label": "Exchange", "value": "Exchange"},
    {"label": "Store Credit", "value": "Store Credit"},
  ];

  List<Map<String, dynamic>> returns = [
    {
      "id": "RET-2024-001",
      "orderNumber": "ORD-45892",
      "customer": "John Doe",
      "email": "john.doe@email.com",
      "phone": "+1 555-0123",
      "status": "Requested",
      "reason": "Defective",
      "type": "Refund",
      "requestDate": "2024-06-19",
      "expectedReturn": "2024-06-26",
      "actualReturn": null,
      "processedBy": null,
      "processedDate": null,
      "refundAmount": 299.99,
      "restockingFee": 0.00,
      "shippingCost": 12.99,
      "totalRefund": 299.99,
      "returnAddress": "123 Main St, Los Angeles, CA 90210",
      "trackingNumber": null,
      "description": "Product stopped working after 2 days of use. Screen goes black randomly.",
      "images": [
        "https://picsum.photos/200/200?random=1",
        "https://picsum.photos/200/200?random=2"
      ],
      "items": [
        {
          "sku": "ELEC-001",
          "name": "Smartphone",
          "quantity": 1,
          "price": 299.99,
          "condition": "Defective"
        }
      ]
    },
    {
      "id": "RET-2024-002",
      "orderNumber": "ORD-45893",
      "customer": "Sarah Smith", 
      "email": "sarah.smith@email.com",
      "phone": "+1 555-0124",
      "status": "In Transit",
      "reason": "Wrong Item",
      "type": "Exchange",
      "requestDate": "2024-06-17",
      "expectedReturn": "2024-06-24",
      "actualReturn": null,
      "processedBy": "Mike Johnson",
      "processedDate": "2024-06-17",
      "refundAmount": 0.00,
      "restockingFee": 0.00,
      "shippingCost": 0.00,
      "totalRefund": 0.00,
      "returnAddress": "456 Oak Ave, Miami, FL 33101",
      "trackingNumber": "1Z999AA9876543210",
      "description": "Received laptop instead of tablet. Need to exchange for correct item.",
      "images": [
        "https://picsum.photos/200/200?random=3"
      ],
      "items": [
        {
          "sku": "COMP-002",
          "name": "Laptop",
          "quantity": 1,
          "price": 899.99,
          "condition": "New"
        }
      ]
    },
    {
      "id": "RET-2024-003",
      "orderNumber": "ORD-45894",
      "customer": "Tech Solutions Ltd",
      "email": "orders@techsolutions.com",
      "phone": "+1 555-0125",
      "status": "Refunded",
      "reason": "Damaged in Transit",
      "type": "Refund",
      "requestDate": "2024-06-15",
      "expectedReturn": "2024-06-22",
      "actualReturn": "2024-06-18",
      "processedBy": "Lisa Davis",
      "processedDate": "2024-06-18",
      "refundAmount": 1200.00,
      "restockingFee": 25.00,
      "shippingCost": 15.99,
      "totalRefund": 1160.01,
      "returnAddress": "789 Business Plaza, New York, NY 10001",
      "trackingNumber": "FX123456789",
      "description": "Multiple items damaged during shipping. Box was crushed on arrival.",
      "images": [
        "https://picsum.photos/200/200?random=4",
        "https://picsum.photos/200/200?random=5",
        "https://picsum.photos/200/200?random=6"
      ],
      "items": [
        {
          "sku": "COMP-003",
          "name": "Monitor",
          "quantity": 2,
          "price": 600.00,
          "condition": "Damaged"
        }
      ]
    },
    {
      "id": "RET-2024-004",
      "orderNumber": "ORD-45895",
      "customer": "Emma Wilson",
      "email": "emma.wilson@email.com",
      "phone": "+1 555-0126",
      "status": "Approved",
      "reason": "Quality Issues",
      "type": "Store Credit",
      "requestDate": "2024-06-18",
      "expectedReturn": "2024-06-25",
      "actualReturn": null,
      "processedBy": "David Brown",
      "processedDate": "2024-06-18",
      "refundAmount": 0.00,
      "restockingFee": 0.00,
      "shippingCost": 8.99,
      "totalRefund": 0.00,
      "storeCredit": 450.00,
      "returnAddress": "321 Elm St, Dallas, TX 75201",
      "trackingNumber": null,
      "description": "Poor build quality. Multiple defects noticed after unboxing.",
      "images": [
        "https://picsum.photos/200/200?random=7"
      ],
      "items": [
        {
          "sku": "HOME-001",
          "name": "Kitchen Appliance",
          "quantity": 1,
          "price": 450.00,
          "condition": "Poor Quality"
        }
      ]
    },
    {
      "id": "RET-2024-005",
      "orderNumber": "ORD-45896",
      "customer": "Fashion Store Inc",
      "email": "returns@fashionstore.com",
      "phone": "+1 555-0127",
      "status": "Rejected",
      "reason": "Changed Mind",
      "type": "Refund",
      "requestDate": "2024-06-19",
      "expectedReturn": null,
      "actualReturn": null,
      "processedBy": "Sarah Johnson",
      "processedDate": "2024-06-19",
      "refundAmount": 0.00,
      "restockingFee": 0.00,
      "shippingCost": 0.00,
      "totalRefund": 0.00,
      "returnAddress": "654 Cedar Ave, Portland, OR 97201",
      "trackingNumber": null,
      "description": "Customer changed mind but return window has expired (45 days).",
      "rejectionReason": "Return request submitted after return window expired",
      "images": [],
      "items": [
        {
          "sku": "FASH-001",
          "name": "Designer Handbag",
          "quantity": 1,
          "price": 299.99,
          "condition": "New"
        }
      ]
    },
  ];

  List<Map<String, dynamic>> get filteredReturns {
    return returns.where((returnItem) {
      final matchesSearch = returnItem["id"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          returnItem["customer"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          returnItem["orderNumber"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      final matchesStatus = selectedStatus == "All" || returnItem["status"] == selectedStatus;
      final matchesReason = selectedReason == "All" || returnItem["reason"] == selectedReason;
      final matchesType = selectedType == "All" || returnItem["type"] == selectedType;
      
      return matchesSearch && matchesStatus && matchesReason && matchesType;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Refunded":
        return successColor;
      case "Processed":
        return primaryColor;
      case "Received":
        return infoColor;
      case "In Transit":
        return warningColor;
      case "Approved":
        return successColor;
      case "Requested":
        return disabledBoldColor;
      case "Rejected":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  void _approveReturn(Map<String, dynamic> returnItem) async {
    bool isConfirmed = await confirm("Approve return request ${returnItem["id"]}?");
    if (isConfirmed) {
      returnItem["status"] = "Approved";
      returnItem["processedBy"] = "Current User";
      returnItem["processedDate"] = DateTime.now().toIso8601String().split('T')[0];
      setState(() {});
      ss("Return request approved: ${returnItem["id"]}");
    }
  }

  void _rejectReturn(Map<String, dynamic> returnItem) {
    showDialog(
      context: context,
      builder: (context) {
        String rejectionReason = "";
        
        return AlertDialog(
          title: Text("Reject Return Request"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Provide reason for rejection:"),
              SizedBox(height: spSm),
              QMemoField(
                label: "Rejection Reason",
                value: rejectionReason,
                onChanged: (value) {
                  rejectionReason = value;
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
              label: "Reject",
              size: bs.sm,
              onPressed: () {
                if (rejectionReason.isNotEmpty) {
                  returnItem["status"] = "Rejected";
                  returnItem["rejectionReason"] = rejectionReason;
                  returnItem["processedBy"] = "Current User";
                  returnItem["processedDate"] = DateTime.now().toIso8601String().split('T')[0];
                  setState(() {});
                  Navigator.pop(context);
                  ss("Return request rejected: ${returnItem["id"]}");
                } else {
                  se("Please provide a rejection reason");
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _processRefund(Map<String, dynamic> returnItem) async {
    bool isConfirmed = await confirm("Process refund for ${returnItem["id"]}?\nAmount: \$${(returnItem["totalRefund"] as double).currency}");
    if (isConfirmed) {
      returnItem["status"] = "Refunded";
      returnItem["processedDate"] = DateTime.now().toIso8601String().split('T')[0];
      setState(() {});
      ss("Refund processed for ${returnItem["id"]}");
    }
  }

  void _markAsReceived(Map<String, dynamic> returnItem) async {
    bool isConfirmed = await confirm("Mark return as received for ${returnItem["id"]}?");
    if (isConfirmed) {
      returnItem["status"] = "Received";
      returnItem["actualReturn"] = DateTime.now().toIso8601String().split('T')[0];
      setState(() {});
      ss("Return marked as received: ${returnItem["id"]}");
    }
  }

  void _viewReturnDetails(Map<String, dynamic> returnItem) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Return Details"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("ID: ${returnItem["id"]}", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: spXs),
              Text("Order: ${returnItem["orderNumber"]}"),
              Text("Customer: ${returnItem["customer"]}"),
              Text("Email: ${returnItem["email"]}"),
              Text("Phone: ${returnItem["phone"]}"),
              Text("Status: ${returnItem["status"]}"),
              Text("Reason: ${returnItem["reason"]}"),
              Text("Type: ${returnItem["type"]}"),
              Text("Request Date: ${returnItem["requestDate"]}"),
              if (returnItem["expectedReturn"] != null)
                Text("Expected Return: ${returnItem["expectedReturn"]}"),
              if (returnItem["actualReturn"] != null)
                Text("Actual Return: ${returnItem["actualReturn"]}"),
              if (returnItem["processedBy"] != null)
                Text("Processed By: ${returnItem["processedBy"]}"),
              if (returnItem["trackingNumber"] != null)
                Text("Tracking: ${returnItem["trackingNumber"]}"),
              if (returnItem["totalRefund"] > 0)
                Text("Refund Amount: \$${(returnItem["totalRefund"] as double).currency}"),
              if (returnItem["storeCredit"] != null)
                Text("Store Credit: \$${(returnItem["storeCredit"] as double).currency}"),
              if (returnItem["rejectionReason"] != null)
                Text("Rejection Reason: ${returnItem["rejectionReason"]}"),
              SizedBox(height: spSm),
              Text("Description:", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("${returnItem["description"]}"),
              SizedBox(height: spSm),
              Text("Items:", style: TextStyle(fontWeight: FontWeight.bold)),
              ...((returnItem["items"] as List).map((item) => Padding(
                padding: EdgeInsets.only(top: spXs),
                child: Text("• ${item["name"]} (${item["quantity"]}) - \$${(item["price"] as double).currency}"),
              ))),
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

  void _viewReturnImages(Map<String, dynamic> returnItem) {
    if ((returnItem["images"] as List).isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Return Images"),
          content: Container(
            height: 300,
            width: double.maxFinite,
            child: QHorizontalScroll(
              children: (returnItem["images"] as List).map<Widget>((imageUrl) => 
                Container(
                  width: 200,
                  margin: EdgeInsets.only(right: spSm),
                  child: Image.network(
                    "$imageUrl",
                    fit: BoxFit.cover,
                  ),
                )
              ).toList(),
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
  }

  Widget _buildReturnCard(Map<String, dynamic> returnItem) {
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
                      "${returnItem["id"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${returnItem["customer"]}",
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
                  color: _getStatusColor(returnItem["status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${returnItem["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor(returnItem["status"]),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.inventory_2, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Order: ${returnItem["orderNumber"]}",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
              Spacer(),
              Icon(Icons.category, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${returnItem["type"]}",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.warning, size: 16, color: warningColor),
                    SizedBox(width: spXs),
                    Text(
                      "Reason: ${returnItem["reason"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "${returnItem["description"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                    fontStyle: FontStyle.italic,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Requested: ${returnItem["requestDate"]}",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
              Spacer(),
              if (returnItem["trackingNumber"] != null) ...[
                Icon(Icons.local_shipping, size: 16, color: primaryColor),
                SizedBox(width: spXs),
                Text(
                  "${returnItem["trackingNumber"]}",
                  style: TextStyle(fontSize: 12, color: primaryColor),
                ),
              ],
            ],
          ),
          if (returnItem["totalRefund"] > 0 || returnItem["storeCredit"] != null) ...[
            SizedBox(height: spSm),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: successColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                children: [
                  Icon(Icons.attach_money, size: 16, color: successColor),
                  SizedBox(width: spXs),
                  if (returnItem["totalRefund"] > 0)
                    Text(
                      "Refund: \$${(returnItem["totalRefund"] as double).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    )
                  else if (returnItem["storeCredit"] != null)
                    Text(
                      "Store Credit: \$${(returnItem["storeCredit"] as double).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                ],
              ),
            ),
          ],
          if (returnItem["rejectionReason"] != null) ...[
            SizedBox(height: spSm),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                children: [
                  Icon(Icons.cancel, size: 16, color: dangerColor),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "${returnItem["rejectionReason"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: dangerColor,
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
                  onPressed: () => _viewReturnDetails(returnItem),
                ),
              ),
              SizedBox(width: spSm),
              if ((returnItem["images"] as List).isNotEmpty)
                QButton(
                  label: "Images",
                  size: bs.sm,
                  onPressed: () => _viewReturnImages(returnItem),
                ),
              SizedBox(width: spSm),
              if (returnItem["status"] == "Requested") ...[
                QButton(
                  label: "Approve",
                  size: bs.sm,
                  onPressed: () => _approveReturn(returnItem),
                ),
                SizedBox(width: spSm),
                QButton(
                  label: "Reject",
                  size: bs.sm,
                  onPressed: () => _rejectReturn(returnItem),
                ),
              ] else if (returnItem["status"] == "In Transit") ...[
                QButton(
                  label: "Received",
                  size: bs.sm,
                  onPressed: () => _markAsReceived(returnItem),
                ),
              ] else if (returnItem["status"] == "Received" && returnItem["totalRefund"] > 0) ...[
                QButton(
                  label: "Refund",
                  size: bs.sm,
                  onPressed: () => _processRefund(returnItem),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    int totalReturns = returns.length;
    int requested = returns.where((r) => r["status"] == "Requested").length;
    int inProgress = returns.where((r) => r["status"] == "Approved" || r["status"] == "In Transit" || r["status"] == "Received").length;
    int completed = returns.where((r) => r["status"] == "Refunded" || r["status"] == "Processed").length;
    int rejected = returns.where((r) => r["status"] == "Rejected").length;

    double totalRefunds = returns.where((r) => r["status"] == "Refunded").fold(0.0, (sum, r) => sum + (r["totalRefund"] as double));
    double totalStoreCredit = returns.where((r) => r["storeCredit"] != null).fold(0.0, (sum, r) => sum + (r["storeCredit"] as double));

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
                    Icon(Icons.keyboard_return, color: primaryColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "$totalReturns",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Total Returns",
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
                    Icon(Icons.pending_actions, color: warningColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "$requested",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                    Text(
                      "Requested",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.work, color: infoColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "$inProgress",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                    Text(
                      "In Progress",
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
                      "$completed",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Completed",
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
                    Icon(Icons.cancel, color: dangerColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "$rejected",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                    Text(
                      "Rejected",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.payments, color: primaryColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "\$${totalRefunds.currency}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Total Refunds",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spLg),
          Text(
            "Recent Return Requests",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...returns.take(5).map((returnItem) => _buildReturnCard(returnItem)),
        ],
      ),
    );
  }

  Widget _buildActiveTab() {
    List<Map<String, dynamic>> activeReturns = returns.where((r) => 
        r["status"] != "Refunded" && r["status"] != "Rejected" && r["status"] != "Processed").toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search returns...",
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
                  label: "Filter by Reason",
                  items: reasonItems,
                  value: selectedReason,
                  onChanged: (value, label) {
                    selectedReason = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spLg),
          if (activeReturns.isEmpty)
            Center(
              child: Column(
                children: [
                  Icon(Icons.inbox, size: 64, color: disabledColor),
                  SizedBox(height: spSm),
                  Text(
                    "No active returns found",
                    style: TextStyle(color: disabledBoldColor),
                  ),
                ],
              ),
            )
          else
            ...filteredReturns.where((r) => r["status"] != "Refunded" && r["status"] != "Rejected" && r["status"] != "Processed").map((returnItem) => _buildReturnCard(returnItem)),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    List<Map<String, dynamic>> completedReturns = returns.where((r) => 
        r["status"] == "Refunded" || r["status"] == "Rejected" || r["status"] == "Processed").toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search return history...",
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
          if (completedReturns.isEmpty)
            Center(
              child: Column(
                children: [
                  Icon(Icons.history, size: 64, color: disabledColor),
                  SizedBox(height: spSm),
                  Text(
                    "No return history found",
                    style: TextStyle(color: disabledBoldColor),
                  ),
                ],
              ),
            )
          else
            ...completedReturns.map((returnItem) => _buildReturnCard(returnItem)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Returns",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Active", icon: Icon(Icons.keyboard_return)),
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
