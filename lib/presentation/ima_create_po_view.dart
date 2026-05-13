import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaCreatePoView extends StatefulWidget {
  const ImaCreatePoView({super.key});

  @override
  State<ImaCreatePoView> createState() => _ImaCreatePoViewState();
}

class _ImaCreatePoViewState extends State<ImaCreatePoView> {
  final formKey = GlobalKey<FormState>();
  
  // PO Basic Information
  String poNumber = "";
  String selectedSupplier = "";
  String selectedDepartment = "";
  String requestedBy = "";
  String priority = "Medium";
  String deliveryDate = "";
  String deliveryAddress = "";
  String notes = "";
  
  // Line Items
  List<Map<String, dynamic>> lineItems = [];
  
  // Totals
  double subtotal = 0.0;
  double taxRate = 10.0;
  double taxAmount = 0.0;
  double shippingCost = 0.0;
  double totalAmount = 0.0;
  
  // Form Data
  List<Map<String, dynamic>> suppliers = [
    {"label": "Global Electronics Supply Co.", "value": "SUP001"},
    {"label": "Advanced Components Inc.", "value": "SUP002"},
    {"label": "Industrial Materials Corp.", "value": "SUP003"},
    {"label": "Quick Delivery Services", "value": "SUP004"},
    {"label": "Office Solutions Plus", "value": "SUP005"},
  ];
  
  List<Map<String, dynamic>> departments = [
    {"label": "Electronics", "value": "electronics"},
    {"label": "Components", "value": "components"},
    {"label": "Materials", "value": "materials"},
    {"label": "Packaging", "value": "packaging"},
    {"label": "Office Supplies", "value": "office"},
    {"label": "IT Equipment", "value": "it"},
  ];
  
  List<Map<String, dynamic>> priorities = [
    {"label": "Low", "value": "Low"},
    {"label": "Medium", "value": "Medium"},
    {"label": "High", "value": "High"},
    {"label": "Urgent", "value": "Urgent"},
  ];
  
  List<Map<String, dynamic>> availableProducts = [
    {"id": "PROD001", "name": "Arduino Uno R3", "sku": "ARD-UNO-R3", "price": 25.99, "unit": "pcs"},
    {"id": "PROD002", "name": "Raspberry Pi 4", "sku": "RPI-4-8GB", "price": 89.99, "unit": "pcs"},
    {"id": "PROD003", "name": "LED Strip 5m", "sku": "LED-STRIP-5M", "price": 15.50, "unit": "pcs"},
    {"id": "PROD004", "name": "Resistor Kit", "sku": "RES-KIT-100", "price": 12.75, "unit": "kit"},
    {"id": "PROD005", "name": "Jumper Wires", "sku": "JUMP-WIRE-40", "price": 8.25, "unit": "pack"},
  ];

