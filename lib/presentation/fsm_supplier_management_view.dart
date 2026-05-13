import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmSupplierManagementView extends StatefulWidget {
  const FsmSupplierManagementView({super.key});

  @override
  State<FsmSupplierManagementView> createState() => _FsmSupplierManagementViewState();
}

class _FsmSupplierManagementViewState extends State<FsmSupplierManagementView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedStatus = "All";
  String sortBy = "Name";

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Electrical", "value": "Electrical"},
    {"label": "Mechanical", "value": "Mechanical"},
    {"label": "Hydraulic", "value": "Hydraulic"},
    {"label": "Safety", "value": "Safety"},
    {"label": "Tools", "value": "Tools"},
    {"label": "Consumables", "value": "Consumables"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "Preferred", "value": "Preferred"},
    {"label": "On Hold", "value": "On Hold"},
    {"label": "Inactive", "value": "Inactive"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Name", "value": "Name"},
    {"label": "Rating", "value": "Rating"},
    {"label": "Lead Time", "value": "Lead Time"},
    {"label": "Last Order", "value": "Last Order"},
  ];

  List<Map<String, dynamic>> suppliers = [
    {
      "id": "SUP001",
      "name": "Siemens AG",
      "category": "Electrical",
      "status": "Preferred",
      "rating": 4.8,
      "contactPerson": "Dr. Klaus Weber",
      "email": "k.weber@siemens.com",
      "phone": "+49-89-636-00",
      "address": "Wittelsbacherplatz 2, 80333 München, Germany",
      "website": "www.siemens.com",
      "avgLeadTime": 7,
      "lastOrderDate": "2025-06-15",
      "totalOrders": 45,
      "totalValue": 127500.00,
      "paymentTerms": "Net 30",
      "currency": "EUR",
      "certifications": ["ISO 9001", "ISO 14001"],
      "products": [
        "Variable Frequency Drives",
        "Circuit Breakers",
        "Control Systems",
        "Sensors"
      ],
      "notes": "Excellent quality and reliable delivery. Preferred supplier for electrical components.",
    },
    {
      "id": "SUP002",
      "name": "Parker Hannifin Corporation",
      "category": "Hydraulic",
      "status": "Active",
      "rating": 4.6,
      "contactPerson": "Tom Anderson",
      "email": "tom.anderson@parker.com",
      "phone": "+1-216-896-3000",
      "address": "6035 Parkland Blvd, Cleveland, OH 44124, USA",
      "website": "www.parker.com",
      "avgLeadTime": 10,
      "lastOrderDate": "2025-06-12",
      "totalOrders": 28,
      "totalValue": 89750.00,
      "paymentTerms": "Net 45",
      "currency": "USD",
      "certifications": ["ISO 9001", "AS9100"],
      "products": [
        "Hydraulic Pumps",
        "Valves",
        "Filters",
        "Hoses"
      ],
      "notes": "Specialized in hydraulic systems. Good technical support.",
    },
    {
      "id": "SUP003",
      "name": "SKF Group",
      "category": "Mechanical",
      "status": "Preferred",
      "rating": 4.7,
      "contactPerson": "Erik Lindström",
      "email": "erik.lindstrom@skf.com",
      "phone": "+46-31-337-1000",
      "address": "Hornsgatan 1, 415 50 Gothenburg, Sweden",
      "website": "www.skf.com",
      "avgLeadTime": 5,
      "lastOrderDate": "2025-06-10",
      "totalOrders": 62,
      "totalValue": 156200.00,
      "paymentTerms": "Net 30",
      "currency": "EUR",
      "certifications": ["ISO 9001", "ISO 14001", "OHSAS 18001"],
      "products": [
        "Ball Bearings",
        "Roller Bearings",
        "Seals",
        "Lubricants"
      ],
      "notes": "World leader in bearing technology. Excellent product quality and fast delivery.",
    },
    {
      "id": "SUP004",
      "name": "SafetyFirst Inc",
      "category": "Safety",
      "status": "Active",
      "rating": 4.2,
      "contactPerson": "Jennifer Martinez",
      "email": "j.martinez@safetyfirst.com",
      "phone": "+1-800-SAFETY-1",
      "address": "2500 Safety Blvd, Houston, TX 77001, USA",
      "website": "www.safetyfirst.com",
      "avgLeadTime": 3,
      "lastOrderDate": "2025-06-08",
      "totalOrders": 38,
      "totalValue": 45800.00,
      "paymentTerms": "Net 15",
      "currency": "USD",
      "certifications": ["ANSI Z87.1", "OSHA Compliant"],
      "products": [
        "Safety Helmets",
        "Safety Harnesses",
        "Protective Gloves",
        "Emergency Equipment"
      ],
      "notes": "Fast delivery for safety equipment. Good for emergency orders.",
    },
    {
      "id": "SUP005",
      "name": "Fluke Corporation",
      "category": "Tools",
      "status": "Preferred",
      "rating": 4.9,
      "contactPerson": "Michael Johnson",
      "email": "m.johnson@fluke.com",
      "phone": "+1-425-446-5500",
      "address": "6920 Seaway Blvd, Everett, WA 98203, USA",
      "website": "www.fluke.com",
      "avgLeadTime": 8,
      "lastOrderDate": "2025-06-05",
      "totalOrders": 25,
      "totalValue": 67500.00,
      "paymentTerms": "Net 30",
      "currency": "USD",
      "certifications": ["ISO 9001", "UL Listed"],
      "products": [
        "Digital Multimeters",
        "Thermal Imagers",
        "Power Quality Analyzers",
        "Calibrators"
      ],
      "notes": "Premium quality test equipment. Excellent accuracy and durability.",
    },
    {
      "id": "SUP006",
      "name": "Shell Lubricants",
      "category": "Consumables",
      "status": "On Hold",
      "rating": 3.8,
      "contactPerson": "Robert Brown",
      "email": "robert.brown@shell.com",
      "phone": "+44-20-7934-1234",
      "address": "Shell Centre, London SE1 7NA, UK",
      "website": "www.shell.com",
      "avgLeadTime": 14,
      "lastOrderDate": "2025-05-20",
      "totalOrders": 15,
      "totalValue": 28900.00,
      "paymentTerms": "Net 60",
      "currency": "GBP",
      "certifications": ["ISO 9001", "API Licensed"],
      "products": [
        "Industrial Lubricants",
        "Hydraulic Oils",
        "Greases",
        "Coolants"
      ],
      "notes": "Quality issues with recent shipments. Currently under review.",
    },
  ];

  List<Map<String, dynamic>> get filteredSuppliers {
    var filtered = suppliers.where((supplier) {
      bool matchesSearch = "${supplier["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${supplier["contactPerson"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || supplier["category"] == selectedCategory;
      bool matchesStatus = selectedStatus == "All" || supplier["status"] == selectedStatus;
      
      return matchesSearch && matchesCategory && matchesStatus;
    }).toList();

    // Sort the filtered results
    switch (sortBy) {
      case "Name":
        filtered.sort((a, b) => "${a["name"]}".compareTo("${b["name"]}"));
        break;
      case "Rating":
        filtered.sort((a, b) => (b["rating"] as double).compareTo(a["rating"] as double));
        break;
      case "Lead Time":
        filtered.sort((a, b) => (a["avgLeadTime"] as int).compareTo(b["avgLeadTime"] as int));
        break;
      case "Last Order":
        filtered.sort((a, b) => "${b["lastOrderDate"]}".compareTo("${a["lastOrderDate"]}"));
        break;
    }

    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Preferred":
        return successColor;
      case "Active":
        return infoColor;
      case "On Hold":
        return warningColor;
      case "Inactive":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildRatingStars(double rating) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < rating.floor() 
            ? Icons.star 
            : (index < rating ? Icons.star_half : Icons.star_border),
          color: warningColor,
          size: 16,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Supplier Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Add new supplier
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Show more options
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search and Filters
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search suppliers",
                          value: searchQuery,
                          hint: "Company name or contact person",
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
                          // Perform search
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Category",
                          items: categories,
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
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Summary Cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.business,
                            color: primaryColor,
                            size: 24,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Total Suppliers",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${suppliers.length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
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
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: successColor,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: successColor,
                            size: 24,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Preferred",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${suppliers.where((s) => s["status"] == "Preferred").length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: successColor,
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
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: warningColor,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.pause_circle,
                            color: warningColor,
                            size: 24,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "On Hold",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${suppliers.where((s) => s["status"] == "On Hold").length}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
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
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: infoColor,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.schedule,
                            color: infoColor,
                            size: 24,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Avg Lead Time",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${(suppliers.fold(0, (sum, s) => sum + (s["avgLeadTime"] as int)) / suppliers.length).round()} days",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),

            // Suppliers List
            Text(
              "Suppliers (${filteredSuppliers.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            ...filteredSuppliers.map((supplier) {
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
                      color: _getStatusColor("${supplier["status"]}"),
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${supplier["name"]}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${supplier["id"]} • ${supplier["category"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: _getStatusColor("${supplier["status"]}").withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${supplier["status"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _getStatusColor("${supplier["status"]}"),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),

                    // Rating and Lead Time
                    Row(
                      children: [
                        _buildRatingStars(supplier["rating"] as double),
                        SizedBox(width: spXs),
                        Text(
                          "${supplier["rating"]}/5",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.schedule,
                          size: 14,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${supplier["avgLeadTime"]} days",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),

                    // Contact Info
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Contact Person",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${supplier["contactPerson"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
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
                                "Phone",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${supplier["phone"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),

                    // Business Metrics
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total Orders",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${supplier["totalOrders"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
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
                                "Total Value",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "\$${(supplier["totalValue"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),

                    // Payment Terms and Last Order
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Payment Terms",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${supplier["paymentTerms"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
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
                                "Last Order",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${supplier["lastOrderDate"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),

                    // Products
                    Text(
                      "Products: ${(supplier["products"] as List).join(", ")}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),

                    // Certifications
                    Text(
                      "Certifications: ${(supplier["certifications"] as List).join(", ")}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),

                    if ("${supplier["notes"]}".isNotEmpty) ...[
                      SizedBox(height: spSm),
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: disabledColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${supplier["notes"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                    SizedBox(height: spSm),

                    // Actions
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "View Details",
                            size: bs.sm,
                            onPressed: () {
                              // View supplier details
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.email,
                          size: bs.sm,
                          onPressed: () {
                            // Send email
                          },
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.phone,
                          size: bs.sm,
                          onPressed: () {
                            // Make call
                          },
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.web,
                          size: bs.sm,
                          onPressed: () {
                            // Open website
                          },
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.edit,
                          size: bs.sm,
                          onPressed: () {
                            // Edit supplier
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new supplier
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
