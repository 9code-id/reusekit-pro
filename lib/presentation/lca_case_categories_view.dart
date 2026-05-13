import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaCaseCategoriesView extends StatefulWidget {
  const LcaCaseCategoriesView({Key? key}) : super(key: key);

  @override
  State<LcaCaseCategoriesView> createState() => _LcaCaseCategoriesViewState();
}

class _LcaCaseCategoriesViewState extends State<LcaCaseCategoriesView> {
  String selectedCategory = "all";
  String searchQuery = "";
  bool loading = false;

  List<Map<String, dynamic>> categories = [
    {
      "id": "civil",
      "name": "Civil Litigation",
      "description": "Disputes between private parties, organizations, or government entities",
      "color": primaryColor,
      "icon": Icons.gavel,
      "case_count": 45,
      "active_cases": 32,
      "avg_value": 180000.0,
      "subcategories": [
        "Personal Injury",
        "Contract Disputes",
        "Property Disputes",
        "Tort Claims",
        "Business Litigation"
      ],
    },
    {
      "id": "criminal",
      "name": "Criminal Defense",
      "description": "Defense of individuals or entities charged with criminal offenses",
      "color": dangerColor,
      "icon": Icons.security,
      "case_count": 28,
      "active_cases": 18,
      "avg_value": 95000.0,
      "subcategories": [
        "White Collar Crime",
        "DUI/DWI",
        "Drug Offenses",
        "Assault & Battery",
        "Theft & Fraud"
      ],
    },
    {
      "id": "corporate",
      "name": "Corporate Law",
      "description": "Legal matters related to business operations and corporate governance",
      "color": infoColor,
      "icon": Icons.business,
      "case_count": 38,
      "active_cases": 25,
      "avg_value": 320000.0,
      "subcategories": [
        "Mergers & Acquisitions",
        "Corporate Compliance",
        "Securities Law",
        "Corporate Governance",
        "Commercial Contracts"
      ],
    },
    {
      "id": "family",
      "name": "Family Law",
      "description": "Legal issues involving family relationships and domestic matters",
      "color": successColor,
      "icon": Icons.family_restroom,
      "case_count": 31,
      "active_cases": 22,
      "avg_value": 65000.0,
      "subcategories": [
        "Divorce & Separation",
        "Child Custody",
        "Adoption",
        "Domestic Violence",
        "Prenuptial Agreements"
      ],
    },
    {
      "id": "intellectual_property",
      "name": "Intellectual Property",
      "description": "Protection of intellectual property rights and related disputes",
      "color": warningColor,
      "icon": Icons.lightbulb,
      "case_count": 19,
      "active_cases": 14,
      "avg_value": 275000.0,
      "subcategories": [
        "Patent Disputes",
        "Trademark Issues",
        "Copyright Infringement",
        "Trade Secrets",
        "Licensing Agreements"
      ],
    },
    {
      "id": "employment",
      "name": "Employment Law",
      "description": "Workplace-related legal issues and employment disputes",
      "color": primaryColor,
      "icon": Icons.work,
      "case_count": 23,
      "active_cases": 16,
      "avg_value": 85000.0,
      "subcategories": [
        "Wrongful Termination",
        "Discrimination",
        "Harassment",
        "Wage & Hour Claims",
        "Employment Contracts"
      ],
    },
  ];

