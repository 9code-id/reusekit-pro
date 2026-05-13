import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaInvoiceView extends StatefulWidget {
  const SpaInvoiceView({super.key});

  @override
  State<SpaInvoiceView> createState() => _SpaInvoiceViewState();
}

class _SpaInvoiceViewState extends State<SpaInvoiceView> {
  String invoiceNumber = "SPA-INV-2024-0156";
  String orderNumber = "SPA-ORD-2024-001";
  String invoiceStatus = "Paid";
  DateTime invoiceDate = DateTime.now().subtract(Duration(days: 2));
  DateTime dueDate = DateTime.now().add(Duration(days: 28));
  DateTime paidDate = DateTime.now().subtract(Duration(days: 1));
  
  Map<String, dynamic> companyInfo = {
    "name": "Wellness Spa Supplies Co.",
    "address": "456 Business Park Drive",
    "city": "New York, NY 10001",
    "phone": "+1 (555) 234-5678",
    "email": "billing@wellnesssupplies.com",
    "taxId": "TAX-987654321",
    "website": "www.wellnesssupplies.com"
  };
  
  Map<String, dynamic> clientInfo = {
    "name": "Serenity Spa Downtown",
    "contactPerson": "Sarah Johnson",
    "address": "123 Main Street, Downtown",
    "city": "New York, NY 10002",
    "phone": "+1 (555) 123-4567",
    "email": "downtown@serenityspa.com",
    "taxId": "TAX-123456789"
  };
  
  List<Map<String, dynamic>> invoiceItems = [
    {
      "description": "Premium Massage Oil Set",
      "quantity": 5,
      "unitPrice": 89.99,
      "discount": 0.0,
      "taxRate": 0.08,
      "category": "Oils & Lotions"
    },
    {
      "description": "Organic Face Mask Collection",
      "quantity": 12,
      "unitPrice": 149.99,
      "discount": 10.0,
      "taxRate": 0.08,
      "category": "Skincare"
    },
    {
      "description": "Aromatherapy Candle Set",
      "quantity": 8,
      "unitPrice": 79.99,
      "discount": 5.0,
      "taxRate": 0.08,
      "category": "Aromatherapy"
    },
    {
      "description": "Spa Towel Premium Pack",
      "quantity": 20,
      "unitPrice": 199.99,
      "discount": 15.0,
      "taxRate": 0.08,
      "category": "Linens"
    },
  ];
  
  Map<String, dynamic> paymentInfo = {
    "method": "Bank Transfer",
    "reference": "TXN-789456123",
    "bankName": "First National Bank",
    "accountNumber": "****1234",
    "paymentDate": "December 15, 2024"
  };

