import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsRoleAssignmentsView extends StatefulWidget {
  const RfsRoleAssignmentsView({super.key});

  @override
  State<RfsRoleAssignmentsView> createState() => _RfsRoleAssignmentsViewState();
}

class _RfsRoleAssignmentsViewState extends State<RfsRoleAssignmentsView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedRole = "";
  String selectedDepartment = "";

  List<Map<String, dynamic>> roles = [
    {
      "id": "ROLE001",
      "title": "Head Chef",
      "department": "Kitchen",
      "level": "Senior",
      "description": "Lead kitchen operations, menu planning, and staff supervision",
      "responsibilities": [
        "Oversee kitchen operations",
        "Menu development and planning",
        "Staff training and supervision",
        "Quality control and food safety",
        "Inventory and cost management",
      ],
      "permissions": [
        "Manage kitchen staff",
        "Approve purchase orders",
        "Access financial reports",
        "Modify menu items",
        "Schedule kitchen staff",
      ],
      "requirements": [
        "5+ years culinary experience",
        "Culinary degree or equivalent",
        "Food safety certification",
        "Leadership experience",
        "Cost management skills",
      ],
      "salary_range": "50000-60000",
      "assigned_employees": ["EMP001"],
      "openings": 0,
      "status": "Active",
    },
    {
      "id": "ROLE002",
      "title": "Sous Chef",
      "department": "Kitchen",
      "level": "Mid",
      "description": "Assist head chef and manage kitchen operations during shifts",
      "responsibilities": [
        "Assist in kitchen management",
        "Supervise line cooks",
        "Maintain food quality standards",
        "Inventory management",
        "Train junior staff",
      ],
      "permissions": [
        "Supervise kitchen staff",
        "Access inventory system",
        "Schedule prep work",
        "Approve time off requests",
        "Manage daily operations",
      ],
      "requirements": [
        "3+ years cooking experience",
        "Culinary training",
        "Food safety knowledge",
        "Leadership skills",
        "Team collaboration",
      ],
      "salary_range": "40000-50000",
      "assigned_employees": ["EMP002"],
      "openings": 1,
      "status": "Active",
    },
    {
      "id": "ROLE003",
      "title": "Server",
      "department": "Front of House",
      "level": "Entry",
      "description": "Provide excellent customer service and take food orders",
      "responsibilities": [
        "Take customer orders",
        "Serve food and beverages",
        "Handle customer inquiries",
        "Process payments",
        "Maintain dining area cleanliness",
      ],
      "permissions": [
        "Access POS system",
        "View menu information",
        "Process payments",
        "Access customer database",
        "Submit time-off requests",
      ],
      "requirements": [
        "Customer service experience",
        "Communication skills",
        "Physical ability to stand/walk",
        "Basic math skills",
        "Professional appearance",
      ],
      "salary_range": "25000-35000",
      "assigned_employees": ["EMP003", "EMP007"],
      "openings": 2,
      "status": "Active",
    },
    {
      "id": "ROLE004",
      "title": "Bartender",
      "department": "Bar",
      "level": "Mid",
      "description": "Prepare and serve alcoholic and non-alcoholic beverages",
      "responsibilities": [
        "Mix and serve drinks",
        "Maintain bar inventory",
        "Check customer IDs",
        "Handle cash transactions",
        "Clean bar equipment",
      ],
      "permissions": [
        "Access bar inventory",
        "Serve alcohol",
        "Handle cash register",
        "View drink recipes",
        "Manage bar supplies",
      ],
      "requirements": [
        "Responsible service certification",
        "Mixology knowledge",
        "Customer service skills",
        "Physical stamina",
        "Basic math skills",
      ],
      "salary_range": "30000-40000",
      "assigned_employees": ["EMP004"],
      "openings": 1,
      "status": "Active",
    },
    {
      "id": "ROLE005",
      "title": "Restaurant Manager",
      "department": "Management",
      "level": "Senior",
      "description": "Oversee daily restaurant operations and staff management",
      "responsibilities": [
        "Manage daily operations",
        "Staff scheduling and supervision",
        "Customer service oversight",
        "Financial management",
        "Compliance and safety",
      ],
      "permissions": [
        "Full system access",
        "Hire and terminate staff",
        "Approve purchases",
        "Access all reports",
        "Modify schedules",
      ],
      "requirements": [
        "5+ years management experience",
        "Business or hospitality degree",
        "Leadership skills",
        "Financial management",
        "Communication skills",
      ],
      "salary_range": "55000-70000",
      "assigned_employees": ["EMP006"],
      "openings": 0,
      "status": "Active",
    },
    {
      "id": "ROLE006",
      "title": "Line Cook",
      "department": "Kitchen",
      "level": "Entry",
      "description": "Prepare and cook food items according to recipes and standards",
      "responsibilities": [
        "Prepare ingredients",
        "Cook menu items",
        "Maintain station cleanliness",
        "Follow food safety protocols",
        "Assist with inventory",
      ],
      "permissions": [
        "Access kitchen equipment",
        "View recipes and procedures",
        "Submit supply requests",
        "Clock in/out",
        "Access schedule",
      ],
      "requirements": [
        "Basic cooking skills",
        "Food safety knowledge",
        "Physical ability to work long hours",
        "Team collaboration",
        "Attention to detail",
      ],
      "salary_range": "28000-35000",
      "assigned_employees": [],
      "openings": 3,
      "status": "Hiring",
    },
  ];

  List<Map<String, dynamic>> employees = [
    {
      "id": "EMP001",
      "name": "John Smith",
      "current_role": "Head Chef",
      "department": "Kitchen",
      "hire_date": "2022-01-15",
      "performance_score": 95,
      "avatar": "https://picsum.photos/60/60?random=1&keyword=person",
    },
    {
      "id": "EMP002",
      "name": "Sarah Johnson",
      "current_role": "Sous Chef",
      "department": "Kitchen",
      "hire_date": "2022-03-20",
      "performance_score": 88,
      "avatar": "https://picsum.photos/60/60?random=2&keyword=person",
    },
    {
      "id": "EMP003",
      "name": "Mike Wilson",
      "current_role": "Server",
      "department": "Front of House",
      "hire_date": "2023-06-10",
      "performance_score": 92,
      "avatar": "https://picsum.photos/60/60?random=3&keyword=person",
    },
    {
      "id": "EMP004",
      "name": "Emily Davis",
      "current_role": "Bartender",
      "department": "Bar",
      "hire_date": "2022-11-05",
      "performance_score": 89,
      "avatar": "https://picsum.photos/60/60?random=4&keyword=person",
    },
    {
      "id": "EMP006",
      "name": "Lisa Garcia",
      "current_role": "Restaurant Manager",
      "department": "Management",
      "hire_date": "2021-08-12",
      "performance_score": 96,
      "avatar": "https://picsum.photos/60/60?random=6&keyword=person",
    },
  ];

  List<Map<String, dynamic>> roleFilters = [
    {"label": "All Roles", "value": ""},
    {"label": "Entry Level", "value": "Entry"},
    {"label": "Mid Level", "value": "Mid"},
    {"label": "Senior Level", "value": "Senior"},
  ];

  List<Map<String, dynamic>> departments = [
    {"label": "All Departments", "value": ""},
    {"label": "Kitchen", "value": "Kitchen"},
    {"label": "Front of House", "value": "Front of House"},
    {"label": "Bar", "value": "Bar"},
    {"label": "Management", "value": "Management"},
  ];

  List<Map<String, dynamic>> roleChangeHistory = [
    {
      "employee_name": "Mike Wilson",
      "employee_id": "EMP003",
      "from_role": "Server Trainee",
      "to_role": "Server",
      "date": "2024-01-15",
      "reason": "Promotion after completing training",
      "approved_by": "Lisa Garcia",
    },
    {
      "employee_name": "Emily Davis",
      "employee_id": "EMP004",
      "from_role": "Bartender",
      "to_role": "Head Bartender",
      "date": "2024-02-01",
      "reason": "Promotion due to excellent performance",
      "approved_by": "Lisa Garcia",
    },
    {
      "employee_name": "Sarah Johnson",
      "employee_id": "EMP002",
      "from_role": "Line Cook",
      "to_role": "Sous Chef",
      "date": "2023-12-01",
      "reason": "Promotion to fill vacant position",
      "approved_by": "John Smith",
    },
  ];

  List<Map<String, dynamic>> get filteredRoles {
    return roles.where((role) {
      bool matchesSearch = searchQuery.isEmpty ||
          (role["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (role["department"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesRole = selectedRole.isEmpty || role["level"] == selectedRole;
      bool matchesDepartment = selectedDepartment.isEmpty || role["department"] == selectedDepartment;
      
      return matchesSearch && matchesRole && matchesDepartment;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Role Assignments",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Roles", icon: Icon(Icons.work)),
        Tab(text: "Assignments", icon: Icon(Icons.assignment_ind)),
        Tab(text: "History", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        _buildRolesTab(),
        _buildAssignmentsTab(),
        _buildHistoryTab(),
      ],
    );
  }

  Widget _buildRolesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildSearchAndFilters(),
          _buildRoleStats(),
          _buildRolesList(),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Column(
      spacing: spSm,
      children: [
        QTextField(
          label: "Search Roles",
          value: searchQuery,
          hint: "Search by role title or department",
          onChanged: (value) {
            searchQuery = value;
            setState(() {});
          },
        ),
        Row(
          children: [
            Expanded(
              child: QDropdownField(
                label: "Role Level",
                items: roleFilters,
                value: selectedRole,
                onChanged: (value, label) {
                  selectedRole = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: QDropdownField(
                label: "Department",
                items: departments,
                value: selectedDepartment,
                onChanged: (value, label) {
                  selectedDepartment = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRoleStats() {
    int totalRoles = roles.length;
    int activeRoles = roles.where((r) => r["status"] == "Active").length;
    int openPositions = roles.fold(0, (sum, role) => sum + (role["openings"] as int));
    int assignedEmployees = roles.fold(0, (sum, role) => sum + (role["assigned_employees"] as List).length);

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 160,
      children: [
        _buildStatCard("Total Roles", "$totalRoles", Icons.work, primaryColor),
        _buildStatCard("Active Roles", "$activeRoles", Icons.check_circle, successColor),
        _buildStatCard("Open Positions", "$openPositions", Icons.person_add, warningColor),
        _buildStatCard("Assigned Staff", "$assignedEmployees", Icons.people, infoColor),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
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

  Widget _buildRolesList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Roles (${filteredRoles.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            QButton(
              label: "Create Role",
              icon: Icons.add,
              size: bs.sm,
              onPressed: () {},
            ),
          ],
        ),
        ...filteredRoles.map((role) => _buildRoleCard(role)),
      ],
    );
  }

  Widget _buildRoleCard(Map<String, dynamic> role) {
    Color levelColor = role["level"] == "Senior" 
        ? primaryColor 
        : role["level"] == "Mid"
        ? warningColor
        : successColor;

    Color statusColor = role["status"] == "Active" 
        ? successColor 
        : role["status"] == "Hiring"
        ? warningColor
        : dangerColor;

    List assignedEmployees = role["assigned_employees"] as List;
    int openings = role["openings"] as int;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${role["title"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: levelColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${role["level"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: levelColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${role["department"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Salary: ${role["salary_range"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${role["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${role["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 120,
            children: [
              _buildRoleMetric("Assigned", "${assignedEmployees.length}", Icons.people),
              _buildRoleMetric("Openings", "$openings", Icons.person_add),
              _buildRoleMetric("Permissions", "${(role["permissions"] as List).length}", Icons.security),
              _buildRoleMetric("Requirements", "${(role["requirements"] as List).length}", Icons.checklist),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () => _showRoleDetails(role),
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
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRoleMetric(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: primaryColor, size: 16),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: disabledColor,
          ),
        ),
      ],
    );
  }

  Widget _buildAssignmentsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildEmployeeAssignments(),
          _buildUnassignedRoles(),
        ],
      ),
    );
  }

  Widget _buildEmployeeAssignments() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Employee Assignments",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...employees.map((employee) => _buildEmployeeAssignmentCard(employee)),
      ],
    );
  }

  Widget _buildEmployeeAssignmentCard(Map<String, dynamic> employee) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage("${employee["avatar"]}"),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${employee["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${employee["current_role"]} • ${employee["department"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "Performance: ${employee["performance_score"]}%",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledColor,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              QButton(
                label: "Reassign",
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(height: spXs),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUnassignedRoles() {
    List<Map<String, dynamic>> unassignedRoles = roles.where((role) => (role["openings"] as int) > 0).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Open Positions (${unassignedRoles.length})",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        if (unassignedRoles.isEmpty)
          Container(
            padding: EdgeInsets.all(spLg),
            decoration: BoxDecoration(
              color: successColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: successColor),
                SizedBox(width: spSm),
                Text(
                  "All positions are currently filled",
                  style: TextStyle(
                    fontSize: 14,
                    color: successColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          )
        else
          ...unassignedRoles.map((role) => _buildOpenPositionCard(role)),
      ],
    );
  }

  Widget _buildOpenPositionCard(Map<String, dynamic> role) {
    int openings = role["openings"] as int;

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: warningColor.withAlpha(50)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(Icons.work, color: warningColor, size: 24),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${role["title"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${role["department"]} • ${role["level"]} Level",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "$openings ${openings == 1 ? 'opening' : 'openings'} available",
                  style: TextStyle(
                    fontSize: 12,
                    color: warningColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            label: "Hire",
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Role Change History",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...roleChangeHistory.map((change) => _buildHistoryCard(change)),
        ],
      ),
    );
  }

  Widget _buildHistoryCard(Map<String, dynamic> change) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
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
              Icon(Icons.trending_up, color: successColor, size: 20),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "${change["employee_name"]} - Role Change",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Text(
                "${change["date"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: disabledColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "From: ${change["from_role"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Icon(Icons.arrow_forward, color: disabledColor, size: 16),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "To: ${change["to_role"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: successColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "Reason: ${change["reason"]}",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          Text(
            "Approved by: ${change["approved_by"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledColor,
            ),
          ),
        ],
      ),
    );
  }

  void _showRoleDetails(Map<String, dynamic> role) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "${role["title"]}",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                QButton(
                  icon: Icons.close,
                  size: bs.sm,
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            Text(
              "${role["department"]} • ${role["level"]} Level",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spMd),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    _buildDetailSection("Description", [role["description"] as String]),
                    _buildDetailSection("Responsibilities", (role["responsibilities"] as List).cast<String>()),
                    _buildDetailSection("Permissions", (role["permissions"] as List).cast<String>()),
                    _buildDetailSection("Requirements", (role["requirements"] as List).cast<String>()),
                    _buildDetailSection("Salary Range", ["\$${role["salary_range"]}"]),
                    _buildAssignedEmployeesSection(role),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, List<String> items) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...items.map((item) => Padding(
            padding: EdgeInsets.only(bottom: spXs),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("• ", style: TextStyle(color: primaryColor)),
                Expanded(
                  child: Text(
                    item,
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildAssignedEmployeesSection(Map<String, dynamic> role) {
    List assignedEmployees = role["assigned_employees"] as List;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Assigned Employees (${assignedEmployees.length})",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          if (assignedEmployees.isEmpty)
            Text(
              "No employees currently assigned to this role",
              style: TextStyle(
                fontSize: 14,
                color: disabledColor,
                fontStyle: FontStyle.italic,
              ),
            )
          else
            ...assignedEmployees.map((empId) {
              var employee = employees.firstWhere((e) => e["id"] == empId, orElse: () => {"name": "Unknown Employee"});
              return Container(
                margin: EdgeInsets.only(bottom: spXs),
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${employee["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }),
        ],
      ),
    );
  }
}
