import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaPaymentView extends StatefulWidget {
  const DlaPaymentView({super.key});

  @override
  State<DlaPaymentView> createState() => _DlaPaymentViewState();
}

class _DlaPaymentViewState extends State<DlaPaymentView> {
  String selectedPaymentMethod = "credit_card";
  String selectedPeriod = "this_month";
  String searchQuery = "";
  
  final List<Map<String, dynamic>> paymentMethods = [
    {"label": "Credit Card", "value": "credit_card"},
    {"label": "Bank Transfer", "value": "bank_transfer"},
    {"label": "Digital Wallet", "value": "digital_wallet"},
    {"label": "Cash", "value": "cash"},
    {"label": "Check", "value": "check"},
  ];

  final List<Map<String, dynamic>> periodOptions = [
    {"label": "This Month", "value": "this_month"},
    {"label": "Last Month", "value": "last_month"},
    {"label": "Last 3 Months", "value": "last_3_months"},
    {"label": "This Year", "value": "this_year"},
    {"label": "All Time", "value": "all_time"},
  ];

  final List<Map<String, dynamic>> paymentsData = [
    {
      "id": "PAY-2024-001",
      "invoice_id": "INV-2024-001",
      "client": "ABC Logistics",
      "amount": 15450.00,
      "method": "bank_transfer",
      "status": "completed",
      "date": "2024-01-15",
      "transaction_id": "TXN-ABC-001",
      "fee": 25.00,
    },
    {
      "id": "PAY-2024-002",
      "invoice_id": "INV-2024-002",
      "client": "XYZ Corporation",
      "amount": 28750.00,
      "method": "credit_card",
      "status": "processing",
      "date": "2024-01-16",
      "transaction_id": "TXN-XYZ-002",
      "fee": 862.50,
    },
    {
      "id": "PAY-2024-003",
      "invoice_id": "INV-2024-003",
      "client": "Global Trading Co",
      "amount": 5890.00,
      "method": "digital_wallet",
      "status": "failed",
      "date": "2024-01-14",
      "transaction_id": "TXN-GTC-003",
      "fee": 58.90,
    },
    {
      "id": "PAY-2024-004",
      "invoice_id": "INV-2024-004",
      "client": "Tech Solutions Inc",
      "amount": 42100.00,
      "method": "bank_transfer",
      "status": "completed",
      "date": "2024-01-17",
      "transaction_id": "TXN-TSI-004",
      "fee": 50.00,
    },
    {
      "id": "PAY-2024-005",
      "invoice_id": "INV-2024-005",
      "client": "Metro Delivery",
      "amount": 12350.00,
      "method": "cash",
      "status": "pending",
      "date": "2024-01-18",
      "transaction_id": "TXN-MDL-005",
      "fee": 0.00,
    },
  ];

