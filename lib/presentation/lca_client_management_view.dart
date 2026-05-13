import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaClientManagementView extends StatefulWidget {
  const LcaClientManagementView({Key? key}) : super(key: key);

  @override
  State<LcaClientManagementView> createState() => _LcaClientManagementViewState();
}

class _LcaClientManagementViewState extends State<LcaClientManagementView> {
  String selectedClientType = "all";
  String selectedStatus = "all";
  String searchQuery = "";
  bool loading = false;

  List<Map<String, dynamic>> clientTypes = [
    {"label": "All Clients", "value": "all", "count": 127},
    {"label": "Individual", "value": "individual", "count": 78},
    {"label": "Corporate", "value": "corporate", "count": 35},
    {"label": "Non-Profit", "value": "nonprofit", "count": 14},
  ];

  List<Map<String, dynamic>> clientStatuses = [
    {"label": "All Status", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Inactive", "value": "inactive"},
    {"label": "Potential", "value": "potential"},
  ];

  List<Map<String, dynamic>> clients = [
    {
      "id": "CLT-001",
      "name": "TechFlow Solutions Inc.",
      "type": "corporate",
      "status": "active",
      "primary_contact": "Jennifer Martinez",
      "email": "j.martinez@techflow.com",
      "phone": "+1 (555) 234-5678",
      "address": "123 Business District, Tech Tower, Floor 15",
      "industry": "Technology",
      "company_size": "250 employees",
      "joined_date": "2023-08-15",
      "last_interaction": "2024-06-12",
      "total_billings": 145000.0,
      "outstanding_balance": 12500.0,
      "active_cases": 3,
      "case_types": ["IP Law", "Employment", "Contract"],
      "assigned_attorney": "Dr. Sarah Mitchell, Esq.",
      "billing_rate": 450.0,
      "payment_terms": "Net 30",
      "client_priority": "high",
    },
    {
      "id": "CLT-002",
      "name": "Robert & Lisa Chen",
      "type": "individual",
      "status": "active",
      "primary_contact": "Robert Chen",
      "email": "robert.chen@email.com",
      "phone": "+1 (555) 345-6789",
      "address": "456 Maple Street, Suburbia Heights",
      "industry": "N/A",
      "company_size": "N/A",
      "joined_date": "2024-03-20",
      "last_interaction": "2024-06-10",
      "total_billings": 28500.0,
      "outstanding_balance": 3200.0,
      "active_cases": 2,
      "case_types": ["Real Estate", "Estate Planning"],
      "assigned_attorney": "Michael Johnson, Esq.",
      "billing_rate": 325.0,
      "payment_terms": "Net 15",
      "client_priority": "medium",
    },
    {
      "id": "CLT-003",
      "name": "Community Health Foundation",
      "type": "nonprofit",
      "status": "active",
      "primary_contact": "Dr. Maria Santos",
      "email": "m.santos@healthfoundation.org",
      "phone": "+1 (555) 456-7890",
      "address": "789 Wellness Avenue, Community Center",
      "industry": "Healthcare",
      "company_size": "85 employees",
      "joined_date": "2023-11-08",
      "last_interaction": "2024-06-08",
      "total_billings": 67500.0,
      "outstanding_balance": 0.0,
      "active_cases": 1,
      "case_types": ["Regulatory Compliance"],
      "assigned_attorney": "Emily Rodriguez, Esq.",
      "billing_rate": 275.0,
      "payment_terms": "Net 45",
      "client_priority": "medium",
    },
    {
      "id": "CLT-004",
      "name": "Global Manufacturing Corp",
      "type": "corporate",
      "status": "potential",
      "primary_contact": "David Kim",
      "email": "d.kim@globalmanufacturing.com",
      "phone": "+1 (555) 567-8901",
      "address": "321 Industrial Park, Manufacturing District",
      "industry": "Manufacturing",
      "company_size": "1,200 employees",
      "joined_date": "N/A",
      "last_interaction": "2024-06-05",
      "total_billings": 0.0,
      "outstanding_balance": 0.0,
      "active_cases": 0,
      "case_types": [],
      "assigned_attorney": "Dr. Sarah Mitchell, Esq.",
      "billing_rate": 475.0,
      "payment_terms": "To be determined",
      "client_priority": "high",
    },
    {
      "id": "CLT-005",
      "name": "Patricia Williams",
      "type": "individual",
      "status": "inactive",
      "primary_contact": "Patricia Williams",
      "email": "p.williams@email.com",
      "phone": "+1 (555) 678-9012",
      "address": "654 Oak Drive, Residential Area",
      "industry": "N/A",
      "company_size": "N/A",
      "joined_date": "2023-05-12",
      "last_interaction": "2024-04-20",
      "total_billings": 15750.0,
      "outstanding_balance": 0.0,
      "active_cases": 0,
      "case_types": ["Family Law"],
      "assigned_attorney": "David Wilson, Esq.",
      "billing_rate": 300.0,
      "payment_terms": "Net 15",
      "client_priority": "low",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Client Management"),
        actions: [
          QButton(
            icon: Icons.person_add,
            size: bs.sm,
            onPressed: () => _addNewClient(),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.analytics,
            size: bs.sm,
            onPressed: () => _showClientAnalytics(),
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
                  _buildClientOverview(),
                  _buildSearchAndFilters(),
                  _buildClientTypeFilter(),
                  _buildClientMetrics(),
                  _buildClientsList(),
                ],
              ),
            ),
    );
  }

