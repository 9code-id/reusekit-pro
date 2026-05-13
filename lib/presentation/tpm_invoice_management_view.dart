import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmInvoiceManagementView extends StatefulWidget {
  const TpmInvoiceManagementView({super.key});

  @override
  State<TpmInvoiceManagementView> createState() => _TpmInvoiceManagementViewState();
}

class _TpmInvoiceManagementViewState extends State<TpmInvoiceManagementView> {
  int currentTab = 0;
  String selectedStatus = "all";
  String searchQuery = "";
  bool showCreateInvoice = false;

  // Invoice form data
  String clientName = "";
  String projectName = "";
  String invoiceNumber = "";
  DateTime dueDate = DateTime.now().add(Duration(days: 30));
  List<Map<String, dynamic>> invoiceItems = [];
  double taxRate = 10.0;
  String notes = "";

  List<Map<String, dynamic>> statusFilters = [
    {"label": "All Invoices", "value": "all"},
    {"label": "Draft", "value": "draft"},
    {"label": "Sent", "value": "sent"},
    {"label": "Paid", "value": "paid"},
    {"label": "Overdue", "value": "overdue"},
  ];

  List<Map<String, dynamic>> invoices = [
    {
      "id": "INV-2024-001",
      "client": "TechCorp Solutions",
      "project": "Mobile App Development",
      "amount": 15000.0,
      "status": "paid",
      "dueDate": "2024-01-15",
      "issueDate": "2023-12-15",
      "paidDate": "2024-01-10",
      "items": 8,
    },
    {
      "id": "INV-2024-002",
      "client": "Digital Ventures",
      "project": "Web Platform Redesign",
      "amount": 22500.0,
      "status": "sent",
      "dueDate": "2024-02-20",
      "issueDate": "2024-01-20",
      "paidDate": null,
      "items": 12,
    },
    {
      "id": "INV-2024-003",
      "client": "StartupHub Inc",
      "project": "AI Integration Services",
      "amount": 8750.0,
      "status": "overdue",
      "dueDate": "2024-01-30",
      "issueDate": "2023-12-30",
      "paidDate": null,
      "items": 5,
    },
    {
      "id": "INV-2024-004",
      "client": "Enterprise Systems",
      "project": "Cloud Migration",
      "amount": 18200.0,
      "status": "draft",
      "dueDate": "2024-03-15",
      "issueDate": null,
      "paidDate": null,
      "items": 15,
    },
    {
      "id": "INV-2024-005",
      "client": "Innovation Labs",
      "project": "Data Analytics Platform",
      "amount": 31000.0,
      "status": "sent",
      "dueDate": "2024-02-28",
      "issueDate": "2024-01-28",
      "paidDate": null,
      "items": 20,
    },
  ];

