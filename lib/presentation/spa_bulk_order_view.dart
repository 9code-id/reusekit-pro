import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaBulkOrderView extends StatefulWidget {
  const SpaBulkOrderView({super.key});

  @override
  State<SpaBulkOrderView> createState() => _SpaBulkOrderViewState();
}

class _SpaBulkOrderViewState extends State<SpaBulkOrderView> {
  String orderName = "Q1 2025 Spa Supplies";
  String deliveryDate = "";
  String deliveryAddress = "123 Main Street, Downtown";
  String deliveryCity = "New York, NY 10002";
  String specialInstructions = "";
  String paymentMethod = "Net 30";
  bool rushOrder = false;
  bool splitDelivery = false;
  
  List<String> paymentMethods = ["Net 15", "Net 30", "Credit Card", "Bank Transfer"];
  
  List<Map<String, dynamic>> categories = [
    {
      "name": "Massage Oils & Lotions",
      "icon": Icons.spa,
      "itemCount": 15,
      "totalValue": 2450.75,
      "selected": true
    },
    {
      "name": "Skincare Products",
      "icon": Icons.face,
      "itemCount": 28,
      "totalValue": 4850.50,
      "selected": true
    },
    {
      "name": "Aromatherapy",
      "icon": Icons.local_florist,
      "itemCount": 12,
      "totalValue": 1890.25,
      "selected": false
    },
    {
      "name": "Spa Equipment",
      "icon": Icons.medical_services,
      "itemCount": 8,
      "totalValue": 8750.00,
      "selected": true
    },
    {
      "name": "Linens & Towels",
      "icon": Icons.dry_cleaning,
      "itemCount": 25,
      "totalValue": 3250.75,
      "selected": true
    },
    {
      "name": "Cleaning Supplies",
      "icon": Icons.cleaning_services,
      "itemCount": 18,
      "totalValue": 890.50,
      "selected": false
    },
  ];
  
  List<Map<String, dynamic>> bulkItems = [
    {
      "name": "Premium Massage Oil Set",
      "sku": "PMO-001",
      "category": "Massage Oils & Lotions",
      "unitPrice": 89.99,
      "minQuantity": 10,
      "quantity": 50,
      "bulkDiscount": 15.0,
      "totalPrice": 3824.79,
      "inStock": 200,
      "image": "https://picsum.photos/80/80?random=201&keyword=oil"
    },
    {
      "name": "Organic Face Mask Collection",
      "sku": "OFM-002",
      "category": "Skincare Products",
      "unitPrice": 149.99,
      "minQuantity": 20,
      "quantity": 100,
      "bulkDiscount": 20.0,
      "totalPrice": 11999.20,
      "inStock": 150,
      "image": "https://picsum.photos/80/80?random=202&keyword=mask"
    },
    {
      "name": "Professional Spa Table",
      "sku": "PST-003",
      "category": "Spa Equipment",
      "unitPrice": 1299.99,
      "minQuantity": 2,
      "quantity": 5,
      "bulkDiscount": 10.0,
      "totalPrice": 5849.95,
      "inStock": 25,
      "image": "https://picsum.photos/80/80?random=203&keyword=table"
    },
    {
      "name": "Luxury Spa Towel Set",
      "sku": "LST-004",
      "category": "Linens & Towels",
      "unitPrice": 45.99,
      "minQuantity": 25,
      "quantity": 200,
      "bulkDiscount": 25.0,
      "totalPrice": 6898.50,
      "inStock": 500,
      "image": "https://picsum.photos/80/80?random=204&keyword=towel"
    },
    {
      "name": "Essential Oil Diffuser",
      "sku": "EOD-005",
      "category": "Aromatherapy",
      "unitPrice": 129.99,
      "minQuantity": 5,
      "quantity": 15,
      "bulkDiscount": 12.0,
      "totalPrice": 1715.87,
      "inStock": 80,
      "image": "https://picsum.photos/80/80?random=205&keyword=diffuser"
    },
    {
      "name": "Anti-Aging Serum Bundle",
      "sku": "AAS-006",
      "category": "Skincare Products",
      "unitPrice": 89.99,
      "minQuantity": 15,
      "quantity": 75,
      "bulkDiscount": 18.0,
      "totalPrice": 5539.39,
      "inStock": 120,
      "image": "https://picsum.photos/80/80?random=206&keyword=serum"
    },
  ];
  
