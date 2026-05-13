import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaCancelOrderView extends StatefulWidget {
  const FdaCancelOrderView({super.key});

  @override
  State<FdaCancelOrderView> createState() => _FdaCancelOrderViewState();
}

class _FdaCancelOrderViewState extends State<FdaCancelOrderView> {
  String selectedReason = "";
  String customReason = "";
  String additionalComments = "";
  bool requestRefund = true;
  double refundAmount = 0.0;
  double cancellationFee = 0.0;

  Map<String, dynamic> orderInfo = {
    "id": "ORDER#12345",
    "date": "2024-06-14",
    "time": "2:30 PM",
    "restaurant": "Tony's Pizzeria",
    "total": 43.05,
    "status": "Preparing",
    "estimatedTime": "25 minutes",
    "canCancel": true,
    "preparationStarted": false,
    "items": [
      {
        "name": "Margherita Pizza",
        "price": 25.98,
        "quantity": 2,
        "image": "https://picsum.photos/60/60?random=1&keyword=pizza"
      },
      {
        "name": "Chicken Caesar Salad",
        "price": 8.99,
        "quantity": 1,
        "image": "https://picsum.photos/60/60?random=2&keyword=salad"
      },
      {
        "name": "Chocolate Brownie",
        "price": 4.99,
        "quantity": 1,
        "image": "https://picsum.photos/60/60?random=3&keyword=brownie"
      }
    ]
  };

  List<Map<String, dynamic>> cancellationReasons = [
    {
      "label": "Changed my mind",
      "value": "changed_mind",
      "description": "No longer want the order",
      "fee": 0.0
    },
    {
      "label": "Wrong items ordered",
      "value": "wrong_items",
      "description": "Ordered incorrect items by mistake",
      "fee": 0.0
    },
    {
      "label": "Delivery taking too long",
      "value": "delivery_delay",
      "description": "Estimated delivery time is too long",
      "fee": 0.0
    },
    {
      "label": "Found better deal elsewhere",
      "value": "better_deal",
      "description": "Found same food for lower price",
      "fee": 0.0
    },
    {
      "label": "Emergency/Urgent matter",
      "value": "emergency",
      "description": "Unexpected urgent situation",
      "fee": 0.0
    },
    {
      "label": "Restaurant location issue",
      "value": "location_issue",
      "description": "Restaurant is too far or closed",
      "fee": 0.0
    },
    {
      "label": "Payment method issue",
      "value": "payment_issue",
      "description": "Problem with selected payment method",
      "fee": 0.0
    },
    {
      "label": "Health/Dietary concerns",
      "value": "health_concern",
      "description": "Discovered allergens or dietary restrictions",
      "fee": 0.0
    },
    {
      "label": "Other",
      "value": "other",
      "description": "Specify your reason below",
      "fee": 0.0
    }
  ];

  @override
  void initState() {
    super.initState();
    _calculateRefundAmount();
  }

  void _calculateRefundAmount() {
    double total = orderInfo["total"] as double;
    
    // Calculate cancellation fee based on order status
    if (orderInfo["preparationStarted"]) {
      cancellationFee = total * 0.15; // 15% fee if preparation started
    } else {
      cancellationFee = 0.0; // No fee if not started preparation
    }
    
    refundAmount = total - cancellationFee;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cancel Order"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Status Warning
            if (orderInfo["preparationStarted"]) ...[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: warningColor),
                ),
                child: Row(
                  children: [
                    Icon(Icons.warning_amber, color: warningColor, size: 20),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Preparation Started",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                          Text(
                            "Your order preparation has started. A cancellation fee will apply.",
                            style: TextStyle(
                              fontSize: 12,
                              color: warningColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: successColor),
                ),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: successColor, size: 20),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Free Cancellation",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "You can cancel this order without any fee as preparation hasn't started.",
                            style: TextStyle(
                              fontSize: 12,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],

