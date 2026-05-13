import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AbaVendorListView extends StatefulWidget {
  const AbaVendorListView({super.key});

  @override
  State<AbaVendorListView> createState() => _AbaVendorListViewState();
}

class _AbaVendorListViewState extends State<AbaVendorListView> {
  String searchQuery = "";
  String selectedCategory = "";
  String selectedStatus = "";
  String selectedLocation = "";
  String sortBy = "name";
  String viewMode = "grid"; // grid or list

  List<Map<String, dynamic>> vendors = [
    {
      "id": "V001",
      "name": "Office Supplies Plus",
      "category": "Office Supplies",
      "email": "contact@officesuppliesplus.com",
      "phone": "+1 (555) 123-4567",
      "address": "123 Business Ave, Suite 100",
      "city": "New York",
      "state": "NY",
      "zipCode": "10001",
      "country": "USA",
      "status": "Active",
      "totalSpent": 15420.50,
      "lastOrderDate": "2024-12-15",
      "paymentTerms": "Net 30",
      "taxId": "12-3456789",
      "contactPerson": "John Smith",
      "rating": 4.8,
      "orderCount": 47,
      "joinDate": "2023-03-15",
      "website": "www.officesuppliesplus.com",
      "certifications": ["ISO 9001", "Green Certified"]
    },
    {
      "id": "V002", 
      "name": "TechCorp Solutions",
      "category": "Technology",
      "email": "sales@techcorp.com",
      "phone": "+1 (555) 987-6543",
      "address": "456 Tech Drive",
      "city": "San Francisco",
      "state": "CA",
      "zipCode": "94105",
      "country": "USA",
      "status": "Active",
      "totalSpent": 28750.00,
      "lastOrderDate": "2024-12-18",
      "paymentTerms": "Net 15",
      "taxId": "98-7654321",
      "contactPerson": "Sarah Johnson",
      "rating": 4.9,
      "orderCount": 23,
      "joinDate": "2023-01-10",
      "website": "www.techcorp.com",
      "certifications": ["SOC 2", "AWS Partner"]
    },
    {
      "id": "V003",
      "name": "Green Cleaning Co",
      "category": "Maintenance",
      "email": "info@greenclean.com",
      "phone": "+1 (555) 555-0123",
      "address": "789 Eco Street",
      "city": "Portland",
      "state": "OR",
      "zipCode": "97201",
      "country": "USA",
      "status": "Inactive",
      "totalSpent": 8340.25,
      "lastOrderDate": "2024-11-30",
      "paymentTerms": "Net 30",
      "taxId": "55-9876543",
      "contactPerson": "Mike Wilson",
      "rating": 4.2,
      "orderCount": 18,
      "joinDate": "2023-06-20",
      "website": "www.greenclean.com",
      "certifications": ["Green Seal", "EPA Certified"]
    },
    {
      "id": "V004",
      "name": "Creative Marketing Hub",
      "category": "Marketing",
      "email": "hello@creativehub.com",
      "phone": "+1 (555) 789-0123",
      "address": "321 Design Boulevard",
      "city": "Los Angeles",
      "state": "CA",
      "zipCode": "90210",
      "country": "USA",
      "status": "Active",
      "totalSpent": 22100.75,
      "lastOrderDate": "2024-12-12",
      "paymentTerms": "Net 15",
      "taxId": "77-1234567",
      "contactPerson": "Emma Davis",
      "rating": 4.7,
      "orderCount": 31,
      "joinDate": "2023-02-28",
      "website": "www.creativehub.com",
      "certifications": ["Google Ads Certified", "Facebook Blueprint"]
    },
    {
      "id": "V005",
      "name": "Legal Partners LLC",
      "category": "Professional Services",
      "email": "contact@legalpartners.com",
      "phone": "+1 (555) 456-7890",
      "address": "987 Law Center Drive",
      "city": "Chicago",
      "state": "IL",
      "zipCode": "60601",
      "country": "USA",
      "status": "Active",
      "totalSpent": 45200.00,
      "lastOrderDate": "2024-12-10",
      "paymentTerms": "Net 30",
      "taxId": "33-9876543",
      "contactPerson": "Robert Martinez",
      "rating": 4.9,
      "orderCount": 12,
      "joinDate": "2023-08-05",
      "website": "www.legalpartners.com",
      "certifications": ["Bar Association", "ABA Accredited"]
    },
    {
      "id": "V006",
      "name": "Food & Beverage Depot",
      "category": "Food & Beverage",
      "email": "orders@fbdepot.com",
      "phone": "+1 (555) 321-6540",
      "address": "654 Warehouse Way",
      "city": "Miami",
      "state": "FL",
      "zipCode": "33101",
      "country": "USA",
      "status": "Pending",
      "totalSpent": 0.00,
      "lastOrderDate": "N/A",
      "paymentTerms": "Net 30",
      "taxId": "44-5678901",
      "contactPerson": "Carlos Rodriguez",
      "rating": 0.0,
      "orderCount": 0,
      "joinDate": "2024-12-18",
      "website": "www.fbdepot.com",
      "certifications": ["HACCP", "FDA Approved"]
    }
  ];

