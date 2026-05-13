import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsTransactionHistoryView extends StatefulWidget {
  const BrsTransactionHistoryView({super.key});

  @override
  State<BrsTransactionHistoryView> createState() => _BrsTransactionHistoryViewState();
}

class _BrsTransactionHistoryViewState extends State<BrsTransactionHistoryView> {
  String selectedPeriod = "This Month";
  String selectedPaymentMethod = "All Methods";
  String searchQuery = "";

  List<Map<String, dynamic>> periodFilters = [
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "Last 3 Months", "value": "Last 3 Months"},
    {"label": "This Year", "value": "This Year"},
    {"label": "Custom Range", "value": "Custom Range"},
  ];

  List<Map<String, dynamic>> paymentMethods = [
    {"label": "All Methods", "value": "All Methods"},
    {"label": "Credit Card", "value": "Credit Card"},
    {"label": "Cash", "value": "Cash"},
    {"label": "Digital Wallet", "value": "Digital Wallet"},
    {"label": "Bank Transfer", "value": "Bank Transfer"},
  ];

  List<Map<String, dynamic>> transactions = [
    {
      "id": "TRX001",
      "date": "2024-01-15",
      "time": "10:30 AM",
      "service": "Premium Haircut + Styling",
      "barber": "Alex Johnson",
      "amount": 45.00,
      "status": "Completed",
      "paymentMethod": "Credit Card",
      "points": 90,
      "receipt": true,
      "type": "service",
    },
    {
      "id": "TRX002",
      "date": "2024-01-12",
      "time": "2:15 PM",
      "service": "Beard Trim & Shave",
      "barber": "Mike Davis",
      "amount": 25.00,
      "status": "Completed",
      "paymentMethod": "Cash",
      "points": 50,
      "receipt": true,
      "type": "service",
    },
    {
      "id": "TRX003",
      "date": "2024-01-10",
      "time": "4:45 PM",
      "service": "Hair Wash & Scalp Treatment",
      "barber": "Sarah Wilson",
      "amount": 35.00,
      "status": "Refunded",
      "paymentMethod": "Digital Wallet",
      "points": -70,
      "receipt": true,
      "type": "refund",
      "refundReason": "Service cancelled by customer",
    },
    {
      "id": "TRX004",
      "date": "2024-01-08",
      "time": "11:00 AM",
      "service": "Full Grooming Package",
      "barber": "David Brown",
      "amount": 80.00,
      "status": "Completed",
      "paymentMethod": "Bank Transfer",
      "points": 160,
      "receipt": true,
      "type": "service",
    },
    {
      "id": "TRX005",
      "date": "2024-01-05",
      "time": "3:30 PM",
      "service": "Quick Trim",
      "barber": "Tom Garcia",
      "amount": 20.00,
      "status": "Completed",
      "paymentMethod": "Credit Card",
      "points": 40,
      "receipt": true,
      "type": "service",
    },
    {
      "id": "RWD001",
      "date": "2024-01-03",
      "time": "12:00 PM",
      "service": "Loyalty Reward Redemption",
      "barber": "",
      "amount": -15.00,
      "status": "Applied",
      "paymentMethod": "Points",
      "points": -300,
      "receipt": false,
      "type": "reward",
    },
  ];

  List<Map<String, dynamic>> monthlyStats = [
    {"month": "January", "amount": 205.00, "transactions": 6, "points": 350},
    {"month": "December", "amount": 320.00, "transactions": 8, "points": 640},
    {"month": "November", "amount": 180.00, "transactions": 5, "points": 360},
    {"month": "October", "amount": 275.00, "transactions": 7, "points": 550},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaction History"),
        actions: [
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: _exportTransactions,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummarySection(),
            SizedBox(height: spLg),
            _buildFiltersSection(),
            SizedBox(height: spLg),
            _buildSearchBar(),
            SizedBox(height: spLg),
            _buildTransactionsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSummarySection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(15),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: primaryColor.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Monthly Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: _buildStatCard("Total Spent", "\$205.00", Icons.payments, successColor),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard("Transactions", "6", Icons.receipt_long, infoColor),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildStatCard("Points Earned", "350", Icons.stars, warningColor),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard("Avg. per Visit", "\$34.17", Icons.trending_up, primaryColor),
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFiltersSection() {
    return Row(
      children: [
        Expanded(
          child: QDropdownField(
            label: "Period",
            items: periodFilters,
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
            label: "Payment Method",
            items: paymentMethods,
            value: selectedPaymentMethod,
            onChanged: (value, label) {
              selectedPaymentMethod = value;
              setState(() {});
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return QTextField(
      label: "Search transactions...",
      value: searchQuery,
      hint: "Search by service, barber, or transaction ID",
      onChanged: (value) {
        searchQuery = value;
        setState(() {});
      },
    );
  }

  Widget _buildTransactionsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Recent Transactions",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            GestureDetector(
              onTap: _showMonthlyReport,
              child: Text(
                "View Report",
                style: TextStyle(
                  fontSize: 14,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: spMd),
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: transactions.length,
          separatorBuilder: (context, index) => SizedBox(height: spSm),
          itemBuilder: (context, index) {
            final transaction = transactions[index];
            return _buildTransactionCard(transaction);
          },
        ),
      ],
    );
  }

  Widget _buildTransactionCard(Map<String, dynamic> transaction) {
    Color statusColor = _getStatusColor(transaction["status"]);
    IconData typeIcon = _getTypeIcon(transaction["type"]);
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(15),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(
                  typeIcon,
                  color: statusColor,
                  size: 18,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${transaction["service"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    if (transaction["barber"].toString().isNotEmpty)
                      Text(
                        "by ${transaction["barber"]}",
                        style: TextStyle(
                          fontSize: 12,
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
                    "\$${(transaction["amount"] as double).abs().toStringAsFixed(2)}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: transaction["amount"] < 0 ? dangerColor : successColor,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(15),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${transaction["status"]}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 14, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${transaction["date"]} at ${transaction["time"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Icon(Icons.payment, size: 14, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${transaction["paymentMethod"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          if (transaction["points"] != 0) ...[
            SizedBox(height: spXs),
            Row(
              children: [
                Icon(
                  Icons.stars,
                  size: 14,
                  color: transaction["points"] > 0 ? warningColor : dangerColor,
                ),
                SizedBox(width: spXs),
                Text(
                  "${transaction["points"] > 0 ? '+' : ''}${transaction["points"]} points",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: transaction["points"] > 0 ? warningColor : dangerColor,
                  ),
                ),
                Spacer(),
                if (transaction["receipt"] == true)
                  GestureDetector(
                    onTap: () => _showReceiptDetails(transaction),
                    child: Row(
                      children: [
                        Icon(Icons.receipt, size: 14, color: primaryColor),
                        SizedBox(width: spXs),
                        Text(
                          "Receipt",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ],
          if (transaction["type"] == "refund" && transaction["refundReason"] != null) ...[
            SizedBox(height: spXs),
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusXs),
                border: Border.all(color: dangerColor.withAlpha(30)),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, size: 14, color: dangerColor),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "${transaction["refundReason"]}",
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
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Completed": return successColor;
      case "Applied": return infoColor;
      case "Refunded": return dangerColor;
      case "Pending": return warningColor;
      default: return disabledBoldColor;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case "service": return Icons.content_cut;
      case "refund": return Icons.undo;
      case "reward": return Icons.card_giftcard;
      default: return Icons.payment;
    }
  }

  void _exportTransactions() {
    si("Transactions exported successfully!");
  }

  void _showReceiptDetails(Map<String, dynamic> transaction) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: disabledOutlineBorderColor)),
              ),
              child: Row(
                children: [
                  Text(
                    "Receipt Details",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () => back(),
                    child: Icon(Icons.close, color: disabledBoldColor),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildReceiptSection("Transaction ID", "${transaction["id"]}"),
                    _buildReceiptSection("Date & Time", "${transaction["date"]} ${transaction["time"]}"),
                    _buildReceiptSection("Service", "${transaction["service"]}"),
                    if (transaction["barber"].toString().isNotEmpty)
                      _buildReceiptSection("Barber", "${transaction["barber"]}"),
                    _buildReceiptSection("Amount", "\$${(transaction["amount"] as double).toStringAsFixed(2)}"),
                    _buildReceiptSection("Payment Method", "${transaction["paymentMethod"]}"),
                    _buildReceiptSection("Points Earned", "${transaction["points"]}"),
                    _buildReceiptSection("Status", "${transaction["status"]}"),
                    SizedBox(height: spLg),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Download Receipt",
                        icon: Icons.download,
                        onPressed: () {
                          back();
                          si("Receipt downloaded successfully!");
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReceiptSection(String title, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showMonthlyReport() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: disabledOutlineBorderColor)),
              ),
              child: Row(
                children: [
                  Text(
                    "Monthly Report",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () => back(),
                    child: Icon(Icons.close, color: disabledBoldColor),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  children: monthlyStats.map((stat) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                        border: Border.all(color: disabledOutlineBorderColor),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${stat["month"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${stat["transactions"]} transactions",
                                  style: TextStyle(
                                    fontSize: 12,
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
                                "\$${(stat["amount"] as double).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: successColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${stat["points"]} pts",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: warningColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
