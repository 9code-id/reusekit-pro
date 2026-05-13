import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaLoanComparisonView extends StatefulWidget {
  const ReaLoanComparisonView({super.key});

  @override
  State<ReaLoanComparisonView> createState() => _ReaLoanComparisonViewState();
}

class _ReaLoanComparisonViewState extends State<ReaLoanComparisonView> {
  String loanAmount = "500000";
  String downPayment = "100000";
  String loanTerm = "30";
  String creditScore = "Excellent";
  
  List<String> selectedLenders = [];
  String comparisonType = "Interest Rate";

  List<Map<String, dynamic>> loanTerms = [
    {"label": "15 years", "value": "15"},
    {"label": "20 years", "value": "20"},
    {"label": "25 years", "value": "25"},
    {"label": "30 years", "value": "30"},
  ];

  List<Map<String, dynamic>> creditScores = [
    {"label": "Excellent (750+)", "value": "Excellent"},
    {"label": "Good (700-749)", "value": "Good"},
    {"label": "Fair (650-699)", "value": "Fair"},
    {"label": "Poor (600-649)", "value": "Poor"},
  ];

  List<Map<String, dynamic>> comparisonTypes = [
    {"label": "Interest Rate", "value": "Interest Rate"},
    {"label": "Monthly Payment", "value": "Monthly Payment"},
    {"label": "Total Cost", "value": "Total Cost"},
    {"label": "Closing Costs", "value": "Closing Costs"},
  ];

  List<Map<String, dynamic>> loanOptions = [
    {
      "id": 1,
      "lenderName": "First National Bank",
      "loanType": "Conventional",
      "interestRate": 3.75,
      "apr": 3.89,
      "monthlyPayment": 2315,
      "totalCost": 833400,
      "closingCosts": 12500,
      "processingFee": 500,
      "pointsOffered": 0,
      "rateLockedFor": 60,
      "processingTime": "30-45 days",
      "prepaymentPenalty": false,
      "features": [
        "No prepayment penalty",
        "Online application",
        "First-time buyer programs",
        "Rate lock options"
      ],
      "pros": [
        "Competitive rates",
        "Established lender",
        "Good customer service",
        "Multiple loan programs"
      ],
      "cons": [
        "Higher closing costs",
        "Longer processing time",
        "Strict documentation requirements"
      ],
      "rating": 4.5,
      "reviews": 1234,
      "contact": "(555) 123-4567"
    },
    {
      "id": 2,
      "lenderName": "Community Credit Union",
      "loanType": "Conventional",
      "interestRate": 3.65,
      "apr": 3.78,
      "monthlyPayment": 2289,
      "totalCost": 824040,
      "closingCosts": 9500,
      "processingFee": 300,
      "pointsOffered": 0.5,
      "rateLockedFor": 45,
      "processingTime": "25-35 days",
      "prepaymentPenalty": false,
      "features": [
        "Member benefits",
        "Lower fees",
        "Local service",
        "Flexible terms"
      ],
      "pros": [
        "Lower interest rate",
        "Reduced closing costs",
        "Member benefits",
        "Local relationship"
      ],
      "cons": [
        "Membership required",
        "Limited locations",
        "Fewer loan programs"
      ],
      "rating": 4.7,
      "reviews": 892,
      "contact": "(555) 234-5678"
    },
    {
      "id": 3,
      "lenderName": "Premier Mortgage Corp",
      "loanType": "Conventional",
      "interestRate": 3.85,
      "apr": 3.95,
      "monthlyPayment": 2341,
      "totalCost": 842760,
      "closingCosts": 15000,
      "processingFee": 750,
      "pointsOffered": 1,
      "rateLockedFor": 90,
      "processingTime": "20-30 days",
      "prepaymentPenalty": false,
      "features": [
        "Quick approval",
        "Jumbo loan specialist",
        "Investment property loans",
        "Competitive rates"
      ],
      "pros": [
        "Fast processing",
        "Jumbo loan expertise",
        "Longer rate lock",
        "Investment property options"
      ],
      "cons": [
        "Higher rates",
        "Higher closing costs",
        "Processing fees"
      ],
      "rating": 4.3,
      "reviews": 567,
      "contact": "(555) 345-6789"
    },
    {
      "id": 4,
      "lenderName": "Digital Home Loans",
      "loanType": "Conventional",
      "interestRate": 3.55,
      "apr": 3.72,
      "monthlyPayment": 2264,
      "totalCost": 815040,
      "closingCosts": 7500,
      "processingFee": 0,
      "pointsOffered": 0,
      "rateLockedFor": 30,
      "processingTime": "15-25 days",
      "prepaymentPenalty": false,
      "features": [
        "100% online process",
        "AI-powered approval",
        "24/7 support",
        "Paperless closing"
      ],
      "pros": [
        "Lowest interest rate",
        "No processing fees",
        "Fastest approval",
        "Digital convenience"
      ],
      "cons": [
        "No in-person service",
        "Shorter rate lock",
        "Limited loan programs"
      ],
      "rating": 4.6,
      "reviews": 2341,
      "contact": "(555) 456-7890"
    }
  ];

