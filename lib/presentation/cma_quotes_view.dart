import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaQuotesView extends StatefulWidget {
  const CmaQuotesView({super.key});

  @override
  State<CmaQuotesView> createState() => _CmaQuotesViewState();
}

class _CmaQuotesViewState extends State<CmaQuotesView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedFilter = "all";
  String sortBy = "newest";

  List<Map<String, dynamic>> quotesData = [
    {
      "id": "QT001",
      "number": "QUO-2024-001",
      "customer": "Tech Solutions Inc",
      "email": "contact@techsolutions.com",
      "phone": "+1 234 567 8900",
      "amount": 12500.0,
      "tax": 1250.0,
      "total": 13750.0,
      "status": "sent",
      "validUntil": "2024-02-15",
      "createdDate": "2024-01-15",
      "assignedTo": "John Smith",
      "items": [
        {"name": "CRM Pro License", "quantity": 5, "price": 2000.0, "total": 10000.0},
        {"name": "Setup & Training", "quantity": 1, "price": 2500.0, "total": 2500.0}
      ],
      "notes": "Enterprise package with training included",
      "terms": "Net 30 days payment terms"
    },
    {
      "id": "QT002",
      "number": "QUO-2024-002", 
      "customer": "StartupXYZ",
      "email": "hello@startupxyz.com",
      "phone": "+1 234 567 8901",
      "amount": 4800.0,
      "tax": 480.0,
      "total": 5280.0,
      "status": "approved",
      "validUntil": "2024-02-20",
      "createdDate": "2024-01-12",
      "assignedTo": "Sarah Johnson",
      "items": [
        {"name": "CRM Standard", "quantity": 3, "price": 1200.0, "total": 3600.0},
        {"name": "Support Package", "quantity": 1, "price": 1200.0, "total": 1200.0}
      ],
      "notes": "Standard package for small team",
      "terms": "Net 15 days payment terms"
    },
    {
      "id": "QT003",
      "number": "QUO-2024-003",
      "customer": "Global Corp",
      "email": "procurement@globalcorp.com",
      "phone": "+1 234 567 8902",
      "amount": 35000.0,
      "tax": 3500.0,
      "total": 38500.0,
      "status": "draft",
      "validUntil": "2024-03-01",
      "createdDate": "2024-01-18",
      "assignedTo": "Mike Wilson",
      "items": [
        {"name": "CRM Enterprise", "quantity": 20, "price": 1500.0, "total": 30000.0},
        {"name": "Analytics Module", "quantity": 1, "price": 5000.0, "total": 5000.0}
      ],
      "notes": "Large enterprise deployment",
      "terms": "Net 45 days payment terms"
    },
    {
      "id": "QT004",
      "number": "QUO-2024-004",
      "customer": "Local Business",
      "email": "info@localbiz.com", 
      "phone": "+1 234 567 8903",
      "amount": 2400.0,
      "tax": 240.0,
      "total": 2640.0,
      "status": "expired",
      "validUntil": "2024-01-20",
      "createdDate": "2024-01-05",
      "assignedTo": "Emily Davis",
      "items": [
        {"name": "CRM Basic", "quantity": 2, "price": 800.0, "total": 1600.0},
        {"name": "Setup Fee", "quantity": 1, "price": 800.0, "total": 800.0}
      ],
      "notes": "Basic setup for small business",
      "terms": "Net 30 days payment terms"
    },
    {
      "id": "QT005",
      "number": "QUO-2024-005",
      "customer": "Retail Chain",
      "email": "purchasing@retailchain.com",
      "phone": "+1 234 567 8904",
      "amount": 18000.0,
      "tax": 1800.0,
      "total": 19800.0,
      "status": "rejected",
      "validUntil": "2024-02-10",
      "createdDate": "2024-01-10",
      "assignedTo": "John Smith",
      "items": [
        {"name": "POS Integration", "quantity": 10, "price": 1500.0, "total": 15000.0},
        {"name": "Training Package", "quantity": 1, "price": 3000.0, "total": 3000.0}
      ],
      "notes": "POS system integration for retail locations",
      "terms": "Net 30 days payment terms"
    }
  ];

  List<Map<String, dynamic>> recentActivities = [
    {
      "id": "QA001",
      "type": "sent",
      "title": "Quote sent to Tech Solutions Inc",
      "description": "QUO-2024-001 sent via email",
      "quoteId": "QT001",
      "timestamp": "2024-01-15 10:30",
      "assignedTo": "John Smith"
    },
    {
      "id": "QA002",
      "type": "approved",
      "title": "Quote approved by StartupXYZ",
      "description": "QUO-2024-002 approved and converted to order",
      "quoteId": "QT002",
      "timestamp": "2024-01-18 14:15",
      "assignedTo": "Sarah Johnson"
    },
    {
      "id": "QA003",
      "type": "created",
      "title": "New quote created for Global Corp",
      "description": "QUO-2024-003 created and saved as draft",
      "quoteId": "QT003",
      "timestamp": "2024-01-18 16:45",
      "assignedTo": "Mike Wilson"
    }
  ];

  List<Map<String, dynamic>> get filteredQuotes {
    List<Map<String, dynamic>> filtered = quotesData;

    if (selectedFilter != "all") {
      filtered = filtered.where((quote) => quote["status"] == selectedFilter).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((quote) =>
        quote["customer"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
        quote["number"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
        quote["email"].toString().toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }

    switch (sortBy) {
      case "newest":
        filtered.sort((a, b) => b["createdDate"].compareTo(a["createdDate"]));
        break;
      case "oldest":
        filtered.sort((a, b) => a["createdDate"].compareTo(b["createdDate"]));
        break;
      case "amount_high":
        filtered.sort((a, b) => (b["total"] as double).compareTo(a["total"] as double));
        break;
      case "amount_low":
        filtered.sort((a, b) => (a["total"] as double).compareTo(b["total"] as double));
        break;
    }

    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "approved":
        return successColor;
      case "sent":
        return infoColor;
      case "draft":
        return warningColor;
      case "expired":
        return dangerColor;
      case "rejected":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case "approved":
        return "Approved";
      case "sent":
        return "Sent";
      case "draft":
        return "Draft";
      case "expired":
        return "Expired";
      case "rejected":
        return "Rejected";
      default:
        return status;
    }
  }

  IconData _getActivityIcon(String type) {
    switch (type) {
      case "sent":
        return Icons.send;
      case "approved":
        return Icons.check_circle;
      case "created":
        return Icons.note_add;
      case "rejected":
        return Icons.cancel;
      default:
        return Icons.note;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Quotes Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "All Quotes", icon: Icon(Icons.description)),
        Tab(text: "Activities", icon: Icon(Icons.history)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildQuotesTab(),
        _buildActivitiesTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildQuotesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildQuotesHeader(),
          _buildSearchAndFilters(),
          _buildQuotesMetrics(),
          _buildQuotesList(),
        ],
      ),
    );
  }

  Widget _buildQuotesHeader() {
    double totalValue = quotesData.fold(0.0, (sum, quote) => sum + (quote["total"] as double));
    int totalQuotes = quotesData.length;
    int approvedQuotes = quotesData.where((quote) => quote["status"] == "approved").length;
    double approvalRate = totalQuotes > 0 ? (approvedQuotes / totalQuotes) * 100 : 0;

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
            children: [
              Icon(Icons.description, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Quotes Overview",
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Quote Value",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${totalValue.currency}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Quotes",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "$totalQuotes",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Approval Rate",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${approvalRate.toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 20,
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
                onChanged: (value) {
                  searchQuery = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            QButton(
              icon: Icons.add,
              size: bs.sm,
              onPressed: () {
                si("Create new quote functionality");
              },
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: QDropdownField(
                label: "Filter by Status",
                items: [
                  {"label": "All Status", "value": "all"},
                  {"label": "Draft", "value": "draft"},
                  {"label": "Sent", "value": "sent"},
                  {"label": "Approved", "value": "approved"},
                  {"label": "Rejected", "value": "rejected"},
                  {"label": "Expired", "value": "expired"},
                ],
                value: selectedFilter,
                onChanged: (value, label) {
                  selectedFilter = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QDropdownField(
                label: "Sort by",
                items: [
                  {"label": "Newest First", "value": "newest"},
                  {"label": "Oldest First", "value": "oldest"},
                  {"label": "Amount (High to Low)", "value": "amount_high"},
                  {"label": "Amount (Low to High)", "value": "amount_low"},
                ],
                value: sortBy,
                onChanged: (value, label) {
                  sortBy = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuotesMetrics() {
    Map<String, int> statusCounts = {};
    for (var quote in quotesData) {
      String status = quote["status"];
      statusCounts[status] = (statusCounts[status] ?? 0) + 1;
    }

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildMetricCard("Draft Quotes", statusCounts["draft"] ?? 0, Icons.edit, warningColor),
        _buildMetricCard("Sent Quotes", statusCounts["sent"] ?? 0, Icons.send, infoColor),
        _buildMetricCard("Approved", statusCounts["approved"] ?? 0, Icons.check_circle, successColor),
        _buildMetricCard("Expired", statusCounts["expired"] ?? 0, Icons.access_time, dangerColor),
      ],
    );
  }

  Widget _buildMetricCard(String title, int count, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(width: 4, color: color),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "$count",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuotesList() {
    return Column(
      spacing: spSm,
      children: filteredQuotes.map((quote) => _buildQuoteCard(quote)).toList(),
    );
  }

  Widget _buildQuoteCard(Map<String, dynamic> quote) {
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
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${quote["number"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${quote["customer"]} • ${quote["email"]}",
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
                  color: _getStatusColor(quote["status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  _getStatusLabel(quote["status"]),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor(quote["status"]),
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
                  children: [
                    Text(
                      "Subtotal",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                    Text(
                      "\$${(quote["amount"] as double).currency}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                    Text(
                      "\$${(quote["total"] as double).currency}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Valid Until",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                    Text(
                      "${quote["validUntil"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Items (${(quote["items"] as List).length}):",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                ...(quote["items"] as List).map((item) => 
                  Padding(
                    padding: EdgeInsets.only(top: spXs),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${item["name"]} (${item["quantity"]}x)",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                        Text(
                          "\$${(item["total"] as double).currency}",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Created: ${quote["createdDate"]} • Assigned: ${quote["assignedTo"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              QButton(
                icon: Icons.visibility,
                size: bs.sm,
                onPressed: () {
                  si("View quote details: ${quote["number"]}");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActivitiesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Icon(Icons.history, color: primaryColor, size: 24),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Recent Quote Activities",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                QButton(
                  icon: Icons.add,
                  size: bs.sm,
                  onPressed: () {
                    si("Log new activity functionality");
                  },
                ),
              ],
            ),
          ),
          ...recentActivities.map((activity) => _buildActivityCard(activity)),
        ],
      ),
    );
  }

  Widget _buildActivityCard(Map<String, dynamic> activity) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              _getActivityIcon(activity["type"]),
              color: primaryColor,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${activity["title"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${activity["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${activity["assignedTo"]} • ${activity["timestamp"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            icon: Icons.more_vert,
            size: bs.sm,
            onPressed: () {
              si("View activity details: ${activity["id"]}");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    double totalQuoteValue = quotesData.fold(0.0, (sum, quote) => sum + (quote["total"] as double));
    double approvedValue = quotesData
        .where((quote) => quote["status"] == "approved")
        .fold(0.0, (sum, quote) => sum + (quote["total"] as double));
    double avgQuoteValue = quotesData.isNotEmpty ? totalQuoteValue / quotesData.length : 0;
    double conversionRate = quotesData.isNotEmpty ? 
        (quotesData.where((q) => q["status"] == "approved").length / quotesData.length) * 100 : 0;

    Map<String, int> monthlyQuotes = {};
    for (var quote in quotesData) {
      String month = quote["createdDate"].toString().substring(0, 7);
      monthlyQuotes[month] = (monthlyQuotes[month] ?? 0) + 1;
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Icon(Icons.analytics, color: primaryColor, size: 24),
                SizedBox(width: spSm),
                Text(
                  "Quote Analytics",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildAnalyticsCard("Total Quote Value", "\$${totalQuoteValue.currency}", Icons.description, primaryColor),
              _buildAnalyticsCard("Approved Value", "\$${approvedValue.currency}", Icons.check_circle, successColor),
              _buildAnalyticsCard("Average Quote", "\$${avgQuoteValue.currency}", Icons.trending_up, infoColor),
              _buildAnalyticsCard("Conversion Rate", "${conversionRate.toStringAsFixed(1)}%", Icons.show_chart, warningColor),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Monthly Quote Activity",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                ...monthlyQuotes.entries.map((entry) => 
                  Padding(
                    padding: EdgeInsets.only(bottom: spSm),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            entry.key,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Text(
                          "${entry.value} quotes",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
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
    );
  }

  Widget _buildAnalyticsCard(String title, String value, IconData icon, Color color) {
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
              Icon(icon, color: color, size: 20),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
