import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlOrder2View extends StatefulWidget {
  @override
  State<GrlOrder2View> createState() => _GrlOrder2ViewState();
}

class _GrlOrder2ViewState extends State<GrlOrder2View> {
  int currentStep = 2;
  
  Map<String, dynamic> orderData = {
    "id": "ORD-2024-001",
    "customer": "John Smith",
    "email": "john.smith@email.com",
    "phone": "+1-555-0123",
    "status": "Processing",
    "total": 299.99,
    "items": 3,
    "date": "2024-06-20",
    "estimated_delivery": "2024-06-25",
    "tracking_number": "TRK-789456123",
    "shipping_address": "123 Main St, New York, NY 10001",
    "billing_address": "123 Main St, New York, NY 10001",
    "payment_method": "Credit Card **** 1234",
    "carrier": "DHL Express",
    "notes": "Customer requested signature confirmation",
    "products": [
      {
        "name": "Wireless Bluetooth Headphones",
        "sku": "WBH-001",
        "quantity": 1,
        "price": 129.99,
        "image": "https://picsum.photos/80/80?random=1&keyword=headphones"
      },
      {
        "name": "Phone Case Premium",
        "sku": "PCP-002", 
        "quantity": 2,
        "price": 24.99,
        "image": "https://picsum.photos/80/80?random=2&keyword=phone"
      },
      {
        "name": "USB-C Cable 2m",
        "sku": "UCC-003",
        "quantity": 3,
        "price": 15.99,
        "image": "https://picsum.photos/80/80?random=3&keyword=cable"
      }
    ],
    "timeline": [
      {
        "status": "Order Placed",
        "date": "2024-06-20 10:30",
        "description": "Order has been successfully placed",
        "completed": true
      },
      {
        "status": "Payment Confirmed",
        "date": "2024-06-20 10:32",
        "description": "Payment of \$299.99 has been confirmed",
        "completed": true
      },
      {
        "status": "Processing",
        "date": "2024-06-20 14:15",
        "description": "Order is being prepared for shipment",
        "completed": true
      },
      {
        "status": "Shipped",
        "date": "",
        "description": "Order has been shipped and is on the way",
        "completed": false
      },
      {
        "status": "Out for Delivery",
        "date": "",
        "description": "Package is out for delivery",
        "completed": false
      },
      {
        "status": "Delivered",
        "date": "",
        "description": "Package has been delivered successfully",
        "completed": false
      }
    ]
  };

