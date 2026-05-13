import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaSupplierManagementView extends StatefulWidget {
  const ComaSupplierManagementView({super.key});

  @override
  State<ComaSupplierManagementView> createState() => _ComaSupplierManagementViewState();
}

class _ComaSupplierManagementViewState extends State<ComaSupplierManagementView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedStatus = "All";
  String selectedRating = "All";

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All", "value": "All"},
    {"label": "Construction Materials", "value": "Construction Materials"},
    {"label": "Steel & Metal", "value": "Steel & Metal"},
    {"label": "Concrete & Cement", "value": "Concrete & Cement"},
    {"label": "Timber & Wood", "value": "Timber & Wood"},
    {"label": "Paint & Coating", "value": "Paint & Coating"},
    {"label": "Tools & Equipment", "value": "Tools & Equipment"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "Inactive", "value": "Inactive"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Blacklisted", "value": "Blacklisted"},
  ];

  List<Map<String, dynamic>> ratingOptions = [
    {"label": "All", "value": "All"},
    {"label": "5 Stars", "value": "5"},
    {"label": "4+ Stars", "value": "4"},
    {"label": "3+ Stars", "value": "3"},
    {"label": "Below 3", "value": "2"},
  ];

  List<Map<String, dynamic>> suppliers = [
    {
      "id": "SUP001",
      "name": "BuildMart Supply",
      "category": "Construction Materials",
      "contactPerson": "John Anderson",
      "email": "john@buildmart.com",
      "phone": "+1-555-0100",
      "address": "123 Industrial Ave, Construction City, CC 12345",
      "website": "www.buildmart.com",
      "rating": 4.8,
      "totalOrders": 145,
      "totalValue": 250000.00,
      "status": "Active",
      "joinDate": "2022-03-15",
      "lastOrderDate": "2024-06-18",
      "paymentTerms": "Net 30",
      "deliveryTime": "2-3 days",
      "specialties": ["Cement", "Aggregates", "Building Materials"],
      "certifications": ["ISO 9001", "CE Marking"],
      "notes": "Reliable supplier with excellent quality materials",
      "image": "https://picsum.photos/120/120?random=41&keyword=building"
    },
    {
      "id": "SUP002",
      "name": "Metal Works Ltd",
      "category": "Steel & Metal",
      "contactPerson": "Sarah Johnson",
      "email": "sarah@metalworks.com",
      "phone": "+1-555-0101",
      "address": "456 Steel Road, Metal District, MD 67890",
      "website": "www.metalworks.com",
      "rating": 4.5,
      "totalOrders": 89,
      "totalValue": 180000.00,
      "status": "Active",
      "joinDate": "2021-11-20",
      "lastOrderDate": "2024-06-17",
      "paymentTerms": "Net 45",
      "deliveryTime": "5-7 days",
      "specialties": ["Steel Bars", "Metal Sheets", "Structural Steel"],
      "certifications": ["ASTM", "ISO 14001"],
      "notes": "Specialized in high-quality steel products",
      "image": "https://picsum.photos/120/120?random=42&keyword=steel"
    },
    {
      "id": "SUP003",
      "name": "Sand & Gravel Co",
      "category": "Construction Materials",
      "contactPerson": "Mike Brown",
      "email": "mike@sandgravel.com",
      "phone": "+1-555-0102",
      "address": "789 Quarry Lane, Stone Valley, SV 13579",
      "website": "www.sandgravel.com",
      "rating": 4.2,
      "totalOrders": 67,
      "totalValue": 95000.00,
      "status": "Active",
      "joinDate": "2023-01-10",
      "lastOrderDate": "2024-06-16",
      "paymentTerms": "Net 15",
      "deliveryTime": "1-2 days",
      "specialties": ["River Sand", "Crushed Stone", "Gravel"],
      "certifications": ["Environmental Permit"],
      "notes": "Local supplier with quick delivery times",
      "image": "https://picsum.photos/120/120?random=43&keyword=sand"
    },
    {
      "id": "SUP004",
      "name": "Brick Manufacturing",
      "category": "Construction Materials",
      "contactPerson": "Lisa Wilson",
      "email": "lisa@brickmanufacturing.com",
      "phone": "+1-555-0103",
      "address": "321 Brick Street, Clay Town, CT 24680",
      "website": "www.brickmanufacturing.com",
      "rating": 3.8,
      "totalOrders": 45,
      "totalValue": 72000.00,
      "status": "Pending",
      "joinDate": "2023-08-05",
      "lastOrderDate": "2024-06-15",
      "paymentTerms": "COD",
      "deliveryTime": "7-10 days",
      "specialties": ["Clay Bricks", "Fire Bricks", "Decorative Bricks"],
      "certifications": ["Quality Assurance"],
      "notes": "New supplier undergoing evaluation",
      "image": "https://picsum.photos/120/120?random=44&keyword=bricks"
    },
    {
      "id": "SUP005",
      "name": "Timber Merchants",
      "category": "Timber & Wood",
      "contactPerson": "David Davis",
      "email": "david@timbermerchants.com",
      "phone": "+1-555-0104",
      "address": "654 Forest Road, Wood Grove, WG 97531",
      "website": "www.timbermerchants.com",
      "rating": 4.6,
      "totalOrders": 78,
      "totalValue": 140000.00,
      "status": "Active",
      "joinDate": "2022-07-12",
      "lastOrderDate": "2024-06-18",
      "paymentTerms": "Net 30",
      "deliveryTime": "3-5 days",
      "specialties": ["Pine Timber", "Oak Wood", "Plywood"],
      "certifications": ["FSC Certified", "PEFC Chain of Custody"],
      "notes": "Sustainable timber supplier with forest certification",
      "image": "https://picsum.photos/120/120?random=45&keyword=wood"
    },
    {
      "id": "SUP006",
      "name": "Paint Store",
      "category": "Paint & Coating",
      "contactPerson": "Emma Thompson",
      "email": "emma@paintstore.com",
      "phone": "+1-555-0105",
      "address": "987 Color Avenue, Paint City, PC 86420",
      "website": "www.paintstore.com",
      "rating": 4.1,
      "totalOrders": 52,
      "totalValue": 65000.00,
      "status": "Active",
      "joinDate": "2023-02-28",
      "lastOrderDate": "2024-06-14",
      "paymentTerms": "Net 20",
      "deliveryTime": "2-4 days",
      "specialties": ["Exterior Paint", "Interior Paint", "Primers"],
      "certifications": ["Low VOC", "Green Seal"],
      "notes": "Wide range of eco-friendly paint products",
      "image": "https://picsum.photos/120/120?random=46&keyword=paint"
    },
  ];

  List<Map<String, dynamic>> get filteredSuppliers {
    return suppliers.where((supplier) {
      bool matchesSearch = searchQuery.isEmpty ||
          (supplier["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (supplier["contactPerson"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (supplier["email"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (supplier["id"] as String).toLowerCase().contains(searchQuery.toLowerCase());

      bool matchesCategory = selectedCategory == "All" || supplier["category"] == selectedCategory;
      bool matchesStatus = selectedStatus == "All" || supplier["status"] == selectedStatus;
      
      bool matchesRating = selectedRating == "All" || 
          (selectedRating == "5" && (supplier["rating"] as double) >= 4.8) ||
          (selectedRating == "4" && (supplier["rating"] as double) >= 4.0) ||
          (selectedRating == "3" && (supplier["rating"] as double) >= 3.0) ||
          (selectedRating == "2" && (supplier["rating"] as double) < 3.0);

      return matchesSearch && matchesCategory && matchesStatus && matchesRating;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Inactive":
        return disabledColor;
      case "Pending":
        return warningColor;
      case "Blacklisted":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  Widget _buildRatingStars(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating.floor() ? Icons.star : 
          index < rating ? Icons.star_half : Icons.star_border,
          size: 14,
          color: warningColor,
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
              //navigateTo('add_supplier')
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterDialog();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search Bar
            QTextField(
              label: "Search suppliers...",
              value: searchQuery,
              hint: "Enter supplier name, contact person, or email",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),

            // Summary Cards
            Row(
              children: [
                Expanded(
                  child: _buildSummaryCard(
                    "Total Suppliers",
                    "${suppliers.length}",
                    Icons.business,
                    primaryColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildSummaryCard(
                    "Active",
                    "${suppliers.where((s) => s["status"] == "Active").length}",
                    Icons.check_circle,
                    successColor,
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Expanded(
                  child: _buildSummaryCard(
                    "Total Orders",
                    "${suppliers.fold(0, (sum, item) => sum + (item["totalOrders"] as int))}",
                    Icons.shopping_cart,
                    infoColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildSummaryCard(
                    "Total Value",
                    "\$${(suppliers.fold(0.0, (sum, item) => sum + (item["totalValue"] as double))).currency}",
                    Icons.attach_money,
                    successColor,
                  ),
                ),
              ],
            ),

            // Quick Filters
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: spSm,
                children: [
                  _buildQuickFilter("All", selectedStatus == "All"),
                  _buildQuickFilter("Active", selectedStatus == "Active"),
                  _buildQuickFilter("Pending", selectedStatus == "Pending"),
                  _buildQuickFilter("4+ Stars", selectedRating == "4"),
                  _buildQuickFilter("Construction", selectedCategory == "Construction Materials"),
                ],
              ),
            ),

            // Suppliers List
            Column(
              spacing: spSm,
              children: filteredSuppliers.map((supplier) {
                return _buildSupplierCard(supplier);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
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
              Icon(
                icon,
                color: color,
                size: 20,
              ),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickFilter(String label, bool isActive) {
    return GestureDetector(
      onTap: () {
        if (label == "All") {
          selectedStatus = "All";
          selectedRating = "All";
          selectedCategory = "All";
        } else if (label == "Active" || label == "Pending") {
          selectedStatus = label;
        } else if (label == "4+ Stars") {
          selectedRating = "4";
        } else if (label == "Construction") {
          selectedCategory = "Construction Materials";
        }
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
        decoration: BoxDecoration(
          color: isActive ? primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: isActive ? primaryColor : disabledOutlineBorderColor,
          ),
          boxShadow: [shadowSm],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : disabledBoldColor,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildSupplierCard(Map<String, dynamic> supplier) {
    Color statusColor = _getStatusColor(supplier["status"] as String);
    double rating = supplier["rating"] as double;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          // Header
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${supplier["image"]}",
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${supplier["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
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
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        _buildRatingStars(rating),
                        SizedBox(width: spXs),
                        Text(
                          "$rating",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${supplier["status"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: statusColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${supplier["totalOrders"]} orders",
                    style: TextStyle(
                      fontSize: 10,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Contact Information
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.circular(radiusSm),
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
                    Expanded(
                      child: Text(
                        "${supplier["contactPerson"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        //callPhone(supplier["phone"])
                      },
                      child: Icon(
                        Icons.phone,
                        size: 16,
                        color: successColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    GestureDetector(
                      onTap: () {
                        //sendEmail(supplier["email"])
                      },
                      child: Icon(
                        Icons.email,
                        size: 16,
                        color: infoColor,
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
                    Expanded(
                      child: Text(
                        "${supplier["address"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Business Details
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
                    SizedBox(height: spXs),
                    Text(
                      "${supplier["paymentTerms"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
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
                      "Delivery Time",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${supplier["deliveryTime"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Total Value",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "\$${(supplier["totalValue"] as double).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Specialties
          if ((supplier["specialties"] as List).isNotEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Specialties",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Wrap(
                    spacing: spXs,
                    runSpacing: spXs,
                    children: (supplier["specialties"] as List).map((specialty) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "$specialty",
                          style: TextStyle(
                            fontSize: 10,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

          // Certifications
          if ((supplier["certifications"] as List).isNotEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Certifications",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Wrap(
                    spacing: spXs,
                    runSpacing: spXs,
                    children: (supplier["certifications"] as List).map((cert) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "$cert",
                          style: TextStyle(
                            fontSize: 10,
                            color: successColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

          // Notes
          if (supplier["notes"] != null && (supplier["notes"] as String).isNotEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(10),
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

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo('supplier_details')
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Create Order",
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo('create_order')
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Filter Suppliers"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              QDropdownField(
                label: "Category",
                items: categoryOptions,
                value: selectedCategory,
                onChanged: (value, label) {
                  selectedCategory = value;
                  setState(() {});
                },
              ),
              QDropdownField(
                label: "Status",
                items: statusOptions,
                value: selectedStatus,
                onChanged: (value, label) {
                  selectedStatus = value;
                  setState(() {});
                },
              ),
              QDropdownField(
                label: "Rating",
                items: ratingOptions,
                value: selectedRating,
                onChanged: (value, label) {
                  selectedRating = value;
                  setState(() {});
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                selectedCategory = "All";
                selectedStatus = "All";
                selectedRating = "All";
                setState(() {});
                Navigator.pop(context);
              },
              child: Text("Clear"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Apply"),
            ),
          ],
        );
      },
    );
  }
}
