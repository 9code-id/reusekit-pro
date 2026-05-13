import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmCustomerListView extends StatefulWidget {
  const FsmCustomerListView({super.key});

  @override
  State<FsmCustomerListView> createState() => _FsmCustomerListViewState();
}

class _FsmCustomerListViewState extends State<FsmCustomerListView> {
  String searchQuery = "";
  String selectedType = "all";
  String selectedStatus = "all";
  String selectedPriority = "all";
  String sortBy = "name";
  bool sortAscending = true;
  
  List<Map<String, dynamic>> typeOptions = [
    {"label": "All Types", "value": "all"},
    {"label": "Enterprise", "value": "enterprise"},
    {"label": "Commercial", "value": "commercial"},
    {"label": "Residential", "value": "residential"},
    {"label": "Government", "value": "government"},
  ];
  
  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Inactive", "value": "inactive"},
    {"label": "Suspended", "value": "suspended"},
  ];
  
  List<Map<String, dynamic>> priorityOptions = [
    {"label": "All Priority", "value": "all"},
    {"label": "Critical", "value": "critical"},
    {"label": "High", "value": "high"},
    {"label": "Medium", "value": "medium"},
    {"label": "Low", "value": "low"},
  ];
  
  List<Map<String, dynamic>> customers = [
    {
      "id": "CUST001",
      "name": "TechCorp Industries",
      "type": "enterprise",
      "status": "active",
      "priority": "high",
      "contact_person": "John Smith",
      "email": "john.smith@techcorp.com",
      "phone": "+1-555-0123",
      "address": "123 Business Ave, Tech City, TC 12345",
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
    },
    {
      "id": "CUST002",
      "name": "Metro Hospital Center",
      "type": "commercial",
      "status": "active",
      "priority": "critical",
      "contact_person": "Dr. Emily Wilson",
      "email": "emily.wilson@metrohospital.com",
      "phone": "+1-555-0124",
      "address": "456 Health Blvd, Medical District, MD 67890",
      "locations_count": 3,
      "equipment_count": 18,
      "contracts_count": 2,
      "last_service": "2024-01-12",
      "next_service": "2024-01-25",
      "total_value": 120000.0,
      "service_level": "Premium Plus",
      "account_manager": "Mike Wilson",
      "created_date": "2021-08-20",
      "rating": 4.9,
    },
    {
      "id": "CUST003",
      "name": "Sunrise Apartments",
      "type": "residential",
      "status": "active",
      "priority": "medium",
      "contact_person": "Robert Chen",
      "email": "robert.chen@sunriseapts.com",
      "phone": "+1-555-0125",
      "address": "789 Residential St, Suburb City, SC 11111",
      "locations_count": 2,
      "equipment_count": 12,
      "contracts_count": 1,
      "last_service": "2024-01-08",
      "next_service": "2024-02-15",
      "total_value": 35000.0,
      "service_level": "Standard",
      "account_manager": "Lisa Park",
      "created_date": "2023-01-10",
      "rating": 4.2,
    },
    {
      "id": "CUST004",
      "name": "City Government Building",
      "type": "government",
      "status": "inactive",
      "priority": "low",
      "contact_person": "David Brown",
      "email": "david.brown@cityoffice.gov",
      "phone": "+1-555-0126",
      "address": "321 Government Plaza, Downtown, DT 22222",
      "locations_count": 1,
      "equipment_count": 8,
      "contracts_count": 0,
      "last_service": "2023-12-15",
      "next_service": "",
      "total_value": 0.0,
      "service_level": "Basic",
      "account_manager": "Tom Anderson",
      "created_date": "2020-05-05",
      "rating": 3.5,
    },
    {
      "id": "CUST005",
      "name": "Global Manufacturing Ltd",
      "type": "enterprise",
      "status": "active",
      "priority": "high",
      "contact_person": "Maria Garcia",
      "email": "maria.garcia@globalmanuf.com",
      "phone": "+1-555-0127",
      "address": "999 Industrial Pkwy, Factory District, FD 33333",
      "locations_count": 8,
      "equipment_count": 45,
      "contracts_count": 5,
      "last_service": "2024-01-14",
      "next_service": "2024-01-22",
      "total_value": 215000.0,
      "service_level": "Enterprise",
      "account_manager": "Alex Thompson",
      "created_date": "2019-11-12",
      "rating": 4.7,
    },
    {
      "id": "CUST006",
      "name": "Downtown Shopping Mall",
      "type": "commercial",
      "status": "active",
      "priority": "medium",
      "contact_person": "Kevin Lee",
      "email": "kevin.lee@downtownmall.com",
      "phone": "+1-555-0128",
      "address": "555 Shopping Center Dr, Mall District, ML 44444",
      "locations_count": 1,
      "equipment_count": 15,
      "contracts_count": 2,
      "last_service": "2024-01-09",
      "next_service": "2024-01-30",
      "total_value": 65000.0,
      "service_level": "Premium",
      "account_manager": "Jenny Kim",
      "created_date": "2022-07-18",
      "rating": 4.4,
    },
  ];

  List<Map<String, dynamic>> get filteredAndSortedCustomers {
    List<Map<String, dynamic>> filtered = customers.where((customer) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${customer["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${customer["contact_person"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${customer["email"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${customer["id"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesType = selectedType == "all" || customer["type"] == selectedType;
      bool matchesStatus = selectedStatus == "all" || customer["status"] == selectedStatus;
      bool matchesPriority = selectedPriority == "all" || customer["priority"] == selectedPriority;
      
      return matchesSearch && matchesType && matchesStatus && matchesPriority;
    }).toList();
    
    filtered.sort((a, b) {
      dynamic valueA = a[sortBy];
      dynamic valueB = b[sortBy];
      
      if (valueA == null && valueB == null) return 0;
      if (valueA == null) return sortAscending ? 1 : -1;
      if (valueB == null) return sortAscending ? -1 : 1;
      
      int comparison = valueA.toString().compareTo(valueB.toString());
      return sortAscending ? comparison : -comparison;
    });
    
    return filtered;
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "enterprise":
        return primaryColor;
      case "commercial":
        return successColor;
      case "residential":
        return infoColor;
      case "government":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

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

  Widget _buildStarRating(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < rating.floor()) {
          return Icon(Icons.star, size: 12, color: warningColor);
        } else if (index < rating) {
          return Icon(Icons.star_half, size: 12, color: warningColor);
        } else {
          return Icon(Icons.star_border, size: 12, color: disabledBoldColor);
        }
      }),
    );
  }

  Widget _buildCustomerListItem(Map<String, dynamic> customer) {
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
            color: _getTypeColor("${customer["type"]}"),
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
                          "${customer["id"]}",
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
                            color: _getTypeColor("${customer["type"]}").withAlpha(50),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            "${customer["type"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: _getTypeColor("${customer["type"]}"),
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        _buildStarRating((customer["rating"] as num).toDouble()),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${customer["name"]}",
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
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getStatusColor("${customer["status"]}").withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Text(
                      "${customer["status"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: _getStatusColor("${customer["status"]}"),
                      ),
                    ),
                  ),
                  SizedBox(height: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: _getPriorityColor("${customer["priority"]}").withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Text(
                      "${customer["priority"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: _getPriorityColor("${customer["priority"]}"),
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
              Icon(
                Icons.person,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${customer["contact_person"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                "${customer["service_level"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Icon(
                Icons.email,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${customer["email"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                  ),
                ),
              ),
              Text(
                "${customer["phone"]}",
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
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${customer["locations_count"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Locations",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${customer["equipment_count"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Equipment",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${customer["contracts_count"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Contracts",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "\$${((customer["total_value"] as num) / 1000).toStringAsFixed(0)}K",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Value",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if ("${customer["next_service"]}".isNotEmpty) ...[
            SizedBox(height: spXs),
            Row(
              children: [
                Icon(
                  Icons.schedule,
                  size: 14,
                  color: warningColor,
                ),
                SizedBox(width: spXs),
                Text(
                  "Next Service: ${customer["next_service"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: warningColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
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
                    // Navigate to customer detail
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Manage",
                  size: bs.sm,
                  onPressed: () {
                    // Navigate to customer management
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer List"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () {
              // Navigate to add customer
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search customers...",
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
                        label: "Type",
                        items: typeOptions,
                        value: selectedType,
                        onChanged: (value, label) {
                          selectedType = value;
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
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Priority",
                        items: priorityOptions,
                        value: selectedPriority,
                        onChanged: (value, label) {
                          selectedPriority = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: sortAscending ? Icons.arrow_upward : Icons.arrow_downward,
                      size: bs.sm,
                      onPressed: () {
                        sortAscending = !sortAscending;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spXs),
            child: Row(
              children: [
                Text(
                  "Found ${filteredAndSortedCustomers.length} customers",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                QButton(
                  icon: Icons.filter_list,
                  size: bs.sm,
                  onPressed: () {
                    // Show filter options
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: filteredAndSortedCustomers.length,
              itemBuilder: (context, index) {
                return _buildCustomerListItem(filteredAndSortedCustomers[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
