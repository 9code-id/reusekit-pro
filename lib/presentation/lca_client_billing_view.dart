import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaClientBillingView extends StatefulWidget {
  const LcaClientBillingView({super.key});

  @override
  State<LcaClientBillingView> createState() => _LcaClientBillingViewState();
}

class _LcaClientBillingViewState extends State<LcaClientBillingView> {
  int selectedTab = 0;
  bool loading = false;
  String selectedClient = "all";
  String selectedPeriod = "month";
  String invoiceStatus = "all";

  List<Map<String, dynamic>> clientOptions = [
    {"label": "All Clients", "value": "all"},
    {"label": "Sarah Johnson", "value": "sarah_johnson"},
    {"label": "Michael Chen", "value": "michael_chen"},
    {"label": "Emma Wilson", "value": "emma_wilson"},
    {"label": "David Rodriguez", "value": "david_rodriguez"},
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Month", "value": "month"},
    {"label": "This Quarter", "value": "quarter"},
    {"label": "This Year", "value": "year"},
    {"label": "All Time", "value": "all"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Draft", "value": "draft"},
    {"label": "Sent", "value": "sent"},
    {"label": "Paid", "value": "paid"},
    {"label": "Overdue", "value": "overdue"},
  ];

  List<Map<String, dynamic>> invoices = [
    {
      "id": "INV-2024-001",
      "clientName": "Sarah Johnson",
      "clientId": "sarah_johnson",
      "issueDate": "2024-06-01",
      "dueDate": "2024-06-30",
      "amount": 4500.0,
      "paidAmount": 4500.0,
      "status": "paid",
      "description": "Contract Review and Legal Consultation",
      "hours": 15.0,
      "hourlyRate": 300.0,
      "expenses": 0.0,
      "taxRate": 0.0875,
    },
    {
      "id": "INV-2024-002",
      "clientName": "Michael Chen",
      "clientId": "michael_chen",
      "issueDate": "2024-06-10",
      "dueDate": "2024-07-10",
      "amount": 2800.0,
      "paidAmount": 0.0,
      "status": "sent",
      "description": "IP Protection Services",
      "hours": 8.0,
      "hourlyRate": 350.0,
      "expenses": 0.0,
      "taxRate": 0.0875,
    },
    {
      "id": "INV-2024-003",
      "clientName": "Emma Wilson",
      "clientId": "emma_wilson",
      "issueDate": "2024-06-15",
      "dueDate": "2024-07-15",
      "amount": 3200.0,
      "paidAmount": 1600.0,
      "status": "sent",
      "description": "Employment Law Consultation",
      "hours": 10.0,
      "hourlyRate": 320.0,
      "expenses": 0.0,
      "taxRate": 0.0875,
    },
    {
      "id": "INV-2024-004",
      "clientName": "David Rodriguez",
      "clientId": "david_rodriguez",
      "issueDate": "2024-05-15",
      "dueDate": "2024-06-15",
      "amount": 5600.0,
      "paidAmount": 0.0,
      "status": "overdue",
      "description": "Family Law - Divorce Proceedings",
      "hours": 18.0,
      "hourlyRate": 280.0,
      "expenses": 560.0,
      "taxRate": 0.0875,
    },
  ];

  List<Map<String, dynamic>> timeEntries = [
    {
      "id": "1",
      "clientName": "Sarah Johnson",
      "date": "2024-06-19",
      "description": "Contract review and client meeting",
      "hours": 2.5,
      "rate": 300.0,
      "billable": true,
      "status": "pending",
    },
    {
      "id": "2",
      "clientName": "Michael Chen",
      "date": "2024-06-19",
      "description": "Research patent filing requirements",
      "hours": 1.5,
      "rate": 350.0,
      "billable": true,
      "status": "pending",
    },
    {
      "id": "3",
      "clientName": "Emma Wilson",
      "date": "2024-06-18",
      "description": "Employee handbook review",
      "hours": 3.0,
      "rate": 320.0,
      "billable": true,
      "status": "invoiced",
    },
    {
      "id": "4",
      "clientName": "Internal",
      "date": "2024-06-18",
      "description": "Administrative tasks",
      "hours": 1.0,
      "rate": 0.0,
      "billable": false,
      "status": "completed",
    },
  ];

  List<Map<String, dynamic>> expenses = [
    {
      "id": "1",
      "clientName": "David Rodriguez",
      "date": "2024-06-15",
      "description": "Court filing fees",
      "amount": 350.0,
      "category": "Legal Fees",
      "billable": true,
      "status": "invoiced",
    },
    {
      "id": "2",
      "clientName": "Michael Chen",
      "date": "2024-06-12",
      "description": "Patent search database access",
      "amount": 150.0,
      "category": "Research",
      "billable": true,
      "status": "pending",
    },
    {
      "id": "3",
      "clientName": "Sarah Johnson",
      "date": "2024-06-10",
      "description": "Document preparation and notarization",
      "amount": 75.0,
      "category": "Documentation",
      "billable": true,
      "status": "pending",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Client Billing",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Invoices", icon: Icon(Icons.receipt)),
        Tab(text: "Time Tracking", icon: Icon(Icons.access_time)),
        Tab(text: "Expenses", icon: Icon(Icons.monetization_on)),
        Tab(text: "Reports", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildInvoicesTab(),
        _buildTimeTrackingTab(),
        _buildExpensesTab(),
        _buildReportsTab(),
      ],
    );
  }

