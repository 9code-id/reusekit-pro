import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaInvoiceListView extends StatefulWidget {
  const AbaInvoiceListView({super.key});

  @override
  State<AbaInvoiceListView> createState() => _AbaInvoiceListViewState();
}

class _AbaInvoiceListViewState extends State<AbaInvoiceListView> {
  String searchQuery = "";
  String selectedStatus = "all";
  String sortBy = "date_desc";

  List<Map<String, dynamic>> invoices = [
    {
      "id": "INV-2024-001",
      "clientName": "Tech Solutions Inc",
      "clientEmail": "billing@techsolutions.com",
      "amount": 15750.00,
      "currency": "USD",
      "status": "paid",
      "dueDate": "2024-12-20",
      "createdDate": "2024-11-20",
      "paymentDate": "2024-12-18",
      "description": "Web Development Services - November 2024",
      "items": [
        {"description": "Frontend Development", "quantity": 40, "rate": 125.00},
        {"description": "Backend Integration", "quantity": 60, "rate": 135.00},
        {"description": "Testing & QA", "quantity": 20, "rate": 95.00}
      ],
      "taxRate": 8.5,
      "discount": 0.0
    },
    {
      "id": "INV-2024-002",
      "clientName": "Global Marketing Ltd",
      "clientEmail": "accounts@globalmarketing.com",
      "amount": 8500.00,
      "currency": "USD",
      "status": "overdue",
      "dueDate": "2024-12-10",
      "createdDate": "2024-11-10",
      "description": "Digital Marketing Campaign - Q4 2024",
      "items": [
        {"description": "Social Media Management", "quantity": 30, "rate": 85.00},
        {"description": "Content Creation", "quantity": 25, "rate": 95.00},
        {"description": "Analytics & Reporting", "quantity": 20, "rate": 110.00}
      ],
      "daysPastDue": 9,
      "taxRate": 8.5,
      "discount": 5.0
    },
    {
      "id": "INV-2024-003",
      "clientName": "Innovation Corp",
      "clientEmail": "finance@innovationcorp.com",
      "amount": 22300.00,
      "currency": "USD",
      "status": "pending",
      "dueDate": "2024-12-25",
      "createdDate": "2024-11-25",
      "description": "Software Development & Consulting - December 2024",
      "items": [
        {"description": "System Architecture", "quantity": 50, "rate": 150.00},
        {"description": "Development", "quantity": 80, "rate": 135.00},
        {"description": "Consulting", "quantity": 30, "rate": 175.00}
      ],
      "taxRate": 8.5,
      "discount": 2.5
    },
    {
      "id": "INV-2024-004",
      "clientName": "Startup Ventures",
      "clientEmail": "billing@startupventures.io",
      "amount": 5200.00,
      "currency": "USD",
      "status": "draft",
      "dueDate": "2024-12-30",
      "createdDate": "2024-12-15",
      "description": "UX/UI Design Services - Phase 1",
      "items": [
        {"description": "UI Design", "quantity": 25, "rate": 120.00},
        {"description": "UX Research", "quantity": 15, "rate": 140.00},
        {"description": "Prototyping", "quantity": 12, "rate": 110.00}
      ],
      "taxRate": 8.5,
      "discount": 0.0
    },
    {
      "id": "INV-2024-005",
      "clientName": "Enterprise Solutions",
      "clientEmail": "ap@enterprisesolutions.com",
      "amount": 35000.00,
      "currency": "USD",
      "status": "pending",
      "dueDate": "2024-12-28",
      "createdDate": "2024-11-28",
      "description": "Enterprise Software Implementation",
      "items": [
        {"description": "Implementation", "quantity": 100, "rate": 175.00},
        {"description": "Training", "quantity": 40, "rate": 125.00},
        {"description": "Support", "quantity": 60, "rate": 110.00}
      ],
      "taxRate": 8.5,
      "discount": 3.0
    }
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Invoices", "value": "all"},
    {"label": "Draft", "value": "draft"},
    {"label": "Pending", "value": "pending"},
    {"label": "Paid", "value": "paid"},
    {"label": "Overdue", "value": "overdue"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Newest First", "value": "date_desc"},
    {"label": "Oldest First", "value": "date_asc"},
    {"label": "Amount (High to Low)", "value": "amount_desc"},
    {"label": "Amount (Low to High)", "value": "amount_asc"},
    {"label": "Due Date", "value": "due_date"},
  ];

  List<Map<String, dynamic>> get filteredAndSortedInvoices {
    List<Map<String, dynamic>> filtered = invoices.where((invoice) {
      bool matchesSearch = searchQuery.isEmpty || 
          "${invoice["id"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${invoice["clientName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${invoice["description"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "all" || invoice["status"] == selectedStatus;
      
      return matchesSearch && matchesStatus;
    }).toList();

    // Sort invoices
    filtered.sort((a, b) {
      switch (sortBy) {
        case "date_desc":
          return DateTime.parse("${b["createdDate"]}").compareTo(DateTime.parse("${a["createdDate"]}"));
        case "date_asc":
          return DateTime.parse("${a["createdDate"]}").compareTo(DateTime.parse("${b["createdDate"]}"));
        case "amount_desc":
          return (b["amount"] as double).compareTo(a["amount"] as double);
        case "amount_asc":
          return (a["amount"] as double).compareTo(b["amount"] as double);
        case "due_date":
          return DateTime.parse("${a["dueDate"]}").compareTo(DateTime.parse("${b["dueDate"]}"));
        default:
          return 0;
      }
    });

    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'paid': return successColor;
      case 'pending': return warningColor;
      case 'overdue': return dangerColor;
      case 'draft': return infoColor;
      default: return disabledBoldColor;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case 'paid': return 'PAID';
      case 'pending': return 'PENDING';
      case 'overdue': return 'OVERDUE';
      case 'draft': return 'DRAFT';
      default: return status.toUpperCase();
    }
  }

  void _sendInvoice(Map<String, dynamic> invoice) async {
    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    
    invoice["status"] = "pending";
    setState(() {});
    ss("Invoice sent successfully to ${invoice["clientEmail"]}");
  }

  void _markAsPaid(Map<String, dynamic> invoice) async {
    bool isConfirmed = await confirm("Mark this invoice as paid?");
    if (isConfirmed) {
      invoice["status"] = "paid";
      invoice["paymentDate"] = DateTime.now().toIso8601String().split('T')[0];
      setState(() {});
      ss("Invoice marked as paid");
    }
  }

  void _deleteInvoice(Map<String, dynamic> invoice) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this invoice? This action cannot be undone.");
    if (isConfirmed) {
      invoices.remove(invoice);
      setState(() {});
      se("Invoice deleted");
    }
  }

  void _duplicateInvoice(Map<String, dynamic> invoice) {
    Map<String, dynamic> duplicated = Map.from(invoice);
    duplicated["id"] = "INV-2024-${(invoices.length + 1).toString().padLeft(3, '0')}";
    duplicated["status"] = "draft";
    duplicated["createdDate"] = DateTime.now().toIso8601String().split('T')[0];
    duplicated["dueDate"] = DateTime.now().add(Duration(days: 30)).toIso8601String().split('T')[0];
    duplicated.remove("paymentDate");
    duplicated.remove("daysPastDue");
    
    invoices.insert(0, duplicated);
    setState(() {});
    ss("Invoice duplicated successfully");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Invoice List"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to create invoice
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filter Section
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
                  QTextField(
                    label: "Search Invoices",
                    value: searchQuery,
                    hint: "Search by invoice ID, client name, or description",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Status",
                          items: statusOptions,
                          value: selectedStatus,
                          onChanged: (value, label) {
                            selectedStatus = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Sort By",
                          items: sortOptions,
                          value: sortBy,
                          onChanged: (value, label) {
                            sortBy = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Summary Statistics
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${filteredAndSortedInvoices.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Invoices",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 30,
                    color: disabledOutlineBorderColor,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${((filteredAndSortedInvoices.fold(0.0, (sum, invoice) => sum + (invoice["amount"] as double))).toDouble()).currency}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Total Value",
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

            // Invoice List
            if (filteredAndSortedInvoices.isEmpty) ...[
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.receipt_long,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No invoices found",
                      style: TextStyle(
                        fontSize: fsH6,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try adjusting your search or filter criteria",
                      style: TextStyle(
                        color: disabledColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
              ...filteredAndSortedInvoices.map((invoice) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: _getStatusColor("${invoice["status"]}"),
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      // Header Row
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${invoice["id"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${invoice["clientName"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getStatusColor("${invoice["status"]}").withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              _getStatusLabel("${invoice["status"]}"),
                              style: TextStyle(
                                color: _getStatusColor("${invoice["status"]}"),
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Amount and Description
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${((invoice["amount"] as double).toDouble()).currency} ${invoice["currency"]}",
                                  style: TextStyle(
                                    fontSize: fsH5,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Spacer(),
                                if (invoice["status"] == "overdue") ...[
                                  Text(
                                    "${invoice["daysPastDue"]} days overdue",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: dangerColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${invoice["description"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Dates and Details
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Created: ${DateTime.parse("${invoice["createdDate"]}").dMMMy}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "Due: ${DateTime.parse("${invoice["dueDate"]}").dMMMy}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: invoice["status"] == "overdue" ? dangerColor : disabledBoldColor,
                                    fontWeight: invoice["status"] == "overdue" ? FontWeight.w600 : FontWeight.normal,
                                  ),
                                ),
                                if (invoice["paymentDate"] != null) ...[
                                  Text(
                                    "Paid: ${DateTime.parse("${invoice["paymentDate"]}").dMMMy}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: successColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "${invoice["clientEmail"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${(invoice["items"] as List).length} items",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Action Buttons
                      Row(
                        children: [
                          if (invoice["status"] == "draft") ...[
                            Expanded(
                              child: QButton(
                                label: "Send",
                                icon: Icons.send,
                                size: bs.sm,
                                onPressed: () => _sendInvoice(invoice),
                              ),
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: QButton(
                                label: "Edit",
                                icon: Icons.edit,
                                color: infoColor,
                                size: bs.sm,
                                onPressed: () {
                                  // Navigate to edit invoice
                                },
                              ),
                            ),
                          ] else if (invoice["status"] == "pending") ...[
                            Expanded(
                              child: QButton(
                                label: "Mark Paid",
                                icon: Icons.check,
                                color: successColor,
                                size: bs.sm,
                                onPressed: () => _markAsPaid(invoice),
                              ),
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: QButton(
                                label: "Resend",
                                icon: Icons.refresh,
                                color: warningColor,
                                size: bs.sm,
                                onPressed: () => _sendInvoice(invoice),
                              ),
                            ),
                          ] else if (invoice["status"] == "overdue") ...[
                            Expanded(
                              child: QButton(
                                label: "Mark Paid",
                                icon: Icons.check,
                                color: successColor,
                                size: bs.sm,
                                onPressed: () => _markAsPaid(invoice),
                              ),
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: QButton(
                                label: "Send Reminder",
                                icon: Icons.notification_important,
                                color: dangerColor,
                                size: bs.sm,
                                onPressed: () {
                                  ss("Payment reminder sent");
                                },
                              ),
                            ),
                          ] else ...[
                            Expanded(
                              child: QButton(
                                label: "View Details",
                                icon: Icons.visibility,
                                size: bs.sm,
                                onPressed: () {
                                  // Navigate to invoice details
                                },
                              ),
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: QButton(
                                label: "Download",
                                icon: Icons.download,
                                color: infoColor,
                                size: bs.sm,
                                onPressed: () {
                                  ss("Invoice downloaded");
                                },
                              ),
                            ),
                          ],
                          SizedBox(width: spXs),
                          GestureDetector(
                            onTap: () {
                              // Show more options
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => Container(
                                  padding: EdgeInsets.all(spMd),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    spacing: spSm,
                                    children: [
                                      Text(
                                        "Invoice Actions",
                                        style: TextStyle(
                                          fontSize: fsH6,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.copy),
                                        title: Text("Duplicate Invoice"),
                                        onTap: () {
                                          back();
                                          _duplicateInvoice(invoice);
                                        },
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.share),
                                        title: Text("Share Invoice"),
                                        onTap: () {
                                          back();
                                          ss("Invoice shared");
                                        },
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.delete, color: dangerColor),
                                        title: Text("Delete Invoice", style: TextStyle(color: dangerColor)),
                                        onTap: () {
                                          back();
                                          _deleteInvoice(invoice);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            child: Icon(
                              Icons.more_vert,
                              color: disabledBoldColor,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to create invoice
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