  Widget _buildPaymentSummary() {
    double totalPayments = paymentsData.fold(0.0, (sum, payment) => sum + (payment["amount"] as double));
    double completedPayments = paymentsData.where((p) => p["status"] == "completed").fold(0.0, (sum, payment) => sum + (payment["amount"] as double));
    double pendingPayments = paymentsData.where((p) => p["status"] == "processing" || p["status"] == "pending").fold(0.0, (sum, payment) => sum + (payment["amount"] as double));
    double totalFees = paymentsData.fold(0.0, (sum, payment) => sum + (payment["fee"] as double));

    return Row(
      spacing: spSm,
      children: [
        _buildSummaryCard("Total Payments", totalPayments, primaryColor, Icons.payments),
        _buildSummaryCard("Completed", completedPayments, successColor, Icons.check_circle),
        _buildSummaryCard("Pending", pendingPayments, warningColor, Icons.pending),
        _buildSummaryCard("Total Fees", totalFees, infoColor, Icons.account_balance),
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

  Widget _buildPaymentMethodsChart() {
    Map<String, double> methodTotals = {};
    
    for (var payment in paymentsData) {
      if (payment["status"] == "completed") {
        String method = payment["method"];
        methodTotals[method] = (methodTotals[method] ?? 0) + (payment["amount"] as double);
      }
    }

    return Container(
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
            "Payment Methods Breakdown",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...methodTotals.entries.map((entry) {
            double percentage = (entry.value / methodTotals.values.fold(0.0, (a, b) => a + b)) * 100;
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              child: Column(
                spacing: spXs,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: _getMethodColor(entry.key),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          _getMethodLabel(entry.key),
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Text(
                        "${percentage.toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "\$${entry.value.currency}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 4,
                    decoration: BoxDecoration(
                      color: disabledOutlineBorderColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: percentage / 100,
                      child: Container(
                        decoration: BoxDecoration(
                          color: _getMethodColor(entry.key),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                      ),
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

  Color _getMethodColor(String method) {
    switch (method) {
      case "credit_card":
        return primaryColor;
      case "bank_transfer":
        return successColor;
      case "digital_wallet":
        return infoColor;
      case "cash":
        return warningColor;
      case "check":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getMethodLabel(String method) {
    switch (method) {
      case "credit_card":
        return "Credit Card";
      case "bank_transfer":
        return "Bank Transfer";
      case "digital_wallet":
        return "Digital Wallet";
      case "cash":
        return "Cash";
      case "check":
        return "Check";
      default:
        return method;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "processing":
        return infoColor;
      case "pending":
        return warningColor;
      case "failed":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getMethodIcon(String method) {
    switch (method) {
      case "credit_card":
        return Icons.credit_card;
      case "bank_transfer":
        return Icons.account_balance;
      case "digital_wallet":
        return Icons.account_balance_wallet;
      case "cash":
        return Icons.money;
      case "check":
        return Icons.receipt;
      default:
        return Icons.payment;
    }
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
                  label: "Search payments...",
                  value: searchQuery,
                  hint: "Search by client, transaction ID, or amount",
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
                  si("Searching payments...");
                },
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Payment Method",
                  items: [
                    {"label": "All Methods", "value": "all"},
                    ...paymentMethods,
                  ],
                  value: selectedPaymentMethod == "all" ? "all" : selectedPaymentMethod,
                  onChanged: (value, label) {
                    selectedPaymentMethod = value;
                    setState(() {});
                  },
                ),
              ),
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
      ),
    );
  }

  Widget _buildPaymentItem(Map<String, dynamic> payment) {
    Color statusColor = _getStatusColor(payment["status"]);
    IconData methodIcon = _getMethodIcon(payment["method"]);
    
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
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: _getMethodColor(payment["method"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  methodIcon,
                  color: _getMethodColor(payment["method"]),
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "${payment["id"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${payment["client"]}",
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
                  "${payment["status"]}".toUpperCase(),
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
                "\$${(payment["amount"] as double).currency}",
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
                "${payment["date"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.receipt, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "Invoice: ${payment["invoice_id"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "Fee: \$${(payment["fee"] as double).currency}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.confirmation_number, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "TXN: ${payment["transaction_id"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              QButton(
                label: "View Details",
                size: bs.sm,
                onPressed: () {
                  si("Viewing payment details for ${payment["id"]}");
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
        title: Text("Payment Management"),
        actions: [
          QButton(
            icon: Icons.add_card,
            size: bs.sm,
            onPressed: () {
              si("Add payment method");
            },
          ),
          QButton(
            icon: Icons.download,
            size: bs.sm,
            onPressed: () {
              si("Export payment report");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildPaymentSummary(),
            _buildPaymentMethodsChart(),
            _buildFilters(),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Recent Payments",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ),
            ...paymentsData.map((payment) => _buildPaymentItem(payment)),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Load More Payments",
                color: disabledBoldColor,
                size: bs.md,
                onPressed: () {
                  si("Loading more payments...");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