  Widget _buildInvoicesTab() {
    return loading
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              spacing: spMd,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBillingStats(),
                _buildInvoiceFilters(),
                _buildInvoicesList(),
              ],
            ),
          );
  }

  Widget _buildTimeTrackingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildTimeEntryForm(),
          _buildTimeEntriesList(),
        ],
      ),
    );
  }

  Widget _buildExpensesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildExpenseForm(),
          _buildExpensesList(),
        ],
      ),
    );
  }

  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildRevenueOverview(),
          _buildBillingAnalytics(),
        ],
      ),
    );
  }

  Widget _buildBillingStats() {
    double totalRevenue = invoices.fold(0.0, (sum, inv) => sum + (inv["amount"] as double));
    double paidAmount = invoices.fold(0.0, (sum, inv) => sum + (inv["paidAmount"] as double));
    double pendingAmount = totalRevenue - paidAmount;
    int overdueCount = invoices.where((inv) => inv["status"] == "overdue").length;

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildStatCard("Total Revenue", "\$${totalRevenue.currency}", Icons.attach_money, primaryColor),
        _buildStatCard("Paid Amount", "\$${paidAmount.currency}", Icons.check_circle, successColor),
        _buildStatCard("Pending", "\$${pendingAmount.currency}", Icons.pending, warningColor),
        _buildStatCard("Overdue", overdueCount.toString(), Icons.warning, dangerColor),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
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
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(51),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
            ],
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvoiceFilters() {
    return Container(
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
              Icon(Icons.filter_list, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Invoice Filters",
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
              Expanded(
                child: QDropdownField(
                  label: "Client",
                  items: clientOptions,
                  value: selectedClient,
                  onChanged: (value, label) {
                    selectedClient = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Period",
                  items: periodOptions,
                  value: selectedPeriod,
                  onChanged: (value, label) {
                    selectedPeriod = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: statusOptions,
                  value: invoiceStatus,
                  onChanged: (value, label) {
                    invoiceStatus = value;
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

  Widget _buildInvoicesList() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
              Icon(Icons.receipt_long, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Invoices",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {
                  _showCreateInvoiceDialog();
                },
              ),
            ],
          ),
          ...invoices.map((invoice) => _buildInvoiceItem(invoice)).toList(),
        ],
      ),
    );
  }

  Widget _buildInvoiceItem(Map<String, dynamic> invoice) {
    Color statusColor = _getInvoiceStatusColor(invoice["status"]);
    double balanceAmount = (invoice["amount"] as double) - (invoice["paidAmount"] as double);

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(13),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
        ),
      ),
      child: Column(
        spacing: spXs,
        crossAxisAlignment: CrossAxisAlignment.start,
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
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${invoice["clientName"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "\$${((invoice["amount"] as double).toDouble()).currency}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${invoice["status"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(128),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "${invoice["description"]}",
              style: TextStyle(
                fontSize: 13,
                color: primaryColor,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Issue Date: ${invoice["issueDate"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Due Date: ${invoice["dueDate"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              if (balanceAmount > 0)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Paid: \$${((invoice["paidAmount"] as double).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Balance: \$${balanceAmount.currency}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: dangerColor,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  icon: Icons.visibility,
                  size: bs.sm,
                  onPressed: () {
                    _showInvoiceDetails(invoice);
                  },
                ),
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.download,
                size: bs.sm,
                onPressed: () {
                  si("Downloading invoice ${invoice["id"]}");
                },
              ),
              SizedBox(width: spXs),
              if (invoice["status"] != "paid")
                QButton(
                  icon: Icons.payment,
                  size: bs.sm,
                  onPressed: () {
                    _showPaymentDialog(invoice);
                  },
                ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  _showInvoiceMenu(invoice);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeEntryForm() {
    String client = "";
    String description = "";
    String hours = "";
    String date = DateTime.now().toString().split(' ')[0];

    return Container(
      padding: EdgeInsets.all(spSm),
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
              Icon(Icons.timer, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Log Time Entry",
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
              Expanded(
                child: QDropdownField(
                  label: "Client",
                  items: clientOptions.where((item) => item["value"] != "all").toList(),
                  value: client,
                  onChanged: (value, label) {
                    client = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDatePicker(
                  label: "Date",
                  value: DateTime.parse(date),
                  onChanged: (value) {
                    date = value.toString().split(' ')[0];
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QTextField(
            label: "Description",
            value: description,
            hint: "Describe the work performed",
            onChanged: (value) {
              description = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QNumberField(
                  label: "Hours",
                  value: hours,
                  hint: "e.g., 2.5",
                  onChanged: (value) {
                    hours = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Log Time",
                  icon: Icons.add_task,
                  size: bs.md,
                  onPressed: () {
                    if (client.isNotEmpty && description.isNotEmpty && hours.isNotEmpty) {
                      ss("Time entry logged successfully");
                      // Clear form and refresh
                      setState(() {});
                    } else {
                      se("Please fill in all fields");
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeEntriesList() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
            "Recent Time Entries",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...timeEntries.map((entry) => _buildTimeEntryItem(entry)).toList(),
        ],
      ),
    );
  }

  Widget _buildTimeEntryItem(Map<String, dynamic> entry) {
    Color statusColor = entry["status"] == "invoiced" ? successColor : 
                       entry["status"] == "pending" ? warningColor : disabledBoldColor;
    double amount = (entry["hours"] as double) * (entry["rate"] as double);

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(13),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${entry["clientName"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${entry["description"]}",
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${entry["date"]} • ${(entry["hours"] as double)}h",
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
              if (entry["billable"] as bool)
                Text(
                  "\$${amount.currency}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                )
              else
                Text(
                  "Non-billable",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${entry["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExpenseForm() {
    String client = "";
    String description = "";
    String amount = "";
    String category = "";

    return Container(
      padding: EdgeInsets.all(spSm),
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
              Icon(Icons.receipt, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Add Expense",
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
              Expanded(
                child: QDropdownField(
                  label: "Client",
                  items: clientOptions.where((item) => item["value"] != "all").toList(),
                  value: client,
                  onChanged: (value, label) {
                    client = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Category",
                  value: category,
                  hint: "e.g., Travel, Filing Fees",
                  onChanged: (value) {
                    category = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QTextField(
            label: "Description",
            value: description,
            onChanged: (value) {
              description = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QNumberField(
                  label: "Amount (\$)",
                  value: amount,
                  onChanged: (value) {
                    amount = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Add Expense",
                  icon: Icons.add,
                  size: bs.md,
                  onPressed: () {
                    if (client.isNotEmpty && description.isNotEmpty && amount.isNotEmpty) {
                      ss("Expense added successfully");
                      setState(() {});
                    } else {
                      se("Please fill in all fields");
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExpensesList() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
            "Recent Expenses",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...expenses.map((expense) => _buildExpenseItem(expense)).toList(),
        ],
      ),
    );
  }

  Widget _buildExpenseItem(Map<String, dynamic> expense) {
    Color statusColor = expense["status"] == "invoiced" ? successColor : warningColor;

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(13),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: statusColor.withAlpha(51),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(Icons.receipt_long, color: statusColor, size: 16),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${expense["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${expense["clientName"]} • ${expense["category"]}",
                  style: TextStyle(
                    fontSize: 13,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${expense["date"]}",
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
                "\$${((expense["amount"] as double).toDouble()).currency}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${expense["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRevenueOverview() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
            "Revenue Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(26),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.trending_up, color: primaryColor, size: 48),
                  SizedBox(height: spSm),
                  Text(
                    "Revenue Chart",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Interactive chart showing revenue trends",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBillingAnalytics() {
    return Container(
      padding: EdgeInsets.all(spSm),
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
            "Billing Analytics",
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
              _buildAnalyticsCard("Average Invoice", "\$3,275", Icons.receipt, primaryColor),
              _buildAnalyticsCard("Collection Rate", "87.3%", Icons.payments, successColor),
              _buildAnalyticsCard("Billable Hours", "156h", Icons.schedule, warningColor),
              _buildAnalyticsCard("Hourly Rate Avg", "\$312", Icons.monetization_on, infoColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(26),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Color _getInvoiceStatusColor(String status) {
    switch (status) {
      case "paid":
        return successColor;
      case "sent":
        return infoColor;
      case "overdue":
        return dangerColor;
      case "draft":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showCreateInvoiceDialog() {
    si("Create new invoice dialog");
  }

  void _showInvoiceDetails(Map<String, dynamic> invoice) {
    si("Showing details for ${invoice["id"]}");
  }

  void _showPaymentDialog(Map<String, dynamic> invoice) {
    si("Recording payment for ${invoice["id"]}");
  }

  void _showInvoiceMenu(Map<String, dynamic> invoice) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(100, 200, 0, 0),
      items: [
        PopupMenuItem(value: "edit", child: Text("Edit Invoice")),
        PopupMenuItem(value: "reminder", child: Text("Send Reminder")),
        PopupMenuItem(value: "paid", child: Text("Mark as Paid")),
        PopupMenuItem(value: "delete", child: Text("Delete")),
      ],
    ).then((value) {
      if (value != null) {
        si("Action: $value for ${invoice["id"]}");
      }
    });
  }
}
