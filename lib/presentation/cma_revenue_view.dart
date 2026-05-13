import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaRevenueView extends StatefulWidget {
  const CmaRevenueView({super.key});

  @override
  State<CmaRevenueView> createState() => _CmaRevenueViewState();
}

class _CmaRevenueViewState extends State<CmaRevenueView> {
  String selectedPeriod = "This Month";
  String selectedCategory = "All";
  int currentTab = 0;

  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "This Quarter", "value": "This Quarter"},
    {"label": "This Year", "value": "This Year"},
    {"label": "Custom Range", "value": "Custom Range"},
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All", "value": "All"},
    {"label": "Services", "value": "Services"},
    {"label": "Products", "value": "Products"},
    {"label": "Subscriptions", "value": "Subscriptions"},
    {"label": "Consulting", "value": "Consulting"},
  ];

  List<Map<String, dynamic>> revenueData = [
    {
      "date": "2024-06-01",
      "amount": 5200.00,
      "category": "Services",
      "invoices": 8,
      "growth": 12.5,
    },
    {
      "date": "2024-06-02",
      "amount": 3800.00,
      "category": "Products",
      "invoices": 6,
      "growth": -5.2,
    },
    {
      "date": "2024-06-03",
      "amount": 7100.00,
      "category": "Consulting",
      "invoices": 4,
      "growth": 18.7,
    },
    {
      "date": "2024-06-04",
      "amount": 4300.00,
      "category": "Subscriptions",
      "invoices": 12,
      "growth": 8.3,
    },
    {
      "date": "2024-06-05",
      "amount": 6500.00,
      "category": "Services",
      "invoices": 10,
      "growth": 15.4,
    },
  ];

  List<Map<String, dynamic>> monthlyRevenue = [
    {"month": "Jan", "amount": 45000.00, "target": 50000.00},
    {"month": "Feb", "amount": 52000.00, "target": 50000.00},
    {"month": "Mar", "amount": 48000.00, "target": 50000.00},
    {"month": "Apr", "amount": 58000.00, "target": 55000.00},
    {"month": "May", "amount": 61000.00, "target": 55000.00},
    {"month": "Jun", "amount": 67000.00, "target": 60000.00},
  ];

  List<Map<String, dynamic>> topCustomers = [
    {
      "name": "Acme Corporation",
      "revenue": 12500.00,
      "invoices": 8,
      "growth": 25.3,
    },
    {
      "name": "TechStart Inc.",
      "revenue": 9800.00,
      "invoices": 6,
      "growth": 18.7,
    },
    {
      "name": "Global Solutions",
      "revenue": 8200.00,
      "invoices": 5,
      "growth": -5.2,
    },
    {
      "name": "Innovation Labs",
      "revenue": 7400.00,
      "invoices": 4,
      "growth": 12.8,
    },
    {
      "name": "Digital Agency",
      "revenue": 6900.00,
      "invoices": 7,
      "growth": 31.5,
    },
  ];

  double get totalRevenue {
    return revenueData.fold(0.0, (sum, item) => sum + (item["amount"] as double));
  }

  double get averageInvoiceValue {
    int totalInvoices = revenueData.fold(0, (sum, item) => sum + (item["invoices"] as int));
    return totalInvoices > 0 ? totalRevenue / totalInvoices : 0.0;
  }

  double get growthRate {
    if (revenueData.isEmpty) return 0.0;
    double totalGrowth = revenueData.fold(0.0, (sum, item) => sum + (item["growth"] as double));
    return totalGrowth / revenueData.length;
  }

  Widget _buildMetricCard(String title, String value, String subtitle, IconData icon, Color color, {double? growth}) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
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
                  color: color.withAlpha(26),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: growth != null
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              growth >= 0 ? Icons.trending_up : Icons.trending_down,
                              color: growth >= 0 ? successColor : dangerColor,
                              size: 16,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "${growth >= 0 ? '+' : ''}${growth.toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: growth >= 0 ? successColor : dangerColor,
                              ),
                            ),
                          ],
                        )
                      : Container(),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
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
          if (subtitle.isNotEmpty)
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: disabledColor,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRevenueChart() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Monthly Revenue vs Target",
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
              crossAxisAlignment: CrossAxisAlignment.end,
              children: monthlyRevenue.map((data) {
                double actualHeight = ((data["amount"] as double) / 70000) * 150;
                double targetHeight = ((data["target"] as double) / 70000) * 150;
                bool metTarget = (data["amount"] as double) >= (data["target"] as double);
                
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Target line
                        Container(
                          height: 2,
                          margin: EdgeInsets.only(bottom: 2),
                          decoration: BoxDecoration(
                            color: warningColor,
                            borderRadius: BorderRadius.circular(1),
                          ),
                        ),
                        // Actual revenue bar
                        Container(
                          height: actualHeight,
                          decoration: BoxDecoration(
                            color: metTarget ? successColor : primaryColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${data["month"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              _buildLegendItem("Actual", primaryColor),
              SizedBox(width: spMd),
              _buildLegendItem("Target", warningColor),
              SizedBox(width: spMd),
              _buildLegendItem("Met Target", successColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(width: spXs),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildTopCustomersCard() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Top Customers by Revenue",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...topCustomers.map((customer) => _buildCustomerItem(customer)),
        ],
      ),
    );
  }

  Widget _buildCustomerItem(Map<String, dynamic> customer) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(26),
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
              children: [
                Text(
                  "${customer["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${customer["invoices"]} invoices",
                  style: TextStyle(
                    fontSize: 14,
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
                "\$${(customer["revenue"] as double).currency}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    (customer["growth"] as double) >= 0 ? Icons.trending_up : Icons.trending_down,
                    color: (customer["growth"] as double) >= 0 ? successColor : dangerColor,
                    size: 16,
                  ),
                  SizedBox(width: 4),
                  Text(
                    "${(customer["growth"] as double) >= 0 ? '+' : ''}${(customer["growth"] as double).toStringAsFixed(1)}%",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: (customer["growth"] as double) >= 0 ? successColor : dangerColor,
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

  Widget _buildCategoryBreakdown() {
    List<Map<String, dynamic>> categories = [
      {"name": "Services", "amount": 28500.00, "percentage": 42.5, "color": primaryColor},
      {"name": "Products", "amount": 19200.00, "percentage": 28.7, "color": secondaryColor},
      {"name": "Consulting", "amount": 12800.00, "percentage": 19.1, "color": successColor},
      {"name": "Subscriptions", "amount": 6500.00, "percentage": 9.7, "color": warningColor},
    ];

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Revenue by Category",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          // Pie chart representation
          Container(
            height: 150,
            child: Row(
              children: [
                Container(
                  width: 150,
                  height: 150,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: disabledOutlineBorderColor, width: 2),
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "\$${categories.fold(0.0, (sum, cat) => sum + (cat["amount"] as double)).currency}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Total Revenue",
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
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    children: categories.map((category) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        child: Row(
                          children: [
                            Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                color: category["color"],
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${category["name"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${(category["percentage"] as double).toStringAsFixed(1)}%",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "\$${(category["amount"] as double).currency}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Revenue Analytics"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              ss("Revenue report downloaded");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Filters
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
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
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Category",
                      items: categoryOptions,
                      value: selectedCategory,
                      onChanged: (value, label) {
                        selectedCategory = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Metrics Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildMetricCard(
                  "Total Revenue",
                  "\$${totalRevenue.currency}",
                  "This month",
                  Icons.trending_up,
                  successColor,
                  growth: growthRate,
                ),
                _buildMetricCard(
                  "Average Invoice",
                  "\$${averageInvoiceValue.currency}",
                  "Per transaction",
                  Icons.receipt,
                  primaryColor,
                  growth: 8.2,
                ),
                _buildMetricCard(
                  "Total Invoices",
                  "${revenueData.fold(0, (sum, item) => sum + (item["invoices"] as int))}",
                  "This period",
                  Icons.description,
                  infoColor,
                  growth: 15.7,
                ),
                _buildMetricCard(
                  "Growth Rate",
                  "${growthRate.toStringAsFixed(1)}%",
                  "Month over month",
                  Icons.show_chart,
                  warningColor,
                  growth: growthRate,
                ),
              ],
            ),

            // Revenue Chart
            _buildRevenueChart(),

            // Category Breakdown and Top Customers
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildCategoryBreakdown()),
                SizedBox(width: spMd),
                Expanded(child: _buildTopCustomersCard()),
              ],
            ),

            // Recent Revenue Items
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Recent Revenue",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      QButton(
                        label: "View All",
                        size: bs.sm,
                        onPressed: () {
                          // Navigate to detailed revenue view
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ...revenueData.take(5).map((revenue) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spSm),
                      decoration: BoxDecoration(
                        border: Border.all(color: disabledOutlineBorderColor),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(26),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.attach_money,
                              color: primaryColor,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${revenue["category"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${revenue["date"]} • ${revenue["invoices"]} invoices",
                                  style: TextStyle(
                                    fontSize: 14,
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
                                "\$${(revenue["amount"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    (revenue["growth"] as double) >= 0 ? Icons.trending_up : Icons.trending_down,
                                    color: (revenue["growth"] as double) >= 0 ? successColor : dangerColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "${(revenue["growth"] as double) >= 0 ? '+' : ''}${(revenue["growth"] as double).toStringAsFixed(1)}%",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: (revenue["growth"] as double) >= 0 ? successColor : dangerColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
