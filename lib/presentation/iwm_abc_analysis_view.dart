import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class IwmAbcAnalysisView extends StatefulWidget {
  const IwmAbcAnalysisView({super.key});

  @override
  State<IwmAbcAnalysisView> createState() => _IwmAbcAnalysisViewState();
}

class _IwmAbcAnalysisViewState extends State<IwmAbcAnalysisView> {
  String selectedCriteria = "Revenue";
  String selectedPeriod = "Last 12 Months";
  String selectedCategory = "All Categories";
  String selectedClassification = "All Classifications";
  bool loading = false;

  List<Map<String, dynamic>> criteriaItems = [
    {"label": "Revenue", "value": "Revenue"},
    {"label": "Quantity", "value": "Quantity"},
    {"label": "Profit", "value": "Profit"},
    {"label": "Usage Frequency", "value": "Usage Frequency"},
  ];

  List<Map<String, dynamic>> periodItems = [
    {"label": "Last 3 Months", "value": "Last 3 Months"},
    {"label": "Last 6 Months", "value": "Last 6 Months"},
    {"label": "Last 12 Months", "value": "Last 12 Months"},
    {"label": "This Year", "value": "This Year"},
  ];

  List<Map<String, dynamic>> categoryItems = [
    {"label": "All Categories", "value": "All Categories"},
    {"label": "Electronics", "value": "Electronics"},
    {"label": "Raw Materials", "value": "Raw Materials"},
    {"label": "Components", "value": "Components"},
    {"label": "Tools", "value": "Tools"},
    {"label": "Supplies", "value": "Supplies"},
  ];

  List<Map<String, dynamic>> classificationItems = [
    {"label": "All Classifications", "value": "All Classifications"},
    {"label": "Class A", "value": "Class A"},
    {"label": "Class B", "value": "Class B"},
    {"label": "Class C", "value": "Class C"},
  ];

  Map<String, dynamic> abcSummary = {
    "classA": {
      "items": 89,
      "percentage": 20,
      "revenue": 1680000,
      "revenuePercentage": 80,
    },
    "classB": {
      "items": 134,
      "percentage": 30,
      "revenue": 336000,
      "revenuePercentage": 16,
    },
    "classC": {
      "items": 223,
      "percentage": 50,
      "revenue": 84000,
      "revenuePercentage": 4,
    },
  };

  List<Map<String, dynamic>> abcItems = [
    {
      "id": "ITM001",
      "name": "Laptop Dell XPS 13",
      "category": "Electronics",
      "classification": "Class A",
      "revenue": 216000,
      "quantity": 180,
      "profit": 32400,
      "unitPrice": 1200.00,
      "contribution": 10.3,
      "cumulativeContribution": 10.3,
    },
    {
      "id": "ITM002",
      "name": "Industrial Steel Beam",
      "category": "Raw Materials",
      "classification": "Class A",
      "revenue": 425000,
      "quantity": 850,
      "profit": 63750,
      "unitPrice": 500.00,
      "contribution": 20.2,
      "cumulativeContribution": 30.5,
    },
    {
      "id": "ITM003",
      "name": "iPhone 15 Pro",
      "category": "Electronics",
      "classification": "Class A",
      "revenue": 380000,
      "quantity": 380,
      "profit": 57000,
      "unitPrice": 1000.00,
      "contribution": 18.1,
      "cumulativeContribution": 48.6,
    },
    {
      "id": "ITM004",
      "name": "MacBook Pro M3",
      "category": "Electronics",
      "classification": "Class A",
      "revenue": 320000,
      "quantity": 160,
      "profit": 48000,
      "unitPrice": 2000.00,
      "contribution": 15.2,
      "cumulativeContribution": 63.8,
    },
    {
      "id": "ITM005",
      "name": "Samsung Galaxy S24",
      "category": "Electronics",
      "classification": "Class A",
      "revenue": 280000,
      "quantity": 350,
      "profit": 42000,
      "unitPrice": 800.00,
      "contribution": 13.3,
      "cumulativeContribution": 77.1,
    },
    {
      "id": "ITM006",
      "name": "Office Chair Premium",
      "category": "Furniture",
      "classification": "Class B",
      "revenue": 45000,
      "quantity": 150,
      "profit": 6750,
      "unitPrice": 300.00,
      "contribution": 2.1,
      "cumulativeContribution": 79.2,
    },
    {
      "id": "ITM007",
      "name": "Wireless Mouse Logitech",
      "category": "Electronics",
      "classification": "Class B",
      "revenue": 15000,
      "quantity": 300,
      "profit": 2250,
      "unitPrice": 50.00,
      "contribution": 0.7,
      "cumulativeContribution": 79.9,
    },
    {
      "id": "ITM008",
      "name": "USB Type-C Cable",
      "category": "Electronics",
      "classification": "Class B",
      "revenue": 12000,
      "quantity": 800,
      "profit": 1800,
      "unitPrice": 15.00,
      "contribution": 0.6,
      "cumulativeContribution": 80.5,
    },
    {
      "id": "ITM009",
      "name": "A4 Paper Ream",
      "category": "Supplies",
      "classification": "Class C",
      "revenue": 7200,
      "quantity": 2400,
      "profit": 1080,
      "unitPrice": 3.00,
      "contribution": 0.3,
      "cumulativeContribution": 80.8,
    },
    {
      "id": "ITM010",
      "name": "Pen Blue Ink",
      "category": "Supplies",
      "classification": "Class C",
      "revenue": 2400,
      "quantity": 4800,
      "profit": 360,
      "unitPrice": 0.50,
      "contribution": 0.1,
      "cumulativeContribution": 80.9,
    },
  ];

