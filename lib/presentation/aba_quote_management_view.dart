import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaQuoteManagementView extends StatefulWidget {
  const AbaQuoteManagementView({super.key});

  @override
  State<AbaQuoteManagementView> createState() => _AbaQuoteManagementViewState();
}

class _AbaQuoteManagementViewState extends State<AbaQuoteManagementView> {
  String searchQuery = "";
  String selectedStatus = "all";
  String selectedPeriod = "current_month";
  int currentTab = 0;

  List<Map<String, dynamic>> quotes = [
    {
      "id": "QT-2025-001",
      "client_name": "Martinez Family",
      "patient_name": "Sofia Martinez",
      "amount": 2800.00,
      "date_created": "2025-01-18",
      "valid_until": "2025-02-18",
      "status": "pending",
      "services": [
        {"name": "Initial Assessment", "hours": 4, "rate": 120.00},
        {"name": "ABA Therapy", "hours": 20, "rate": 100.00},
        {"name": "Parent Training", "hours": 2, "rate": 150.00}
      ],
      "total_hours": 26,
      "notes": "Comprehensive ABA program for autism spectrum disorder",
      "insurance_coverage": 80,
      "estimated_copay": 560.00
    },
    {
      "id": "QT-2025-002", 
      "client_name": "Thompson Family",
      "patient_name": "Michael Thompson",
      "amount": 3500.00,
      "date_created": "2025-01-15",
      "valid_until": "2025-02-15",
      "status": "approved",
      "services": [
        {"name": "Comprehensive Assessment", "hours": 6, "rate": 120.00},
        {"name": "Intensive ABA Therapy", "hours": 25, "rate": 110.00},
        {"name": "Social Skills Training", "hours": 3, "rate": 130.00}
      ],
      "total_hours": 34,
      "notes": "Intensive program with social skills focus",
      "insurance_coverage": 75,
      "estimated_copay": 875.00
    },
    {
      "id": "QT-2025-003",
      "client_name": "Davis Family",
      "patient_name": "Emma Davis",
      "amount": 2200.00,
      "date_created": "2025-01-10",
      "valid_until": "2025-01-25",
      "status": "expired",
      "services": [
        {"name": "Behavioral Assessment", "hours": 3, "rate": 120.00},
        {"name": "ABA Therapy", "hours": 18, "rate": 95.00}
      ],
      "total_hours": 21,
      "notes": "Standard ABA therapy program",
      "insurance_coverage": 85,
      "estimated_copay": 330.00
    },
    {
      "id": "QT-2025-004",
      "client_name": "Wilson Family", 
      "patient_name": "Jacob Wilson",
      "amount": 4200.00,
      "date_created": "2025-01-20",
      "valid_until": "2025-02-20",
      "status": "draft",
      "services": [
        {"name": "Full Psychological Assessment", "hours": 8, "rate": 125.00},
        {"name": "Intensive ABA Therapy", "hours": 30, "rate": 105.00},
        {"name": "Family Training Program", "hours": 4, "rate": 140.00}
      ],
      "total_hours": 42,
      "notes": "Comprehensive program with family training component",
      "insurance_coverage": 70,
      "estimated_copay": 1260.00
    },
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Quotes", "value": "all"},
    {"label": "Draft", "value": "draft"},
    {"label": "Pending", "value": "pending"},
    {"label": "Approved", "value": "approved"},
    {"label": "Rejected", "value": "rejected"},
    {"label": "Expired", "value": "expired"},
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "Current Month", "value": "current_month"},
    {"label": "Last Month", "value": "last_month"},
    {"label": "Last 3 Months", "value": "last_3_months"},
    {"label": "This Year", "value": "this_year"},
    {"label": "All Time", "value": "all_time"},
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case 'approved':
        return successColor;
      case 'pending':
        return warningColor;
      case 'rejected':
        return dangerColor;
      case 'expired':
        return disabledBoldColor;
      case 'draft':
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case 'approved':
        return 'Approved';
      case 'pending':
        return 'Pending Review';
      case 'rejected':
        return 'Rejected';
      case 'expired':
        return 'Expired';
      case 'draft':
        return 'Draft';
      default:
        return 'Unknown';
    }
  }

  List<Map<String, dynamic>> get filteredQuotes {
    return quotes.where((quote) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${quote["client_name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${quote["patient_name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${quote["id"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "all" || quote["status"] == selectedStatus;
      
      return matchesSearch && matchesStatus;
    }).toList();
  }

  double get totalQuoteValue {
    return filteredQuotes.fold(0.0, (sum, quote) => sum + (quote["amount"] as double));
  }

  double get avgQuoteValue {
    return filteredQuotes.isNotEmpty ? totalQuoteValue / filteredQuotes.length : 0.0;
  }

  int get pendingCount {
    return filteredQuotes.where((quote) => quote["status"] == "pending").length;
  }

  double get conversionRate {
    int approvedCount = filteredQuotes.where((quote) => quote["status"] == "approved").length;
    return filteredQuotes.isNotEmpty ? (approvedCount / filteredQuotes.length) * 100 : 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Quote Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "All Quotes", icon: Icon(Icons.request_quote)),
        Tab(text: "Templates", icon: Icon(Icons.description)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildQuotesListTab(),
        _buildTemplatesTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildQuotesListTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildSearchAndFilters(),
          _buildSummaryCards(),
          _buildQuotesList(),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Column(
      spacing: spSm,
      children: [
        Row(
          children: [
            Expanded(
              child: QTextField(
                label: "Search quotes...",
                value: searchQuery,
                hint: "Client name, patient, or quote ID",
                onChanged: (value) {
                  searchQuery = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            QButton(
              icon: Icons.search,
              size: bs.sm,
              onPressed: () {},
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: QDropdownField(
                label: "Status",
                items: statusOptions,
                value: selectedStatus,
                onChanged: (value, label) {
                  selectedStatus = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
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
          ],
        ),
      ],
    );
  }

  Widget _buildSummaryCards() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildSummaryCard(
          "Total Quote Value",
          "\$${totalQuoteValue.currency}",
          Icons.attach_money,
          successColor,
        ),
        _buildSummaryCard(
          "Average Quote",
          "\$${avgQuoteValue.currency}",
          Icons.request_quote,
          infoColor,
        ),
        _buildSummaryCard(
          "Pending Quotes",
          "$pendingCount",
          Icons.pending,
          warningColor,
        ),
        _buildSummaryCard(
          "Conversion Rate",
          "${conversionRate.toStringAsFixed(1)}%",
          Icons.trending_up,
          primaryColor,
        ),
      ],
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.trending_up,
                  color: color,
                  size: 16,
                ),
              ),
            ],
          ),
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
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuotesList() {
    return Column(
      spacing: spSm,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Recent Quotes",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            QButton(
              label: "New Quote",
              icon: Icons.add,
              size: bs.sm,
              onPressed: () {},
            ),
          ],
        ),
        ...filteredQuotes.map((quote) => _buildQuoteCard(quote)),
      ],
    );
  }

  Widget _buildQuoteCard(Map<String, dynamic> quote) {
    List<dynamic> services = quote["services"] as List<dynamic>;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getStatusColor("${quote["status"]}"),
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "${quote["id"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${quote["client_name"]} - ${quote["patient_name"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getStatusColor("${quote["status"]}").withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  _getStatusLabel("${quote["status"]}"),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor("${quote["status"]}"),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "Total: \$${(quote["amount"] as double).currency}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Valid until: ${quote["valid_until"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Total hours: ${quote["total_hours"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                spacing: spXs,
                children: [
                  QButton(
                    icon: Icons.visibility,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                  QButton(
                    icon: Icons.edit,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "Services Included:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                ...services.take(2).map((service) => Text(
                  "• ${service["name"]} (${service["hours"]}h @ \$${((service["rate"] as double)).currency}/hr)",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                )),
                if (services.length > 2)
                  Text(
                    "...and ${services.length - 2} more services",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Text(
                        "Insurance Coverage",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "${quote["insurance_coverage"]}%",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Text(
                        "Est. Copay",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "\$${(quote["estimated_copay"] as double).currency}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if ("${quote["notes"]}".isNotEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: infoColor,
                    size: 16,
                  ),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "${quote["notes"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: infoColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTemplatesTab() {
    List<Map<String, dynamic>> templates = [
      {
        "name": "Standard ABA Assessment",
        "description": "Comprehensive behavioral assessment with therapy plan",
        "services_count": 3,
        "avg_hours": 25,
        "avg_cost": 2800.00,
        "usage_count": 45,
        "last_used": "2025-01-18"
      },
      {
        "name": "Intensive ABA Program",
        "description": "High-intensity therapy program with family training",
        "services_count": 5,
        "avg_hours": 35,
        "avg_cost": 4200.00,
        "usage_count": 28,
        "last_used": "2025-01-15"
      },
      {
        "name": "Social Skills Focus",
        "description": "ABA therapy with emphasis on social skills development",
        "services_count": 4,
        "avg_hours": 20,
        "avg_cost": 2400.00,
        "usage_count": 32,
        "last_used": "2025-01-20"
      },
      {
        "name": "Early Intervention",
        "description": "Specialized program for young children (2-5 years)",
        "services_count": 3,
        "avg_hours": 15,
        "avg_cost": 1800.00,
        "usage_count": 18,
        "last_used": "2025-01-12"
      },
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildTemplatesHeader(),
          _buildTemplatesList(templates),
        ],
      ),
    );
  }

  Widget _buildTemplatesHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Row(
        children: [
          Icon(
            Icons.description,
            color: primaryColor,
            size: 32,
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "Quote Templates",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Pre-built templates to speed up quote creation",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            label: "New Template",
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildTemplatesList(List<Map<String, dynamic>> templates) {
    return Column(
      spacing: spSm,
      children: templates.map((template) => _buildTemplateCard(template)).toList(),
    );
  }

  Widget _buildTemplateCard(Map<String, dynamic> template) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "${template["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${template["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                spacing: spXs,
                children: [
                  QButton(
                    icon: Icons.copy,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                  QButton(
                    icon: Icons.edit,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildTemplateStatCard(
                "Services",
                "${template["services_count"]}",
                Icons.medical_services,
                infoColor,
              ),
              _buildTemplateStatCard(
                "Avg. Hours",
                "${template["avg_hours"]}",
                Icons.schedule,
                warningColor,
              ),
              _buildTemplateStatCard(
                "Avg. Cost",
                "\$${(template["avg_cost"] as double).currency}",
                Icons.attach_money,
                successColor,
              ),
              _buildTemplateStatCard(
                "Used",
                "${template["usage_count"]} times",
                Icons.trending_up,
                primaryColor,
              ),
            ],
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Last used: ${template["last_used"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                QButton(
                  label: "Use Template",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTemplateStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: spXs,
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildAnalyticsHeader(),
          _buildQuotePerformanceMetrics(),
          _buildConversionAnalysis(),
          _buildServiceAnalysis(),
        ],
      ),
    );
  }

  Widget _buildAnalyticsHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: successColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
      ),
      child: Row(
        children: [
          Icon(
            Icons.analytics,
            color: successColor,
            size: 32,
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "Quote Analytics",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Analyze quote performance and conversion rates",
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
    );
  }

  Widget _buildQuotePerformanceMetrics() {
    return Container(
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
          Text(
            "Performance Metrics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildMetricCard(
                "Conversion Rate",
                "${conversionRate.toStringAsFixed(1)}%",
                Icons.trending_up,
                successColor,
                "+5.2%",
              ),
              _buildMetricCard(
                "Avg. Quote Value",
                "\$${avgQuoteValue.currency}",
                Icons.attach_money,
                infoColor,
                "+12.8%",
              ),
              _buildMetricCard(
                "Response Time",
                "2.4 days",
                Icons.schedule,
                warningColor,
                "-0.5 days",
              ),
              _buildMetricCard(
                "Win Rate",
                "67.5%",
                Icons.star,
                primaryColor,
                "+8.1%",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color, String change) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: color.withAlpha(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              Text(
                change,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: change.startsWith('+') ? successColor : dangerColor,
                ),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConversionAnalysis() {
    List<Map<String, dynamic>> conversionData = [
      {"status": "Draft", "count": 8, "percentage": 20.0},
      {"status": "Pending", "count": 12, "percentage": 30.0},
      {"status": "Approved", "count": 15, "percentage": 37.5},
      {"status": "Rejected", "count": 3, "percentage": 7.5},
      {"status": "Expired", "count": 2, "percentage": 5.0},
    ];

    return Container(
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
          Text(
            "Quote Status Distribution",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Column(
            spacing: spSm,
            children: conversionData.map((data) => _buildConversionBar(data)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildConversionBar(Map<String, dynamic> data) {
    Color barColor = _getStatusColor(data["status"].toString().toLowerCase());
    
    return Column(
      spacing: spXs,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${data["status"]}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
            Text(
              "${data["count"]} (${(data["percentage"] as double).toStringAsFixed(1)}%)",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
        Container(
          height: 8,
          decoration: BoxDecoration(
            color: disabledColor,
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: (data["percentage"] as double) / 100,
            child: Container(
              decoration: BoxDecoration(
                color: barColor,
                borderRadius: BorderRadius.circular(radiusLg),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildServiceAnalysis() {
    List<Map<String, dynamic>> serviceStats = [
      {
        "service": "ABA Therapy",
        "usage": 85,
        "avg_hours": 22,
        "avg_rate": 105.00,
        "revenue": 45600.00
      },
      {
        "service": "Assessment Services",
        "usage": 92,
        "avg_hours": 5,
        "avg_rate": 120.00,
        "revenue": 27600.00
      },
      {
        "service": "Parent Training",
        "usage": 68,
        "avg_hours": 3,
        "avg_rate": 145.00,
        "revenue": 12180.00
      },
      {
        "service": "Social Skills Training",
        "usage": 45,
        "avg_hours": 4,
        "avg_rate": 130.00,
        "revenue": 9360.00
      },
    ];

    return Container(
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
          Text(
            "Service Analysis",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Column(
            spacing: spSm,
            children: serviceStats.map((service) => _buildServiceAnalysisCard(service)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceAnalysisCard(Map<String, dynamic> service) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: primaryColor.withAlpha(20)),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${service["service"]}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "${service["usage"]}% usage",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: successColor,
                ),
              ),
            ],
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildServiceStatItem("Avg. Hours", "${service["avg_hours"]}"),
              _buildServiceStatItem("Avg. Rate", "\$${(service["avg_rate"] as double).currency}/hr"),
              _buildServiceStatItem("Total Revenue", "\$${(service["revenue"] as double).currency}"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServiceStatItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spXs,
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
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
      ],
    );
  }
}
