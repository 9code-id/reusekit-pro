import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmCustomerListView extends StatefulWidget {
  const CrmCustomerListView({super.key});

  @override
  State<CrmCustomerListView> createState() => _CrmCustomerListViewState();
}

class _CrmCustomerListViewState extends State<CrmCustomerListView> {
  String searchQuery = "";
  String selectedStatus = "All";
  String selectedType = "All";
  String sortBy = "Recent";

  List<String> statusOptions = ["All", "Active", "Inactive", "Lead", "Prospect"];
  List<String> typeOptions = ["All", "Individual", "Company"];
  List<String> sortOptions = ["Recent", "Name A-Z", "Name Z-A", "Value High-Low"];

  List<Map<String, dynamic>> customers = [
    {
      "id": "1",
      "name": "TechCorp Inc.",
      "email": "contact@techcorp.com",
      "phone": "+1 555-123-4567",
      "company": "TechCorp Inc.",
      "status": "Active",
      "type": "Company",
      "total_value": 45000,
      "last_contact": "2024-06-18T14:30:00Z",
      "avatar": "https://picsum.photos/60/60?random=1&keyword=business",
      "location": "New York, NY",
      "tags": ["Enterprise", "Software"],
      "deals_count": 3,
      "notes": "Important client, always pays on time",
    },
    {
      "id": "2",
      "name": "Sarah Johnson",
      "email": "sarah.johnson@email.com",
      "phone": "+1 555-987-6543",
      "company": "Digital Solutions",
      "status": "Lead",
      "type": "Individual",
      "total_value": 12500,
      "last_contact": "2024-06-19T10:15:00Z",
      "avatar": "https://picsum.photos/60/60?random=2&keyword=person",
      "location": "Los Angeles, CA",
      "tags": ["Marketing", "Consulting"],
      "deals_count": 1,
      "notes": "Interested in consulting services",
    },
    {
      "id": "3",
      "name": "Mike Chen",
      "email": "mike.chen@growthco.com",
      "phone": "+1 555-456-7890",
      "company": "Growth Solutions",
      "status": "Prospect",
      "type": "Individual",
      "total_value": 8750,
      "last_contact": "2024-06-17T16:45:00Z",
      "avatar": "https://picsum.photos/60/60?random=3&keyword=person",
      "location": "Chicago, IL",
      "tags": ["Sales", "Growth"],
      "deals_count": 2,
      "notes": "Following up on proposal",
    },
    {
      "id": "4",
      "name": "Digital Plus Agency",
      "email": "hello@digitalplus.com",
      "phone": "+1 555-321-9876",
      "company": "Digital Plus Agency",
      "status": "Active",
      "type": "Company",
      "total_value": 28900,
      "last_contact": "2024-06-16T11:20:00Z",
      "avatar": "https://picsum.photos/60/60?random=4&keyword=business",
      "location": "San Francisco, CA",
      "tags": ["Digital", "Agency"],
      "deals_count": 4,
      "notes": "Long-term partnership",
    },
    {
      "id": "5",
      "name": "Emma Wilson",
      "email": "emma.wilson@innovate.com",
      "phone": "+1 555-654-3210",
      "company": "Innovate Labs",
      "status": "Inactive",
      "type": "Individual",
      "total_value": 5600,
      "last_contact": "2024-06-10T09:30:00Z",
      "avatar": "https://picsum.photos/60/60?random=5&keyword=person",
      "location": "Austin, TX",
      "tags": ["Innovation", "R&D"],
      "deals_count": 1,
      "notes": "Contract ended, potential for renewal",
    },
    {
      "id": "6",
      "name": "StartupXYZ",
      "email": "team@startupxyz.com",
      "phone": "+1 555-789-0123",
      "company": "StartupXYZ",
      "status": "Lead",
      "type": "Company",
      "total_value": 15000,
      "last_contact": "2024-06-19T08:00:00Z",
      "avatar": "https://picsum.photos/60/60?random=6&keyword=startup",
      "location": "Seattle, WA",
      "tags": ["Startup", "Tech"],
      "deals_count": 0,
      "notes": "New lead from website contact form",
    },
  ];

