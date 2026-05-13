import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LtaDeliveryReceiptView extends StatefulWidget {
  const LtaDeliveryReceiptView({super.key});

  @override
  State<LtaDeliveryReceiptView> createState() => _LtaDeliveryReceiptViewState();
}

class _LtaDeliveryReceiptViewState extends State<LtaDeliveryReceiptView> {
  bool loading = false;
  String deliveryId = "DEL-2024-001523";
  String trackingNumber = "LTA-TRK-789456123";
  String selectedReceiptFormat = "PDF";
  bool emailReceipt = true;
  bool smsReceipt = false;
  bool printReceipt = false;
  String customerEmail = "john.mitchell@email.com";
  String customerPhone = "+1 (555) 123-4567";
  List<String> additionalEmails = [];
  String newEmail = "";
  String receiptNotes = "";

  List<Map<String, dynamic>> formatOptions = [
    {"label": "PDF Document", "value": "PDF"},
    {"label": "Digital Receipt", "value": "Digital"},
    {"label": "SMS Receipt", "value": "SMS"},
    {"label": "Email Receipt", "value": "Email"},
  ];

  Map<String, dynamic> deliveryData = {
    "id": "DEL-2024-001523",
    "trackingNumber": "LTA-TRK-789456123",
    "orderNumber": "ORD-2024-7856",
    "deliveryDate": "2024-01-15",
    "deliveryTime": "14:32:15",
    "customerName": "John Mitchell",
    "customerPhone": "+1 (555) 123-4567",
    "customerEmail": "john.mitchell@email.com",
    "pickupAddress": "456 Warehouse District, Industrial Zone A",
    "deliveryAddress": "125 Business Plaza, Suite 402, Downtown District",
    "packageType": "Standard Package",
    "packageWeight": "2.5 kg",
    "packageDimensions": "30 x 20 x 15 cm",
    "serviceType": "Express Delivery",
    "deliveryFee": 25.00,
    "additionalCharges": 5.00,
    "totalAmount": 30.00,
    "paymentMethod": "Credit Card",
    "paymentStatus": "Paid",
    "driverName": "Michael Rodriguez",
    "driverPhone": "+1 (555) 987-6543",
    "vehicleNumber": "LTA-VH-234",
    "deliveryStatus": "Delivered",
    "signatureRequired": true,
    "signatureCaptured": true,
    "photoEvidence": true,
    "specialInstructions": "Ring doorbell twice, wait 2 minutes",
    "completedAt": "2024-01-15T14:32:15.000Z",
  };

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() async {
    loading = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 1));

    loading = false;
    setState(() {});
  }

  void _addEmail() {
    if (newEmail.isNotEmpty && newEmail.contains('@')) {
      additionalEmails.add(newEmail);
      newEmail = "";
      setState(() {});
      ss("Email address added");
    } else {
      se("Please enter a valid email address");
    }
  }

  void _removeEmail(int index) {
    additionalEmails.removeAt(index);
    setState(() {});
    ss("Email address removed");
  }

  void _generateReceipt() async {
    loading = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 2));

    loading = false;
    setState(() {});

    ss("Receipt generated successfully");
    
    // Show receipt preview dialog
    _showReceiptPreview();
  }

  void _showReceiptPreview() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Receipt Preview",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        content: Container(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildReceiptContent(),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Close"),
          ),
          QButton(
            label: "Download",
            icon: Icons.download,
            size: bs.sm,
            onPressed: () {
              back();
              _downloadReceipt();
            },
          ),
        ],
      ),
    );
  }

  void _downloadReceipt() {
    ss("Receipt downloaded to device");
  }

  void _sendReceipt() async {
    if (emailReceipt && customerEmail.isEmpty && additionalEmails.isEmpty) {
      se("Please provide at least one email address");
      return;
    }

    if (smsReceipt && customerPhone.isEmpty) {
      se("Please provide phone number for SMS receipt");
      return;
    }

    loading = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 2));

    loading = false;
    setState(() {});

    List<String> sentMethods = [];
    if (emailReceipt) sentMethods.add("Email");
    if (smsReceipt) sentMethods.add("SMS");
    if (printReceipt) sentMethods.add("Print");

    ss("Receipt sent via ${sentMethods.join(', ')}");
    //navigateTo ('')
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Delivery Receipt"),
        actions: [
          IconButton(
            onPressed: _generateReceipt,
            icon: Icon(Icons.preview),
          ),
          IconButton(
            onPressed: () {
              // Share receipt
            },
            icon: Icon(Icons.share),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Delivery Summary Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: successColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.check_circle, color: successColor, size: 24),
                      SizedBox(width: spSm),
                      Text(
                        "Delivery Completed",
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Delivery ID",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              deliveryId,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Tracking Number",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              trackingNumber,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
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
                              "Completed At",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${deliveryData["deliveryDate"]} ${deliveryData["deliveryTime"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
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
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "\$${(deliveryData["totalAmount"] as double).currency}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Receipt Format Options
            Text(
              "Receipt Format",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            QDropdownField(
              label: "Receipt Format",
              items: formatOptions,
              value: selectedReceiptFormat,
              onChanged: (value, label) {
                selectedReceiptFormat = value;
                setState(() {});
              },
            ),

            SizedBox(height: spMd),

            // Delivery Method Options
            Text(
              "Delivery Method",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            // Email Option
            Row(
              children: [
                Expanded(
                  child: QSwitch(
                    items: [
                      {
                        "label": "Send via Email",
                        "value": true,
                        "checked": emailReceipt,
                      }
                    ],
                    value: [
                      if (emailReceipt)
                        {
                          "label": "Send via Email",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      setState(() {
                        emailReceipt = values.isNotEmpty;
                      });
                    },
                  ),
                ),
              ],
            ),

            if (emailReceipt) ...[
              SizedBox(height: spSm),
              QTextField(
                label: "Customer Email",
                value: customerEmail,
                hint: "Enter customer email address",
                onChanged: (value) {
                  customerEmail = value;
                  setState(() {});
                },
              ),

              SizedBox(height: spSm),
              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Additional Email (Optional)",
                      value: newEmail,
                      hint: "Add another email address",
                      onChanged: (value) {
                        newEmail = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    label: "Add",
                    size: bs.sm,
                    onPressed: _addEmail,
                  ),
                ],
              ),

              if (additionalEmails.isNotEmpty) ...[
                SizedBox(height: spSm),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: disabledOutlineBorderColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Additional Recipients:",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: spXs),
                      ...List.generate(additionalEmails.length, (index) {
                        return Row(
                          children: [
                            Icon(Icons.email, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                additionalEmails[index],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => _removeEmail(index),
                              child: Icon(
                                Icons.remove_circle,
                                size: 16,
                                color: dangerColor,
                              ),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ],

            SizedBox(height: spSm),

            // SMS Option
            Row(
              children: [
                Expanded(
                  child: QSwitch(
                    items: [
                      {
                        "label": "Send via SMS",
                        "value": true,
                        "checked": smsReceipt,
                      }
                    ],
                    value: [
                      if (smsReceipt)
                        {
                          "label": "Send via SMS",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      setState(() {
                        smsReceipt = values.isNotEmpty;
                      });
                    },
                  ),
                ),
              ],
            ),

            if (smsReceipt) ...[
              SizedBox(height: spSm),
              QTextField(
                label: "Customer Phone",
                value: customerPhone,
                hint: "Enter customer phone number",
                onChanged: (value) {
                  customerPhone = value;
                  setState(() {});
                },
              ),
            ],

            SizedBox(height: spSm),

            // Print Option
            Row(
              children: [
                Expanded(
                  child: QSwitch(
                    items: [
                      {
                        "label": "Print Receipt",
                        "value": true,
                        "checked": printReceipt,
                      }
                    ],
                    value: [
                      if (printReceipt)
                        {
                          "label": "Print Receipt",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      setState(() {
                        printReceipt = values.isNotEmpty;
                      });
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: spMd),

            // Additional Notes
            QMemoField(
              label: "Receipt Notes (Optional)",
              value: receiptNotes,
              hint: "Add any additional notes for the receipt",
              onChanged: (value) {
                receiptNotes = value;
                setState(() {});
              },
            ),

            SizedBox(height: spMd),

            // Receipt Preview Section
            Text(
              "Receipt Preview",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledOutlineBorderColor),
                boxShadow: [shadowSm],
              ),
              child: _buildReceiptContent(),
            ),

            SizedBox(height: spMd),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Preview",
                    icon: Icons.preview,
                    size: bs.md,
                    onPressed: _generateReceipt,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Send Receipt",
                    icon: Icons.send,
                    size: bs.md,
                    onPressed: _sendReceipt,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReceiptContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Center(
          child: Column(
            children: [
              Text(
                "LOGISTICS TRANSPORT AGENCY",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "DELIVERY RECEIPT",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spSm),
              Container(
                height: 1,
                width: double.infinity,
                color: disabledOutlineBorderColor,
              ),
            ],
          ),
        ),

        SizedBox(height: spSm),

        // Order Information
        _buildReceiptSection("ORDER INFORMATION", [
          _buildReceiptRow("Delivery ID:", deliveryData["id"]),
          _buildReceiptRow("Tracking Number:", deliveryData["trackingNumber"]),
          _buildReceiptRow("Order Number:", deliveryData["orderNumber"]),
          _buildReceiptRow("Service Type:", deliveryData["serviceType"]),
        ]),

        // Customer Information
        _buildReceiptSection("CUSTOMER INFORMATION", [
          _buildReceiptRow("Name:", deliveryData["customerName"]),
          _buildReceiptRow("Phone:", deliveryData["customerPhone"]),
          _buildReceiptRow("Email:", deliveryData["customerEmail"]),
        ]),

        // Delivery Information
        _buildReceiptSection("DELIVERY INFORMATION", [
          _buildReceiptRow("From:", deliveryData["pickupAddress"]),
          _buildReceiptRow("To:", deliveryData["deliveryAddress"]),
          _buildReceiptRow("Date:", deliveryData["deliveryDate"]),
          _buildReceiptRow("Time:", deliveryData["deliveryTime"]),
          _buildReceiptRow("Driver:", deliveryData["driverName"]),
          _buildReceiptRow("Vehicle:", deliveryData["vehicleNumber"]),
        ]),

        // Package Information
        _buildReceiptSection("PACKAGE INFORMATION", [
          _buildReceiptRow("Type:", deliveryData["packageType"]),
          _buildReceiptRow("Weight:", deliveryData["packageWeight"]),
          _buildReceiptRow("Dimensions:", deliveryData["packageDimensions"]),
        ]),

        // Charges
        _buildReceiptSection("CHARGES", [
          _buildReceiptRow("Delivery Fee:", "\$${(deliveryData["deliveryFee"] as double).currency}"),
          _buildReceiptRow("Additional Charges:", "\$${(deliveryData["additionalCharges"] as double).currency}"),
          Container(
            height: 1,
            width: double.infinity,
            color: disabledOutlineBorderColor,
            margin: EdgeInsets.symmetric(vertical: spXs),
          ),
          _buildReceiptRow(
            "TOTAL AMOUNT:",
            "\$${(deliveryData["totalAmount"] as double).currency}",
            isBold: true,
          ),
          _buildReceiptRow("Payment Method:", deliveryData["paymentMethod"]),
          _buildReceiptRow("Payment Status:", deliveryData["paymentStatus"]),
        ]),

        // Delivery Confirmation
        _buildReceiptSection("DELIVERY CONFIRMATION", [
          _buildReceiptRow("Status:", deliveryData["deliveryStatus"]),
          _buildReceiptRow("Signature Captured:", deliveryData["signatureCaptured"] ? "Yes" : "No"),
          _buildReceiptRow("Photo Evidence:", deliveryData["photoEvidence"] ? "Yes" : "No"),
          _buildReceiptRow("Completed At:", deliveryData["completedAt"]),
        ]),

        if (receiptNotes.isNotEmpty)
          _buildReceiptSection("ADDITIONAL NOTES", [
            Text(
              receiptNotes,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ]),

        SizedBox(height: spSm),
        Container(
          height: 1,
          width: double.infinity,
          color: disabledOutlineBorderColor,
        ),
        SizedBox(height: spSm),

        // Footer
        Center(
          child: Column(
            children: [
              Text(
                "Thank you for choosing LTA Services",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "Generated on: ${DateTime.now().toString().split('.')[0]}",
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReceiptSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: spSm),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spXs),
        ...children,
      ],
    );
  }

  Widget _buildReceiptRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 10,
                color: isBold ? primaryColor : disabledBoldColor,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
