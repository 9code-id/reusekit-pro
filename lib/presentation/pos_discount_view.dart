import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosDiscountView extends StatefulWidget {
  const PosDiscountView({super.key});

  @override
  State<PosDiscountView> createState() => _PosDiscountViewState();
}

class _PosDiscountViewState extends State<PosDiscountView> {
  String discountType = "percentage";
  String discountValue = "";
  String discountCode = "";
  String discountReason = "";
  bool isManagerApprovalRequired = false;
  String managerCode = "";
  
  final List<Map<String, dynamic>> discountTypes = [
    {"label": "Percentage (%)", "value": "percentage"},
    {"label": "Fixed Amount (\$)", "value": "fixed"},
    {"label": "Buy One Get One", "value": "bogo"},
  ];

  final List<Map<String, dynamic>> predefinedDiscounts = [
    {
      "name": "Senior Citizen",
      "type": "percentage",
      "value": 10,
      "code": "SENIOR10",
      "requires_approval": false,
    },
    {
      "name": "Student Discount",
      "type": "percentage", 
      "value": 15,
      "code": "STUDENT15",
      "requires_approval": false,
    },
    {
      "name": "Employee Discount",
      "type": "percentage",
      "value": 20,
      "code": "EMP20",
      "requires_approval": true,
    },
    {
      "name": "Manager Special",
      "type": "fixed",
      "value": 50,
      "code": "MGR50",
      "requires_approval": true,
    },
  ];

  double originalAmount = 847.50;
  double discountAmount = 0.0;
  double finalAmount = 847.50;

  void _calculateDiscount() {
    if (discountValue.isEmpty) {
      discountAmount = 0.0;
      finalAmount = originalAmount;
      setState(() {});
      return;
    }

    double value = double.tryParse(discountValue) ?? 0.0;
    
    if (discountType == "percentage") {
      discountAmount = (originalAmount * value) / 100;
    } else if (discountType == "fixed") {
      discountAmount = value;
    } else if (discountType == "bogo") {
      discountAmount = originalAmount * 0.5;
    }
    
    finalAmount = originalAmount - discountAmount;
    if (finalAmount < 0) finalAmount = 0;
    
    setState(() {});
  }

  void _applyPredefinedDiscount(Map<String, dynamic> discount) {
    discountType = "${discount["type"]}";
    discountValue = "${discount["value"]}";
    discountCode = "${discount["code"]}";
    isManagerApprovalRequired = discount["requires_approval"] as bool;
    _calculateDiscount();
  }

  void _applyDiscount() async {
    if (discountValue.isEmpty) {
      se("Please enter discount value");
      return;
    }

    if (isManagerApprovalRequired && managerCode.isEmpty) {
      se("Manager approval code required");
      return;
    }

    bool isConfirmed = await confirm("Apply this discount to the transaction?");
    if (isConfirmed) {
      ss("Discount applied successfully");
      back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Apply Discount"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              si("Select discount type and enter value to apply discount");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Transaction Summary
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Original Amount",
                        style: TextStyle(
                          fontSize: 16,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "\$${originalAmount.currency}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  if (discountAmount > 0) ...[
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Discount",
                          style: TextStyle(
                            fontSize: 16,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "-\$${discountAmount.currency}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Final Amount",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "\$${finalAmount.currency}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),

            // Predefined Discounts
            Container(
              padding: EdgeInsets.all(spMd),
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
                    "Quick Discounts",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 160,
                    children: predefinedDiscounts.map((discount) {
                      return GestureDetector(
                        onTap: () => _applyPredefinedDiscount(discount),
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: primaryColor.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${discount["name"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  if (discount["requires_approval"] as bool)
                                    Icon(
                                      Icons.admin_panel_settings,
                                      size: 16,
                                      color: warningColor,
                                    ),
                                ],
                              ),
                              
                              Text(
                                "${discount["type"]}" == "percentage" 
                                  ? "${discount["value"]}% OFF"
                                  : "\$${(discount["value"] as num).currency} OFF",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: successColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              
                              Text(
                                "${discount["code"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Custom Discount
            Container(
              padding: EdgeInsets.all(spMd),
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
                    "Custom Discount",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  QDropdownField(
                    label: "Discount Type",
                    items: discountTypes,
                    value: discountType,
                    onChanged: (value, label) {
                      discountType = value;
                      _calculateDiscount();
                    },
                  ),

                  if (discountType != "bogo")
                    QNumberField(
                      label: discountType == "percentage" ? "Discount (%)" : "Discount Amount (\$)",
                      value: discountValue,
                      onChanged: (value) {
                        discountValue = value;
                        _calculateDiscount();
                      },
                    ),

                  QTextField(
                    label: "Discount Code (Optional)",
                    value: discountCode,
                    hint: "Enter discount code",
                    onChanged: (value) {
                      discountCode = value;
                      setState(() {});
                    },
                  ),

                  QTextField(
                    label: "Reason for Discount",
                    value: discountReason,
                    hint: "Enter reason for applying discount",
                    onChanged: (value) {
                      discountReason = value;
                      setState(() {});
                    },
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Requires Manager Approval",
                              "value": true,
                              "checked": isManagerApprovalRequired,
                            }
                          ],
                          value: [
                            if (isManagerApprovalRequired)
                              {
                                "label": "Requires Manager Approval",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            isManagerApprovalRequired = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),

                  if (isManagerApprovalRequired)
                    QTextField(
                      label: "Manager Approval Code",
                      value: managerCode,
                      hint: "Enter manager approval code",
                      onChanged: (value) {
                        managerCode = value;
                        setState(() {});
                      },
                    ),
                ],
              ),
            ),

            // Action Buttons
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Clear Discount",
                    color: disabledBoldColor,
                    size: bs.md,
                    onPressed: () {
                      discountType = "percentage";
                      discountValue = "";
                      discountCode = "";
                      discountReason = "";
                      isManagerApprovalRequired = false;
                      managerCode = "";
                      _calculateDiscount();
                    },
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Apply Discount",
                    size: bs.md,
                    onPressed: _applyDiscount,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
