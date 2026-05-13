import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaInvoiceGenerationView extends StatefulWidget {
  const LtaInvoiceGenerationView({super.key});

  @override
  State<LtaInvoiceGenerationView> createState() => _LtaInvoiceGenerationViewState();
}

class _LtaInvoiceGenerationViewState extends State<LtaInvoiceGenerationView> {
  final formKey = GlobalKey<FormState>();
  bool loading = false;
  
  // Invoice Details
  String invoiceNumber = "";
  String clientId = "";
  String clientName = "";
  String clientEmail = "";
  String clientAddress = "";
  String issueDate = DateTime.now().toIso8601String();
  String dueDate = DateTime.now().add(Duration(days: 30)).toIso8601String();
  
  // Services and Items
  List<Map<String, dynamic>> services = [];
  String selectedService = "";
  double serviceAmount = 0.0;
  String serviceDescription = "";
  
  // Calculations
  double subtotal = 0.0;
  double taxRate = 10.0;
  double discountPercent = 0.0;
  double additionalFees = 0.0;
  
  List<Map<String, dynamic>> serviceOptions = [
    {"label": "Standard Delivery", "value": "standard_delivery", "baseRate": 15.0},
    {"label": "Express Shipping", "value": "express_shipping", "baseRate": 25.0},
    {"label": "Same Day Delivery", "value": "same_day", "baseRate": 45.0},
    {"label": "International Shipping", "value": "international", "baseRate": 85.0},
    {"label": "Warehouse Storage", "value": "storage", "baseRate": 5.0},
    {"label": "Freight Transportation", "value": "freight", "baseRate": 120.0},
    {"label": "Insurance Coverage", "value": "insurance", "baseRate": 20.0},
    {"label": "Loading/Unloading", "value": "loading", "baseRate": 35.0},
  ];

  List<Map<String, dynamic>> clients = [
    {
      "id": "CLIENT_001",
      "name": "Express Logistics Co.",
      "email": "contact@expresslogistics.com",
      "address": "123 Business Ave, Metro City, MC 12345",
    },
    {
      "id": "CLIENT_002", 
      "name": "Global Transport Ltd.",
      "email": "billing@globaltransport.com",
      "address": "456 Industrial Blvd, Commerce City, CC 67890",
    },
    {
      "id": "CLIENT_003",
      "name": "Fast Courier Services",
      "email": "accounts@fastcourier.com", 
      "address": "789 Logistics Lane, Shipping Town, ST 13579",
    },
    {
      "id": "CLIENT_004",
      "name": "Metro Delivery Network",
      "email": "finance@metrodelivery.com",
      "address": "321 Transport Way, Delivery City, DC 24680",
    },
  ];

  @override
  void initState() {
    super.initState();
    _generateInvoiceNumber();
  }

  void _generateInvoiceNumber() {
    DateTime now = DateTime.now();
    invoiceNumber = "INV-${now.year}-${now.millisecondsSinceEpoch.toString().substring(8)}";
    setState(() {});
  }

  void _selectClient(String clientIdValue) {
    Map<String, dynamic>? client = clients.firstWhere(
      (c) => c["id"] == clientIdValue,
      orElse: () => {},
    );
    
    if (client.isNotEmpty) {
      clientId = "${client["id"]}";
      clientName = "${client["name"]}";
      clientEmail = "${client["email"]}";
      clientAddress = "${client["address"]}";
      setState(() {});
    }
  }

  void _addService() {
    if (selectedService.isNotEmpty && serviceAmount > 0) {
      Map<String, dynamic>? serviceOption = serviceOptions.firstWhere(
        (s) => s["value"] == selectedService,
        orElse: () => {},
      );
      
      services.add({
        "id": DateTime.now().millisecondsSinceEpoch.toString(),
        "name": serviceOption.isNotEmpty ? "${serviceOption["label"]}" : selectedService,
        "description": serviceDescription,
        "amount": serviceAmount,
        "quantity": 1,
        "total": serviceAmount,
      });
      
      // Reset fields
      selectedService = "";
      serviceAmount = 0.0;
      serviceDescription = "";
      
      _calculateTotals();
      setState(() {});
    }
  }

  void _removeService(String serviceId) {
    services.removeWhere((s) => s["id"] == serviceId);
    _calculateTotals();
    setState(() {});
  }

  void _calculateTotals() {
    subtotal = services.fold(0.0, (sum, service) => sum + (service["total"] as double));
    setState(() {});
  }

  double get taxAmount => (subtotal * taxRate) / 100;
  double get discountAmount => (subtotal * discountPercent) / 100;
  double get totalAmount => subtotal + taxAmount - discountAmount + additionalFees;

