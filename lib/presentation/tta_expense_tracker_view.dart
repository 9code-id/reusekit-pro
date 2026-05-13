import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaExpenseTrackerView extends StatefulWidget {
  const TtaExpenseTrackerView({super.key});

  @override
  State<TtaExpenseTrackerView> createState() => _TtaExpenseTrackerViewState();
}

class _TtaExpenseTrackerViewState extends State<TtaExpenseTrackerView> {
  String selectedTrip = "Paris Adventure";
  String selectedCategory = "All Categories";
  int selectedTabIndex = 0;

  List<Map<String, dynamic>> trips = [
    {"label": "Paris Adventure", "value": "paris"},
    {"label": "Tokyo Business Trip", "value": "tokyo"},
    {"label": "London Vacation", "value": "london"},
    {"label": "New York Weekend", "value": "newyork"},
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All Categories", "value": "all"},
    {"label": "Accommodation", "value": "accommodation"},
    {"label": "Transportation", "value": "transportation"},
    {"label": "Food & Dining", "value": "food"},
    {"label": "Activities", "value": "activities"},
    {"label": "Shopping", "value": "shopping"},
    {"label": "Miscellaneous", "value": "miscellaneous"},
  ];

  List<Map<String, dynamic>> expenses = [
    {
      "id": 1,
      "title": "Hotel Royal Plaza",
      "category": "Accommodation",
      "amount": 350.00,
      "date": "2024-06-14",
      "time": "14:30",
      "location": "Paris, France",
      "paymentMethod": "Credit Card",
      "currency": "USD",
      "receipt": true,
      "icon": Icons.hotel,
      "color": primaryColor,
    },
    {
      "id": 2,
      "title": "Flight to Paris",
      "category": "Transportation",
      "amount": 800.00,
      "date": "2024-06-13",
      "time": "09:15",
      "location": "Charles de Gaulle Airport",
      "paymentMethod": "Credit Card",
      "currency": "USD",
      "receipt": true,
      "icon": Icons.flight,
      "color": infoColor,
    },
    {
      "id": 3,
      "title": "Le Petit Bistro",
      "category": "Food & Dining",
      "amount": 85.50,
      "date": "2024-06-14",
      "time": "19:45",
      "location": "Latin Quarter, Paris",
      "paymentMethod": "Cash",
      "currency": "EUR",
      "receipt": false,
      "icon": Icons.restaurant,
      "color": warningColor,
    },
    {
      "id": 4,
      "title": "Eiffel Tower Tour",
      "category": "Activities",
      "amount": 45.00,
      "date": "2024-06-15",
      "time": "10:00",
      "location": "Eiffel Tower, Paris",
      "paymentMethod": "Credit Card",
      "currency": "EUR",
      "receipt": true,
      "icon": Icons.attractions,
      "color": successColor,
    },
    {
      "id": 5,
      "title": "Metro Day Pass",
      "category": "Transportation",
      "amount": 12.00,
      "date": "2024-06-14",
      "time": "08:30",
      "location": "Metro Station",
      "paymentMethod": "Cash",
      "currency": "EUR",
      "receipt": false,
      "icon": Icons.directions_subway,
      "color": infoColor,
    },
    {
      "id": 6,
      "title": "Souvenir Shopping",
      "category": "Shopping",
      "amount": 120.00,
      "date": "2024-06-15",
      "time": "16:20",
      "location": "Champs-Élysées",
      "paymentMethod": "Credit Card",
      "currency": "EUR",
      "receipt": true,
      "icon": Icons.shopping_bag,
      "color": dangerColor,
    },
  ];

  List<Map<String, dynamic>> expenseSummary = [
    {
      "category": "Accommodation",
      "amount": 1050.00,
      "percentage": 42,
      "color": primaryColor,
      "icon": Icons.hotel,
    },
    {
      "category": "Transportation",
      "amount": 812.00,
      "percentage": 32,
      "color": infoColor,
      "icon": Icons.flight,
    },
    {
      "category": "Food & Dining",
      "amount": 385.50,
      "percentage": 15,
      "color": warningColor,
      "icon": Icons.restaurant,
    },
    {
      "category": "Activities",
      "amount": 145.00,
      "percentage": 6,
      "color": successColor,
      "icon": Icons.attractions,
    },
    {
      "category": "Shopping",
      "amount": 120.00,
      "percentage": 5,
      "color": dangerColor,
      "icon": Icons.shopping_bag,
    },
  ];

  double get totalExpenses {
    return expenses.fold(0.0, (sum, expense) => sum + (expense["amount"] as double));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Tracker"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // navigateTo(TtaAddExpenseView())
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Section
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Select Trip",
                        items: trips,
                        value: selectedTrip,
                        onChanged: (value, label) {
                          selectedTrip = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Category",
                        items: categories,
                        value: selectedCategory,
                        onChanged: (value, label) {
                          selectedCategory = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                // Total Expenses Display
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: primaryColor.withAlpha(30)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total Expenses",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "\$${totalExpenses.currency}",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.account_balance_wallet,
                        color: primaryColor,
                        size: 32,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Tab Section
          Expanded(
            child: QTabBar(
              withoutAppBar: true,
              selectedIndex: selectedTabIndex,
              tabs: [
                Tab(text: "Expenses", icon: Icon(Icons.receipt)),
                Tab(text: "Summary", icon: Icon(Icons.analytics)),
                Tab(text: "Charts", icon: Icon(Icons.pie_chart)),
              ],
              tabChildren: [
                // Expenses List Tab
                SingleChildScrollView(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    spacing: spSm,
                    children: expenses.map((expense) {
                      return Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusMd),
                          boxShadow: [shadowMd],
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(spSm),
                                  decoration: BoxDecoration(
                                    color: (expense["color"] as Color).withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Icon(
                                    expense["icon"],
                                    color: expense["color"] as Color,
                                    size: 24,
                                  ),
                                ),
                                SizedBox(width: spMd),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${expense["title"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "${expense["category"]} • ${expense["location"]}",
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
                                      "${expense["currency"] == "USD" ? "\$" : "€"}${((expense["amount"] as double)).currency}",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: expense["color"] as Color,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "${expense["date"]} ${expense["time"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: infoColor.withAlpha(10),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${expense["paymentMethod"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: infoColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                if (expense["receipt"] as bool) ...[
                                  SizedBox(width: spSm),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: successColor.withAlpha(10),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.check_circle,
                                          size: 12,
                                          color: successColor,
                                        ),
                                        SizedBox(width: spXs),
                                        Text(
                                          "Receipt",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: successColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    // navigateTo(TtaEditExpenseView())
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    color: disabledBoldColor,
                                    size: 20,
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

                // Summary Tab
                SingleChildScrollView(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    spacing: spMd,
                    children: [
                      Text(
                        "Expense Summary",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      ...expenseSummary.map((summary) {
                        return Container(
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusMd),
                            boxShadow: [shadowMd],
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: (summary["color"] as Color).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  summary["icon"],
                                  color: summary["color"] as Color,
                                  size: 24,
                                ),
                              ),
                              SizedBox(width: spMd),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${summary["category"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "${summary["percentage"]}% of total",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                "\$${((summary["amount"] as double)).currency}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: summary["color"] as Color,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),

                // Charts Tab
                Container(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    children: [
                      Text(
                        "Visual Analysis",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spLg),
                      Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.pie_chart,
                                size: 100,
                                color: disabledBoldColor,
                              ),
                              SizedBox(height: spMd),
                              Text(
                                "Charts Coming Soon",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spSm),
                              Text(
                                "Visual expense analytics will be available in the next update",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // navigateTo(TtaAddExpenseView())
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
