import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaBudgetVarianceView extends StatefulWidget {
  const ComaBudgetVarianceView({super.key});

  @override
  State<ComaBudgetVarianceView> createState() => _ComaBudgetVarianceViewState();
}

class _ComaBudgetVarianceViewState extends State<ComaBudgetVarianceView> {
  String selectedProject = "all";
  String selectedCategory = "all";
  String selectedTimeframe = "current_month";
  String searchQuery = "";

  List<Map<String, dynamic>> projects = [
    {
      "id": "PRJ001",
      "name": "Skyline Tower",
      "status": "active",
    },
    {
      "id": "PRJ002", 
      "name": "Harbor Bridge",
      "status": "active",
    },
    {
      "id": "PRJ003",
      "name": "Metro Station Complex",
      "status": "planning",
    },
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "Materials", "value": "materials"},
    {"label": "Labor", "value": "labor"},
    {"label": "Equipment", "value": "equipment"},
    {"label": "Subcontractors", "value": "subcontractors"},
    {"label": "Overhead", "value": "overhead"},
  ];

  List<Map<String, dynamic>> timeframes = [
    {"label": "Current Month", "value": "current_month"},
    {"label": "Quarter", "value": "quarter"},
    {"label": "Year to Date", "value": "year_to_date"},
    {"label": "Project Lifetime", "value": "lifetime"},
  ];

  List<Map<String, dynamic>> budgetVariances = [
    {
      "id": "VAR001",
      "projectId": "PRJ001",
      "projectName": "Skyline Tower",
      "category": "materials",
      "categoryName": "Materials",
      "budgetedAmount": 450000.0,
      "actualAmount": 487500.0,
      "variance": 37500.0,
      "variancePercentage": 8.33,
      "period": "2024-01",
      "status": "over_budget",
      "description": "Steel prices increased due to market conditions",
      "createdAt": "2024-01-15T10:30:00Z",
      "updatedAt": "2024-01-20T14:20:00Z",
    },
    {
      "id": "VAR002",
      "projectId": "PRJ001",
      "projectName": "Skyline Tower",
      "category": "labor",
      "categoryName": "Labor",
      "budgetedAmount": 320000.0,
      "actualAmount": 298000.0,
      "variance": -22000.0,
      "variancePercentage": -6.88,
      "period": "2024-01",
      "status": "under_budget",
      "description": "Efficient crew scheduling reduced overtime costs",
      "createdAt": "2024-01-15T10:30:00Z",
      "updatedAt": "2024-01-25T09:15:00Z",
    },
    {
      "id": "VAR003",
      "projectId": "PRJ002",
      "projectName": "Harbor Bridge",
      "category": "equipment",
      "categoryName": "Equipment",
      "budgetedAmount": 180000.0,
      "actualAmount": 195000.0,
      "variance": 15000.0,
      "variancePercentage": 8.33,
      "period": "2024-01",
      "status": "over_budget",
      "description": "Additional crane rental due to weather delays",
      "createdAt": "2024-01-10T08:45:00Z",
      "updatedAt": "2024-01-22T16:30:00Z",
    },
    {
      "id": "VAR004",
      "projectId": "PRJ002",
      "projectName": "Harbor Bridge",
      "category": "subcontractors",
      "categoryName": "Subcontractors",
      "budgetedAmount": 280000.0,
      "actualAmount": 275000.0,
      "variance": -5000.0,
      "variancePercentage": -1.79,
      "period": "2024-01",
      "status": "on_track",
      "description": "Electrical work completed within budget",
      "createdAt": "2024-01-08T11:20:00Z",
      "updatedAt": "2024-01-28T13:45:00Z",
    },
    {
      "id": "VAR005",
      "projectId": "PRJ003",
      "projectName": "Metro Station Complex",
      "category": "materials",
      "categoryName": "Materials",
      "budgetedAmount": 520000.0,
      "actualAmount": 545000.0,
      "variance": 25000.0,
      "variancePercentage": 4.81,
      "period": "2024-01",
      "status": "over_budget",
      "description": "Concrete costs higher than projected",
      "createdAt": "2024-01-12T09:30:00Z",
      "updatedAt": "2024-01-30T11:15:00Z",
    },
    {
      "id": "VAR006",
      "projectId": "PRJ001",
      "projectName": "Skyline Tower",
      "category": "overhead",
      "categoryName": "Overhead",
      "budgetedAmount": 85000.0,
      "actualAmount": 82000.0,
      "variance": -3000.0,
      "variancePercentage": -3.53,
      "period": "2024-01",
      "status": "under_budget",
      "description": "Reduced administrative costs",
      "createdAt": "2024-01-05T14:00:00Z",
      "updatedAt": "2024-01-31T17:20:00Z",
    },
  ];

  List<Map<String, dynamic>> get filteredVariances {
    List<Map<String, dynamic>> filtered = budgetVariances;

    if (selectedProject != "all") {
      filtered = filtered.where((variance) => variance["projectId"] == selectedProject).toList();
    }

    if (selectedCategory != "all") {
      filtered = filtered.where((variance) => variance["category"] == selectedCategory).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((variance) {
        return variance["projectName"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
            variance["categoryName"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
            variance["description"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    return filtered;
  }

  double get totalBudgetedAmount {
    return filteredVariances.fold(0.0, (sum, variance) => sum + (variance["budgetedAmount"] as double));
  }

  double get totalActualAmount {
    return filteredVariances.fold(0.0, (sum, variance) => sum + (variance["actualAmount"] as double));
  }

  double get totalVariance {
    return filteredVariances.fold(0.0, (sum, variance) => sum + (variance["variance"] as double));
  }

  double get averageVariancePercentage {
    if (filteredVariances.isEmpty) return 0.0;
    double totalPercentage = filteredVariances.fold(0.0, (sum, variance) => sum + (variance["variancePercentage"] as double));
    return totalPercentage / filteredVariances.length;
  }

  int get overBudgetCount {
    return filteredVariances.where((variance) => variance["status"] == "over_budget").length;
  }

  int get underBudgetCount {
    return filteredVariances.where((variance) => variance["status"] == "under_budget").length;
  }

  Color getVarianceColor(String status) {
    switch (status) {
      case "over_budget":
        return dangerColor;
      case "under_budget":
        return successColor;
      case "on_track":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  String getVarianceStatusText(String status) {
    switch (status) {
      case "over_budget":
        return "Over Budget";
      case "under_budget":
        return "Under Budget";
      case "on_track":
        return "On Track";
      default:
        return "Unknown";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Budget Variance"),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              si("Budget variance analytics opened");
            },
          ),
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () {
              si("Budget variance report exported");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
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
                            Icons.account_balance_wallet,
                            color: primaryColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Total Budget",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "\$${totalBudgetedAmount.currency}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${filteredVariances.length} variance entries",
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
                            Icons.trending_up,
                            color: totalVariance >= 0 ? dangerColor : successColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Total Variance",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.w600,
                              color: totalVariance >= 0 ? dangerColor : successColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${totalVariance >= 0 ? '+' : ''}\$${totalVariance.abs().currency}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: totalVariance >= 0 ? dangerColor : successColor,
                        ),
                      ),
                      Text(
                        "${averageVariancePercentage >= 0 ? '+' : ''}${averageVariancePercentage.toStringAsFixed(1)}% average",
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
                            Icons.warning,
                            color: warningColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Over Budget",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.w600,
                              color: warningColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "$overBudgetCount",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "items need attention",
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
                            Icons.check_circle,
                            color: successColor,
                            size: 24,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Under Budget",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.w600,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "$underBudgetCount",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "items performing well",
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

            // Filters
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
                        child: QTextField(
                          label: "Search variance",
                          value: searchQuery,
                          hint: "Search by project, category, or description",
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Project",
                          items: [
                            {"label": "All Projects", "value": "all"},
                            ...projects.map((project) => {
                              "label": "${project["name"]}",
                              "value": "${project["id"]}",
                            }),
                          ],
                          value: selectedProject,
                          onChanged: (value, label) {
                            selectedProject = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: QDropdownField(
                          label: "Category",
                          items: [
                            {"label": "All Categories", "value": "all"},
                            ...categories,
                          ],
                          value: selectedCategory,
                          onChanged: (value, label) {
                            selectedCategory = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: QDropdownField(
                          label: "Timeframe",
                          items: timeframes,
                          value: selectedTimeframe,
                          onChanged: (value, label) {
                            selectedTimeframe = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Variance List
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: disabledOutlineBorderColor,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Budget Variance Analysis",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          label: "Add Variance",
                          size: bs.sm,
                          onPressed: () {
                            si("Add new variance entry");
                          },
                        ),
                      ],
                    ),
                  ),
                  if (filteredVariances.isEmpty)
                    Container(
                      padding: EdgeInsets.all(spLg),
                      child: Column(
                        children: [
                          Icon(
                            Icons.analytics,
                            size: 64,
                            color: disabledColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "No variance data found",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Try adjusting your filters or add new variance entries",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    ...filteredVariances.map((variance) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: disabledOutlineBorderColor,
                              width: 0.5,
                            ),
                          ),
                        ),
                        child: Column(
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 4,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: getVarianceColor("${variance["status"]}"),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    spacing: spXs,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "${variance["projectName"]}",
                                            style: TextStyle(
                                              fontSize: fsH6,
                                              fontWeight: FontWeight.bold,
                                              color: primaryColor,
                                            ),
                                          ),
                                          Spacer(),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: spXs,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: getVarianceColor("${variance["status"]}").withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              getVarianceStatusText("${variance["status"]}"),
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: getVarianceColor("${variance["status"]}"),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "${variance["categoryName"]} • ${variance["period"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: disabledColor.withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Column(
                                spacing: spXs,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          spacing: 2,
                                          children: [
                                            Text(
                                              "Budgeted",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                            Text(
                                              "\$${(variance["budgetedAmount"] as double).currency}",
                                              style: TextStyle(
                                                fontSize: 16,
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
                                          spacing: 2,
                                          children: [
                                            Text(
                                              "Actual",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                            Text(
                                              "\$${(variance["actualAmount"] as double).currency}",
                                              style: TextStyle(
                                                fontSize: 16,
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
                                          spacing: 2,
                                          children: [
                                            Text(
                                              "Variance",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                            Text(
                                              "${(variance["variance"] as double) >= 0 ? '+' : ''}\$${((variance["variance"] as double).abs()).currency}",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: getVarianceColor("${variance["status"]}"),
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
                                            "Percentage",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                          Text(
                                            "${(variance["variancePercentage"] as double) >= 0 ? '+' : ''}${(variance["variancePercentage"] as double).toStringAsFixed(1)}%",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: getVarianceColor("${variance["status"]}"),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  if (variance["description"] != null && (variance["description"] as String).isNotEmpty)
                                    Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.only(top: spXs),
                                      child: Text(
                                        "${variance["description"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: disabledBoldColor,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: QButton(
                                          label: "View Details",
                                          size: bs.sm,
                                          onPressed: () {
                                            si("Viewing variance details for ${variance["id"]}");
                                          },
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Expanded(
                                        child: QButton(
                                          label: "Edit Variance",
                                          size: bs.sm,
                                          onPressed: () {
                                            si("Editing variance ${variance["id"]}");
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
                      );
                    }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