  @override
  Widget build(BuildContext context) {
    double subtotal = _calculateSubtotal();
    double totalDiscount = _calculateTotalDiscount();
    double totalTax = _calculateTotalTax();
    double totalAmount = subtotal - totalDiscount + totalTax;
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Invoice #${invoiceNumber.split('-').last}"),
        actions: [
          QButton(
            icon: Icons.download,
            size: bs.sm,
            onPressed: () {
              _downloadInvoice();
            },
          ),
          SizedBox(width: spXs),
          QButton(
            icon: Icons.print,
            size: bs.sm,
            onPressed: () {
              _printInvoice();
            },
          ),
          SizedBox(width: spXs),
          QButton(
            icon: Icons.share,
            size: bs.sm,
            onPressed: () {
              _shareInvoice();
            },
          ),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            // Invoice Header
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "INVOICE",
                              style: TextStyle(
                                fontSize: fsH3,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              invoiceNumber,
                              style: TextStyle(
                                fontSize: fsH6,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                        decoration: BoxDecoration(
                          color: _getStatusColor(invoiceStatus).withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Text(
                          invoiceStatus.toUpperCase(),
                          style: TextStyle(
                            color: _getStatusColor(invoiceStatus),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoSection("Invoice Date", invoiceDate.dMMMy),
                      ),
                      Expanded(
                        child: _buildInfoSection("Due Date", dueDate.dMMMy),
                      ),
                      if (invoiceStatus == "Paid")
                        Expanded(
                          child: _buildInfoSection("Paid Date", paidDate.dMMMy),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Company & Client Info
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowMd],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "From:",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${companyInfo["name"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${companyInfo["address"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "${companyInfo["city"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${companyInfo["phone"]}",
                          style: TextStyle(
                            color: infoColor,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "${companyInfo["email"]}",
                          style: TextStyle(
                            color: infoColor,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "Tax ID: ${companyInfo["taxId"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowMd],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Bill To:",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${clientInfo["name"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Attn: ${clientInfo["contactPerson"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "${clientInfo["address"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "${clientInfo["city"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${clientInfo["phone"]}",
                          style: TextStyle(
                            color: infoColor,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "${clientInfo["email"]}",
                          style: TextStyle(
                            color: infoColor,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "Tax ID: ${clientInfo["taxId"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Invoice Items
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Invoice Items",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Order #${orderNumber.split('-').last}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  // Table Header
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            "Description",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Qty",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Price",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Total",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Table Items
                  ...invoiceItems.map((item) => _buildInvoiceItem(item)).toList(),
                  
                  SizedBox(height: spMd),
                  
                  // Totals Section
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      children: [
                        _buildTotalRow("Subtotal", subtotal),
                        if (totalDiscount > 0)
                          _buildTotalRow("Total Discount", -totalDiscount, color: dangerColor),
                        _buildTotalRow("Total Tax", totalTax),
                        Divider(color: disabledOutlineBorderColor),
                        _buildTotalRow("Total Amount", totalAmount, isTotal: true),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Payment Information
            if (invoiceStatus == "Paid")
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Text(
                      "Payment Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: successColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Payment Method: ${paymentInfo["method"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                                Text(
                                  "Reference: ${paymentInfo["reference"]}",
                                  style: TextStyle(
                                    color: successColor,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "Paid on: ${paymentInfo["paymentDate"]}",
                                  style: TextStyle(
                                    color: successColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            
            SizedBox(height: spMd),
            
            // Actions
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Download PDF",
                          size: bs.md,
                          icon: Icons.download,
                          onPressed: () {
                            _downloadInvoice();
                          },
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: QButton(
                          label: "Send Email",
                          size: bs.md,
                          icon: Icons.email,
                          color: infoColor,
                          onPressed: () {
                            _sendEmail();
                          },
                        ),
                      ),
                    ],
                  ),
                  if (invoiceStatus != "Paid")
                    QButton(
                      label: "Mark as Paid",
                      size: bs.md,
                      icon: Icons.payment,
                      color: successColor,
                      onPressed: () {
                        _markAsPaid();
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: disabledBoldColor,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: primaryColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildInvoiceItem(Map<String, dynamic> item) {
    double unitPrice = item["unitPrice"];
    int quantity = item["quantity"];
    double discountPercent = item["discount"];
    double discountAmount = unitPrice * quantity * (discountPercent / 100);
    double subtotal = (unitPrice * quantity) - discountAmount;
    
    return Container(
      padding: EdgeInsets.symmetric(vertical: spSm, horizontal: spSm),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: disabledOutlineBorderColor.withAlpha(50)),
        ),
      ),
      child: Column(
        children: [
          Row(
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
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Category: ${item["category"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Text(
                  "$quantity",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  "\$${unitPrice.toStringAsFixed(2)}",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  "\$${subtotal.toStringAsFixed(2)}",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          if (discountPercent > 0)
            Padding(
              padding: EdgeInsets.only(top: spXs),
              child: Row(
                children: [
                  Expanded(flex: 3, child: SizedBox()),
                  Expanded(child: SizedBox()),
                  Expanded(
                    child: Text(
                      "Discount (${discountPercent.toInt()}%)",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 12,
                        color: dangerColor,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "-\$${discountAmount.toStringAsFixed(2)}",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 12,
                        color: dangerColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTotalRow(String label, double amount, {Color? color, bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: spXs),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: isTotal ? 16 : 14,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
                color: color ?? (isTotal ? primaryColor : disabledBoldColor),
              ),
            ),
          ),
          Text(
            "\$${amount.abs().toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: isTotal ? 18 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
              color: color ?? (isTotal ? primaryColor : primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  double _calculateSubtotal() {
    return invoiceItems.fold(0.0, (sum, item) {
      return sum + ((item["unitPrice"] as double) * (item["quantity"] as int));
    });
  }

  double _calculateTotalDiscount() {
    return invoiceItems.fold(0.0, (sum, item) {
      double unitPrice = item["unitPrice"];
      int quantity = item["quantity"];
      double discountPercent = item["discount"];
      return sum + (unitPrice * quantity * (discountPercent / 100));
    });
  }

  double _calculateTotalTax() {
    return invoiceItems.fold(0.0, (sum, item) {
      double unitPrice = item["unitPrice"];
      int quantity = item["quantity"];
      double discountPercent = item["discount"];
      double taxRate = item["taxRate"];
      double subtotal = (unitPrice * quantity) - (unitPrice * quantity * (discountPercent / 100));
      return sum + (subtotal * taxRate);
    });
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'paid':
        return successColor;
      case 'pending':
        return warningColor;
      case 'overdue':
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  void _downloadInvoice() {
    ss("Downloading invoice PDF...");
  }

  void _printInvoice() {
    ss("Printing invoice...");
  }

  void _shareInvoice() {
    ss("Sharing invoice...");
  }

  void _sendEmail() {
    ss("Sending invoice via email...");
  }

  void _markAsPaid() async {
    bool confirmed = await confirm("Mark this invoice as paid?");
    if (confirmed) {
      invoiceStatus = "Paid";
      paidDate = DateTime.now();
      setState(() {});
      ss("Invoice marked as paid successfully");
    }
  }
}