  Color _getStepColor(int index) {
    if (index < currentStep) {
      return successColor;
    } else if (index == currentStep) {
      return primaryColor;
    } else {
      return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              ss("Tracking link shared");
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              _showOrderActions();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Order Header
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${orderData["id"]}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${orderData["customer"]}",
                              style: TextStyle(
                                fontSize: 16,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${orderData["status"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  Divider(color: disabledOutlineBorderColor),
                  
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Tracking Number",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${orderData["tracking_number"]}",
                              style: TextStyle(
                                fontSize: 14,
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
                            "Estimated Delivery",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${orderData["estimated_delivery"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Tracking Progress
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Tracking Progress",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  Container(
                    padding: EdgeInsets.all(spSm),
                    child: Column(
                      children: (orderData["timeline"] as List).asMap().entries.map((entry) {
                        int index = entry.key;
                        Map<String, dynamic> step = entry.value;
                        bool isCompleted = step["completed"];
                        bool isLast = index == (orderData["timeline"] as List).length - 1;
                        
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Step indicator
                            Column(
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: isCompleted ? successColor : 
                                           index == currentStep ? primaryColor : disabledColor,
                                    borderRadius: BorderRadius.circular(radiusLg),
                                  ),
                                  child: Icon(
                                    isCompleted ? Icons.check : 
                                    index == currentStep ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                                if (!isLast) ...[
                                  Container(
                                    width: 2,
                                    height: 40,
                                    color: isCompleted ? successColor : disabledOutlineBorderColor,
                                  ),
                                ],
                              ],
                            ),
                            SizedBox(width: spSm),
                            
                            // Step content
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(bottom: isLast ? 0 : spSm),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${step["status"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: isCompleted ? primaryColor : disabledBoldColor,
                                      ),
                                    ),
                                    if ("${step["date"]}".isNotEmpty) ...[
                                      Text(
                                        "${step["date"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: successColor,
                                        ),
                                      ),
                                    ],
                                    Text(
                                      "${step["description"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            // Order Items
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Order Items (${orderData["items"]})",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  ...(orderData["products"] as List).map((product) {
                    return Container(
                      padding: EdgeInsets.all(spXs),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: Colors.grey.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radiusXs),
                              image: DecorationImage(
                                image: NetworkImage("${product["image"]}"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${product["name"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "SKU: ${product["sku"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "Qty: ${product["quantity"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "\$${((product["price"] as num).toDouble()).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  
                  Divider(color: disabledOutlineBorderColor),
                  
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Total Amount",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Text(
                        "\$${((orderData["total"] as num).toDouble()).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Shipping Information
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Shipping Information",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: Colors.grey.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Column(
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.local_shipping, size: 16, color: primaryColor),
                            SizedBox(width: spXs),
                            Text(
                              "Carrier:",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${orderData["carrier"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.location_on, size: 16, color: primaryColor),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Shipping Address:",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${orderData["shipping_address"]}",
                                    style: TextStyle(
                                      fontSize: 12,
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
                ],
              ),
            ),

            // Customer Information
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Customer Information",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: Colors.grey.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Column(
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.person, size: 16, color: primaryColor),
                            SizedBox(width: spXs),
                            Text(
                              "Name:",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${orderData["customer"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.email, size: 16, color: primaryColor),
                            SizedBox(width: spXs),
                            Text(
                              "Email:",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${orderData["email"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.phone, size: 16, color: primaryColor),
                            SizedBox(width: spXs),
                            Text(
                              "Phone:",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${orderData["phone"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Notes
            if ("${orderData["notes"]}".isNotEmpty) ...[
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: infoColor.withAlpha(50)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.note, size: 20, color: infoColor),
                        SizedBox(width: spXs),
                        Text(
                          "Order Notes",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${orderData["notes"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: infoColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Contact Customer",
                    size: bs.md,
                    onPressed: () {
                      //navigateTo('ContactCustomerView', arguments: orderData)
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Update Status",
                    size: bs.md,
                    onPressed: () {
                      _showStatusUpdateDialog();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showOrderActions() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: disabledOutlineBorderColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
              Text(
                "Order Actions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Print Order",
                  size: bs.md,
                  onPressed: () {
                    back();
                    ss("Order printed successfully");
                  },
                ),
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Email Customer",
                  size: bs.md,
                  onPressed: () {
                    back();
                    ss("Email sent to customer");
                  },
                ),
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Generate Invoice",
                  size: bs.md,
                  onPressed: () {
                    back();
                    ss("Invoice generated");
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showStatusUpdateDialog() {
    String selectedStatus = "${orderData["status"]}";
    List<String> statusOptions = ["Processing", "Shipped", "Out for Delivery", "Delivered", "Cancelled"];
    
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Update Order Status"),
          content: StatefulBuilder(
            builder: (context, setDialogState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: statusOptions.map((status) {
                  return RadioListTile<String>(
                    title: Text(status),
                    value: status,
                    groupValue: selectedStatus,
                    onChanged: (value) {
                      selectedStatus = value!;
                      setDialogState(() {});
                    },
                  );
                }).toList(),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => back(),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                orderData["status"] = selectedStatus;
                setState(() {});
                back();
                ss("Order status updated to $selectedStatus");
              },
              child: Text("Update"),
            ),
          ],
        );
      },
    );
  }
}
