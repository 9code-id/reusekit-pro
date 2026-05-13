import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaRecurringInvoicesView extends StatefulWidget {
  const AbaRecurringInvoicesView({super.key});

  @override
  State<AbaRecurringInvoicesView> createState() => _AbaRecurringInvoicesViewState();
}

class _AbaRecurringInvoicesViewState extends State<AbaRecurringInvoicesView> {
  String searchQuery = "";
  String selectedStatus = "all";
  String selectedFrequency = "all";

  List<Map<String, dynamic>> recurringInvoices = [
    {
      "id": "REC-001",
      "clientName": "Tech Solutions Inc",
      "clientEmail": "billing@techsolutions.com",
      "description": "Monthly Web Development Retainer",
      "amount": 5000.00,
      "currency": "USD",
      "frequency": "monthly",
      "status": "active",
      "startDate": "2024-01-01",
      "endDate": "2024-12-31",
      "nextInvoiceDate": "2024-12-20",
      "lastInvoiceDate": "2024-11-20",
      "totalInvoices": 11,
      "totalRevenue": 55000.00,
      "template": "Standard Service Invoice",
      "taxRate": 8.5,
      "paymentTerms": "Net 30",
      "autoSend": true,
      "createdDate": "2023-12-15"
    },
    {
      "id": "REC-002",
      "clientName": "Global Marketing Ltd",
      "clientEmail": "accounts@globalmarketing.com",
      "description": "Quarterly Digital Marketing Services",
      "amount": 15000.00,
      "currency": "USD",
      "frequency": "quarterly",
      "status": "active",
      "startDate": "2024-01-01",
      "endDate": "2025-12-31",
      "nextInvoiceDate": "2025-01-01",
      "lastInvoiceDate": "2024-10-01",
      "totalInvoices": 4,
      "totalRevenue": 60000.00,
      "template": "Consulting Invoice",
      "taxRate": 8.5,
      "paymentTerms": "Net 15",
      "autoSend": true,
      "createdDate": "2023-11-20"
    },
    {
      "id": "REC-003",
      "clientName": "Startup Ventures",
      "clientEmail": "billing@startupventures.io",
      "description": "SaaS Platform Subscription",
      "amount": 299.00,
      "currency": "USD",
      "frequency": "monthly",
      "status": "paused",
      "startDate": "2024-06-01",
      "endDate": "2025-05-31",
      "nextInvoiceDate": null,
      "lastInvoiceDate": "2024-11-01",
      "totalInvoices": 6,
      "totalRevenue": 1794.00,
      "template": "Subscription Invoice",
      "taxRate": 8.5,
      "paymentTerms": "Due on Receipt",
      "autoSend": false,
      "createdDate": "2024-05-15",
      "pausedDate": "2024-12-01",
      "pauseReason": "Client requested temporary pause"
    },
    {
      "id": "REC-004",
      "clientName": "Enterprise Solutions",
      "clientEmail": "ap@enterprisesolutions.com",
      "description": "Annual Software License",
      "amount": 25000.00,
      "currency": "USD",
      "frequency": "yearly",
      "status": "active",
      "startDate": "2024-01-01",
      "endDate": "2026-12-31",
      "nextInvoiceDate": "2025-01-01",
      "lastInvoiceDate": "2024-01-01",
      "totalInvoices": 1,
      "totalRevenue": 25000.00,
      "template": "Product Sales Invoice",
      "taxRate": 10.0,
      "paymentTerms": "Net 30",
      "autoSend": true,
      "createdDate": "2023-12-01"
    },
    {
      "id": "REC-005",
      "clientName": "Innovation Corp",
      "clientEmail": "finance@innovationcorp.com",
      "description": "Weekly Consulting Hours",
      "amount": 2800.00,
      "currency": "USD",
      "frequency": "weekly",
      "status": "cancelled",
      "startDate": "2024-03-01",
      "endDate": "2024-08-31",
      "nextInvoiceDate": null,
      "lastInvoiceDate": "2024-08-26",
      "totalInvoices": 26,
      "totalRevenue": 72800.00,
      "template": "Freelance Creative Work",
      "taxRate": 8.5,
      "paymentTerms": "Net 15",
      "autoSend": true,
      "createdDate": "2024-02-15",
      "cancelledDate": "2024-08-31",
      "cancelReason": "Project completed"
    }
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Paused", "value": "paused"},
    {"label": "Cancelled", "value": "cancelled"},
  ];

  List<Map<String, dynamic>> frequencyOptions = [
    {"label": "All Frequencies", "value": "all"},
    {"label": "Weekly", "value": "weekly"},
    {"label": "Monthly", "value": "monthly"},
    {"label": "Quarterly", "value": "quarterly"},
    {"label": "Yearly", "value": "yearly"},
  ];

