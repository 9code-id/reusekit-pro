import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaCashRegisterView extends StatefulWidget {
  const RmaCashRegisterView({super.key});

  @override
  State<RmaCashRegisterView> createState() => _RmaCashRegisterViewState();
}

class _RmaCashRegisterViewState extends State<RmaCashRegisterView> {
  int currentTab = 0;
  double currentCashAmount = 250.0;
  String selectedShift = "morning";
  String cashierName = "John Smith";
  String registerId = "REG001";
  
  List<Map<String, dynamic>> cashTransactions = [
    {
      "transaction_id": "CT001",
      "type": "sale",
      "amount": 25.0,
      "description": "RMA Processing Fee",
      "timestamp": "2024-03-15 14:30:00",
      "receipt_number": "RCP001",
      "customer": "Emily Davis",
      "change_given": 0.0,
      "cash_received": 25.0,
    },
    {
      "transaction_id": "CT002",
      "type": "sale",
      "amount": 45.0,
      "description": "Battery Replacement",
      "timestamp": "2024-03-15 13:45:00",
      "receipt_number": "RCP002",
      "customer": "Robert Wilson",
      "change_given": 5.0,
      "cash_received": 50.0,
    },
    {
      "transaction_id": "CT003",
      "type": "refund",
      "amount": 30.0,
      "description": "Service Cancellation",
      "timestamp": "2024-03-15 12:15:00",
      "receipt_number": "RCP003",
      "customer": "Maria Garcia",
      "change_given": 0.0,
      "cash_received": 0.0,
    },
    {
      "transaction_id": "CT004",
      "type": "sale",
      "amount": 75.0,
      "description": "Diagnostic Service",
      "timestamp": "2024-03-15 11:30:00",
      "receipt_number": "RCP004",
      "customer": "James Anderson",
      "change_given": 0.0,
      "cash_received": 75.0,
    },
    {
      "transaction_id": "CT005",
      "type": "void",
      "amount": 15.0,
      "description": "Void Transaction - Error",
      "timestamp": "2024-03-15 10:45:00",
      "receipt_number": "RCP005",
      "customer": "Sarah Johnson",
      "change_given": 0.0,
      "cash_received": 0.0,
    },
  ];

  List<Map<String, dynamic>> denominationCounts = [
    {"denomination": "100", "type": "bill", "count": 2, "total": 200.0},
    {"denomination": "50", "type": "bill", "count": 1, "total": 50.0},
    {"denomination": "20", "type": "bill", "count": 3, "total": 60.0},
    {"denomination": "10", "type": "bill", "count": 5, "total": 50.0},
    {"denomination": "5", "type": "bill", "count": 4, "total": 20.0},
    {"denomination": "1", "type": "bill", "count": 8, "total": 8.0},
    {"denomination": "0.25", "type": "coin", "count": 12, "total": 3.0},
    {"denomination": "0.10", "type": "coin", "count": 15, "total": 1.5},
    {"denomination": "0.05", "type": "coin", "count": 10, "total": 0.5},
    {"denomination": "0.01", "type": "coin", "count": 20, "total": 0.2},
  ];

  List<Map<String, dynamic>> shiftHistory = [
    {
      "shift_id": "SH001",
      "date": "2024-03-15",
      "shift": "morning",
      "cashier": "John Smith",
      "start_time": "08:00:00",
      "end_time": "12:00:00",
      "starting_cash": 200.0,
      "sales_total": 485.0,
      "refunds_total": 25.0,
      "ending_cash": 660.0,
      "expected_cash": 660.0,
      "variance": 0.0,
      "transactions_count": 15,
      "status": "completed",
    },
    {
      "shift_id": "SH002",
      "date": "2024-03-14",
      "shift": "afternoon",
      "cashier": "Emily Davis",
      "start_time": "12:00:00",
      "end_time": "18:00:00",
      "starting_cash": 250.0,
      "sales_total": 320.0,
      "refunds_total": 45.0,
      "ending_cash": 525.0,
      "expected_cash": 525.0,
      "variance": 0.0,
      "transactions_count": 12,
      "status": "completed",
    },
    {
      "shift_id": "SH003",
      "date": "2024-03-14",
      "shift": "evening",
      "cashier": "Robert Wilson",
      "start_time": "18:00:00",
      "end_time": "22:00:00",
      "starting_cash": 200.0,
      "sales_total": 280.0,
      "refunds_total": 0.0,
      "ending_cash": 480.0,
      "expected_cash": 480.0,
      "variance": 0.0,
      "transactions_count": 8,
      "status": "completed",
    },
  ];

