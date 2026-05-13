import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaInvoiceView extends StatefulWidget {
  const FdaInvoiceView({super.key});

  @override
  State<FdaInvoiceView> createState() => _FdaInvoiceViewState();
}

class _FdaInvoiceViewState extends State<FdaInvoiceView> {
  Map<String, dynamic> invoiceData = {
    "invoiceNumber": "INV-2024-001234",
    "orderNumber": "ORDER#12345",
    "issueDate": "2024-06-14",
    "dueDate": "2024-06-21",
    "status": "Paid",
    "paymentDate": "2024-06-14",
    "company": {
      "name": "FoodDelivery Inc.",
      "address": "789 Business Ave, Suite 100\nCommerce City, NY 10005",
      "phone": "+1 (555) 999-0000",
      "email": "billing@fooddelivery.com",
      "website": "www.fooddelivery.com",
      "taxId": "TAX123456789"
    },
    "restaurant": {
      "name": "Tony's Pizzeria",
      "businessId": "BIZ987654321",
      "address": "456 Food Street, Culinary District",
      "phone": "+1 (555) 123-4567",
      "email": "orders@tonyspizzeria.com"
    },
    "customer": {
      "name": "John Doe",
      "email": "john.doe@example.com",
      "phone": "+1 (555) 987-6543",
      "address": "123 Main Street, Apt 4B\nNew York, NY 10001",
      "customerId": "CUST001234"
    }
  };

  List<Map<String, dynamic>> invoiceItems = [
    {
      "description": "Margherita Pizza (Large)",
      "category": "Food",
      "quantity": 2,
      "unitPrice": 12.99,
      "total": 25.98,
      "taxRate": 0.08,
      "taxAmount": 2.08
    },
    {
      "description": "Chicken Caesar Salad (Regular)",
      "category": "Food",
      "quantity": 1,
      "unitPrice": 8.99,
      "total": 8.99,
      "taxRate": 0.08,
      "taxAmount": 0.72
    },
    {
      "description": "Chocolate Brownie (Regular)",
      "category": "Dessert",
      "quantity": 1,
      "unitPrice": 4.99,
      "total": 4.99,
      "taxRate": 0.08,
      "taxAmount": 0.40
    },
    {
      "description": "Delivery Service",
      "category": "Service",
      "quantity": 1,
      "unitPrice": 2.99,
      "total": 2.99,
      "taxRate": 0.08,
      "taxAmount": 0.24
    },
    {
      "description": "Service Fee",
      "category": "Service",
      "quantity": 1,
      "unitPrice": 1.50,
      "total": 1.50,
      "taxRate": 0.08,
      "taxAmount": 0.12
    }
  ];

