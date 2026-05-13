import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaInvoiceTrackingView extends StatefulWidget {
  const AbaInvoiceTrackingView({super.key});

  @override
  State<AbaInvoiceTrackingView> createState() => _AbaInvoiceTrackingViewState();
}

class _AbaInvoiceTrackingViewState extends State<AbaInvoiceTrackingView> {
  String searchQuery = "";
  String selectedStatus = "all";
  String selectedPeriod = "current_month";
  int currentTab = 0;

  List<Map<String, dynamic>> invoices = [
    {
      "id": "INV-2025-001",
      "client_name": "Smith Family",
      "patient_name": "Alex Smith",
      "amount": 2400.00,
      "date_issued": "2025-01-15",
      "due_date": "2025-02-15",
      "status": "sent",
      "services": "ABA Therapy - 20 hours",
      "insurance_claim": "BC12345",
      "payment_method": "Insurance + Copay",
      "notes": "Pending insurance approval"
    },
    {
      "id": "INV-2025-002",
      "client_name": "Johnson Family",
      "patient_name": "Emma Johnson",
      "amount": 1800.00,
      "date_issued": "2025-01-10",
      "due_date": "2025-02-10",
      "status": "paid",
      "services": "ABA Therapy - 15 hours",
      "insurance_claim": "BC12346",
      "payment_method": "Paid in Full",
      "notes": "Payment received via check"
    },
    {
      "id": "INV-2025-003",
      "client_name": "Williams Family",
      "patient_name": "Jordan Williams",
      "amount": 3200.00,
      "date_issued": "2025-01-08",
      "due_date": "2025-01-25",
      "status": "overdue",
      "services": "ABA Therapy - 25 hours",
      "insurance_claim": "BC12347",
      "payment_method": "Insurance + Copay",
      "notes": "Follow up needed"
    },
    {
      "id": "INV-2025-004",
      "client_name": "Brown Family",
      "patient_name": "Riley Brown",
      "amount": 2100.00,
      "date_issued": "2025-01-12",
      "due_date": "2025-02-12",
      "status": "draft",
      "services": "ABA Therapy - 18 hours",
      "insurance_claim": "BC12348",
      "payment_method": "Insurance + Copay",
      "notes": "Awaiting approval to send"
    },
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Invoices", "value": "all"},
    {"label": "Draft", "value": "draft"},
    {"label": "Sent", "value": "sent"},
    {"label": "Paid", "value": "paid"},
    {"label": "Overdue", "value": "overdue"},
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "Current Month", "value": "current_month"},
    {"label": "Last Month", "value": "last_month"},
    {"label": "Last 3 Months", "value": "last_3_months"},
    {"label": "This Year", "value": "this_year"},
    {"label": "All Time", "value": "all_time"},
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case 'paid':
        return successColor;
      case 'sent':
        return infoColor;
      case 'overdue':
        return dangerColor;
      case 'draft':
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case 'paid':
        return 'Paid';
      case 'sent':
        return 'Sent';
      case 'overdue':
        return 'Overdue';
      case 'draft':
        return 'Draft';
      default:
        return 'Unknown';
    }
  }

  List<Map<String, dynamic>> get filteredInvoices {
    return invoices.where((invoice) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${invoice["client_name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${invoice["patient_name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${invoice["id"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "all" || invoice["status"] == selectedStatus;
      
      return matchesSearch && matchesStatus;
    }).toList();
  }

  double get totalOutstanding {
    return filteredInvoices
        .where((invoice) => invoice["status"] != "paid")
        .fold(0.0, (sum, invoice) => sum + (invoice["amount"] as double));
  }

  double get totalPaid {
    return filteredInvoices
        .where((invoice) => invoice["status"] == "paid")
        .fold(0.0, (sum, invoice) => sum + (invoice["amount"] as double));
  }

  int get overdueCount {
    return filteredInvoices.where((invoice) => invoice["status"] == "overdue").length;
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Invoice Tracking",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "All Invoices", icon: Icon(Icons.receipt_long)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "Reports", icon: Icon(Icons.assessment)),
      ],
      tabChildren: [
        _buildInvoiceListTab(),
        _buildAnalyticsTab(),
        _buildReportsTab(),
      ],
    );
  }

  Widget _buildInvoiceListTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildSearchAndFilters(),
          _buildSummaryCards(),
          _buildInvoicesList(),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Column(
      spacing: spSm,
      children: [
        Row(
          children: [
            Expanded(
              child: QTextField(
                label: "Search invoices...",
                value: searchQuery,
                hint: "Client name, patient, or invoice ID",
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
              onPressed: () {},
            ),
          ],
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
                label: "Period",
                items: periodOptions,
                value: selectedPeriod,
                onChanged: (value, label) {
                  selectedPeriod = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSummaryCards() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildSummaryCard(
          "Total Outstanding",  
          "\$${totalOutstanding.currency}",
          Icons.account_balance_wallet,
          dangerColor,
        ),
        _buildSummaryCard(
          "Total Paid",
          "\$${totalPaid.currency}",
          Icons.payments,
          successColor,
        ),
        _buildSummaryCard(
          "Overdue Invoices",
          "$overdueCount",
          Icons.warning,
          warningColor,
        ),
        _buildSummaryCard(
          "Total Invoices",
          "${filteredInvoices.length}",
          Icons.receipt,
          infoColor,
        ),
      ],
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.trending_up,
                  color: color,
                  size: 16,
                ),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvoicesList() {
    return Column(
      spacing: spSm,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Recent Invoices",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            QButton(
              label: "New Invoice",
              icon: Icons.add,
              size: bs.sm,
              onPressed: () {},
            ),
          ],
        ),
        ...filteredInvoices.map((invoice) => _buildInvoiceCard(invoice)),
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
            color: _getStatusColor("${invoice["status"]}"),
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
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
                      "${invoice["client_name"]} - ${invoice["patient_name"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getStatusColor("${invoice["status"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  _getStatusLabel("${invoice["status"]}"),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor("${invoice["status"]}"),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "Amount: \$${(invoice["amount"] as double).currency}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Due: ${invoice["due_date"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${invoice["services"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                spacing: spXs,
                children: [
                  QButton(
                    icon: Icons.visibility,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                  QButton(
                    icon: Icons.edit,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
          if ("${invoice["notes"]}".isNotEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: infoColor,
                    size: 16,
                  ),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "${invoice["notes"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: infoColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildAnalyticsHeader(),
          _buildRevenueAnalytics(),
          _buildInvoiceStatusAnalytics(),
        ],
      ),
    );
  }

  Widget _buildAnalyticsHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Row(
        children: [
          Icon(
            Icons.analytics,
            color: primaryColor,
            size: 32,
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "Invoice Analytics",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Track your billing performance and revenue trends",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRevenueAnalytics() {
    double totalRevenue = invoices.fold(0.0, (sum, invoice) => sum + (invoice["amount"] as double));
    double avgInvoiceAmount = totalRevenue / invoices.length;
    
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
            "Revenue Analytics",
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
              _buildAnalyticsCard(
                "Total Revenue",
                "\$${totalRevenue.currency}",
                Icons.attach_money,
                successColor,
                "+12.5%",
              ),
              _buildAnalyticsCard(
                "Average Invoice",
                "\$${avgInvoiceAmount.currency}",
                Icons.receipt,
                infoColor,
                "+8.2%",
              ),
              _buildAnalyticsCard(
                "Collection Rate",
                "94.2%",
                Icons.trending_up,
                successColor,
                "+2.1%",
              ),
              _buildAnalyticsCard(
                "Avg. Payment Time",
                "18 days",
                Icons.schedule,
                warningColor,
                "-3 days",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsCard(String title, String value, IconData icon, Color color, String change) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: color.withAlpha(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              Text(
                change,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: change.startsWith('+') ? successColor : dangerColor,
                ),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvoiceStatusAnalytics() {
    int draftCount = invoices.where((inv) => inv["status"] == "draft").length;
    int sentCount = invoices.where((inv) => inv["status"] == "sent").length;
    int paidCount = invoices.where((inv) => inv["status"] == "paid").length;
    int overdueCount = invoices.where((inv) => inv["status"] == "overdue").length;
    
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
            "Invoice Status Distribution",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Column(
            spacing: spSm,
            children: [
              _buildStatusProgressBar("Draft", draftCount, invoices.length, warningColor),
              _buildStatusProgressBar("Sent", sentCount, invoices.length, infoColor),
              _buildStatusProgressBar("Paid", paidCount, invoices.length, successColor),
              _buildStatusProgressBar("Overdue", overdueCount, invoices.length, dangerColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusProgressBar(String status, int count, int total, Color color) {
    double percentage = total > 0 ? (count / total) * 100 : 0;
    
    return Column(
      spacing: spXs,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              status,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            Text(
              "$count (${percentage.toStringAsFixed(1)}%)",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
        Container(
          height: 8,
          decoration: BoxDecoration(
            color: disabledColor,
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: percentage / 100,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(radiusLg),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildReportsHeader(),
          _buildQuickReports(),
          _buildCustomReports(),
        ],
      ),
    );
  }

  Widget _buildReportsHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: infoColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Row(
        children: [
          Icon(
            Icons.assessment,
            color: infoColor,
            size: 32,
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "Invoice Reports",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Generate detailed reports for accounting and analysis",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickReports() {
    List<Map<String, dynamic>> quickReports = [
      {
        "title": "Monthly Revenue Report",
        "description": "Revenue breakdown by month with comparisons",
        "icon": Icons.calendar_month,
        "color": successColor,
        "period": "January 2025"
      },
      {
        "title": "Outstanding Invoices",
        "description": "All unpaid invoices with aging analysis",
        "icon": Icons.warning,
        "color": warningColor,
        "period": "Current"
      },
      {
        "title": "Client Billing Summary",
        "description": "Billing totals by client and patient",
        "icon": Icons.people,
        "color": infoColor,
        "period": "Last 3 months"
      },
      {
        "title": "Payment Method Analysis",
        "description": "Payment methods and processing times",
        "icon": Icons.payment,
        "color": primaryColor,
        "period": "YTD"
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Quick Reports",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...quickReports.map((report) => _buildQuickReportCard(report)),
      ],
    );
  }

  Widget _buildQuickReportCard(Map<String, dynamic> report) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: (report["color"] as Color).withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Icon(
              report["icon"] as IconData,
              color: report["color"] as Color,
              size: 24,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "${report["title"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${report["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "Period: ${report["period"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: report["color"] as Color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Column(
            spacing: spXs,
            children: [
              QButton(
                icon: Icons.visibility,
                size: bs.sm,
                onPressed: () {},
              ),
              QButton(
                icon: Icons.download,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCustomReports() {
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
            "Custom Report Builder",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "Create custom reports with specific date ranges, clients, and metrics",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Build Custom Report",
                  icon: Icons.build,
                  size: bs.md,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.history,
                size: bs.md,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
