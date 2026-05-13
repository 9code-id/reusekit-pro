import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmTicketListView extends StatefulWidget {
  const CrmTicketListView({super.key});

  @override
  State<CrmTicketListView> createState() => _CrmTicketListViewState();
}

class _CrmTicketListViewState extends State<CrmTicketListView> {
  String searchQuery = "";
  String selectedStatus = "all";
  String selectedPriority = "all";
  String selectedCategory = "all";
  String sortBy = "created_desc";
  bool isGridView = false;

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Open", "value": "open"},
    {"label": "In Progress", "value": "in_progress"},
    {"label": "Pending", "value": "pending"},
    {"label": "Resolved", "value": "resolved"},
    {"label": "Closed", "value": "closed"},
  ];

  List<Map<String, dynamic>> priorityOptions = [
    {"label": "All Priority", "value": "all"},
    {"label": "Critical", "value": "critical"},
    {"label": "High", "value": "high"},
    {"label": "Medium", "value": "medium"},
    {"label": "Low", "value": "low"},
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "all"},
    {"label": "Technical Support", "value": "technical"},
    {"label": "Billing", "value": "billing"},
    {"label": "General Inquiry", "value": "general"},
    {"label": "Bug Report", "value": "bug"},
    {"label": "Feature Request", "value": "feature"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Newest First", "value": "created_desc"},
    {"label": "Oldest First", "value": "created_asc"},
    {"label": "Priority High to Low", "value": "priority_desc"},
    {"label": "Priority Low to High", "value": "priority_asc"},
    {"label": "Status", "value": "status"},
  ];

  List<Map<String, dynamic>> tickets = [
    {
      "id": "TKT-001",
      "subject": "Unable to login to account",
      "description": "Customer cannot access their account after password reset",
      "customer": "John Smith",
      "email": "john.smith@example.com",
      "priority": "high",
      "status": "open",
      "category": "technical",
      "assignee": "Sarah Johnson",
      "created": "2024-06-19 09:00:00",
      "updated": "2024-06-19 10:30:00",
      "dueDate": "2024-06-20 17:00:00",
      "tags": ["login", "password", "urgent"]
    },
    {
      "id": "TKT-002",
      "subject": "Billing inquiry for last month",
      "description": "Customer has questions about charges on their monthly bill",
      "customer": "Emily Davis",
      "email": "emily.davis@example.com",
      "priority": "medium",
      "status": "in_progress",
      "category": "billing",
      "assignee": "Mike Wilson",
      "created": "2024-06-19 08:45:00",
      "updated": "2024-06-19 09:15:00",
      "dueDate": "2024-06-21 17:00:00",
      "tags": ["billing", "charges"]
    },
    {
      "id": "TKT-003",
      "subject": "Feature request: Dark mode",
      "description": "User would like dark mode option in the application",
      "customer": "Robert Brown",
      "email": "robert.brown@example.com",
      "priority": "low",
      "status": "pending",
      "category": "feature",
      "assignee": "Lisa Chen",
      "created": "2024-06-19 07:30:00",
      "updated": "2024-06-19 08:00:00",
      "dueDate": "2024-06-25 17:00:00",
      "tags": ["enhancement", "ui"]
    },
    {
      "id": "TKT-004",
      "subject": "Application crashes on startup",
      "description": "Critical bug causing app to crash immediately after launch",
      "customer": "Maria Garcia",
      "email": "maria.garcia@example.com",
      "priority": "critical",
      "status": "open",
      "category": "bug",
      "assignee": "David Park",
      "created": "2024-06-19 06:20:00",
      "updated": "2024-06-19 07:00:00",
      "dueDate": "2024-06-19 18:00:00",
      "tags": ["critical", "crash", "bug"]
    },
    {
      "id": "TKT-005",
      "subject": "How to export data",
      "description": "Customer needs help exporting their data from the system",
      "customer": "James Wilson",
      "email": "james.wilson@example.com",
      "priority": "low",
      "status": "resolved",
      "category": "general",
      "assignee": "Anna Lee",
      "created": "2024-06-18 15:30:00",
      "updated": "2024-06-19 09:45:00",
      "dueDate": "2024-06-22 17:00:00",
      "tags": ["export", "help"]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Tickets"),
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
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {
              // Navigate to create ticket
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: Column(
        children: [
          _buildFilterBar(),
          Expanded(
            child: isGridView ? _buildGridView() : _buildListView(),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search tickets",
                  value: searchQuery,
                  hint: "Ticket ID, subject, or customer",
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
              SizedBox(width: spSm),
              QButton(
                icon: Icons.filter_list,
                size: bs.sm,
                onPressed: () {
                  _showFilterDialog();
                },
              ),
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip("Status", selectedStatus),
                SizedBox(width: spSm),
                _buildFilterChip("Priority", selectedPriority),
                SizedBox(width: spSm),
                _buildFilterChip("Category", selectedCategory),
                SizedBox(width: spSm),
                _buildSortChip(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
    bool isActive = value != "all";
    return GestureDetector(
      onTap: () {
        _showFilterDialog();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
        decoration: BoxDecoration(
          color: isActive ? primaryColor.withAlpha(20) : Colors.grey.withAlpha(20),
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: isActive ? primaryColor : Colors.grey,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "$label: ${value == "all" ? "All" : value}",
              style: TextStyle(
                fontSize: 12,
                color: isActive ? primaryColor : disabledBoldColor,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            if (isActive) ...[
              SizedBox(width: spXs),
              Icon(
                Icons.close,
                size: 14,
                color: primaryColor,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSortChip() {
    return GestureDetector(
      onTap: () {
        _showSortDialog();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
        decoration: BoxDecoration(
          color: primaryColor.withAlpha(20),
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(color: primaryColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.sort, size: 14, color: primaryColor),
            SizedBox(width: spXs),
            Text(
              "Sort",
              style: TextStyle(
                fontSize: 12,
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spSm,
        children: [
          _buildTicketCounter(),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: tickets.length,
            separatorBuilder: (context, index) => SizedBox(height: spSm),
            itemBuilder: (context, index) {
              final ticket = tickets[index];
              return _buildTicketCard(ticket);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGridView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildTicketCounter(),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: tickets.map((ticket) => _buildTicketGridCard(ticket)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTicketCounter() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Icon(Icons.confirmation_number, color: primaryColor, size: 20),
          SizedBox(width: spSm),
          Text(
            "${tickets.length} tickets found",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Spacer(),
          Text(
            "Updated just now",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTicketCard(Map<String, dynamic> ticket) {
    Color priorityColor = _getPriorityColor(ticket["priority"]);
    Color statusColor = _getStatusColor(ticket["status"]);

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: priorityColor,
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Text(
                "${ticket["id"]}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${ticket["status"]}".replaceAll("_", " ").toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "${ticket["subject"]}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "${ticket["description"]}",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ),
          Row(
            children: [
              Icon(Icons.person, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${ticket["customer"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spMd),
              Icon(Icons.assignment_ind, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${ticket["assignee"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: priorityColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${ticket["priority"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: priorityColor,
                  ),
                ),
              ),
            ],
          ),
          if (ticket["tags"] != null) ...[
            Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                spacing: spXs,
                children: (ticket["tags"] as List).map((tag) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "$tag",
                      style: TextStyle(
                        fontSize: 10,
                        color: infoColor,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
          Row(
            children: [
              Icon(Icons.access_time, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Created: ${DateTime.parse(ticket["created"]).dMMMy}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "Due: ${DateTime.parse(ticket["dueDate"]).dMMMy}",
                style: TextStyle(
                  fontSize: 12,
                  color: dangerColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {
                    // Navigate to ticket detail
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.comment,
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  _showTicketActions(ticket);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTicketGridCard(Map<String, dynamic> ticket) {
    Color priorityColor = _getPriorityColor(ticket["priority"]);
    Color statusColor = _getStatusColor(ticket["status"]);

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
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: priorityColor,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "${ticket["id"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${ticket["status"]}".replaceAll("_", " ").toUpperCase(),
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "${ticket["subject"]}",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "${ticket["customer"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Text(
            "Assigned to: ${ticket["assignee"]}",
            style: TextStyle(
              fontSize: 11,
              color: disabledBoldColor,
            ),
          ),
          Container(
            width: double.infinity,
            child: QButton(
              label: "View",
              size: bs.sm,
              onPressed: () {
                // Navigate to ticket detail
              },
            ),
          ),
        ],
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "critical":
        return dangerColor;
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "open":
        return dangerColor;
      case "in_progress":
        return warningColor;
      case "pending":
        return infoColor;
      case "resolved":
        return successColor;
      case "closed":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Filter Tickets"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            QDropdownField(
              label: "Status",
              items: statusOptions,
              value: selectedStatus,
              onChanged: (value, label) {
                selectedStatus = value;
                setState(() {});
                Navigator.pop(context);
              },
            ),
            QDropdownField(
              label: "Priority",
              items: priorityOptions,
              value: selectedPriority,
              onChanged: (value, label) {
                selectedPriority = value;
                setState(() {});
                Navigator.pop(context);
              },
            ),
            QDropdownField(
              label: "Category",
              items: categoryOptions,
              value: selectedCategory,
              onChanged: (value, label) {
                selectedCategory = value;
                setState(() {});
                Navigator.pop(context);
              },
            ),
          ],
        ),
        actions: [
          QButton(
            label: "Clear All",
            size: bs.sm,
            onPressed: () {
              selectedStatus = "all";
              selectedPriority = "all";
              selectedCategory = "all";
              setState(() {});
              Navigator.pop(context);
            },
          ),
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _showSortDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Sort Tickets"),
        content: QDropdownField(
          label: "Sort by",
          items: sortOptions,
          value: sortBy,
          onChanged: (value, label) {
            sortBy = value;
            setState(() {});
            Navigator.pop(context);
          },
        ),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _showTicketActions(Map<String, dynamic> ticket) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Ticket Actions"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            QButton(
              label: "Assign to Me",
              size: bs.sm,
              icon: Icons.assignment_ind,
              onPressed: () {
                Navigator.pop(context);
                ss("Ticket assigned to you");
              },
            ),
            QButton(
              label: "Change Priority",
              size: bs.sm,
              icon: Icons.priority_high,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            QButton(
              label: "Move to Pending",
              size: bs.sm,
              icon: Icons.pending,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            QButton(
              label: "Close Ticket",
              size: bs.sm,
              icon: Icons.close,
              color: dangerColor,
              onPressed: () async {
                Navigator.pop(context);
                bool isConfirmed = await confirm("Close this ticket?");
                if (isConfirmed) {
                  ss("Ticket closed successfully");
                }
              },
            ),
          ],
        ),
        actions: [
          QButton(
            label: "Cancel",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
