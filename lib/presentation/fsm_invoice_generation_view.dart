import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmInvoiceGenerationView extends StatefulWidget {
  const FsmInvoiceGenerationView({super.key});

  @override
  State<FsmInvoiceGenerationView> createState() => _FsmInvoiceGenerationViewState();
}

class _FsmInvoiceGenerationViewState extends State<FsmInvoiceGenerationView> {
  String selectedClient = "";
  String selectedWorkOrder = "";
  String selectedTemplate = "standard";
  String invoiceNumber = "INV-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}";
  String notes = "";
  bool includeTax = true;
  bool includeDiscount = false;
  double taxRate = 8.5;
  double discountAmount = 0.0;

  List<Map<String, dynamic>> clients = [
    {
      "id": "CLT001",
      "name": "TechCorp Solutions",
      "email": "billing@techcorp.com",
      "address": "123 Business Ave, City, ST 12345",
      "phone": "(555) 123-4567",
    },
    {
      "id": "CLT002", 
      "name": "Global Industries",
      "email": "accounts@global.com",
      "address": "456 Industrial Blvd, Metro, ST 67890",
      "phone": "(555) 987-6543",
    },
    {
      "id": "CLT003",
      "name": "SmartTech Systems",
      "email": "finance@smarttech.com", 
      "address": "789 Technology Dr, Innovation, ST 13579",
      "phone": "(555) 456-7890",
    },
  ];

  List<Map<String, dynamic>> workOrders = [
    {
      "id": "WO-2024-001",
      "client_id": "CLT001",
      "description": "HVAC System Maintenance",
      "date": "2024-01-15",
      "status": "completed",
      "technician": "John Smith",
      "total_hours": 3.5,
    },
    {
      "id": "WO-2024-002",
      "client_id": "CLT001",
      "description": "Electrical Panel Upgrade",
      "date": "2024-01-18",
      "status": "completed", 
      "technician": "Mike Johnson",
      "total_hours": 6.0,
    },
    {
      "id": "WO-2024-003",
      "client_id": "CLT002",
      "description": "Network Equipment Installation",
      "date": "2024-01-20",
      "status": "completed",
      "technician": "Sarah Davis",
      "total_hours": 4.5,
    },
  ];

  List<Map<String, dynamic>> templates = [
    {
      "id": "standard",
      "name": "Standard Invoice",
      "description": "Basic invoice template with essential details",
    },
    {
      "id": "detailed",
      "name": "Detailed Invoice", 
      "description": "Comprehensive template with itemized breakdown",
    },
    {
      "id": "professional",
      "name": "Professional Invoice",
      "description": "Premium template with company branding",
    },
  ];

  List<Map<String, dynamic>> lineItems = [
    {
      "description": "Labor - HVAC Maintenance",
      "quantity": 3.5,
      "rate": 85.0,
      "amount": 297.50,
      "type": "labor",
    },
    {
      "description": "HVAC Filter Replacement",
      "quantity": 2.0,
      "rate": 25.0,
      "amount": 50.0,
      "type": "material",
    },
    {
      "description": "Service Call Fee",
      "quantity": 1.0,
      "rate": 75.0,
      "amount": 75.0,
      "type": "service",
    },
    {
      "description": "Equipment Inspection",
      "quantity": 1.0,
      "rate": 120.0,
      "amount": 120.0,
      "type": "service",
    },
  ];

  double get subtotal => lineItems.fold(0.0, (sum, item) => sum + (item["amount"] as double));
  double get taxAmount => includeTax ? (subtotal * (taxRate / 100)) : 0.0;
  double get discountTotal => includeDiscount ? discountAmount : 0.0;
  double get grandTotal => subtotal + taxAmount - discountTotal;

  List<Map<String, dynamic>> getFilteredWorkOrders() {
    if (selectedClient.isEmpty) return [];
    return workOrders.where((wo) => wo["client_id"] == selectedClient).toList();
  }

  void _generateInvoice() async {
    if (selectedClient.isEmpty) {
      se("Please select a client");
      return;
    }
    
    if (selectedWorkOrder.isEmpty) {
      se("Please select a work order");
      return;
    }

    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();

    ss("Invoice generated successfully!");
  }

  void _previewInvoice() {
    if (selectedClient.isEmpty) {
      se("Please select a client to preview");
      return;
    }

    si("Opening invoice preview...");
  }

  void _addLineItem() {
    setState(() {
      lineItems.add({
        "description": "New Item",
        "quantity": 1.0,
        "rate": 0.0,
        "amount": 0.0,
        "type": "service",
      });
    });
  }

