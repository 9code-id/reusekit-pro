import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaOverdueInvoicesView extends StatefulWidget {
  const AbaOverdueInvoicesView({super.key});

  @override
  State<AbaOverdueInvoicesView> createState() => _AbaOverdueInvoicesViewState();
}

class _AbaOverdueInvoicesViewState extends State<AbaOverdueInvoicesView> {
  String searchQuery = "";
  String selectedOverdueRange = "All";
  String selectedClient = "All";
  String sortBy = "due_date";
  bool sortAscending = false;

  final List<Map<String, dynamic>> overdueRanges = [
    {"label": "All", "value": "All"},
    {"label": "1-30 days", "value": "1-30"},
    {"label": "31-60 days", "value": "31-60"},
    {"label": "61-90 days", "value": "61-90"},
    {"label": "90+ days", "value": "90+"},
  ];

  final List<Map<String, dynamic>> clients = [
    {"label": "All", "value": "All"},
    {"label": "Tech Solutions Inc", "value": "tech_solutions"},
    {"label": "Global Marketing LLC", "value": "global_marketing"},
    {"label": "StartupHub Co", "value": "startup_hub"},
    {"label": "Design Studio Plus", "value": "design_studio"},
    {"label": "Consulting Group", "value": "consulting_group"},
  ];

  final List<Map<String, dynamic>> sortOptions = [
    {"label": "Due Date", "value": "due_date"},
    {"label": "Amount", "value": "amount"},
    {"label": "Days Overdue", "value": "days_overdue"},
    {"label": "Client Name", "value": "client_name"},
  ];

  List<Map<String, dynamic>> overdueInvoices = [
    {
      "id": "INV-2024-001",
      "client_name": "Tech Solutions Inc",
      "client_email": "finance@techsolutions.com",
      "client_phone": "+1 (555) 123-4567",
      "amount": 2500.00,
      "due_date": "2024-05-15",
      "days_overdue": 35,
      "issue_date": "2024-04-15",
      "status": "overdue",
      "priority": "high",
      "reminder_count": 3,
      "last_reminder": "2024-06-10",
      "description": "Website Development Project - Phase 2",
      "late_fee": 125.00,
      "total_due": 2625.00,
    },
    {
      "id": "INV-2024-002",
      "client_name": "Global Marketing LLC",
      "client_email": "accounts@globalmarketing.com",
      "client_phone": "+1 (555) 234-5678",
      "amount": 1800.00,
      "due_date": "2024-05-28",
      "days_overdue": 22,
      "issue_date": "2024-04-28",
      "status": "overdue",
      "priority": "medium",
      "reminder_count": 2,
      "last_reminder": "2024-06-08",
      "description": "SEO Campaign Management - Q2 2024",
      "late_fee": 90.00,
      "total_due": 1890.00,
    },
    {
      "id": "INV-2024-003",
      "client_name": "StartupHub Co",
      "client_email": "billing@startuphub.co",
      "client_phone": "+1 (555) 345-6789",
      "amount": 950.00,
      "due_date": "2024-04-20",
      "days_overdue": 61,
      "issue_date": "2024-03-20",
      "status": "overdue",
      "priority": "high",
      "reminder_count": 4,
      "last_reminder": "2024-06-05",
      "description": "Brand Identity Design Package",
      "late_fee": 190.00,
      "total_due": 1140.00,
    },
    {
      "id": "INV-2024-004",
      "client_name": "Design Studio Plus",
      "client_email": "payments@designstudio.plus",
      "client_phone": "+1 (555) 456-7890",
      "amount": 3200.00,
      "due_date": "2024-03-10",
      "days_overdue": 101,
      "issue_date": "2024-02-10",
      "status": "overdue",
      "priority": "critical",
      "reminder_count": 6,
      "last_reminder": "2024-06-12",
      "description": "Mobile App UI/UX Design - Complete Package",
      "late_fee": 640.00,
      "total_due": 3840.00,
    },
    {
      "id": "INV-2024-005",
      "client_name": "Consulting Group",
      "client_email": "finance@consultinggroup.net",
      "client_phone": "+1 (555) 567-8901",
      "amount": 1200.00,
      "due_date": "2024-06-01",
      "days_overdue": 18,
      "issue_date": "2024-05-01",
      "status": "overdue",
      "priority": "low",
      "reminder_count": 1,
      "last_reminder": "2024-06-15",
      "description": "Business Strategy Consultation - Phase 1",
      "late_fee": 60.00,
      "total_due": 1260.00,
    },
  ];

