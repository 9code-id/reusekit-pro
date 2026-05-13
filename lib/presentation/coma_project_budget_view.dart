import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaProjectBudgetView extends StatefulWidget {
  const ComaProjectBudgetView({Key? key}) : super(key: key);

  @override
  State<ComaProjectBudgetView> createState() => _ComaProjectBudgetViewState();
}

class _ComaProjectBudgetViewState extends State<ComaProjectBudgetView> {
  String selectedBudgetFilter = "all";
  String searchQuery = "";
  bool loading = false;

  List<Map<String, dynamic>> budgetFilters = [
    {"label": "All Projects", "value": "all", "count": 18},
    {"label": "Under Budget", "value": "under", "count": 8},
    {"label": "On Budget", "value": "on_budget", "count": 6},
    {"label": "Over Budget", "value": "over", "count": 4},
  ];

  List<Map<String, dynamic>> projectBudgets = [
    {
      "id": "PRJ-2024-001",
      "project_name": "Metro Downtown Complex",
      "client_name": "Metro Development Corp",
      "total_budget": 2500000.0,
      "budget_allocated": 2500000.0,
      "budget_spent": 1700000.0,
      "budget_remaining": 800000.0,
      "budget_variance": -50000.0,
      "budget_status": "over",
      "spending_rate": 68.0,
      "projected_cost": 2550000.0,
      "cost_per_phase": {
        "planning": 125000.0,
        "design": 200000.0,
        "construction": 1800000.0,
        "finishing": 375000.0,
      },
      "change_orders_cost": 150000.0,
      "contingency_used": 75000.0,
      "contingency_total": 250000.0,
      "labor_costs": 1020000.0,
      "material_costs": 480000.0,
      "equipment_costs": 200000.0,
      "overhead_costs": 300000.0,
      "profit_margin": 12.5,
      "payment_schedule": "Monthly",
      "invoice_submitted": 1650000.0,
      "invoice_paid": 1500000.0,
      "invoice_pending": 150000.0,
      "budget_manager": "Sarah Johnson",
      "last_updated": "2024-06-15",
      "next_payment": "2024-07-01",
      "payment_terms": "Net 30",
      "currency": "USD",
      "tax_rate": 8.5,
      "progress_percentage": 68,
    },
    {
      "id": "PRJ-2024-002",
      "project_name": "Riverside Office Park",
      "client_name": "Riverside Properties LLC",
      "total_budget": 1800000.0,
      "budget_allocated": 1800000.0,
      "budget_spent": 1750000.0,
      "budget_remaining": 50000.0,
      "budget_variance": -25000.0,
      "budget_status": "on_budget",
      "spending_rate": 97.2,
      "projected_cost": 1775000.0,
      "cost_per_phase": {
        "planning": 90000.0,
        "design": 150000.0,
        "construction": 1200000.0,
        "finishing": 335000.0,
      },
      "change_orders_cost": 75000.0,
      "contingency_used": 125000.0,
      "contingency_total": 180000.0,
      "labor_costs": 945000.0,
      "material_costs": 525000.0,
      "equipment_costs": 280000.0,
      "overhead_costs": 225000.0,
      "profit_margin": 15.0,
      "payment_schedule": "Bi-weekly",
      "invoice_submitted": 1750000.0,
      "invoice_paid": 1650000.0,
      "invoice_pending": 100000.0,
      "budget_manager": "Michael Chen",
      "last_updated": "2024-06-14",
      "next_payment": "2024-06-28",
      "payment_terms": "Net 15",
      "currency": "USD",
      "tax_rate": 7.25,
      "progress_percentage": 100,
    },
    {
      "id": "PRJ-2024-003",
      "project_name": "Healthcare Facility Expansion",
      "client_name": "Metro Health System",
      "total_budget": 3200000.0,
      "budget_allocated": 3200000.0,
      "budget_spent": 1350000.0,
      "budget_remaining": 1850000.0,
      "budget_variance": 180000.0,
      "budget_status": "over",
      "spending_rate": 42.2,
      "projected_cost": 3580000.0,
      "cost_per_phase": {
        "planning": 160000.0,
        "design": 320000.0,
        "construction": 2400000.0,
        "finishing": 700000.0,
      },
      "change_orders_cost": 380000.0,
      "contingency_used": 220000.0,
      "contingency_total": 320000.0,
      "labor_costs": 810000.0,
      "material_costs": 360000.0,
      "equipment_costs": 180000.0,
      "overhead_costs": 380000.0,
      "profit_margin": 10.5,
      "payment_schedule": "Monthly",
      "invoice_submitted": 1200000.0,
      "invoice_paid": 1050000.0,
      "invoice_pending": 150000.0,
      "budget_manager": "Emily Rodriguez",
      "last_updated": "2024-06-16",
      "next_payment": "2024-07-05",
      "payment_terms": "Net 45",
      "currency": "USD",
      "tax_rate": 9.0,
      "progress_percentage": 35,
    },
    {
      "id": "PRJ-2024-004",
      "project_name": "Residential Tower A",
      "client_name": "Urban Living Solutions",
      "total_budget": 4500000.0,
      "budget_allocated": 4500000.0,
      "budget_spent": 3100000.0,
      "budget_remaining": 1400000.0,
      "budget_variance": -150000.0,
      "budget_status": "under",
      "spending_rate": 68.9,
      "projected_cost": 4350000.0,
      "cost_per_phase": {
        "planning": 225000.0,
        "design": 360000.0,
        "construction": 3150000.0,
        "finishing": 765000.0,
      },
      "change_orders_cost": 125000.0,
      "contingency_used": 180000.0,
      "contingency_total": 450000.0,
      "labor_costs": 1860000.0,
      "material_costs": 930000.0,
      "equipment_costs": 310000.0,
      "overhead_costs": 450000.0,
      "profit_margin": 14.0,
      "payment_schedule": "Bi-weekly",
      "invoice_submitted": 3000000.0,
      "invoice_paid": 2750000.0,
      "invoice_pending": 250000.0,
      "budget_manager": "David Wilson",
      "last_updated": "2024-06-17",
      "next_payment": "2024-06-30",
      "payment_terms": "Net 20",
      "currency": "USD",
      "tax_rate": 8.25,
      "progress_percentage": 72,
    },
    {
      "id": "PRJ-2024-005",
      "project_name": "Industrial Warehouse Complex",
      "client_name": "LogiTech Distribution",
      "total_budget": 2100000.0,
      "budget_allocated": 2100000.0,
      "budget_spent": 480000.0,
      "budget_remaining": 1620000.0,
      "budget_variance": -45000.0,
      "budget_status": "under",
      "spending_rate": 22.9,
      "projected_cost": 2055000.0,
      "cost_per_phase": {
        "planning": 105000.0,
        "design": 168000.0,
        "construction": 1470000.0,
        "finishing": 357000.0,
      },
      "change_orders_cost": 0.0,
      "contingency_used": 45000.0,
      "contingency_total": 210000.0,
      "labor_costs": 288000.0,
      "material_costs": 144000.0,
      "equipment_costs": 48000.0,
      "overhead_costs": 105000.0,
      "profit_margin": 13.5,
      "payment_schedule": "Monthly",
      "invoice_submitted": 450000.0,
      "invoice_paid": 400000.0,
      "invoice_pending": 50000.0,
      "budget_manager": "Jennifer Park",
      "last_updated": "2024-06-10",
      "next_payment": "2024-07-10",
      "payment_terms": "Net 30",
      "currency": "USD",
      "tax_rate": 7.75,
      "progress_percentage": 25,
    },
    {
      "id": "PRJ-2024-006",
      "project_name": "Municipal Library Renovation",
      "client_name": "City of Metro",
      "total_budget": 1200000.0,
      "budget_allocated": 1200000.0,
      "budget_spent": 520000.0,
      "budget_remaining": 680000.0,
      "budget_variance": -20000.0,
      "budget_status": "on_budget",
      "spending_rate": 43.3,
      "projected_cost": 1180000.0,
      "cost_per_phase": {
        "planning": 60000.0,
        "design": 96000.0,
        "construction": 840000.0,
        "finishing": 204000.0,
      },
      "change_orders_cost": 25000.0,
      "contingency_used": 35000.0,
      "contingency_total": 120000.0,
      "labor_costs": 312000.0,
      "material_costs": 156000.0,
      "equipment_costs": 52000.0,
      "overhead_costs": 72000.0,
      "profit_margin": 11.0,
      "payment_schedule": "Monthly",
      "invoice_submitted": 500000.0,
      "invoice_paid": 450000.0,
      "invoice_pending": 50000.0,
      "budget_manager": "Thomas Anderson",
      "last_updated": "2024-06-12",
      "next_payment": "2024-07-12",
      "payment_terms": "Net 60",
      "currency": "USD",
      "tax_rate": 8.0,
      "progress_percentage": 45,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Project Budgets"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () => _addBudgetEntry(),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.analytics,
            size: bs.sm,
            onPressed: () => _showBudgetAnalytics(),
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  _buildBudgetOverview(),
                  _buildSearchAndFilter(),
                  _buildBudgetFilters(),
                  _buildBudgetSummary(),
                  _buildBudgetsList(),
                ],
              ),
            ),
    );
  }

  Widget _buildBudgetOverview() {
    double totalBudget = projectBudgets.fold(0.0, (sum, p) => sum + (p["total_budget"] as double));
    double totalSpent = projectBudgets.fold(0.0, (sum, p) => sum + (p["budget_spent"] as double));
    double totalRemaining = projectBudgets.fold(0.0, (sum, p) => sum + (p["budget_remaining"] as double));

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: primaryColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(Icons.account_balance_wallet, color: primaryColor, size: 24),
              ),
              SizedBox(width: spMd),
              Text(
                "Budget Portfolio Overview",
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
              _buildOverviewCard("Total Budget", "\$${(totalBudget).currency}", Icons.account_balance, primaryColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Spent", "\$${(totalSpent).currency}", Icons.trending_down, dangerColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Remaining", "\$${(totalRemaining).currency}", Icons.savings, successColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Projects", "${projectBudgets.length}", Icons.folder, infoColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusMd),
          border: Border.all(color: color.withAlpha(30)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 18),
            SizedBox(height: spXs),
            Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: disabledBoldColor, size: 20),
          SizedBox(width: spSm),
          Expanded(
            child: QTextField(
              label: "Search project budgets...",
              value: searchQuery,
              hint: "Search by project name, client, or manager",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.filter_list,
            size: bs.sm,
            onPressed: () => _showAdvancedFilters(),
          ),
        ],
      ),
    );
  }

  Widget _buildBudgetFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Filter by Budget Status",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QHorizontalScroll(
            children: budgetFilters.map((filter) {
              bool isSelected = selectedBudgetFilter == filter["value"];
              return Container(
                margin: EdgeInsets.only(right: spSm),
                child: GestureDetector(
                  onTap: () {
                    selectedBudgetFilter = filter["value"];
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    decoration: BoxDecoration(
                      color: isSelected 
                          ? primaryColor.withAlpha(30)
                          : Colors.grey.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledColor,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Text(
                      "${filter["label"]} (${filter["count"]})",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? primaryColor : disabledBoldColor,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBudgetSummary() {
    double avgSpendingRate = projectBudgets.fold(0.0, (sum, p) => sum + (p["spending_rate"] as double)) / projectBudgets.length;
    int overBudgetCount = projectBudgets.where((p) => p["budget_status"] == "over").length;
    double totalVariance = projectBudgets.fold(0.0, (sum, p) => sum + (p["budget_variance"] as double));

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: successColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: successColor.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Budget Performance",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: successColor,
            ),
          ),
          Row(
            children: [
              _buildSummaryCard("Avg. Spending", "${avgSpendingRate.toInt()}%", Icons.trending_up),
              SizedBox(width: spSm),
              _buildSummaryCard("Over Budget", "$overBudgetCount", Icons.warning),
              SizedBox(width: spSm),
              _buildSummaryCard("Total Variance", "\$${(totalVariance.abs()).currency}", Icons.compare_arrows),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
        ),
        child: Column(
          children: [
            Icon(icon, color: successColor, size: 18),
            SizedBox(height: spXs),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: successColor,
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBudgetsList() {
    List<Map<String, dynamic>> filteredBudgets = _getFilteredBudgets();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Row(
          children: [
            Text(
              "Project Budgets (${filteredBudgets.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            QButton(
              icon: Icons.sort,
              size: bs.sm,
              onPressed: () => _showSortOptions(),
            ),
          ],
        ),
        ...filteredBudgets.map((budget) => _buildBudgetCard(budget)),
      ],
    );
  }

  Widget _buildBudgetCard(Map<String, dynamic> budget) {
    Color statusColor = _getBudgetStatusColor(budget["budget_status"]);
    double spendingRate = (budget["spending_rate"] as double);
    double varianceAmount = (budget["budget_variance"] as double);
    bool isOverBudget = varianceAmount > 0;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            color: statusColor,
            width: 4,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${budget["id"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "${budget["project_name"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${budget["budget_status"]}".replaceAll("_", " ").toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.business, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "Client: ${budget["client_name"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Text(
                      "Budget: \$${((budget["total_budget"] as double)).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Spent: ${spendingRate.toInt()}%",
                      style: TextStyle(
                        fontSize: 12,
                        color: spendingRate > 90 ? dangerColor : successColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: disabledColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: spendingRate / 100,
                    child: Container(
                      decoration: BoxDecoration(
                        color: spendingRate > 90 ? dangerColor : successColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Text(
                "Spent: \$${((budget["budget_spent"] as double)).currency}",
                style: TextStyle(
                  fontSize: 12,
                  color: dangerColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text(
                "Remaining: \$${((budget["budget_remaining"] as double)).currency}",
                style: TextStyle(
                  fontSize: 12,
                  color: successColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          if (varianceAmount != 0)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: isOverBudget ? dangerColor.withAlpha(10) : successColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    isOverBudget ? Icons.trending_up : Icons.trending_down,
                    color: isOverBudget ? dangerColor : successColor,
                    size: 16,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "${isOverBudget ? 'Over' : 'Under'} Budget: \$${(varianceAmount.abs()).currency}",
                    style: TextStyle(
                      fontSize: 12,
                      color: isOverBudget ? dangerColor : successColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          Row(
            children: [
              _buildCostBreakdown("Labor", budget["labor_costs"] as double),
              SizedBox(width: spSm),
              _buildCostBreakdown("Material", budget["material_costs"] as double),
              SizedBox(width: spSm),
              _buildCostBreakdown("Equipment", budget["equipment_costs"] as double),
            ],
          ),
          Row(
            children: [
              Icon(Icons.person, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "Manager: ${budget["budget_manager"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "Progress: ${(budget["progress_percentage"] as num).toInt()}%",
                style: TextStyle(
                  fontSize: 12,
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              if ((budget["change_orders_cost"] as double) > 0)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "CHANGE ORDERS: \$${((budget["change_orders_cost"] as double)).currency}",
                    style: TextStyle(
                      fontSize: 10,
                      color: warningColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              Spacer(),
              Text(
                "Updated: ${budget["last_updated"]}",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Projected Cost: \$${((budget["projected_cost"] as double)).currency}",
                style: TextStyle(
                  fontSize: 12,
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text(
                "Margin: ${(budget["profit_margin"] as double).toStringAsFixed(1)}%",
                style: TextStyle(
                  fontSize: 12,
                  color: successColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Next Payment: ${budget["next_payment"]} (${budget["payment_terms"]})",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              QButton(
                icon: Icons.visibility,
                size: bs.sm,
                onPressed: () => _viewBudgetDetails(budget["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () => _editBudget(budget["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showBudgetOptions(budget),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCostBreakdown(String label, double amount) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spXs),
        decoration: BoxDecoration(
          color: primaryColor.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusXs),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
            ),
            Text(
              "\$${(amount).currency}",
              style: TextStyle(
                fontSize: 10,
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredBudgets() {
    List<Map<String, dynamic>> filtered = projectBudgets;

    if (selectedBudgetFilter != "all") {
      filtered = filtered.where((b) => b["budget_status"] == selectedBudgetFilter).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((b) =>
          b["project_name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          b["client_name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          b["budget_manager"].toString().toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }

    return filtered;
  }

  Color _getBudgetStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'under':
        return successColor;
      case 'on_budget':
        return primaryColor;
      case 'over':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _addBudgetEntry() {
    ss("Add budget entry");
  }

  void _showBudgetAnalytics() {
    ss("Budget analytics dashboard");
  }

  void _showAdvancedFilters() {
    ss("Advanced budget filters");
  }

  void _showSortOptions() {
    ss("Budget sort options");
  }

  void _viewBudgetDetails(String budgetId) {
    ss("Viewing budget details $budgetId");
  }

  void _editBudget(String budgetId) {
    ss("Editing budget $budgetId");
  }

  void _showBudgetOptions(Map<String, dynamic> budget) {
    ss("Budget options for ${budget["id"]}");
  }
}
