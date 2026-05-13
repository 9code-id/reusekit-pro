import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaClientListView extends StatefulWidget {
  const LcaClientListView({Key? key}) : super(key: key);

  @override
  State<LcaClientListView> createState() => _LcaClientListViewState();
}

class _LcaClientListViewState extends State<LcaClientListView> {
  String selectedFilter = "all";
  String searchQuery = "";
  bool loading = false;
  bool isGridView = false;

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Clients", "value": "all", "count": 127},
    {"label": "VIP Clients", "value": "vip", "count": 18},
    {"label": "Recent", "value": "recent", "count": 25},
    {"label": "High Value", "value": "high_value", "count": 32},
  ];

  List<Map<String, dynamic>> clients = [
    {
      "id": "CLT-001",
      "name": "TechFlow Solutions Inc.",
      "contact_person": "Jennifer Martinez",
      "email": "j.martinez@techflow.com",
      "phone": "+1 (555) 234-5678",
      "client_type": "Corporate",
      "status": "Active",
      "total_cases": 5,
      "active_cases": 3,
      "total_billings": 285000.0,
      "last_activity": "2024-06-15",
      "priority": "High",
      "avatar_color": "blue",
      "industry": "Technology",
      "location": "San Francisco, CA",
      "rating": 4.8,
      "join_date": "2023-08-15",
    },
    {
      "id": "CLT-002",
      "name": "Robert & Lisa Chen",
      "contact_person": "Robert Chen",
      "email": "robert.chen@email.com",
      "phone": "+1 (555) 345-6789",
      "client_type": "Individual",
      "status": "Active",
      "total_cases": 3,
      "active_cases": 2,
      "total_billings": 45000.0,
      "last_activity": "2024-06-12",
      "priority": "Medium",
      "avatar_color": "green",
      "industry": "Personal",
      "location": "Austin, TX",
      "rating": 4.9,
      "join_date": "2024-03-20",
    },
    {
      "id": "CLT-003",
      "name": "GlobalTech Manufacturing",
      "contact_person": "Sarah Wilson",
      "email": "s.wilson@globaltech.com",
      "phone": "+1 (555) 456-7890",
      "client_type": "Corporate",
      "status": "Active",
      "total_cases": 8,
      "active_cases": 4,
      "total_billings": 520000.0,
      "last_activity": "2024-06-14",
      "priority": "High",
      "avatar_color": "purple",
      "industry": "Manufacturing",
      "location": "Detroit, MI",
      "rating": 4.7,
      "join_date": "2023-01-10",
    },
    {
      "id": "CLT-004",
      "name": "Maria Rodriguez",
      "contact_person": "Maria Rodriguez",
      "email": "m.rodriguez@email.com",
      "phone": "+1 (555) 567-8901",
      "client_type": "Individual",
      "status": "Active",
      "total_cases": 2,
      "active_cases": 1,
      "total_billings": 28500.0,
      "last_activity": "2024-06-10",
      "priority": "Medium",
      "avatar_color": "orange",
      "industry": "Personal",
      "location": "Miami, FL",
      "rating": 5.0,
      "join_date": "2024-04-08",
    },
    {
      "id": "CLT-005",
      "name": "Innovate Startups Inc.",
      "contact_person": "David Kim",
      "email": "d.kim@innovate.com",
      "phone": "+1 (555) 678-9012",
      "client_type": "Corporate",
      "status": "Potential",
      "total_cases": 0,
      "active_cases": 0,
      "total_billings": 0.0,
      "last_activity": "2024-06-08",
      "priority": "High",
      "avatar_color": "red",
      "industry": "Technology",
      "location": "Seattle, WA",
      "rating": 0.0,
      "join_date": "N/A",
    },
    {
      "id": "CLT-006",
      "name": "Patricia Johnson",
      "contact_person": "Patricia Johnson",
      "email": "p.johnson@email.com",
      "phone": "+1 (555) 789-0123",
      "client_type": "Individual",
      "status": "Inactive",
      "total_cases": 1,
      "active_cases": 0,
      "total_billings": 15750.0,
      "last_activity": "2024-04-20",
      "priority": "Low",
      "avatar_color": "gray",
      "industry": "Personal",
      "location": "Boston, MA",
      "rating": 4.5,
      "join_date": "2023-11-15",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Client Directory"),
        actions: [
          QButton(
            icon: isGridView ? Icons.list : Icons.grid_view,
            size: bs.sm,
            onPressed: () {
              isGridView = !isGridView;
              setState(() {});
            },
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.person_add,
            size: bs.sm,
            onPressed: () => _addNewClient(),
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
                  _buildSearchAndFilters(),
                  _buildQuickStats(),
                  _buildFilterTabs(),
                  isGridView ? _buildGridView() : _buildListView(),
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
      child: Row(
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
          SizedBox(width: spSm),
          QButton(
            icon: Icons.tune,
            size: bs.sm,
            onPressed: () => _showFilterOptions(),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: primaryColor.withAlpha(30)),
      ),
      child: Row(
        children: [
          _buildStatCard("Total", "127", Icons.group, primaryColor),
          SizedBox(width: spSm),
          _buildStatCard("Active", "89", Icons.trending_up, successColor),
          SizedBox(width: spSm),
          _buildStatCard("VIP", "18", Icons.star, warningColor),
          SizedBox(width: spSm),
          _buildStatCard("New", "12", Icons.fiber_new, infoColor),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String count, IconData icon, Color color) {
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
            Icon(icon, color: color, size: 16),
            SizedBox(height: spXs),
            Text(
              count,
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

  Widget _buildFilterTabs() {
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
            "Quick Filters",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          QHorizontalScroll(
            children: filterOptions.map((filter) {
              bool isSelected = selectedFilter == filter["value"];
              return Container(
                margin: EdgeInsets.only(right: spSm),
                child: GestureDetector(
                  onTap: () {
                    selectedFilter = filter["value"];
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

  Widget _buildListView() {
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
        ...filteredClients.map((client) => _buildClientListItem(client)),
      ],
    );
  }

  Widget _buildGridView() {
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
        ResponsiveGridView(
          padding: EdgeInsets.all(spSm),
          minItemWidth: 200,
          children: filteredClients.map((client) {
            return _buildClientGridItem(client);
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildClientListItem(Map<String, dynamic> client) {
    Color statusColor = _getStatusColor(client["status"]);
    Color avatarColor = _getAvatarColor(client["avatar_color"]);

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
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: avatarColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Center(
              child: Text(
                "${client["name"]}".substring(0, 1).toUpperCase(),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: avatarColor,
                ),
              ),
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${client["name"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${client["status"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "${client["contact_person"]} • ${client["client_type"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.email, color: disabledBoldColor, size: 14),
                    SizedBox(width: spXs),
                    Text(
                      "${client["email"]}",
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
                      "Cases: ${client["active_cases"]}/${client["total_cases"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Text(
                      "Billings: \$${((client["total_billings"] as double)).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              QButton(
                icon: Icons.visibility,
                size: bs.sm,
                onPressed: () => _viewClient(client["id"]),
              ),
              SizedBox(height: spXs),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showClientOptions(client),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildClientGridItem(Map<String, dynamic> client) {
    Color statusColor = _getStatusColor(client["status"]);
    Color avatarColor = _getAvatarColor(client["avatar_color"]);

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: avatarColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Center(
                  child: Text(
                    "${client["name"]}".substring(0, 1).toUpperCase(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: avatarColor,
                    ),
                  ),
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${client["status"]}",
                  style: TextStyle(
                    fontSize: 9,
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "${client["name"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            "${client["contact_person"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Row(
            children: [
              Icon(Icons.business, color: disabledBoldColor, size: 14),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${client["industry"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.location_on, color: disabledBoldColor, size: 14),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${client["location"]}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "${client["active_cases"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Active Cases",
                        style: TextStyle(
                          fontSize: 9,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      if (client["rating"] > 0) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.star, color: warningColor, size: 12),
                            Text(
                              "${client["rating"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Rating",
                          style: TextStyle(
                            fontSize: 9,
                            color: disabledBoldColor,
                          ),
                        ),
                      ] else ...[
                        Text(
                          "New",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Client",
                          style: TextStyle(
                            fontSize: 9,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
          Text(
            "Billings: \$${((client["total_billings"] as double)).currency}",
            style: TextStyle(
              fontSize: 12,
              color: successColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  icon: Icons.visibility,
                  size: bs.sm,
                  onPressed: () => _viewClient(client["id"]),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showClientOptions(client),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredClients() {
    List<Map<String, dynamic>> filtered = clients;

    if (selectedFilter == "vip") {
      filtered = filtered.where((c) => (c["total_billings"] as double) > 100000).toList();
    } else if (selectedFilter == "recent") {
      filtered = filtered.where((c) => c["join_date"] != "N/A" && 
          DateTime.parse(c["join_date"]).isAfter(DateTime.now().subtract(Duration(days: 90)))).toList();
    } else if (selectedFilter == "high_value") {
      filtered = filtered.where((c) => (c["total_billings"] as double) > 50000).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((c) =>
          c["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          c["contact_person"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          c["email"].toString().toLowerCase().contains(searchQuery.toLowerCase())).toList();
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

  Color _getAvatarColor(String color) {
    switch (color.toLowerCase()) {
      case 'blue':
        return primaryColor;
      case 'green':
        return successColor;
      case 'purple':
        return infoColor;
      case 'orange':
        return warningColor;
      case 'red':
        return dangerColor;
      case 'gray':
        return disabledBoldColor;
      default:
        return primaryColor;
    }
  }

  void _addNewClient() {
    ss("Add new client");
  }

  void _showFilterOptions() {
    ss("Show filter options");
  }

  void _showSortOptions() {
    ss("Sort options");
  }

  void _viewClient(String clientId) {
    ss("Viewing client $clientId");
  }

  void _showClientOptions(Map<String, dynamic> client) {
    ss("Client options for ${client["id"]}");
  }
}
