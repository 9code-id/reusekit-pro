import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosHourlySalesView extends StatefulWidget {
  const PosHourlySalesView({super.key});

  @override
  State<PosHourlySalesView> createState() => _PosHourlySalesViewState();
}

class _PosHourlySalesViewState extends State<PosHourlySalesView> {
  String selectedDate = DateTime.now().toString().substring(0, 10);
  String selectedStore = "All Stores";
  bool loading = false;

  List<Map<String, dynamic>> storeItems = [
    {"label": "All Stores", "value": "All Stores"},
    {"label": "Main Store", "value": "Main Store"},
    {"label": "Branch A", "value": "Branch A"},
    {"label": "Branch B", "value": "Branch B"},
    {"label": "Online Store", "value": "Online Store"},
  ];

  List<Map<String, dynamic>> hourlySales = [
    {
      "hour": "08:00",
      "sales": 2450.75,
      "transactions": 23,
      "avg_ticket": 106.55,
      "customers": 18,
      "growth": 8.5,
    },
    {
      "hour": "09:00",
      "sales": 3890.25,
      "transactions": 34,
      "avg_ticket": 114.42,
      "customers": 29,
      "growth": 12.3,
    },
    {
      "hour": "10:00",
      "sales": 5240.80,
      "transactions": 45,
      "avg_ticket": 116.46,
      "customers": 38,
      "growth": 15.7,
    },
    {
      "hour": "11:00",
      "sales": 7680.30,
      "transactions": 62,
      "avg_ticket": 123.88,
      "customers": 52,
      "growth": 18.9,
    },
    {
      "hour": "12:00",
      "sales": 12450.75,
      "transactions": 89,
      "avg_ticket": 139.90,
      "customers": 78,
      "growth": 25.4,
    },
    {
      "hour": "13:00",
      "sales": 15890.50,
      "transactions": 108,
      "avg_ticket": 147.13,
      "customers": 95,
      "growth": 22.1,
    },
    {
      "hour": "14:00",
      "sales": 11240.25,
      "transactions": 78,
      "avg_ticket": 144.11,
      "customers": 67,
      "growth": 8.3,
    },
    {
      "hour": "15:00",
      "sales": 9850.40,
      "transactions": 65,
      "avg_ticket": 151.54,
      "customers": 58,
      "growth": 5.2,
    },
    {
      "hour": "16:00",
      "sales": 13670.80,
      "transactions": 92,
      "avg_ticket": 148.60,
      "customers": 81,
      "growth": 19.8,
    },
    {
      "hour": "17:00",
      "sales": 18920.75,
      "transactions": 125,
      "avg_ticket": 151.37,
      "customers": 112,
      "growth": 28.5,
    },
    {
      "hour": "18:00",
      "sales": 21450.90,
      "transactions": 145,
      "avg_ticket": 147.94,
      "customers": 128,
      "growth": 32.1,
    },
    {
      "hour": "19:00",
      "sales": 19880.60,
      "transactions": 134,
      "avg_ticket": 148.36,
      "customers": 118,
      "growth": 24.7,
    },
    {
      "hour": "20:00",
      "sales": 16450.25,
      "transactions": 102,
      "avg_ticket": 161.28,
      "customers": 89,
      "growth": 18.3,
    },
    {
      "hour": "21:00",
      "sales": 12380.75,
      "transactions": 78,
      "avg_ticket": 158.73,
      "customers": 68,
      "growth": 12.5,
    },
  ];

  double get totalSales => hourlySales.fold(0.0, (sum, hour) => sum + (hour["sales"] as double));
  int get totalTransactions => hourlySales.fold(0, (sum, hour) => sum + (hour["transactions"] as int));
  int get totalCustomers => hourlySales.fold(0, (sum, hour) => sum + (hour["customers"] as int));
  double get avgTicket => totalSales / totalTransactions;

