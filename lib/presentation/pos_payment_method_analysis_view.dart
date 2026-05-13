import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosPaymentMethodAnalysisView extends StatefulWidget {
  const PosPaymentMethodAnalysisView({super.key});

  @override
  State<PosPaymentMethodAnalysisView> createState() => _PosPaymentMethodAnalysisViewState();
}

class _PosPaymentMethodAnalysisViewState extends State<PosPaymentMethodAnalysisView> {
  String selectedPeriod = "This Month";
  bool loading = false;

  List<Map<String, dynamic>> periodItems = [
    {"label": "Today", "value": "Today"},
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
    {"label": "Custom Range", "value": "Custom Range"},
  ];

  List<Map<String, dynamic>> paymentMethods = [
    {
      "method": "Cash",
      "transactions": 1847,
      "total_amount": 75420.50,
      "percentage": 45.2,
      "color": primaryColor,
      "icon": Icons.money,
      "avg_transaction": 40.85,
      "growth": 8.5,
    },
    {
      "method": "Credit Card",
      "transactions": 1256,
      "total_amount": 89730.25,
      "percentage": 35.8,
      "color": successColor,
      "icon": Icons.credit_card,
      "avg_transaction": 71.45,
      "growth": 12.3,
    },
    {
      "method": "Digital Wallet",
      "transactions": 892,
      "total_amount": 42180.75,
      "percentage": 19.0,
      "color": infoColor,
      "icon": Icons.phone_android,
      "avg_transaction": 47.29,
      "growth": 28.7,
    },
    {
      "method": "Bank Transfer",
      "transactions": 234,
      "total_amount": 18650.00,
      "percentage": 6.7,
      "color": warningColor,
      "icon": Icons.account_balance,
      "avg_transaction": 79.70,
      "growth": -3.2,
    },
    {
      "method": "Gift Card",
      "transactions": 156,
      "total_amount": 7850.30,
      "percentage": 4.4,
      "color": dangerColor,
      "icon": Icons.card_giftcard,
      "avg_transaction": 50.32,
      "growth": 15.8,
    },
  ];

  List<Map<String, dynamic>> hourlyTrends = [
    {"hour": "09:00", "cash": 2450, "card": 1890, "digital": 1230, "other": 450},
    {"hour": "10:00", "cash": 3280, "card": 2650, "digital": 1780, "other": 620},
    {"hour": "11:00", "cash": 4120, "card": 3890, "digital": 2340, "other": 890},
    {"hour": "12:00", "cash": 5680, "card": 4750, "digital": 3120, "other": 1120},
    {"hour": "13:00", "cash": 6240, "card": 5890, "digital": 3650, "other": 1340},
    {"hour": "14:00", "cash": 4890, "card": 4320, "digital": 2780, "other": 980},
    {"hour": "15:00", "cash": 5230, "card": 4680, "digital": 3240, "other": 1180},
    {"hour": "16:00", "cash": 6780, "card": 6120, "digital": 4230, "other": 1560},
    {"hour": "17:00", "cash": 7890, "card": 7340, "digital": 5120, "other": 1890},
    {"hour": "18:00", "cash": 6450, "card": 5890, "digital": 3890, "other": 1450},
  ];

  double get totalAmount => paymentMethods.fold(0.0, (sum, method) => sum + (method["total_amount"] as double));
  int get totalTransactions => paymentMethods.fold(0, (sum, method) => sum + (method["transactions"] as int));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Method Analysis"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refreshData,
          ),
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: _exportData,
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                children: [
                  _buildPeriodFilter(),
                  _buildSummaryCards(),
                  _buildPaymentMethodChart(),
                  _buildPaymentMethodsList(),
                  _buildHourlyTrends(),
                  _buildInsights(),
                ],
              ),
            ),
    );
  }

  Widget _buildPeriodFilter() {
    return Container(
      width: double.infinity,
      child: QDropdownField(
        label: "Period",
        items: periodItems,
        value: selectedPeriod,
        onChanged: (value, label) {
          selectedPeriod = value;
          _loadData();
        },
      ),
    );
  }

  Widget _buildSummaryCards() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.payment, color: primaryColor, size: 20),
                    SizedBox(width: spSm),
                    Text(
                      "Total Revenue",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "\$${totalAmount.currency}",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(Icons.trending_up, color: successColor, size: 14),
                    SizedBox(width: spXs),
                    Text(
                      "+12.5% vs last period",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spMd),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.receipt, color: infoColor, size: 20),
                    SizedBox(width: spSm),
                    Text(
                      "Total Transactions",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "${totalTransactions.toString()}",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(Icons.trending_up, color: successColor, size: 14),
                    SizedBox(width: spXs),
                    Text(
                      "+8.2% vs last period",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethodChart() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Payment Method Distribution",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Container(
            height: 200,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Center(
                      child: Text(
                        "Payment Methods\nChart",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  flex: 1,
                  child: Column(
                    spacing: spSm,
                    children: paymentMethods.take(4).map((method) {
                      return Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: method["color"] as Color,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "${method["method"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                          Text(
                            "${(method["percentage"] as double).toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodsList() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Payment Methods Performance",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Column(
            spacing: spSm,
            children: paymentMethods.map((method) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: (method["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: method["color"] as Color,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          method["icon"] as IconData,
                          color: method["color"] as Color,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${method["method"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${method["transactions"]} transactions",
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
                              "\$${(method["total_amount"] as double).currency}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  (method["growth"] as double) >= 0 ? Icons.trending_up : Icons.trending_down,
                                  color: (method["growth"] as double) >= 0 ? successColor : dangerColor,
                                  size: 14,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${(method["growth"] as double) >= 0 ? '+' : ''}${(method["growth"] as double).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: (method["growth"] as double) >= 0 ? successColor : dangerColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Avg Transaction",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "\$${(method["avg_transaction"] as double).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Share",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${(method["percentage"] as double).toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildHourlyTrends() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hourly Payment Trends",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(50),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Center(
              child: Text(
                "Hourly Payment Method\nTrends Chart",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Cash",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: successColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Card",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: infoColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Digital",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInsights() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Key Insights",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Column(
            spacing: spMd,
            children: [
              _buildInsightItem(
                Icons.trending_up,
                successColor,
                "Growing Digital Adoption",
                "Digital wallet payments increased by 28.7% this period, showing strong customer preference for contactless payments.",
              ),
              _buildInsightItem(
                Icons.credit_card,
                infoColor,
                "Credit Card Dominance",
                "Credit cards generate the highest average transaction value at \$71.45 per transaction.",
              ),
              _buildInsightItem(
                Icons.schedule,
                warningColor,
                "Peak Payment Hours",
                "Most digital payments occur between 5-7 PM, while cash transactions remain steady throughout the day.",
              ),
              _buildInsightItem(
                Icons.analytics,
                primaryColor,
                "Optimization Opportunity",
                "Promoting digital payment methods during peak hours could increase transaction efficiency by 15%.",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInsightItem(IconData icon, Color color, String title, String description) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border(
          left: BorderSide(
            width: 4,
            color: color,
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _loadData() {
    loading = true;
    setState(() {});

    // Simulate API call
    Future.delayed(Duration(seconds: 1), () {
      loading = false;
      setState(() {});
    });
  }

  void _refreshData() {
    _loadData();
  }

  void _exportData() {
    ss("Payment method analysis exported successfully");
  }
}