            // Order Information
            Container(
              width: double.infinity,
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
                      Icon(Icons.receipt_long, color: primaryColor, size: 20),
                      SizedBox(width: spSm),
                      Text(
                        "Order Details",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  _buildInfoRow("Order ID:", "${orderInfo["id"]}"),
                  _buildInfoRow("Restaurant:", "${orderInfo["restaurant"]}"),
                  _buildInfoRow("Order Time:", "${orderInfo["date"]} at ${orderInfo["time"]}"),
                  _buildInfoRow("Status:", "${orderInfo["status"]}", 
                      valueColor: _getStatusColor(orderInfo["status"])),
                  _buildInfoRow("Estimated Time:", "${orderInfo["estimatedTime"]}"),
                  _buildInfoRow("Total Amount:", "\$${(orderInfo["total"] as double).toStringAsFixed(2)}"),
                ],
              ),
            ),

            // Order Items
            Container(
              width: double.infinity,
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
                      Icon(Icons.fastfood, color: primaryColor, size: 20),
                      SizedBox(width: spSm),
                      Text(
                        "Items to Cancel",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ...(orderInfo["items"] as List).map((item) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusXs),
                            child: Image.network(
                              "${item["image"]}",
                              width: 50,
                              height: 50,
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
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  "Qty: ${item["quantity"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "\$${(item["price"] as double).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Cancellation Reason
            Container(
              width: double.infinity,
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
                      Icon(Icons.help_outline, color: primaryColor, size: 20),
                      SizedBox(width: spSm),
                      Text(
                        "Reason for Cancellation *",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ...cancellationReasons.map((reason) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spXs),
                      child: GestureDetector(
                        onTap: () {
                          selectedReason = reason["value"];
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: selectedReason == reason["value"] 
                                ? primaryColor.withAlpha(20) 
                                : Colors.grey[50],
                            border: Border.all(
                              color: selectedReason == reason["value"] 
                                  ? primaryColor 
                                  : disabledOutlineBorderColor,
                            ),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                selectedReason == reason["value"] 
                                    ? Icons.radio_button_checked 
                                    : Icons.radio_button_unchecked,
                                color: selectedReason == reason["value"] 
                                    ? primaryColor 
                                    : disabledBoldColor,
                                size: 20,
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${reason["label"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: selectedReason == reason["value"] 
                                            ? primaryColor 
                                            : Colors.black,
                                      ),
                                    ),
                                    Text(
                                      "${reason["description"]}",
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
                        ),
                      ),
                    );
                  }).toList(),
                  
                  if (selectedReason == "other") ...[
                    SizedBox(height: spSm),
                    QTextField(
                      label: "Specify Reason",
                      value: customReason,
                      hint: "Please describe your reason for cancellation...",
                      onChanged: (value) {
                        customReason = value;
                        setState(() {});
                      },
                    ),
                  ],
                ],
              ),
            ),

            // Additional Comments
            Container(
              width: double.infinity,
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
                      Icon(Icons.comment, color: primaryColor, size: 20),
                      SizedBox(width: spSm),
                      Text(
                        "Additional Comments (Optional)",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  QMemoField(
                    label: "Any additional information",
                    value: additionalComments,
                    hint: "Share any feedback that might help us improve our service...",
                    onChanged: (value) {
                      additionalComments = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Refund Information
            Container(
              width: double.infinity,
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
                      Icon(Icons.money_off, color: primaryColor, size: 20),
                      SizedBox(width: spSm),
                      Text(
                        "Refund Summary",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  _buildRefundRow("Order Total:", orderInfo["total"] as double),
                  if (cancellationFee > 0)
                    _buildRefundRow("Cancellation Fee:", -cancellationFee, color: dangerColor),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: spXs),
                    height: 1,
                    color: disabledOutlineBorderColor,
                  ),
                  _buildRefundRow("Refund Amount:", refundAmount, isTotal: true),
                  SizedBox(height: spSm),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "Refund will be processed to your original payment method within 3-5 business days.",
                      style: TextStyle(
                        fontSize: 12,
                        color: infoColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Cancellation Policy
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: warningColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.policy, color: warningColor, size: 20),
                      SizedBox(width: spSm),
                      Text(
                        "Cancellation Policy",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "• Free cancellation before restaurant starts preparation",
                    style: TextStyle(fontSize: 12, color: warningColor),
                  ),
                  Text(
                    "• 15% cancellation fee applies once preparation begins",
                    style: TextStyle(fontSize: 12, color: warningColor),
                  ),
                  Text(
                    "• No cancellation allowed once order is dispatched",
                    style: TextStyle(fontSize: 12, color: warningColor),
                  ),
                  Text(
                    "• Refunds processed within 3-5 business days",
                    style: TextStyle(fontSize: 12, color: warningColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [shadowSm],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (refundAmount > 0) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Refund Amount:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "\$${refundAmount.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
            ],
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Keep Order",
                    color: secondaryColor,
                    onPressed: () {
                      back();
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Cancel Order",
                    color: dangerColor,
                    onPressed: () {
                      _confirmCancellation();
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

  Widget _buildInfoRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12,
                color: valueColor ?? Colors.black,
                fontWeight: valueColor != null ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRefundRow(String label, double amount, {Color? color, bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 14 : 12,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: color ?? (isTotal ? Colors.black : disabledBoldColor),
            ),
          ),
          Text(
            "\$${amount.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: isTotal ? 14 : 12,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: color ?? (isTotal ? primaryColor : Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
      case 'preparing':
        return infoColor;
      case 'ready':
      case 'dispatched':
        return warningColor;
      case 'delivered':
        return successColor;
      case 'cancelled':
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  void _confirmCancellation() async {
    if (selectedReason.isEmpty) {
      se("Please select a reason for cancellation");
      return;
    }

    bool isConfirmed = await confirm(
      "Are you sure you want to cancel this order? ${refundAmount > 0 ? 'You will receive a refund of \$${refundAmount.toStringAsFixed(2)}.' : 'This action cannot be undone.'}"
    );

    if (isConfirmed) {
      _processCancellation();
    }
  }

  void _processCancellation() async {
    showLoading();
    
    // Simulate API call
    await Future.delayed(Duration(seconds: 3));
    
    hideLoading();
    
    // Show success message
    ss("Order cancelled successfully! ${refundAmount > 0 ? 'Refund will be processed within 3-5 business days.' : ''}");
    
    // Navigate back to order history or home
    back();
  }
}
