import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlTransaction5View extends StatefulWidget {
  @override
  State<GrlTransaction5View> createState() => _GrlTransaction5ViewState();
}

class _GrlTransaction5ViewState extends State<GrlTransaction5View> {
  int currentStep = 0;
  bool loading = false;

  Map<String, dynamic> transactionDetails = {
    "id": "TXN-2024-0001",
    "amount": 299.99,
    "currency": "USD",
    "type": "Purchase",
    "description": "Premium Wireless Headphones - Sony WH-1000XM5",
    "merchant": "AudioTech Store",
    "date": "2024-06-20T14:30:00Z",
    "status": "processing",
    "paymentMethod": "Visa •••• 1234",
    "customerEmail": "john.doe@email.com",
    "shippingAddress": {
      "name": "John Doe",
      "street": "123 Main Street",
      "city": "New York",
      "state": "NY",
      "zipCode": "10001",
      "country": "United States",
    },
    "items": [
      {
        "name": "Sony WH-1000XM5 Wireless Headphones",
        "quantity": 1,
        "price": 279.99,
        "image": "https://picsum.photos/60/60?random=1&keyword=headphones",
      },
      {
        "name": "Premium Carrying Case",
        "quantity": 1,
        "price": 19.99,
        "image": "https://picsum.photos/60/60?random=2&keyword=case",
      },
    ],
    "timeline": [
      {
        "status": "initiated",
        "title": "Transaction Initiated",
        "description": "Payment request received and validation started",
        "timestamp": "2024-06-20T14:30:00Z",
        "completed": true,
      },
      {
        "status": "processing",
        "title": "Processing Payment",
        "description": "Verifying payment method and processing transaction",
        "timestamp": "2024-06-20T14:31:00Z",
        "completed": true,
      },
      {
        "status": "verification",
        "title": "Security Verification",
        "description": "Performing security checks and fraud detection",
        "timestamp": null,
        "completed": false,
      },
      {
        "status": "approved",
        "title": "Payment Approved",
        "description": "Transaction approved and funds authorized",
        "timestamp": null,
        "completed": false,
      },
      {
        "status": "completed",
        "title": "Transaction Completed",
        "description": "Payment processed successfully and confirmation sent",
        "timestamp": null,
        "completed": false,
      },
    ],
  };

  Color getStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "processing":
        return warningColor;
      case "failed":
        return dangerColor;
      case "pending":
        return infoColor;
      default:
        return primaryColor;
    }
  }

  IconData getStatusIcon(String status) {
    switch (status) {
      case "completed":
        return Icons.check_circle;
      case "processing":
        return Icons.hourglass_empty;
      case "failed":
        return Icons.error;
      case "pending":
        return Icons.schedule;
      default:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = getStatusColor(transactionDetails["status"] as String);
    final timeline = transactionDetails["timeline"] as List;
    final completedSteps = timeline.where((step) => step["completed"] as bool).length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Transaction Status"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              // Share transaction details
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Transaction header
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: statusColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          getStatusIcon(transactionDetails["status"] as String),
                          color: statusColor,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Transaction ${(transactionDetails["status"] as String).toUpperCase()}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: statusColor,
                              ),
                            ),
                            Text(
                              "${transactionDetails["id"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "\$${(transactionDetails["amount"] as double).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Progress indicator
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Progress",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${completedSteps}/${timeline.length} steps completed",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      LinearProgressIndicator(
                        value: completedSteps / timeline.length,
                        backgroundColor: disabledColor,
                        valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Transaction details
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Merchant",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "${transactionDetails["merchant"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Payment Method",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "${transactionDetails["paymentMethod"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Transaction timeline
            Text(
              "Transaction Timeline",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: List.generate(timeline.length, (index) {
                  final step = timeline[index];
                  final isCompleted = step["completed"] as bool;
                  final isLast = index == timeline.length - 1;
                  
                  return Container(
                    padding: EdgeInsets.all(spMd),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: isCompleted ? successColor : disabledColor,
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Icon(
                                isCompleted ? Icons.check : Icons.schedule,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                            if (!isLast)
                              Container(
                                width: 2,
                                height: 40,
                                color: isCompleted ? successColor : disabledColor,
                              ),
                          ],
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${step["title"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: isCompleted ? primaryColor : disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${step["description"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                              if (step["timestamp"] != null) ...[
                                SizedBox(height: spXs),
                                Text(
                                  "${DateTime.parse(step["timestamp"]).dMMMy} at ${DateTime.parse(step["timestamp"]).kkmm}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Order items
            Text(
              "Order Items",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: List.generate((transactionDetails["items"] as List).length, (index) {
                  final item = (transactionDetails["items"] as List)[index];
                  
                  return Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      border: index < (transactionDetails["items"] as List).length - 1
                          ? Border(bottom: BorderSide(color: disabledOutlineBorderColor))
                          : null,
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusSm),
                          child: Image.network(
                            "${item["image"]}",
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${item["name"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Quantity: ${item["quantity"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "\$${(item["price"] as double).toStringAsFixed(2)}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Shipping information
            Text(
              "Shipping Information",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
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
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Delivery Address",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${(transactionDetails["shippingAddress"] as Map)["name"]}\n${(transactionDetails["shippingAddress"] as Map)["street"]}\n${(transactionDetails["shippingAddress"] as Map)["city"]}, ${(transactionDetails["shippingAddress"] as Map)["state"]} ${(transactionDetails["shippingAddress"] as Map)["zipCode"]}\n${(transactionDetails["shippingAddress"] as Map)["country"]}",
                    style: TextStyle(
                      color: primaryColor,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Status-specific information
            if (transactionDetails["status"] == "processing") ...[
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(color: warningColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info,
                          color: warningColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Transaction in Progress",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Your transaction is being processed. This usually takes 2-5 minutes. You will receive an email confirmation once completed.",
                      style: TextStyle(
                        color: warningColor,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: spMd),
            ],
            
            // Action buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Download Receipt",
                    size: bs.sm,
                    icon: Icons.download,
                    onPressed: () {
                      // Download receipt
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Contact Support",
                    size: bs.sm,
                    color: disabledBoldColor,
                    onPressed: () {
                      // Contact support
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            // Refresh button for processing transactions
            if (transactionDetails["status"] == "processing")
              Container(
                width: double.infinity,
                child: QButton(
                  label: loading ? "Checking Status..." : "Refresh Status",
                  size: bs.sm,
                  color: infoColor,
                  onPressed: loading ? null : () async {
                    loading = true;
                    setState(() {});
                    
                    // Simulate status check
                    await Future.delayed(Duration(seconds: 2));
                    
                    loading = false;
                    setState(() {});
                    
                    si("Status updated");
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
