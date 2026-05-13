import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsExchangeRequestView extends StatefulWidget {
  const EcsExchangeRequestView({super.key});

  @override
  State<EcsExchangeRequestView> createState() => _EcsExchangeRequestViewState();
}

class _EcsExchangeRequestViewState extends State<EcsExchangeRequestView> {
  final formKey = GlobalKey<FormState>();
  
  Map<String, dynamic> orderData = {
    "orderNumber": "ORD-2024-001234",
    "orderDate": "2024-06-10",
    "deliveryDate": "2024-06-14",
    "status": "Delivered"
  };

  Map<String, dynamic> selectedItem = {
    "name": "Wireless Bluetooth Headphones",
    "image": "https://picsum.photos/200/200?random=1&keyword=headphones",
    "price": 129.99,
    "sku": "WBH-2024-001",
    "color": "Black",
    "size": "One Size",
    "quantity": 1
  };

  String exchangeReason = "";
  List<Map<String, dynamic>> exchangeReasons = [
    {"label": "Wrong size", "value": "wrong_size"},
    {"label": "Wrong color", "value": "wrong_color"},
    {"label": "Defective/Damaged", "value": "defective"},
    {"label": "Not as described", "value": "not_described"},
    {"label": "Poor quality", "value": "poor_quality"},
    {"label": "Changed my mind", "value": "changed_mind"},
    {"label": "Other", "value": "other"}
  ];

  String newColor = "";
  String newSize = "";
  List<String> availableColors = ["Black", "White", "Blue", "Red", "Gray"];
  List<String> availableSizes = ["Small", "Medium", "Large", "XL", "One Size"];

  String description = "";
  List<String> uploadedImages = [];
  bool includeReturnShipping = true;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exchange Request"),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildOrderInfo(),
              SizedBox(height: spLg),
              _buildItemDetails(),
              SizedBox(height: spLg),
              _buildExchangeReason(),
              SizedBox(height: spLg),
              _buildExchangePreferences(),
              SizedBox(height: spLg),
              _buildUploadProof(),
              SizedBox(height: spLg),
              _buildExchangePolicy(),
              SizedBox(height: spXl),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderInfo() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.receipt_long, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Order Information",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order Number",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "${orderData["orderNumber"]}",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: successColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${orderData["status"]}",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order Date",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "${orderData["orderDate"]}",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Delivered",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "${orderData["deliveryDate"]}",
                      style: TextStyle(fontWeight: FontWeight.w500),
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

  Widget _buildItemDetails() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.inventory, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Item to Exchange",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusSm),
                  image: DecorationImage(
                    image: NetworkImage("${selectedItem["image"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${selectedItem["name"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: fsH6,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "SKU: ${selectedItem["sku"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Text(
                          "Color: ${selectedItem["color"]}",
                          style: TextStyle(fontSize: 12),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Size: ${selectedItem["size"]}",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "\$${((selectedItem["price"] as double)).currency}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                        fontSize: fsH6,
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

  Widget _buildExchangeReason() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.help_outline, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Reason for Exchange",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          QDropdownField(
            label: "Select Reason",
            items: exchangeReasons,
            value: exchangeReason,
            validator: Validator.required,
            onChanged: (value, label) {
              exchangeReason = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          QMemoField(
            label: "Description",
            value: description,
            hint: "Please provide detailed description of the issue",
            validator: Validator.required,
            onChanged: (value) {
              description = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildExchangePreferences() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.swap_horiz, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Exchange Preferences",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          if (exchangeReason == "wrong_color" || exchangeReason == "changed_mind") ...[
            QDropdownField(
              label: "Preferred Color",
              items: availableColors.map((color) => {
                "label": color,
                "value": color,
              }).toList(),
              value: newColor,
              onChanged: (value, label) {
                newColor = value;
                setState(() {});
              },
            ),
            SizedBox(height: spMd),
          ],
          if (exchangeReason == "wrong_size" || exchangeReason == "changed_mind") ...[
            QDropdownField(
              label: "Preferred Size",
              items: availableSizes.map((size) => {
                "label": size,
                "value": size,
              }).toList(),
              value: newSize,
              onChanged: (value, label) {
                newSize = value;
                setState(() {});
              },
            ),
            SizedBox(height: spMd),
          ],
          QSwitch(
            items: [
              {
                "label": "Include prepaid return shipping label",
                "value": true,
                "checked": includeReturnShipping,
              }
            ],
            value: [if (includeReturnShipping) {"label": "Include prepaid return shipping label", "value": true, "checked": true}],
            onChanged: (values, ids) {
              includeReturnShipping = values.isNotEmpty;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildUploadProof() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.camera_alt, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Upload Images",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          QMultiImagePicker(
            label: "Product Images",
            value: uploadedImages,
            maxImages: 5,
            hint: "Upload photos showing the issue",
            onChanged: (value) {
              uploadedImages = value;
              setState(() {});
            },
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: infoColor.withAlpha(50)),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: infoColor, size: 16),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Clear photos help us process your exchange faster",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExchangePolicy() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.policy, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Exchange Policy",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          _buildPolicyItem("Items must be in original condition with tags"),
          _buildPolicyItem("Exchange requests within 30 days of delivery"),
          _buildPolicyItem("Free return shipping for defective items"),
          _buildPolicyItem("Processing time: 3-7 business days"),
          _buildPolicyItem("New item will be shipped after inspection"),
        ],
      ),
    );
  }

  Widget _buildPolicyItem(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: spXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 6),
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: primaryColor,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          child: QButton(
            label: "Submit Exchange Request",
            size: bs.md,
            onPressed: _submitExchangeRequest,
          ),
        ),
        SizedBox(height: spSm),
        Container(
          width: double.infinity,
          child: QButton(
            label: "Cancel",
            size: bs.md,
            onPressed: () => back(),
          ),
        ),
        SizedBox(height: spSm),
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: successColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Row(
            children: [
              Icon(Icons.check_circle_outline, color: successColor, size: 16),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "No charges apply for exchanges due to defects",
                  style: TextStyle(
                    color: successColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _submitExchangeRequest() {
    if (formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Confirm Exchange Request"),
          content: Text("Submit exchange request for ${selectedItem["name"]}? You will receive a confirmation email with tracking details."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _confirmExchange();
              },
              child: Text("Submit"),
            ),
          ],
        ),
      );
    }
  }

  void _confirmExchange() {
    ss("Exchange request submitted successfully");
    back();
  }
}
