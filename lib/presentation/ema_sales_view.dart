import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaSalesView extends StatefulWidget {
  const EmaSalesView({super.key});

  @override
  State<EmaSalesView> createState() => _EmaSalesViewState();
}

class _EmaSalesViewState extends State<EmaSalesView> {
  String selectedPeriod = "This Month";
  String selectedCategory = "All Products";
  List<String> periods = ["Today", "This Week", "This Month", "This Quarter", "This Year"];
  List<String> categories = ["All Products", "Electronics", "Clothing", "Home & Garden", "Sports", "Books"];
  
  List<Map<String, dynamic>> salesData = [
    {
      "id": 1,
      "productName": "Wireless Headphones",
      "category": "Electronics",
      "unitsSold": 45,
      "revenue": 6750.0,
      "profit": 2025.0,
      "date": "2025-06-18",
      "region": "North America",
      "salesperson": "John Smith",
      "commission": 337.5,
    },
    {
      "id": 2,
      "productName": "Summer Dress",
      "category": "Clothing",
      "unitsSold": 28,
      "revenue": 1400.0,
      "profit": 560.0,
      "date": "2025-06-17",
      "region": "Europe",
      "salesperson": "Emma Johnson",
      "commission": 70.0,
    },
    {
      "id": 3,
      "productName": "Garden Tools Set",
      "category": "Home & Garden",
      "unitsSold": 15,
      "revenue": 2250.0,
      "profit": 900.0,
      "date": "2025-06-16",
      "region": "Asia Pacific",
      "salesperson": "Michael Chen",
      "commission": 112.5,
    },
    {
      "id": 4,
      "productName": "Running Shoes",
      "category": "Sports",
      "unitsSold": 62,
      "revenue": 9300.0,
      "profit": 3720.0,
      "date": "2025-06-15",
      "region": "North America",
      "salesperson": "Sarah Williams",
      "commission": 465.0,
    },
    {
      "id": 5,
      "productName": "Programming Books",
      "category": "Books",
      "unitsSold": 33,
      "revenue": 1650.0,
      "profit": 495.0,
      "date": "2025-06-14",
      "region": "Europe",
      "salesperson": "David Brown",
      "commission": 82.5,
    },
    {
      "id": 6,
      "productName": "Smart Watch",
      "category": "Electronics",
      "unitsSold": 38,
      "revenue": 11400.0,
      "profit": 4560.0,
      "date": "2025-06-13",
      "region": "Asia Pacific",
      "salesperson": "Lisa Garcia",
      "commission": 570.0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredSales = salesData.where((sale) {
      if (selectedCategory == "All Products") return true;
      return sale["category"] == selectedCategory;
    }).toList();

    double totalRevenue = filteredSales.fold(0.0, (sum, sale) => sum + (sale["revenue"] as double));
    double totalProfit = filteredSales.fold(0.0, (sum, sale) => sum + (sale["profit"] as double));
    int totalUnits = filteredSales.fold(0, (sum, sale) => sum + (sale["unitsSold"] as int));
    double totalCommission = filteredSales.fold(0.0, (sum, sale) => sum + (sale["commission"] as double));

    return Scaffold(
      appBar: AppBar(
        title: Text("Sales Analytics"),
        actions: [
          IconButton(
            icon: Icon(Icons.add_shopping_cart),
            onPressed: () {
              // navigateTo('NewSaleView')
            },
          ),
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () {
              // navigateTo('ExportSalesView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Period and Category Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Period",
                    items: periods.map((period) => {
                      "label": period,
                      "value": period,
                    }).toList(),
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
                    items: categories.map((category) => {
                      "label": category,
                      "value": category,
                    }).toList(),
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Sales Summary Cards
            ResponsiveGridView(
              minItemWidth: 200,
              children: [
                _buildSummaryCard(
                  title: "Total Revenue",
                  value: "\$${totalRevenue.currency}",
                  icon: Icons.monetization_on,
                  color: successColor,
                  trend: "+12.5%",
                ),
                _buildSummaryCard(
                  title: "Total Profit",
                  value: "\$${totalProfit.currency}",
                  icon: Icons.trending_up,
                  color: primaryColor,
                  trend: "+8.3%",
                ),
                _buildSummaryCard(
                  title: "Units Sold",
                  value: "${totalUnits}",
                  icon: Icons.inventory,
                  color: infoColor,
                  trend: "+15.2%",
                ),
                _buildSummaryCard(
                  title: "Commission",
                  value: "\$${totalCommission.currency}",
                  icon: Icons.account_balance_wallet,
                  color: warningColor,
                  trend: "+9.7%",
                ),
              ],
            ),

            // Top Performing Products
            Container(
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
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: warningColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Top Performing Products",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  ...filteredSales.take(3).map((sale) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: primaryColor.withAlpha(20)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: _getCategoryColor(sale["category"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              _getCategoryIcon(sale["category"]),
                              color: _getCategoryColor(sale["category"]),
                              size: 24,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${sale["productName"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${sale["category"]} • ${sale["unitsSold"]} units",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "\$${(sale["revenue"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "Profit: \$${(sale["profit"] as double).currency}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Sales by Region
            Container(
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
                  Row(
                    children: [
                      Icon(
                        Icons.public,
                        color: infoColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Sales by Region",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  _buildRegionChart(),
                ],
              ),
            ),

            // Recent Sales Activity
            Container(
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
                  Row(
                    children: [
                      Icon(
                        Icons.history,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Recent Sales Activity",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          // navigateTo('AllSalesView')
                        },
                        child: Text(
                          "View All",
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ...filteredSales.map((sale) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.shopping_bag,
                              color: successColor,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${sale["productName"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "By ${sale["salesperson"]} • ${sale["region"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "\$${(sale["revenue"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "${sale["unitsSold"]} units",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Quick Actions
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "New Sale",
                          size: bs.sm,
                          onPressed: () {
                            // navigateTo('NewSaleView')
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Generate Report",
                          size: bs.sm,
                          onPressed: () {
                            // navigateTo('SalesReportView')
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required String trend,
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  trend,
                  style: TextStyle(
                    color: successColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
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
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegionChart() {
    Map<String, double> regionSales = {};
    for (var sale in salesData) {
      String region = sale["region"];
      double revenue = sale["revenue"] as double;
      regionSales[region] = (regionSales[region] ?? 0) + revenue;
    }

    double maxValue = regionSales.values.isNotEmpty ? regionSales.values.reduce((a, b) => a > b ? a : b) : 0;

    return Column(
      children: regionSales.entries.map((entry) {
        double percentage = maxValue > 0 ? (entry.value / maxValue) : 0;
        return Container(
          margin: EdgeInsets.only(bottom: spSm),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    entry.key,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "\$${entry.value.currency}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spXs),
              Container(
                height: 8,
                decoration: BoxDecoration(
                  color: disabledColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: percentage,
                  child: Container(
                    decoration: BoxDecoration(
                      color: infoColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Electronics":
        return primaryColor;
      case "Clothing":
        return dangerColor;
      case "Home & Garden":
        return successColor;
      case "Sports":
        return warningColor;
      case "Books":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "Electronics":
        return Icons.devices;
      case "Clothing":
        return Icons.checkroom;
      case "Home & Garden":
        return Icons.home;
      case "Sports":
        return Icons.sports;
      case "Books":
        return Icons.book;
      default:
        return Icons.inventory;
    }
  }
}
