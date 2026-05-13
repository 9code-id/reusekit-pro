import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsCustomerDatabaseView extends StatefulWidget {
  const RfsCustomerDatabaseView({super.key});

  @override
  State<RfsCustomerDatabaseView> createState() => _RfsCustomerDatabaseViewState();
}

class _RfsCustomerDatabaseViewState extends State<RfsCustomerDatabaseView> {
  int currentTab = 0;
  
  // Customer Database State
  String searchQuery = "";
  String selectedSegment = "all";
  String selectedTag = "";
  bool showActiveOnly = true;
  
  // Add Customer State
  String customerName = "";
  String customerEmail = "";
  String customerPhone = "";
  String customerBirthday = "";
  String customerAddress = "";
  String customerNotes = "";
  List<String> selectedTags = [];
  
  // Import State
  bool isImporting = false;
  String importFile = "";
  String importMapping = "auto";
  
  // Settings State
  bool autoTagging = true;
  bool duplicateDetection = true;
  bool birthdayReminders = true;
  String dataRetention = "2years";
  bool emailSync = false;
  
  final List<Map<String, dynamic>> customers = [
    {
      "id": "CUST001",
      "name": "Sarah Johnson",
      "email": "sarah.johnson@email.com",
      "phone": "+1 (555) 123-4567",
      "visits": 45,
      "totalSpent": 2250.75,
      "lastVisit": "2024-01-15",
      "birthday": "1985-06-15",
      "status": "VIP",
      "tags": ["Regular", "High Value"],
      "joinDate": "2023-01-20",
      "averageOrder": 50.02,
      "favoriteItems": ["Cappuccino", "Avocado Toast"],
      "address": "123 Main St, City, State 12345",
      "notes": "Prefers oat milk, usually orders for pickup"
    },
    {
      "id": "CUST002", 
      "name": "Michael Chen",
      "email": "m.chen@email.com",
      "phone": "+1 (555) 234-5678",
      "visits": 28,
      "totalSpent": 840.50,
      "lastVisit": "2024-01-14",
      "birthday": "1990-03-22",
      "status": "Regular",
      "tags": ["Lunch Regular", "Business"],
      "joinDate": "2023-05-10",
      "averageOrder": 30.02,
      "favoriteItems": ["Caesar Salad", "Iced Coffee"],
      "address": "456 Business Ave, City, State 12345",
      "notes": "Orders delivery for office meetings"
    },
    {
      "id": "CUST003",
      "name": "Emma Wilson",
      "email": "emma.w@email.com", 
      "phone": "+1 (555) 345-6789",
      "visits": 12,
      "totalSpent": 480.25,
      "lastVisit": "2024-01-13",
      "birthday": "1988-11-08",
      "status": "New",
      "tags": ["Weekend Visitor", "Family"],
      "joinDate": "2023-11-15",
      "averageOrder": 40.02,
      "favoriteItems": ["Pancakes", "Fresh Juice"],
      "address": "789 Family Lane, City, State 12345",
      "notes": "Usually comes with children on weekends"
    },
    {
      "id": "CUST004",
      "name": "David Rodriguez",
      "email": "d.rodriguez@email.com",
      "phone": "+1 (555) 456-7890",
      "visits": 67,
      "totalSpent": 3350.80,
      "lastVisit": "2024-01-16",
      "birthday": "1982-09-12",
      "status": "VIP",
      "tags": ["Daily Regular", "Coffee Lover"],
      "joinDate": "2022-08-05",
      "averageOrder": 50.01,
      "favoriteItems": ["Espresso", "Croissant"],
      "address": "321 Coffee St, City, State 12345",
      "notes": "Owns coffee shop, studies our menu"
    }
  ];
  
  final List<Map<String, dynamic>> customerSegments = [
    {"label": "All Customers", "value": "all", "count": 1250},
    {"label": "VIP Customers", "value": "vip", "count": 89},
    {"label": "Regular Customers", "value": "regular", "count": 456},
    {"label": "New Customers", "value": "new", "count": 234},
    {"label": "Inactive Customers", "value": "inactive", "count": 471}
  ];
  
  final List<Map<String, dynamic>> customerTags = [
    {"label": "All Tags", "value": ""},
    {"label": "Regular", "value": "regular"},
    {"label": "High Value", "value": "high_value"},
    {"label": "Business", "value": "business"},
    {"label": "Family", "value": "family"},
    {"label": "Coffee Lover", "value": "coffee_lover"},
    {"label": "Weekend Visitor", "value": "weekend"}
  ];
  
