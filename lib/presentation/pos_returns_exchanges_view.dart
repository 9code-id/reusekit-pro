import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosReturnsExchangesView extends StatefulWidget {
  const PosReturnsExchangesView({super.key});

  @override
  State<PosReturnsExchangesView> createState() => _PosReturnsExchangesViewState();
}

class _PosReturnsExchangesViewState extends State<PosReturnsExchangesView> {
  String searchQuery = "";
  String selectedStatus = "all";
  String selectedType = "all";
  String selectedTimeRange = "all";
  int currentTab = 0;

  List<Map<String, dynamic>> returnsExchanges = [
    {
      "id": "RE001",
      "transactionId": "TXN-2024-001234",
      "type": "return",
      "status": "pending",
      "requestDate": "2024-06-18",
      "processedDate": null,
      "reason": "defective_item",
      "description": "Product arrived damaged, screen has cracks",
      "customer": {
        "name": "John Doe",
        "email": "john.doe@email.com",
        "phone": "+1234567890",
        "loyaltyId": "CUST001"
      },
      "originalOrder": {
        "orderId": "ORD-2024-5678",
        "orderDate": "2024-06-15",
        "total": 299.99,
        "paymentMethod": "Credit Card"
      },
      "items": [
        {
          "productId": "PROD001",
          "name": "Smartphone XL",
          "sku": "SPH-XL-001",
          "quantity": 1,
          "price": 299.99,
          "category": "Electronics"
        }
      ],
      "refundAmount": 299.99,
      "restockingFee": 0.00,
      "shippingCost": 15.99,
      "returnShippingPaid": true,
      "condition": "damaged",
      "images": ["https://picsum.photos/300/200?random=1&keyword=damage"],
      "handledBy": null,
      "notes": "Customer provided photos showing screen damage",
      "createdAt": "2024-06-18",
      "lastUpdated": "2024-06-18"
    },
    {
      "id": "RE002",
      "transactionId": "TXN-2024-002345",
      "type": "exchange",
      "status": "approved",
      "requestDate": "2024-06-16",
      "processedDate": "2024-06-17",
      "reason": "wrong_size",
      "description": "Ordered Medium but need Large size",
      "customer": {
        "name": "Sarah Wilson",
        "email": "sarah.wilson@email.com",
        "phone": "+1234567891",
        "loyaltyId": "CUST002"
      },
      "originalOrder": {
        "orderId": "ORD-2024-5679",
        "orderDate": "2024-06-10",
        "total": 89.99,
        "paymentMethod": "Debit Card"
      },
      "items": [
        {
          "productId": "PROD002",
          "name": "Summer Dress",
          "sku": "DRS-SUM-002",
          "quantity": 1,
          "price": 89.99,
          "category": "Fashion"
        }
      ],
      "refundAmount": 0.00,
      "restockingFee": 0.00,
      "shippingCost": 0.00,
      "returnShippingPaid": true,
      "condition": "new",
      "images": [],
      "handledBy": "Store Manager",
      "notes": "Exchange processed, new item shipped",
      "exchangeItem": {
        "productId": "PROD002L",
        "name": "Summer Dress - Large",
        "sku": "DRS-SUM-002L",
        "price": 89.99
      },
      "createdAt": "2024-06-16",
      "lastUpdated": "2024-06-17"
    },
    {
      "id": "RE003",
      "transactionId": "TXN-2024-003456",
      "type": "return",
      "status": "completed",
      "requestDate": "2024-06-12",
      "processedDate": "2024-06-14",
      "reason": "not_as_described",
      "description": "Color different from website photos",
      "customer": {
        "name": "Mike Johnson",
        "email": "mike.johnson@email.com",
        "phone": "+1234567892",
        "loyaltyId": "CUST003"
      },
      "originalOrder": {
        "orderId": "ORD-2024-5680",
        "orderDate": "2024-06-08",
        "total": 149.99,
        "paymentMethod": "PayPal"
      },
      "items": [
        {
          "productId": "PROD003",
          "name": "Leather Jacket",
          "sku": "JKT-LTH-003",
          "quantity": 1,
          "price": 149.99,
          "category": "Fashion"
        }
      ],
      "refundAmount": 149.99,
      "restockingFee": 0.00,
      "shippingCost": 12.99,
      "returnShippingPaid": false,
      "condition": "good",
      "images": ["https://picsum.photos/300/200?random=2&keyword=jacket"],
      "handledBy": "Customer Service Rep",
      "notes": "Full refund processed, item restocked",
      "createdAt": "2024-06-12",
      "lastUpdated": "2024-06-14"
    },
    {
      "id": "RE004",
      "transactionId": "TXN-2024-004567",
      "type": "return",
      "status": "rejected",
      "requestDate": "2024-06-10",
      "processedDate": "2024-06-11",
      "reason": "changed_mind",
      "description": "No longer need the item",
      "customer": {
        "name": "Emily Brown",
        "email": "emily.brown@email.com",
        "phone": "+1234567893",
        "loyaltyId": "CUST004"
      },
      "originalOrder": {
        "orderId": "ORD-2024-5681",
        "orderDate": "2024-05-20",
        "total": 79.99,
        "paymentMethod": "Credit Card"
      },
      "items": [
        {
          "productId": "PROD004",
          "name": "Bluetooth Headphones",
          "sku": "AUD-BT-004",
          "quantity": 1,
          "price": 79.99,
          "category": "Electronics"
        }
      ],
      "refundAmount": 0.00,
      "restockingFee": 0.00,
      "shippingCost": 8.99,
      "returnShippingPaid": false,
      "condition": "used",
      "images": [],
      "handledBy": "Returns Manager",
      "notes": "Return rejected - outside 30-day return window",
      "createdAt": "2024-06-10",
      "lastUpdated": "2024-06-11"
    },
    {
      "id": "RE005",
      "transactionId": "TXN-2024-005678",
      "type": "exchange",
      "status": "in_progress",
      "requestDate": "2024-06-17",
      "processedDate": null,
      "reason": "defective_item",
      "description": "Shoes have manufacturing defect on left sole",
      "customer": {
        "name": "David Lee",
        "email": "david.lee@email.com",
        "phone": "+1234567894",
        "loyaltyId": "CUST005"
      },
      "originalOrder": {
        "orderId": "ORD-2024-5682",
        "orderDate": "2024-06-14",
        "total": 199.99,
        "paymentMethod": "Credit Card"
      },
      "items": [
        {
          "productId": "PROD005",
          "name": "Running Shoes",
          "sku": "SHO-RUN-005",
          "quantity": 1,
          "price": 199.99,
          "category": "Sports"
        }
      ],
      "refundAmount": 0.00,
      "restockingFee": 0.00,
      "shippingCost": 0.00,
      "returnShippingPaid": true,
      "condition": "defective",
      "images": ["https://picsum.photos/300/200?random=3&keyword=shoes"],
      "handledBy": "Quality Control Team",
      "notes": "Investigating manufacturing defect, replacement approved",
      "exchangeItem": {
        "productId": "PROD005",
        "name": "Running Shoes",
        "sku": "SHO-RUN-005",
        "price": 199.99
      },
      "createdAt": "2024-06-17",
      "lastUpdated": "2024-06-18"
    }
  ];