  List<Map<String, dynamic>> get filteredCustomers {
    return customers.where((customer) {
      bool matchesSearch = searchQuery.isEmpty ||
          (customer["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (customer["email"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (customer["company"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesStatus = selectedStatus == "All" || customer["status"] == selectedStatus;
      bool matchesType = selectedType == "All" || customer["type"] == selectedType;
      
      return matchesSearch && matchesStatus && matchesType;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Lead":
        return warningColor;
      case "Prospect":
        return infoColor;
      case "Inactive":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getTimeAgo(String dateString) {
    DateTime date = DateTime.parse(dateString);
    Duration difference = DateTime.now().difference(date);
    
    if (difference.inDays > 0) {
      return "${difference.inDays}d ago";
    } else if (difference.inHours > 0) {
      return "${difference.inHours}h ago";
    } else {
      return "${difference.inMinutes}m ago";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customers"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Summary Stats
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 140,
              children: [
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${customers.length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Total Customers",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${customers.where((c) => c["status"] == "Active").length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Active",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${customers.where((c) => c["status"] == "Lead").length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Leads",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "\$${((customers.map((c) => c["total_value"] as int).reduce((a, b) => a + b)) / 1000).toInt()}K",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Total Value",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Search and Filters
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search customers...",
                    value: searchQuery,
                    hint: "Name, email, or company",
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
                    label: "Status",
                    items: statusOptions.map((status) => {
                      "label": status,
                      "value": status,
                    }).toList(),
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
                    label: "Type",
                    items: typeOptions.map((type) => {
                      "label": type,
                      "value": type,
                    }).toList(),
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
                    label: "Sort By",
                    items: sortOptions.map((sort) => {
                      "label": sort,
                      "value": sort,
                    }).toList(),
                    value: sortBy,
                    onChanged: (value, label) {
                      sortBy = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Results Header
            Row(
              children: [
                Text(
                  "Customers",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Text(
                  "${filteredCustomers.length} results",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),

            // Customer List
            Column(
              spacing: spSm,
              children: filteredCustomers.map((customer) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spSm,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header with Avatar and Status
                      Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage("${customer["avatar"]}"),
                                fit: BoxFit.cover,
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
                                        "${customer["name"]}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spSm,
                                        vertical: spXs,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _getStatusColor(customer["status"] as String).withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusLg),
                                      ),
                                      child: Text(
                                        "${customer["status"]}",
                                        style: TextStyle(
                                          color: _getStatusColor(customer["status"] as String),
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "${customer["company"]}",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // Contact Information
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
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.phone,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${customer["phone"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.location_on,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${customer["location"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),

                      // Tags
                      if ((customer["tags"] as List).isNotEmpty)
                        QHorizontalScroll(
                          children: (customer["tags"] as List).map((tag) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: secondaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Text(
                                "$tag",
                                style: TextStyle(
                                  color: secondaryColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }).toList(),
                        ),

                      // Stats Row
                      Row(
                        children: [
                          Icon(
                            Icons.attach_money,
                            size: 16,
                            color: successColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "\$${((customer["total_value"] as int).toDouble()).currency}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          SizedBox(width: spMd),
                          Icon(
                            Icons.handshake,
                            size: 16,
                            color: infoColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${customer["deals_count"]} deals",
                            style: TextStyle(
                              fontSize: 12,
                              color: infoColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Last contact ${_getTimeAgo(customer["last_contact"] as String)}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),

                      // Notes
                      if ((customer["notes"] as String).isNotEmpty)
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: disabledColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${customer["notes"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "View Details",
                              size: bs.sm,
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(width: spSm),
                          QButton(
                            icon: Icons.phone,
                            size: bs.sm,
                            onPressed: () {},
                          ),
                          SizedBox(width: spXs),
                          QButton(
                            icon: Icons.email,
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
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
