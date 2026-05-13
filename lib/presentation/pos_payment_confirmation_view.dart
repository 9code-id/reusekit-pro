import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosPaymentConfirmationView extends StatefulWidget {
  const PosPaymentConfirmationView({super.key});

  @override
  State<PosPaymentConfirmationView> createState() => _PosPaymentConfirmationViewState();
}

class _PosPaymentConfirmationViewState extends State<PosPaymentConfirmationView> {
  final Map<String, dynamic> paymentDetails = {
    "transaction_id": "TXN-2024-001234",
    "payment_method": "Credit Card",
    "payment_type": "Visa •••• 4532",
    "amount": 126.85,
    "processing_fee": 3.17,
    "total_amount": 129.02,
    "status": "completed",
    "timestamp": DateTime.now(),
    "customer_name": "John Doe",
    "customer_email": "john.doe@email.com",
    "customer_phone": "+1 (555) 123-4567",
  };

  final List<Map<String, dynamic>> orderItems = [
    {
      "name": "Espresso",
      "quantity": 2,
      "price": 3.50,
      "total": 7.00,
    },
    {
      "name": "Croissant",
      "quantity": 1,
      "price": 4.25,
      "total": 4.25,
    },
    {
      "name": "Latte",
      "quantity": 1,
      "price": 4.75,
      "total": 4.75,
    },
    {
      "name": "Blueberry Muffin",
      "quantity": 3,
      "price": 3.95,
      "total": 11.85,
    },
    {
      "name": "Green Tea",
      "quantity": 1,
      "price": 2.50,
      "total": 2.50,
    },
  ];

  bool sendEmailReceipt = true;
  bool sendSMSReceipt = false;
  bool printReceipt = true;
  String additionalNotes = "";

  void _printReceipt() async {
    showLoading();
    
    // Simulate printing
    await Future.delayed(Duration(seconds: 2));
    
    hideLoading();
    ss("Receipt printed successfully");
  }

  void _emailReceipt() async {
    if (paymentDetails["customer_email"] == null || 
        (paymentDetails["customer_email"] as String).isEmpty) {
      se("Customer email not available");
      return;
    }

    showLoading();
    
    // Simulate sending email
    await Future.delayed(Duration(seconds: 2));
    
    hideLoading();
    ss("Receipt emailed to ${paymentDetails["customer_email"]}");
  }

  void _smsReceipt() async {
    if (paymentDetails["customer_phone"] == null || 
        (paymentDetails["customer_phone"] as String).isEmpty) {
      se("Customer phone number not available");
      return;
    }

    showLoading();
    
    // Simulate sending SMS
    await Future.delayed(Duration(seconds: 2));
    
    hideLoading();
    ss("Receipt sent via SMS to ${paymentDetails["customer_phone"]}");
  }

  void _processNewTransaction() async {
    bool isConfirmed = await confirm("Start a new transaction?");
    if (isConfirmed) {
      ss("Starting new transaction");
      //navigateTo('pos_main')
    }
  }

  void _viewTransactionDetails() {
    si("Transaction details: ${paymentDetails["transaction_id"]}");
    //navigateTo('transaction_details')
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Confirmation"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              //navigateTo('pos_main')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Success Status
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: successColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: successColor.withValues(alpha: 0.3),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: successColor,
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Icon(
                      Icons.check,
                      size: 32,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spSm),
                  
                  Text(
                    "Payment Successful!",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  
                  Text(
                    "Transaction completed successfully",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  
                  SizedBox(height: spSm),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spSm,
                      vertical: spXs,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${paymentDetails["transaction_id"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Payment Summary
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
                    "Payment Summary",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Payment Method",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${paymentDetails["payment_method"]}",
                        style: TextStyle(
                          fontSize: 14,
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
                        "Card Details",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${paymentDetails["payment_type"]}",
                        style: TextStyle(
                          fontSize: 14,
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
                        "Subtotal",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "\$${(paymentDetails["amount"] as double).currency}",
                        style: TextStyle(
                          fontSize: 14,
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
                        "Processing Fee",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "\$${(paymentDetails["processing_fee"] as double).currency}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                  
                  Divider(),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Paid",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "\$${(paymentDetails["total_amount"] as double).currency}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Date & Time",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${(paymentDetails["timestamp"] as DateTime).dMMMykkss}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Customer Information
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
                    "Customer Information",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        size: 16,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${paymentDetails["customer_name"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Icon(
                        Icons.email,
                        size: 16,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${paymentDetails["customer_email"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Icon(
                        Icons.phone,
                        size: 16,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${paymentDetails["customer_phone"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Order Items
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
                    "Order Items",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  ...List.generate(orderItems.length, (index) {
                    final item = orderItems[index];
                    
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: spXs),
                      child: Row(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: primaryColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Center(
                              child: Text(
                                "${item["quantity"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
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
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "\$${(item["price"] as double).currency} each",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          Text(
                            "\$${(item["total"] as double).currency}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),

            // Receipt Options
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
                    "Receipt Options",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

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
                            printReceipt = values.isNotEmpty;
                            setState(() {});
                          },
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
                              "label": "Email Receipt",
                              "value": true,
                              "checked": sendEmailReceipt,
                            }
                          ],
                          value: [
                            if (sendEmailReceipt)
                              {
                                "label": "Email Receipt",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            sendEmailReceipt = values.isNotEmpty;
                            setState(() {});
                          },
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
                              "label": "SMS Receipt",
                              "value": true,
                              "checked": sendSMSReceipt,
                            }
                          ],
                          value: [
                            if (sendSMSReceipt)
                              {
                                "label": "SMS Receipt",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            sendSMSReceipt = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),

                  QTextField(
                    label: "Additional Notes (Optional)",
                    value: additionalNotes,
                    hint: "Add any notes for the receipt",
                    onChanged: (value) {
                      additionalNotes = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Action Buttons
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 150,
              children: [
                if (printReceipt)
                  QButton(
                    label: "Print Receipt",
                    icon: Icons.print,
                    color: primaryColor,
                    size: bs.md,
                    onPressed: _printReceipt,
                  ),
                
                if (sendEmailReceipt)
                  QButton(
                    label: "Email Receipt",
                    icon: Icons.email,
                    color: infoColor,
                    size: bs.md,
                    onPressed: _emailReceipt,
                  ),
                
                if (sendSMSReceipt)
                  QButton(
                    label: "SMS Receipt",
                    icon: Icons.sms,
                    color: warningColor,
                    size: bs.md,
                    onPressed: _smsReceipt,
                  ),
                
                QButton(
                  label: "View Details",
                  icon: Icons.info,
                  color: disabledBoldColor,
                  size: bs.md,
                  onPressed: _viewTransactionDetails,
                ),
                
                QButton(
                  label: "New Transaction",
                  icon: Icons.add,
                  color: successColor,
                  size: bs.md,
                  onPressed: _processNewTransaction,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
