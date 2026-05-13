import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaStaffManagementView extends StatefulWidget {
  const HhaStaffManagementView({super.key});

  @override
  State<HhaStaffManagementView> createState() => _HhaStaffManagementViewState();
}

class _HhaStaffManagementViewState extends State<HhaStaffManagementView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedDepartment = "all";
  String selectedStatus = "all";
  
  // Staff form fields
  String firstName = "";
  String lastName = "";
  String email = "";
  String phone = "";
  String department = "front_desk";
  String position = "";
  String employeeId = "";
  String hireDate = "";
  String emergencyContact = "";
  String emergencyPhone = "";
  String status = "active";
  
  List<Map<String, dynamic>> departmentOptions = [
    {"label": "All Departments", "value": "all"},
    {"label": "Front Desk", "value": "front_desk"},
    {"label": "Housekeeping", "value": "housekeeping"},
    {"label": "Food & Beverage", "value": "food_beverage"},
    {"label": "Maintenance", "value": "maintenance"},
    {"label": "Management", "value": "management"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Inactive", "value": "inactive"},
    {"label": "On Leave", "value": "on_leave"},
  ];

  List<Map<String, dynamic>> departmentFormOptions = [
    {"label": "Front Desk", "value": "front_desk"},
    {"label": "Housekeeping", "value": "housekeeping"},
    {"label": "Food & Beverage", "value": "food_beverage"},
    {"label": "Maintenance", "value": "maintenance"},
    {"label": "Management", "value": "management"},
  ];

  List<Map<String, dynamic>> statusFormOptions = [
    {"label": "Active", "value": "active"},
    {"label": "Inactive", "value": "inactive"},
    {"label": "On Leave", "value": "on_leave"},
  ];

  List<Map<String, dynamic>> staff = [
    {
      "id": "EMP001",
      "employee_id": "HD001",
      "first_name": "John",
      "last_name": "Smith",
      "email": "john.smith@hotel.com",
      "phone": "+1-555-0101",
      "department": "front_desk",
      "position": "Front Desk Manager",
      "hire_date": "2023-01-15",
      "status": "active",
      "emergency_contact": "Jane Smith",
      "emergency_phone": "+1-555-0102",
      "salary": 55000.0,
      "performance_rating": 4.8,
      "training_completed": 12,
      "certifications": ["CPR", "First Aid", "Hotel Management"],
      "schedule_type": "full_time",
    },
    {
      "id": "EMP002",
      "employee_id": "HK001",
      "first_name": "Maria",
      "last_name": "Garcia",
      "email": "maria.garcia@hotel.com",
      "phone": "+1-555-0201",
      "department": "housekeeping",
      "position": "Housekeeping Supervisor",
      "hire_date": "2023-03-20",
      "status": "active",
      "emergency_contact": "Carlos Garcia",
      "emergency_phone": "+1-555-0202",
      "salary": 42000.0,
      "performance_rating": 4.6,
      "training_completed": 8,
      "certifications": ["Safety Training", "Chemical Handling"],
      "schedule_type": "full_time",
    },
    {
      "id": "EMP003",
      "employee_id": "FB001",
      "first_name": "David",
      "last_name": "Johnson",
      "email": "david.johnson@hotel.com",
      "phone": "+1-555-0301",
      "department": "food_beverage",
      "position": "Restaurant Manager",
      "hire_date": "2022-11-10",
      "status": "active",
      "emergency_contact": "Lisa Johnson",
      "emergency_phone": "+1-555-0302",
      "salary": 48000.0,
      "performance_rating": 4.7,
      "training_completed": 15,
      "certifications": ["Food Safety", "ServSafe", "Wine Certification"],
      "schedule_type": "full_time",
    },
    {
      "id": "EMP004",
      "employee_id": "MT001",
      "first_name": "Robert",
      "last_name": "Wilson",
      "email": "robert.wilson@hotel.com",
      "phone": "+1-555-0401",
      "department": "maintenance",
      "position": "Maintenance Technician",
      "hire_date": "2023-06-01",
      "status": "active",
      "emergency_contact": "Susan Wilson",
      "emergency_phone": "+1-555-0402",
      "salary": 38000.0,
      "performance_rating": 4.5,
      "training_completed": 6,
      "certifications": ["HVAC", "Electrical", "Plumbing"],
      "schedule_type": "full_time",
    },
    {
      "id": "EMP005",
      "employee_id": "HD002",
      "first_name": "Sarah",
      "last_name": "Davis",
      "email": "sarah.davis@hotel.com",
      "phone": "+1-555-0501",
      "department": "front_desk",
      "position": "Front Desk Agent",
      "hire_date": "2023-09-15",
      "status": "on_leave",
      "emergency_contact": "Michael Davis",
      "emergency_phone": "+1-555-0502",
      "salary": 32000.0,
      "performance_rating": 4.3,
      "training_completed": 4,
      "certifications": ["Customer Service"],
      "schedule_type": "part_time",
    },
  ];

  List<Map<String, dynamic>> get filteredStaff {
    return staff.where((employee) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${employee["first_name"]} ${employee["last_name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          (employee["email"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (employee["employee_id"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (employee["position"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesDepartment = selectedDepartment == "all" || employee["department"] == selectedDepartment;
      bool matchesStatus = selectedStatus == "all" || employee["status"] == selectedStatus;
      
      return matchesSearch && matchesDepartment && matchesStatus;
    }).toList();
  }

  int get totalActiveStaff {
    return staff.where((s) => s["status"] == "active").length;
  }

  int get totalOnLeave {
    return staff.where((s) => s["status"] == "on_leave").length;
  }

  double get averageRating {
    return staff.fold(0.0, (sum, s) => sum + (s["performance_rating"] as double)) / staff.length;
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Staff Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Staff List", icon: Icon(Icons.people)),
        Tab(text: "Add Staff", icon: Icon(Icons.person_add)),
        Tab(text: "Reports", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildStaffListTab(),
        _buildAddStaffTab(),
        _buildReportsTab(),
      ],
    );
  }

  Widget _buildStaffListTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Search and Filters
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search",
                  hint: "Search by name, email, ID, or position",
                  value: searchQuery,
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
                  label: "Department",
                  items: departmentOptions,
                  value: selectedDepartment,
                  onChanged: (value, label) {
                    selectedDepartment = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
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
            ],
          ),

          // Summary Stats
          Row(
            children: [
              Expanded(
                child: Container(
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
                        "Active Staff",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "$totalActiveStaff",
                        style: TextStyle(
                          fontSize: fsH4,
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
                        "On Leave",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),                      Text(
                        "$totalOnLeave",
                        style: TextStyle(
                          fontSize: fsH4,
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

          Row(
            children: [
              Expanded(
                child: Container(
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
                        "Avg Rating",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${averageRating.toStringAsFixed(1)}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
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
                        "Total Staff",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${staff.length}",
                        style: TextStyle(
                          fontSize: fsH4,
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

          Text(
            "Staff Members",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),

          // Staff List
          ...filteredStaff.map((employee) => Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
              border: Border(
                left: BorderSide(
                  width: 4,
                  color: (employee["status"] as String) == "active" 
                      ? successColor 
                      : (employee["status"] as String) == "on_leave"
                          ? warningColor
                          : disabledBoldColor,
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
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Center(
                        child: Text(
                          "${employee["first_name"]}".substring(0, 1) + 
                          "${employee["last_name"]}".substring(0, 1),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${employee["first_name"]} ${employee["last_name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${employee["position"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "ID: ${employee["employee_id"]} • ${employee["department"]}".replaceAll("_", " ").toUpperCase(),
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: (employee["status"] as String) == "active" 
                                ? successColor.withAlpha(20)
                                : (employee["status"] as String) == "on_leave"
                                    ? warningColor.withAlpha(20)
                                    : disabledColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${employee["status"]}".replaceAll("_", " ").toUpperCase(),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: (employee["status"] as String) == "active" 
                                  ? successColor
                                  : (employee["status"] as String) == "on_leave"
                                      ? warningColor
                                      : disabledBoldColor,
                            ),
                          ),
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: warningColor,
                              size: 16,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "${employee["performance_rating"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: warningColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Email: ${employee["email"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                          Text(
                            "Hired: ${employee["hire_date"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Phone: ${employee["phone"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                          Text(
                            "Trainings: ${employee["training_completed"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      if ((employee["certifications"] as List).isNotEmpty)
                        Wrap(
                          spacing: spXs,
                          runSpacing: spXs,
                          children: (employee["certifications"] as List).map((cert) => Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "$cert",
                              style: TextStyle(
                                fontSize: 10,
                                color: infoColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )).toList(),
                        ),
                    ],
                  ),
                ),

                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "View Profile",
                        size: bs.sm,
                        onPressed: () {
                          _viewStaffProfile(employee);
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Edit",
                        size: bs.sm,
                        onPressed: () {
                          _editStaff(employee);
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.more_vert,
                      size: bs.sm,
                      onPressed: () {
                        _showStaffOptions(employee);
                      },
                    ),
                  ],
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildAddStaffTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Personal Information
          Container(
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
                  "Personal Information",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "First Name",
                        value: firstName,
                        hint: "Enter first name",
                        onChanged: (value) {
                          firstName = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QTextField(
                        label: "Last Name",
                        value: lastName,
                        hint: "Enter last name",
                        onChanged: (value) {
                          lastName = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                QTextField(
                  label: "Email Address",
                  value: email,
                  hint: "Enter email address",
                  onChanged: (value) {
                    email = value;
                    setState(() {});
                  },
                ),

                QTextField(
                  label: "Phone Number",
                  value: phone,
                  hint: "Enter phone number",
                  onChanged: (value) {
                    phone = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Employment Information
          Container(
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
                  "Employment Information",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Employee ID",
                        value: employeeId,
                        hint: "Enter employee ID",
                        onChanged: (value) {
                          employeeId = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Department",
                        items: departmentFormOptions,
                        value: department,
                        onChanged: (value, label) {
                          department = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                QTextField(
                  label: "Position/Job Title",
                  value: position,
                  hint: "Enter position or job title",
                  onChanged: (value) {
                    position = value;
                    setState(() {});
                  },
                ),

                Row(
                  children: [
                    Expanded(
                      child: QDatePicker(
                        label: "Hire Date",
                        value: hireDate.isNotEmpty 
                            ? DateTime.parse(hireDate)
                            : DateTime.now(),
                        onChanged: (value) {
                          hireDate = value.toString().split(' ')[0];
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Status",
                        items: statusFormOptions,
                        value: status,
                        onChanged: (value, label) {
                          status = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Emergency Contact
          Container(
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
                  "Emergency Contact",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                QTextField(
                  label: "Emergency Contact Name",
                  value: emergencyContact,
                  hint: "Enter emergency contact name",
                  onChanged: (value) {
                    emergencyContact = value;
                    setState(() {});
                  },
                ),

                QTextField(
                  label: "Emergency Contact Phone",
                  value: emergencyPhone,
                  hint: "Enter emergency contact phone",
                  onChanged: (value) {
                    emergencyPhone = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Clear Form",
                  size: bs.sm,
                  onPressed: () {
                    _clearForm();
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Add Staff Member",
                  onPressed: firstName.isNotEmpty && 
                             lastName.isNotEmpty && 
                             email.isNotEmpty ? () {
                    _addStaff();
                  } : null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Department Breakdown
          Container(
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
                Text(
                  "Staff by Department",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                ...["front_desk", "housekeeping", "food_beverage", "maintenance", "management"].map((dept) {
                  final deptStaff = staff.where((s) => s["department"] == dept).toList();
                  final activeCount = deptStaff.where((s) => s["status"] == "active").length;
                  final avgRating = deptStaff.isNotEmpty 
                      ? deptStaff.fold(0.0, (sum, s) => sum + (s["performance_rating"] as double)) / deptStaff.length
                      : 0.0;
                  
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    margin: EdgeInsets.only(bottom: spXs),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${dept.replaceAll("_", " ").toUpperCase()}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "$activeCount active, ${deptStaff.length} total",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "${deptStaff.length}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: warningColor,
                                  size: 14,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${avgRating.toStringAsFixed(1)}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: warningColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),

          // Performance Overview
          Container(
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
                  "Performance Overview",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Highest Rated",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${staff.reduce((a, b) => (a["performance_rating"] as double) > (b["performance_rating"] as double) ? a : b)["performance_rating"]}",
                            style: TextStyle(
                              fontSize: fsH4,
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
                            "Avg Rating",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${averageRating.toStringAsFixed(1)}",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
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
                            "Total Trainings",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${staff.fold(0, (sum, s) => sum + (s["training_completed"] as int))}",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: infoColor,
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
                            "Avg Salary",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "\$${((staff.fold(0.0, (sum, s) => sum + (s["salary"] as double)) / staff.length) as double).currency}",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Recent Hires
          Container(
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
                Text(
                  "Recent Hires",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                ...staff.where((s) => DateTime.parse(s["hire_date"] as String).isAfter(DateTime.now().subtract(Duration(days: 90))))
                    .take(5).map((employee) => Container(
                  padding: EdgeInsets.all(spSm),
                  margin: EdgeInsets.only(bottom: spXs),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Center(
                          child: Text(
                            "${employee["first_name"]}".substring(0, 1),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${employee["first_name"]} ${employee["last_name"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${employee["position"]} • ${employee["department"]}".replaceAll("_", " "),
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "${employee["hire_date"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                )).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _viewStaffProfile(Map<String, dynamic> employee) {
    ss("Viewing profile for ${employee["first_name"]} ${employee["last_name"]}");
  }

  void _editStaff(Map<String, dynamic> employee) {
    // Pre-fill form with employee data
    firstName = employee["first_name"] as String;
    lastName = employee["last_name"] as String;
    email = employee["email"] as String;
    phone = employee["phone"] as String;
    department = employee["department"] as String;
    position = employee["position"] as String;
    employeeId = employee["employee_id"] as String;
    hireDate = employee["hire_date"] as String;
    emergencyContact = employee["emergency_contact"] as String;
    emergencyPhone = employee["emergency_phone"] as String;
    status = employee["status"] as String;
    
    setState(() {});
    
    // Switch to edit tab
    currentTab = 1;
    setState(() {});
    
    ss("Editing ${employee["first_name"]} ${employee["last_name"]}");
  }

  void _showStaffOptions(Map<String, dynamic> employee) {
    ss("Showing options for ${employee["first_name"]} ${employee["last_name"]}");
  }

  void _clearForm() {
    firstName = "";
    lastName = "";
    email = "";
    phone = "";
    department = "front_desk";
    position = "";
    employeeId = "";
    hireDate = "";
    emergencyContact = "";
    emergencyPhone = "";
    status = "active";
    setState(() {});
  }

  void _addStaff() async {
    showLoading();
    
    // Simulate adding staff
    await Future.delayed(Duration(seconds: 2));
    
    hideLoading();
    
    // Clear form
    _clearForm();
    
    // Switch to staff list tab
    currentTab = 0;
    setState(() {});
    
    ss("Staff member added successfully");
  }
}
