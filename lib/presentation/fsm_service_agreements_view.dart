import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmServiceAgreementsView extends StatefulWidget {
  const FsmServiceAgreementsView({super.key});

  @override
  State<FsmServiceAgreementsView> createState() => _FsmServiceAgreementsViewState();
}

class _FsmServiceAgreementsViewState extends State<FsmServiceAgreementsView> {
  bool loading = false;
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedCategory = "All";

  List<Map<String, dynamic>> agreements = [
    {
      "id": "SA-001",
      "customer": "TechCorp Industries",
      "serviceType": "IT Support",
      "contractValue": 125000.0,
      "startDate": "2024-01-15",
      "endDate": "2025-01-15",
      "status": "Active",
      "responseTime": "4 hours",
      "coverage": "24/7",
      "renewalDate": "2024-12-15",
      "priority": "High",
      "location": "New York, NY",
      "techniciansAssigned": 8,
      "servicesIncluded": ["Hardware Support", "Software Support", "Network Maintenance"],
      "nextReview": "2024-07-15",
      "satisfaction": 4.8,
      "completedServices": 156,
      "pendingServices": 3
    },
    {
      "id": "SA-002", 
      "customer": "Global Manufacturing Co",
      "serviceType": "Equipment Maintenance",
      "contractValue": 85000.0,
      "startDate": "2024-03-01",
      "endDate": "2025-03-01",
      "status": "Active",
      "responseTime": "2 hours",
      "coverage": "Business Hours",
      "renewalDate": "2025-02-01",
      "priority": "Medium",
      "location": "Chicago, IL",
      "techniciansAssigned": 5,
      "servicesIncluded": ["Preventive Maintenance", "Emergency Repairs", "Parts Replacement"],
      "nextReview": "2024-09-01",
      "satisfaction": 4.6,
      "completedServices": 89,
      "pendingServices": 1
    },
    {
      "id": "SA-003",
      "customer": "Healthcare Systems Inc",
      "serviceType": "Medical Equipment Service",
      "contractValue": 200000.0,
      "startDate": "2023-12-01",
      "endDate": "2024-12-01",
      "status": "Renewal Required",
      "responseTime": "1 hour",
      "coverage": "24/7",
      "renewalDate": "2024-11-01",
      "priority": "Critical",
      "location": "Boston, MA",
      "techniciansAssigned": 12,
      "servicesIncluded": ["Equipment Calibration", "Compliance Testing", "Emergency Support"],
      "nextReview": "2024-08-01",
      "satisfaction": 4.9,
      "completedServices": 234,
      "pendingServices": 7
    },
    {
      "id": "SA-004",
      "customer": "Retail Chain Solutions",
      "serviceType": "POS System Support",
      "contractValue": 45000.0,
      "startDate": "2024-05-01",
      "endDate": "2025-05-01",
      "status": "Active",
      "responseTime": "6 hours",
      "coverage": "Business Hours",
      "renewalDate": "2025-04-01",
      "priority": "Low",
      "location": "Miami, FL",
      "techniciansAssigned": 3,
      "servicesIncluded": ["Software Updates", "Hardware Maintenance", "User Training"],
      "nextReview": "2024-11-01",
      "satisfaction": 4.4,
      "completedServices": 67,
      "pendingServices": 2
    },
    {
      "id": "SA-005",
      "customer": "Energy Solutions Ltd",
      "serviceType": "Infrastructure Monitoring",
      "contractValue": 175000.0,
      "startDate": "2024-02-15",
      "endDate": "2026-02-15",
      "status": "Active",
      "responseTime": "30 minutes",
      "coverage": "24/7",
      "renewalDate": "2026-01-15",
      "priority": "Critical",
      "location": "Houston, TX",
      "techniciansAssigned": 15,
      "servicesIncluded": ["System Monitoring", "Predictive Maintenance", "Emergency Response"],
      "nextReview": "2024-08-15",
      "satisfaction": 4.7,
      "completedServices": 298,
      "pendingServices": 5
    }
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "Renewal Required", "value": "Renewal Required"},
    {"label": "Expired", "value": "Expired"},
    {"label": "Suspended", "value": "Suspended"}
  ];

  List<Map<String, dynamic>> categoryItems = [
    {"label": "All", "value": "All"},
    {"label": "IT Support", "value": "IT Support"},
    {"label": "Equipment Maintenance", "value": "Equipment Maintenance"},
    {"label": "Medical Equipment Service", "value": "Medical Equipment Service"},
    {"label": "POS System Support", "value": "POS System Support"},
    {"label": "Infrastructure Monitoring", "value": "Infrastructure Monitoring"}
  ];

  List<Map<String, dynamic>> get filteredAgreements {
    return agreements.where((agreement) {
      bool matchesSearch = agreement["customer"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          agreement["id"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          agreement["serviceType"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "All" || agreement["status"] == selectedStatus;
      bool matchesCategory = selectedCategory == "All" || agreement["serviceType"] == selectedCategory;
      
      return matchesSearch && matchesStatus && matchesCategory;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Renewal Required":
        return warningColor;
      case "Expired":
        return dangerColor;
      case "Suspended":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Critical":
        return dangerColor;
      case "High":
        return warningColor;
      case "Medium":
        return infoColor;
      case "Low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  void _viewAgreementDetails(Map<String, dynamic> agreement) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Service Agreement Details"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Text("Agreement ID: ${agreement["id"]}", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("Customer: ${agreement["customer"]}"),
              Text("Service Type: ${agreement["serviceType"]}"),
              Text("Contract Value: \$${(agreement["contractValue"] as double).currency}"),
              Text("Duration: ${agreement["startDate"]} to ${agreement["endDate"]}"),
              Text("Response Time: ${agreement["responseTime"]}"),
              Text("Coverage: ${agreement["coverage"]}"),
              Text("Location: ${agreement["location"]}"),
              Text("Technicians: ${agreement["techniciansAssigned"]}"),
              Text("Satisfaction: ${agreement["satisfaction"]}/5.0"),
              Text("Services Completed: ${agreement["completedServices"]}"),
              Text("Pending Services: ${agreement["pendingServices"]}"),
              SizedBox(height: spSm),
              Text("Services Included:", style: TextStyle(fontWeight: FontWeight.bold)),
              ...(agreement["servicesIncluded"] as List).map((service) => 
                Text("• $service", style: TextStyle(fontSize: 14))),
            ],
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

  void _renewAgreement(Map<String, dynamic> agreement) async {
    bool isConfirmed = await confirm("Renew service agreement ${agreement["id"]}?");
    if (isConfirmed) {
      loading = true;
      setState(() {});
      
      await Future.delayed(Duration(seconds: 2));
      
      setState(() {
        agreement["status"] = "Active";
        agreement["renewalDate"] = "2025-12-15";
      });
      
      loading = false;
      setState(() {});
      
      ss("Service agreement renewed successfully");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Service Agreements"),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Service Agreements"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to add agreement
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
                _buildSummaryCard("Total Agreements", "${agreements.length}", primaryColor, Icons.description),
                _buildSummaryCard("Active", "${agreements.where((a) => a["status"] == "Active").length}", successColor, Icons.check_circle),
                _buildSummaryCard("Renewal Required", "${agreements.where((a) => a["status"] == "Renewal Required").length}", warningColor, Icons.warning),
                _buildSummaryCard("Total Value", "\$${((agreements.fold(0.0, (sum, a) => sum + (a["contractValue"] as double))) / 1000).toStringAsFixed(0)}K", infoColor, Icons.attach_money),
              ],
            ),

            // Search and Filters
            QTextField(
              label: "Search agreements",
              value: searchQuery,
              hint: "Search by customer, ID, or service type",
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
                    items: statusItems,
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
                    label: "Service Category",
                    items: categoryItems,
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Agreements List
            Text(
              "Service Agreements (${filteredAgreements.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            ...filteredAgreements.map((agreement) => Container(
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
                              "${agreement["id"]} - ${agreement["customer"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${agreement["serviceType"]}",
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
                          color: _getStatusColor(agreement["status"]).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${agreement["status"]}",
                          style: TextStyle(
                            color: _getStatusColor(agreement["status"]),
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
                              "Contract Value",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "\$${(agreement["contractValue"] as double).currency}",
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
                              "Response Time",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${agreement["responseTime"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getPriorityColor(agreement["priority"]).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${agreement["priority"]}",
                          style: TextStyle(
                            color: _getPriorityColor(agreement["priority"]),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16, color: disabledBoldColor),
                      SizedBox(width: 4),
                      Text(
                        "${agreement["location"]}",
                        style: TextStyle(fontSize: 12, color: disabledBoldColor),
                      ),
                      Spacer(),
                      Icon(Icons.people, size: 16, color: disabledBoldColor),
                      SizedBox(width: 4),
                      Text(
                        "${agreement["techniciansAssigned"]} technicians",
                        style: TextStyle(fontSize: 12, color: disabledBoldColor),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "View Details",
                          size: bs.sm,
                          onPressed: () => _viewAgreementDetails(agreement),
                        ),
                      ),
                      SizedBox(width: spSm),
                      if (agreement["status"] == "Renewal Required")
                        Expanded(
                          child: QButton(
                            label: "Renew",
                            size: bs.sm,
                            onPressed: () => _renewAgreement(agreement),
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
