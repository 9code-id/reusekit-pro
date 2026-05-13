import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaRefundRequestView extends StatefulWidget {
  const FdaRefundRequestView({super.key});

  @override
  State<FdaRefundRequestView> createState() => _FdaRefundRequestViewState();
}

class _FdaRefundRequestViewState extends State<FdaRefundRequestView> {
  String selectedReason = "";
  String customReason = "";
  String refundDescription = "";
  String bankAccount = "";
  String accountHolder = "";
  String routingNumber = "";
  String refundMethod = "Original Payment Method";
  bool attachImages = false;
  List<String> attachedImages = [];

  Map<String, dynamic> orderInfo = {
    "id": "ORDER#12345",
    "date": "2024-06-14",
    "restaurant": "Tony's Pizzeria",
    "total": 43.05,
    "status": "Delivered",
    "deliveryTime": "45 minutes",
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

  List<Map<String, dynamic>> refundReasons = [
    {
      "label": "Food Quality Issue",
      "value": "quality",
      "description": "Food was cold, stale, or not fresh"
    },
    {
      "label": "Wrong Order",
      "value": "wrong_order",
      "description": "Received different items than ordered"
    },
    {
      "label": "Missing Items",
      "value": "missing_items",
      "description": "Some items were missing from the order"
    },
    {
      "label": "Late Delivery",
      "value": "late_delivery",
      "description": "Order arrived significantly late"
    },
    {
      "label": "Food Safety Concern",
      "value": "safety",
      "description": "Found foreign objects or contamination"
    },
    {
      "label": "Allergic Reaction",
      "value": "allergy",
      "description": "Food contained undisclosed allergens"
    },
    {
      "label": "Damaged Packaging",
      "value": "packaging",
      "description": "Food packaging was damaged or leaked"
    },
    {
      "label": "Restaurant Cancelled",
      "value": "cancelled",
      "description": "Restaurant cancelled the order"
    },
    {
      "label": "Other",
      "value": "other",
      "description": "Specify your reason below"
    }
  ];

  List<Map<String, dynamic>> refundMethods = [
    {
      "label": "Original Payment Method",
      "value": "original",
      "description": "Refund to the original card/wallet"
    },
    {
      "label": "Bank Account",
      "value": "bank",
      "description": "Direct transfer to bank account"
    },
    {
      "label": "App Wallet",
      "value": "wallet",
      "description": "Add credit to your app wallet"
    },
    {
      "label": "Gift Card",
      "value": "gift_card",
      "description": "Receive a gift card for future orders"
    }
  ];

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Request Refund"),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                          "Order Information",
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
                    _buildInfoRow("Order Date:", "${orderInfo["date"]}"),
                    _buildInfoRow("Total Amount:", "\$${(orderInfo["total"] as double).toStringAsFixed(2)}"),
                    _buildInfoRow("Status:", "${orderInfo["status"]}", 
                        valueColor: orderInfo["status"] == "Delivered" ? successColor : primaryColor),
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
                          "Order Items",
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

              // Refund Reason
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
                          "Reason for Refund *",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    ...refundReasons.map((reason) {
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
                        hint: "Please describe your issue...",
                        validator: Validator.required,
                        onChanged: (value) {
                          customReason = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ],
                ),
              ),

              // Description
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
                        Icon(Icons.description, color: primaryColor, size: 20),
                        SizedBox(width: spSm),
                        Text(
                          "Detailed Description",
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
                      label: "Describe the issue in detail",
                      value: refundDescription,
                      hint: "Please provide as much detail as possible to help us process your refund quickly...",
                      validator: Validator.required,
                      onChanged: (value) {
                        refundDescription = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Photo Evidence
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
                        Icon(Icons.camera_alt, color: primaryColor, size: 20),
                        SizedBox(width: spSm),
                        Text(
                          "Photo Evidence (Optional)",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Attach photos to support your refund request. This helps us process your request faster.",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    QMultiImagePicker(
                      label: "Upload Images",
                      value: attachedImages,
                      maxImages: 5,
                      hint: "Add photos of the issue",
                      onChanged: (value) {
                        attachedImages = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Refund Method
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
                        Icon(Icons.payment, color: primaryColor, size: 20),
                        SizedBox(width: spSm),
                        Text(
                          "Refund Method",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    QDropdownField(
                      label: "Select refund method",
                      items: refundMethods,
                      value: refundMethod,
                      onChanged: (value, label) {
                        refundMethod = value;
                        setState(() {});
                      },
                    ),
                    
                    if (refundMethod == "bank") ...[
                      SizedBox(height: spSm),
                      Text(
                        "Bank Account Details",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      QTextField(
                        label: "Account Holder Name",
                        value: accountHolder,
                        validator: Validator.required,
                        onChanged: (value) {
                          accountHolder = value;
                          setState(() {});
                        },
                      ),
                      SizedBox(height: spSm),
                      QTextField(
                        label: "Bank Account Number",
                        value: bankAccount,
                        validator: Validator.required,
                        onChanged: (value) {
                          bankAccount = value;
                          setState(() {});
                        },
                      ),
                      SizedBox(height: spSm),
                      QTextField(
                        label: "Routing Number",
                        value: routingNumber,
                        validator: Validator.required,
                        onChanged: (value) {
                          routingNumber = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ],
                ),
              ),

              // Refund Policy
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: infoColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline, color: infoColor, size: 20),
                        SizedBox(width: spSm),
                        Text(
                          "Refund Policy",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "• Refund requests must be submitted within 24 hours of delivery",
                      style: TextStyle(fontSize: 12, color: infoColor),
                    ),
                    Text(
                      "• Processing time: 3-5 business days for card refunds, 1-2 days for wallet credit",
                      style: TextStyle(fontSize: 12, color: infoColor),
                    ),
                    Text(
                      "• Photo evidence may be required for quality-related issues",
                      style: TextStyle(fontSize: 12, color: infoColor),
                    ),
                    Text(
                      "• Our team will review your request and contact you if additional information is needed",
                      style: TextStyle(fontSize: 12, color: infoColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
                  "\$${(orderInfo["total"] as double).toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Submit Refund Request",
                onPressed: () {
                  _submitRefundRequest();
                },
              ),
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

  void _submitRefundRequest() async {
    if (!formKey.currentState!.validate()) {
      se("Please fill in all required fields");
      return;
    }

    if (selectedReason.isEmpty) {
      se("Please select a reason for refund");
      return;
    }

    showLoading();
    
    // Simulate API call
    await Future.delayed(Duration(seconds: 3));
    
    hideLoading();
    
    // Show success message
    ss("Refund request submitted successfully!");
    
    // Navigate to refund status or back
    back();
  }
}
