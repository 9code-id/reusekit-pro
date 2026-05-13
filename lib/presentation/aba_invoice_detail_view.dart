import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaInvoiceDetailView extends StatefulWidget {
  const AbaInvoiceDetailView({super.key});

  @override
  State<AbaInvoiceDetailView> createState() => _AbaInvoiceDetailViewState();
}

class _AbaInvoiceDetailViewState extends State<AbaInvoiceDetailView> {
  Map<String, dynamic> invoice = {
    "id": "INV-2024-001",
    "clientName": "Tech Solutions Inc",
    "clientEmail": "billing@techsolutions.com",
    "clientAddress": {
      "street": "123 Business Street",
      "city": "San Francisco",
      "state": "CA",
      "zip": "94105",
      "country": "United States"
    },
    "amount": 15750.00,
    "currency": "USD",
    "status": "paid",
    "dueDate": "2024-12-20",
    "createdDate": "2024-11-20",
    "paymentDate": "2024-12-18",
    "description": "Web Development Services - November 2024",
    "notes": "Thank you for your business. Payment terms: Net 30 days.",
    "items": [
      {
        "description": "Frontend Development - React Components",
        "quantity": 40,
        "rate": 125.00,
        "amount": 5000.00
      },
      {
        "description": "Backend Integration - API Development",
        "quantity": 60,
        "rate": 135.00,
        "amount": 8100.00
      },
      {
        "description": "Testing & Quality Assurance",
        "quantity": 20,
        "rate": 95.00,
        "amount": 1900.00
      }
    ],
    "subtotal": 15000.00,
    "taxRate": 8.5,
    "taxAmount": 1275.00,
    "discount": 0.0,
    "discountAmount": 0.0,
    "totalAmount": 15750.00,
    "companyInfo": {
      "name": "Digital Agency LLC",
      "address": "456 Tech Avenue, Suite 100",
      "city": "San Francisco, CA 94107",
      "phone": "+1 (555) 123-4567",
      "email": "billing@digitalagency.com",
      "website": "www.digitalagency.com"
    },
    "paymentMethod": "Bank Transfer",
    "paymentReference": "TXN-20241218-001",
    "activityLog": [
      {
        "date": "2024-12-18T14:30:00",
        "action": "Payment received",
        "description": "Invoice paid via bank transfer",
        "user": "System"
      },
      {
        "date": "2024-12-15T09:15:00",
        "action": "Payment reminder sent",
        "description": "Automatic reminder sent to client",
        "user": "System"
      },
      {
        "date": "2024-11-20T16:45:00",
        "action": "Invoice sent",
        "description": "Invoice sent via email to billing@techsolutions.com",
        "user": "Sarah Johnson"
      },
      {
        "date": "2024-11-20T16:30:00",
        "action": "Invoice created",
        "description": "Invoice created from template",
        "user": "Sarah Johnson"
      }
    ]
  };

  Color _getStatusColor(String status) {
    switch (status) {
      case 'paid': return successColor;
      case 'pending': return warningColor;
      case 'overdue': return dangerColor;
      case 'draft': return infoColor;
      default: return disabledBoldColor;
    }
  }

