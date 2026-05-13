import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsReturnRequestView extends StatefulWidget {
  const EcsReturnRequestView({super.key});

  @override
  State<EcsReturnRequestView> createState() => _EcsReturnRequestViewState();
}

class _EcsReturnRequestViewState extends State<EcsReturnRequestView> {
  final formKey = GlobalKey<FormState>();
  bool loading = false;
  
  String selectedReason = "";
  String additionalComments = "";
  String refundMethod = "original";
  List<String> selectedItems = [];
  List<String> uploadedImages = [];

  Map<String, dynamic> orderDetails = {
    "orderId": "ORD-2024-001234",
    "orderDate": DateTime.now().subtract(Duration(days: 15)),
    "deliveryDate": DateTime.now().subtract(Duration(days: 10)),
    "total": 156.78,
    "items": [
      {
        "id": "1",
        "name": "Wireless Bluetooth Headphones",
        "image": "https://picsum.photos/100/100?random=1&keyword=headphones",
        "price": 89.99,
        "quantity": 1,
        "sku": "WBH-001",
        "canReturn": true,
        "returnDeadline": DateTime.now().add(Duration(days: 15)),
      },
      {
        "id": "2",
        "name": "Smartphone Protective Case",
        "image": "https://picsum.photos/100/100?random=2&keyword=phonecase",
        "price": 24.99,
        "quantity": 2,
        "sku": "SPC-002",
        "canReturn": true,
        "returnDeadline": DateTime.now().add(Duration(days: 15)),
      },
      {
        "id": "3",
        "name": "USB-C Fast Charging Cable",
        "image": "https://picsum.photos/100/100?random=3&keyword=cable",
        "price": 15.99,
        "quantity": 1,
        "sku": "UFC-003",
        "canReturn": false,
        "returnDeadline": DateTime.now().subtract(Duration(days: 1)),
        "reason": "Return window expired",
      },
    ],
  };

  List<Map<String, dynamic>> returnReasons = [
    {
      "value": "defective",
      "label": "Defective/Damaged Item",
      "description": "Item arrived damaged or not working properly",
    },
    {
      "value": "wrong_item",
      "label": "Wrong Item Received",
      "description": "Received different item than ordered",
    },
    {
      "value": "not_as_described",
      "label": "Not as Described",
      "description": "Item doesn't match product description",
    },
    {
      "value": "size_fit",
      "label": "Size/Fit Issues",
      "description": "Item doesn't fit as expected",
    },
    {
      "value": "quality",
      "label": "Quality Issues",
      "description": "Product quality below expectations",
    },
    {
      "value": "changed_mind",
      "label": "Changed My Mind",
      "description": "No longer need the item",
    },
    {
      "value": "other",
      "label": "Other",
      "description": "Please specify in comments",
    },
  ];

