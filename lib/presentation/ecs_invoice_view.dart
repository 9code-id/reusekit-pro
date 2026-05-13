import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsInvoiceView extends StatefulWidget {
  const EcsInvoiceView({super.key});

  @override
  State<EcsInvoiceView> createState() => _EcsInvoiceViewState();
}

class _EcsInvoiceViewState extends State<EcsInvoiceView> {
  Map<String, dynamic> orderData = {
    "orderNumber": "ORD-2024-001234",
    "orderDate": "2024-06-14",
    "dueDate": "2024-06-21",
    "status": "Delivered",
    "customerName": "John Doe",
    "customerEmail": "john.doe@email.com",
    "customerPhone": "+1 234 567 8900",
    "shippingAddress": "123 Main Street, New York, NY 10001",
    "billingAddress": "123 Main Street, New York, NY 10001",
    "paymentMethod": "Credit Card ****1234",
    "subtotal": 299.97,
    "shipping": 15.00,
    "tax": 26.99,
    "discount": 20.00,
    "total": 321.96
  };

  List<Map<String, dynamic>> orderItems = [
    {
      "name": "Wireless Bluetooth Headphones",
      "sku": "WBH-2024-001",
      "quantity": 1,
      "price": 129.99,
      "total": 129.99
    },
    {
      "name": "Smartphone Case Premium",
      "sku": "SCP-2024-002",
      "quantity": 2,
      "price": 24.99,
      "total": 49.98
    },
    {
      "name": "USB-C Fast Charger",
      "sku": "UCF-2024-003",
      "quantity": 1,
      "price": 39.99,
      "total": 39.99
    },
    {
      "name": "Screen Protector Set",
      "sku": "SPS-2024-004",
      "quantity": 1,
      "price": 19.99,
      "total": 19.99
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Invoice"),
        actions: [
          IconButton(
            onPressed: _downloadInvoice,
            icon: Icon(Icons.download),
          ),
          IconButton(
            onPressed: _shareInvoice,
            icon: Icon(Icons.share),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInvoiceHeader(),
            SizedBox(height: spLg),
            _buildCustomerInfo(),
            SizedBox(height: spLg),
            _buildOrderItems(),
            SizedBox(height: spLg),
            _buildOrderSummary(),
            SizedBox(height: spLg),
            _buildPaymentInfo(),
            SizedBox(height: spXl),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildInvoiceHeader() {
    return Container(
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: primaryColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
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
                  SizedBox(height: spXs),
                  Text(
                    "${orderData["orderNumber"]}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: successColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${orderData["status"]}",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order Date",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "${orderData["orderDate"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
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
                      "Due Date",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "${orderData["dueDate"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerInfo() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Customer Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bill To",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text("${orderData["customerName"]}"),
                    Text("${orderData["customerEmail"]}"),
                    Text("${orderData["customerPhone"]}"),
                    SizedBox(height: spXs),
                    Text(
                      "${orderData["billingAddress"]}",
                      style: TextStyle(color: disabledBoldColor),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Ship To",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text("${orderData["customerName"]}"),
                    SizedBox(height: spXs),
                    Text(
                      "${orderData["shippingAddress"]}",
                      style: TextStyle(color: disabledBoldColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItems() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Order Items",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          // Header
          Container(
            padding: EdgeInsets.symmetric(vertical: spSm),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: disabledOutlineBorderColor)),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    "Item",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Qty",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Price",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Total",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Items
          ...orderItems.map((item) => Container(
            padding: EdgeInsets.symmetric(vertical: spSm),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${item["name"]}",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "SKU: ${item["sku"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Text(
                    "${item["quantity"]}",
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Text(
                    "\$${((item["price"] as double)).currency}",
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Text(
                    "\$${((item["total"] as double)).currency}",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Order Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          _buildSummaryRow("Subtotal", "\$${((orderData["subtotal"] as double)).currency}"),
          _buildSummaryRow("Shipping", "\$${((orderData["shipping"] as double)).currency}"),
          _buildSummaryRow("Tax", "\$${((orderData["tax"] as double)).currency}"),
          _buildSummaryRow("Discount", "-\$${((orderData["discount"] as double)).currency}", isDiscount: true),
          Divider(),
          _buildSummaryRow("Total", "\$${((orderData["total"] as double)).currency}", isTotal: true),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isDiscount = false, bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: spXs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? fsH6 : 14,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
              fontSize: isTotal ? fsH6 : 14,
              color: isDiscount ? successColor : (isTotal ? primaryColor : null),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentInfo() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Payment Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Icon(Icons.payment, color: primaryColor),
              SizedBox(width: spSm),
              Text("${orderData["paymentMethod"]}"),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "Payment Status: Completed",
            style: TextStyle(
              color: successColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          child: QButton(
            label: "Download PDF",
            icon: Icons.download,
            size: bs.md,
            onPressed: _downloadInvoice,
          ),
        ),
        SizedBox(height: spSm),
        Container(
          width: double.infinity,
          child: QButton(
            label: "Share Invoice",
            icon: Icons.share,
            size: bs.md,
            onPressed: _shareInvoice,
          ),
        ),
        SizedBox(height: spSm),
        Container(
          width: double.infinity,
          child: QButton(
            label: "Print Invoice",
            icon: Icons.print,
            size: bs.md,
            onPressed: _printInvoice,
          ),
        ),
      ],
    );
  }

  void _downloadInvoice() {
    ss("Invoice downloaded successfully");
  }

  void _shareInvoice() {
    ss("Invoice shared successfully");
  }

  void _printInvoice() {
    ss("Invoice sent to printer");
  }
}
