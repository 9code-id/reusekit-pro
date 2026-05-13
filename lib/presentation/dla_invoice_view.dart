import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaInvoiceView extends StatefulWidget {
  const DlaInvoiceView({super.key});

  @override
  State<DlaInvoiceView> createState() => _DlaInvoiceViewState();
}

class _DlaInvoiceViewState extends State<DlaInvoiceView> {
  String invoiceId = "INV-2024-001";
  String clientName = "ABC Logistics";
  String clientEmail = "contact@abclogistics.com";
  String clientAddress = "123 Business Street, Jakarta 12345";
  String invoiceDate = "2024-01-15";
  String dueDate = "2024-01-30";
  String paymentTerms = "Net 15";
  String notes = "";
  double subtotal = 0.0;
  double taxRate = 10.0;
  double discountAmount = 0.0;
  String status = "draft";

  final List<Map<String, dynamic>> invoiceItems = [
    {
      "id": "1",
      "description": "Express Delivery - Jakarta to Surabaya",
      "quantity": 25,
      "unit_price": 45.00,
      "total": 1125.00,
    },
    {
      "id": "2", 
      "description": "Warehouse Storage - 30 days",
      "quantity": 150,
      "unit_price": 5.50,
      "total": 825.00,
    },
    {
      "id": "3",
      "description": "Packaging Service - Fragile Items",
      "quantity": 10,
      "unit_price": 15.00,
      "total": 150.00,
    },
    {
      "id": "4",
      "description": "Insurance Coverage - High Value",
      "quantity": 5,
      "unit_price": 25.00,
      "total": 125.00,
    },
  ];

  final List<Map<String, dynamic>> statusOptions = [
    {"label": "Draft", "value": "draft"},
    {"label": "Sent", "value": "sent"},
    {"label": "Paid", "value": "paid"},
    {"label": "Overdue", "value": "overdue"},
    {"label": "Cancelled", "value": "cancelled"},
  ];

  @override
  void initState() {
    super.initState();
    _calculateSubtotal();
  }

  void _calculateSubtotal() {
    subtotal = invoiceItems.fold(0.0, (sum, item) => sum + (item["total"] as double));
  }

  double get taxAmount => (subtotal - discountAmount) * (taxRate / 100);
  double get totalAmount => subtotal + taxAmount - discountAmount;

  Color _getStatusColor(String status) {
    switch (status) {
      case "draft":
        return disabledBoldColor;
      case "sent":
        return infoColor;
      case "paid":
        return successColor;
      case "overdue":
        return dangerColor;
      case "cancelled":
        return warningColor;
      default:
        return primaryColor;
    }
  }

  Widget _buildInvoiceHeader() {
    return Container(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "INVOICE",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      invoiceId,
                      style: TextStyle(
                        fontSize: 16,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getStatusColor(status).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  status.toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: _getStatusColor(status),
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Text(
                        "Bill To:",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        clientName,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        clientEmail,
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        clientAddress,
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: spMd),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Invoice Date: ",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          invoiceDate,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Due Date: ",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          dueDate,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Payment Terms: ",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          paymentTerms,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvoiceItems() {
    return Container(
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
            "Invoice Items",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    "Description",
                    style: TextStyle(
                      fontSize: 12,
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
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Unit Price",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
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
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ...invoiceItems.map((item) => Container(
            padding: EdgeInsets.symmetric(vertical: spSm),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: disabledOutlineBorderColor,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    "${item["description"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "${item["quantity"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "\$${(item["unit_price"] as double).currency}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "\$${(item["total"] as double).currency}",
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
          )),
          QButton(
            label: "Add Item",
            icon: Icons.add,
            color: disabledBoldColor,
            size: bs.sm,
            onPressed: () {
              si("Add new invoice item");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInvoiceTotal() {
    return Container(
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
            "Invoice Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Text(
                      "Subtotal:",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
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
                Row(
                  children: [
                    Text(
                      "Discount:",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "-\$${discountAmount.currency}",
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
                      "Tax (${taxRate.toStringAsFixed(0)}%):",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
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
                Container(
                  height: 1,
                  color: disabledOutlineBorderColor,
                ),
                Row(
                  children: [
                    Text(
                      "Total Amount:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
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
    );
  }

  Widget _buildInvoiceSettings() {
    return Container(
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
            "Invoice Settings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QDropdownField(
            label: "Status",
            items: statusOptions,
            value: status,
            onChanged: (value, label) {
              status = value;
              setState(() {});
            },
          ),
          QMemoField(
            label: "Notes",
            value: notes,
            hint: "Add any additional notes or payment instructions...",
            onChanged: (value) {
              notes = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Invoice Details"),
        actions: [
          QButton(
            icon: Icons.share,
            size: bs.sm,
            onPressed: () {
              si("Share invoice");
            },
          ),
          QButton(
            icon: Icons.download,
            size: bs.sm,
            onPressed: () {
              si("Download PDF");
            },
          ),
          QButton(
            icon: Icons.print,
            size: bs.sm,
            onPressed: () {
              si("Print invoice");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildInvoiceHeader(),
            _buildInvoiceItems(),
            _buildInvoiceTotal(),
            _buildInvoiceSettings(),
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Save Draft",
                    color: disabledBoldColor,
                    size: bs.md,
                    onPressed: () {
                      ss("Invoice saved as draft");
                    },
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: status == "draft" ? "Send Invoice" : "Update Invoice",
                    size: bs.md,
                    onPressed: () {
                      if (status == "draft") {
                        status = "sent";
                        setState(() {});
                        ss("Invoice sent successfully!");
                      } else {
                        ss("Invoice updated successfully!");
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
