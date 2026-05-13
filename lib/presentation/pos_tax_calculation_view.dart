import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosTaxCalculationView extends StatefulWidget {
  const PosTaxCalculationView({super.key});

  @override
  State<PosTaxCalculationView> createState() => _PosTaxCalculationViewState();
}

class _PosTaxCalculationViewState extends State<PosTaxCalculationView> {
  final List<Map<String, dynamic>> taxRates = [
    {
      "name": "Sales Tax",
      "rate": 8.5,
      "type": "percentage",
      "enabled": true,
      "description": "State sales tax",
    },
    {
      "name": "VAT",
      "rate": 15.0,
      "type": "percentage", 
      "enabled": false,
      "description": "Value Added Tax",
    },
    {
      "name": "Service Tax",
      "rate": 5.0,
      "type": "percentage",
      "enabled": true,
      "description": "Service industry tax",
    },
    {
      "name": "Environmental Fee",
      "rate": 2.50,
      "type": "fixed",
      "enabled": false,
      "description": "Environmental protection fee",
    },
  ];

  final List<Map<String, dynamic>> cartItems = [
    {
      "name": "Espresso",
      "price": 3.50,
      "quantity": 2,
      "taxable": true,
      "tax_category": "food_beverage",
    },
    {
      "name": "Croissant",
      "price": 4.25,
      "quantity": 1,
      "taxable": true,
      "tax_category": "food_beverage",
    },
    {
      "name": "Gift Card",
      "price": 25.00,
      "quantity": 1,
      "taxable": false,
      "tax_category": "non_taxable",
    },
    {
      "name": "Ceramic Mug",
      "price": 15.99,
      "quantity": 1,
      "taxable": true,
      "tax_category": "retail",
    },
  ];

  String taxExemptReason = "";
  bool isTaxExempt = false;
  String exemptionNumber = "";

  double get subtotal {
    return cartItems.fold(0.0, (sum, item) => 
      sum + ((item["price"] as double) * (item["quantity"] as int)));
  }

  double get taxableAmount {
    if (isTaxExempt) return 0.0;
    return cartItems.fold(0.0, (sum, item) {
      if (item["taxable"] as bool) {
        return sum + ((item["price"] as double) * (item["quantity"] as int));
      }
      return sum;
    });
  }

  double get totalTax {
    if (isTaxExempt) return 0.0;
    double tax = 0.0;
    
    for (var taxRate in taxRates) {
      if (taxRate["enabled"] as bool) {
        if (taxRate["type"] == "percentage") {
          tax += taxableAmount * ((taxRate["rate"] as double) / 100);
        } else {
          tax += taxRate["rate"] as double;
        }
      }
    }
    
    return tax;
  }

  double get grandTotal {
    return subtotal + totalTax;
  }

  void _toggleTaxRate(int index) {
    taxRates[index]["enabled"] = !(taxRates[index]["enabled"] as bool);
    setState(() {});
  }

  void _toggleItemTaxable(int index) {
    cartItems[index]["taxable"] = !(cartItems[index]["taxable"] as bool);
    setState(() {});
  }

  void _applyTaxExemption() async {
    if (taxExemptReason.isEmpty) {
      se("Please enter tax exemption reason");
      return;
    }
    
    if (exemptionNumber.isEmpty) {
      se("Please enter exemption number");
      return;
    }

    bool isConfirmed = await confirm("Apply tax exemption to this transaction?");
    if (isConfirmed) {
      isTaxExempt = true;
      setState(() {});
      ss("Tax exemption applied");
    }
  }

