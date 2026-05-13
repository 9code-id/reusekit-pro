import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmCustomerDetailView extends StatefulWidget {
  const FsmCustomerDetailView({super.key});

  @override
  State<FsmCustomerDetailView> createState() => _FsmCustomerDetailViewState();
}

class _FsmCustomerDetailViewState extends State<FsmCustomerDetailView> {
  int currentTab = 0;
  
  Map<String, dynamic> customer = {
    "id": "CUST001",
    "name": "TechCorp Industries",
    "type": "enterprise",
    "status": "active",
    "priority": "high",
    "contact_person": "John Smith",
    "title": "Facilities Manager",
    "email": "john.smith@techcorp.com",
    "phone": "+1-555-0123",
    "mobile": "+1-555-0124",
    "address": "123 Business Ave, Tech City, TC 12345",
    "website": "www.techcorp.com",
    "locations_count": 5,
    "equipment_count": 24,
    "contracts_count": 3,
    "last_service": "2024-01-10",
    "next_service": "2024-01-20",
    "total_value": 85000.0,
    "service_level": "Premium",
    "account_manager": "Sarah Johnson",
    "created_date": "2022-03-15",
    "rating": 4.8,
    "payment_terms": "Net 30",
    "billing_address": "456 Finance St, Tech City, TC 12346",
    "company_size": "500-1000 employees",
    "industry": "Technology",
    "notes": "Important client with multiple locations. Requires 24/7 emergency support. Very satisfied with current service level.",
  };
  
  List<Map<String, dynamic>> serviceHistory = [
    {
      "id": "SH001",
      "date": "2024-01-10",
      "type": "Preventive Maintenance",
      "equipment": "HVAC System - Building A",
      "technician": "John Smith",
      "status": "Completed",
      "duration": 2.5,
      "cost": 850.0,
      "description": "Quarterly HVAC maintenance and filter replacement",
      "rating": 5,
    },
    {
      "id": "SH002",
      "date": "2024-01-05",
      "type": "Emergency Repair",
      "equipment": "Elevator System - Building B",
      "technician": "Mike Wilson",
      "status": "Completed",
      "duration": 4.0,
      "cost": 1200.0,
      "description": "Emergency elevator repair - motor replacement",
      "rating": 4,
    },
    {
      "id": "SH003",
      "date": "2023-12-28",
      "type": "Installation",
      "equipment": "Security System - Building C",
      "technician": "Sarah Johnson",
      "status": "Completed",
      "duration": 8.0,
      "cost": 3500.0,
      "description": "New security system installation with cameras and access control",
      "rating": 5,
    },
  ];
  
