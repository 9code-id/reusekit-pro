import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaProfitLossView extends StatefulWidget {
  const RmaProfitLossView({super.key});

  @override
  State<RmaProfitLossView> createState() => _RmaProfitLossViewState();
}

class _RmaProfitLossViewState extends State<RmaProfitLossView> {
  String selectedProperty = "all";
  String selectedPeriod = "monthly";
  String selectedYear = "2024";
  String selectedMonth = "06";

  List<Map<String, dynamic>> properties = [
    {"label": "All Properties", "value": "all"},
    {"label": "Sunset Apartments Unit 1A", "value": "sunset_1a"},
    {"label": "Downtown Loft 205", "value": "downtown_205"},
    {"label": "Garden View Villa", "value": "garden_villa"},
    {"label": "Metro Plaza Suite 12", "value": "metro_12"},
  ];

  List<Map<String, dynamic>> periodItems = [
    {"label": "Monthly", "value": "monthly"},
    {"label": "Quarterly", "value": "quarterly"},
    {"label": "Yearly", "value": "yearly"},
  ];

  List<Map<String, dynamic>> yearItems = [
    {"label": "2024", "value": "2024"},
    {"label": "2023", "value": "2023"},
    {"label": "2022", "value": "2022"},
  ];

  List<Map<String, dynamic>> monthItems = [
    {"label": "January", "value": "01"},
    {"label": "February", "value": "02"},
    {"label": "March", "value": "03"},
    {"label": "April", "value": "04"},
    {"label": "May", "value": "05"},
    {"label": "June", "value": "06"},
    {"label": "July", "value": "07"},
    {"label": "August", "value": "08"},
    {"label": "September", "value": "09"},
    {"label": "October", "value": "10"},
    {"label": "November", "value": "11"},
    {"label": "December", "value": "12"},
  ];

  // Sample data for demonstration
  Map<String, dynamic> _getProfitLossData() {
    return {
      "income": {
        "rental_income": 10800.0,
        "late_fees": 250.0,
        "pet_fees": 150.0,
        "application_fees": 100.0,
        "other_income": 75.0,
        "total": 11375.0,
      },
      "expenses": {
        "maintenance": 1450.0,
        "management": 1200.0,
        "insurance": 400.0,
        "property_tax": 800.0,
        "utilities": 350.0,
        "cleaning": 280.0,
        "supplies": 150.0,
        "advertising": 120.0,
        "legal": 300.0,
        "other": 200.0,
        "total": 5250.0,
      },
      "net_income": 6125.0,
      "previous_period": {
        "net_income": 5850.0,
        "change_percent": 4.7,
      },
    };
  }

  Map<String, List<Map<String, dynamic>>> _getMonthlyTrends() {
    return {
      "income": [
        {"month": "Jan", "amount": 10500.0},
        {"month": "Feb", "amount": 10800.0},
        {"month": "Mar", "amount": 11200.0},
        {"month": "Apr", "amount": 10900.0},
        {"month": "May", "amount": 11100.0},
        {"month": "Jun", "amount": 11375.0},
      ],
      "expenses": [
        {"month": "Jan", "amount": 4800.0},
        {"month": "Feb", "amount": 5200.0},
        {"month": "Mar", "amount": 5600.0},
        {"month": "Apr", "amount": 4900.0},
        {"month": "May", "amount": 5100.0},
        {"month": "Jun", "amount": 5250.0},
      ],
      "profit": [
        {"month": "Jan", "amount": 5700.0},
        {"month": "Feb", "amount": 5600.0},
        {"month": "Mar", "amount": 5600.0},
        {"month": "Apr", "amount": 6000.0},
        {"month": "May", "amount": 6000.0},
        {"month": "Jun", "amount": 6125.0},
      ],
    };
  }

  List<Map<String, dynamic>> _getPropertyBreakdown() {
    return [
      {
        "property": "Sunset Apartments Unit 1A",
        "income": 2500.0,
        "expenses": 1200.0,
        "profit": 1300.0,
        "margin": 52.0,
      },
      {
        "property": "Downtown Loft 205",
        "income": 3200.0,
        "expenses": 1400.0,
        "profit": 1800.0,
        "margin": 56.25,
      },
      {
        "property": "Garden View Villa",
        "income": 3500.0,
        "expenses": 1600.0,
        "profit": 1900.0,
        "margin": 54.29,
      },
      {
        "property": "Metro Plaza Suite 12",
        "income": 2800.0,
        "expenses": 1300.0,
        "profit": 1500.0,
        "margin": 53.57,
      },
    ];
  }

  Color _getTrendColor(double changePercent) {
    if (changePercent > 0) return successColor;
    if (changePercent < 0) return dangerColor;
    return disabledBoldColor;
  }

  String _formatCurrency(double amount) {
    return "\$${amount.currency}";
  }