  void _removeTaxExemption() {
    isTaxExempt = false;
    taxExemptReason = "";
    exemptionNumber = "";
    setState(() {});
    si("Tax exemption removed");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tax Calculation"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              si("Tax settings and configuration");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Tax Summary
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
                        "Subtotal",
                        style: TextStyle(
                          fontSize: 16,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "\$${subtotal.currency}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Taxable Amount",
                        style: TextStyle(
                          fontSize: 16,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "\$${taxableAmount.currency}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Total Tax",
                            style: TextStyle(
                              fontSize: 16,
                              color: disabledBoldColor,
                            ),
                          ),
                          if (isTaxExempt)
                            Container(
                              margin: EdgeInsets.only(left: spXs),
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: warningColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "EXEMPT",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                      Text(
                        "\$${totalTax.currency}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isTaxExempt ? warningColor : dangerColor,
                        ),
                      ),
                    ],
                  ),
                  
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Grand Total",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "\$${grandTotal.currency}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Tax Rates Configuration
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
                    "Tax Rates",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  ...List.generate(taxRates.length, (index) {
                    final taxRate = taxRates[index];
                    final isEnabled = taxRate["enabled"] as bool;
                    
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: isEnabled 
                          ? primaryColor.withValues(alpha: 0.1)
                          : disabledColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: isEnabled 
                            ? primaryColor.withValues(alpha: 0.3)
                            : disabledOutlineBorderColor,
                        ),
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => _toggleTaxRate(index),
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: isEnabled ? primaryColor : Colors.transparent,
                                border: Border.all(
                                  color: isEnabled ? primaryColor : disabledBoldColor,
                                ),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: isEnabled
                                ? Icon(
                                    Icons.check,
                                    size: 14,
                                    color: Colors.white,
                                  )
                                : null,
                            ),
                          ),
                          SizedBox(width: spSm),
                          
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${taxRate["name"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: isEnabled ? primaryColor : disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${taxRate["description"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          Text(
                            taxRate["type"] == "percentage"
                              ? "${taxRate["rate"]}%"
                              : "\$${(taxRate["rate"] as double).currency}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: isEnabled ? primaryColor : disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),

            // Cart Items Tax Status
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
                    "Items Tax Status",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  ...List.generate(cartItems.length, (index) {
                    final item = cartItems[index];
                    final isTaxable = item["taxable"] as bool;
                    final itemTotal = (item["price"] as double) * (item["quantity"] as int);
                    
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${item["name"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${item["quantity"]}x \$${(item["price"] as double).currency} = \$${itemTotal.currency}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          GestureDetector(
                            onTap: () => _toggleItemTaxable(index),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: isTaxable ? successColor : dangerColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                isTaxable ? "TAXABLE" : "TAX FREE",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),

            // Tax Exemption
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tax Exemption",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      if (isTaxExempt)
                        QButton(
                          label: "Remove Exemption",
                          color: dangerColor,
                          size: bs.sm,
                          onPressed: _removeTaxExemption,
                        ),
                    ],
                  ),
                  
                  if (!isTaxExempt) ...[
                    QTextField(
                      label: "Exemption Reason",
                      value: taxExemptReason,
                      hint: "Enter reason for tax exemption",
                      onChanged: (value) {
                        taxExemptReason = value;
                        setState(() {});
                      },
                    ),
                    
                    QTextField(
                      label: "Exemption Number",
                      value: exemptionNumber,
                      hint: "Enter tax exemption number",
                      onChanged: (value) {
                        exemptionNumber = value;
                        setState(() {});
                      },
                    ),
                    
                    QButton(
                      label: "Apply Tax Exemption",
                      color: warningColor,
                      size: bs.md,
                      onPressed: _applyTaxExemption,
                    ),
                  ] else ...[
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: warningColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: warningColor.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "Tax Exemption Applied",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: warningColor,
                            ),
                          ),
                          Text(
                            "Reason: $taxExemptReason",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Exemption #: $exemptionNumber",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Action Buttons
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Recalculate",
                    color: disabledBoldColor,
                    size: bs.md,
                    onPressed: () {
                      setState(() {});
                      si("Tax calculation updated");
                    },
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Proceed to Payment",
                    size: bs.md,
                    onPressed: () {
                      ss("Tax calculation completed");
                      //navigateTo('payment_methods')
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
}