  Color _getClassificationColor(String classification) {
    switch (classification) {
      case "Class A":
        return successColor;
      case "Class B":
        return warningColor;
      case "Class C":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildSummaryCard(String className, Map<String, dynamic> data) {
    Color classColor = _getClassificationColor(className);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: classColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: classColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  className,
                  style: TextStyle(
                    fontSize: 14,
                    color: classColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Spacer(),
              Text(
                "${data["percentage"]}% of items",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${data["items"]} Items",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "\$${((data["revenue"] as num).toDouble()).currency}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: successColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "${data["revenuePercentage"]}% of total revenue",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemCard(Map<String, dynamic> item) {
    Color classColor = _getClassificationColor(item["classification"]);

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: classColor,
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
                      "${item["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${item["id"]} • ${item["category"]}",
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
                  color: classColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${item["classification"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: classColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.all(0),
            minItemWidth: 200,
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(12),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Revenue",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "\$${((item["revenue"] as num).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(12),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Quantity Sold",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${item["quantity"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Unit Price: \$${(item["unitPrice"] as double).currency}",
                      style: TextStyle(
                        fontSize: 13,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Profit: \$${((item["profit"] as num).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Contribution: ${(item["contribution"] as num).toStringAsFixed(1)}%",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Cumulative: ${(item["cumulativeContribution"] as num).toStringAsFixed(1)}%",
                    style: TextStyle(
                      fontSize: 13,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            child: QButton(
              label: "View Details",
              size: bs.sm,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> get filteredItems {
    return abcItems.where((item) {
      bool matchesCategory = selectedCategory == "All Categories" || item["category"] == selectedCategory;
      bool matchesClassification = selectedClassification == "All Classifications" || item["classification"] == selectedClassification;
      return matchesCategory && matchesClassification;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ABC Analysis"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {},
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
                  // Analysis Configuration
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
                        Text(
                          "Analysis Configuration",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Expanded(
                              child: QDropdownField(
                                label: "Criteria",
                                items: criteriaItems,
                                value: selectedCriteria,
                                onChanged: (value, label) {
                                  selectedCriteria = value;
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
                        SizedBox(height: spSm),
                        Container(
                          width: double.infinity,
                          child: QButton(
                            label: "Run Analysis",
                            size: bs.md,
                            onPressed: () {
                              ss("ABC Analysis completed successfully");
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ABC Summary
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
                        Text(
                          "ABC Classification Summary",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        ResponsiveGridView(
                          padding: EdgeInsets.all(0),
                          minItemWidth: 200,
                          children: [
                            _buildSummaryCard("Class A", abcSummary["classA"]),
                            _buildSummaryCard("Class B", abcSummary["classB"]),
                            _buildSummaryCard("Class C", abcSummary["classC"]),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Classification Guidelines
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.info, color: infoColor),
                            SizedBox(width: spSm),
                            Text(
                              "ABC Classification Guidelines",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            Container(
                              width: 4,
                              height: 16,
                              color: successColor,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "Class A: Top 20% of items contributing 80% of revenue",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Container(
                              width: 4,
                              height: 16,
                              color: warningColor,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "Class B: Next 30% of items contributing 15% of revenue",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Container(
                              width: 4,
                              height: 16,
                              color: dangerColor,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "Class C: Remaining 50% of items contributing 5% of revenue",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Filters
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Category",
                          items: categoryItems,
                          value: selectedCategory,
                          onChanged: (value, label) {
                            selectedCategory = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Classification",
                          items: classificationItems,
                          value: selectedClassification,
                          onChanged: (value, label) {
                            selectedClassification = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),

                  // Items List
                  Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Items Analysis (${filteredItems.length})",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Spacer(),
                            QButton(
                              label: "Export",
                              icon: Icons.download,
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        ...filteredItems.map((item) => _buildItemCard(item)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
