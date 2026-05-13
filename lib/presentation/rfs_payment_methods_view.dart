import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsPaymentMethodsView extends StatefulWidget {
  const RfsPaymentMethodsView({super.key});

  @override
  State<RfsPaymentMethodsView> createState() => _RfsPaymentMethodsViewState();
}

class _RfsPaymentMethodsViewState extends State<RfsPaymentMethodsView> {
  int currentTab = 0;
  String methodName = "";
  String methodType = "Credit Card";
  String processingFee = "2.5";
  bool isActive = true;
  bool requiresSignature = false;
  bool supportsTips = true;
  String dailyLimit = "10000";
  String transactionLimit = "500";
  String merchantId = "";
  String apiKey = "";
  String secretKey = "";

  List<Map<String, dynamic>> methodTypeOptions = [
    {"label": "Credit Card", "value": "Credit Card"},
    {"label": "Debit Card", "value": "Debit Card"},
    {"label": "Digital Wallet", "value": "Digital Wallet"},
    {"label": "Bank Transfer", "value": "Bank Transfer"},
    {"label": "Cash", "value": "Cash"},
    {"label": "Check", "value": "Check"},
    {"label": "Gift Card", "value": "Gift Card"},
    {"label": "Cryptocurrency", "value": "Cryptocurrency"},
  ];

  List<Map<String, dynamic>> paymentMethods = [
    {
      "id": 1,
      "name": "Visa/Mastercard",
      "type": "Credit Card",
      "isActive": true,
      "processingFee": 2.5,
      "dailyTransactions": 156,
      "dailyVolume": 12450.75,
      "avgTransactionSize": 79.81,
      "requiresSignature": true,
      "supportsTips": true,
      "provider": "Square",
      "lastUsed": "2024-01-15 19:45"
    },
    {
      "id": 2,
      "name": "Apple Pay",
      "type": "Digital Wallet",
      "isActive": true,
      "processingFee": 1.8,
      "dailyTransactions": 89,
      "dailyVolume": 6789.30,
      "avgTransactionSize": 76.28,
      "requiresSignature": false,
      "supportsTips": true,
      "provider": "Apple",
      "lastUsed": "2024-01-15 19:30"
    },
    {
      "id": 3,
      "name": "Cash Register",
      "type": "Cash",
      "isActive": true,
      "processingFee": 0.0,
      "dailyTransactions": 67,
      "dailyVolume": 3421.50,
      "avgTransactionSize": 51.07,
      "requiresSignature": false,
      "supportsTips": true,
      "provider": "Internal",
      "lastUsed": "2024-01-15 19:50"
    },
    {
      "id": 4,
      "name": "Google Pay",
      "type": "Digital Wallet",
      "isActive": true,
      "processingFee": 1.9,
      "dailyTransactions": 45,
      "dailyVolume": 2876.20,
      "avgTransactionSize": 63.92,
      "requiresSignature": false,
      "supportsTips": true,
      "provider": "Google",
      "lastUsed": "2024-01-15 18:15"
    },
    {
      "id": 5,
      "name": "PayPal",
      "type": "Digital Wallet",
      "isActive": false,
      "processingFee": 2.9,
      "dailyTransactions": 12,
      "dailyVolume": 876.40,
      "avgTransactionSize": 73.03,
      "requiresSignature": false,
      "supportsTips": false,
      "provider": "PayPal",
      "lastUsed": "2024-01-14 16:20"
    },
    {
      "id": 6,
      "name": "Bank Transfer",
      "type": "Bank Transfer",
      "isActive": true,
      "processingFee": 0.5,
      "dailyTransactions": 8,
      "dailyVolume": 1245.80,
      "avgTransactionSize": 155.73,
      "requiresSignature": true,
      "supportsTips": false,
      "provider": "Chase Bank",
      "lastUsed": "2024-01-15 14:30"
    }
  ];

