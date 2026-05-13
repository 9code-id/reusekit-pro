import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosCustomAmountView extends StatefulWidget {
  const PosCustomAmountView({super.key});

  @override
  State<PosCustomAmountView> createState() => _PosCustomAmountViewState();
}

class _PosCustomAmountViewState extends State<PosCustomAmountView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
  String customAmount = "";
  String productName = "";
  String productDescription = "";
  String category = "Custom";
  String taxRate = "8.5";
  bool applyTax = true;
  bool isService = false;
  String customerNote = "";
  
  // Quick amount buttons
  List<double> quickAmounts = [1.00, 5.00, 10.00, 20.00, 50.00, 100.00];
  
  // Categories for custom items
  List<Map<String, dynamic>> categories = [
    {"label": "Custom", "value": "Custom"},
    {"label": "Service", "value": "Service"},
    {"label": "Fee", "value": "Fee"},
    {"label": "Adjustment", "value": "Adjustment"},
    {"label": "Discount", "value": "Discount"},
    {"label": "Miscellaneous", "value": "Miscellaneous"},
  ];
  
  // Tax rates
  List<Map<String, dynamic>> taxRates = [
    {"label": "No Tax (0%)", "value": "0"},
    {"label": "Sales Tax (8.5%)", "value": "8.5"},
    {"label": "Service Tax (10%)", "value": "10"},
    {"label": "Custom Rate", "value": "custom"},
  ];

  double get totalAmount {
    double amount = double.tryParse(customAmount) ?? 0.0;
    double tax = 0.0;
    
    if (applyTax && taxRate != "0") {
      double rate = double.tryParse(taxRate) ?? 0.0;
      tax = amount * (rate / 100);
    }
    
    return amount + tax;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Custom Amount"),
        actions: [
          QButton(
            label: "Add to Cart",
            size: bs.sm,
            onPressed: _addToCart,
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            spacing: spMd,
            children: [
              _buildAmountInputSection(),
              _buildQuickAmountButtons(),
              _buildProductDetailsSection(),
              _buildTaxSettingsSection(),
              _buildSummarySection(),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAmountInputSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Enter Amount",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QNumberField(
            label: "Amount (\$)",
            value: customAmount,
            validator: Validator.required,
            onChanged: (value) {
              customAmount = value;
              setState(() {});
            },
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: successColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Amount:",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "\$${totalAmount.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAmountButtons() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Quick Amounts",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Wrap(
            spacing: spSm,
            runSpacing: spSm,
            children: quickAmounts.map((amount) {
              return GestureDetector(
                onTap: () {
                  customAmount = amount.toStringAsFixed(2);
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spMd,
                    vertical: spSm,
                  ),
                  decoration: BoxDecoration(
                    color: customAmount == amount.toStringAsFixed(2) 
                        ? primaryColor 
                        : disabledColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: customAmount == amount.toStringAsFixed(2)
                          ? primaryColor
                          : disabledOutlineBorderColor,
                    ),
                  ),
                  child: Text(
                    "\$${amount.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: customAmount == amount.toStringAsFixed(2)
                          ? Colors.white
                          : primaryColor,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildProductDetailsSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Item Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QTextField(
            label: "Item Name",
            value: productName,
            validator: Validator.required,
            hint: "Enter item name",
            onChanged: (value) {
              productName = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Description",
            value: productDescription,
            hint: "Optional description",
            onChanged: (value) {
              productDescription = value;
              setState(() {});
            },
          ),
          QDropdownField(
            label: "Category",
            items: categories,
            value: category,
            onChanged: (value, label) {
              category = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Switch(
                value: isService,
                onChanged: (value) {
                  isService = value;
                  setState(() {});
                },
                activeColor: primaryColor,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "This is a service item",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTaxSettingsSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Tax Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Switch(
                value: applyTax,
                onChanged: (value) {
                  applyTax = value;
                  setState(() {});
                },
                activeColor: primaryColor,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "Apply Tax",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          if (applyTax) ...[
            QDropdownField(
              label: "Tax Rate",
              items: taxRates,
              value: taxRate,
              onChanged: (value, label) {
                taxRate = value;
                setState(() {});
              },
            ),
            if (taxRate == "custom")
              QNumberField(
                label: "Custom Tax Rate (%)",
                value: taxRate == "custom" ? "" : taxRate,
                hint: "Enter tax percentage",
                onChanged: (value) {
                  taxRate = value;
                  setState(() {});
                },
              ),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Tax Amount:",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "\$${(totalAmount - (double.tryParse(customAmount) ?? 0.0)).toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: infoColor,
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

  Widget _buildSummarySection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QMemoField(
            label: "Customer Note",
            value: customerNote,
            hint: "Add any special notes for this item",
            onChanged: (value) {
              customerNote = value;
              setState(() {});
            },
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              border: Border.all(color: disabledOutlineBorderColor),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spXs,
              children: [
                _buildSummaryRow("Item Name:", productName.isEmpty ? "Custom Item" : productName),
                _buildSummaryRow("Category:", category),
                _buildSummaryRow("Type:", isService ? "Service" : "Product"),
                _buildSummaryRow("Base Amount:", "\$${(double.tryParse(customAmount) ?? 0.0).toStringAsFixed(2)}"),
                if (applyTax && taxRate != "0")
                  _buildSummaryRow("Tax (${taxRate}%):", "\$${(totalAmount - (double.tryParse(customAmount) ?? 0.0)).toStringAsFixed(2)}"),
                Divider(color: disabledOutlineBorderColor),
                _buildSummaryRow(
                  "Total Amount:",
                  "\$${totalAmount.toStringAsFixed(2)}",
                  isTotal: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: primaryColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            color: isTotal ? successColor : primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Reset",
                  size: bs.sm,
                  onPressed: _resetForm,
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Save as Template",
                  size: bs.sm,
                  onPressed: _saveAsTemplate,
                ),
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Preview",
                  size: bs.sm,
                  onPressed: _previewItem,
                ),
              ),
              Expanded(
                flex: 2,
                child: QButton(
                  label: "Add to Cart",
                  onPressed: _addToCart,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _addToCart() {
    if (formKey.currentState!.validate()) {
      if (customAmount.isEmpty || double.tryParse(customAmount) == 0) {
        se("Please enter a valid amount");
        return;
      }
      
      ss("Custom item added to cart successfully");
    }
  }

  void _resetForm() {
    customAmount = "";
    productName = "";
    productDescription = "";
    category = "Custom";
    taxRate = "8.5";
    applyTax = true;
    isService = false;
    customerNote = "";
    setState(() {});
    si("Form reset successfully");
  }

  void _saveAsTemplate() {
    if (productName.isEmpty) {
      se("Please enter an item name to save as template");
      return;
    }
    
    ss("Template saved successfully");
  }

  void _previewItem() {
    if (customAmount.isEmpty || double.tryParse(customAmount) == 0) {
      se("Please enter a valid amount to preview");
      return;
    }
    
    si("Preview mode - showing item details");
  }
}
