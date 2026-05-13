import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaVendorContactView extends StatefulWidget {
  const AbaVendorContactView({super.key});

  @override
  State<AbaVendorContactView> createState() => _AbaVendorContactViewState();
}

class _AbaVendorContactViewState extends State<AbaVendorContactView> {
  String searchQuery = "";
  String selectedCategory = "All";
  bool loading = false;

  List<Map<String, dynamic>> vendors = [
    {
      "id": 1,
      "name": "Tech Solutions Ltd",
      "email": "contact@techsolutions.com",
      "phone": "+1 (555) 123-4567",
      "category": "Technology",
      "status": "Active",
      "lastContact": "2024-01-15",
      "primaryContact": "John Smith",
      "position": "Sales Manager",
      "avatar": "https://picsum.photos/80/80?random=1",
      "rating": 4.8,
      "location": "New York, NY",
      "company": "Tech Solutions Ltd"
    },
    {
      "id": 2,
      "name": "Global Supplies Inc",
      "email": "info@globalsupplies.com",
      "phone": "+1 (555) 987-6543",
      "category": "Supplies",
      "status": "Active",
      "lastContact": "2024-01-10",
      "primaryContact": "Sarah Johnson",
      "position": "Account Executive",
      "avatar": "https://picsum.photos/80/80?random=2",
      "rating": 4.5,
      "location": "Los Angeles, CA",
      "company": "Global Supplies Inc"
    },
    {
      "id": 3,
      "name": "Manufacturing Corp",
      "email": "sales@manufacturing.com",
      "phone": "+1 (555) 456-7890",
      "category": "Manufacturing",
      "status": "Inactive",
      "lastContact": "2023-12-20",
      "primaryContact": "Mike Wilson",
      "position": "Director",
      "avatar": "https://picsum.photos/80/80?random=3",
      "rating": 4.2,
      "location": "Chicago, IL",
      "company": "Manufacturing Corp"
    },
    {
      "id": 4,
      "name": "Logistics Partners",
      "email": "contact@logistics.com",
      "phone": "+1 (555) 321-0987",
      "category": "Logistics",
      "status": "Active",
      "lastContact": "2024-01-18",
      "primaryContact": "Emily Davis",
      "position": "Operations Manager",
      "avatar": "https://picsum.photos/80/80?random=4",
      "rating": 4.7,
      "location": "Houston, TX",
      "company": "Logistics Partners"
    },
    {
      "id": 5,
      "name": "Service Providers LLC",
      "email": "hello@serviceproviders.com",
      "phone": "+1 (555) 654-3210",
      "category": "Services",
      "status": "Active",
      "lastContact": "2024-01-12",
      "primaryContact": "David Brown",
      "position": "Customer Success",
      "avatar": "https://picsum.photos/80/80?random=5",
      "rating": 4.6,
      "location": "Miami, FL",
      "company": "Service Providers LLC"
    }
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Technology", "value": "Technology"},
    {"label": "Supplies", "value": "Supplies"},
    {"label": "Manufacturing", "value": "Manufacturing"},
    {"label": "Logistics", "value": "Logistics"},
    {"label": "Services", "value": "Services"}
  ];

  List<Map<String, dynamic>> get filteredVendors {
    return vendors.where((vendor) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${vendor["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${vendor["email"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${vendor["primaryContact"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "All" || vendor["category"] == selectedCategory;
      
      return matchesSearch && matchesCategory;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Inactive":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vendor Contacts"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // navigateTo AddVendorContactView
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filter Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search vendors...",
                          value: searchQuery,
                          hint: "Name, email, or contact person",
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
                  QDropdownField(
                    label: "Category Filter",
                    items: categories,
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Statistics Cards
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${vendors.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Vendors",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${vendors.where((v) => v["status"] == "Active").length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Active",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Vendor List
            if (loading)
              Center(
                child: CircularProgressIndicator(),
              )
            else if (filteredVendors.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No vendors found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try adjusting your search or filter criteria",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...filteredVendors.map((vendor) {
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
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          ClipOval(
                            child: Image.network(
                              "${vendor["avatar"]}",
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${vendor["name"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${vendor["category"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor("${vendor["status"]}").withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${vendor["status"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: _getStatusColor("${vendor["status"]}"),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Contact Information
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Column(
                          spacing: spXs,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${vendor["primaryContact"]} - ${vendor["position"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
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
                                    "${vendor["email"]}",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: primaryColor,
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
                                  "${vendor["phone"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${vendor["location"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Rating and Last Contact
                      Row(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 16,
                                color: warningColor,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "${vendor["rating"]}",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: warningColor,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Text(
                            "Last contact: ${DateTime.parse("${vendor["lastContact"]}").dMMMy}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: QButton(
                              label: "Call",
                              icon: Icons.phone,
                              size: bs.sm,
                              onPressed: () {
                                // Handle call action
                              },
                            ),
                          ),
                          SizedBox(width: spXs),
                          Expanded(
                            child: QButton(
                              label: "Email",
                              icon: Icons.email,
                              size: bs.sm,
                              onPressed: () {
                                // Handle email action
                              },
                            ),
                          ),
                          SizedBox(width: spXs),
                          QButton(
                            icon: Icons.more_vert,
                            size: bs.sm,
                            onPressed: () {
                              // Show more options
                            },
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
    );
  }
}