  List<Map<String, dynamic>> transactionHistory = [
    {
      "id": "TXN-2024-1567",
      "method": "Visa/Mastercard",
      "amount": 89.45,
      "status": "Success",
      "date": "2024-01-15",
      "time": "19:45",
      "table": "Table 12",
      "fee": 2.24,
      "customer": "John Smith",
      "reference": "4532-****-****-1234"
    },
    {
      "id": "TXN-2024-1568",
      "method": "Apple Pay",
      "amount": 156.78,
      "status": "Success",
      "date": "2024-01-15",
      "time": "19:30",
      "table": "Table 8",
      "fee": 2.82,
      "customer": "Sarah Johnson",
      "reference": "APAY-5678-9012"
    },
    {
      "id": "TXN-2024-1569",
      "method": "Cash Register",
      "amount": 67.20,
      "status": "Success",
      "date": "2024-01-15",
      "time": "19:20",
      "table": "Table 5",
      "fee": 0.00,
      "customer": "Mike Davis",
      "reference": "CASH-001-456"
    },
    {
      "id": "TXN-2024-1570",
      "method": "Google Pay",
      "amount": 234.50,
      "status": "Failed",
      "date": "2024-01-15",
      "time": "19:10",
      "table": "Table 15",
      "fee": 0.00,
      "customer": "Emma Wilson",
      "reference": "GPAY-7890-1234"
    },
    {
      "id": "TXN-2024-1571",
      "method": "Visa/Mastercard",
      "amount": 145.30,
      "status": "Pending",
      "date": "2024-01-15",
      "time": "18:55",
      "table": "VIP Room 1",
      "fee": 3.63,
      "customer": "Robert Brown",
      "reference": "4567-****-****-8901"
    }
  ];