  List<Map<String, dynamic>> vendorCategories = [
    {"label": "All Categories", "value": ""},
    {"label": "Office Supplies", "value": "Office Supplies"},
    {"label": "Technology", "value": "Technology"},
    {"label": "Maintenance", "value": "Maintenance"},
    {"label": "Professional Services", "value": "Professional Services"},
    {"label": "Marketing", "value": "Marketing"},
    {"label": "Food & Beverage", "value": "Food & Beverage"}
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": ""},
    {"label": "Active", "value": "Active"},
    {"label": "Inactive", "value": "Inactive"},
    {"label": "Pending", "value": "Pending"}
  ];

  List<Map<String, dynamic>> locationOptions = [
    {"label": "All Locations", "value": ""},
    {"label": "California", "value": "CA"},
    {"label": "New York", "value": "NY"},
    {"label": "Illinois", "value": "IL"},
    {"label": "Oregon", "value": "OR"},
    {"label": "Florida", "value": "FL"}
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Name A-Z", "value": "name"},
    {"label": "Name Z-A", "value": "name_desc"},
    {"label": "Total Spent (High-Low)", "value": "totalSpent"},
    {"label": "Total Spent (Low-High)", "value": "totalSpent_asc"},
    {"label": "Last Order Date", "value": "lastOrderDate"},
    {"label": "Rating (High-Low)", "value": "rating"},
    {"label": "Join Date (Recent)", "value": "joinDate"}
  ];

