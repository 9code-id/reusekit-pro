import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsReceiptView extends StatefulWidget {
  const EcsReceiptView({super.key});

  @override
  State<EcsReceiptView> createState() => _EcsReceiptViewState();
}

class _EcsReceiptViewState extends State<EcsReceiptView> {
  Map<String, dynamic> receiptData = {
    "storeName": "TechMart Electronics",
    "storeAddress": "456 Tech Avenue, Silicon Valley, CA 94041",
    "storePhone": "+1 (555) 123-4567",
    "receiptNumber": "RCP-2024-001234",
    "orderNumber": "ORD-2024-001234",
    "date": "2024-06-14",
    "time": "14:30:25",
    "cashier": "Sarah Johnson",
    "paymentMethod": "Credit Card",
    "cardNumber": "****1234",
    "approvalCode": "AP123456",
    "subtotal": 299.97,
    "tax": 26.99,
    "discount": 20.00,
    "total": 306.96,
    "amountPaid": 306.96,
    "change": 0.00
  };

  List<Map<String, dynamic>> items = [
    {
      "name": "Wireless Bluetooth Headphones",
      "sku": "WBH-001",
      "quantity": 1,
      "price": 129.99,
      "total": 129.99
    },
    {
      "name": "Smartphone Case Premium",
      "sku": "SCP-002",
      "quantity": 2,
      "price": 24.99,
      "total": 49.98
    },
    {
      "name": "USB-C Fast Charger",
      "sku": "UCF-003",
      "quantity": 1,
      "price": 39.99,
      "total": 39.99
    },
    {
      "name": "Screen Protector Set",
      "sku": "SPS-004",
      "quantity": 1,
      "price": 19.99,
      "total": 19.99
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Receipt"),
        actions: [
          IconButton(
            onPressed: _shareReceipt,
            icon: Icon(Icons.share),
          ),
          IconButton(
            onPressed: _downloadReceipt,
            icon: Icon(Icons.download),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: [
                  _buildReceiptHeader(),
                  Divider(height: spLg * 2),
                  _buildReceiptItems(),
                  Divider(height: spLg * 2),
                  _buildReceiptSummary(),
                  Divider(height: spLg * 2),
                  _buildPaymentDetails(),
                  SizedBox(height: spLg),
                  _buildReceiptFooter(),
                ],
              ),
            ),
            SizedBox(height: spLg),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildReceiptHeader() {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          child: Icon(
            Icons.store,
            color: Colors.white,
            size: 30,
          ),
        ),
        SizedBox(height: spMd),
        Text(
          "${receiptData["storeName"]}",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: fsH5,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: spXs),
        Text(
          "${receiptData["storeAddress"]}",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: disabledBoldColor,
            fontSize: 12,
          ),
        ),
        Text(
          "${receiptData["storePhone"]}",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: disabledBoldColor,
            fontSize: 12,
          ),
        ),
        SizedBox(height: spMd),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Receipt #",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
                Text(
                  "${receiptData["receiptNumber"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Order #",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
                Text(
                  "${receiptData["orderNumber"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: spSm),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${receiptData["date"]} ${receiptData["time"]}",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
            Text(
              "Cashier: ${receiptData["cashier"]}",
              style: TextStyle(
                color: disabledBoldColor,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildReceiptItems() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "ITEMS PURCHASED",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spSm),
        ...items.map((item) => Padding(
          padding: EdgeInsets.only(bottom: spSm),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "${item["name"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Text(
                    "\$${((item["total"] as double)).currency}",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spXxs),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "SKU: ${item["sku"]} • Qty: ${item["quantity"]}",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    "\$${((item["price"] as double)).currency} each",
                    style: TextStyle(
                      color: disabledBoldColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        )).toList(),
      ],
    );
  }

  Widget _buildReceiptSummary() {
    return Column(
      children: [
        _buildSummaryRow("Subtotal", "\$${((receiptData["subtotal"] as double)).currency}"),
        _buildSummaryRow("Tax", "\$${((receiptData["tax"] as double)).currency}"),
        if ((receiptData["discount"] as double) > 0)
          _buildSummaryRow("Discount", "-\$${((receiptData["discount"] as double)).currency}", isDiscount: true),
        Divider(),
        _buildSummaryRow("TOTAL", "\$${((receiptData["total"] as double)).currency}", isTotal: true),
      ],
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isDiscount = false, bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: spXxs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 16 : 14,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: isTotal ? 16 : 14,
              color: isDiscount ? successColor : (isTotal ? primaryColor : null),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "PAYMENT DETAILS",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spSm),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Payment Method"),
            Text(
              "${receiptData["paymentMethod"]}",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        SizedBox(height: spXs),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Card Number"),
            Text(
              "${receiptData["cardNumber"]}",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        SizedBox(height: spXs),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Approval Code"),
            Text(
              "${receiptData["approvalCode"]}",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        SizedBox(height: spSm),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Amount Paid"),
            Text(
              "\$${((receiptData["amountPaid"] as double)).currency}",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Change"),
            Text(
              "\$${((receiptData["change"] as double)).currency}",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildReceiptFooter() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Text(
            "Thank you for shopping with us!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
        ),
        SizedBox(height: spSm),
        Text(
          "Return Policy: Items can be returned within 30 days with receipt",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spXs),
        Text(
          "Customer Service: (555) 123-4567",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          child: QButton(
            label: "Email Receipt",
            icon: Icons.email,
            size: bs.md,
            onPressed: _emailReceipt,
          ),
        ),
        SizedBox(height: spSm),
        Container(
          width: double.infinity,
          child: QButton(
            label: "Download PDF",
            icon: Icons.download,
            size: bs.md,
            onPressed: _downloadReceipt,
          ),
        ),
        SizedBox(height: spSm),
        Container(
          width: double.infinity,
          child: QButton(
            label: "Print Receipt",
            icon: Icons.print,
            size: bs.md,
            onPressed: _printReceipt,
          ),
        ),
      ],
    );
  }

  void _shareReceipt() {
    ss("Receipt shared successfully");
  }

  void _downloadReceipt() {
    ss("Receipt downloaded successfully");
  }

  void _emailReceipt() {
    ss("Receipt sent to email");
  }

  void _printReceipt() {
    ss("Receipt sent to printer");
  }
}