  Map<String, dynamic> get peakHour => hourlySales.reduce((a, b) => 
    (a["sales"] as double) > (b["sales"] as double) ? a : b);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hourly Sales Analysis"),
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
                  _buildFilters(),
                  _buildSummaryCards(),
                  _buildHourlySalesChart(),
                  _buildPeakHoursInsight(),
                  _buildHourlyBreakdown(),
                  _buildPerformanceMetrics(),
                ],
              ),
            ),
    );
  }

  Widget _buildFilters() {
    return Row(
      children: [
        Expanded(
          child: QDatePicker(
            label: "Date",
            value: DateTime.parse(selectedDate),
            onChanged: (value) {
              selectedDate = value.toString().substring(0, 10);
              _loadData();
            },
          ),
        ),
        SizedBox(width: spMd),
        Expanded(
          child: QDropdownField(
            label: "Store",
            items: storeItems,
            value: selectedStore,
            onChanged: (value, label) {
              selectedStore = value;
              _loadData();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCards() {
    return Column(
      spacing: spMd,
      children: [
        Row(
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
                        Icon(Icons.attach_money, color: primaryColor, size: 20),
                        SizedBox(width: spSm),
                        Text(
                          "Total Sales",
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
                      "\$${totalSales.currency}",
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
                          "+18.5% vs yesterday",
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
                          "Transactions",
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
                      "${totalTransactions}",
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
                          "+12.3% vs yesterday",
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
        ),
        Row(
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
                        Icon(Icons.people, color: successColor, size: 20),
                        SizedBox(width: spSm),
                        Text(
                          "Customers",
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
                      "${totalCustomers}",
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
                          "+15.7% vs yesterday",
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
                        Icon(Icons.shopping_cart, color: warningColor, size: 20),
                        SizedBox(width: spSm),
                        Text(
                          "Avg Ticket",
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
                      "\$${avgTicket.toStringAsFixed(2)}",
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
                          "+5.2% vs yesterday",
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
        ),
      ],
    );
  }

  Widget _buildHourlySalesChart() {
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
          Row(
            children: [
              Expanded(
                child: Text(
                  "Hourly Sales Trend",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${DateTime.parse(selectedDate).dMMMy}",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
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
                "Hourly Sales\nChart",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPeakHoursInsight() {
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
            "Peak Hour Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: successColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border(
                left: BorderSide(
                  width: 4,
                  color: successColor,
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.trending_up,
                  color: successColor,
                  size: 32,
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Peak Hour: ${peakHour["hour"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Sales: \$${(peakHour["sales"] as double).currency}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "Transactions: ${peakHour["transactions"]} | Customers: ${peakHour["customers"]}",
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
                      "+${(peakHour["growth"] as double).toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "vs yesterday",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHourlyBreakdown() {
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
            "Hourly Breakdown",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Column(
            spacing: spSm,
            children: hourlySales.map((hour) {
              double maxSales = hourlySales.map((h) => h["sales"] as double).reduce((a, b) => a > b ? a : b);
              double barWidth = (hour["sales"] as double) / maxSales;
              
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 60,
                          child: Text(
                            "${hour["hour"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: disabledColor.withAlpha(50),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          width: MediaQuery.of(context).size.width * 0.5 * barWidth,
                                          height: 8,
                                          decoration: BoxDecoration(
                                            color: primaryColor,
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "\$${(hour["sales"] as double).currency}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: spMd),
                        Row(
                          children: [
                            Icon(
                              (hour["growth"] as double) >= 0 ? Icons.trending_up : Icons.trending_down,
                              color: (hour["growth"] as double) >= 0 ? successColor : dangerColor,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${(hour["growth"] as double) >= 0 ? '+' : ''}${(hour["growth"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 12,
                                color: (hour["growth"] as double) >= 0 ? successColor : dangerColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      children: [
                        SizedBox(width: 60),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${hour["transactions"]} transactions",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "${hour["customers"]} customers",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "\$${(hour["avg_ticket"] as double).toStringAsFixed(2)} avg",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
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

  Widget _buildPerformanceMetrics() {
    List<Map<String, dynamic>> topHours = List.from(hourlySales)
      ..sort((a, b) => (b["sales"] as double).compareTo(a["sales"] as double));
    
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
            "Performance Insights",
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
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Top 3 Hours",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Column(
                            spacing: spXs,
                            children: topHours.take(3).map((hour) {
                              return Text(
                                "${hour["hour"]} - \$${(hour["sales"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              );
                            }).toList(),
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
                        color: infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Rush Hours",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "12:00 - 13:00",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "17:00 - 19:00",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Peak traffic periods",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
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
    ss("Hourly sales data exported successfully");
  }
}