  double get subtotal => invoiceItems.fold(0.0, (sum, item) => sum + (item["total"] as double));
  double get totalTax => invoiceItems.fold(0.0, (sum, item) => sum + (item["taxAmount"] as double));
  double get discount => 5.00; // Promo discount
  double get grandTotal => subtotal + totalTax - discount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Invoice"),
        actions: [
          QButton(
            icon: Icons.email,
            size: bs.sm,
            onPressed: () {
              _emailInvoice();
            },
          ),
          SizedBox(width: spXs),
          QButton(
            icon: Icons.download,
            size: bs.sm,
            onPressed: () {
              _downloadInvoice();
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(spLg),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
            boxShadow: [shadowLg],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Invoice Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Company Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${invoiceData["company"]["name"]}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${invoiceData["company"]["address"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "Phone: ${invoiceData["company"]["phone"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "Email: ${invoiceData["company"]["email"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "Tax ID: ${invoiceData["company"]["taxId"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Invoice Title & Status
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "INVOICE",
                        style: TextStyle(
                          fontSize: fsH2,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                          letterSpacing: 2,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: successColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${invoiceData["status"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: spLg),

              // Invoice Details
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoSection("Invoice Information", [
                          _buildInfoItem("Invoice Number:", "${invoiceData["invoiceNumber"]}"),
                          _buildInfoItem("Order Number:", "${invoiceData["orderNumber"]}"),
                          _buildInfoItem("Issue Date:", "${invoiceData["issueDate"]}"),
                          _buildInfoItem("Due Date:", "${invoiceData["dueDate"]}"),
                          _buildInfoItem("Payment Date:", "${invoiceData["paymentDate"]}"),
                        ]),
                      ],
                    ),
                  ),
                  SizedBox(width: spLg),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoSection("Bill To", [
                          _buildInfoItem("Customer:", "${invoiceData["customer"]["name"]}"),
                          _buildInfoItem("Customer ID:", "${invoiceData["customer"]["customerId"]}"),
                          _buildInfoItem("Email:", "${invoiceData["customer"]["email"]}"),
                          _buildInfoItem("Phone:", "${invoiceData["customer"]["phone"]}"),
                          _buildInfoItem("Address:", "${invoiceData["customer"]["address"]}"),
                        ]),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: spMd),

              // Restaurant Information
              _buildInfoSection("Restaurant/Vendor", [
                _buildInfoItem("Restaurant:", "${invoiceData["restaurant"]["name"]}"),
                _buildInfoItem("Business ID:", "${invoiceData["restaurant"]["businessId"]}"),
                _buildInfoItem("Address:", "${invoiceData["restaurant"]["address"]}"),
                _buildInfoItem("Phone:", "${invoiceData["restaurant"]["phone"]}"),
                _buildInfoItem("Email:", "${invoiceData["restaurant"]["email"]}"),
              ]),

              SizedBox(height: spLg),

              // Invoice Items Table
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Invoice Items",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  
                  // Table Header
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radiusXs),
                        topRight: Radius.circular(radiusXs),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(flex: 3, child: _buildTableHeader("Description")),
                        Expanded(flex: 1, child: _buildTableHeader("Qty")),
                        Expanded(flex: 1, child: _buildTableHeader("Unit Price")),
                        Expanded(flex: 1, child: _buildTableHeader("Tax")),
                        Expanded(flex: 1, child: _buildTableHeader("Total")),
                      ],
                    ),
                  ),
                  
                  // Table Body
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: disabledOutlineBorderColor),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(radiusXs),
                        bottomRight: Radius.circular(radiusXs),
                      ),
                    ),
                    child: Column(
                      children: invoiceItems.map((item) {
                        return Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: invoiceItems.indexOf(item) < invoiceItems.length - 1
                                    ? disabledOutlineBorderColor
                                    : Colors.transparent,
                                width: 1,
                              ),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${item["description"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      "Category: ${item["category"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(flex: 1, child: _buildTableCell("${item["quantity"]}")),
                              Expanded(flex: 1, child: _buildTableCell("\$${(item["unitPrice"] as double).toStringAsFixed(2)}")),
                              Expanded(flex: 1, child: _buildTableCell("\$${(item["taxAmount"] as double).toStringAsFixed(2)}")),
                              Expanded(flex: 1, child: _buildTableCell("\$${(item["total"] as double).toStringAsFixed(2)}", isAmount: true)),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),

              SizedBox(height: spMd),

              // Invoice Summary
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 250,
                    child: Column(
                      children: [
                        _buildSummaryRow("Subtotal:", subtotal),
                        _buildSummaryRow("Total Tax:", totalTax),
                        _buildSummaryRow("Discount:", -discount, color: successColor),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: spXs),
                          height: 2,
                          color: primaryColor,
                        ),
                        _buildSummaryRow("Grand Total:", grandTotal, isTotal: true),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: spLg),

              // Tax Breakdown
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(radiusXs),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tax Breakdown",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Sales Tax (8%): \$${totalTax.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Tax is calculated on the subtotal before discounts",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: spMd),

              // Payment Information
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                  border: Border.all(color: successColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.check_circle, color: successColor, size: 16),
                        SizedBox(width: spXs),
                        Text(
                          "Payment Completed",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Amount Paid: \$${grandTotal.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Payment Date: ${invoiceData["paymentDate"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: spLg),

              // Footer
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Column(
                  children: [
                    Text(
                      "Thank you for your business!",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "For questions about this invoice, please contact us at ${invoiceData["company"]["email"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Generated on: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [shadowSm],
        ),
        child: Row(
          children: [
            Expanded(
              child: QButton(
                label: "Download PDF",
                icon: Icons.picture_as_pdf,
                onPressed: () {
                  _downloadInvoice();
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QButton(
                label: "Email Invoice",
                icon: Icons.email,
                onPressed: () {
                  _emailInvoice();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spXs),
        ...items,
      ],
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: primaryColor,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildTableCell(String text, {bool isAmount = false}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12,
        color: Colors.black,
        fontWeight: isAmount ? FontWeight.w600 : FontWeight.normal,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSummaryRow(String label, double amount, {Color? color, bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 14 : 12,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: color ?? (isTotal ? Colors.black : disabledBoldColor),
            ),
          ),
          Text(
            "\$${amount.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: isTotal ? 14 : 12,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: color ?? (isTotal ? primaryColor : Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  void _downloadInvoice() async {
    showLoading();
    
    // Simulate download
    await Future.delayed(Duration(seconds: 2));
    
    hideLoading();
    ss("Invoice downloaded successfully");
  }

  void _emailInvoice() async {
    showLoading();
    
    // Simulate email sending
    await Future.delayed(Duration(seconds: 2));
    
    hideLoading();
    ss("Invoice sent to ${invoiceData["customer"]["email"]}");
  }
}