  final List<Map<String, dynamic>> tagOptions = [
    {"label": "Regular Customer", "value": "regular", "checked": false},
    {"label": "High Value", "value": "high_value", "checked": false},
    {"label": "Business Customer", "value": "business", "checked": false},
    {"label": "Family Customer", "value": "family", "checked": false},
    {"label": "Coffee Lover", "value": "coffee_lover", "checked": false},
    {"label": "Weekend Visitor", "value": "weekend", "checked": false},
    {"label": "Lunch Regular", "value": "lunch", "checked": false},
    {"label": "Breakfast Regular", "value": "breakfast", "checked": false}
  ];
  
  final List<Map<String, dynamic>> retentionOptions = [
    {"label": "1 Year", "value": "1year"},
    {"label": "2 Years", "value": "2years"},
    {"label": "5 Years", "value": "5years"},
    {"label": "Forever", "value": "forever"}
  ];
  
  final List<Map<String, dynamic>> mappingOptions = [
    {"label": "Auto-detect", "value": "auto"},
    {"label": "Manual mapping", "value": "manual"},
    {"label": "Use template", "value": "template"}
  ];

  List<Map<String, dynamic>> get filteredCustomers {
    var filtered = customers.where((customer) {
      bool matchesSearch = searchQuery.isEmpty ||
          (customer["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (customer["email"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (customer["phone"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesSegment = selectedSegment == "all" ||
          (customer["status"] as String).toLowerCase() == selectedSegment;
      
      bool matchesTag = selectedTag.isEmpty ||
          (customer["tags"] as List).any((tag) => 
              tag.toLowerCase().contains(selectedTag.toLowerCase()));
      
      return matchesSearch && matchesSegment && matchesTag;
    }).toList();
    
    if (showActiveOnly) {
      filtered = filtered.where((customer) => 
          (customer["status"] as String) != "Inactive").toList();
    }
    
    return filtered;
  }

  void _addCustomer() {
    if (customerName.isEmpty || customerEmail.isEmpty) {
      se("Please fill in required fields");
      return;
    }
    
    ss("Customer added successfully");
    
    // Reset form
    customerName = "";
    customerEmail = "";
    customerPhone = "";
    customerBirthday = "";
    customerAddress = "";
    customerNotes = "";
    selectedTags = [];
    setState(() {});
  }
  
  void _exportCustomers() {
    ss("Customer database exported successfully");
  }
  
  void _importCustomers() async {
    if (importFile.isEmpty) {
      se("Please select a file to import");
      return;
    }
    
    isImporting = true;
    setState(() {});
    
    await Future.delayed(Duration(seconds: 2));
    
    isImporting = false;
    setState(() {});
    
    ss("Customers imported successfully");
  }
  
  void _saveSettings() {
    ss("Settings saved successfully");
  }

  Widget _buildCustomerDatabase() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Search and Filters
          Row(
            children: [
              Expanded(
                flex: 2,
                child: QTextField(
                  label: "Search Customers",
                  value: searchQuery,
                  hint: "Name, email, or phone",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Segment",
                  items: customerSegments,
                  value: selectedSegment,
                  onChanged: (value, label) {
                    selectedSegment = value;
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
                  label: "Filter by Tag",
                  items: customerTags,
                  value: selectedTag,
                  onChanged: (value, label) {
                    selectedTag = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QSwitch(
                  label: "Active Only",
                  items: [
                    {
                      "label": "Show active customers only",
                      "value": true,
                      "checked": showActiveOnly,
                    }
                  ],
                  value: [if (showActiveOnly) {"label": "Show active customers only", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    showActiveOnly = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          
          // Summary Cards
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 150,
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(Icons.people, color: primaryColor, size: 24),
                    SizedBox(height: spXs),
                    Text(
                      "${filteredCustomers.length}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Total Customers",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(Icons.star, color: warningColor, size: 24),
                    SizedBox(height: spXs),
                    Text(
                      "89",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "VIP Customers",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(Icons.trending_up, color: successColor, size: 24),
                    SizedBox(height: spXs),
                    Text(
                      "15%",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Growth Rate",
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
          
          // Actions
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Export Database",
                  icon: Icons.download,
                  size: bs.sm,
                  onPressed: _exportCustomers,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Add Customer",
                  icon: Icons.person_add,
                  size: bs.sm,
                  onPressed: () {
                    currentTab = 1;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          
          // Customer List
          ...filteredCustomers.map((customer) {
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
                spacing: spXs,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${customer["name"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: (customer["status"] as String) == "VIP" ? warningColor : 
                                 (customer["status"] as String) == "Regular" ? successColor : infoColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${customer["status"]}",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Icon(Icons.email, size: 14, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "${customer["email"]}",
                        style: TextStyle(fontSize: 12, color: disabledBoldColor),
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Icon(Icons.phone, size: 14, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "${customer["phone"]}",
                        style: TextStyle(fontSize: 12, color: disabledBoldColor),
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${customer["visits"]} visits • \$${(customer["totalSpent"] as double).currency}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Text(
                        "Last: ${customer["lastVisit"]}",
                        style: TextStyle(fontSize: 11, color: disabledBoldColor),
                      ),
                    ],
                  ),
                  
                  if ((customer["tags"] as List).isNotEmpty)
                    Wrap(
                      spacing: spXs,
                      children: (customer["tags"] as List).map((tag) => Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
                        decoration: BoxDecoration(
                          color: secondaryColor.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "$tag",
                          style: TextStyle(
                            fontSize: 10,
                            color: secondaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )).toList(),
                    ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildAddCustomer() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: infoColor.withAlpha(50)),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: infoColor, size: 20),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Add new customers to your database with detailed information for better service.",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Basic Information
          Container(
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
                Text(
                  "Basic Information",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                QTextField(
                  label: "Full Name *",
                  value: customerName,
                  hint: "Enter customer's full name",
                  onChanged: (value) {
                    customerName = value;
                    setState(() {});
                  },
                ),
                
                QTextField(
                  label: "Email Address *",
                  value: customerEmail,
                  hint: "customer@email.com",
                  onChanged: (value) {
                    customerEmail = value;
                    setState(() {});
                  },
                ),
                
                QTextField(
                  label: "Phone Number",
                  value: customerPhone,
                  hint: "+1 (555) 123-4567",
                  onChanged: (value) {
                    customerPhone = value;
                    setState(() {});
                  },
                ),
                
                QDatePicker(
                  label: "Birthday",
                  value: customerBirthday.isNotEmpty ? DateTime.parse(customerBirthday) : null,
                  onChanged: (value) {
                    customerBirthday = value.toIso8601String() ?? "";
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          
          // Additional Information
          Container(
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
                Text(
                  "Additional Information",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                QTextField(
                  label: "Address",
                  value: customerAddress,
                  hint: "Enter customer's address",
                  onChanged: (value) {
                    customerAddress = value;
                    setState(() {});
                  },
                ),
                
                QMemoField(
                  label: "Notes",
                  value: customerNotes,
                  hint: "Any special notes about the customer",
                  onChanged: (value) {
                    customerNotes = value;
                    setState(() {});
                  },
                ),
                
                QSwitch(
                  label: "Customer Tags",
                  items: tagOptions,
                  value: tagOptions.where((tag) => selectedTags.contains(tag["value"])).map((tag) => {
                    "label": tag["label"],
                    "value": tag["value"],
                    "checked": true,
                  }).toList(),
                  onChanged: (values, ids) {
                    selectedTags = values.map((v) => v["value"] as String).toList();
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          
          // Actions
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Cancel",
                  size: bs.sm,
                  onPressed: () {
                    currentTab = 0;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Add Customer",
                  size: bs.sm,
                  onPressed: _addCustomer,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImportExport() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Export Section
          Container(
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
                    Icon(Icons.download, color: successColor, size: 20),
                    SizedBox(width: spSm),
                    Text(
                      "Export Customer Database",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                
                Text(
                  "Export your customer database to CSV, Excel, or JSON format for backup or analysis.",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Export as CSV",
                        icon: Icons.table_chart,
                        size: bs.sm,
                        onPressed: _exportCustomers,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Export as Excel",
                        icon: Icons.description,
                        size: bs.sm,
                        onPressed: _exportCustomers,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Import Section
          Container(
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
                    Icon(Icons.upload, color: warningColor, size: 20),
                    SizedBox(width: spSm),
                    Text(
                      "Import Customer Database",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: warningColor.withAlpha(50)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.warning, color: warningColor, size: 16),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "Importing will merge with existing data. Duplicates will be detected.",
                          style: TextStyle(
                            fontSize: 11,
                            color: warningColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                QAttachmentPicker(
                  label: "Select Import File",
                  value: importFile.isNotEmpty ? [importFile] : [],
                  hint: "Choose CSV, Excel, or JSON file",
                  onChanged: (value) {
                    importFile = value.isNotEmpty ? value.first : "";
                    setState(() {});
                  },
                ),
                
                QDropdownField(
                  label: "Field Mapping",
                  items: mappingOptions,
                  value: importMapping,
                  onChanged: (value, label) {
                    importMapping = value;
                    setState(() {});
                  },
                ),
                
                QButton(
                  label: isImporting ? "Importing..." : "Import Customers",
                  icon: isImporting ? Icons.sync : Icons.upload,
                  size: bs.md,
                  onPressed: isImporting ? null : _importCustomers,
                ),
              ],
            ),
          ),
          
          // Backup History
          Container(
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
                Text(
                  "Recent Exports",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                ...[
                  {"file": "customers_2024_01_15.csv", "date": "Jan 15, 2024", "size": "2.4 MB", "records": 1250},
                  {"file": "vip_customers_2024_01_10.xlsx", "date": "Jan 10, 2024", "size": "856 KB", "records": 89},
                  {"file": "customer_backup_2024_01_01.json", "date": "Jan 1, 2024", "size": "3.1 MB", "records": 1180}
                ].map((export) => Container(
                  padding: EdgeInsets.all(spSm),
                  margin: EdgeInsets.only(bottom: spXs),
                  decoration: BoxDecoration(
                    color: secondaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.file_download, color: successColor, size: 16),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${export["file"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${export["date"]} • ${export["size"]} • ${export["records"]} records",
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
                )).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettings() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Data Management
          Container(
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
                Text(
                  "Data Management",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                QSwitch(
                  label: "Auto-tagging",
                  items: [
                    {
                      "label": "Automatically tag customers based on behavior",
                      "value": true,
                      "checked": autoTagging,
                    }
                  ],
                  value: [if (autoTagging) {"label": "Automatically tag customers based on behavior", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    autoTagging = values.isNotEmpty;
                    setState(() {});
                  },
                ),
                
                QSwitch(
                  label: "Duplicate Detection",
                  items: [
                    {
                      "label": "Detect and merge duplicate customer records",
                      "value": true,
                      "checked": duplicateDetection,
                    }
                  ],
                  value: [if (duplicateDetection) {"label": "Detect and merge duplicate customer records", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    duplicateDetection = values.isNotEmpty;
                    setState(() {});
                  },
                ),
                
                QDropdownField(
                  label: "Data Retention",
                  items: retentionOptions,
                  value: dataRetention,
                  onChanged: (value, label) {
                    dataRetention = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          
          // Notifications
          Container(
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
                Text(
                  "Customer Notifications",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                QSwitch(
                  label: "Birthday Reminders",
                  items: [
                    {
                      "label": "Send birthday wishes and special offers",
                      "value": true,
                      "checked": birthdayReminders,
                    }
                  ],
                  value: [if (birthdayReminders) {"label": "Send birthday wishes and special offers", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    birthdayReminders = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          
          // Integration
          Container(
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
                Text(
                  "External Integration",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                QSwitch(
                  label: "Email Sync",
                  items: [
                    {
                      "label": "Sync with email marketing platforms",
                      "value": true,
                      "checked": emailSync,
                    }
                  ],
                  value: [if (emailSync) {"label": "Sync with email marketing platforms", "value": true, "checked": true}],
                  onChanged: (values, ids) {
                    emailSync = values.isNotEmpty;
                    setState(() {});
                  },
                ),
                
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: infoColor.withAlpha(50)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info, color: infoColor, size: 16),
                      SizedBox(width: spXs),
                      Expanded(
                        child: Text(
                          "Connect with Mailchimp, Constant Contact, or other email platforms to sync customer data.",
                          style: TextStyle(
                            fontSize: 11,
                            color: infoColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Database Statistics
          Container(
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
                Text(
                  "Database Statistics",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 120,
                  children: [
                    {
                      "title": "Total Records",
                      "value": "1,250",
                      "icon": Icons.people,
                      "color": primaryColor
                    },
                    {
                      "title": "Active Customers", 
                      "value": "779",
                      "icon": Icons.person_pin,
                      "color": successColor
                    },
                    {
                      "title": "Database Size",
                      "value": "15.2 MB",
                      "icon": Icons.storage,
                      "color": infoColor
                    },
                    {
                      "title": "Last Backup",
                      "value": "Jan 15",
                      "icon": Icons.backup,
                      "color": warningColor
                    }
                  ].map((stat) => Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: (stat["color"] as Color).withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          stat["icon"] as IconData,
                          color: stat["color"] as Color,
                          size: 20,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${stat["value"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${stat["title"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )).toList(),
                ),
              ],
            ),
          ),
          
          // Save Settings
          Container(
            width: double.infinity,
            child: QButton(
              label: "Save Settings",
              size: bs.md,
              onPressed: _saveSettings,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Customer Database",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Database", icon: Icon(Icons.people)),
        Tab(text: "Add Customer", icon: Icon(Icons.person_add)),
        Tab(text: "Import/Export", icon: Icon(Icons.import_export)),
        Tab(text: "Settings", icon: Icon(Icons.settings)),
      ],
      tabChildren: [
        _buildCustomerDatabase(),
        _buildAddCustomer(),
        _buildImportExport(),
        _buildSettings(),
      ],
    );
  }
}