  List<Map<String, dynamic>> activeContracts = [
    {
      "id": "CON001",
      "name": "HVAC Maintenance Contract",
      "type": "Preventive Maintenance",
      "start_date": "2024-01-01",
      "end_date": "2024-12-31",
      "value": 35000.0,
      "status": "active",
      "frequency": "Quarterly",
      "coverage": "All HVAC systems across 5 locations",
    },
    {
      "id": "CON002",
      "name": "Emergency Support Contract",
      "type": "Emergency Response",
      "start_date": "2024-01-01",
      "end_date": "2024-12-31",
      "value": 25000.0,
      "status": "active",
      "frequency": "24/7 On-demand",
      "coverage": "All equipment emergency support",
    },
    {
      "id": "CON003",
      "name": "Security System Maintenance",
      "type": "Preventive Maintenance",
      "start_date": "2024-01-01",
      "end_date": "2024-12-31",
      "value": 15000.0,
      "status": "active",
      "frequency": "Monthly",
      "coverage": "Security systems and access control",
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return successColor;
      case "inactive":
        return disabledBoldColor;
      case "suspended":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "critical":
        return dangerColor;
      case "high":
        return warningColor;
      case "medium":
        return infoColor;
      case "low":
        return successColor;
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
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${customer["id"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: spXs),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                                decoration: BoxDecoration(
                                  color: _getStatusColor("${customer["status"]}").withAlpha(50),
                                  borderRadius: BorderRadius.circular(radiusLg),
                                ),
                                child: Text(
                                  "${customer["status"]}".toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: _getStatusColor("${customer["status"]}"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${customer["name"]}",
                            style: TextStyle(
                              fontSize: fsH4,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              _buildStarRating((customer["rating"] as num).toInt()),
                              SizedBox(width: spXs),
                              Text(
                                "(${(customer["rating"] as num).toDouble()})",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: _getPriorityColor("${customer["priority"]}").withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Text(
                        "${customer["priority"]}".toUpperCase(),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: _getPriorityColor("${customer["priority"]}"),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 200,
                  children: [
                    _buildStatCard("Locations", "${customer["locations_count"]}", Icons.location_on),
                    _buildStatCard("Equipment", "${customer["equipment_count"]}", Icons.build),
                    _buildStatCard("Contracts", "${customer["contracts_count"]}", Icons.description),
                    _buildStatCard("Total Value", "\$${((customer["total_value"] as num).toDouble()).currency}", Icons.attach_money),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),
          Text(
            "Contact Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                _buildInfoRow(Icons.person, "Contact Person", "${customer["contact_person"]} - ${customer["title"]}"),
                _buildInfoRow(Icons.email, "Email", "${customer["email"]}"),
                _buildInfoRow(Icons.phone, "Phone", "${customer["phone"]}"),
                _buildInfoRow(Icons.phone_android, "Mobile", "${customer["mobile"]}"),
                _buildInfoRow(Icons.language, "Website", "${customer["website"]}"),
                _buildInfoRow(Icons.location_on, "Address", "${customer["address"]}"),
              ],
            ),
          ),
          SizedBox(height: spMd),
          Text(
            "Service Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                _buildInfoRow(Icons.star, "Service Level", "${customer["service_level"]}"),
                _buildInfoRow(Icons.person_pin, "Account Manager", "${customer["account_manager"]}"),
                _buildInfoRow(Icons.schedule, "Last Service", "${customer["last_service"]}"),
                _buildInfoRow(Icons.event, "Next Service", "${customer["next_service"]}"),
                _buildInfoRow(Icons.payment, "Payment Terms", "${customer["payment_terms"]}"),
                _buildInfoRow(Icons.business, "Company Size", "${customer["company_size"]}"),
                _buildInfoRow(Icons.category, "Industry", "${customer["industry"]}"),
              ],
            ),
          ),
          SizedBox(height: spMd),
          Text(
            "Notes",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Text(
              "${customer["notes"]}",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
                height: 1.4,
              ),
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Edit Customer",
                  onPressed: () {
                    // Navigate to edit
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Add Service",
                  onPressed: () {
                    // Add new service
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
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
                color: primaryColor,
                size: 20,
              ),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
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

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: spXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 18,
            color: disabledBoldColor,
          ),
          SizedBox(width: spSm),
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceHistoryTab() {
    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: serviceHistory.length,
      itemBuilder: (context, index) {
        final service = serviceHistory[index];
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
                          "${service["id"]} - ${service["type"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${service["date"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildStarRating((service["rating"] as num).toInt()),
                ],
              ),
              SizedBox(height: spSm),
              Text(
                "${service["equipment"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "${service["description"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Icon(Icons.person, size: 16, color: disabledBoldColor),
                  SizedBox(width: spXs),
                  Text(
                    "${service["technician"]}",
                    style: TextStyle(fontSize: 12, color: disabledBoldColor),
                  ),
                  Spacer(),
                  Text(
                    "${(service["duration"] as num).toStringAsFixed(1)}h",
                    style: TextStyle(fontSize: 12, color: disabledBoldColor),
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "\$${((service["cost"] as num).toDouble()).currency}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: successColor,
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

  Widget _buildContractsTab() {
    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: activeContracts.length,
      itemBuilder: (context, index) {
        final contract = activeContracts[index];
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
                          "${contract["name"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${contract["id"]} - ${contract["type"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Text(
                      "${contract["status"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Text(
                "${contract["coverage"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spSm),
              Row(
                children: [
                  Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                  SizedBox(width: spXs),
                  Text(
                    "${contract["frequency"]}",
                    style: TextStyle(fontSize: 12, color: disabledBoldColor),
                  ),
                ],
              ),
              SizedBox(height: spXs),
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 16, color: disabledBoldColor),
                  SizedBox(width: spXs),
                  Text(
                    "${contract["start_date"]} - ${contract["end_date"]}",
                    style: TextStyle(fontSize: 12, color: disabledBoldColor),
                  ),
                  Spacer(),
                  Text(
                    "\$${((contract["value"] as num).toDouble()).currency}",
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
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Customer Details",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.info)),
        Tab(text: "History", icon: Icon(Icons.history)),
        Tab(text: "Contracts", icon: Icon(Icons.description)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildServiceHistoryTab(),
        _buildContractsTab(),
      ],
      onInit: (tabController) {},
    );
  }
}