  List<Map<String, dynamic>> recentCases = [
    {
      "id": "LCA-2024-001",
      "title": "Smith vs. Johnson Construction",
      "category": "civil",
      "subcategory": "Personal Injury",
      "client": "John Smith",
      "status": "active",
      "case_value": 250000.0,
      "filing_date": "2024-01-15",
      "lawyer": "Sarah Johnson, Esq.",
    },
    {
      "id": "LCA-2024-003",
      "title": "TechCorp Patent Dispute",
      "category": "intellectual_property",
      "subcategory": "Patent Disputes",
      "client": "TechCorp Industries",
      "status": "active",
      "case_value": 500000.0,
      "filing_date": "2024-02-01",
      "lawyer": "Emily Rodriguez, Esq.",
    },
    {
      "id": "LCA-2024-002",
      "title": "Davis Divorce Settlement",
      "category": "family",
      "subcategory": "Divorce & Separation",
      "client": "Maria Davis",
      "status": "pending",
      "case_value": 85000.0,
      "filing_date": "2024-01-20",
      "lawyer": "Michael Chen, Esq.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Case Categories"),
        actions: [
          QButton(
            icon: Icons.add_circle,
            size: bs.sm,
            onPressed: () => _addNewCategory(),
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
                  _buildSearchBar(),
                  _buildCategoriesOverview(),
                  _buildCategoriesGrid(),
                  _buildRecentCases(),
                ],
              ),
            ),
    );
  }

  Widget _buildSearchBar() {
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
              label: "Search categories...",
              value: searchQuery,
              hint: "Search by category name or subcategory",
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
            onPressed: () => _showFilterOptions(),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesOverview() {
    int totalCases = categories.fold(0, (sum, cat) => sum + (cat["case_count"] as int));
    int totalActive = categories.fold(0, (sum, cat) => sum + (cat["active_cases"] as int));
    double avgValue = categories.fold(0.0, (sum, cat) => sum + (cat["avg_value"] as double)) / categories.length;

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
                child: Icon(Icons.category, color: primaryColor, size: 24),
              ),
              SizedBox(width: spMd),
              Text(
                "Categories Overview",
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
              _buildOverviewCard("Total Cases", "$totalCases", Icons.folder, primaryColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Active", "$totalActive", Icons.play_circle, successColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Avg Value", "\$${(avgValue).currency}", Icons.attach_money, warningColor),
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
            Icon(icon, color: color, size: 20),
            SizedBox(height: spXs),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
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

  Widget _buildCategoriesGrid() {
    List<Map<String, dynamic>> filteredCategories = _getFilteredCategories();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Legal Practice Areas (${filteredCategories.length})",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: filteredCategories.map((category) {
            return _buildCategoryCard(category);
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCategoryCard(Map<String, dynamic> category) {
    Color categoryColor = category["color"] as Color;
    int caseCount = category["case_count"] as int;
    int activeCases = category["active_cases"] as int;
    double avgValue = category["avg_value"] as double;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          top: BorderSide(
            color: categoryColor,
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
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: categoryColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(category["icon"] as IconData, color: categoryColor, size: 24),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${category["name"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "$caseCount cases",
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
          Text(
            "${category["description"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildStatItem("Active", "$activeCases", successColor),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatItem("Avg Value", "\$${(avgValue / 1000).toStringAsFixed(0)}K", categoryColor),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: categoryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "Subcategories:",
                  style: TextStyle(
                    fontSize: 10,
                    color: categoryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: (category["subcategories"] as List<String>).take(3).map((sub) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: categoryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        sub,
                        style: TextStyle(
                          fontSize: 8,
                          color: categoryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                if ((category["subcategories"] as List).length > 3)
                  Text(
                    "+${(category["subcategories"] as List).length - 3} more",
                    style: TextStyle(
                      fontSize: 8,
                      color: disabledBoldColor,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Cases",
                  size: bs.sm,
                  onPressed: () => _viewCategoryCases(category["id"]),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showCategoryOptions(category),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildRecentCases() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Row(
          children: [
            Text(
              "Recent Cases by Category",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            QButton(
              label: "View All",
              size: bs.sm,
              onPressed: () => _viewAllCases(),
            ),
          ],
        ),
        ...recentCases.map((caseData) => _buildRecentCaseCard(caseData)),
      ],
    );
  }

  Widget _buildRecentCaseCard(Map<String, dynamic> caseData) {
    Map<String, dynamic>? category = categories.firstWhere(
      (cat) => cat["id"] == caseData["category"],
      orElse: () => categories[0],
    );
    Color categoryColor = category["color"] as Color;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: categoryColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Icon(category["icon"] as IconData, color: categoryColor, size: 20),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${caseData["id"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: categoryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${caseData["subcategory"]}",
                        style: TextStyle(
                          fontSize: 8,
                          color: categoryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "${caseData["title"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "${caseData["client"]} • \$${((caseData["case_value"] as double)).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${caseData["filing_date"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: spMd),
          QButton(
            icon: Icons.arrow_forward,
            size: bs.sm,
            onPressed: () => _viewCase(caseData["id"]),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredCategories() {
    List<Map<String, dynamic>> filtered = categories;

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((cat) =>
          cat["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          (cat["subcategories"] as List<String>).any((sub) =>
              sub.toLowerCase().contains(searchQuery.toLowerCase()))).toList();
    }

    return filtered;
  }

  void _showFilterOptions() {
    ss("Filter options");
  }

  void _addNewCategory() {
    ss("Add new category");
  }

  void _viewCategoryCases(String categoryId) {
    ss("View cases for category: $categoryId");
  }

  void _showCategoryOptions(Map<String, dynamic> category) {
    ss("Category options for ${category["name"]}");
  }

  void _viewAllCases() {
    ss("View all cases");
  }

  void _viewCase(String caseId) {
    ss("View case: $caseId");
  }
}