  List<Map<String, dynamic>> refundMethods = [
    {
      "value": "original",
      "label": "Original Payment Method",
      "description": "Refund to the card/method used for purchase",
      "processingTime": "3-5 business days",
    },
    {
      "value": "store_credit",
      "label": "Store Credit",
      "description": "Receive store credit for future purchases",
      "processingTime": "Instant",
      "bonus": "Get 10% bonus credit",
    },
    {
      "value": "gift_card",
      "label": "Gift Card",
      "description": "Receive a digital gift card",
      "processingTime": "1-2 business days",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Return Request"),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Form(
              key: formKey,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Order Information
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Order Information",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Order ID:",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${orderDetails["orderId"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Order Date:",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${(orderDetails["orderDate"] as DateTime).dMMMy}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Delivered:",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${(orderDetails["deliveryDate"] as DateTime).dMMMy}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: spLg),

                    // Select Items to Return
                    Text(
                      "Select Items to Return",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),

                    ...(orderDetails["items"] as List).map((item) {
                      bool canReturn = item["canReturn"];
                      bool isSelected = selectedItems.contains(item["id"]);
                      
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: canReturn 
                                ? (isSelected ? primaryColor : disabledOutlineBorderColor)
                                : dangerColor.withAlpha(30),
                            width: isSelected ? 2 : 1,
                          ),
                          boxShadow: [shadowSm],
                        ),
                        child: GestureDetector(
                          onTap: canReturn ? () {
                            if (isSelected) {
                              selectedItems.remove(item["id"]);
                            } else {
                              selectedItems.add(item["id"]);
                            }
                            setState(() {});
                          } : null,
                          child: Container(
                            padding: EdgeInsets.all(spMd),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(radiusXs),
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
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: canReturn ? primaryColor : disabledBoldColor,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "SKU: ${item["sku"]} • Qty: ${item["quantity"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      if (!canReturn)
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spSm,
                                            vertical: spXs,
                                          ),
                                          decoration: BoxDecoration(
                                            color: dangerColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "${item["reason"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: dangerColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      if (canReturn)
                                        Text(
                                          "Return by ${(item["returnDeadline"] as DateTime).dMMMy}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: successColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "\$${((item["price"] as double)).currency}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: canReturn ? primaryColor : disabledBoldColor,
                                      ),
                                    ),
                                    SizedBox(height: spSm),
                                    if (canReturn)
                                      Icon(
                                        isSelected ? Icons.check_box : Icons.check_box_outline_blank,
                                        color: isSelected ? primaryColor : disabledBoldColor,
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),

                    if (selectedItems.isNotEmpty) ...[
                      SizedBox(height: spLg),

                      // Return Reason
                      Text(
                        "Reason for Return",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),

                      ...returnReasons.map((reason) {
                        bool isSelected = selectedReason == reason["value"];
                        return Container(
                          margin: EdgeInsets.only(bottom: spSm),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: isSelected ? primaryColor : disabledOutlineBorderColor,
                              width: isSelected ? 2 : 1,
                            ),
                            boxShadow: [shadowSm],
                          ),
                          child: GestureDetector(
                            onTap: () {
                              selectedReason = reason["value"];
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.all(spMd),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${reason["label"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                        SizedBox(height: spXs),
                                        Text(
                                          "${reason["description"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                                    color: isSelected ? primaryColor : disabledBoldColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),

                      SizedBox(height: spLg),

                      // Additional Comments
                      Text(
                        "Additional Comments",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),

                      QMemoField(
                        label: "Please provide additional details (optional)",
                        value: additionalComments,
                        onChanged: (value) {
                          additionalComments = value;
                          setState(() {});
                        },
                      ),
                      SizedBox(height: spLg),

                      // Upload Photos
                      Text(
                        "Upload Photos (Optional)",
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
                          borderRadius: BorderRadius.circular(radiusSm),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          children: [
                            if (uploadedImages.isEmpty)
                              Column(
                                children: [
                                  Icon(
                                    Icons.cloud_upload,
                                    size: 48,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(height: spSm),
                                  Text(
                                    "Upload photos to help us process your return faster",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(height: spSm),
                                  QButton(
                                    label: "Select Photos",
                                    size: bs.sm,
                                    onPressed: () {
                                      _selectPhotos();
                                    },
                                  ),
                                ],
                              )
                            else
                              Column(
                                children: [
                                  Wrap(
                                    spacing: spSm,
                                    runSpacing: spSm,
                                    children: uploadedImages.map((image) {
                                      return Container(
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(radiusXs),
                                          border: Border.all(
                                            color: disabledOutlineBorderColor,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(radiusXs),
                                          child: Image.network(
                                            image,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                  SizedBox(height: spSm),
                                  QButton(
                                    label: "Add More Photos",
                                    size: bs.sm,
                                    onPressed: () {
                                      _selectPhotos();
                                    },
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                      SizedBox(height: spLg),

                      // Refund Method
                      Text(
                        "Refund Method",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),

                      ...refundMethods.map((method) {
                        bool isSelected = refundMethod == method["value"];
                        return Container(
                          margin: EdgeInsets.only(bottom: spSm),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: isSelected ? primaryColor : disabledOutlineBorderColor,
                              width: isSelected ? 2 : 1,
                            ),
                            boxShadow: [shadowSm],
                          ),
                          child: GestureDetector(
                            onTap: () {
                              refundMethod = method["value"];
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.all(spMd),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "${method["label"]}",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: primaryColor,
                                              ),
                                            ),
                                            if (method["bonus"] != null) ...[
                                              SizedBox(width: spSm),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: spSm,
                                                  vertical: 2,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: successColor.withAlpha(20),
                                                  borderRadius: BorderRadius.circular(radiusXs),
                                                ),
                                                child: Text(
                                                  "${method["bonus"]}",
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: successColor,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ],
                                        ),
                                        SizedBox(height: spXs),
                                        Text(
                                          "${method["description"]}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        SizedBox(height: spXs),
                                        Text(
                                          "Processing time: ${method["processingTime"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: infoColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                                    color: isSelected ? primaryColor : disabledBoldColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),

                      SizedBox(height: spLg),

                      // Return Summary
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: infoColor.withAlpha(30),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Return Summary",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Items to return:",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${selectedItems.length}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Estimated refund:",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "\$${_calculateRefundAmount().currency}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: spXl),

                      // Submit Button
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "Submit Return Request",
                          size: bs.md,
                          onPressed: _canSubmit() ? _submitReturnRequest : null,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
    );
  }

  double _calculateRefundAmount() {
    double total = 0;
    for (String itemId in selectedItems) {
      final item = (orderDetails["items"] as List).firstWhere((item) => item["id"] == itemId);
      total += (item["price"] as double) * (item["quantity"] as int);
    }
    return total;
  }

  bool _canSubmit() {
    return selectedItems.isNotEmpty && selectedReason.isNotEmpty;
  }

  void _selectPhotos() {
    // Simulate photo selection
    setState(() {
      uploadedImages.addAll([
        "https://picsum.photos/200/200?random=10&keyword=product",
        "https://picsum.photos/200/200?random=11&keyword=product",
      ]);
    });
    ss("Photos selected successfully");
  }

  void _submitReturnRequest() async {
    if (!formKey.currentState!.validate()) return;

    loading = true;
    setState(() {});

    try {
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));
      
      loading = false;
      setState(() {});
      
      ss("Return request submitted successfully");
      back();
    } catch (e) {
      loading = false;
      setState(() {});
      
      se("Failed to submit return request. Please try again.");
    }
  }
}
