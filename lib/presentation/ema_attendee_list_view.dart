import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaAttendeeListView extends StatefulWidget {
  const EmaAttendeeListView({super.key});

  @override
  State<EmaAttendeeListView> createState() => _EmaAttendeeListViewState();
}

class _EmaAttendeeListViewState extends State<EmaAttendeeListView> {
  String searchQuery = "";
  String selectedFilter = "All";
  String sortBy = "name";
  bool isAscending = true;
  
  List<Map<String, dynamic>> attendees = [
    {
      "id": "ATT-001",
      "name": "John Doe",
      "email": "john@example.com",
      "phone": "+1-555-0123",
      "company": "Tech Solutions Inc",
      "job_title": "Senior Developer",
      "ticket_type": "Regular",
      "ticket_id": "TKT-001-001",
      "check_in_status": "Checked In",
      "check_in_time": "2024-07-15T09:15:00Z",
      "registration_date": "2024-06-19",
      "dietary_requirements": "Vegetarian",
      "sessions_count": 3
    },
    {
      "id": "ATT-002",
      "name": "Jane Smith",
      "email": "jane@example.com",
      "phone": "+1-555-0124",
      "company": "Digital Innovations",
      "job_title": "UI/UX Designer",
      "ticket_type": "VIP",
      "ticket_id": "TKT-002-001",
      "check_in_status": "Not Checked In",
      "check_in_time": null,
      "registration_date": "2024-06-20",
      "dietary_requirements": "None",
      "sessions_count": 5
    },
    {
      "id": "ATT-003",
      "name": "Mike Johnson",
      "email": "mike@example.com",
      "phone": "+1-555-0125",
      "company": "StartupX",
      "job_title": "CTO",
      "ticket_type": "VIP",
      "ticket_id": "TKT-002-002",
      "check_in_status": "Checked In",
      "check_in_time": "2024-07-15T08:45:00Z",
      "registration_date": "2024-06-18",
      "dietary_requirements": "Gluten Free",
      "sessions_count": 4
    },
    {
      "id": "ATT-004",
      "name": "Sarah Wilson",
      "email": "sarah@example.com",
      "phone": "+1-555-0126",
      "company": "Creative Agency",
      "job_title": "Lead Developer",
      "ticket_type": "Regular",
      "ticket_id": "TKT-001-003",
      "check_in_status": "Not Checked In",
      "check_in_time": null,
      "registration_date": "2024-06-21",
      "dietary_requirements": "Vegan",
      "sessions_count": 2
    },
    {
      "id": "ATT-005",
      "name": "David Brown",
      "email": "david@example.com",
      "phone": "+1-555-0127",
      "company": "Enterprise Corp",
      "job_title": "Software Architect",
      "ticket_type": "Regular",
      "ticket_id": "TKT-001-004",
      "check_in_status": "Checked In",
      "check_in_time": "2024-07-15T09:30:00Z",
      "registration_date": "2024-06-17",
      "dietary_requirements": "None",
      "sessions_count": 3
    }
  ];

  List<Map<String, dynamic>> get filteredAndSortedAttendees {
    List<Map<String, dynamic>> filtered = attendees;
    
    // Apply search filter
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((attendee) {
        final name = (attendee["name"] as String).toLowerCase();
        final email = (attendee["email"] as String).toLowerCase();
        final company = (attendee["company"] as String).toLowerCase();
        final query = searchQuery.toLowerCase();
        return name.contains(query) || email.contains(query) || company.contains(query);
      }).toList();
    }
    
    // Apply status filter
    if (selectedFilter != "All") {
      filtered = filtered.where((attendee) => attendee["check_in_status"] == selectedFilter).toList();
    }
    
