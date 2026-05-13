import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaCreateQuoteView extends StatefulWidget {
  const CmaCreateQuoteView({super.key});

  @override
  State<CmaCreateQuoteView> createState() => _CmaCreateQuoteViewState();
}

class _CmaCreateQuoteViewState extends State<CmaCreateQuoteView> {
  final formKey = GlobalKey<FormState>();
  
  String customerName = "";
  String customerEmail = "";
  String customerPhone = "";
  String projectTitle = "";
  String projectDescription = "";
  String selectedPriority = "Medium";
  DateTime deliveryDate = DateTime.now().add(Duration(days: 30));
  List<Map<String, dynamic>> quoteItems = [];
  String notes = "";
  double discountPercentage = 0.0;
  String paymentTerms = "Net 30";
  
  List<Map<String, dynamic>> priorityOptions = [
    {"label": "Low", "value": "Low"},
    {"label": "Medium", "value": "Medium"},
    {"label": "High", "value": "High"},
    {"label": "Urgent", "value": "Urgent"},
  ];
  
  List<Map<String, dynamic>> paymentTermsOptions = [
    {"label": "Due on Receipt", "value": "Due on Receipt"},
    {"label": "Net 15", "value": "Net 15"},
    {"label": "Net 30", "value": "Net 30"},
    {"label": "Net 60", "value": "Net 60"},
  ];

  @override
  void initState() {
    super.initState();
    _addQuoteItem();
  }

  void _addQuoteItem() {
    setState(() {
      quoteItems.add({
        "description": "",
        "quantity": 1,
        "unitPrice": 0.0,
        "total": 0.0,
      });
    });
  }

  void _removeQuoteItem(int index) {
    setState(() {
      quoteItems.removeAt(index);
    });
  }

  void _updateQuoteItem(int index, String field, dynamic value) {
    setState(() {
      quoteItems[index][field] = value;
      if (field == "quantity" || field == "unitPrice") {
        double quantity = (quoteItems[index]["quantity"] as num).toDouble();
        double unitPrice = (quoteItems[index]["unitPrice"] as num).toDouble();
        quoteItems[index]["total"] = quantity * unitPrice;
      }
    });
  }

  double get subtotal {
    return quoteItems.fold(0.0, (sum, item) => sum + (item["total"] as double));
  }

  double get discountAmount {
    return subtotal * (discountPercentage / 100);
  }

  double get totalAmount {
    return subtotal - discountAmount;
  }

  void _saveQuote() {
    if (formKey.currentState!.validate()) {
      if (quoteItems.isEmpty) {
        se("Please add at least one quote item");
        return;
      }
      
      ss("Quote created successfully");
      back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Quote"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveQuote,
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              // Customer Information
              Container(
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
                      "Customer Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QTextField(
                      label: "Customer Name",
                      value: customerName,
                      validator: Validator.required,
                      onChanged: (value) {
                        customerName = value;
                        setState(() {});
                      },
                    ),
                    QTextField(
                      label: "Email Address",
                      value: customerEmail,
                      validator: Validator.email,
                      onChanged: (value) {
                        customerEmail = value;
                        setState(() {});
                      },
                    ),
                    QTextField(
                      label: "Phone Number",
                      value: customerPhone,
                      validator: Validator.required,
                      onChanged: (value) {
                        customerPhone = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Project Details
              Container(
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
                      "Project Details",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QTextField(
                      label: "Project Title",
                      value: projectTitle,
                      validator: Validator.required,
                      onChanged: (value) {
                        projectTitle = value;
                        setState(() {});
                      },
                    ),
                    QMemoField(
                      label: "Project Description",
                      value: projectDescription,
                      validator: Validator.required,
                      onChanged: (value) {
                        projectDescription = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Priority",
                            items: priorityOptions,
                            value: selectedPriority,
                            onChanged: (value, label) {
                              selectedPriority = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDatePicker(
                            label: "Delivery Date",
                            value: deliveryDate,
                            onChanged: (value) {
                              deliveryDate = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Quote Items
              Container(
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
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Quote Items",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        QButton(
                          icon: Icons.add,
                          size: bs.sm,
                          onPressed: _addQuoteItem,
                        ),
                      ],
                    ),
                    ...List.generate(quoteItems.length, (index) {
                      final item = quoteItems[index];
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(bottom: spSm),
                        decoration: BoxDecoration(
                          border: Border.all(color: disabledOutlineBorderColor),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          spacing: spSm,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Item ${index + 1}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                if (quoteItems.length > 1)
                                  GestureDetector(
                                    onTap: () => _removeQuoteItem(index),
                                    child: Icon(
                                      Icons.remove_circle,
                                      color: dangerColor,
                                      size: 20,
                                    ),
                                  ),
                              ],
                            ),
                            QTextField(
                              label: "Description",
                              value: "${item["description"]}",
                              onChanged: (value) {
                                _updateQuoteItem(index, "description", value);
                              },
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: QNumberField(
                                    label: "Quantity",
                                    value: "${item["quantity"]}",
                                    onChanged: (value) {
                                      _updateQuoteItem(index, "quantity", int.tryParse(value) ?? 1);
                                    },
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: QNumberField(
                                    label: "Unit Price (\$)",
                                    value: "${item["unitPrice"]}",
                                    onChanged: (value) {
                                      _updateQuoteItem(index, "unitPrice", double.tryParse(value) ?? 0.0);
                                    },
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: spSm, horizontal: spSm),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withAlpha(26),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Total",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          "\$${(item["total"] as double).currency}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),

              // Quote Summary
              Container(
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
                      "Quote Summary",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QNumberField(
                      label: "Discount (%)",
                      value: "${discountPercentage}",
                      onChanged: (value) {
                        discountPercentage = double.tryParse(value) ?? 0.0;
                        setState(() {});
                      },
                    ),
                    QDropdownField(
                      label: "Payment Terms",
                      items: paymentTermsOptions,
                      value: paymentTerms,
                      onChanged: (value, label) {
                        paymentTerms = value;
                        setState(() {});
                      },
                    ),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey.withAlpha(26),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Subtotal:",
                                  style: TextStyle(color: disabledBoldColor),
                                ),
                              ),
                              Text(
                                "\$${subtotal.currency}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          if (discountPercentage > 0)
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Discount (${discountPercentage.toStringAsFixed(1)}%):",
                                    style: TextStyle(color: disabledBoldColor),
                                  ),
                                ),
                                Text(
                                  "-\$${discountAmount.currency}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: dangerColor,
                                  ),
                                ),
                              ],
                            ),
                          Divider(),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Total:",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Text(
                                "\$${totalAmount.currency}",
                                style: TextStyle(
                                  fontSize: 18,
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

              // Additional Notes
              Container(
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
                      "Additional Notes",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QMemoField(
                      label: "Notes & Terms",
                      value: notes,
                      hint: "Add any additional terms, conditions, or notes for this quote",
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
                      label: "Save as Draft",
                      size: bs.md,
                      onPressed: () {
                        ss("Quote saved as draft");
                        back();
                      },
                    ),
                  ),
                  Expanded(
                    child: QButton(
                      label: "Create Quote",
                      size: bs.md,
                      onPressed: _saveQuote,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
