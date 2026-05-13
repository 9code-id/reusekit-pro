import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmCustomerPreferencesView extends StatefulWidget {
  const FsmCustomerPreferencesView({super.key});

  @override
  State<FsmCustomerPreferencesView> createState() => _FsmCustomerPreferencesViewState();
}

class _FsmCustomerPreferencesViewState extends State<FsmCustomerPreferencesView> {
  bool loading = false;
  String searchQuery = "";
  String selectedCustomer = "";

  List<Map<String, dynamic>> customers = [
    {
      "id": "CUST-001",
      "name": "TechCorp Industries",
      "industry": "Technology",
      "preferences": {
        "preferredTechnicians": ["John Smith", "Sarah Wilson"],
        "communicationMethod": "Email + SMS",
        "serviceWindow": "Business Hours (9AM-5PM)",
        "emergencyContact": "+1-555-0123",
        "specialInstructions": "Require advance notice for all visits. Security clearance needed for server room access.",
        "equipmentAccessNotes": "Main entrance only. Badge required at reception.",
        "escalationContacts": ["Mike Johnson - CTO", "Lisa Chen - IT Manager"],
        "billingPreferences": "Monthly invoicing",
        "reportingRequirements": "Detailed technical reports required",
        "responseTimeExpectation": "4 hours maximum",
        "followUpRequired": true,
        "documentationLevel": "Detailed"
      },
      "contactInfo": {
        "primaryContact": "David Thompson",
        "email": "david.thompson@techcorp.com",
        "phone": "+1-555-0123",
        "alternateContact": "Jennifer Miller",
        "alternateEmail": "jennifer.miller@techcorp.com",
        "alternatePhone": "+1-555-0124"
      },
      "serviceHistory": {
        "totalServices": 156,
        "lastServiceDate": "2024-06-15",
        "averageRating": 4.8,
        "commonIssues": ["Software updates", "Network configuration", "Hardware replacement"]
      }
    },
    {
      "id": "CUST-002",
      "name": "Global Manufacturing Co",
      "industry": "Manufacturing",
      "preferences": {
        "preferredTechnicians": ["Mike Davis", "Emily Rodriguez"],
        "communicationMethod": "Phone + Portal",
        "serviceWindow": "24/7 for emergencies, Business hours for routine",
        "emergencyContact": "+1-555-0234",
        "specialInstructions": "Safety protocols mandatory. Hard hat and safety shoes required. No work during shift changes (7AM, 3PM, 11PM).",
        "equipmentAccessNotes": "Factory floor access requires safety training certification. Escort needed for production areas.",
        "escalationContacts": ["Robert Lee - Plant Manager", "Anna Garcia - Maintenance Supervisor"],
        "billingPreferences": "Weekly invoicing",
        "reportingRequirements": "Safety compliance reports mandatory",
        "responseTimeExpectation": "2 hours for production equipment",
        "followUpRequired": true,
        "documentationLevel": "Standard"
      },
      "contactInfo": {
        "primaryContact": "Robert Lee",
        "email": "robert.lee@globalmanufacturing.com",
        "phone": "+1-555-0234",
        "alternateContact": "Anna Garcia",
        "alternateEmail": "anna.garcia@globalmanufacturing.com",
        "alternatePhone": "+1-555-0235"
      },
      "serviceHistory": {
        "totalServices": 89,
        "lastServiceDate": "2024-06-18",
        "averageRating": 4.6,
        "commonIssues": ["Equipment calibration", "Preventive maintenance", "Emergency repairs"]
      }
    },
    {
      "id": "CUST-003",
      "name": "Healthcare Systems Inc",
      "industry": "Healthcare",
      "preferences": {
        "preferredTechnicians": ["Dr. James Wilson", "Maria Santos"],
        "communicationMethod": "Secure Portal Only",
        "serviceWindow": "24/7 for critical equipment, scheduled for routine",
        "emergencyContact": "+1-555-0345",
        "specialInstructions": "HIPAA compliance required. All personnel must sign confidentiality agreements. Sterile environment protocols must be followed.",
        "equipmentAccessNotes": "Clean room protocols for sensitive equipment. Hand sanitization mandatory. Visitor badges required.",
        "escalationContacts": ["Dr. Patricia Miller - Chief Medical Officer", "Tom Brown - Biomedical Engineer"],
        "billingPreferences": "Department-wise billing",
        "reportingRequirements": "FDA compliance documentation",
        "responseTimeExpectation": "1 hour for life-critical equipment",
        "followUpRequired": true,
        "documentationLevel": "Comprehensive"
      },
      "contactInfo": {
        "primaryContact": "Dr. Patricia Miller",
        "email": "patricia.miller@healthcaresystems.com",
        "phone": "+1-555-0345",
        "alternateContact": "Tom Brown",
        "alternateEmail": "tom.brown@healthcaresystems.com",
        "alternatePhone": "+1-555-0346"
      },
      "serviceHistory": {
        "totalServices": 234,
        "lastServiceDate": "2024-06-19",
        "averageRating": 4.9,
        "commonIssues": ["Equipment calibration", "Compliance testing", "Emergency support"]
      }
    },
    {
      "id": "CUST-004",
      "name": "Retail Chain Solutions",
      "industry": "Retail",
      "preferences": {
        "preferredTechnicians": ["Alex Johnson", "Sophie Chen"],
        "communicationMethod": "Email + App Notifications",
        "serviceWindow": "After hours preferred (10PM-6AM)",
        "emergencyContact": "+1-555-0456",
        "specialInstructions": "Minimal disruption to customer operations. Work during store closure preferred. Point-of-sale systems are critical during business hours.",
        "equipmentAccessNotes": "Store manager must be present. Back office access only during business hours.",
        "escalationContacts": ["Karen White - Regional Manager", "Steve Johnson - IT Director"],
        "billingPreferences": "Consolidated monthly billing",
        "reportingRequirements": "Service impact reports",
        "responseTimeExpectation": "6 hours during business hours",
        "followUpRequired": false,
        "documentationLevel": "Minimal"
      },
      "contactInfo": {
        "primaryContact": "Karen White",
        "email": "karen.white@retailchain.com",
        "phone": "+1-555-0456",
        "alternateContact": "Steve Johnson",
        "alternateEmail": "steve.johnson@retailchain.com",
        "alternatePhone": "+1-555-0457"
      },
      "serviceHistory": {
        "totalServices": 67,
        "lastServiceDate": "2024-06-14",
        "averageRating": 4.4,
        "commonIssues": ["POS system updates", "Network connectivity", "Hardware replacement"]
      }
    },
    {
      "id": "CUST-005",
      "name": "Energy Solutions Ltd",
      "industry": "Energy",
      "preferences": {
        "preferredTechnicians": ["Mark Thompson", "Rachel Green", "Chris Miller"],
        "communicationMethod": "Secure Email + Radio",
        "serviceWindow": "24/7 availability required",
        "emergencyContact": "+1-555-0567",
        "specialInstructions": "High security clearance required. Safety protocols critical - no solo work. Hot work permits needed for electrical work. Environmental protection protocols mandatory.",
        "equipmentAccessNotes": "Restricted access zones require security escort. Personal protective equipment mandatory. Gas detection equipment required.",
        "escalationContacts": ["Susan Davis - Operations Manager", "Paul Wilson - Safety Officer"],
        "billingPreferences": "Project-based billing",
        "reportingRequirements": "Environmental and safety compliance reports",
        "responseTimeExpectation": "30 minutes for critical infrastructure",
        "followUpRequired": true,
        "documentationLevel": "Comprehensive"
      },
      "contactInfo": {
        "primaryContact": "Susan Davis",
        "email": "susan.davis@energysolutions.com",
        "phone": "+1-555-0567",
        "alternateContact": "Paul Wilson",
        "alternateEmail": "paul.wilson@energysolutions.com",
        "alternatePhone": "+1-555-0568"
      },
      "serviceHistory": {
        "totalServices": 298,
        "lastServiceDate": "2024-06-18",
        "averageRating": 4.7,
        "commonIssues": ["System monitoring", "Preventive maintenance", "Emergency response"]
      }
    }
  ];