  Widget _buildComparisonCriteria() {
    return Container(
      margin: EdgeInsets.all(spMd),
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
              Icon(Icons.compare, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Comparison Criteria",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          
          Row(
            children: [
              Expanded(
                child: QNumberField(
                  label: "Loan Amount (\$)",
                  value: loanAmount,
                  onChanged: (value) {
                    loanAmount = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QNumberField(
                  label: "Down Payment (\$)",
                  value: downPayment,
                  onChanged: (value) {
                    downPayment = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Loan Term",
                  items: loanTerms,
                  value: loanTerm,
                  onChanged: (value, label) {
                    loanTerm = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Credit Score",
                  items: creditScores,
                  value: creditScore,
                  onChanged: (value, label) {
                    creditScore = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          QDropdownField(
            label: "Sort by",
            items: comparisonTypes,
            value: comparisonType,
            onChanged: (value, label) {
              comparisonType = value;
              setState(() {});
            },
          ),

          Container(
            width: double.infinity,
            child: QButton(
              label: "Update Comparison",
              icon: Icons.refresh,
              size: bs.md,
              onPressed: () {
                _updateComparison();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonTable() {
    final sortedLoans = _getSortedLoans();
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(25),
              borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
            ),
            child: Row(
              children: [
                Icon(Icons.table_chart, color: primaryColor),
                SizedBox(width: spSm),
                Text(
                  "Loan Comparison",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "Sorted by $comparisonType",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              padding: EdgeInsets.all(spMd),
              child: DataTable(
                columnSpacing: 20,
                headingRowColor: WidgetStateColor.resolveWith((states) => Colors.grey[100]!),
                columns: [
                  DataColumn(
                    label: Text(
                      "Lender",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Interest Rate",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "APR",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Monthly Payment",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Total Cost",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Closing Costs",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Actions",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
                rows: sortedLoans.map((loan) {
                  final isSelected = selectedLenders.contains("${loan["id"]}");
                  return DataRow(
                    selected: isSelected,
                    onSelectChanged: (selected) {
                      if (selected == true) {
                        selectedLenders.add("${loan["id"]}");
                      } else {
                        selectedLenders.remove("${loan["id"]}");
                      }
                      setState(() {});
                    },
                    cells: [
                      DataCell(
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${loan["lenderName"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${loan["loanType"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      DataCell(
                        Text(
                          "${loan["interestRate"]}%",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          "${loan["apr"]}%",
                          style: TextStyle(
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          "\$${loan["monthlyPayment"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          "\$${((loan["totalCost"] as int) / 1000).toInt()}K",
                          style: TextStyle(
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          "\$${((loan["closingCosts"] as int) / 1000).toStringAsFixed(1)}K",
                          style: TextStyle(
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                      DataCell(
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.info, size: 20),
                              onPressed: () => _showLoanDetails(loan),
                            ),
                            IconButton(
                              icon: Icon(Icons.phone, size: 20),
                              onPressed: () => _contactLender(loan),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedComparison() {
    if (selectedLenders.isEmpty) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: spMd),
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
        ),
        child: Column(
          children: [
            Icon(Icons.compare, size: 64, color: disabledColor),
            SizedBox(height: spMd),
            Text(
              "Select loans to compare",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.w600,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Check the boxes in the table above to compare loans side by side",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: disabledColor,
              ),
            ),
          ],
        ),
      );
    }

    final selectedLoans = loanOptions.where((loan) => 
        selectedLenders.contains("${loan["id"]}")).toList();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Text(
              "Detailed Comparison (${selectedLoans.length} loans)",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
          QHorizontalScroll(
            children: selectedLoans.map((loan) => _buildDetailCard(loan)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailCard(Map<String, dynamic> loan) {
    return Container(
      width: 300,
      margin: EdgeInsets.only(right: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [primaryColor.withAlpha(25), Colors.white],
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${loan["lenderName"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: successColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star, color: Colors.white, size: 12),
                          SizedBox(width: spXs),
                          Text(
                            "${loan["rating"]}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${loan["reviews"]} reviews",
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

          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              spacing: spSm,
              children: [
                // Key Metrics
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    spacing: spSm,
                    children: [
                      _buildMetricRow("Interest Rate", "${loan["interestRate"]}%"),
                      _buildMetricRow("APR", "${loan["apr"]}%"),
                      _buildMetricRow("Monthly Payment", "\$${loan["monthlyPayment"]}"),
                      _buildMetricRow("Total Cost", "\$${((loan["totalCost"] as int) / 1000).toInt()}K"),
                      _buildMetricRow("Closing Costs", "\$${((loan["closingCosts"] as int) / 1000).toStringAsFixed(1)}K"),
                      _buildMetricRow("Processing Time", "${loan["processingTime"]}"),
                    ],
                  ),
                ),

                // Pros
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pros",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      ...(loan["pros"] as List).map((pro) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: spXs),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.check, color: successColor, size: 16),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  "${pro}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: successColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),

                // Cons
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Cons",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: warningColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      ...(loan["cons"] as List).map((con) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: spXs),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.close, color: warningColor, size: 16),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  "${con}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: warningColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),

                // Actions
                Column(
                  spacing: spSm,
                  children: [
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Apply Now",
                        icon: Icons.assignment,
                        size: bs.sm,
                        onPressed: () {
                          _applyForLoan(loan);
                        },
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Details",
                            icon: Icons.info,
                            size: bs.sm,
                            onPressed: () => _showLoanDetails(loan),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Contact",
                            icon: Icons.phone,
                            size: bs.sm,
                            onPressed: () => _contactLender(loan),
                          ),
                        ),
                      ],
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

  Widget _buildMetricRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  List<Map<String, dynamic>> _getSortedLoans() {
    final sortedLoans = List<Map<String, dynamic>>.from(loanOptions);
    
    switch (comparisonType) {
      case "Interest Rate":
        sortedLoans.sort((a, b) => (a["interestRate"] as double).compareTo(b["interestRate"] as double));
        break;
      case "Monthly Payment":
        sortedLoans.sort((a, b) => (a["monthlyPayment"] as int).compareTo(b["monthlyPayment"] as int));
        break;
      case "Total Cost":
        sortedLoans.sort((a, b) => (a["totalCost"] as int).compareTo(b["totalCost"] as int));
        break;
      case "Closing Costs":
        sortedLoans.sort((a, b) => (a["closingCosts"] as int).compareTo(b["closingCosts"] as int));
        break;
    }
    
    return sortedLoans;
  }

  void _updateComparison() {
    ss("Comparison updated with new criteria");
    setState(() {});
  }

  void _showLoanDetails(Map<String, dynamic> loan) {
    // Show detailed loan information
    si("Showing details for ${loan["lenderName"]}");
  }

  void _contactLender(Map<String, dynamic> loan) {
    // Contact lender
    si("Contacting ${loan["lenderName"]} at ${loan["contact"]}");
  }

  void _applyForLoan(Map<String, dynamic> loan) {
    // Start loan application
    ss("Starting application with ${loan["lenderName"]}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Loan Comparison"),
        actions: [
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {
              // Show comparison help
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildComparisonCriteria(),
            SizedBox(height: spMd),
            _buildComparisonTable(),
            SizedBox(height: spMd),
            _buildDetailedComparison(),
            SizedBox(height: spMd),
          ],
        ),
      ),
    );
  }
}