  List<Map<String, dynamic>> integrationProviders = [
    {
      "name": "Square",
      "type": "Payment Processor",
      "connected": true,
      "supportedMethods": ["Credit Card", "Debit Card", "Digital Wallet"],
      "features": ["PCI Compliant", "Real-time Processing", "Fraud Protection"],
      "monthlyFee": 25.00,
      "setupFee": 0.00
    },
    {
      "name": "Stripe",
      "type": "Payment Processor",
      "connected": false,
      "supportedMethods": ["Credit Card", "Digital Wallet", "Bank Transfer"],
      "features": ["Global Payments", "Subscription Billing", "Mobile SDK"],
      "monthlyFee": 30.00,
      "setupFee": 50.00
    },
    {
      "name": "PayPal Business",
      "type": "Digital Wallet",
      "connected": true,
      "supportedMethods": ["PayPal", "Credit Card", "Debit Card"],
      "features": ["Buyer Protection", "International", "Mobile App"],
      "monthlyFee": 20.00,
      "setupFee": 0.00
    },
    {
      "name": "Clover",
      "type": "POS Integration",
      "connected": false,
      "supportedMethods": ["Credit Card", "Debit Card", "Contactless"],
      "features": ["Hardware Integration", "Inventory Sync", "Analytics"],
      "monthlyFee": 40.00,
      "setupFee": 100.00
    },
    {
      "name": "TouchBistro Pay",
      "type": "Restaurant Specific",
      "connected": false,
      "supportedMethods": ["Credit Card", "Digital Wallet", "Gift Card"],
      "features": ["Restaurant Focused", "Split Billing", "Tip Management"],
      "monthlyFee": 35.00,
      "setupFee": 75.00
    }
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Payment Methods",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Methods", icon: Icon(Icons.payment)),
        Tab(text: "Transactions", icon: Icon(Icons.receipt_long)),
        Tab(text: "Integration", icon: Icon(Icons.integration_instructions)),
        Tab(text: "Settings", icon: Icon(Icons.settings)),
      ],
      tabChildren: [
        _buildMethodsTab(),
        _buildTransactionsTab(),
        _buildIntegrationTab(),
        _buildSettingsTab(),
      ],
    );
  }

  Widget _buildMethodsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildMethodsOverview(),
          _buildAddMethodCard(),
          _buildMethodsList(),
        ],
      ),
    );
  }

  Widget _buildMethodsOverview() {
    double totalVolume = paymentMethods.fold(0.0, (sum, method) => sum + (method["dailyVolume"] as double));
    int totalTransactions = paymentMethods.fold(0, (sum, method) => sum + (method["dailyTransactions"] as int));
    int activeMethods = paymentMethods.where((method) => method["isActive"] == true).length;

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildOverviewCard("Active Methods", "$activeMethods", Icons.payment, primaryColor),
        _buildOverviewCard("Daily Volume", "\$${totalVolume.toStringAsFixed(2)}", Icons.attach_money, successColor),
        _buildOverviewCard("Transactions", "$totalTransactions", Icons.receipt, infoColor),
        _buildOverviewCard("Avg. Size", "\$${(totalVolume / totalTransactions).toStringAsFixed(2)}", Icons.trending_up, warningColor),
      ],
    );
  }

  Widget _buildOverviewCard(String title, String value, IconData icon, Color color) {
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
                  size: 20,
                ),
              ),
              Spacer(),
              Icon(
                Icons.trending_up,
                color: successColor,
                size: 16,
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
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

  Widget _buildAddMethodCard() {
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
              Icon(Icons.add_card, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Add Payment Method",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Divider(),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Method Name",
                  value: methodName,
                  hint: "e.g., Amex Business Card",
                  onChanged: (value) {
                    methodName = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Method Type",
                  items: methodTypeOptions,
                  value: methodType,
                  onChanged: (value, label) {
                    methodType = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QNumberField(
                  label: "Processing Fee (%)",
                  value: processingFee,
                  onChanged: (value) {
                    processingFee = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QNumberField(
                  label: "Transaction Limit (\$)",
                  value: transactionLimit,
                  onChanged: (value) {
                    transactionLimit = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Active",
                      "value": "active",
                      "checked": isActive,
                    }
                  ],
                  value: [if (isActive) {"label": "Active", "value": "active", "checked": true}],
                  onChanged: (values, ids) {
                    isActive = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Requires Signature",
                      "value": "signature",
                      "checked": requiresSignature,
                    }
                  ],
                  value: [if (requiresSignature) {"label": "Requires Signature", "value": "signature", "checked": true}],
                  onChanged: (values, ids) {
                    requiresSignature = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QSwitch(
            items: [
              {
                "label": "Supports Tips",
                "value": "tips",
                "checked": supportsTips,
              }
            ],
            value: [if (supportsTips) {"label": "Supports Tips", "value": "tips", "checked": true}],
            onChanged: (values, ids) {
              supportsTips = values.isNotEmpty;
              setState(() {});
            },
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Add Payment Method",
              icon: Icons.add,
              size: bs.md,
              onPressed: () {
                ss("Payment method added successfully");
                methodName = "";
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMethodsList() {
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
              Icon(Icons.list, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Payment Methods",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                icon: Icons.filter_list,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          Divider(),
          ...paymentMethods.map((method) => _buildMethodCard(method)),
        ],
      ),
    );
  }

  Widget _buildMethodCard(Map<String, dynamic> method) {
    Color statusColor = method["isActive"] ? successColor : dangerColor;
    IconData methodIcon = _getMethodIcon(method["type"]);

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  methodIcon,
                  color: primaryColor,
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
                      "${method["name"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${method["type"]} • ${method["provider"]}",
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
                  method["isActive"] ? "Active" : "Inactive",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
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
                    Text("Daily Volume:", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                    Spacer(),
                    Text("\$${(method["dailyVolume"] as double).toStringAsFixed(2)}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                  ],
                ),
                Row(
                  children: [
                    Text("Transactions:", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                    Spacer(),
                    Text("${method["dailyTransactions"]}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                  ],
                ),
                Row(
                  children: [
                    Text("Processing Fee:", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                    Spacer(),
                    Text("${(method["processingFee"] as double).toStringAsFixed(1)}%", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                  ],
                ),
                Row(
                  children: [
                    Text("Avg. Transaction:", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                    Spacer(),
                    Text("\$${(method["avgTransactionSize"] as double).toStringAsFixed(2)}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              Icon(Icons.access_time, size: 12, color: disabledColor),
              SizedBox(width: spXs),
              Text(
                "Last used: ${method["lastUsed"]}",
                style: TextStyle(fontSize: 11, color: disabledColor),
              ),
              Spacer(),
              Row(
                children: [
                  if (method["requiresSignature"])
                    Container(
                      margin: EdgeInsets.only(right: spXs),
                      child: Icon(Icons.edit, size: 12, color: infoColor),
                    ),
                  if (method["supportsTips"])
                    Container(
                      margin: EdgeInsets.only(right: spXs),
                      child: Icon(Icons.volunteer_activism, size: 12, color: successColor),
                    ),
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.more_vert,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getMethodIcon(String type) {
    switch (type) {
      case "Credit Card":
      case "Debit Card":
        return Icons.credit_card;
      case "Digital Wallet":
        return Icons.account_balance_wallet;
      case "Bank Transfer":
        return Icons.account_balance;
      case "Cash":
        return Icons.money;
      case "Check":
        return Icons.receipt;
      case "Gift Card":
        return Icons.card_giftcard;
      case "Cryptocurrency":
        return Icons.currency_bitcoin;
      default:
        return Icons.payment;
    }
  }

  Widget _buildTransactionsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildTransactionFilters(),
          _buildTransactionStats(),
          _buildTransactionsList(),
        ],
      ),
    );
  }

  Widget _buildTransactionFilters() {
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
              Icon(Icons.filter_list, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Transaction Filters",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Divider(),
          Row(
            children: [
              Expanded(
                child: QDatePicker(
                  label: "From Date",
                  value: DateTime.now().subtract(Duration(days: 1)),
                  onChanged: (value) {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDatePicker(
                  label: "To Date",
                  value: DateTime.now(),
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Payment Method",
                  items: [
                    {"label": "All Methods", "value": "All"},
                    {"label": "Credit Card", "value": "Credit Card"},
                    {"label": "Digital Wallet", "value": "Digital Wallet"},
                    {"label": "Cash", "value": "Cash"},
                    {"label": "Bank Transfer", "value": "Bank Transfer"},
                  ],
                  value: "All",
                  onChanged: (value, label) {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: [
                    {"label": "All Status", "value": "All"},
                    {"label": "Success", "value": "Success"},
                    {"label": "Failed", "value": "Failed"},
                    {"label": "Pending", "value": "Pending"},
                    {"label": "Refunded", "value": "Refunded"},
                  ],
                  value: "All",
                  onChanged: (value, label) {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionStats() {
    double totalAmount = transactionHistory.fold(0.0, (sum, txn) => sum + (txn["amount"] as double));
    double totalFees = transactionHistory.fold(0.0, (sum, txn) => sum + (txn["fee"] as double));
    int successCount = transactionHistory.where((txn) => txn["status"] == "Success").length;

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildStatsCard("Total Amount", "\$${totalAmount.toStringAsFixed(2)}", Icons.attach_money, successColor),
        _buildStatsCard("Total Fees", "\$${totalFees.toStringAsFixed(2)}", Icons.receipt, warningColor),
        _buildStatsCard("Success Rate", "${((successCount / transactionHistory.length) * 100).toStringAsFixed(1)}%", Icons.check_circle, primaryColor),
        _buildStatsCard("Transactions", "${transactionHistory.length}", Icons.receipt_long, infoColor),
      ],
    );
  }

  Widget _buildStatsCard(String title, String value, IconData icon, Color color) {
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
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
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

  Widget _buildTransactionsList() {
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
              Icon(Icons.history, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Recent Transactions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                icon: Icons.download,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          Divider(),
          ...transactionHistory.map((transaction) => _buildTransactionCard(transaction)),
        ],
      ),
    );
  }

  Widget _buildTransactionCard(Map<String, dynamic> transaction) {
    Color statusColor = transaction["status"] == "Success" ? successColor : 
                       transaction["status"] == "Failed" ? dangerColor : 
                       transaction["status"] == "Pending" ? warningColor : infoColor;

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
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
                    Text(
                      "${transaction["id"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${transaction["method"]} • ${transaction["table"]}",
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
                  "${transaction["status"]}",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.person, size: 14, color: disabledBoldColor),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${transaction["customer"]}",
                  style: TextStyle(fontSize: 12, color: disabledBoldColor),
                ),
              ),
              Text(
                "\$${(transaction["amount"] as double).toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Ref: ${transaction["reference"]}",
                style: TextStyle(fontSize: 11, color: disabledColor),
              ),
              Spacer(),
              if ((transaction["fee"] as double) > 0)
                Text(
                  "Fee: \$${(transaction["fee"] as double).toStringAsFixed(2)}",
                  style: TextStyle(fontSize: 11, color: disabledColor),
                ),
              SizedBox(width: spSm),
              Text(
                "${transaction["date"]} ${transaction["time"]}",
                style: TextStyle(fontSize: 11, color: disabledColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIntegrationTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildIntegrationOverview(),
          _buildProvidersList(),
        ],
      ),
    );
  }

  Widget _buildIntegrationOverview() {
    int connectedCount = integrationProviders.where((provider) => provider["connected"] == true).length;
    double totalMonthlyFees = integrationProviders
        .where((provider) => provider["connected"] == true)
        .fold(0.0, (sum, provider) => sum + (provider["monthlyFee"] as double));

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildOverviewCard("Connected", "$connectedCount", Icons.link, successColor),
        _buildOverviewCard("Available", "${integrationProviders.length - connectedCount}", Icons.link_off, warningColor),
        _buildOverviewCard("Monthly Fees", "\$${totalMonthlyFees.toStringAsFixed(2)}", Icons.attach_money, primaryColor),
        _buildOverviewCard("Total Providers", "${integrationProviders.length}", Icons.business, infoColor),
      ],
    );
  }

  Widget _buildProvidersList() {
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
              Icon(Icons.integration_instructions, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Integration Providers",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              QButton(
                label: "Add Provider",
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
          Divider(),
          ...integrationProviders.map((provider) => _buildProviderCard(provider)),
        ],
      ),
    );
  }

  Widget _buildProviderCard(Map<String, dynamic> provider) {
    Color statusColor = provider["connected"] ? successColor : dangerColor;

    return Container(
      padding: EdgeInsets.all(spMd),
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.business,
                  color: primaryColor,
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
                      "${provider["name"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${provider["type"]}",
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
                  provider["connected"] ? "Connected" : "Available",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spXs,
            children: [
              Text(
                "Supported Methods:",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: disabledBoldColor,
                ),
              ),
              Wrap(
                spacing: spXs,
                runSpacing: spXs,
                children: (provider["supportedMethods"] as List).map((method) => Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "$method",
                    style: TextStyle(
                      fontSize: 10,
                      color: infoColor,
                    ),
                  ),
                )).toList(),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spXs,
            children: [
              Text(
                "Features:",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                (provider["features"] as List).join(" • "),
                style: TextStyle(
                  fontSize: 11,
                  color: disabledColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Monthly: \$${(provider["monthlyFee"] as double).toStringAsFixed(2)}",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
              SizedBox(width: spSm),
              Text(
                "Setup: \$${(provider["setupFee"] as double).toStringAsFixed(2)}",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
              Spacer(),
              QButton(
                label: provider["connected"] ? "Configure" : "Connect",
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildGeneralSettings(),
          _buildSecuritySettings(),
          _buildFeeSettings(),
        ],
      ),
    );
  }

  Widget _buildGeneralSettings() {
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
              Icon(Icons.settings, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "General Settings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Divider(),
          QSwitch(
            items: [
              {
                "label": "Auto-accept payments under \$50",
                "value": "auto_accept",
                "checked": true,
              }
            ],
            value: [{"label": "Auto-accept payments under \$50", "value": "auto_accept", "checked": true}],
            onChanged: (values, ids) {},
          ),
          QSwitch(
            items: [
              {
                "label": "Require receipt confirmation",
                "value": "receipt_confirm",
                "checked": false,
              }
            ],
            value: [],
            onChanged: (values, ids) {},
          ),
          QSwitch(
            items: [
              {
                "label": "Enable contactless payments",
                "value": "contactless",
                "checked": true,
              }
            ],
            value: [{"label": "Enable contactless payments", "value": "contactless", "checked": true}],
            onChanged: (values, ids) {},
          ),
          QNumberField(
            label: "Default Daily Limit (\$)",
            value: dailyLimit,
            hint: "Maximum daily transaction volume",
            onChanged: (value) {
              dailyLimit = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSecuritySettings() {
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
              Icon(Icons.security, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Security Settings",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Divider(),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Merchant ID",
                  value: merchantId,
                  hint: "Your merchant identifier",
                  onChanged: (value) {
                    merchantId = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "API Key",
                  value: apiKey,
                  hint: "Payment processor API key",
                  onChanged: (value) {
                    apiKey = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QTextField(
            label: "Secret Key",
            value: secretKey,
            hint: "Secure secret key for transactions",
            onChanged: (value) {
              secretKey = value;
              setState(() {});
            },
          ),
          QSwitch(
            items: [
              {
                "label": "Enable fraud detection",
                "value": "fraud_detection",
                "checked": true,
              }
            ],
            value: [{"label": "Enable fraud detection", "value": "fraud_detection", "checked": true}],
            onChanged: (values, ids) {},
          ),
          QSwitch(
            items: [
              {
                "label": "Require CVV for card payments",
                "value": "require_cvv",
                "checked": true,
              }
            ],
            value: [{"label": "Require CVV for card payments", "value": "require_cvv", "checked": true}],
            onChanged: (values, ids) {},
          ),
        ],
      ),
    );
  }

  Widget _buildFeeSettings() {
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
              Icon(Icons.percent, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Fee Configuration",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Divider(),
          Row(
            children: [
              Expanded(
                child: QNumberField(
                  label: "Credit Card Fee (%)",
                  value: "2.9",
                  onChanged: (value) {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QNumberField(
                  label: "Debit Card Fee (%)",
                  value: "1.5",
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QNumberField(
                  label: "Digital Wallet Fee (%)",
                  value: "2.2",
                  onChanged: (value) {},
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QNumberField(
                  label: "Bank Transfer Fee (\$)",
                  value: "1.50",
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
          QSwitch(
            items: [
              {
                "label": "Pass processing fees to customer",
                "value": "pass_fees",
                "checked": false,
              }
            ],
            value: [],
            onChanged: (values, ids) {},
          ),
          QSwitch(
            items: [
              {
                "label": "Show fees on receipt",
                "value": "show_fees",
                "checked": true,
              }
            ],
            value: [{"label": "Show fees on receipt", "value": "show_fees", "checked": true}],
            onChanged: (values, ids) {},
          ),
        ],
      ),
    );
  }
}
