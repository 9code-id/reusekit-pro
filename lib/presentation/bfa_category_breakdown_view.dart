import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaCategoryBreakdownView extends StatefulWidget {
  const BfaCategoryBreakdownView({super.key});

  @override
  State<BfaCategoryBreakdownView> createState() => _BfaCategoryBreakdownViewState();
}

class _BfaCategoryBreakdownViewState extends State<BfaCategoryBreakdownView> {
  String selectedPeriod = "This Month";
  String sortBy = "Amount";
  
  List<Map<String, dynamic>> timeframes = [
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "Last 3 Months", "value": "Last 3 Months"},
    {"label": "This Year", "value": "This Year"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Amount", "value": "Amount"},
    {"label": "Percentage", "value": "Percentage"},
    {"label": "Transactions", "value": "Transactions"},
    {"label": "Change", "value": "Change"},
  ];

  List<Map<String, dynamic>> categories = [
    {
      "name": "Food & Dining",
      "amount": 1485.75,
      "percentage": 28.5,
      "transactions": 67,
      "change": 12.3,
      "avgTransaction": 22.17,
      "topMerchant": "Starbucks",
      "icon": Icons.restaurant,
      "color": warningColor,
      "subcategories": [
        {"name": "Restaurants", "amount": 890.50, "percentage": 59.9},
        {"name": "Coffee Shops", "amount": 345.25, "percentage": 23.2},
        {"name": "Fast Food", "amount": 250.00, "percentage": 16.8},
      ],
    },
    {
      "name": "Transportation",
      "amount": 1125.60,
      "percentage": 21.6,
      "transactions": 34,
      "change": -8.7,
      "avgTransaction": 33.11,
      "topMerchant": "Shell",
      "icon": Icons.directions_car,
      "color": primaryColor,
      "subcategories": [
        {"name": "Gas", "amount": 675.40, "percentage": 60.0},
        {"name": "Public Transport", "amount": 285.20, "percentage": 25.3},
        {"name": "Parking", "amount": 165.00, "percentage": 14.7},
      ],
    },
    {
      "name": "Shopping",
      "amount": 975.25,
      "percentage": 18.7,
      "transactions": 28,
      "change": 15.8,
      "avgTransaction": 34.83,
      "topMerchant": "Amazon",
      "icon": Icons.shopping_bag,
      "color": successColor,
      "subcategories": [
        {"name": "Online Shopping", "amount": 585.15, "percentage": 60.0},
        {"name": "Clothing", "amount": 234.10, "percentage": 24.0},
        {"name": "Electronics", "amount": 156.00, "percentage": 16.0},
      ],
    },
    {
      "name": "Entertainment",
      "amount": 685.50,
      "percentage": 13.2,
      "transactions": 22,
      "change": 25.4,
      "avgTransaction": 31.16,
      "topMerchant": "Netflix",
      "icon": Icons.movie,
      "color": infoColor,
      "subcategories": [
        {"name": "Streaming Services", "amount": 275.40, "percentage": 40.2},
        {"name": "Movies & Events", "amount": 245.10, "percentage": 35.8},
        {"name": "Gaming", "amount": 165.00, "percentage": 24.1},
      ],
    },
    {
      "name": "Bills & Utilities",
      "amount": 485.75,
      "percentage": 9.3,
      "transactions": 12,
      "change": -3.2,
      "avgTransaction": 40.48,
      "topMerchant": "Electric Company",
      "icon": Icons.receipt,
      "color": dangerColor,
      "subcategories": [
        {"name": "Electricity", "amount": 185.25, "percentage": 38.1},
        {"name": "Internet", "amount": 155.50, "percentage": 32.0},
        {"name": "Water", "amount": 145.00, "percentage": 29.9},
      ],
    },
    {
      "name": "Health & Fitness",
      "amount": 425.80,
      "percentage": 8.2,
      "transactions": 18,
      "change": 7.9,
      "avgTransaction": 23.66,
      "topMerchant": "Pharmacy Plus",
      "icon": Icons.fitness_center,
      "color": successColor,
      "subcategories": [
        {"name": "Pharmacy", "amount": 185.40, "percentage": 43.5},
        {"name": "Gym Membership", "amount": 125.40, "percentage": 29.4},
        {"name": "Medical", "amount": 115.00, "percentage": 27.0},
      ],
    },
    {
      "name": "Travel",
      "amount": 285.50,
      "percentage": 5.5,
      "transactions": 8,
      "change": 45.2,
      "avgTransaction": 35.69,
      "topMerchant": "Booking.com",
      "icon": Icons.flight,
      "color": primaryColor,
      "subcategories": [
        {"name": "Hotels", "amount": 165.30, "percentage": 57.9},
        {"name": "Flights", "amount": 85.20, "percentage": 29.9},
        {"name": "Car Rental", "amount": 35.00, "percentage": 12.3},
      ],
    },
  ];