  List<Map<String, dynamic>> customerItems = [];

  @override
  void initState() {
    super.initState();
    customerItems = [
      {"label": "All Customers", "value": ""},
      ...customers.map((c) => {"label": c["name"], "value": c["id"]})
    ];
  }

  List<Map<String, dynamic>> get filteredCustomers {
    return customers.where((customer) {
      bool matchesSearch = customer["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          customer["id"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          customer["industry"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesSelection = selectedCustomer.isEmpty || customer["id"] == selectedCustomer;
      
      return matchesSearch && matchesSelection;
    }).toList();
  }

  void _editPreferences(Map<String, dynamic> customer) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Customer Preferences"),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text("Customer: ${customer["name"]}", style: TextStyle(fontWeight: FontWeight.bold)),
                
                Text("Communication Preferences", style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold)),
                Text("Method: ${customer["preferences"]["communicationMethod"]}"),
                Text("Emergency Contact: ${customer["preferences"]["emergencyContact"]}"),
                
                SizedBox(height: spSm),
                Text("Service Preferences", style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold)),
                Text("Service Window: ${customer["preferences"]["serviceWindow"]}"),
                Text("Response Time: ${customer["preferences"]["responseTimeExpectation"]}"),
                Text("Documentation Level: ${customer["preferences"]["documentationLevel"]}"),
                
                SizedBox(height: spSm),
                Text("Special Instructions", style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold)),
                Text("${customer["preferences"]["specialInstructions"]}"),
                
                SizedBox(height: spSm),
                Text("Access Notes", style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold)),
                Text("${customer["preferences"]["equipmentAccessNotes"]}"),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Close"),
          ),
          QButton(
            label: "Edit",
            size: bs.sm,
            onPressed: () {
              back();
              ss("Preferences updated successfully");
            },
          ),
        ],
      ),
    );
  }

  void _viewCustomerDetails(Map<String, dynamic> customer) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Customer Details"),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text("${customer["name"]}", style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold)),
                Text("Industry: ${customer["industry"]}"),
                Text("Customer ID: ${customer["id"]}"),
                
                SizedBox(height: spSm),
                Text("Contact Information", style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold)),
                Text("Primary: ${customer["contactInfo"]["primaryContact"]}"),
                Text("Email: ${customer["contactInfo"]["email"]}"),
                Text("Phone: ${customer["contactInfo"]["phone"]}"),
                
                SizedBox(height: spSm),
                Text("Service History", style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold)),
                Text("Total Services: ${customer["serviceHistory"]["totalServices"]}"),
                Text("Last Service: ${customer["serviceHistory"]["lastServiceDate"]}"),
                Text("Average Rating: ${customer["serviceHistory"]["averageRating"]}/5.0"),
                
                SizedBox(height: spSm),
                Text("Preferred Technicians", style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold)),
                ...(customer["preferences"]["preferredTechnicians"] as List).map((tech) => 
                  Text("• $tech")),
                
                SizedBox(height: spSm),
                Text("Escalation Contacts", style: TextStyle(fontSize: fsH6, fontWeight: FontWeight.bold)),
                ...(customer["preferences"]["escalationContacts"] as List).map((contact) => 
                  Text("• $contact")),
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

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Customer Preferences"),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Preferences"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // Open advanced filters
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
                _buildSummaryCard("Total Customers", "${customers.length}", primaryColor, Icons.business),
                _buildSummaryCard("High Priority", "${customers.where((c) => c["preferences"]["responseTimeExpectation"].contains("hour") && int.parse(c["preferences"]["responseTimeExpectation"].split(" ")[0]) <= 2).length}", dangerColor, Icons.priority_high),
                _buildSummaryCard("24/7 Service", "${customers.where((c) => c["preferences"]["serviceWindow"].contains("24/7")).length}", warningColor, Icons.access_time),
                _buildSummaryCard("Avg Rating", "${(customers.fold(0.0, (sum, c) => sum + (c["serviceHistory"]["averageRating"] as num)) / customers.length).toStringAsFixed(1)}", successColor, Icons.star),
              ],
            ),

            // Search and Filters
            QTextField(
              label: "Search customers",
              value: searchQuery,
              hint: "Search by name, ID, or industry",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

            QDropdownField(
              label: "Select Customer",
              items: customerItems,
              value: selectedCustomer,
              onChanged: (value, label) {
                selectedCustomer = value;
                setState(() {});
              },
            ),

            // Customers List
            Text(
              "Customer Preferences (${filteredCustomers.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            ...filteredCustomers.map((customer) => Container(
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
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${customer["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${customer["industry"]} • ${customer["id"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getRatingColor(customer["serviceHistory"]["averageRating"] as num).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${customer["serviceHistory"]["averageRating"]}/5.0",
                          style: TextStyle(
                            color: _getRatingColor(customer["serviceHistory"]["averageRating"] as num),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
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
                              "Communication",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${customer["preferences"]["communicationMethod"]}",
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
                              "Service Window",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${customer["preferences"]["serviceWindow"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                      SizedBox(width: 4),
                      Text(
                        "Response: ${customer["preferences"]["responseTimeExpectation"]}",
                        style: TextStyle(fontSize: 12, color: disabledBoldColor),
                      ),
                      Spacer(),
                      Icon(Icons.assignment, size: 16, color: disabledBoldColor),
                      SizedBox(width: 4),
                      Text(
                        "${customer["serviceHistory"]["totalServices"]} services",
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Special Instructions:",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${customer["preferences"]["specialInstructions"]}",
                          style: TextStyle(fontSize: 12),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
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
                          onPressed: () => _viewCustomerDetails(customer),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Edit Preferences",
                          size: bs.sm,
                          onPressed: () => _editPreferences(customer),
                        ),
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

  Color _getRatingColor(num rating) {
    if (rating >= 4.5) return successColor;
    if (rating >= 4.0) return infoColor;
    if (rating >= 3.5) return warningColor;
    return dangerColor;
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