  void _downloadInvoice() {
    showLoading();
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("Invoice downloaded as PDF");
    });
  }

  void _sendInvoice() {
    showLoading();
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("Invoice sent to ${invoice["clientEmail"]}");
    });
  }

  void _markAsPaid() async {
    bool isConfirmed = await confirm("Mark this invoice as paid?");
    if (isConfirmed) {
      setState(() {
        invoice["status"] = "paid";
        invoice["paymentDate"] = DateTime.now().toIso8601String().split('T')[0];
      });
      ss("Invoice marked as paid");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${invoice["id"]}"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              ss("Invoice shared");
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: _downloadInvoice,
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
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
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${invoice["id"]}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${invoice["description"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: _getStatusColor("${invoice["status"]}").withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${invoice["status"]}".toUpperCase(),
                          style: TextStyle(
                            color: _getStatusColor("${invoice["status"]}"),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Row(
                      children: [
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
                                "${((invoice["totalAmount"] as double).toDouble()).currency} ${invoice["currency"]}",
                                style: TextStyle(
                                  fontSize: fsH3,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Due Date",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${DateTime.parse("${invoice["dueDate"]}").dMMMy}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: invoice["status"] == "overdue" ? dangerColor : disabledBoldColor,
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

            // Company and Client Information
            Container(
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
                    "Invoice Details",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "From:",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${invoice["companyInfo"]["name"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${invoice["companyInfo"]["address"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${invoice["companyInfo"]["city"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${invoice["companyInfo"]["phone"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${invoice["companyInfo"]["email"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                              ),
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
                              "Bill To:",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${invoice["clientName"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${invoice["clientAddress"]["street"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${invoice["clientAddress"]["city"]}, ${invoice["clientAddress"]["state"]} ${invoice["clientAddress"]["zip"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${invoice["clientAddress"]["country"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${invoice["clientEmail"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                              ),
                            ),
                          ],
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
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Invoice Date",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${DateTime.parse("${invoice["createdDate"]}").dMMMy}",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
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
                              "Due Date",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${DateTime.parse("${invoice["dueDate"]}").dMMMy}",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (invoice["paymentDate"] != null) ...[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Payment Date",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${DateTime.parse("${invoice["paymentDate"]}").dMMMy}",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),

            // Line Items
            Container(
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
                    "Line Items",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  // Items Header
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            "Description",
                            style: TextStyle(
                              fontSize: 11,
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
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Rate",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Amount",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Line Items
                  ...(invoice["items"] as List).map((item) {
                    return Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: disabledOutlineBorderColor,
                            width: 0.5,
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
                                color: disabledBoldColor,
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
                              "\$${((item["rate"] as double).toDouble()).toStringAsFixed(2)}",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "\$${((item["amount"] as double).toDouble()).toStringAsFixed(2)}",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),

                  SizedBox(height: spSm),

                  // Totals
                  Column(
                    children: [
                      Row(
                        children: [
                          Spacer(),
                          Text(
                            "Subtotal:",
                            style: TextStyle(
                              fontSize: 13,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "${((invoice["subtotal"] as double).toDouble()).currency}",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      if ((invoice["discountAmount"] as double) > 0) ...[
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Spacer(),
                            Text(
                              "Discount (${invoice["discount"]}%):",
                              style: TextStyle(
                                fontSize: 13,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "-${((invoice["discountAmount"] as double).toDouble()).currency}",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Spacer(),
                          Text(
                            "Tax (${invoice["taxRate"]}%):",
                            style: TextStyle(
                              fontSize: 13,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "${((invoice["taxAmount"] as double).toDouble()).currency}",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Container(
                        height: 1,
                        color: disabledOutlineBorderColor,
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Spacer(),
                          Text(
                            "Total:",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "${((invoice["totalAmount"] as double).toDouble()).currency} ${invoice["currency"]}",
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
                ],
              ),
            ),

            // Payment Information
            if (invoice["status"] == "paid") ...[
              Container(
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
                      "Payment Information",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
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
                                  "Payment Received",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                ),
                                Text(
                                  "Method: ${invoice["paymentMethod"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: successColor,
                                  ),
                                ),
                                if (invoice["paymentReference"] != null) ...[
                                  Text(
                                    "Reference: ${invoice["paymentReference"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: successColor,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          Text(
                            "${DateTime.parse("${invoice["paymentDate"]}").dMMMy}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],

            // Notes
            if (invoice["notes"] != null && "${invoice["notes"]}".isNotEmpty) ...[
              Container(
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
                      "Notes",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${invoice["notes"]}",
                      style: TextStyle(
                        fontSize: 13,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],

            // Activity Log
            Container(
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
                    "Activity Log",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ...(invoice["activityLog"] as List).map((activity) {
                    return Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            width: 2,
                            color: primaryColor.withAlpha(100),
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${activity["action"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Text(
                                "${DateTime.parse("${activity["date"]}").dMMMy}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${activity["description"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "by ${activity["user"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledColor,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Action Buttons
            if (invoice["status"] != "paid") ...[
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Send Invoice",
                            icon: Icons.send,
                            size: bs.md,
                            onPressed: _sendInvoice,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Mark as Paid",
                            icon: Icons.check,
                            color: successColor,
                            size: bs.md,
                            onPressed: _markAsPaid,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Edit Invoice",
                            icon: Icons.edit,
                            color: infoColor,
                            size: bs.md,
                            onPressed: () {
                              // Navigate to edit invoice
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Download PDF",
                            icon: Icons.download,
                            color: warningColor,
                            size: bs.md,
                            onPressed: _downloadInvoice,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
