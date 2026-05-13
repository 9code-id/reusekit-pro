import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsReceiptView extends StatefulWidget {
  const BrsReceiptView({super.key});

  @override
  State<BrsReceiptView> createState() => _BrsReceiptViewState();
}

class _BrsReceiptViewState extends State<BrsReceiptView> {
  Map<String, dynamic> receiptData = {
    "receiptNumber": "RC-2024-001234",
    "transactionDate": "2024-03-20 14:30:25",
    "customerName": "John Doe",
    "barberName": "Mike Johnson",
    "barbershopName": "Elite Barbershop",
    "barbershopAddress": "456 Barber Street, New York, NY 10002",
    "barbershopPhone": "+1 (555) 987-6543",
    "services": [
      {
        "name": "Premium Hair Cut",
        "price": 45.00,
      },
      {
        "name": "Beard Trim",
        "price": 25.00,
      },
      {
        "name": "Hot Towel Treatment",
        "price": 15.00,
      },
    ],
    "subtotal": 85.00,
    "tax": 8.50,
    "discount": 5.00,
    "tip": 12.00,
    "total": 100.50,
    "paymentMethod": "Visa ****1234",
    "transactionId": "TXN123456789",
    "cashier": "Sarah Wilson",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Receipt"),
        actions: [
          IconButton(
            onPressed: () => _shareReceipt(),
            icon: Icon(Icons.share),
          ),
          PopupMenuButton<String>(
            onSelected: (value) => _handleMenuAction(value),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: "save",
                child: Row(
                  children: [
                    Icon(Icons.save, size: 16),
                    SizedBox(width: spSm),
                    Text("Save to Gallery"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: "print",
                child: Row(
                  children: [
                    Icon(Icons.print, size: 16),
                    SizedBox(width: spSm),
                    Text("Print Receipt"),
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
        child: Center(
          child: Container(
            width: 300,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: spSm,
              children: [
                _buildReceiptHeader(),
                _buildDivider(),
                _buildCustomerInfo(),
                _buildDivider(),
                _buildServicesList(),
                _buildDivider(),
                _buildTotalSection(),
                _buildDivider(),
                _buildPaymentInfo(),
                _buildDivider(),
                _buildReceiptFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReceiptHeader() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(10),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.cut,
            color: primaryColor,
            size: 32,
          ),
        ),
        SizedBox(height: spSm),
        Text(
          "${receiptData["barbershopName"]}",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          "${receiptData["barbershopAddress"]}",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11,
            color: disabledBoldColor,
          ),
        ),
        Text(
          "${receiptData["barbershopPhone"]}",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spSm),
        Text(
          "RECEIPT",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: primaryColor,
            letterSpacing: 2,
          ),
        ),
        Text(
          "${receiptData["receiptNumber"]}",
          style: TextStyle(
            fontSize: 11,
            color: disabledBoldColor,
            fontFamily: 'monospace',
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: spXs),
      child: Row(
        children: List.generate(50, (index) => Container(
          margin: EdgeInsets.only(right: 2),
          width: 2,
          height: 1,
          color: disabledBoldColor,
        )),
      ),
    );
  }

  Widget _buildCustomerInfo() {
    return Column(
      spacing: spXs,
      children: [
        _buildReceiptRow("Date:", "${receiptData["transactionDate"]}"),
        _buildReceiptRow("Customer:", "${receiptData["customerName"]}"),
        _buildReceiptRow("Barber:", "${receiptData["barberName"]}"),
        _buildReceiptRow("Cashier:", "${receiptData["cashier"]}"),
      ],
    );
  }

  Widget _buildServicesList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spXs,
      children: [
        Text(
          "SERVICES",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spXs),
        ...(receiptData["services"] as List).map((service) => Row(
          children: [
            Expanded(
              child: Text(
                "${service["name"]}",
                style: TextStyle(
                  fontSize: 11,
                  color: primaryColor,
                ),
              ),
            ),
            Text(
              "\$${(service["price"] as double).toStringAsFixed(2)}",
              style: TextStyle(
                fontSize: 11,
                color: primaryColor,
                fontFamily: 'monospace',
              ),
            ),
          ],
        )),
      ],
    );
  }

  Widget _buildTotalSection() {
    return Column(
      spacing: spXs,
      children: [
        _buildReceiptRow("Subtotal:", "\$${(receiptData["subtotal"] as double).toStringAsFixed(2)}"),
        _buildReceiptRow("Tax (10%):", "\$${(receiptData["tax"] as double).toStringAsFixed(2)}"),
        _buildReceiptRow("Discount:", "-\$${(receiptData["discount"] as double).toStringAsFixed(2)}"),
        _buildReceiptRow("Tip:", "\$${(receiptData["tip"] as double).toStringAsFixed(2)}"),
        Container(
          margin: EdgeInsets.symmetric(vertical: spXs),
          child: Row(
            children: List.generate(25, (index) => Container(
              margin: EdgeInsets.only(right: 2),
              width: 4,
              height: 1,
              color: primaryColor,
            )),
          ),
        ),
        Row(
          children: [
            Text(
              "TOTAL:",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            Text(
              "\$${(receiptData["total"] as double).toStringAsFixed(2)}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: primaryColor,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentInfo() {
    return Column(
      spacing: spXs,
      children: [
        Text(
          "PAYMENT DETAILS",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spXs),
        _buildReceiptRow("Method:", "${receiptData["paymentMethod"]}"),
        _buildReceiptRow("Transaction ID:", "${receiptData["transactionId"]}"),
        Container(
          padding: EdgeInsets.all(spXs),
          decoration: BoxDecoration(
            color: successColor.withAlpha(10),
            borderRadius: BorderRadius.circular(radiusXs),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle,
                color: successColor,
                size: 12,
              ),
              SizedBox(width: spXs),
              Text(
                "PAYMENT APPROVED",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReceiptFooter() {
    return Column(
      children: [
        Text(
          "Thank you for your business!",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spXs),
        Text(
          "Please rate your experience",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spSm),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) => GestureDetector(
            onTap: () => _rateService(index + 1),
            child: Container(
              margin: EdgeInsets.only(right: spXs),
              child: Icon(
                Icons.star_border,
                color: primaryColor,
                size: 16,
              ),
            ),
          )),
        ),
        SizedBox(height: spSm),
        Text(
          "Visit us again soon!",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
        Text(
          "Keep this receipt for your records",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 9,
            color: disabledBoldColor,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  Widget _buildReceiptRow(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: disabledBoldColor,
          ),
        ),
        Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: 11,
            color: primaryColor,
            fontFamily: label.contains("ID") || label.contains("Date") ? 'monospace' : null,
          ),
        ),
      ],
    );
  }

  void _shareReceipt() {
    ss("Receipt sharing options opened");
  }

  void _handleMenuAction(String action) {
    switch (action) {
      case "save":
        ss("Receipt saved to gallery");
        break;
      case "print":
        ss("Printing receipt...");
        break;
      case "email":
        ss("Email copy sent");
        break;
    }
  }

  void _rateService(int rating) {
    ss("Thank you for rating us $rating stars!");
  }
}
