import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaSalesView extends StatefulWidget {
  const CmaSalesView({super.key});

  @override
  State<CmaSalesView> createState() => _CmaSalesViewState();
}

class _CmaSalesViewState extends State<CmaSalesView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedFilter = "all";
  String sortBy = "newest";

  List<Map<String, dynamic>> salesData = [
    {
      "id": "SL001",
      "customer": "Tech Corp Ltd",
      "email": "contact@techcorp.com",
      "phone": "+1 234 567 8900",
      "amount": 15000.0,
      "status": "closed_won",
      "stage": "Closed Won",
      "probability": 100,
      "createdDate": "2024-01-15",
      "closeDate": "2024-01-20",
      "source": "Website",
      "assignedTo": "John Smith",
      "products": ["CRM Pro", "Analytics Plus"],
      "notes": "Enterprise client with multiple locations"
    },
    {
      "id": "SL002", 
      "customer": "StartupXYZ",
      "email": "hello@startupxyz.com",
      "phone": "+1 234 567 8901",
      "amount": 8500.0,
      "status": "negotiation",
      "stage": "Negotiation",
      "probability": 75,
      "createdDate": "2024-01-10",
      "closeDate": "2024-02-01",
      "source": "Referral",
      "assignedTo": "Sarah Johnson",
      "products": ["CRM Standard"],
      "notes": "Price sensitive but interested in long-term contract"
    },
    {
      "id": "SL003",
      "customer": "Global Industries",
      "email": "procurement@global.com", 
      "phone": "+1 234 567 8902",
      "amount": 25000.0,
      "status": "proposal",
      "stage": "Proposal Sent",
      "probability": 60,
      "createdDate": "2024-01-08",
      "closeDate": "2024-02-15",
      "source": "Cold Call",
      "assignedTo": "Mike Wilson",
      "products": ["CRM Enterprise", "Analytics Pro", "Support Premium"],
      "notes": "Large enterprise deal requiring custom implementation"
    },
    {
      "id": "SL004",
      "customer": "Local Business Co",
      "email": "info@localbiz.com",
      "phone": "+1 234 567 8903", 
      "amount": 3500.0,
      "status": "qualified",
      "stage": "Qualified Lead", 
      "probability": 40,
      "createdDate": "2024-01-12",
      "closeDate": "2024-02-28",
      "source": "LinkedIn",
      "assignedTo": "Emily Davis",
      "products": ["CRM Basic"],
      "notes": "Small business looking for simple solution"
    },
    {
      "id": "SL005",
      "customer": "Retail Chain Inc",
      "email": "sales@retailchain.com",
      "phone": "+1 234 567 8904",
      "amount": 45000.0,
      "status": "closed_lost",
      "stage": "Closed Lost",
      "probability": 0,
      "createdDate": "2023-12-20",
      "closeDate": "2024-01-18",
      "source": "Trade Show",
      "assignedTo": "John Smith",
      "products": ["CRM Enterprise", "POS Integration"],
      "notes": "Lost to competitor due to pricing"
    }
  ];

  List<Map<String, dynamic>> recentActivities = [
    {
      "id": "ACT001",
      "type": "call",
      "title": "Follow-up call with Tech Corp",
      "description": "Discussed implementation timeline",
      "salesId": "SL001",
      "timestamp": "2024-01-20 14:30",
      "assignedTo": "John Smith"
    },
    {
      "id": "ACT002", 
      "type": "email",
      "title": "Proposal sent to Global Industries",
      "description": "Comprehensive proposal with pricing",
      "salesId": "SL003",
      "timestamp": "2024-01-19 09:15",
      "assignedTo": "Mike Wilson"
    },
    {
      "id": "ACT003",
      "type": "meeting",
      "title": "Demo scheduled with StartupXYZ",
      "description": "Product demonstration meeting",
      "salesId": "SL002", 
      "timestamp": "2024-01-18 16:00",
      "assignedTo": "Sarah Johnson"
    }
  ];

  List<Map<String, dynamic>> get filteredSales {
    List<Map<String, dynamic>> filtered = salesData;

    if (selectedFilter != "all") {
      filtered = filtered.where((sale) => sale["status"] == selectedFilter).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((sale) =>
        sale["customer"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
        sale["email"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
        sale["id"].toString().toLowerCase().contains(searchQuery.toLowerCase())
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
        filtered.sort((a, b) => (b["amount"] as double).compareTo(a["amount"] as double));
        break;
      case "amount_low":
        filtered.sort((a, b) => (a["amount"] as double).compareTo(b["amount"] as double));
        break;
    }

    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "closed_won":
        return successColor;
      case "closed_lost":
        return dangerColor;
      case "negotiation":
        return warningColor;
      case "proposal":
        return infoColor;
      case "qualified":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getActivityIcon(String type) {
    switch (type) {
      case "call":
        return Icons.phone;
      case "email":
        return Icons.email;
      case "meeting":
        return Icons.videocam;
      default:
        return Icons.note;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Sales Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Sales Pipeline", icon: Icon(Icons.trending_up)),
        Tab(text: "Activities", icon: Icon(Icons.history)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildSalesPipelineTab(),
        _buildActivitiesTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildSalesPipelineTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildPipelineHeader(),
          _buildSearchAndFilters(),
          _buildSalesMetrics(),
          _buildSalesList(),
        ],
      ),
    );
  }

  Widget _buildPipelineHeader() {
    double totalValue = salesData.fold(0.0, (sum, sale) => sum + (sale["amount"] as double));
    int totalDeals = salesData.length;
    int wonDeals = salesData.where((sale) => sale["status"] == "closed_won").length;
    double winRate = totalDeals > 0 ? (wonDeals / totalDeals) * 100 : 0;

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
              Icon(Icons.trending_up, color: primaryColor, size: 24),
              SizedBox(width: spSm),
              Text(
                "Sales Pipeline Overview",
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
                      "Total Pipeline Value",
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
                      "Total Deals",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "$totalDeals",
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
                      "Win Rate",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${winRate.toStringAsFixed(1)}%",
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
                label: "Search sales...",
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
                si("Create new sale functionality");
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
                  {"label": "Qualified Lead", "value": "qualified"},
                  {"label": "Proposal Sent", "value": "proposal"},
                  {"label": "Negotiation", "value": "negotiation"},
                  {"label": "Closed Won", "value": "closed_won"},
                  {"label": "Closed Lost", "value": "closed_lost"},
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

  Widget _buildSalesMetrics() {
    Map<String, int> statusCounts = {};
    for (var sale in salesData) {
      String status = sale["status"];
      statusCounts[status] = (statusCounts[status] ?? 0) + 1;
    }

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildMetricCard("Qualified Leads", statusCounts["qualified"] ?? 0, Icons.people, primaryColor),
        _buildMetricCard("Proposals Sent", statusCounts["proposal"] ?? 0, Icons.description, infoColor),
        _buildMetricCard("In Negotiation", statusCounts["negotiation"] ?? 0, Icons.handshake, warningColor),
        _buildMetricCard("Closed Won", statusCounts["closed_won"] ?? 0, Icons.check_circle, successColor),
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

  Widget _buildSalesList() {
    return Column(
      spacing: spSm,
      children: filteredSales.map((sale) => _buildSaleCard(sale)).toList(),
    );
  }

  Widget _buildSaleCard(Map<String, dynamic> sale) {
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
                      "${sale["customer"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${sale["id"]} • ${sale["email"]}",
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
                  color: _getStatusColor(sale["status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${sale["stage"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor(sale["status"]),
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
                      "Deal Value",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                    Text(
                      "\$${(sale["amount"] as double).currency}",
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
                      "Probability",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                    Text(
                      "${sale["probability"]}%",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: _getStatusColor(sale["status"]),
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
                      "Assigned To",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                    Text(
                      "${sale["assignedTo"]}",
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
          if (sale["notes"].toString().isNotEmpty) ...[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "${sale["notes"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
          Row(
            children: [
              Expanded(
                child: Text(
                  "Created: ${sale["createdDate"]} • Close: ${sale["closeDate"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  si("View sale details: ${sale["id"]}");
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
                    "Recent Sales Activities",
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
    double totalRevenue = salesData
        .where((sale) => sale["status"] == "closed_won")
        .fold(0.0, (sum, sale) => sum + (sale["amount"] as double));
    
    double avgDealSize = salesData.isNotEmpty ? 
        salesData.fold(0.0, (sum, sale) => sum + (sale["amount"] as double)) / salesData.length : 0;

    Map<String, double> sourceRevenue = {};
    for (var sale in salesData.where((s) => s["status"] == "closed_won")) {
      String source = sale["source"];
      sourceRevenue[source] = (sourceRevenue[source] ?? 0) + (sale["amount"] as double);
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
                  "Sales Analytics",
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
              _buildAnalyticsCard("Total Revenue", "\$${totalRevenue.currency}", Icons.monetization_on, successColor),
              _buildAnalyticsCard("Average Deal Size", "\$${avgDealSize.currency}", Icons.trending_up, primaryColor),
              _buildAnalyticsCard("Conversion Rate", "25%", Icons.show_chart, infoColor),
              _buildAnalyticsCard("Sales Cycle", "21 days", Icons.schedule, warningColor),
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
                  "Revenue by Source",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                ...sourceRevenue.entries.map((entry) => 
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
                          "\$${entry.value.currency}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: successColor,
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