  @override
  Widget build(BuildContext context) {
    final profitLossData = _getProfitLossData();
    final monthlyTrends = _getMonthlyTrends();
    final propertyBreakdown = _getPropertyBreakdown();

    return Scaffold(
      appBar: AppBar(
        title: Text("Profit & Loss"),
        actions: [
          IconButton(
            onPressed: () {
              si("Exporting P&L report");
            },
            icon: Icon(Icons.file_download),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Filter Section
            Container(
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
                        child: QDropdownField(
                          label: "Property",
                          items: properties,
                          value: selectedProperty,
                          onChanged: (value, label) {
                            selectedProperty = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Period",
                          items: periodItems,
                          value: selectedPeriod,
                          onChanged: (value, label) {
                            selectedPeriod = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  if (selectedPeriod == "monthly") ...[
                    Row(
                      children: [
                        Expanded(
                          child: QDropdownField(
                            label: "Year",
                            items: yearItems,
                            value: selectedYear,
                            onChanged: (value, label) {
                              selectedYear = value;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QDropdownField(
                            label: "Month",
                            items: monthItems,
                            value: selectedMonth,
                            onChanged: (value, label) {
                              selectedMonth = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),

            // Summary Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.trending_up,
                            color: successColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Total Income",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        _formatCurrency(profitLossData["income"]["total"]),
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Revenue generated",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.trending_down,
                            color: dangerColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Total Expenses",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        _formatCurrency(profitLossData["expenses"]["total"]),
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "Operating costs",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.account_balance_wallet,
                            color: primaryColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Net Profit",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        _formatCurrency(profitLossData["net_income"]),
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            profitLossData["previous_period"]["change_percent"] > 0 
                                ? Icons.arrow_upward 
                                : Icons.arrow_downward,
                            size: 12,
                            color: _getTrendColor(profitLossData["previous_period"]["change_percent"]),
                          ),
                          SizedBox(width: 2),
                          Text(
                            "${profitLossData["previous_period"]["change_percent"].toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 12,
                              color: _getTrendColor(profitLossData["previous_period"]["change_percent"]),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Income Breakdown
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
                    "Income Breakdown",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Column(
                    spacing: spXs,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: spXs),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Rental Income",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            Text(
                              _formatCurrency(profitLossData["income"]["rental_income"]),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: spXs),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Late Fees",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            Text(
                              _formatCurrency(profitLossData["income"]["late_fees"]),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: spXs),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Pet Fees",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            Text(
                              _formatCurrency(profitLossData["income"]["pet_fees"]),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: spXs),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Application Fees",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            Text(
                              _formatCurrency(profitLossData["income"]["application_fees"]),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: spXs),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Other Income",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            Text(
                              _formatCurrency(profitLossData["income"]["other_income"]),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: spXs),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Total Income",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              _formatCurrency(profitLossData["income"]["total"]),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Expenses Breakdown
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
                    "Expenses Breakdown",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Column(
                    spacing: spXs,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: spXs),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Maintenance & Repairs",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            Text(
                              _formatCurrency(profitLossData["expenses"]["maintenance"]),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: dangerColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: spXs),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Property Management",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            Text(
                              _formatCurrency(profitLossData["expenses"]["management"]),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: dangerColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: spXs),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Property Tax",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            Text(
                              _formatCurrency(profitLossData["expenses"]["property_tax"]),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: dangerColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: spXs),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Insurance",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),                            Text(
                              _formatCurrency(profitLossData["expenses"]["insurance"]),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: dangerColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: spXs),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Utilities",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            Text(
                              _formatCurrency(profitLossData["expenses"]["utilities"]),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: dangerColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: spXs),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Other Expenses",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            Text(
                              _formatCurrency((profitLossData["expenses"]["cleaning"] as double) + 
                                           (profitLossData["expenses"]["supplies"] as double) + 
                                           (profitLossData["expenses"]["advertising"] as double) + 
                                           (profitLossData["expenses"]["legal"] as double) + 
                                           (profitLossData["expenses"]["other"] as double)),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: dangerColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: spXs),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Total Expenses",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              _formatCurrency(profitLossData["expenses"]["total"]),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Property Performance
            if (selectedProperty == "all") ...[
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
                      "Property Performance",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: propertyBreakdown.length,
                      separatorBuilder: (context, index) => Divider(height: 1),
                      itemBuilder: (context, index) {
                        final property = propertyBreakdown[index];
                        return Container(
                          padding: EdgeInsets.symmetric(vertical: spSm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Text(
                                "${property["property"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      spacing: 2,
                                      children: [
                                        Text(
                                          "Income: ${_formatCurrency(property["income"])}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: successColor,
                                          ),
                                        ),
                                        Text(
                                          "Expenses: ${_formatCurrency(property["expenses"])}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: dangerColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    spacing: 2,
                                    children: [
                                      Text(
                                        "Profit: ${_formatCurrency(property["profit"])}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "Margin: ${(property["margin"] as double).toStringAsFixed(1)}%",
                                        style: TextStyle(
                                          fontSize: 12,
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
                      },
                    ),
                  ],
                ),
              ),
            ],

            // Monthly Trends Chart Placeholder
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
                    "6-Month Trend",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    height: 200,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: spSm,
                        children: [
                          Icon(
                            Icons.show_chart,
                            size: 48,
                            color: disabledColor,
                          ),
                          Text(
                            "Profit & Loss Trend Chart",
                            style: TextStyle(
                              fontSize: 16,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Interactive chart showing income vs expenses over time",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
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
    );
  }
}