  List<Map<String, dynamic>> recentActivity = [
    {
      "type": "payment",
      "invoice": "INV-2024-001",
      "client": "TechCorp Solutions",
      "amount": 15000.0,
      "time": "2 hours ago",
      "icon": Icons.payment,
      "color": successColor,
    },
    {
      "type": "sent",
      "invoice": "INV-2024-005",
      "client": "Innovation Labs",
      "amount": 31000.0,
      "time": "5 hours ago",
      "icon": Icons.send,
      "color": primaryColor,
    },
    {
      "type": "overdue",
      "invoice": "INV-2024-003",
      "client": "StartupHub Inc",
      "amount": 8750.0,
      "time": "1 day ago",
      "icon": Icons.warning,
      "color": dangerColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Invoice Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              showCreateInvoice = true;
              setState(() {});
            },
          ),
        ],
      ),
      body: showCreateInvoice ? _buildCreateInvoiceForm() : _buildInvoiceList(),
    );
  }

  Widget _buildInvoiceList() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildSummaryCards(),
          _buildFiltersAndSearch(),
          _buildInvoiceStats(),
          _buildInvoicesSection(),
          _buildRecentActivity(),
        ],
      ),
    );
  }

  Widget _buildSummaryCards() {
    double totalAmount = invoices.fold(0.0, (sum, invoice) => sum + (invoice["amount"] as double));
    double paidAmount = invoices.where((i) => i["status"] == "paid").fold(0.0, (sum, invoice) => sum + (invoice["amount"] as double));
    double pendingAmount = invoices.where((i) => i["status"] == "sent").fold(0.0, (sum, invoice) => sum + (invoice["amount"] as double));
    double overdueAmount = invoices.where((i) => i["status"] == "overdue").fold(0.0, (sum, invoice) => sum + (invoice["amount"] as double));

    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spXs,
              children: [
                Icon(Icons.receipt_long, color: primaryColor, size: 32),
                Text(
                  "Total Revenue",
                  style: TextStyle(fontSize: 12, color: disabledBoldColor),
                ),
                Text(
                  "\$${totalAmount.currency}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spXs,
              children: [
                Icon(Icons.check_circle, color: successColor, size: 32),
                Text(
                  "Paid",
                  style: TextStyle(fontSize: 12, color: disabledBoldColor),
                ),
                Text(
                  "\$${paidAmount.currency}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spXs,
              children: [
                Icon(Icons.schedule, color: warningColor, size: 32),
                Text(
                  "Pending",
                  style: TextStyle(fontSize: 12, color: disabledBoldColor),
                ),
                Text(
                  "\$${pendingAmount.currency}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: warningColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spXs,
              children: [
                Icon(Icons.warning, color: dangerColor, size: 32),
                Text(
                  "Overdue",
                  style: TextStyle(fontSize: 12, color: disabledBoldColor),
                ),
                Text(
                  "\$${overdueAmount.currency}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: dangerColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFiltersAndSearch() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
                child: QTextField(
                  label: "Search invoices...",
                  value: searchQuery,
                  hint: "Invoice ID, client name, or project",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.search,
                size: bs.sm,
                onPressed: () {
                  // Perform search
                },
              ),
            ],
          ),
          QDropdownField(
            label: "Filter by Status",
            items: statusFilters,
            value: selectedStatus,
            onChanged: (value, label) {
              selectedStatus = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInvoiceStats() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Invoice Statistics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildStatCard("Total Invoices", "${invoices.length}", Icons.receipt, primaryColor),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard("This Month", "8", Icons.calendar_month, successColor),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard("Avg. Amount", "\$${(invoices.fold(0.0, (sum, i) => sum + (i["amount"] as double)) / invoices.length).toStringAsFixed(0)}", Icons.trending_up, warningColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Icon(icon, color: color, size: 24),
          Text(
            title,
            style: TextStyle(fontSize: 10, color: disabledBoldColor),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvoicesSection() {
    List<Map<String, dynamic>> filteredInvoices = invoices.where((invoice) {
      bool statusMatch = selectedStatus == "all" || invoice["status"] == selectedStatus;
      bool searchMatch = searchQuery.isEmpty ||
          "${invoice["id"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${invoice["client"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${invoice["project"]}".toLowerCase().contains(searchQuery.toLowerCase());
      return statusMatch && searchMatch;
    }).toList();

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Recent Invoices",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${filteredInvoices.length} invoices",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          ...filteredInvoices.map((invoice) => _buildInvoiceCard(invoice)).toList(),
        ],
      ),
    );
  }

  Widget _buildInvoiceCard(Map<String, dynamic> invoice) {
    Color statusColor = _getStatusColor(invoice["status"] as String);
    IconData statusIcon = _getStatusIcon(invoice["status"] as String);

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        spacing: spXs,
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
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${invoice["client"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(statusIcon, size: 12, color: Colors.white),
                    SizedBox(width: 2),
                    Text(
                      "${invoice["status"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${invoice["project"]}",
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      "Due: ${invoice["dueDate"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "\$${(invoice["amount"] as double).currency}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "${invoice["items"]} items",
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "View",
                size: bs.sm,
                onPressed: () {
                  ss("Viewing invoice ${invoice["id"]}");
                },
              ),
              SizedBox(width: spXs),
              QButton(
                label: "Send",
                size: bs.sm,
                icon: Icons.send,
                onPressed: () {
                  ss("Invoice ${invoice["id"]} sent to client");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Activity",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...recentActivity.map((activity) {
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                color: (activity["color"] as Color).withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    activity["icon"] as IconData,
                    color: activity["color"] as Color,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${activity["invoice"]} - ${activity["client"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "\$${(activity["amount"] as double).currency} • ${activity["time"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildCreateInvoiceForm() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Create New Invoice",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Cancel",
                size: bs.sm,
                onPressed: () {
                  showCreateInvoice = false;
                  setState(() {});
                },
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                QTextField(
                  label: "Client Name",
                  value: clientName,
                  hint: "Enter client company name",
                  onChanged: (value) {
                    clientName = value;
                    setState(() {});
                  },
                ),
                QTextField(
                  label: "Project Name",
                  value: projectName,
                  hint: "Enter project title",
                  onChanged: (value) {
                    projectName = value;
                    setState(() {});
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Invoice Number",
                        value: invoiceNumber,
                        hint: "INV-2024-XXX",
                        onChanged: (value) {
                          invoiceNumber = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDatePicker(
                        label: "Due Date",
                        value: dueDate,
                        onChanged: (value) {
                          dueDate = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                QNumberField(
                  label: "Tax Rate (%)",
                  value: taxRate.toString(),
                  onChanged: (value) {
                    taxRate = double.tryParse(value) ?? 0.0;
                    setState(() {});
                  },
                ),
                QMemoField(
                  label: "Notes",
                  value: notes,
                  hint: "Additional notes or terms",
                  onChanged: (value) {
                    notes = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
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
                    QButton(
                      label: "Add Item",
                      size: bs.sm,
                      icon: Icons.add,
                      onPressed: () {
                        // Add new invoice item
                        ss("Invoice item added");
                      },
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: disabledColor.withAlpha(50),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "Click 'Add Item' to start adding billable items, services, or expenses to this invoice.",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Save as Draft",
                  size: bs.md,
                  onPressed: () {
                    ss("Invoice saved as draft");
                    showCreateInvoice = false;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Create & Send",
                  size: bs.md,
                  icon: Icons.send,
                  onPressed: () {
                    ss("Invoice created and sent to client");
                    showCreateInvoice = false;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "paid":
        return successColor;
      case "sent":
        return primaryColor;
      case "overdue":
        return dangerColor;
      case "draft":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "paid":
        return Icons.check_circle;
      case "sent":
        return Icons.send;
      case "overdue":
        return Icons.warning;
      case "draft":
        return Icons.edit;
      default:
        return Icons.receipt;
    }
  }
}
