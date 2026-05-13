import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaBillingView extends StatefulWidget {
  const DlaBillingView({super.key});

  @override
  State<DlaBillingView> createState() => _DlaBillingViewState();
}

class _DlaBillingViewState extends State<DlaBillingView> {
  String selectedPeriod = "current_month";
  String selectedStatus = "all";
  String searchQuery = "";
  
  final List<Map<String, dynamic>> periodOptions = [
    {"label": "Current Month", "value": "current_month"},
    {"label": "Last Month", "value": "last_month"},
    {"label": "Last 3 Months", "value": "last_3_months"},
    {"label": "Last 6 Months", "value": "last_6_months"},
    {"label": "This Year", "value": "this_year"},
  ];

  final List<Map<String, dynamic>> statusOptions = [
    {"label": "All Statuses", "value": "all"},
    {"label": "Pending", "value": "pending"},
    {"label": "Paid", "value": "paid"},
    {"label": "Overdue", "value": "overdue"},
    {"label": "Cancelled", "value": "cancelled"},
  ];

  final List<Map<String, dynamic>> billingData = [
    {
      "id": "BILL-2024-001",
      "client": "ABC Logistics",
      "amount": 15450.00,
      "status": "paid",
      "due_date": "2024-01-15",
      "invoice_date": "2024-01-01",
      "services": ["Express Delivery", "Warehouse Storage"],
      "payment_method": "Bank Transfer",
    },
    {
      "id": "BILL-2024-002", 
      "client": "XYZ Corporation",
      "amount": 28750.00,
      "status": "pending",
      "due_date": "2024-01-20",
      "invoice_date": "2024-01-05",
      "services": ["Standard Delivery", "Packaging"],
      "payment_method": "Credit Card",
    },
    {
      "id": "BILL-2024-003",
      "client": "Global Trading Co",
      "amount": 5890.00,
      "status": "overdue",
      "due_date": "2024-01-10",
      "invoice_date": "2023-12-25",
      "services": ["Same Day Delivery"],
      "payment_method": "Cash",
    },
    {
      "id": "BILL-2024-004",
      "client": "Tech Solutions Inc",
      "amount": 42100.00,
      "status": "paid",
      "due_date": "2024-01-25",
      "invoice_date": "2024-01-10",
      "services": ["Express Delivery", "Insurance", "Tracking"],
      "payment_method": "Bank Transfer",
    },
  ];

  Widget _buildSummaryCards() {
    double totalAmount = billingData.fold(0.0, (sum, bill) => sum + (bill["amount"] as double));
    double paidAmount = billingData.where((bill) => bill["status"] == "paid").fold(0.0, (sum, bill) => sum + (bill["amount"] as double));
    double pendingAmount = billingData.where((bill) => bill["status"] == "pending").fold(0.0, (sum, bill) => sum + (bill["amount"] as double));
    double overdueAmount = billingData.where((bill) => bill["status"] == "overdue").fold(0.0, (sum, bill) => sum + (bill["amount"] as double));

    return Row(
      spacing: spSm,
      children: [
        _buildSummaryCard("Total Billing", totalAmount, primaryColor, Icons.receipt_long),
        _buildSummaryCard("Paid", paidAmount, successColor, Icons.check_circle),
        _buildSummaryCard("Pending", pendingAmount, warningColor, Icons.pending),
        _buildSummaryCard("Overdue", overdueAmount, dangerColor, Icons.warning),
      ],
    );
  }

  Widget _buildSummaryCard(String title, double amount, Color color, IconData icon) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
          border: Border(
            left: BorderSide(
              width: 4,
              color: color,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spSm,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 20),
                Spacer(),
                Icon(Icons.trending_up, color: successColor, size: 16),
              ],
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "\$${amount.currency}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters() {
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
              Expanded(
                child: QTextField(
                  label: "Search bills...",
                  value: searchQuery,
                  hint: "Search by client, ID, or amount",
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
                  si("Searching bills...");
                },
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
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

  Color _getStatusColor(String status) {
    switch (status) {
      case "paid":
        return successColor;
      case "pending":
        return warningColor;
      case "overdue":
        return dangerColor;
      case "cancelled":
        return disabledBoldColor;
      default:
        return primaryColor;
    }
  }

  Widget _buildBillItem(Map<String, dynamic> bill) {
    Color statusColor = _getStatusColor(bill["status"]);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
        ),
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
                      "${bill["id"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${bill["client"]}",
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
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${bill["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.attach_money, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "\$${(bill["amount"] as double).currency}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Icon(Icons.calendar_today, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "Due: ${bill["due_date"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Text(
            "Services: ${(bill["services"] as List).join(", ")}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Row(
            children: [
              Icon(Icons.payment, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "${bill["payment_method"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "View Details",
                size: bs.sm,
                onPressed: () {
                  si("Viewing bill details for ${bill["id"]}");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Billing Management"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {
              si("Create new bill");
            },
          ),
          QButton(
            icon: Icons.download,
            size: bs.sm,
            onPressed: () {
              si("Export billing report");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildSummaryCards(),
            _buildFilters(),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Recent Bills",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ),
            ...billingData.map((bill) => _buildBillItem(bill)),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Load More Bills",
                color: disabledBoldColor,
                size: bs.md,
                onPressed: () {
                  si("Loading more bills...");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
