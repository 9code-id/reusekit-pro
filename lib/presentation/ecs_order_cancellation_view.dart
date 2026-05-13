import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsOrderCancellationView extends StatefulWidget {
  const EcsOrderCancellationView({super.key});

  @override
  State<EcsOrderCancellationView> createState() => _EcsOrderCancellationViewState();
}

class _EcsOrderCancellationViewState extends State<EcsOrderCancellationView> {
  final formKey = GlobalKey<FormState>();
  
  Map<String, dynamic> orderData = {
    "orderNumber": "ORD-2024-001234",
    "orderDate": "2024-06-14",
    "status": "Processing",
    "total": 321.96,
    "estimatedDelivery": "2024-06-20"
  };

  List<Map<String, dynamic>> orderItems = [
    {
      "name": "Wireless Bluetooth Headphones",
      "image": "https://picsum.photos/80/80?random=1&keyword=headphones",
      "price": 129.99,
      "quantity": 1,
      "canCancel": true
    },
    {
      "name": "Smartphone Case Premium",
      "image": "https://picsum.photos/80/80?random=2&keyword=phone-case",
      "price": 24.99,
      "quantity": 2,
      "canCancel": true
    },
    {
      "name": "USB-C Fast Charger",
      "image": "https://picsum.photos/80/80?random=3&keyword=charger",
      "price": 39.99,
      "quantity": 1,
      "canCancel": false
    }
  ];

  String selectedReason = "";
  List<Map<String, dynamic>> cancellationReasons = [
    {"label": "Changed my mind", "value": "changed_mind"},
    {"label": "Found a better price elsewhere", "value": "better_price"},
    {"label": "No longer needed", "value": "not_needed"},
    {"label": "Ordered by mistake", "value": "mistake"},
    {"label": "Item taking too long to arrive", "value": "delayed"},
    {"label": "Product details were incorrect", "value": "incorrect_details"},
    {"label": "Financial constraints", "value": "financial"},
    {"label": "Other", "value": "other"}
  ];

  String additionalComments = "";
  bool requestRefund = true;
  String refundMethod = "original_payment";
  List<String> selectedItems = [];

  @override
  void initState() {
    super.initState();
    // Select all cancellable items by default
    selectedItems = orderItems
        .where((item) => item["canCancel"] as bool)
        .map((item) => item["name"] as String)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cancel Order"),
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
              _buildItemSelection(),
              SizedBox(height: spLg),
              _buildCancellationReason(),
              SizedBox(height: spLg),
              _buildRefundOptions(),
              SizedBox(height: spLg),
              _buildCancellationPolicies(),
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
                "Order Details",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
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
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: warningColor,
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
                      "Total Amount",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "\$${((orderData["total"] as double)).currency}",
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
    );
  }

  Widget _buildItemSelection() {
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
              Icon(Icons.shopping_cart, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Select Items to Cancel",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          ...orderItems.map((item) => _buildItemCard(item)).toList(),
        ],
      ),
    );
  }

  Widget _buildItemCard(Map<String, dynamic> item) {
    bool canCancel = item["canCancel"] as bool;
    bool isSelected = selectedItems.contains(item["name"]);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: isSelected ? primaryColor.withAlpha(20) : null,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: canCancel 
              ? (isSelected ? primaryColor : disabledOutlineBorderColor)
              : disabledColor,
        ),
      ),
      child: Row(
        children: [
          if (canCancel)
            GestureDetector(
              onTap: () => _toggleItemSelection(item["name"]),
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(radiusXs),
                  border: Border.all(
                    color: isSelected ? primaryColor : disabledBoldColor,
                  ),
                ),
                child: isSelected
                    ? Icon(Icons.check, color: Colors.white, size: 14)
                    : null,
              ),
            )
          else
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Icon(Icons.lock, color: Colors.white, size: 12),
            ),
          SizedBox(width: spSm),
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusSm),
              image: DecorationImage(
                image: NetworkImage("${item["image"]}"),
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
                  "${item["name"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: canCancel ? null : disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "Qty: ${item["quantity"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "\$${((item["price"] as double)).currency}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                if (!canCancel) ...[
                  SizedBox(height: spXs),
                  Text(
                    "Cannot be cancelled (Already shipped)",
                    style: TextStyle(
                      color: dangerColor,
                      fontSize: 10,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCancellationReason() {
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
                "Reason for Cancellation",
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
            items: cancellationReasons,
            value: selectedReason,
            validator: Validator.required,
            onChanged: (value, label) {
              selectedReason = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          QMemoField(
            label: "Additional Comments",
            value: additionalComments,
            hint: "Please provide any additional details about your cancellation",
            onChanged: (value) {
              additionalComments = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRefundOptions() {
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
              Icon(Icons.account_balance_wallet, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Refund Options",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          QSwitch(
            items: [
              {
                "label": "Request refund for cancelled items",
                "value": true,
                "checked": requestRefund,
              }
            ],
            value: [if (requestRefund) {"label": "Request refund for cancelled items", "value": true, "checked": true}],
            onChanged: (values, ids) {
              requestRefund = values.isNotEmpty;
              setState(() {});
            },
          ),
          if (requestRefund) ...[
            SizedBox(height: spMd),
            QDropdownField(
              label: "Refund Method",
              items: [
                {"label": "Original Payment Method", "value": "original_payment"},
                {"label": "Store Credit", "value": "store_credit"},
                {"label": "Bank Transfer", "value": "bank_transfer"},
              ],
              value: refundMethod,
              onChanged: (value, label) {
                refundMethod = value;
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
                  Icon(Icons.schedule, color: infoColor, size: 16),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "Refunds typically take 3-5 business days to process",
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
        ],
      ),
    );
  }

  Widget _buildCancellationPolicies() {
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
                "Cancellation Policy",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          _buildPolicyItem("Items can be cancelled until they are shipped"),
          _buildPolicyItem("Refunds will be processed within 3-5 business days"),
          _buildPolicyItem("Digital items cannot be cancelled once delivered"),
          _buildPolicyItem("Custom or personalized items are non-cancellable"),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(color: warningColor.withAlpha(50)),
            ),
            child: Row(
              children: [
                Icon(Icons.warning, color: warningColor, size: 16),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Order cancellation is final and cannot be undone",
                    style: TextStyle(
                      fontSize: 12,
                      color: warningColor,
                      fontWeight: FontWeight.w500,
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
    bool canProceed = selectedItems.isNotEmpty && selectedReason.isNotEmpty;
    
    return Column(
      children: [
        Container(
          width: double.infinity,
          child: QButton(
            label: "Cancel Selected Items",
            size: bs.md,
            onPressed: canProceed ? _processCancellation : null,
          ),
        ),
        SizedBox(height: spSm),
        Container(
          width: double.infinity,
          child: QButton(
            label: "Keep Order",
            size: bs.md,
            onPressed: () => back(),
          ),
        ),
        if (selectedItems.isNotEmpty) ...[
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: primaryColor, size: 16),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Cancelling ${selectedItems.length} item(s) from your order",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  void _toggleItemSelection(String itemName) {
    if (selectedItems.contains(itemName)) {
      selectedItems.remove(itemName);
    } else {
      selectedItems.add(itemName);
    }
    setState(() {});
  }

  void _processCancellation() {
    if (formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Confirm Cancellation"),
          content: Text("Are you sure you want to cancel ${selectedItems.length} item(s) from this order? This action cannot be undone."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Keep Order"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _confirmCancellation();
              },
              child: Text("Cancel Items"),
            ),
          ],
        ),
      );
    }
  }

  void _confirmCancellation() {
    ss("Order cancellation request submitted successfully");
    back();
  }
}