  void _generateInvoice() async {
    if (!formKey.currentState!.validate()) return;
    if (services.isEmpty) {
      se("Please add at least one service item");
      return;
    }

    loading = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 2));

    loading = false;
    setState(() {});
    
    ss("Invoice ${invoiceNumber} generated successfully");
    
    // Show preview or navigate to invoice details
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> clientOptions = clients.map((client) => {
      "label": "${client["name"]} (${client["id"]})",
      "value": "${client["id"]}",
    }).toList();

    List<Map<String, dynamic>> serviceDropdownOptions = serviceOptions.map((service) => {
      "label": "${service["label"]} - \$${(service["baseRate"] as double).toStringAsFixed(2)}",
      "value": "${service["value"]}",
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Generate Invoice"),
        actions: [
          IconButton(
            icon: Icon(Icons.preview),
            onPressed: services.isNotEmpty ? () {
              // Preview invoice
            } : null,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Form(
          key: formKey,
          child: Column(
            spacing: spMd,
            children: [
              // Invoice Header
              Container(
                padding: EdgeInsets.all(spSm),
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
                        Icon(
                          Icons.receipt_long,
                          color: primaryColor,
                          size: 24,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Invoice Details",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          label: "Auto Generate",
                          size: bs.sm,
                          onPressed: _generateInvoiceNumber,
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Invoice Number",
                            value: invoiceNumber,
                            validator: Validator.required,
                            onChanged: (value) {
                              invoiceNumber = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDatePicker(
                            label: "Issue Date",
                            value: DateTime.parse(issueDate),
                            onChanged: (value) {
                              issueDate = value.toIso8601String();
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDatePicker(
                            label: "Due Date",
                            value: DateTime.parse(dueDate),
                            onChanged: (value) {
                              dueDate = value.toIso8601String();
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Client Information
              Container(
                padding: EdgeInsets.all(spSm),
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
                        Icon(
                          Icons.business,
                          color: secondaryColor,
                          size: 24,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Client Information",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: secondaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    QDropdownField(
                      label: "Select Client",
                      items: clientOptions,
                      value: clientId,
                      validator: Validator.required,
                      onChanged: (value, label) {
                        _selectClient(value);
                      },
                    ),
                    if (clientName.isNotEmpty) ...[
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Expanded(
                            child: QTextField(
                              label: "Client Name",
                              value: clientName,
                              validator: Validator.required,
                              onChanged: (value) {
                                clientName = value;
                                setState(() {});
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QTextField(
                              label: "Client Email",
                              value: clientEmail,
                              validator: Validator.email,
                              onChanged: (value) {
                                clientEmail = value;
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      QMemoField(
                        label: "Client Address",
                        value: clientAddress,
                        validator: Validator.required,
                        onChanged: (value) {
                          clientAddress = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ],
                ),
              ),

              // Add Services
              Container(
                padding: EdgeInsets.all(spSm),
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
                        Icon(
                          Icons.add_business,
                          color: warningColor,
                          size: 24,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Add Services",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: QDropdownField(
                            label: "Service Type",
                            items: serviceDropdownOptions,
                            value: selectedService,
                            onChanged: (value, label) {
                              selectedService = value;
                              // Auto-fill amount from base rate
                              Map<String, dynamic>? service = serviceOptions.firstWhere(
                                (s) => s["value"] == value,
                                orElse: () => {},
                              );
                              if (service.isNotEmpty) {
                                serviceAmount = service["baseRate"] as double;
                              }
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QNumberField(
                            label: "Amount (\$)",
                            value: serviceAmount.toString(),
                            onChanged: (value) {
                              serviceAmount = double.tryParse(value) ?? 0.0;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: QTextField(
                            label: "Description (Optional)",
                            value: serviceDescription,
                            hint: "Additional details about the service",
                            onChanged: (value) {
                              serviceDescription = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          label: "Add Service",
                          size: bs.sm,
                          onPressed: _addService,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Services List
              if (services.isNotEmpty)
                Container(
                  padding: EdgeInsets.all(spSm),
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
                          Icon(
                            Icons.list_alt,
                            color: infoColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Invoice Items (${services.length})",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: infoColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Column(
                        children: services.map((service) {
                          return Container(
                            padding: EdgeInsets.all(spXs),
                            margin: EdgeInsets.only(bottom: spXs),
                            decoration: BoxDecoration(
                              color: Colors.grey.withValues(alpha: 0.05),
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: Colors.grey.withValues(alpha: 0.2),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${service["name"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      if (service["description"].toString().isNotEmpty)
                                        Text(
                                          "${service["description"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "\$${((service["total"] as double)).currency}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                QButton(
                                  icon: Icons.delete,
                                  size: bs.sm,
                                  onPressed: () => _removeService("${service["id"]}"),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),

              // Calculations
              Container(
                padding: EdgeInsets.all(spSm),
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
                        Icon(
                          Icons.calculate,
                          color: successColor,
                          size: 24,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Invoice Calculations",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        Expanded(
                          child: QNumberField(
                            label: "Tax Rate (%)",
                            value: taxRate.toString(),
                            onChanged: (value) {
                              taxRate = double.tryParse(value) ?? 0.0;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QNumberField(
                            label: "Discount (%)",
                            value: discountPercent.toString(),
                            onChanged: (value) {
                              discountPercent = double.tryParse(value) ?? 0.0;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QNumberField(
                            label: "Additional Fees (\$)",
                            value: additionalFees.toString(),
                            onChanged: (value) {
                              additionalFees = double.tryParse(value) ?? 0.0;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Subtotal:",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: primaryColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "\$${subtotal.currency}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                "Tax (${taxRate.toStringAsFixed(1)}%):",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: primaryColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "\$${taxAmount.currency}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          if (discountPercent > 0) ...[
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Text(
                                  "Discount (${discountPercent.toStringAsFixed(1)}%):",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: dangerColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "-\$${discountAmount.currency}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: dangerColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                          if (additionalFees > 0) ...[
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Text(
                                  "Additional Fees:",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: primaryColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "\$${additionalFees.currency}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                          Divider(),
                          Row(
                            children: [
                              Text(
                                "Total Amount:",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "\$${totalAmount.currency}",
                                style: TextStyle(
                                  fontSize: fsH5,
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

              // Generate Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: loading ? "Generating..." : "Generate Invoice",
                  size: bs.md,
                  onPressed: loading ? null : _generateInvoice,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