  List<Map<String, dynamic>> get filteredVendors {
    return vendors.where((vendor) {
      bool matchesSearch = searchQuery.isEmpty ||
          (vendor["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (vendor["category"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (vendor["contactPerson"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory.isEmpty || vendor["category"] == selectedCategory;
      bool matchesStatus = selectedStatus.isEmpty || vendor["status"] == selectedStatus;
      bool matchesLocation = selectedLocation.isEmpty || vendor["state"] == selectedLocation;
      
      return matchesSearch && matchesCategory && matchesStatus && matchesLocation;
    }).toList()..sort((a, b) {
      switch (sortBy) {
        case "name":
          return (a["name"] as String).compareTo(b["name"] as String);
        case "name_desc":
          return (b["name"] as String).compareTo(a["name"] as String);
        case "totalSpent":
          return (b["totalSpent"] as double).compareTo(a["totalSpent"] as double);
        case "totalSpent_asc":
          return (a["totalSpent"] as double).compareTo(b["totalSpent"] as double);
        case "lastOrderDate":
          return (b["lastOrderDate"] as String).compareTo(a["lastOrderDate"] as String);
        case "rating":
          return (b["rating"] as double).compareTo(a["rating"] as double);
        case "joinDate":
          return (b["joinDate"] as String).compareTo(a["joinDate"] as String);
        default:
          return 0;
      }
    });
  }

  void _viewVendorDetails(Map<String, dynamic> vendor) {
    ss("Viewing details for ${vendor["name"]}");
  }

  void _editVendor(Map<String, dynamic> vendor) {
    ss("Editing vendor: ${vendor["name"]}");
  }

  void _contactVendor(Map<String, dynamic> vendor) {
    ss("Contacting ${vendor["contactPerson"]} at ${vendor["name"]}");
  }

  void _toggleVendorStatus(Map<String, dynamic> vendor) async {
    String newStatus = vendor["status"] == "Active" ? "Inactive" : "Active";
    bool isConfirmed = await confirm("Are you sure you want to ${vendor["status"] == "Active" ? "deactivate" : "activate"} this vendor?");
    if (isConfirmed) {
      setState(() {
        vendor["status"] = newStatus;
      });
      ss("Vendor status updated to $newStatus");
    }
  }

  void _deleteVendor(Map<String, dynamic> vendor) async {
    bool isConfirmed = await confirm("Are you sure you want to delete ${vendor["name"]}? This action cannot be undone.");
    if (isConfirmed) {
      setState(() {
        vendors.removeWhere((v) => v["id"] == vendor["id"]);
      });
      ss("Vendor deleted successfully");
    }
  }

  void _addVendor() {
    ss("Navigating to Add Vendor form");
  }

  void _exportVendors() {
    ss("Exporting vendor list to CSV");
  }

  void _importVendors() {
    ss("Opening vendor import dialog");
  }

  Widget _buildVendorCard(Map<String, dynamic> vendor) {
    Color statusColor = vendor["status"] == "Active" 
        ? successColor 
        : vendor["status"] == "Inactive" 
            ? dangerColor 
            : warningColor;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: disabledOutlineBorderColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          // Header with status
          Row(
            children: [
              Expanded(
                child: Text(
                  "${vendor["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${vendor["status"]}",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),

          // Category and Contact
          Text(
            "${vendor["category"]}",
            style: TextStyle(
              fontSize: 13,
              color: disabledBoldColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          
          Text(
            "${vendor["contactPerson"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledColor,
            ),
          ),

          // Location
          Row(
            children: [
              Icon(Icons.location_on, size: 14, color: disabledColor),
              SizedBox(width: 4),
              Expanded(
                child: Text(
                  "${vendor["city"]}, ${vendor["state"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledColor,
                  ),
                ),
              ),
            ],
          ),

          // Stats
          if (vendor["status"] != "Pending") ...[
            Divider(color: disabledOutlineBorderColor),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Text(
                        "Total Spent",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledColor,
                        ),
                      ),
                      Text(
                        "\$${(vendor["totalSpent"] as double).currency}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    spacing: spXs,
                    children: [
                      Text(
                        "Rating",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledColor,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star, color: warningColor, size: 14),
                          SizedBox(width: 2),
                          Text(
                            "${vendor["rating"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],

          // Actions
          Container(
            width: double.infinity,
            child: QButton(
              label: "View Details",
              size: bs.sm,
              onPressed: () => _viewVendorDetails(vendor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVendorListItem(Map<String, dynamic> vendor) {
    Color statusColor = vendor["status"] == "Active" 
        ? successColor 
        : vendor["status"] == "Inactive" 
            ? dangerColor 
            : warningColor;

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: disabledOutlineBorderColor.withAlpha(50)),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${vendor["name"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${vendor["status"]}",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: statusColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${vendor["category"]} • ${vendor["contactPerson"]}",
                      style: TextStyle(
                        fontSize: 13,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${vendor["email"]} • ${vendor["phone"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                      ),
                    ),
                    Text(
                      "${vendor["city"]}, ${vendor["state"]} ${vendor["zipCode"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              ),
              if (vendor["status"] != "Pending")
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: spXs,
                  children: [
                    Text(
                      "\$${(vendor["totalSpent"] as double).currency}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.star, color: warningColor, size: 14),
                        SizedBox(width: 2),
                        Text(
                          "${vendor["rating"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${vendor["orderCount"]} orders",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () => _viewVendorDetails(vendor),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Edit",
                  icon: Icons.edit,
                  size: bs.sm,
                  onPressed: () => _editVendor(vendor),
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.phone,
                size: bs.sm,
                onPressed: () => _contactVendor(vendor),
              ),
              SizedBox(width: spXs),
              QButton(
                icon: vendor["status"] == "Active" ? Icons.pause : Icons.play_arrow,
                size: bs.sm,
                onPressed: () => _toggleVendorStatus(vendor),
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.delete,
                size: bs.sm,
                onPressed: () => _deleteVendor(vendor),
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
        title: Text("Vendor Directory"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filters
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  // Search Bar
                  QTextField(
                    label: "Search vendors, categories, or contacts...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  
                  // Filter Row 1
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Category",
                          items: vendorCategories,
                          value: selectedCategory,
                          onChanged: (value, label) {
                            selectedCategory = value;
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
                  
                  // Filter Row 2
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Location",
                          items: locationOptions,
                          value: selectedLocation,
                          onChanged: (value, label) {
                            selectedLocation = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Sort by",
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
                  
                  // Clear Filters
                  if (searchQuery.isNotEmpty || selectedCategory.isNotEmpty || 
                      selectedStatus.isNotEmpty || selectedLocation.isNotEmpty)
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Clear All Filters",
                        icon: Icons.clear,
                        size: bs.sm,
                        onPressed: () {
                          searchQuery = "";
                          selectedCategory = "";
                          selectedStatus = "";
                          selectedLocation = "";
                          setState(() {});
                        },
                      ),
                    ),
                ],
              ),
            ),

            // Results Header and View Toggle
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Text(
                    "${filteredVendors.length} vendors found",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  QButton(
                    icon: viewMode == "grid" ? Icons.list : Icons.grid_view,
                    size: bs.sm,
                    onPressed: () {
                      viewMode = viewMode == "grid" ? "list" : "grid";
                      setState(() {});
                    },
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    label: "Add Vendor",
                    icon: Icons.add,
                    size: bs.sm,
                    onPressed: _addVendor,
                  ),
                ],
              ),
            ),

            // Quick Actions
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
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Export List",
                          icon: Icons.download,
                          size: bs.sm,
                          onPressed: _exportVendors,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Import Vendors",
                          icon: Icons.upload,
                          size: bs.sm,
                          onPressed: _importVendors,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Vendor List/Grid
            if (filteredVendors.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No vendors found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Try adjusting your search criteria or add a new vendor",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledColor,
                      ),
                    ),
                    SizedBox(height: spMd),
                    QButton(
                      label: "Add New Vendor",
                      icon: Icons.add,
                      size: bs.sm,
                      onPressed: _addVendor,
                    ),
                  ],
                ),
              )
            else if (viewMode == "grid")
              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: filteredVendors.map((vendor) => _buildVendorCard(vendor)).toList(),
              )
            else
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: filteredVendors.map((vendor) => _buildVendorListItem(vendor)).toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