  List<Map<String, dynamic>> get filteredInvoices {
    List<Map<String, dynamic>> filtered = overdueInvoices.where((invoice) {
      bool matchesSearch = invoice["client_name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          invoice["id"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          invoice["description"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesClient = selectedClient == "All" || 
          invoice["client_name"].toString().toLowerCase().contains(selectedClient.toLowerCase());
      
      bool matchesRange = selectedOverdueRange == "All" || _matchesOverdueRange(invoice);
      
      return matchesSearch && matchesClient && matchesRange;
    }).toList();

    // Sort the filtered list
    filtered.sort((a, b) {
      dynamic aValue = a[sortBy];
      dynamic bValue = b[sortBy];
      
      int comparison;
      if (aValue is String && bValue is String) {
        comparison = aValue.compareTo(bValue);
      } else if (aValue is num && bValue is num) {
        comparison = aValue.compareTo(bValue);
      } else {
        comparison = aValue.toString().compareTo(bValue.toString());
      }
      
      return sortAscending ? comparison : -comparison;
    });

    return filtered;
  }

  bool _matchesOverdueRange(Map<String, dynamic> invoice) {
    int daysOverdue = invoice["days_overdue"];
    switch (selectedOverdueRange) {
      case "1-30":
        return daysOverdue >= 1 && daysOverdue <= 30;
      case "31-60":
        return daysOverdue >= 31 && daysOverdue <= 60;
      case "61-90":
        return daysOverdue >= 61 && daysOverdue <= 90;
      case "90+":
        return daysOverdue > 90;
      default:
        return true;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'critical':
        return dangerColor;
      case 'high':
        return warningColor;
      case 'medium':
        return infoColor;
      case 'low':
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getPriorityLabel(String priority) {
    return priority.toUpperCase();
  }

  Widget _buildOverviewCard() {
    double totalOverdue = overdueInvoices.fold(0.0, (sum, invoice) => sum + (invoice["total_due"] as num).toDouble());
    int totalCount = overdueInvoices.length;
    double averageOverdue = totalCount > 0 ? totalOverdue / totalCount : 0.0;
    
    int critical = overdueInvoices.where((i) => i["priority"] == "critical").length;
    int high = overdueInvoices.where((i) => i["priority"] == "high").length;
    int medium = overdueInvoices.where((i) => i["priority"] == "medium").length;
    int low = overdueInvoices.where((i) => i["priority"] == "low").length;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Overdue Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildSummaryItem("Total Amount", "\$${totalOverdue.currency}", dangerColor, Icons.money_off),
              _buildSummaryItem("Invoice Count", "$totalCount", warningColor, Icons.receipt_long),
              _buildSummaryItem("Average Amount", "\$${averageOverdue.currency}", infoColor, Icons.calculate),
              _buildSummaryItem("Oldest Overdue", "${overdueInvoices.isNotEmpty ? overdueInvoices.map((i) => i["days_overdue"]).reduce((a, b) => a > b ? a : b) : 0} days", dangerColor, Icons.schedule),
            ],
          ),
          Divider(),
          Text(
            "Priority Breakdown",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Column(
            spacing: spSm,
            children: [
              _buildPriorityRow("Critical", critical, dangerColor),
              _buildPriorityRow("High", high, warningColor),
              _buildPriorityRow("Medium", medium, infoColor),
              _buildPriorityRow("Low", low, successColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String title, String value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriorityRow(String priority, int count, Color color) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radiusXs),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Text(
            priority,
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          "$count",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildInvoiceCard(Map<String, dynamic> invoice) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getPriorityColor(invoice["priority"]),
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${invoice["id"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: _getPriorityColor(invoice["priority"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            _getPriorityLabel(invoice["priority"]),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: _getPriorityColor(invoice["priority"]),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${invoice["client_name"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                spacing: spXs,
                children: [
                  Text(
                    "\$${(invoice["total_due"] as num).toDouble().currency}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: dangerColor,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: dangerColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${invoice["days_overdue"]} days overdue",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: dangerColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              "${invoice["description"]}",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ),
          Row(
            children: [
              Icon(Icons.schedule, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Due: ${invoice["due_date"]}",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
              SizedBox(width: spMd),
              Icon(Icons.notifications, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${invoice["reminder_count"]} reminders sent",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
            ],
          ),
          if ((invoice["late_fee"] as num) > 0) ...[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning, size: 16, color: warningColor),
                  SizedBox(width: spSm),
                  Text(
                    "Late fee applied: \$${(invoice["late_fee"] as num).toDouble().currency}",
                    style: TextStyle(
                      fontSize: 14,
                      color: warningColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Send Reminder",
                  size: bs.sm,
                  onPressed: () => _sendReminder(invoice),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Call Client",
                  size: bs.sm,
                  onPressed: () => _callClient(invoice),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showInvoiceActions(invoice),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _sendReminder(Map<String, dynamic> invoice) async {
    bool isConfirmed = await confirm("Send payment reminder to ${invoice["client_name"]}?");
    if (isConfirmed) {
      ss("Payment reminder sent to ${invoice["client_name"]}");
      // Update reminder count
      invoice["reminder_count"] = (invoice["reminder_count"] as int) + 1;
      invoice["last_reminder"] = DateTime.now().toString().substring(0, 10);
      setState(() {});
    }
  }

  void _callClient(Map<String, dynamic> invoice) {
    ss("Calling ${invoice["client_name"]} at ${invoice["client_phone"]}");
    // In a real app, this would integrate with the phone dialer
  }

  void _showInvoiceActions(Map<String, dynamic> invoice) {
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
                color: primaryColor,
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.visibility),
              title: Text("View Invoice"),
              onTap: () {
                Navigator.pop(context);
                _viewInvoice(invoice);
              },
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text("Edit Invoice"),
              onTap: () {
                Navigator.pop(context);
                _editInvoice(invoice);
              },
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text("Email Client"),
              onTap: () {
                Navigator.pop(context);
                _emailClient(invoice);
              },
            ),
            ListTile(
              leading: Icon(Icons.payment),
              title: Text("Record Payment"),
              onTap: () {
                Navigator.pop(context);
                _recordPayment(invoice);
              },
            ),
            ListTile(
              leading: Icon(Icons.cancel, color: dangerColor),
              title: Text("Write Off", style: TextStyle(color: dangerColor)),
              onTap: () {
                Navigator.pop(context);
                _writeOffInvoice(invoice);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _viewInvoice(Map<String, dynamic> invoice) {
    si("Viewing invoice ${invoice["id"]}");
    // Navigate to invoice detail view
  }

  void _editInvoice(Map<String, dynamic> invoice) {
    si("Editing invoice ${invoice["id"]}");
    // Navigate to edit invoice view
  }

  void _emailClient(Map<String, dynamic> invoice) {
    ss("Email sent to ${invoice["client_email"]}");
  }

  void _recordPayment(Map<String, dynamic> invoice) {
    si("Recording payment for invoice ${invoice["id"]}");
    // Navigate to payment recording screen
  }

  void _writeOffInvoice(Map<String, dynamic> invoice) async {
    bool isConfirmed = await confirm("Are you sure you want to write off invoice ${invoice["id"]}? This action cannot be undone.");
    if (isConfirmed) {
      se("Invoice ${invoice["id"]} has been written off");
      // Remove from overdue list
      overdueInvoices.remove(invoice);
      setState(() {});
    }
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Filter & Sort"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spMd,
          children: [
            QDropdownField(
              label: "Overdue Range",
              items: overdueRanges,
              value: selectedOverdueRange,
              onChanged: (value, label) {
                selectedOverdueRange = value;
                setState(() {});
              },
            ),
            QDropdownField(
              label: "Client",
              items: clients,
              value: selectedClient,
              onChanged: (value, label) {
                selectedClient = value;
                setState(() {});
              },
            ),
            QDropdownField(
              label: "Sort By",
              items: sortOptions,
              value: sortBy,
              onChanged: (value, label) {
                sortBy = value;
                setState(() {});
              },
            ),
            QSwitch(
              items: [
                {
                  "label": "Sort Ascending",
                  "value": true,
                  "checked": sortAscending,
                }
              ],
              value: [
                if (sortAscending)
                  {
                    "label": "Sort Ascending",
                    "value": true,
                    "checked": true
                  }
              ],
              onChanged: (values, ids) {
                setState(() {
                  sortAscending = values.isNotEmpty;
                });
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              selectedOverdueRange = "All";
              selectedClient = "All";
              sortBy = "due_date";
              sortAscending = false;
              setState(() {});
              Navigator.pop(context);
            },
            child: Text("Clear"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Apply"),
          ),
        ],
      ),
    );
  }

  void _bulkAction() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Bulk Actions"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            ListTile(
              leading: Icon(Icons.email),
              title: Text("Send Reminders to All"),
              onTap: () {
                Navigator.pop(context);
                _sendBulkReminders();
              },
            ),
            ListTile(
              leading: Icon(Icons.file_download),
              title: Text("Export Overdue Report"),
              onTap: () {
                Navigator.pop(context);
                _exportReport();
              },
            ),
            ListTile(
              leading: Icon(Icons.schedule),
              title: Text("Schedule Follow-ups"),
              onTap: () {
                Navigator.pop(context);
                _scheduleFollowups();
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }

  void _sendBulkReminders() async {
    bool isConfirmed = await confirm("Send payment reminders to all overdue clients?");
    if (isConfirmed) {
      ss("Bulk reminders sent to ${overdueInvoices.length} clients");
      // Update reminder counts for all invoices
      for (var invoice in overdueInvoices) {
        invoice["reminder_count"] = (invoice["reminder_count"] as int) + 1;
        invoice["last_reminder"] = DateTime.now().toString().substring(0, 10);
      }
      setState(() {});
    }
  }

  void _exportReport() {
    ss("Overdue invoices report exported successfully");
  }

  void _scheduleFollowups() {
    si("Follow-up tasks scheduled for all overdue invoices");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Overdue Invoices"),
        actions: [
          IconButton(
            icon: Icon(Icons.more_horiz),
            onPressed: _bulkAction,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildOverviewCard(),
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search overdue invoices...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.filter_list,
                  size: bs.sm,
                  onPressed: _showFilterDialog,
                ),
              ],
            ),
            if (filteredInvoices.isNotEmpty) ...[
              Column(
                spacing: spSm,
                children: filteredInvoices.map((invoice) => _buildInvoiceCard(invoice)).toList(),
              ),
            ] else ...[
              Container(
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 64,
                      color: successColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No overdue invoices found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "All invoices are up to date!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
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