  double getTotalAmount() {
    return categories.fold(0.0, (sum, cat) => sum + (cat["amount"] as double));
  }

  int getTotalTransactions() {
    return categories.fold(0, (sum, cat) => sum + (cat["transactions"] as int));
  }

  List<Map<String, dynamic>> getSortedCategories() {
    List<Map<String, dynamic>> sorted = List.from(categories);
    
    switch (sortBy) {
      case "Amount":
        sorted.sort((a, b) => (b["amount"] as double).compareTo(a["amount"] as double));
        break;
      case "Percentage":
        sorted.sort((a, b) => (b["percentage"] as double).compareTo(a["percentage"] as double));
        break;
      case "Transactions":
        sorted.sort((a, b) => (b["transactions"] as int).compareTo(a["transactions"] as int));
        break;
      case "Change":
        sorted.sort((a, b) => (b["change"] as double).compareTo(a["change"] as double));
        break;
    }
    
    return sorted;
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> sortedCategories = getSortedCategories();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Category Breakdown"),
        actions: [
          IconButton(
            onPressed: () {
              // Share report
            },
            icon: Icon(Icons.share),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Time Period",
                    items: timeframes,
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
                    label: "Sort By",
                    items: sortOptions,
                    value: sortBy,
                    onChanged: (value, label) {
                      sortBy = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Overview Summary
            Container(
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
                    "Spending Summary",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildSummaryCard(
                          "Total Spent",
                          "\$${getTotalAmount().currency}",
                          Icons.account_balance_wallet,
                          primaryColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildSummaryCard(
                          "Categories",
                          "${categories.length}",
                          Icons.category,
                          successColor,
                        ),
                      ),
                    ],
                  ),
                  _buildSummaryCard(
                    "Total Transactions",
                    "${getTotalTransactions()}",
                    Icons.receipt_long,
                    infoColor,
                  ),
                ],
              ),
            ),

            // Visual Chart Placeholder
            Container(
              height: 200,
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
                    "Category Distribution",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: sortedCategories.take(5).map((category) {
                        double heightRatio = (category["percentage"] as double) / 100;
                        
                        return Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 2),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "${(category["percentage"] as double).toStringAsFixed(0)}%",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Container(
                                  height: 100 * heightRatio,
                                  decoration: BoxDecoration(
                                    color: category["color"] as Color,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Icon(
                                  category["icon"] as IconData,
                                  size: 16,
                                  color: category["color"] as Color,
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            // Category Details
            Text(
              "Category Details",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            Column(
              spacing: spSm,
              children: sortedCategories.map((category) {
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
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: (category["color"] as Color).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              category["icon"] as IconData,
                              color: category["color"] as Color,
                              size: 24,
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
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${category["transactions"]} transactions • Top: ${category["topMerchant"]}",
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
                                "\$${(category["amount"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: category["color"] as Color,
                                ),
                              ),
                              Text(
                                "${(category["percentage"] as double).toStringAsFixed(1)}% of total",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Icon(
                                  (category["change"] as double) >= 0 ? Icons.trending_up : Icons.trending_down,
                                  size: 16,
                                  color: (category["change"] as double) >= 0 ? dangerColor : successColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${(category["change"] as double) >= 0 ? '+' : ''}${(category["change"] as double).toStringAsFixed(1)}% vs last period",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: (category["change"] as double) >= 0 ? dangerColor : successColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "Avg: \$${(category["avgTransaction"] as double).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),

                      // Subcategories
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: (category["color"] as Color).withAlpha(5),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "Subcategories",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                            Column(
                              spacing: spXs,
                              children: (category["subcategories"] as List<Map<String, dynamic>>).map((sub) {
                                return Row(
                                  children: [
                                    Container(
                                      width: 4,
                                      height: 4,
                                      decoration: BoxDecoration(
                                        color: category["color"] as Color,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Expanded(
                                      child: Text(
                                        "${sub["name"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "\$${(sub["amount"] as double).currency}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "(${(sub["percentage"] as double).toStringAsFixed(1)}%)",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "View Category Details",
                          icon: Icons.arrow_forward,
                          size: bs.sm,
                          onPressed: () {
                            // View detailed category analysis
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Quick Actions
            Container(
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
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Set Category Budgets",
                          icon: Icons.edit,
                          size: bs.sm,
                          onPressed: () {
                            // Set budgets for categories
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Export Report",
                          icon: Icons.file_download,
                          size: bs.sm,
                          onPressed: () {
                            // Export category breakdown
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

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: color.withAlpha(30),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Text(
            value,
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
}
