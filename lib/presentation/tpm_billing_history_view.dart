import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmBillingHistoryView extends StatefulWidget {
  const TpmBillingHistoryView({super.key});

  @override
  State<TpmBillingHistoryView> createState() => _TpmBillingHistoryViewState();
}

class _TpmBillingHistoryViewState extends State<TpmBillingHistoryView> {
  String selectedYear = "2025";
  String selectedStatus = "All";
  
  List<Map<String, dynamic>> yearOptions = [
    {"label": "2025", "value": "2025"},
    {"label": "2024", "value": "2024"},
    {"label": "2023", "value": "2023"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Paid", "value": "Paid"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Failed", "value": "Failed"},
    {"label": "Refunded", "value": "Refunded"},
  ];

  List<Map<String, dynamic>> billingHistory = [
    {
      "id": "INV-2025-001",
      "date": "2025-06-19",
      "description": "Professional Plan - Monthly",
      "amount": 29.00,
      "status": "Paid",
      "paymentMethod": "•••• 4242",
      "dueDate": "2025-06-19",
      "paidDate": "2025-06-19",
    },
    {
      "id": "INV-2025-002",
      "date": "2025-05-19",
      "description": "Professional Plan - Monthly",
      "amount": 29.00,
      "status": "Paid",
      "paymentMethod": "•••• 4242",
      "dueDate": "2025-05-19",
      "paidDate": "2025-05-19",
    },
    {
      "id": "INV-2025-003",
      "date": "2025-04-19",
      "description": "Professional Plan - Monthly",
      "amount": 29.00,
      "status": "Paid",
      "paymentMethod": "•••• 4242",
      "dueDate": "2025-04-19",
      "paidDate": "2025-04-19",
    },
    {
      "id": "INV-2025-004",
      "date": "2025-03-19",
      "description": "Professional Plan - Monthly",
      "amount": 29.00,
      "status": "Failed",
      "paymentMethod": "•••• 1234",
      "dueDate": "2025-03-19",
      "paidDate": null,
    },
    {
      "id": "INV-2025-005",
      "date": "2025-02-19",
      "description": "Professional Plan - Monthly",
      "amount": 29.00,
      "status": "Refunded",
      "paymentMethod": "•••• 4242",
      "dueDate": "2025-02-19",
      "paidDate": "2025-02-19",
    },
    {
      "id": "INV-2025-006",
      "date": "2025-01-19",
      "description": "Professional Plan - Monthly",
      "amount": 29.00,
      "status": "Paid",
      "paymentMethod": "•••• 4242",
      "dueDate": "2025-01-19",
      "paidDate": "2025-01-19",
    },
  ];

  Map<String, dynamic> billingSummary = {
    "totalPaid": 145.00,
    "totalRefunded": 29.00,
    "totalFailed": 29.00,
    "totalInvoices": 6,
  };

  List<Map<String, dynamic>> get filteredHistory {
    return billingHistory.where((invoice) {
      bool yearMatch = DateTime.parse(invoice["date"]).year.toString() == selectedYear;
      bool statusMatch = selectedStatus == "All" || invoice["status"] == selectedStatus;
      return yearMatch && statusMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Billing History"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: _exportBillingHistory,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildSummaryCards(),
            _buildFiltersSection(),
            _buildBillingHistoryList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCards() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildSummaryCard(
          title: "Total Paid",
          value: "\$${((billingSummary["totalPaid"] as num).toDouble()).currency}",
          icon: Icons.paid,
          color: successColor,
        ),
        _buildSummaryCard(
          title: "Total Refunded",
          value: "\$${((billingSummary["totalRefunded"] as num).toDouble()).currency}",
          icon: Icons.undo,
          color: warningColor,
        ),
        _buildSummaryCard(
          title: "Failed Payments",
          value: "\$${((billingSummary["totalFailed"] as num).toDouble()).currency}",
          icon: Icons.error,
          color: dangerColor,
        ),
        _buildSummaryCard(
          title: "Total Invoices",
          value: "${billingSummary["totalInvoices"]}",
          icon: Icons.receipt,
          color: primaryColor,
        ),
      ],
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
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
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              Spacer(),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFiltersSection() {
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
          Text(
            "Filters",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Year",
                  items: yearOptions,
                  value: selectedYear,
                  onChanged: (value, label) {
                    selectedYear = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
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
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBillingHistoryList() {
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
            children: [
              Expanded(
                child: Text(
                  "Invoice History",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Text(
                "${filteredHistory.length} invoices",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          if (filteredHistory.isEmpty) ...[
            Container(
              padding: EdgeInsets.all(spLg),
              child: Column(
                children: [
                  Icon(
                    Icons.receipt_long,
                    size: 48,
                    color: disabledColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "No invoices found",
                    style: TextStyle(
                      fontSize: 16,
                      color: disabledBoldColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Try adjusting your filters",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            ...filteredHistory.map((invoice) => _buildInvoiceCard(invoice)),
          ],
        ],
      ),
    );
  }

  Widget _buildInvoiceCard(Map<String, dynamic> invoice) {
    Color statusColor = _getStatusColor(invoice["status"]);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
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
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${invoice["status"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: statusColor,
                    fontWeight: FontWeight.w600,
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
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 14,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Due: ${DateTime.parse(invoice["dueDate"]).dMMMy}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    if (invoice["paidDate"] != null) ...[
                      Row(
                        children: [
                          Icon(
                            Icons.payment,
                            size: 14,
                            color: successColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Paid: ${DateTime.parse(invoice["paidDate"]).dMMMy}",
                            style: TextStyle(
                              fontSize: 11,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                    Row(
                      children: [
                        Icon(
                          Icons.credit_card,
                          size: 14,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${invoice["paymentMethod"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "\$${((invoice["amount"] as num).toDouble()).currency}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      QButton(
                        icon: Icons.download,
                        size: bs.sm,
                        onPressed: () {
                          _downloadInvoice(invoice["id"]);
                        },
                      ),
                      SizedBox(width: spXs),
                      QButton(
                        icon: Icons.visibility,
                        size: bs.sm,
                        onPressed: () {
                          _viewInvoiceDetails(invoice);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Paid":
        return successColor;
      case "Pending":
        return warningColor;
      case "Failed":
        return dangerColor;
      case "Refunded":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  void _exportBillingHistory() {
    si("Exporting billing history as CSV...");
  }

  void _downloadInvoice(String invoiceId) {
    si("Downloading invoice $invoiceId...");
  }

  void _viewInvoiceDetails(Map<String, dynamic> invoice) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Invoice Details"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow("Invoice ID", "${invoice["id"]}"),
            _buildDetailRow("Description", "${invoice["description"]}"),
            _buildDetailRow("Amount", "\$${((invoice["amount"] as num).toDouble()).currency}"),
            _buildDetailRow("Status", "${invoice["status"]}"),
            _buildDetailRow("Due Date", "${DateTime.parse(invoice["dueDate"]).dMMMy}"),
            if (invoice["paidDate"] != null)
              _buildDetailRow("Paid Date", "${DateTime.parse(invoice["paidDate"]).dMMMy}"),
            _buildDetailRow("Payment Method", "${invoice["paymentMethod"]}"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _downloadInvoice(invoice["id"]);
            },
            child: Text("Download"),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              "$label:",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: disabledBoldColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