  @override
  void initState() {
    super.initState();
    _generatePONumber();
    _addLineItem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Purchase Order"),
        actions: [
          IconButton(
            onPressed: () {
              _saveDraft();
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBasicInformation(),
                    SizedBox(height: spLg),
                    _buildLineItems(),
                    SizedBox(height: spLg),
                    _buildTotalsSection(),
                    SizedBox(height: spLg),
                    _buildDeliveryInfo(),
                    SizedBox(height: spLg),
                    _buildAdditionalNotes(),
                  ],
                ),
              ),
            ),
            _buildBottomActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildBasicInformation() {
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
          Text(
            "Purchase Order Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "PO Number",
                  value: poNumber,
                  onChanged: (value) {
                    poNumber = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QDropdownField(
                  label: "Priority *",
                  items: priorities,
                  value: priority,
                  validator: Validator.required,
                  onChanged: (value, label) {
                    priority = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          QDropdownField(
            label: "Supplier *",
            items: suppliers,
            value: selectedSupplier,
            validator: Validator.required,
            onChanged: (value, label) {
              selectedSupplier = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Department *",
                  items: departments,
                  value: selectedDepartment,
                  validator: Validator.required,
                  onChanged: (value, label) {
                    selectedDepartment = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QTextField(
                  label: "Requested By *",
                  value: requestedBy,
                  validator: Validator.required,
                  onChanged: (value) {
                    requestedBy = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          QDatePicker(
            label: "Required Delivery Date *",
            value: deliveryDate.isNotEmpty ? DateTime.parse(deliveryDate) : DateTime.now().add(Duration(days: 7)),
            onChanged: (value) {
              deliveryDate = value.toIso8601String().split('T')[0];
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLineItems() {
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
              Text(
                "Line Items",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Add Item",
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {
                  _addLineItem();
                },
              ),
            ],
          ),
          SizedBox(height: spMd),
          Column(
            children: lineItems.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> item = entry.value;
              return _buildLineItemCard(item, index);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildLineItemCard(Map<String, dynamic> item, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Item ${index + 1}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              if (lineItems.length > 1)
                GestureDetector(
                  onTap: () {
                    _removeLineItem(index);
                  },
                  child: Icon(
                    Icons.close,
                    color: dangerColor,
                    size: 20,
                  ),
                ),
            ],
          ),
          SizedBox(height: spMd),
          QDropdownField(
            label: "Product *",
            items: availableProducts.map((product) {
              return {
                "label": "${product["name"]} (${product["sku"]})",
                "value": product["id"],
              };
            }).toList(),
            value: item["productId"] ?? "",
            onChanged: (value, label) {
              _updateLineItem(index, "productId", value);
              
              // Auto-fill product details
              Map<String, dynamic> selectedProduct = availableProducts.firstWhere(
                (product) => product["id"] == value,
                orElse: () => {},
              );
              
              if (selectedProduct.isNotEmpty) {
                _updateLineItem(index, "productName", selectedProduct["name"]);
                _updateLineItem(index, "sku", selectedProduct["sku"]);
                _updateLineItem(index, "unitPrice", selectedProduct["price"]);
                _updateLineItem(index, "unit", selectedProduct["unit"]);
              }
            },
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QNumberField(
                  label: "Quantity *",
                  value: "${item["quantity"] ?? 1}",
                  onChanged: (value) {
                    _updateLineItem(index, "quantity", double.tryParse(value) ?? 1);
                  },
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QTextField(
                  label: "Unit",
                  value: item["unit"] ?? "",
                  onChanged: (value) {
                    _updateLineItem(index, "unit", value);
                  },
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QNumberField(
                  label: "Unit Price *",
                  value: "${item["unitPrice"] ?? 0.0}",
                  onChanged: (value) {
                    _updateLineItem(index, "unitPrice", double.tryParse(value) ?? 0.0);
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Description",
                  value: item["description"] ?? "",
                  onChanged: (value) {
                    _updateLineItem(index, "description", value);
                  },
                ),
              ),
              SizedBox(width: spMd),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  children: [
                    Text(
                      "Line Total",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${(((item["quantity"] ?? 1) * (item["unitPrice"] ?? 0.0)) as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
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

  Widget _buildTotalsSection() {
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
          Text(
            "Order Totals",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QNumberField(
                  label: "Tax Rate (%)",
                  value: "$taxRate",
                  onChanged: (value) {
                    taxRate = double.tryParse(value) ?? 0.0;
                    _calculateTotals();
                  },
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QNumberField(
                  label: "Shipping Cost",
                  value: "$shippingCost",
                  onChanged: (value) {
                    shippingCost = double.tryParse(value) ?? 0.0;
                    _calculateTotals();
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              children: [
                _buildTotalRow("Subtotal", subtotal),
                _buildTotalRow("Tax Amount", taxAmount),
                _buildTotalRow("Shipping", shippingCost),
                Divider(),
                _buildTotalRow("Total Amount", totalAmount, isTotal: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalRow(String label, double amount, {bool isTotal = false}) {
    return Container(
      margin: EdgeInsets.only(bottom: isTotal ? 0 : spSm),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Spacer(),
          Text(
            "\$${amount.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: FontWeight.bold,
              color: isTotal ? primaryColor : disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryInfo() {
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
          Text(
            "Delivery Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          QMemoField(
            label: "Delivery Address *",
            value: deliveryAddress,
            validator: Validator.required,
            onChanged: (value) {
              deliveryAddress = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalNotes() {
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
          Text(
            "Additional Notes",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          QMemoField(
            label: "Notes",
            value: notes,
            hint: "Enter any special instructions or requirements",
            onChanged: (value) {
              notes = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Expanded(
            child: QButton(
              label: "Save as Draft",
              size: bs.md,
              color: disabledBoldColor,
              onPressed: () {
                _saveDraft();
              },
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: QButton(
              label: "Submit for Approval",
              size: bs.md,
              onPressed: () {
                _submitForApproval();
              },
            ),
          ),
        ],
      ),
    );
  }

  void _generatePONumber() {
    DateTime now = DateTime.now();
    int randomNumber = DateTime.now().millisecondsSinceEpoch % 10000;
    poNumber = "PO-${now.year}-${randomNumber.toString().padLeft(4, '0')}";
    setState(() {});
  }

  void _addLineItem() {
    lineItems.add({
      "productId": "",
      "productName": "",
      "sku": "",
      "description": "",
      "quantity": 1,
      "unit": "pcs",
      "unitPrice": 0.0,
    });
    setState(() {});
  }

  void _removeLineItem(int index) {
    lineItems.removeAt(index);
    _calculateTotals();
  }

  void _updateLineItem(int index, String key, dynamic value) {
    lineItems[index][key] = value;
    _calculateTotals();
  }

  void _calculateTotals() {
    subtotal = lineItems.fold(0.0, (sum, item) {
      return sum + ((item["quantity"] ?? 1) * (item["unitPrice"] ?? 0.0));
    });
    
    taxAmount = (subtotal * taxRate) / 100;
    totalAmount = subtotal + taxAmount + shippingCost;
    
    setState(() {});
  }

  void _saveDraft() {
    si("Purchase order saved as draft!");
  }

  void _submitForApproval() {
    if (formKey.currentState!.validate()) {
      if (lineItems.isEmpty) {
        se("Please add at least one line item!");
        return;
      }
      
      bool hasValidItems = lineItems.any((item) => 
        item["productId"] != null && 
        item["productId"].toString().isNotEmpty &&
        (item["quantity"] ?? 0) > 0 &&
        (item["unitPrice"] ?? 0) > 0
      );
      
      if (!hasValidItems) {
        se("Please ensure all line items have valid product, quantity, and price!");
        return;
      }
      
      showLoading();
      
      // Simulate API call
      Future.delayed(Duration(seconds: 2), () {
        hideLoading();
        ss("Purchase order submitted for approval!");
        back();
      });
    }
  }
}