  Widget _buildClientOverview() {
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
                child: Icon(Icons.people, color: primaryColor, size: 24),
              ),
              SizedBox(width: spMd),
              Text(
                "Client Portfolio Overview",
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
              _buildOverviewCard("Total Clients", "127", Icons.group, primaryColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Active", "89", Icons.trending_up, successColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Potential", "25", Icons.visibility, warningColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Corporate", "35", Icons.business, infoColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(String title, String count, IconData icon, Color color) {
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
              count,
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
                fontSize: 10,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(Icons.search, color: disabledBoldColor, size: 20),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Search clients...",
                  value: searchQuery,
                  hint: "Search by name, email, or company",
                  onChanged: (value) {
                    searchQuery = value;
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
                  label: "Status",
                  items: clientStatuses,
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
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
        ],
      ),
    );
  }

  Widget _buildClientTypeFilter() {
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
            "Filter by Client Type",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QHorizontalScroll(
            children: clientTypes.map((clientType) {
              bool isSelected = selectedClientType == clientType["value"];
              return Container(
                margin: EdgeInsets.only(right: spSm),
                child: GestureDetector(
                  onTap: () {
                    selectedClientType = clientType["value"];
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
                      "${clientType["label"]} (${clientType["count"]})",
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

  Widget _buildClientMetrics() {
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
            "Client Portfolio Metrics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: successColor,
            ),
          ),
          Row(
            children: [
              _buildMetricCard("Total Revenue", "\$1.2M", Icons.attach_money),
              SizedBox(width: spSm),
              _buildMetricCard("Avg. Billing Rate", "\$385/hr", Icons.schedule),
              SizedBox(width: spSm),
              _buildMetricCard("Collection Rate", "94%", Icons.trending_up),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon) {
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

  Widget _buildClientsList() {
    List<Map<String, dynamic>> filteredClients = _getFilteredClients();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Row(
          children: [
            Text(
              "Clients (${filteredClients.length})",
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
        ...filteredClients.map((clientData) => _buildClientCard(clientData)),
      ],
    );
  }

  Widget _buildClientCard(Map<String, dynamic> clientData) {
    Color statusColor = _getStatusColor(clientData["status"]);
    Color priorityColor = _getPriorityColor(clientData["client_priority"]);

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
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Icon(
                  clientData["type"] == "corporate" ? Icons.business : Icons.person,
                  color: primaryColor,
                  size: 28,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${clientData["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${clientData["id"]} - ${clientData["primary_contact"]}",
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
                  color: statusColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${clientData["status"]}".toUpperCase(),
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${clientData["type"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: priorityColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${clientData["client_priority"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    color: priorityColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.email, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${clientData["email"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.phone, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "${clientData["phone"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              if (clientData["industry"] != "N/A")
                Text(
                  "${clientData["industry"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
            ],
          ),
          if ((clientData["case_types"] as List).isNotEmpty)
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
                  Text(
                    "Practice Areas:",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  QHorizontalScroll(
                    children: (clientData["case_types"] as List).map((caseType) {
                      return Container(
                        margin: EdgeInsets.only(right: spXs),
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "$caseType",
                          style: TextStyle(
                            fontSize: 10,
                            color: infoColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          Row(
            children: [
              Text(
                "Total Billings: \$${((clientData["total_billings"] as double)).currency}",
                style: TextStyle(
                  fontSize: 12,
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text(
                "Rate: \$${((clientData["billing_rate"] as double)).currency}/hr",
                style: TextStyle(
                  fontSize: 12,
                  color: successColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          if ((clientData["outstanding_balance"] as double) > 0)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: warningColor.withAlpha(30)),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning, color: warningColor, size: 16),
                  SizedBox(width: spSm),
                  Text(
                    "Outstanding Balance: \$${((clientData["outstanding_balance"] as double)).currency}",
                    style: TextStyle(
                      fontSize: 12,
                      color: warningColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Assigned to: ${clientData["assigned_attorney"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              QButton(
                icon: Icons.visibility,
                size: bs.sm,
                onPressed: () => _viewClient(clientData["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () => _editClient(clientData["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showClientOptions(clientData),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredClients() {
    List<Map<String, dynamic>> filtered = clients;

    if (selectedClientType != "all") {
      filtered = filtered.where((c) => c["type"] == selectedClientType).toList();
    }

    if (selectedStatus != "all") {
      filtered = filtered.where((c) => c["status"] == selectedStatus).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((c) =>
          c["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          c["email"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          c["primary_contact"].toString().toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }

    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return successColor;
      case 'inactive':
        return disabledBoldColor;
      case 'potential':
        return warningColor;
      default:
        return primaryColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return dangerColor;
      case 'medium':
        return warningColor;
      case 'low':
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  void _addNewClient() {
    ss("Add new client");
  }

  void _showClientAnalytics() {
    ss("Client analytics dashboard");
  }

  void _showAdvancedFilters() {
    ss("Advanced filters");
  }

  void _showSortOptions() {
    ss("Sort options");
  }

  void _viewClient(String clientId) {
    ss("Viewing client $clientId");
  }

  void _editClient(String clientId) {
    ss("Editing client $clientId");
  }

  void _showClientOptions(Map<String, dynamic> clientData) {
    ss("Client options for ${clientData["id"]}");
  }
}
