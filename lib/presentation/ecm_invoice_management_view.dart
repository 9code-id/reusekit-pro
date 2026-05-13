import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmInvoiceManagementView extends StatefulWidget {
  const EcmInvoiceManagementView({super.key});

  @override
  State<EcmInvoiceManagementView> createState() => _EcmInvoiceManagementViewState();
}

class _EcmInvoiceManagementViewState extends State<EcmInvoiceManagementView> {
  String filterStatus = "all";
  String filterPeriod = "30";
  String searchQuery = "";
  
  final List<Map<String, dynamic>> invoices = [
    {
      "id": "INV-2024-001",
      "invoiceNumber": "INV-001",
      "customerId": "CUST-001",
      "customerName": "John Smith",
      "customerEmail": "john.smith@email.com",
      "amount": 1299.99,
      "taxAmount": 129.99,
      "totalAmount": 1429.98,
      "currency": "USD",
      "status": "paid",
      "paymentStatus": "completed",
      "dueDate": "2024-07-15",
      "issuedDate": "2024-06-15",
      "paidDate": "2024-06-18",
      "items": [
        {"name": "Premium Subscription", "quantity": 1, "price": 999.99},
        {"name": "Additional Features", "quantity": 2, "price": 150.00}
      ],
      "paymentMethod": "credit_card",
      "notes": "Annual subscription with premium features"
    },
    {
      "id": "INV-2024-002",
      "invoiceNumber": "INV-002",
      "customerId": "CUST-002",
      "customerName": "Sarah Johnson",
      "customerEmail": "sarah.j@email.com",
      "amount": 299.50,
      "taxAmount": 29.95,
      "totalAmount": 329.45,
      "currency": "USD",
      "status": "pending",
      "paymentStatus": "pending",
      "dueDate": "2024-07-01",
      "issuedDate": "2024-06-01",
      "paidDate": null,
      "items": [
        {"name": "Basic Plan", "quantity": 1, "price": 199.50},
        {"name": "Setup Fee", "quantity": 1, "price": 100.00}
      ],
      "paymentMethod": null,
      "notes": "Monthly subscription setup"
    },
    {
      "id": "INV-2024-003",
      "invoiceNumber": "INV-003",
      "customerId": "CUST-003",
      "customerName": "Mike Wilson",
      "customerEmail": "mike.w@email.com",
      "amount": 599.00,
      "taxAmount": 59.90,
      "totalAmount": 658.90,
      "currency": "USD",
      "status": "overdue",
      "paymentStatus": "failed",
      "dueDate": "2024-06-10",
      "issuedDate": "2024-05-10",
      "paidDate": null,
      "items": [
        {"name": "Professional Package", "quantity": 1, "price": 599.00}
      ],
      "paymentMethod": null,
      "notes": "Overdue payment - follow up required"
    },
    {
      "id": "INV-2024-004",
      "invoiceNumber": "INV-004",
      "customerId": "CUST-004",
      "customerName": "Emma Davis",
      "customerEmail": "emma.davis@email.com",
      "amount": 149.99,
      "taxAmount": 14.99,
      "totalAmount": 164.98,
      "currency": "USD",
      "status": "draft",
      "paymentStatus": "not_sent",
      "dueDate": "2024-07-20",
      "issuedDate": null,
      "paidDate": null,
      "items": [
        {"name": "Starter Plan", "quantity": 1, "price": 149.99}
      ],
      "paymentMethod": null,
      "notes": "Draft invoice - pending approval"
    },
    {
      "id": "INV-2024-005",
      "invoiceNumber": "INV-005",
      "customerId": "CUST-005",
      "customerName": "David Brown",
      "customerEmail": "david.brown@email.com",
      "amount": 2499.00,
      "taxAmount": 249.90,
      "totalAmount": 2748.90,
      "currency": "USD",
      "status": "partially_paid",
      "paymentStatus": "partial",
      "dueDate": "2024-08-01",
      "issuedDate": "2024-06-01",
      "paidDate": "2024-06-10",
      "items": [
        {"name": "Enterprise Package", "quantity": 1, "price": 1999.00},
        {"name": "Custom Integration", "quantity": 1, "price": 500.00}
      ],
      "paymentMethod": "bank_transfer",
      "notes": "Partial payment received - balance pending"
    }
  ];