  List<Map<String, dynamic>> get filteredReturns {
    return returnsExchanges.where((re) {
      bool matchesSearch = "${re["id"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${re["transactionId"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${re["customer"]["name"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesStatus = selectedStatus == "all" || re["status"] == selectedStatus;
      bool matchesType = selectedType == "all" || re["type"] == selectedType;
      
      bool matchesTimeRange = true;
      if (selectedTimeRange != "all") {
        DateTime requestDate = DateTime.parse(re["requestDate"]);
        DateTime now = DateTime.now();
        switch (selectedTimeRange) {
          case "today":
            matchesTimeRange = requestDate.day == now.day && 
                              requestDate.month == now.month && 
                              requestDate.year == now.year;
            break;
          case "week":
            matchesTimeRange = now.difference(requestDate).inDays <= 7;
            break;
          case "month":
            matchesTimeRange = now.difference(requestDate).inDays <= 30;
            break;
        }
      }
      
      return matchesSearch && matchesStatus && matchesType && matchesTimeRange;
    }).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "pending":
        return warningColor;
      case "approved":
        return infoColor;
      case "in_progress":
        return primaryColor;
      case "completed":
        return successColor;
      case "rejected":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  String getReasonLabel(String reason) {
    switch (reason) {
      case "defective_item":
        return "Defective Item";
      case "wrong_size":
        return "Wrong Size";
      case "not_as_described":
        return "Not as Described";
      case "changed_mind":
        return "Changed Mind";
      case "damaged_shipping":
        return "Damaged in Shipping";
      default:
        return reason.replaceAll("_", " ").toUpperCase();
    }
  }

  Widget _buildReturnExchangeCard(Map<String, dynamic> returnExchange) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: getStatusColor(returnExchange["status"]).withAlpha(20),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusMd),
                topRight: Radius.circular(radiusMd),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  returnExchange["type"] == "return" ? Icons.keyboard_return : Icons.swap_horiz,
                  color: getStatusColor(returnExchange["status"]),
                  size: 20,
                ),
                SizedBox(width: spXs),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${returnExchange["id"]} • ${returnExchange["type"]}".toUpperCase(),
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: getStatusColor(returnExchange["status"]),
                        ),
                      ),
                      Text(
                        "${returnExchange["transactionId"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: getStatusColor(returnExchange["status"]),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${returnExchange["status"]}".replaceAll("_", " ").toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Content
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Customer info
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.person,
                        size: 16,
                        color: primaryColor,
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${returnExchange["customer"]["name"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${returnExchange["customer"]["email"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${returnExchange["customer"]["loyaltyId"]}",
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: spSm),
                
                // Reason and description
                Row(
                  children: [
                    Icon(
                      Icons.help_outline,
                      size: 16,
                      color: warningColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      getReasonLabel(returnExchange["reason"]),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${returnExchange["description"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
                SizedBox(height: spSm),
                
                // Items
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.inventory_2,
                            size: 16,
                            color: infoColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Items (${(returnExchange["items"] as List).length})",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: infoColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      ...(returnExchange["items"] as List).map((item) {
                        return Container(
                          margin: EdgeInsets.only(bottom: spXs),
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${item["name"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${item["sku"]} • Qty: ${item["quantity"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                "\$${(item["price"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
                SizedBox(height: spSm),
                
                // Financial details
                if (returnExchange["type"] == "return" && returnExchange["refundAmount"] > 0) ...[
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Refund Amount",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "\$${(returnExchange["refundAmount"] as double).currency}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                        if (returnExchange["restockingFee"] > 0) ...[
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Text(
                                "Restocking Fee",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "-\$${(returnExchange["restockingFee"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: dangerColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Text(
                              "Return Shipping",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              returnExchange["returnShippingPaid"] ? "Paid by Store" : "Paid by Customer",
                              style: TextStyle(
                                fontSize: 11,
                                color: returnExchange["returnShippingPaid"] ? successColor : warningColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: spSm),
                ],
                
                // Exchange item
                if (returnExchange["type"] == "exchange" && returnExchange["exchangeItem"] != null) ...[
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.swap_horiz,
                              size: 16,
                              color: successColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Exchange Item",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${returnExchange["exchangeItem"]["name"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${returnExchange["exchangeItem"]["sku"]} • \$${(returnExchange["exchangeItem"]["price"] as double).currency}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: spSm),
                ],
                
                // Condition and dates
                Row(
                  children: [
                    Icon(
                      Icons.assessment,
                      size: 14,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Condition: ${returnExchange["condition"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(
                      Icons.schedule,
                      size: 14,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Requested: ${returnExchange["requestDate"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                    if (returnExchange["processedDate"] != null) ...[
                      SizedBox(width: spSm),
                      Text(
                        "Processed: ${returnExchange["processedDate"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: spXs),
                
                // Handler and notes
                if (returnExchange["handledBy"] != null) ...[
                  Row(
                    children: [
                      Icon(
                        Icons.person_outline,
                        size: 14,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Handled by: ${returnExchange["handledBy"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                ],
                
                if (returnExchange["notes"] != null && returnExchange["notes"].toString().isNotEmpty) ...[
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${returnExchange["notes"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  SizedBox(height: spSm),
                ],
                
                // Actions
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "View Details",
                        size: bs.sm,
                        onPressed: () {
                          // View return/exchange details
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    if (returnExchange["status"] == "pending")
                      Expanded(
                        child: QButton(
                          label: "Process",
                          size: bs.sm,
                          onPressed: () {
                            // Process return/exchange
                          },
                        ),
                      ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.message,
                      size: bs.sm,
                      onPressed: () {
                        // Contact customer
                      },
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      icon: Icons.more_vert,
                      size: bs.sm,
                      onPressed: () {
                        // Show more options
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard() {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "${returnsExchanges.where((re) => re["status"] == "pending").length}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                    Text(
                      "Pending",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 40,
                color: disabledColor,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "${returnsExchanges.where((re) => re["type"] == "return").length}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                    Text(
                      "Returns",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 40,
                color: disabledColor,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "${returnsExchanges.where((re) => re["type"] == "exchange").length}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                    Text(
                      "Exchanges",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 40,
                color: disabledColor,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "\$${returnsExchanges.fold(0.0, (sum, re) => sum + (re["refundAmount"] as double)).currency}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Refunds",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Returns & Exchanges"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Process new return/exchange
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatsCard(),
            
            // Search and filters
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search returns & exchanges...",
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
                    label: "Status",
                    items: [
                      {"label": "All Status", "value": "all"},
                      {"label": "Pending", "value": "pending"},
                      {"label": "Approved", "value": "approved"},
                      {"label": "In Progress", "value": "in_progress"},
                      {"label": "Completed", "value": "completed"},
                      {"label": "Rejected", "value": "rejected"},
                    ],
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
                    label: "Type",
                    items: [
                      {"label": "All Types", "value": "all"},
                      {"label": "Returns", "value": "return"},
                      {"label": "Exchanges", "value": "exchange"},
                    ],
                    value: selectedType,
                    onChanged: (value, label) {
                      selectedType = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
            
            // Returns & exchanges list
            Text(
              "Returns & Exchanges (${filteredReturns.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            if (filteredReturns.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.keyboard_return_outlined,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No returns or exchanges found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Try adjusting your search criteria",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...filteredReturns.map((returnExchange) => _buildReturnExchangeCard(returnExchange)),
          ],
        ),
      ),
    );
  }
}
