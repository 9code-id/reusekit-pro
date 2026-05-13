import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsInvoiceView extends StatefulWidget {
  const BrsInvoiceView({super.key});

  @override
  State<BrsInvoiceView> createState() => _BrsInvoiceViewState();
}

class _BrsInvoiceViewState extends State<BrsInvoiceView> {
  Map<String, dynamic> invoiceData = {
    "invoiceNumber": "INV-2024-001234",
    "issueDate": "2024-03-20",
    "dueDate": "2024-03-20",
    "status": "paid",
    "customerInfo": {
      "name": "John Doe",
      "email": "john.doe@example.com",
      "phone": "+1 (555) 123-4567",
      "address": "123 Main Street\nNew York, NY 10001",
    },
    "barbershopInfo": {
      "name": "Elite Barbershop",
      "address": "456 Barber Street\nNew York, NY 10002",
      "phone": "+1 (555) 987-6543",
      "email": "info@elitebarbershop.com",
      "website": "www.elitebarbershop.com",
    },
    "services": [
      {
        "name": "Premium Hair Cut",
        "description": "Professional hair cutting and styling",
        "quantity": 1,
        "unitPrice": 45.00,
        "total": 45.00,
      },
      {
        "name": "Beard Trim",
        "description": "Beard shaping and trimming",
        "quantity": 1,
        "unitPrice": 25.00,
        "total": 25.00,
      },
      {
        "name": "Hot Towel Treatment",
        "description": "Relaxing hot towel facial treatment",
        "quantity": 1,
        "unitPrice": 15.00,
        "total": 15.00,
      },
    ],
    "subtotal": 85.00,
    "tax": 8.50,
    "discount": 5.00,
    "total": 88.50,
    "paymentMethod": "Visa ****1234",
    "transactionId": "TXN123456789",
    "barber": "Mike Johnson",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Invoice"),
        actions: [
          IconButton(
            onPressed: () => _shareInvoice(),
            icon: Icon(Icons.share),
          ),
          IconButton(
            onPressed: () => _downloadInvoice(),
            icon: Icon(Icons.download),
          ),
          PopupMenuButton<String>(
            onSelected: (value) => _handleMenuAction(value),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: "print",
                child: Row(
                  children: [
                    Icon(Icons.print, size: 16),
                    SizedBox(width: spSm),
                    Text("Print"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: "email",
                child: Row(
                  children: [
                    Icon(Icons.email, size: 16),
                    SizedBox(width: spSm),
                    Text("Email Copy"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Container(
          padding: EdgeInsets.all(spLg),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowMd],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spLg,
            children: [
              _buildInvoiceHeader(),
              _buildInvoiceInfo(),
              _buildParticipantInfo(),
              _buildServicesList(),
              _buildTotalSection(),
              _buildPaymentInfo(),
              _buildInvoiceFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInvoiceHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(
                Icons.receipt_long,
                color: primaryColor,
                size: 32,
              ),
            ),
            SizedBox(width: spMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "INVOICE",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "${invoiceData["invoiceNumber"]}",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              decoration: BoxDecoration(
                color: _getStatusColor().withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: _getStatusColor().withAlpha(30)),
              ),
              child: Text(
                "${invoiceData["status"]}".toUpperCase(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: _getStatusColor(),
                ),
              ),
            ),
          ],
        ),
        Divider(),
      ],
    );
  }

  Widget _buildInvoiceInfo() {
    return Row(
      children: [
        Expanded(
          child: _buildInfoCard("Issue Date", "${invoiceData["issueDate"]}"),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildInfoCard("Due Date", "${invoiceData["dueDate"]}"),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildInfoCard("Barber", "${invoiceData["barber"]}"),
        ),
      ],
    );
  }

  Widget _buildInfoCard(String label, String value) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildParticipantInfo() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Text(
                "Bill To:",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "${invoiceData["customerInfo"]["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${invoiceData["customerInfo"]["email"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${invoiceData["customerInfo"]["phone"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${invoiceData["customerInfo"]["address"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: spMd),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Text(
                "From:",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "${invoiceData["barbershopInfo"]["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${invoiceData["barbershopInfo"]["address"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${invoiceData["barbershopInfo"]["phone"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${invoiceData["barbershopInfo"]["email"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildServicesList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Services",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: disabledOutlineBorderColor),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(radiusSm)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        "Service",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "Qty",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "Price",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "Total",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ...(invoiceData["services"] as List).asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, dynamic> service = entry.value;
                bool isLast = index == (invoiceData["services"] as List).length - 1;
                
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    border: !isLast ? Border(bottom: BorderSide(color: disabledOutlineBorderColor)) : null,
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
                              "${service["name"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            if (service["description"] != null) ...[
                              SizedBox(height: spXxs),
                              Text(
                                "${service["description"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          "${service["quantity"]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          "\$${(service["unitPrice"] as double).toStringAsFixed(2)}",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          "\$${(service["total"] as double).toStringAsFixed(2)}",
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
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTotalSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        spacing: spSm,
        children: [
          _buildTotalRow("Subtotal", invoiceData["subtotal"]),
          _buildTotalRow("Tax (10%)", invoiceData["tax"]),
          _buildTotalRow("Discount", -invoiceData["discount"], isDiscount: true),
          Divider(),
          _buildTotalRow("Total", invoiceData["total"], isTotal: true),
        ],
      ),
    );
  }

  Widget _buildTotalRow(String label, double amount, {bool isTotal = false, bool isDiscount = false}) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            color: primaryColor,
          ),
        ),
        Spacer(),
        Text(
          "${isDiscount ? '-' : ''}\$${amount.abs().toStringAsFixed(2)}",
          style: TextStyle(
            fontSize: isTotal ? 18 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            color: isDiscount ? dangerColor : isTotal ? primaryColor : primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentInfo() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: successColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: successColor.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.check_circle,
                color: successColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Payment Information",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Payment Method:",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: successColor,
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "${invoiceData["paymentMethod"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: successColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Transaction ID:",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: successColor,
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "${invoiceData["transactionId"]}",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'monospace',
                  color: successColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInvoiceFooter() {
    return Column(
      spacing: spMd,
      children: [
        Divider(),
        Text(
          "Thank you for choosing ${invoiceData["barbershopInfo"]["name"]}!",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          "For questions about this invoice, please contact us at ${invoiceData["barbershopInfo"]["email"]} or ${invoiceData["barbershopInfo"]["phone"]}",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor() {
    switch (invoiceData["status"]) {
      case "paid":
        return successColor;
      case "pending":
        return warningColor;
      case "overdue":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _shareInvoice() {
    ss("Invoice sharing options opened");
  }

  void _downloadInvoice() {
    ss("Invoice downloaded successfully");
  }

  void _handleMenuAction(String action) {
    switch (action) {
      case "print":
        ss("Printing invoice...");
        break;
      case "email":
        ss("Email copy sent");
        break;
    }
  }
}