  List<Map<String, dynamic>> get filteredInvoices {
    List<Map<String, dynamic>> filtered = List.from(invoices);
    
    if (filterStatus != "all") {
      filtered = filtered.where((invoice) => invoice["status"] == filterStatus).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((invoice) => 
        (invoice["invoiceNumber"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (invoice["customerName"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (invoice["customerEmail"] as String).toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "paid":
        return successColor;
      case "pending":
        return warningColor;
      case "overdue":
        return dangerColor;
      case "draft":
        return infoColor;
      case "partially_paid":
        return primaryColor;
      default:
        return disabledColor;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case "paid":
        return "Paid";
      case "pending":
        return "Pending";
      case "overdue":
        return "Overdue";
      case "draft":
        return "Draft";
      case "partially_paid":
        return "Partially Paid";
      default:
        return "Unknown";
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalAmount = invoices.map((i) => i["totalAmount"] as double).reduce((a, b) => a + b);
    double paidAmount = invoices.where((i) => i["status"] == "paid")
        .map((i) => i["totalAmount"] as double).fold(0.0, (a, b) => a + b);
    int overdueCount = invoices.where((i) => i["status"] == "overdue").length;
    int pendingCount = invoices.where((i) => i["status"] == "pending").length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Invoice Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Create new invoice
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Overview Stats
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 160,
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.receipt, color: primaryColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Total Invoices",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${invoices.length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.payments, color: successColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Total Amount",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "\$${(totalAmount / 1000).toStringAsFixed(1)}K",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.check_circle, color: infoColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Paid Amount",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "\$${(paidAmount / 1000).toStringAsFixed(1)}K",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.warning, color: dangerColor, size: 20),
                          SizedBox(width: spXs),
                          Text(
                            "Overdue",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "$overdueCount",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Quick Actions
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 120,
                    children: [
                      QButton(
                        label: "Create Invoice",
                        size: bs.sm,
                        onPressed: () {
                          // Create new invoice
                        },
                      ),
                      QButton(
                        label: "Send Reminders",
                        size: bs.sm,
                        onPressed: () {
                          // Send payment reminders
                        },
                      ),
                      QButton(
                        label: "Export Report",
                        size: bs.sm,
                        onPressed: () {
                          // Export invoice report
                        },
                      ),
                      QButton(
                        label: "Templates",
                        size: bs.sm,
                        onPressed: () {
                          // Manage templates
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Filters
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: QTextField(
                    label: "Search invoices...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Status",
                    items: [
                      {"label": "All Status", "value": "all"},
                      {"label": "Draft", "value": "draft"},
                      {"label": "Pending", "value": "pending"},
                      {"label": "Paid", "value": "paid"},
                      {"label": "Overdue", "value": "overdue"},
                      {"label": "Partially Paid", "value": "partially_paid"},
                    ],
                    value: filterStatus,
                    onChanged: (value, label) {
                      filterStatus = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Invoices List
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Invoices (${filteredInvoices.length})",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      QButton(
                        label: "Bulk Actions",
                        size: bs.sm,
                        onPressed: () {
                          // Show bulk actions menu
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ...filteredInvoices.map((invoice) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: disabledOutlineBorderColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: _getStatusColor(invoice["status"]).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  Icons.receipt_long,
                                  color: _getStatusColor(invoice["status"]),
                                  size: 24,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${invoice["invoiceNumber"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${invoice["customerName"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "Due: ${invoice["dueDate"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "\$${((invoice["totalAmount"] as double).toDouble()).currency}",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor(invoice["status"]).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      _getStatusText(invoice["status"]),
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: _getStatusColor(invoice["status"]),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: disabledColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Items:",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                ...(invoice["items"] as List).map((item) {
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 2),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${item["name"]} × ${item["quantity"]}",
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: disabledBoldColor,
                                          ),
                                        ),
                                        Text(
                                          "\$${((item["price"] as double).toDouble()).currency}",
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ],
                            ),
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Subtotal",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "\$${((invoice["amount"] as double).toDouble()).currency}",
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
                                      "Tax",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "\$${((invoice["taxAmount"] as double).toDouble()).currency}",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: warningColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (invoice["issuedDate"] != null)
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Issued",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${invoice["issuedDate"]}",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: infoColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              if (invoice["paidDate"] != null)
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Paid",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "${invoice["paidDate"]}",
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
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "View",
                                  size: bs.sm,
                                  onPressed: () {
                                    // View invoice details
                                  },
                                ),
                              ),
                              SizedBox(width: spSm),
                              if (invoice["status"] == "draft")
                                QButton(
                                  label: "Send",
                                  size: bs.sm,
                                  onPressed: () {
                                    // Send invoice
                                  },
                                ),
                              if (invoice["status"] == "pending" || invoice["status"] == "overdue")
                                QButton(
                                  label: "Remind",
                                  size: bs.sm,
                                  onPressed: () {
                                    // Send reminder
                                  },
                                ),
                              SizedBox(width: spSm),
                              QButton(
                                icon: Icons.more_vert,
                                size: bs.sm,
                                onPressed: () {
                                  // Show options menu
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
