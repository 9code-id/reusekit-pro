import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmTechnicianListView extends StatefulWidget {
  const FsmTechnicianListView({super.key});

  @override
  State<FsmTechnicianListView> createState() => _FsmTechnicianListViewState();
}

class _FsmTechnicianListViewState extends State<FsmTechnicianListView> {
  bool loading = false;
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedDepartment = "All";
  String selectedAvailability = "All";
  String sortBy = "Name";

  List<Map<String, dynamic>> technicians = [
    {
      "id": "TECH-001",
      "name": "John Smith",
      "email": "john.smith@company.com",
      "phone": "+1-555-0101",
      "department": "IT Support",
      "status": "Active",
      "availability": "Available",
      "location": "New York, NY",
      "skills": ["Network Administration", "Windows Server", "Cisco Equipment"],
      "certifications": ["CompTIA Network+", "Microsoft MCSA", "Cisco CCNA"],
      "currentJobs": 3,
      "completedJobs": 142,
      "averageRating": 4.8,
      "profileImage": "https://picsum.photos/100/100?random=1",
      "lastActiveDate": "2024-06-19",
      "hourlyRate": 75.0,
      "experienceYears": 8,
      "joinDate": "2020-01-15",
      "supervisor": "Mike Johnson",
      "nextAvailableSlot": "Today 2:00 PM",
      "workingHours": "9:00 AM - 5:00 PM",
      "responseTime": "< 30 min",
      "specializationArea": "Network Infrastructure"
    },
    {
      "id": "TECH-002",
      "name": "Sarah Wilson",
      "email": "sarah.wilson@company.com",
      "phone": "+1-555-0102",
      "department": "Field Service",
      "status": "Active",
      "availability": "On Job",
      "location": "Chicago, IL",
      "skills": ["Equipment Maintenance", "Electrical Systems", "HVAC"],
      "certifications": ["OSHA Safety", "Electrical License", "HVAC Certification"],
      "currentJobs": 1,
      "completedJobs": 98,
      "averageRating": 4.9,
      "profileImage": "https://picsum.photos/100/100?random=2",
      "lastActiveDate": "2024-06-19",
      "hourlyRate": 68.0,
      "experienceYears": 6,
      "joinDate": "2021-03-20",
      "supervisor": "Lisa Chen",
      "nextAvailableSlot": "Tomorrow 10:00 AM",
      "workingHours": "8:00 AM - 4:00 PM",
      "responseTime": "< 45 min",
      "specializationArea": "HVAC Systems"
    },
    {
      "id": "TECH-003",
      "name": "Mike Davis",
      "email": "mike.davis@company.com",
      "phone": "+1-555-0103",
      "department": "Medical Equipment",
      "status": "Active",
      "availability": "Available",
      "location": "Boston, MA",
      "skills": ["Biomedical Equipment", "Calibration", "Compliance Testing"],
      "certifications": ["Biomedical Equipment Technician", "FDA Compliance"],
      "currentJobs": 2,
      "completedJobs": 189,
      "averageRating": 4.7,
      "profileImage": "https://picsum.photos/100/100?random=3",
      "lastActiveDate": "2024-06-18",
      "hourlyRate": 85.0,
      "experienceYears": 12,
      "joinDate": "2018-11-10",
      "supervisor": "Dr. James Wilson",
      "nextAvailableSlot": "Today 4:00 PM",
      "workingHours": "7:00 AM - 3:00 PM",
      "responseTime": "< 15 min",
      "specializationArea": "Medical Imaging Equipment"
    },
    {
      "id": "TECH-004",
      "name": "Emily Rodriguez",
      "email": "emily.rodriguez@company.com",
      "phone": "+1-555-0104",
      "department": "Field Service",
      "status": "On Leave",
      "availability": "Unavailable",
      "location": "Miami, FL",
      "skills": ["POS Systems", "Network Setup", "Retail Equipment"],
      "certifications": ["Retail Technology", "Point of Sale Systems"],
      "currentJobs": 0,
      "completedJobs": 76,
      "averageRating": 4.5,
      "profileImage": "https://picsum.photos/100/100?random=4",
      "lastActiveDate": "2024-06-10",
      "hourlyRate": 62.0,
      "experienceYears": 4,
      "joinDate": "2022-05-05",
      "supervisor": "Robert Lee",
      "nextAvailableSlot": "June 25th",
      "workingHours": "10:00 AM - 6:00 PM",
      "responseTime": "N/A",
      "specializationArea": "Retail Systems"
    },
    {
      "id": "TECH-005",
      "name": "Alex Johnson",
      "email": "alex.johnson@company.com",
      "phone": "+1-555-0105",
      "department": "IT Support",
      "status": "Active",
      "availability": "Busy",
      "location": "Houston, TX",
      "skills": ["System Monitoring", "Database Management", "Cloud Services"],
      "certifications": ["AWS Certified", "Microsoft Azure", "CompTIA Security+"],
      "currentJobs": 4,
      "completedJobs": 34,
      "averageRating": 4.6,
      "profileImage": "https://picsum.photos/100/100?random=5",
      "lastActiveDate": "2024-06-19",
      "hourlyRate": 72.0,
      "experienceYears": 3,
      "joinDate": "2023-01-08",
      "supervisor": "Susan Davis",
      "nextAvailableSlot": "Tomorrow 2:00 PM",
      "workingHours": "9:00 AM - 5:00 PM",
      "responseTime": "< 60 min",
      "specializationArea": "Cloud Infrastructure"
    },
    {
      "id": "TECH-006",
      "name": "Jessica Taylor",
      "email": "jessica.taylor@company.com",
      "phone": "+1-555-0106",
      "department": "Medical Equipment",
      "status": "Active",
      "availability": "Available",
      "location": "Seattle, WA",
      "skills": ["Laboratory Equipment", "Quality Control", "Safety Protocols"],
      "certifications": ["Clinical Laboratory", "ISO 15189", "Quality Management"],
      "currentJobs": 1,
      "completedJobs": 156,
      "averageRating": 4.8,
      "profileImage": "https://picsum.photos/100/100?random=6",
      "lastActiveDate": "2024-06-19",
      "hourlyRate": 78.0,
      "experienceYears": 9,
      "joinDate": "2019-08-15",
      "supervisor": "Dr. Maria Santos",
      "nextAvailableSlot": "Today 1:00 PM",
      "workingHours": "6:00 AM - 2:00 PM",
      "responseTime": "< 20 min",
      "specializationArea": "Laboratory Systems"
    },
    {
      "id": "TECH-007",
      "name": "David Brown",
      "email": "david.brown@company.com",
      "phone": "+1-555-0107",
      "department": "Field Service",
      "status": "Active",
      "availability": "Available",
      "location": "Phoenix, AZ",
      "skills": ["Solar Systems", "Electrical Installation", "Energy Systems"],
      "certifications": ["Solar Installation", "Electrical License", "Energy Efficiency"],
      "currentJobs": 2,
      "completedJobs": 203,
      "averageRating": 4.9,
      "profileImage": "https://picsum.photos/100/100?random=7",
      "lastActiveDate": "2024-06-18",
      "hourlyRate": 80.0,
      "experienceYears": 11,
      "joinDate": "2017-04-10",
      "supervisor": "Karen Miller",
      "nextAvailableSlot": "Today 3:00 PM",
      "workingHours": "7:00 AM - 3:00 PM",
      "responseTime": "< 25 min",
      "specializationArea": "Renewable Energy"
    },
    {
      "id": "TECH-008",
      "name": "Lisa Chang",
      "email": "lisa.chang@company.com",
      "phone": "+1-555-0108",
      "department": "IT Support",
      "status": "Training",
      "availability": "Limited",
      "location": "San Francisco, CA",
      "skills": ["Cybersecurity", "Network Security", "Incident Response"],
      "certifications": ["CISSP", "CEH", "Security+"],
      "currentJobs": 1,
      "completedJobs": 67,
      "averageRating": 4.7,
      "profileImage": "https://picsum.photos/100/100?random=8",
      "lastActiveDate": "2024-06-17",
      "hourlyRate": 88.0,
      "experienceYears": 5,
      "joinDate": "2021-11-12",
      "supervisor": "Tom Wilson",
      "nextAvailableSlot": "June 22nd",
      "workingHours": "10:00 AM - 6:00 PM",
      "responseTime": "< 40 min",
      "specializationArea": "Cybersecurity"
    }
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "On Leave", "value": "On Leave"},
    {"label": "Training", "value": "Training"},
    {"label": "Inactive", "value": "Inactive"}
  ];

  List<Map<String, dynamic>> departmentOptions = [
    {"label": "All", "value": "All"},
    {"label": "IT Support", "value": "IT Support"},
    {"label": "Field Service", "value": "Field Service"},
    {"label": "Medical Equipment", "value": "Medical Equipment"}
  ];

  List<Map<String, dynamic>> availabilityOptions = [
    {"label": "All", "value": "All"},
    {"label": "Available", "value": "Available"},
    {"label": "On Job", "value": "On Job"},
    {"label": "Busy", "value": "Busy"},
    {"label": "Unavailable", "value": "Unavailable"},
    {"label": "Limited", "value": "Limited"}
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Name", "value": "Name"},
    {"label": "Rating", "value": "Rating"},
    {"label": "Experience", "value": "Experience"},
    {"label": "Hourly Rate", "value": "Hourly Rate"},
    {"label": "Completed Jobs", "value": "Completed Jobs"}
  ];

  List<Map<String, dynamic>> get filteredAndSortedTechnicians {
    var filtered = technicians.where((tech) {
      bool matchesSearch = tech["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          tech["id"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          tech["department"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          tech["specializationArea"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "All" || tech["status"] == selectedStatus;
      bool matchesDepartment = selectedDepartment == "All" || tech["department"] == selectedDepartment;
      bool matchesAvailability = selectedAvailability == "All" || tech["availability"] == selectedAvailability;
      
      return matchesSearch && matchesStatus && matchesDepartment && matchesAvailability;
    }).toList();

    // Sort based on selected criteria
    filtered.sort((a, b) {
      switch (sortBy) {
        case "Rating":
          return (b["averageRating"] as double).compareTo(a["averageRating"] as double);
        case "Experience":
          return (b["experienceYears"] as int).compareTo(a["experienceYears"] as int);
        case "Hourly Rate":
          return (b["hourlyRate"] as double).compareTo(a["hourlyRate"] as double);
        case "Completed Jobs":
          return (b["completedJobs"] as int).compareTo(a["completedJobs"] as int);
        default:
          return a["name"].toString().compareTo(b["name"].toString());
      }
    });

    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "On Leave":
        return warningColor;
      case "Training":
        return infoColor;
      case "Inactive":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getAvailabilityColor(String availability) {
    switch (availability) {
      case "Available":
        return successColor;
      case "On Job":
        return infoColor;
      case "Busy":
        return warningColor;
      case "Limited":
        return warningColor;
      case "Unavailable":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _viewTechnicianDetails(Map<String, dynamic> technician) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Technician Details"),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(technician["profileImage"]),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${technician["name"]}",
                            style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold),
                          ),
                          Text("${technician["id"]} • ${technician["department"]}"),
                          Text("${technician["specializationArea"]}"),
                        ],
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                Text("Contact Information", style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold)),
                Text("Email: ${technician["email"]}"),
                Text("Phone: ${technician["phone"]}"),
                Text("Location: ${technician["location"]}"),
                
                SizedBox(height: spSm),
                Text("Work Information", style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold)),
                Text("Supervisor: ${technician["supervisor"]}"),
                Text("Working Hours: ${technician["workingHours"]}"),
                Text("Join Date: ${technician["joinDate"]}"),
                Text("Experience: ${technician["experienceYears"]} years"),
                Text("Hourly Rate: \$${(technician["hourlyRate"] as double).toStringAsFixed(2)}"),
                
                SizedBox(height: spSm),
                Text("Performance Metrics", style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold)),
                Text("Average Rating: ${technician["averageRating"]}/5.0"),
                Text("Completed Jobs: ${technician["completedJobs"]}"),
                Text("Current Jobs: ${technician["currentJobs"]}"),
                Text("Response Time: ${technician["responseTime"]}"),
                
                SizedBox(height: spSm),
                Text("Availability", style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold)),
                Text("Status: ${technician["availability"]}"),
                Text("Next Available: ${technician["nextAvailableSlot"]}"),
                Text("Last Active: ${technician["lastActiveDate"]}"),
                
                SizedBox(height: spSm),
                Text("Skills", style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold)),
                ...(technician["skills"] as List).map((skill) => Text("• $skill")),
                
                SizedBox(height: spSm),
                Text("Certifications", style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold)),
                ...(technician["certifications"] as List).map((cert) => Text("• $cert")),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }

  void _assignJob(Map<String, dynamic> technician) {
    if (technician["availability"] == "Unavailable") {
      se("Technician is currently unavailable");
      return;
    }
    ss("Job assignment functionality for ${technician["name"]}");
  }

  void _contactTechnician(Map<String, dynamic> technician) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Contact ${technician["name"]}"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            QButton(
              label: "Call ${technician["phone"]}",
              icon: Icons.phone,
              size: bs.sm,
              onPressed: () {
                back();
                ss("Calling ${technician["name"]}");
              },
            ),
            QButton(
              label: "Email ${technician["email"]}",
              icon: Icons.email,
              size: bs.sm,
              onPressed: () {
                back();
                ss("Opening email to ${technician["name"]}");
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Technician List"),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Technician List"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              ss("Add new technician");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Summary Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildSummaryCard("Total Technicians", "${technicians.length}", primaryColor, Icons.people),
                _buildSummaryCard("Available", "${technicians.where((t) => t["availability"] == "Available").length}", successColor, Icons.check_circle),
                _buildSummaryCard("On Job", "${technicians.where((t) => t["availability"] == "On Job").length}", infoColor, Icons.work),
                _buildSummaryCard("Avg Rating", "${(technicians.fold(0.0, (sum, t) => sum + (t["averageRating"] as double)) / technicians.length).toStringAsFixed(1)}", warningColor, Icons.star),
              ],
            ),

            // Search and Filters
            QTextField(
              label: "Search technicians",
              value: searchQuery,
              hint: "Search by name, ID, department, or specialization",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
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
                    label: "Department",
                    items: departmentOptions,
                    value: selectedDepartment,
                    onChanged: (value, label) {
                      selectedDepartment = value;
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
                    label: "Availability",
                    items: availabilityOptions,
                    value: selectedAvailability,
                    onChanged: (value, label) {
                      selectedAvailability = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Sort By",
                    items: sortOptions,
                    value: sortBy,
                    onChanged: (value, label) {
                      sortBy = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Technicians List
            Text(
              "Technicians (${filteredAndSortedTechnicians.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            ...filteredAndSortedTechnicians.map((technician) => Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(technician["profileImage"]),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${technician["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${technician["department"]} • ${technician["id"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "${technician["specializationArea"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getStatusColor(technician["status"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${technician["status"]}",
                              style: TextStyle(
                                color: _getStatusColor(technician["status"]),
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(height: 4),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getAvailabilityColor(technician["availability"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${technician["availability"]}",
                              style: TextStyle(
                                color: _getAvailabilityColor(technician["availability"]),
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
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
                              "Rating",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(Icons.star, color: warningColor, size: 16),
                                SizedBox(width: 4),
                                Text(
                                  "${technician["averageRating"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Experience",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${technician["experienceYears"]} years",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
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
                              "Rate",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "\$${(technician["hourlyRate"] as double).toStringAsFixed(0)}/hr",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                      SizedBox(width: 4),
                      Text(
                        "${technician["location"]}",
                        style: TextStyle(fontSize: 12, color: disabledBoldColor),
                      ),
                      Spacer(),
                      Icon(Icons.assignment, size: 16, color: disabledBoldColor),
                      SizedBox(width: 4),
                      Text(
                        "${technician["currentJobs"]} active jobs",
                        style: TextStyle(fontSize: 12, color: disabledBoldColor),
                      ),
                    ],
                  ),

                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                        SizedBox(width: 4),
                        Text(
                          "Next available: ${technician["nextAvailableSlot"]}",
                          style: TextStyle(fontSize: 12, color: disabledBoldColor),
                        ),
                      ],
                    ),
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "View Details",
                          size: bs.sm,
                          onPressed: () => _viewTechnicianDetails(technician),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Assign Job",
                          size: bs.sm,
                          onPressed: () => _assignJob(technician),
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.contact_phone,
                        size: bs.sm,
                        onPressed: () => _contactTechnician(technician),
                      ),
                    ],
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              Spacer(),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
