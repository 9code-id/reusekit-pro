import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmCustomerHistoryView extends StatefulWidget {
  const FsmCustomerHistoryView({super.key});

  @override
  State<FsmCustomerHistoryView> createState() => _FsmCustomerHistoryViewState();
}

class _FsmCustomerHistoryViewState extends State<FsmCustomerHistoryView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedServiceType = "all";
  String selectedTimeRange = "all";
  String selectedTechnician = "all";
  
  List<Map<String, dynamic>> serviceTypeOptions = [
    {"label": "All Service Types", "value": "all"},
    {"label": "Preventive Maintenance", "value": "preventive"},
    {"label": "Emergency Repair", "value": "emergency"},
    {"label": "Installation", "value": "installation"},
    {"label": "Inspection", "value": "inspection"},
    {"label": "Upgrade", "value": "upgrade"},
  ];
  
  List<Map<String, dynamic>> timeRangeOptions = [
    {"label": "All Time", "value": "all"},
    {"label": "Last 30 Days", "value": "30_days"},
    {"label": "Last 3 Months", "value": "3_months"},
    {"label": "Last 6 Months", "value": "6_months"},
    {"label": "Last Year", "value": "1_year"},
  ];
  
  List<Map<String, dynamic>> technicianOptions = [
    {"label": "All Technicians", "value": "all"},
    {"label": "John Smith", "value": "john_smith"},
    {"label": "Sarah Johnson", "value": "sarah_johnson"},
    {"label": "Mike Wilson", "value": "mike_wilson"},
    {"label": "Lisa Park", "value": "lisa_park"},
  ];
  
  Map<String, dynamic> customer = {
    "id": "CUST001",
    "name": "TechCorp Industries",
    "account_since": "2022-03-15",
    "total_services": 24,
    "total_spent": 45750.0,
  };
  
  List<Map<String, dynamic>> serviceHistory = [
    {
      "id": "SH001",
      "date": "2024-01-15",
      "time": "09:00 AM",
      "type": "preventive",
      "title": "HVAC System Quarterly Maintenance",
      "equipment": "Central HVAC Unit A",
      "location": "Main Office - Building A",
      "technician": "John Smith",
      "duration": 2.5,
      "status": "completed",
      "cost": 850.0,
      "description": "Quarterly maintenance including filter replacement, coil cleaning, and system inspection",
      "rating": 5,
      "feedback": "Excellent work! Very thorough and professional service.",
      "parts_used": ["Air Filter MERV-13", "Refrigerant R-410A", "Coil Cleaner"],
      "issues_found": ["Minor refrigerant leak", "Dirty evaporator coil"],
      "actions_taken": ["Sealed refrigerant leak", "Cleaned evaporator coil", "Replaced filters"],
      "recommendations": ["Consider upgrading to smart thermostat", "Schedule duct cleaning"],
    },
    {
      "id": "SH002",
      "date": "2024-01-10",
      "time": "2:30 PM",
      "type": "emergency",
      "title": "Emergency Generator Repair",
      "equipment": "Emergency Generator CAT-001",
      "location": "Main Office - Basement",
      "technician": "Sarah Johnson",
      "duration": 4.0,
      "status": "completed",
      "cost": 1250.0,
      "description": "Emergency repair of backup generator that failed to start during weekly test",
      "rating": 5,
      "feedback": "Quick response time. Problem resolved efficiently.",
      "parts_used": ["Starter Motor", "Battery 12V", "Oil Filter"],
      "issues_found": ["Faulty starter motor", "Weak battery", "Overdue oil change"],
      "actions_taken": ["Replaced starter motor", "Installed new battery", "Changed oil and filter"],
      "recommendations": ["Implement monthly battery testing", "Consider battery monitoring system"],
    },
    {
      "id": "SH003",
      "date": "2024-01-05",
      "time": "11:00 AM",
      "type": "installation",
      "title": "New Security Camera Installation",
      "equipment": "Security Camera System",
      "location": "R&D Center - Perimeter",
      "technician": "Mike Wilson",
      "duration": 6.0,
      "status": "completed",
      "cost": 2800.0,
      "description": "Installation of 8 new IP security cameras with night vision capability",
      "rating": 4,
      "feedback": "Good installation but took longer than expected.",
      "parts_used": ["IP Camera x8", "Network Cable", "PoE Switch"],
      "issues_found": ["Existing network infrastructure limitations"],
      "actions_taken": ["Installed new network switch", "Upgraded network cabling", "Configured camera system"],
      "recommendations": ["Consider upgrading main network infrastructure", "Add motion detection zones"],
    },
    {
      "id": "SH004",
      "date": "2023-12-28",
      "time": "8:00 AM",
      "type": "inspection",
      "title": "Annual Fire Safety Inspection",
      "equipment": "Fire Safety System",
      "location": "All Buildings",
      "technician": "Lisa Park",
      "duration": 3.5,
      "status": "completed",
      "cost": 650.0,
      "description": "Annual inspection of fire suppression systems, alarms, and emergency exits",
      "rating": 5,
      "feedback": "Very detailed inspection with comprehensive report.",
      "parts_used": ["Smoke Detector Battery x12"],
      "issues_found": ["Low battery in smoke detectors", "Blocked emergency exit"],
      "actions_taken": ["Replaced smoke detector batteries", "Cleared emergency exit", "Updated emergency signage"],
      "recommendations": ["Schedule quarterly battery checks", "Conduct fire drill training"],
    },
    {
      "id": "SH005",
      "date": "2023-12-15",
      "time": "1:00 PM",
      "type": "preventive",
      "title": "Elevator Monthly Inspection",
      "equipment": "Passenger Elevator #1",
      "location": "Main Office - Elevator Shaft",
      "technician": "John Smith",
      "duration": 1.5,
      "status": "completed",
      "cost": 450.0,
      "description": "Monthly safety inspection and maintenance of passenger elevator",
      "rating": 5,
      "feedback": "Always reliable and professional service.",
      "parts_used": ["Elevator Oil", "Safety Circuit Components"],
      "issues_found": ["Slightly worn door rollers"],
      "actions_taken": ["Lubricated all moving parts", "Adjusted door alignment", "Tested safety systems"],
      "recommendations": ["Plan door roller replacement in 3 months"],
    },
  ];
  
  List<Map<String, dynamic>> invoices = [
    {
      "id": "INV-2024-001",
      "date": "2024-01-15",
      "service_id": "SH001",
      "amount": 850.0,
      "status": "paid",
      "paid_date": "2024-01-20",
      "payment_method": "Bank Transfer",
      "due_date": "2024-02-15",
    },
    {
      "id": "INV-2024-002",
      "date": "2024-01-10",
      "service_id": "SH002",
      "amount": 1250.0,
      "status": "paid",
      "paid_date": "2024-01-15",
      "payment_method": "Credit Card",
      "due_date": "2024-02-10",
    },
    {
      "id": "INV-2024-003",
      "date": "2024-01-05",
      "service_id": "SH003",
      "amount": 2800.0,
      "status": "pending",
      "paid_date": "",
      "payment_method": "",
      "due_date": "2024-02-05",
    },
  ];

  List<Map<String, dynamic>> get filteredServiceHistory {
    return serviceHistory.where((service) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${service["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${service["equipment"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${service["technician"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesServiceType = selectedServiceType == "all" || service["type"] == selectedServiceType;
      bool matchesTechnician = selectedTechnician == "all" || "${service["technician"]}".toLowerCase().replaceAll(" ", "_") == selectedTechnician;
      
      return matchesSearch && matchesServiceType && matchesTechnician;
    }).toList();
  }

  Color _getServiceTypeColor(String type) {
    switch (type) {
      case "preventive":
        return successColor;
      case "emergency":
        return dangerColor;
      case "installation":
        return primaryColor;
      case "inspection":
        return infoColor;
      case "upgrade":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "in_progress":
        return warningColor;
      case "cancelled":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildStarRating(int rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          size: 16,
          color: index < rating ? warningColor : disabledBoldColor,
        );
      }),
    );
  }

  Widget _buildServiceCard(Map<String, dynamic> service) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: _getServiceTypeColor("${service["type"]}"),
          ),
        ),
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
                        Text(
                          "${service["id"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getServiceTypeColor("${service["type"]}").withAlpha(50),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            "${service["type"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: _getServiceTypeColor("${service["type"]}"),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${service["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildStarRating((service["rating"] as num).toInt()),
                  SizedBox(height: spXs),
                  Text(
                    "\$${((service["cost"] as num).toDouble()).currency}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${service["date"]} at ${service["time"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "${(service["duration"] as num).toStringAsFixed(1)}h",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Icon(
                Icons.build,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${service["equipment"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Icon(
                Icons.person,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${service["technician"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              "${service["description"]}",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ),
          if ("${service["feedback"]}".isNotEmpty) ...[
            SizedBox(height: spSm),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: Colors.green[100]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Customer Feedback:",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[800],
                    ),
                  ),
                  Text(
                    "${service["feedback"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.green[800],
                    ),
                  ),
                ],
              ),
            ),
          ],
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {
                    // Navigate to service detail
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Invoice",
                  size: bs.sm,
                  onPressed: () {
                    // Navigate to invoice
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
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
                  "${customer["name"]}",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Service History Overview",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spMd),
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 200,
                  children: [
                    _buildStatCard("Total Services", "${customer["total_services"]}", Icons.build, primaryColor),
                    _buildStatCard("Account Since", "${customer["account_since"]}", Icons.calendar_today, infoColor),
                    _buildStatCard("Total Spent", "\$${((customer["total_spent"] as num).toDouble()).currency}", Icons.attach_money, successColor),
                    _buildStatCard("Avg Rating", "${(serviceHistory.fold(0.0, (sum, s) => sum + (s["rating"] as num)) / serviceHistory.length).toStringAsFixed(1)}", Icons.star, warningColor),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),
          Text(
            "Recent Services",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...filteredServiceHistory.take(3).map((service) => _buildServiceCard(service)),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 20,
              ),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceHistoryTab() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Search services...",
                      value: searchQuery,
                      onChanged: (value) {
                        searchQuery = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Service Type",
                      items: serviceTypeOptions,
                      value: selectedServiceType,
                      onChanged: (value, label) {
                        selectedServiceType = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Technician",
                      items: technicianOptions,
                      value: selectedTechnician,
                      onChanged: (value, label) {
                        selectedTechnician = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            itemCount: filteredServiceHistory.length,
            itemBuilder: (context, index) {
              return _buildServiceCard(filteredServiceHistory[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildInvoicesTab() {
    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: invoices.length,
      itemBuilder: (context, index) {
        final invoice = invoices[index];
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
                        Text(
                          "${invoice["id"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Service: ${invoice["service_id"]}",
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
                        "\$${((invoice["amount"] as num).toDouble()).currency}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                        decoration: BoxDecoration(
                          color: "${invoice["status"]}" == "paid" ? successColor.withAlpha(50) : warningColor.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Text(
                          "${invoice["status"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: "${invoice["status"]}" == "paid" ? successColor : warningColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 16, color: disabledBoldColor),
                  SizedBox(width: spXs),
                  Text(
                    "Date: ${invoice["date"]}",
                    style: TextStyle(fontSize: 12, color: disabledBoldColor),
                  ),
                  Spacer(),
                  Text(
                    "Due: ${invoice["due_date"]}",
                    style: TextStyle(fontSize: 12, color: disabledBoldColor),
                  ),
                ],
              ),
              if ("${invoice["paid_date"]}".isNotEmpty) ...[
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(Icons.payment, size: 16, color: successColor),
                    SizedBox(width: spXs),
                    Text(
                      "Paid: ${invoice["paid_date"]} via ${invoice["payment_method"]}",
                      style: TextStyle(fontSize: 12, color: successColor),
                    ),
                  ],
                ),
              ],
              SizedBox(height: spSm),
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "View Invoice",
                      size: bs.sm,
                      onPressed: () {
                        // View invoice detail
                      },
                    ),
                  ),
                  if ("${invoice["status"]}" == "pending") ...[
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Mark Paid",
                        size: bs.sm,
                        onPressed: () {
                          // Mark as paid
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Customer History",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Services", icon: Icon(Icons.build)),
        Tab(text: "Invoices", icon: Icon(Icons.receipt)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildServiceHistoryTab(),
        _buildInvoicesTab(),
      ],
      onInit: (tabController) {},
    );
  }
}