    // Apply sorting
    filtered.sort((a, b) {
      dynamic aValue = a[sortBy];
      dynamic bValue = b[sortBy];
      
      if (sortBy == "check_in_time") {
        aValue = aValue != null ? DateTime.parse(aValue) : DateTime(1970);
        bValue = bValue != null ? DateTime.parse(bValue) : DateTime(1970);
      }
      
      int comparison = aValue.toString().compareTo(bValue.toString());
      return isAscending ? comparison : -comparison;
    });
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendee List"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterBottomSheet();
            },
          ),
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: () {
              _showSortBottomSheet();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchAndStats(),
          Expanded(
            child: _buildAttendeesList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //navigateTo EmaAttendeeManagementView for adding new attendee
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildSearchAndStats() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowXs],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search attendees...",
                      prefixIcon: Icon(Icons.search, color: primaryColor),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    ),
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
              ),
            ],
          ),
          _buildQuickStats(),
          _buildFilterChips(),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    final totalAttendees = attendees.length;
    final checkedInCount = attendees.where((a) => a["check_in_status"] == "Checked In").length;
    final notCheckedInCount = attendees.where((a) => a["check_in_status"] == "Not Checked In").length;
    final vipCount = attendees.where((a) => a["ticket_type"] == "VIP").length;

    return Row(
      spacing: spSm,
      children: [
        Expanded(
          child: _buildStatCard("Total", "$totalAttendees", Icons.people, primaryColor),
        ),
        Expanded(
          child: _buildStatCard("Checked In", "$checkedInCount", Icons.check_circle, successColor),
        ),
        Expanded(
          child: _buildStatCard("Pending", "$notCheckedInCount", Icons.schedule, warningColor),
        ),
        Expanded(
          child: _buildStatCard("VIP", "$vipCount", Icons.star, infoColor),
        ),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Icon(icon, color: color, size: 20),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
              fontSize: 14,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    final filters = ["All", "Checked In", "Not Checked In"];
    
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: spSm,
        children: filters.map((filter) {
          final isSelected = selectedFilter == filter;
          return GestureDetector(
            onTap: () {
              selectedFilter = filter;
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
              decoration: BoxDecoration(
                color: isSelected ? primaryColor : primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Text(
                filter,
                style: TextStyle(
                  color: isSelected ? Colors.white : primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildAttendeesList() {
    final filteredAttendees = filteredAndSortedAttendees;
    
    if (filteredAttendees.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: spMd,
          children: [
            Icon(
              Icons.people_outline,
              size: 64,
              color: disabledColor,
            ),
            Text(
              "No attendees found",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: disabledBoldColor,
              ),
            ),
            Text(
              "Try adjusting your search or filter criteria",
              style: TextStyle(
                color: disabledBoldColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: filteredAttendees.length,
      itemBuilder: (context, index) {
        final attendee = filteredAttendees[index];
        return _buildAttendeeCard(attendee);
      },
    );
  }

  Widget _buildAttendeeCard(Map<String, dynamic> attendee) {
    final checkInStatus = attendee["check_in_status"] as String;
    final ticketType = attendee["ticket_type"] as String;
    
    Color statusColor = checkInStatus == "Checked In" ? successColor : warningColor;
    Color ticketColor = ticketType == "VIP" ? infoColor : primaryColor;

    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: primaryColor.withAlpha(50),
                      child: Text(
                        "${(attendee["name"] as String).substring(0, 2).toUpperCase()}",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${attendee["name"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
                                decoration: BoxDecoration(
                                  color: statusColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      checkInStatus == "Checked In" ? Icons.check_circle : Icons.schedule,
                                      size: 12,
                                      color: statusColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      checkInStatus,
                                      style: TextStyle(
                                        color: statusColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${attendee["job_title"]} at ${attendee["company"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.email, size: 14, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "${attendee["email"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: _buildAttendeeInfoChip(
                        Icons.confirmation_number,
                        ticketType,
                        ticketColor,
                      ),
                    ),
                    Expanded(
                      child: _buildAttendeeInfoChip(
                        Icons.event,
                        "${attendee["sessions_count"]} Sessions",
                        primaryColor,
                      ),
                    ),
                    Expanded(
                      child: _buildAttendeeInfoChip(
                        Icons.restaurant,
                        "${attendee["dietary_requirements"]}",
                        warningColor,
                      ),
                    ),
                  ],
                ),
                if (checkInStatus == "Checked In" && attendee["check_in_time"] != null)
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.access_time, size: 16, color: successColor),
                        SizedBox(width: spSm),
                        Text(
                          "Checked in at ${DateTime.parse(attendee["check_in_time"]).hour.toString().padLeft(2, '0')}:${DateTime.parse(attendee["check_in_time"]).minute.toString().padLeft(2, '0')}",
                          style: TextStyle(
                            color: successColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(radiusLg)),
            ),
            child: Row(
              children: [
                Text(
                  "ID: ${attendee["ticket_id"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 12,
                  ),
                ),
                Spacer(),
                QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo EmaAttendeeView with attendee data
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttendeeInfoChip(IconData icon, String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          SizedBox(width: spXs),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spMd,
            children: [
              Row(
                children: [
                  Text(
                    "Filter Attendees",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              Text(
                "Filter attendees by check-in status",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 14,
                ),
              ),
              Column(
                spacing: spSm,
                children: ["All", "Checked In", "Not Checked In"].map((filter) {
                  return Container(
                    width: double.infinity,
                    child: QButton(
                      label: filter,
                      size: bs.md,
                      onPressed: () {
                        selectedFilter = filter;
                        setState(() {});
                        Navigator.pop(context);
                      },
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSortBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spMd,
            children: [
              Row(
                children: [
                  Text(
                    "Sort Attendees",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              Column(
                spacing: spSm,
                children: [
                  _buildSortOption("Name", "name", Icons.person),
                  _buildSortOption("Company", "company", Icons.business),
                  _buildSortOption("Registration Date", "registration_date", Icons.calendar_today),
                  _buildSortOption("Check-in Time", "check_in_time", Icons.access_time),
                ],
              ),
              Row(
                spacing: spSm,
                children: [
                  Expanded(
                    child: QButton(
                      label: "Ascending",
                      size: bs.md,
                      onPressed: () {
                        isAscending = true;
                        setState(() {});
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Expanded(
                    child: QButton(
                      label: "Descending",
                      size: bs.md,
                      onPressed: () {
                        isAscending = false;
                        setState(() {});
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSortOption(String label, String value, IconData icon) {
    return GestureDetector(
      onTap: () {
        sortBy = value;
        setState(() {});
        Navigator.pop(context);
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          border: Border.all(
            color: sortBy == value ? primaryColor : disabledOutlineBorderColor,
            width: sortBy == value ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(radiusSm),
          color: sortBy == value ? primaryColor.withAlpha(20) : Colors.transparent,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: sortBy == value ? primaryColor : disabledBoldColor,
            ),
            SizedBox(width: spSm),
            Text(
              label,
              style: TextStyle(
                fontWeight: sortBy == value ? FontWeight.bold : FontWeight.normal,
                color: sortBy == value ? primaryColor : disabledBoldColor,
              ),
            ),
            Spacer(),
            if (sortBy == value)
              Icon(Icons.check, color: primaryColor),
          ],
        ),
      ),
    );
  }
}
