import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ImaSupplierContactView extends StatefulWidget {
  const ImaSupplierContactView({super.key});

  @override
  State<ImaSupplierContactView> createState() => _ImaSupplierContactViewState();
}

class _ImaSupplierContactViewState extends State<ImaSupplierContactView> {
  String searchQuery = "";
  String selectedStatus = "";
  String selectedType = "";
  String selectedCategory = "";
  
  List<Map<String, dynamic>> suppliers = [
    {
      "id": "SUP001",
      "name": "Global Electronics Supply Co.",
      "code": "GESC",
      "contactPerson": "John Anderson",
      "email": "john.anderson@globalsupply.com",
      "phone": "+1 (555) 0123",
      "address": "1234 Industrial Blvd, Tech City, TC 12345",
      "status": "Active",
      "type": "Premium",
      "category": "Electronics",
      "rating": 4.8,
      "lastContact": "2024-12-15",
      "responseTime": "2.3 hours",
      "preferredContact": "Email",
    },
    {
      "id": "SUP002",
      "name": "Advanced Components Inc.",
      "code": "ACI",
      "contactPerson": "Sarah Wilson",
      "email": "sarah.wilson@advancedcomp.com",
      "phone": "+1 (555) 0124",
      "address": "5678 Component Ave, Silicon Valley, SV 54321",
      "status": "Active",
      "type": "Standard",
      "category": "Components",
      "rating": 4.5,
      "lastContact": "2024-12-14",
      "responseTime": "4.1 hours",
      "preferredContact": "Phone",
    },
    {
      "id": "SUP003",
      "name": "Industrial Materials Corp.",
      "code": "IMC",
      "contactPerson": "Michael Chen",
      "email": "michael.chen@indmaterials.com",
      "phone": "+1 (555) 0125",
      "address": "9012 Materials St, Industrial Park, IP 98765",
      "status": "Active",
      "type": "Strategic",
      "category": "Raw Materials",
      "rating": 4.7,
      "lastContact": "2024-12-13",
      "responseTime": "1.8 hours",
      "preferredContact": "Email",
    },
    {
      "id": "SUP004",
      "name": "Quick Delivery Services",
      "code": "QDS",
      "contactPerson": "Emma Davis",
      "email": "emma.davis@quickdelivery.com",
      "phone": "+1 (555) 0126",
      "address": "3456 Express Lane, Logistics Hub, LH 13579",
      "status": "Inactive",
      "type": "Emergency",
      "category": "Packaging",
      "rating": 4.2,
      "lastContact": "2024-11-28",
      "responseTime": "6.2 hours",
      "preferredContact": "Phone",
    },
    {
      "id": "SUP005",
      "name": "Office Solutions Plus",
      "code": "OSP",
      "contactPerson": "Robert Johnson",
      "email": "robert.johnson@officesolutions.com",
      "phone": "+1 (555) 0127",
      "address": "7890 Office Park Dr, Business District, BD 24680",
      "status": "Active",
      "type": "Standard",
      "category": "Office Supplies",
      "rating": 4.3,
      "lastContact": "2024-12-12",
      "responseTime": "3.5 hours",
      "preferredContact": "Email",
    },
  ];
  
  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": ""},
    {"label": "Active", "value": "Active"},
    {"label": "Inactive", "value": "Inactive"},
    {"label": "Suspended", "value": "Suspended"},
  ];
  
  List<Map<String, dynamic>> typeOptions = [
    {"label": "All Types", "value": ""},
    {"label": "Premium", "value": "Premium"},
    {"label": "Standard", "value": "Standard"},
    {"label": "Strategic", "value": "Strategic"},
    {"label": "Emergency", "value": "Emergency"},
  ];
  
  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": ""},
    {"label": "Electronics", "value": "Electronics"},
    {"label": "Components", "value": "Components"},
    {"label": "Raw Materials", "value": "Raw Materials"},
    {"label": "Packaging", "value": "Packaging"},
    {"label": "Office Supplies", "value": "Office Supplies"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Supplier Contacts"),
        actions: [
          IconButton(
            onPressed: () {
              _showContactOptions();
            },
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchAndFilter(),
          _buildQuickStats(),
          Expanded(
            child: _buildSupplierList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // navigateTo(ImaAddSupplierView());
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search suppliers...",
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
                onPressed: () {
                  _performSearch();
                },
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: statusOptions,
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
                    _applyFilters();
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Type",
                  items: typeOptions,
                  value: selectedType,
                  onChanged: (value, label) {
                    selectedType = value;
                    _applyFilters();
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: categoryOptions,
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    _applyFilters();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    int totalSuppliers = suppliers.length;
    int activeSuppliers = suppliers.where((s) => s["status"] == "Active").length;
    int premiumSuppliers = suppliers.where((s) => s["type"] == "Premium").length;
    double avgRating = suppliers.fold(0.0, (sum, s) => sum + (s["rating"] as double)) / suppliers.length;

    return Container(
      padding: EdgeInsets.all(spMd),
      child: Row(
        children: [
          _buildStatCard("Total", "$totalSuppliers", Icons.business, primaryColor),
          SizedBox(width: spSm),
          _buildStatCard("Active", "$activeSuppliers", Icons.check_circle, successColor),
          SizedBox(width: spSm),
          _buildStatCard("Premium", "$premiumSuppliers", Icons.star, warningColor),
          SizedBox(width: spSm),
          _buildStatCard("Avg Rating", "${avgRating.toStringAsFixed(1)}", Icons.grade, infoColor),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            SizedBox(height: spXs),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSupplierList() {
    List<Map<String, dynamic>> filteredSuppliers = _getFilteredSuppliers();
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spMd),
      child: ListView.builder(
        itemCount: filteredSuppliers.length,
        itemBuilder: (context, index) {
          final supplier = filteredSuppliers[index];
          return _buildSupplierCard(supplier);
        },
      ),
    );
  }

  Widget _buildSupplierCard(Map<String, dynamic> supplier) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
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
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: _getTypeColor(supplier["type"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(
                  Icons.business,
                  color: _getTypeColor(supplier["type"]),
                  size: 24,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${supplier["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: _getStatusColor(supplier["status"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${supplier["status"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: _getStatusColor(supplier["status"]),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${supplier["code"]} • ${supplier["category"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              children: [
                _buildContactRow(Icons.person, "Contact", "${supplier["contactPerson"]}"),
                _buildContactRow(Icons.email, "Email", "${supplier["email"]}"),
                _buildContactRow(Icons.phone, "Phone", "${supplier["phone"]}"),
                _buildContactRow(Icons.location_on, "Address", "${supplier["address"]}"),
              ],
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star, color: successColor, size: 12),
                    SizedBox(width: spXs),
                    Text(
                      "${supplier["rating"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spSm),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "Response: ${supplier["responseTime"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: infoColor,
                  ),
                ),
              ),
              Spacer(),
              Text(
                "Last: ${DateTime.parse(supplier["lastContact"]).dMMMy}",
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Call",
                  icon: Icons.phone,
                  size: bs.sm,
                  onPressed: () {
                    _makeCall(supplier["phone"]);
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Email",
                  icon: Icons.email,
                  size: bs.sm,
                  onPressed: () {
                    _sendEmail(supplier["email"]);
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Details",
                  icon: Icons.info,
                  size: bs.sm,
                  onPressed: () {
                    // navigateTo(ImaSupplierDetailView());
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String label, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Icon(icon, color: disabledBoldColor, size: 16),
          SizedBox(width: spSm),
          SizedBox(
            width: 60,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ),
          Text(": ", style: TextStyle(color: disabledBoldColor, fontSize: 12)),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredSuppliers() {
    List<Map<String, dynamic>> filtered = suppliers;
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((supplier) {
        return supplier["name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               supplier["code"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
               supplier["contactPerson"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }
    
    if (selectedStatus.isNotEmpty) {
      filtered = filtered.where((supplier) => supplier["status"] == selectedStatus).toList();
    }
    
    if (selectedType.isNotEmpty) {
      filtered = filtered.where((supplier) => supplier["type"] == selectedType).toList();
    }
    
    if (selectedCategory.isNotEmpty) {
      filtered = filtered.where((supplier) => supplier["category"] == selectedCategory).toList();
    }
    
    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return successColor;
      case 'inactive':
        return dangerColor;
      case 'suspended':
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'premium':
        return warningColor;
      case 'strategic':
        return primaryColor;
      case 'emergency':
        return dangerColor;
      default:
        return infoColor;
    }
  }

  void _performSearch() {
    setState(() {});
  }

  void _applyFilters() {
    setState(() {});
  }

  void _makeCall(String phoneNumber) {
    si("Calling $phoneNumber...");
  }

  void _sendEmail(String email) {
    si("Opening email to $email...");
  }

  void _showContactOptions() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: disabledColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
              SizedBox(height: spMd),
              Text(
                "Contact Options",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              _buildActionItem(Icons.add, "Add New Supplier", () {}),
              _buildActionItem(Icons.import_export, "Import Contacts", () {}),
              _buildActionItem(Icons.file_download, "Export Contact List", () {}),
              _buildActionItem(Icons.group, "Bulk Email", () {}),
              _buildActionItem(Icons.phone_callback, "Schedule Calls", () {}),
              SizedBox(height: spMd),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActionItem(IconData icon, String title, VoidCallback onTap) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
              color: primaryColor,
              size: 20,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
                onTap();
              },
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