  List<Map<String, dynamic>> get filteredInvoices {
    return recurringInvoices.where((invoice) {
      bool matchesSearch = searchQuery.isEmpty || 
          "${invoice["id"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${invoice["clientName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${invoice["description"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "all" || invoice["status"] == selectedStatus;
      bool matchesFrequency = selectedFrequency == "all" || invoice["frequency"] == selectedFrequency;
      
      return matchesSearch && matchesStatus && matchesFrequency;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'active': return successColor;
      case 'paused': return warningColor;
      case 'cancelled': return dangerColor;
      default: return disabledBoldColor;
    }
  }

  Color _getFrequencyColor(String frequency) {
    switch (frequency) {
      case 'weekly': return primaryColor;
      case 'monthly': return successColor;
      case 'quarterly': return warningColor;
      case 'yearly': return infoColor;
      default: return disabledBoldColor;
    }
  }

  String _getFrequencyLabel(String frequency) {
    switch (frequency) {
      case 'weekly': return 'Weekly';
      case 'monthly': return 'Monthly';
      case 'quarterly': return 'Quarterly';
      case 'yearly': return 'Yearly';
      default: return frequency;
    }
  }

  void _pauseInvoice(Map<String, dynamic> invoice) async {
    bool isConfirmed = await confirm("Pause this recurring invoice?");
    if (isConfirmed) {
      invoice["status"] = "paused";
      invoice["pausedDate"] = DateTime.now().toIso8601String().split('T')[0];
      invoice["pauseReason"] = "Manually paused by user";
      invoice["nextInvoiceDate"] = null;
      setState(() {});
      sw("Recurring invoice paused");
    }
  }

  void _resumeInvoice(Map<String, dynamic> invoice) async {
    bool isConfirmed = await confirm("Resume this recurring invoice?");
    if (isConfirmed) {
      invoice["status"] = "active";
      invoice.remove("pausedDate");
      invoice.remove("pauseReason");
      
      // Calculate next invoice date based on frequency
      DateTime now = DateTime.now();
      DateTime nextDate;
      
      switch (invoice["frequency"]) {
        case "weekly":
          nextDate = now.add(Duration(days: 7));
          break;
        case "monthly":
          nextDate = DateTime(now.year, now.month + 1, now.day);
          break;
        case "quarterly":
          nextDate = DateTime(now.year, now.month + 3, now.day);
          break;
        case "yearly":
          nextDate = DateTime(now.year + 1, now.month, now.day);
          break;
        default:
          nextDate = now.add(Duration(days: 30));
      }
      
      invoice["nextInvoiceDate"] = nextDate.toIso8601String().split('T')[0];
      setState(() {});
      ss("Recurring invoice resumed");
    }
  }

  void _cancelInvoice(Map<String, dynamic> invoice) async {
    bool isConfirmed = await confirm("Cancel this recurring invoice? This action cannot be undone.");
    if (isConfirmed) {
      invoice["status"] = "cancelled";
      invoice["cancelledDate"] = DateTime.now().toIso8601String().split('T')[0];
      invoice["cancelReason"] = "Manually cancelled by user";
      invoice["nextInvoiceDate"] = null;
      setState(() {});
      se("Recurring invoice cancelled");
    }
  }

  void _generateInvoiceNow(Map<String, dynamic> invoice) async {
    if (invoice["status"] != "active") {
      se("Cannot generate invoice for inactive recurring schedule");
      return;
    }
    
    bool isConfirmed = await confirm("Generate invoice now for ${invoice["clientName"]}?");
    if (isConfirmed) {
      showLoading();
      await Future.delayed(Duration(seconds: 2));
      hideLoading();
      
      // Update stats
      invoice["totalInvoices"] = (invoice["totalInvoices"] as int) + 1;
      invoice["totalRevenue"] = (invoice["totalRevenue"] as double) + (invoice["amount"] as double);
      invoice["lastInvoiceDate"] = DateTime.now().toIso8601String().split('T')[0];
      
      setState(() {});
      ss("Invoice generated and sent to ${invoice["clientEmail"]}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recurring Invoices"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to create recurring invoice
            },
          ),
          IconButton(
            icon: Icon(Icons.schedule),
            onPressed: () {
              ss("View invoice schedule");
            },
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
                    label: "Search Recurring Invoices",
                    value: searchQuery,
                    hint: "Search by ID, client name, or description",
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
                          label: "Frequency",
                          items: frequencyOptions,
                          value: selectedFrequency,
                          onChanged: (value, label) {
                            selectedFrequency = value;
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
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 120,
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.autorenew,
                        color: successColor,
                        size: 32,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${filteredInvoices.where((i) => i["status"] == "active").length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Active",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
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
                    children: [
                      Icon(
                        Icons.pause_circle,
                        color: warningColor,
                        size: 32,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${filteredInvoices.where((i) => i["status"] == "paused").length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Paused",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
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
                    children: [
                      Icon(
                        Icons.attach_money,
                        color: primaryColor,
                        size: 32,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${((filteredInvoices.fold(0.0, (sum, i) => sum + (i["totalRevenue"] as double))).toDouble()).currency}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Total Revenue",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
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
                    children: [
                      Icon(
                        Icons.receipt,
                        color: infoColor,
                        size: 32,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${filteredInvoices.fold(0, (sum, i) => sum + (i["totalInvoices"] as int))}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Total Invoices",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Recurring Invoices List
            if (filteredInvoices.isEmpty) ...[
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.repeat,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No recurring invoices found",
                      style: TextStyle(
                        fontSize: fsH6,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Create recurring invoices to automate your billing",
                      style: TextStyle(
                        color: disabledColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
              ...filteredInvoices.map((invoice) {
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
                              color: _getFrequencyColor("${invoice["frequency"]}").withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              _getFrequencyLabel("${invoice["frequency"]}").toUpperCase(),
                              style: TextStyle(
                                color: _getFrequencyColor("${invoice["frequency"]}"),
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(width: spXs),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getStatusColor("${invoice["status"]}").withAlpha(30),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${invoice["status"]}".toUpperCase(),
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
                                if (invoice["autoSend"] == true) ...[
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: successColor.withAlpha(30),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "AUTO-SEND",
                                      style: TextStyle(
                                        color: successColor,
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                      ),
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

                      // Schedule Information
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Period: ${DateTime.parse("${invoice["startDate"]}").dMMMy} - ${DateTime.parse("${invoice["endDate"]}").dMMMy}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                if (invoice["nextInvoiceDate"] != null) ...[
                                  Text(
                                    "Next invoice: ${DateTime.parse("${invoice["nextInvoiceDate"]}").dMMMy}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: invoice["status"] == "active" ? primaryColor : disabledBoldColor,
                                      fontWeight: invoice["status"] == "active" ? FontWeight.w600 : FontWeight.normal,
                                    ),
                                  ),
                                ],
                                if (invoice["lastInvoiceDate"] != null) ...[
                                  Text(
                                    "Last invoice: ${DateTime.parse("${invoice["lastInvoiceDate"]}").dMMMy}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledColor,
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
                                "${invoice["totalInvoices"]} invoices",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${((invoice["totalRevenue"] as double).toDouble()).currency} total",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: successColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Status-specific information
                      if (invoice["status"] == "paused" && invoice["pauseReason"] != null) ...[
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.pause,
                                color: warningColor,
                                size: 16,
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "Paused: ${invoice["pauseReason"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: warningColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],

                      if (invoice["status"] == "cancelled" && invoice["cancelReason"] != null) ...[
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.cancel,
                                color: dangerColor,
                                size: 16,
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "Cancelled: ${invoice["cancelReason"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: dangerColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],

                      // Action Buttons
                      if (invoice["status"] == "active") ...[
                        Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: "Generate Now",
                                icon: Icons.send,
                                size: bs.sm,
                                onPressed: () => _generateInvoiceNow(invoice),
                              ),
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: QButton(
                                label: "Pause",
                                icon: Icons.pause,
                                color: warningColor,
                                size: bs.sm,
                                onPressed: () => _pauseInvoice(invoice),
                              ),
                            ),
                            SizedBox(width: spXs),
                            GestureDetector(
                              onTap: () => _cancelInvoice(invoice),
                              child: Icon(
                                Icons.cancel,
                                color: dangerColor,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ] else if (invoice["status"] == "paused") ...[
                        Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: "Resume",
                                icon: Icons.play_arrow,
                                color: successColor,
                                size: bs.sm,
                                onPressed: () => _resumeInvoice(invoice),
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
                                  // Navigate to edit recurring invoice
                                },
                              ),
                            ),
                            SizedBox(width: spXs),
                            GestureDetector(
                              onTap: () => _cancelInvoice(invoice),
                              child: Icon(
                                Icons.cancel,
                                color: dangerColor,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ] else ...[
                        Container(
                          width: double.infinity,
                          child: QButton(
                            label: "View Details",
                            icon: Icons.visibility,
                            size: bs.sm,
                            onPressed: () {
                              // Navigate to recurring invoice details
                            },
                          ),
                        ),
                      ],
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
          // Navigate to create recurring invoice
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