  void _removeLineItem(int index) {
    setState(() {
      lineItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Invoice Generation"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              si("Viewing invoice history...");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Statistics Cards
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.receipt_long,
                          color: primaryColor,
                          size: 28,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "147",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Generated",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.pending_actions,
                          color: warningColor,
                          size: 28,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "23",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Pending",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.attach_money,
                          color: successColor,
                          size: 28,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "\$${((147250.0).currency)}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Total Value",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Invoice Configuration
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.settings,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Invoice Configuration",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  QDropdownField(
                    label: "Select Client",
                    items: clients.map((client) => {
                      "label": "${client["name"]} (${client["id"]})",
                      "value": client["id"],
                    }).toList(),
                    value: selectedClient,
                    onChanged: (value, label) {
                      selectedClient = value;
                      selectedWorkOrder = "";
                      setState(() {});
                    },
                  ),

                  if (selectedClient.isNotEmpty)
                    QDropdownField(
                      label: "Select Work Order",
                      items: getFilteredWorkOrders().map((wo) => {
                        "label": "${wo["id"]} - ${wo["description"]}",
                        "value": wo["id"],
                      }).toList(),
                      value: selectedWorkOrder,
                      onChanged: (value, label) {
                        selectedWorkOrder = value;
                        setState(() {});
                      },
                    ),

                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Invoice Number",
                          value: invoiceNumber,
                          onChanged: (value) {
                            invoiceNumber = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Template",
                          items: templates.map((template) => {
                            "label": template["name"],
                            "value": template["id"],
                          }).toList(),
                          value: selectedTemplate,
                          onChanged: (value, label) {
                            selectedTemplate = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Line Items Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.list_alt,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
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
                        icon: Icons.add,
                        size: bs.sm,
                        onPressed: _addLineItem,
                      ),
                    ],
                  ),

                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(51),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            "Description",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Qty",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Rate",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Amount",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(width: 40),
                      ],
                    ),
                  ),

                  ...lineItems.asMap().entries.map((entry) {
                    int index = entry.key;
                    Map<String, dynamic> item = entry.value;
                    Color typeColor = item["type"] == "labor" ? primaryColor :
                                    item["type"] == "material" ? successColor : infoColor;

                    return Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: disabledOutlineBorderColor,
                            width: 1,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${item["description"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: typeColor.withAlpha(51),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${item["type"]}".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: typeColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "${(item["quantity"] as double).toStringAsFixed(1)}",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "\$${(item["rate"] as double).toStringAsFixed(2)}",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "\$${(item["amount"] as double).toStringAsFixed(2)}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 40,
                            child: GestureDetector(
                              onTap: () => _removeLineItem(index),
                              child: Icon(
                                Icons.delete_outline,
                                color: dangerColor,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Calculation Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calculate,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Invoice Calculations",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Include Tax",
                              "value": true,
                              "checked": includeTax,
                            }
                          ],
                          value: [if (includeTax) {"label": "Include Tax", "value": true, "checked": true}],
                          onChanged: (values, ids) {
                            includeTax = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                      if (includeTax) ...[
                        SizedBox(width: spSm),
                        SizedBox(
                          width: 100,
                          child: QNumberField(
                            label: "Tax Rate (%)",
                            value: taxRate.toString(),
                            onChanged: (value) {
                              taxRate = double.tryParse(value) ?? 0.0;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Apply Discount",
                              "value": true,
                              "checked": includeDiscount,
                            }
                          ],
                          value: [if (includeDiscount) {"label": "Apply Discount", "value": true, "checked": true}],
                          onChanged: (values, ids) {
                            includeDiscount = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                      if (includeDiscount) ...[
                        SizedBox(width: spSm),
                        SizedBox(
                          width: 120,
                          child: QNumberField(
                            label: "Discount (\$)",
                            value: discountAmount.toString(),
                            onChanged: (value) {
                              discountAmount = double.tryParse(value) ?? 0.0;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ],
                  ),

                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(26),
                      borderRadius: BorderRadius.circular(radiusXs),
                      border: Border.all(
                        color: primaryColor.withAlpha(77),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      spacing: spXs,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Subtotal:",
                              style: TextStyle(fontSize: 14),
                            ),
                            Text(
                              "\$${subtotal.toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        if (includeTax)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Tax (${taxRate.toStringAsFixed(1)}%):",
                                style: TextStyle(fontSize: 14),
                              ),
                              Text(
                                "\$${taxAmount.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        if (includeDiscount)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Discount:",
                                style: TextStyle(fontSize: 14),
                              ),
                              Text(
                                "-\$${discountTotal.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: dangerColor,
                                ),
                              ),
                            ],
                          ),
                        Divider(color: primaryColor.withAlpha(77)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total:",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "\$${grandTotal.toStringAsFixed(2)}",
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
                ],
              ),
            ),

            // Notes Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.note_alt,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Invoice Notes",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  QMemoField(
                    label: "Additional Notes",
                    value: notes,
                    hint: "Add any additional information or payment terms...",
                    onChanged: (value) {
                      notes = value;
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
                    label: "Preview",
                    size: bs.md,
                    onPressed: _previewInvoice,
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [primaryColor, primaryColor.withAlpha(204)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(radiusSm),
                        onTap: _generateInvoice,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: spSm),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.receipt_long,
                                color: Colors.white,
                                size: 18,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Generate Invoice",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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