  void _updateDenominationCount(int index, int newCount) {
    denominationCounts[index]["count"] = newCount;
    double denomination = double.parse("${denominationCounts[index]["denomination"]}");
    denominationCounts[index]["total"] = denomination * newCount;
    
    // Recalculate total cash
    currentCashAmount = denominationCounts.fold(0.0, (sum, item) => sum + (item["total"] as double));
    setState(() {});
  }

  void _openCashDrawer() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Cash Drawer"),
        content: Text("Cash drawer opened for manual access."),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _performCashCount() {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text("Cash Count"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Count each denomination in the cash drawer:",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spMd),
                
                ...denominationCounts.asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<String, dynamic> item = entry.value;
                  bool isBill = item["type"] == "bill";
                  
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: isBill ? successColor.withAlpha(10) : warningColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: isBill ? successColor.withAlpha(20) : warningColor.withAlpha(20),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isBill ? Icons.money : Icons.monetization_on,
                          color: isBill ? successColor : warningColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        
                        Expanded(
                          child: Text(
                            "\$${item["denomination"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if ((item["count"] as int) > 0) {
                                  int newCount = (item["count"] as int) - 1;
                                  _updateDenominationCount(index, newCount);
                                  setDialogState(() {});
                                }
                              },
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: dangerColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Icon(Icons.remove, size: 20, color: dangerColor),
                              ),
                            ),
                            