  Map<String, dynamic> orderSummary = {
    "subtotal": 35827.70,
    "bulkDiscount": 6896.42,
    "shipping": 0.0,
    "tax": 2314.50,
    "total": 31245.78,
    "estimatedSavings": 6896.42
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bulk Order"),
        actions: [
          QButton(
            icon: Icons.save,
            size: bs.sm,
            onPressed: () {
              _saveDraft();
            },
          ),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Order Header
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Icon(
                          Icons.shopping_cart,
                          color: primaryColor,
                          size: 32,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Bulk Order Request",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Save up to 25% on bulk purchases",
                              style: TextStyle(
                                color: successColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                        decoration: BoxDecoration(
                          color: warningColor,
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Text(
                          "DRAFT",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  QTextField(
                    label: "Order Name",
                    value: orderName,
                    hint: "Enter a name for this bulk order",
                    onChanged: (value) {
                      orderName = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Quick Category Selection
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Product Categories",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: categories.map((category) => _buildCategoryCard(category)).toList(),
                  ),
                ],
              ),
            ),

            // Bulk Items
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Text(
                        "Bulk Items",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "Add Items",
                        size: bs.sm,
                        icon: Icons.add,
                        onPressed: () {
                          _addBulkItems();
                        },
                      ),
                    ],
                  ),
                  ...bulkItems.map((item) => _buildBulkItem(item)).toList(),
                ],
              ),
            ),

            // Order Settings
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Delivery & Payment",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QDatePicker(
                    label: "Preferred Delivery Date",
                    value: deliveryDate.isNotEmpty ? DateTime.parse(deliveryDate) : DateTime.now().add(Duration(days: 14)),
                    onChanged: (value) {
                      deliveryDate = value.toString();
                      setState(() {});
                    },
                  ),
                  QTextField(
                    label: "Delivery Address",
                    value: deliveryAddress,
                    onChanged: (value) {
                      deliveryAddress = value;
                      setState(() {});
                    },
                  ),
                  QTextField(
                    label: "City, State, ZIP",
                    value: deliveryCity,
                    onChanged: (value) {
                      deliveryCity = value;
                      setState(() {});
                    },
                  ),
                  QDropdownField(
                    label: "Payment Terms",
                    items: paymentMethods.map((method) => {"label": method, "value": method}).toList(),
                    value: paymentMethod,
                    onChanged: (value, label) {
                      paymentMethod = value;
                      setState(() {});
                    },
                  ),
                  QMemoField(
                    label: "Special Instructions",
                    value: specialInstructions,
                    hint: "Any specific delivery or handling requirements",
                    onChanged: (value) {
                      specialInstructions = value;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {"label": "Rush Order (+15% fee)", "value": "rush", "checked": rushOrder},
                      {"label": "Split Delivery Allowed", "value": "split", "checked": splitDelivery},
                    ],
                    value: [
                      if (rushOrder) {"label": "Rush Order (+15% fee)", "value": "rush", "checked": true},
                      if (splitDelivery) {"label": "Split Delivery Allowed", "value": "split", "checked": true},
                    ],
                    onChanged: (values, ids) {
                      rushOrder = values.any((v) => v["value"] == "rush");
                      splitDelivery = values.any((v) => v["value"] == "split");
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Order Summary
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Order Summary",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.savings,
                          color: successColor,
                          size: 32,
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total Savings",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: successColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "\$${(orderSummary["estimatedSavings"] as double).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: fsH5,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "vs. Regular Pricing",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildSummaryRow("Subtotal", orderSummary["subtotal"]),
                  _buildSummaryRow("Bulk Discount", -orderSummary["bulkDiscount"], color: successColor),
                  _buildSummaryRow("Shipping", orderSummary["shipping"]),
                  if (rushOrder)
                    _buildSummaryRow("Rush Fee (15%)", (orderSummary["subtotal"] as double) * 0.15, color: warningColor),
                  _buildSummaryRow("Tax", orderSummary["tax"]),
                  Divider(color: disabledOutlineBorderColor),
                  _buildSummaryRow("Total Amount", orderSummary["total"], isTotal: true),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info,
                          color: infoColor,
                          size: 16,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "Bulk discounts automatically applied. Free shipping on orders over \$25,000.",
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
            ),

            // Action Buttons
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Save as Draft",
                          size: bs.md,
                          icon: Icons.save,
                          color: infoColor,
                          onPressed: () {
                            _saveDraft();
                          },
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: QButton(
                          label: "Request Quote",
                          size: bs.md,
                          icon: Icons.request_quote,
                          color: warningColor,
                          onPressed: () {
                            _requestQuote();
                          },
                        ),
                      ),
                    ],
                  ),
                  QButton(
                    label: "Submit Bulk Order",
                    size: bs.md,
                    icon: Icons.send,
                    onPressed: () {
                      _submitBulkOrder();
                    },
                  ),
                  Text(
                    "Bulk orders require approval and may take 3-5 business days to process",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(Map<String, dynamic> category) {
    bool isSelected = category["selected"];
    
    return GestureDetector(
      onTap: () {
        category["selected"] = !isSelected;
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withAlpha(30) : Colors.grey[50],
          borderRadius: BorderRadius.circular(radiusLg),
          border: Border.all(
            color: isSelected ? primaryColor : disabledOutlineBorderColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  category["icon"],
                  color: isSelected ? primaryColor : disabledBoldColor,
                  size: 20,
                ),
                Spacer(),
                if (isSelected)
                  Icon(
                    Icons.check_circle,
                    color: primaryColor,
                    size: 16,
                  ),
              ],
            ),
            SizedBox(height: spSm),
            Text(
              "${category["name"]}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isSelected ? primaryColor : disabledBoldColor,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              "${category["itemCount"]} items",
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? primaryColor : disabledBoldColor,
              ),
            ),
            Text(
              "\$${(category["totalValue"] as double).toStringAsFixed(0)}",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isSelected ? successColor : disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBulkItem(Map<String, dynamic> item) {
    double originalPrice = (item["unitPrice"] as double) * (item["quantity"] as int);
    double discountAmount = originalPrice * ((item["bulkDiscount"] as double) / 100);
    double finalPrice = originalPrice - discountAmount;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: disabledOutlineBorderColor.withAlpha(50)),
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
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "${item["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "SKU: ${item["sku"]} • ${item["category"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Qty: ${item["quantity"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Text(
                      "@ \$${(item["unitPrice"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${item["bulkDiscount"].toInt()}% BULK DISCOUNT",
                        style: TextStyle(
                          color: successColor,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Min: ${item["minQuantity"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: warningColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Stock: ${item["inStock"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: (item["inStock"] as int) > (item["quantity"] as int) ? successColor : dangerColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: spMd),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "\$${finalPrice.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "\$${originalPrice.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              Text(
                "Save \$${discountAmount.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 12,
                  color: successColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.edit,
            size: bs.sm,
            onPressed: () {
              _editBulkItem(item);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, double amount, {Color? color, bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: spXs),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: isTotal ? 16 : 14,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
                color: color ?? (isTotal ? primaryColor : disabledBoldColor),
              ),
            ),
          ),
          Text(
            "${amount < 0 ? '-' : ''}\$${amount.abs().toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: isTotal ? 18 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
              color: color ?? (isTotal ? primaryColor : primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  void _addBulkItems() {
    ss("Opening bulk item catalog...");
  }

  void _editBulkItem(Map<String, dynamic> item) {
    ss("Editing ${item["name"]}...");
  }

  void _saveDraft() {
    ss("Bulk order saved as draft");
  }

  void _requestQuote() async {
    bool confirmed = await confirm("Request a custom quote for this bulk order?");
    if (confirmed) {
      ss("Quote request submitted. You will receive a response within 24 hours.");
    }
  }

  void _submitBulkOrder() async {
    if (orderName.isEmpty) {
      se("Please enter an order name");
      return;
    }
    
    if (deliveryAddress.isEmpty) {
      se("Please enter a delivery address");
      return;
    }
    
    bool confirmed = await confirm("Submit this bulk order for processing?");
    if (confirmed) {
      ss("Bulk order submitted successfully. Order ID: BULK-${DateTime.now().millisecondsSinceEpoch}");
    }
  }
}