                            SizedBox(width: spSm),
                            Container(
                              width: 40,
                              child: Text(
                                "${item["count"]}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            
                            GestureDetector(
                              onTap: () {
                                int newCount = (item["count"] as int) + 1;
                                _updateDenominationCount(index, newCount);
                                setDialogState(() {});
                              },
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: successColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Icon(Icons.add, size: 20, color: successColor),
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(width: spSm),
                        Text(
                          "\$${(item["total"] as double).currency}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                
                SizedBox(height: spMd),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: primaryColor.withAlpha(40)),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Total Cash:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "\$${currentCashAmount.currency}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            QButton(
              label: "Save Count",
              size: bs.sm,
              onPressed: () {
                Navigator.pop(context);
                ss("Cash count saved successfully");
              },
            ),
          ],
        ),
      ),
    );
  }

  void _closeShift() async {
    bool isConfirmed = await confirm("Close current shift and finalize cash count?");
    if (!isConfirmed) return;

    showLoading();
    await Future.delayed(Duration(seconds: 2));
    hideLoading();
    
    ss("Shift closed successfully");
  }

  Widget _buildTransactionItem(Map<String, dynamic> transaction) {
    bool isRefund = transaction["type"] == "refund";
    bool isVoid = transaction["type"] == "void";
    Color amountColor = isRefund || isVoid ? dangerColor : successColor;
    IconData icon = isRefund ? Icons.undo : (isVoid ? Icons.cancel : Icons.attach_money);
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
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
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: amountColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(icon, size: 16, color: amountColor),
              ),
              
              SizedBox(width: spSm),
              
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${transaction["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXxs),
                    Text(
                      "${transaction["customer"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              
              Text(
                "${isRefund || isVoid ? '-' : '+'}\$${(transaction["amount"] as double).currency}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: amountColor,
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.receipt, size: 16, color: disabledBoldColor),
              SizedBox(width: spXxs),
              Text(
                "${transaction["receipt_number"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spSm),
              Icon(Icons.access_time, size: 16, color: disabledBoldColor),
              SizedBox(width: spXxs),
              Text(
                "${transaction["timestamp"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          
          if (transaction["type"] == "sale" && (transaction["change_given"] as double) > 0) ...[
            SizedBox(height: spXs),
            Row(
              children: [
                Icon(Icons.change_circle, size: 16, color: warningColor),
                SizedBox(width: spXxs),
                Text(
                  "Change: \$${(transaction["change_given"] as double).currency}",
                  style: TextStyle(
                    fontSize: 12,
                    color: warningColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: spSm),
                Text(
                  "Received: \$${(transaction["cash_received"] as double).currency}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDenominationItem(Map<String, dynamic> item) {
    bool isBill = item["type"] == "bill";
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: isBill ? successColor.withAlpha(20) : warningColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Icon(
              isBill ? Icons.money : Icons.monetization_on,
              color: isBill ? successColor : warningColor,
              size: 24,
            ),
          ),
          
          SizedBox(width: spSm),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "\$${item["denomination"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXxs),
                Text(
                  "${isBill ? 'Bills' : 'Coins'}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          
          Text(
            "${item["count"]} × \$${item["denomination"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          
          SizedBox(width: spSm),
          
          Text(
            "\$${(item["total"] as double).currency}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShiftItem(Map<String, dynamic> shift) {
    Color statusColor = shift["status"] == "completed" ? successColor : warningColor;
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
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
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${shift["cashier"]} - ${shift["shift"]} shift".toUpperCase(),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXxs),
                    Text(
                      "${shift["date"]} • ${shift["start_time"]} - ${shift["end_time"]}",
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
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${shift["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: spMd),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildShiftStatCard("Starting Cash", shift["starting_cash"], infoColor),
              _buildShiftStatCard("Sales Total", shift["sales_total"], successColor),
              _buildShiftStatCard("Refunds", shift["refunds_total"], dangerColor),
              _buildShiftStatCard("Ending Cash", shift["ending_cash"], primaryColor),
            ],
          ),
          
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.receipt_long, size: 16, color: disabledBoldColor),
              SizedBox(width: spXxs),
              Text(
                "${shift["transactions_count"]} transactions",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spSm),
              Icon(Icons.account_balance, size: 16, color: disabledBoldColor),
              SizedBox(width: spXxs),
              Text(
                "Variance: \$${(shift["variance"] as double).currency}",
                style: TextStyle(
                  fontSize: 12,
                  color: (shift["variance"] as double) == 0 ? successColor : dangerColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildShiftStatCard(String title, dynamic value, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "\$${(value as double).currency}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCashDrawerTab() {
    double totalCash = denominationCounts.fold(0.0, (sum, item) => sum + (item["total"] as double));
    
    return Column(
      children: [
        // Cash Summary
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: primaryColor.withAlpha(40)),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.account_balance_wallet, color: primaryColor, size: 32),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Current Cash Amount",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "\$${totalCash.currency}",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: spMd),
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Open Drawer",
                      size: bs.sm,
                      onPressed: _openCashDrawer,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Count Cash",
                      size: bs.sm,
                      onPressed: _performCashCount,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        
        SizedBox(height: spMd),
        
        // Denomination Breakdown
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Cash Breakdown",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              
              ...denominationCounts.map((item) => _buildDenominationItem(item)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionsTab() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: primaryColor.withAlpha(40)),
          ),
          child: Row(
            children: [
              Icon(Icons.receipt_long, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Cash Transactions (${cashTransactions.length})",
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        
        SizedBox(height: spMd),
        
        ...cashTransactions.map((transaction) => _buildTransactionItem(transaction)),
      ],
    );
  }

  Widget _buildShiftHistoryTab() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: primaryColor.withAlpha(40)),
          ),
          child: Row(
            children: [
              Icon(Icons.schedule, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Shift History",
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              QButton(
                label: "Close Current Shift",
                size: bs.sm,
                onPressed: _closeShift,
              ),
            ],
          ),
        ),
        
        SizedBox(height: spMd),
        
        ...shiftHistory.map((shift) => _buildShiftItem(shift)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "RMA Cash Register",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Cash Drawer", icon: Icon(Icons.account_balance_wallet)),
        Tab(text: "Transactions", icon: Icon(Icons.receipt_long)),
        Tab(text: "Shift History", icon: Icon(Icons.schedule)),
      ],
      tabChildren: [
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildCashDrawerTab(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildTransactionsTab(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildShiftHistoryTab(),
        ),
      ],
    );
  }
}
