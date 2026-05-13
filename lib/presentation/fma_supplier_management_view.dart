import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaSupplierManagementView extends StatefulWidget {
  const FmaSupplierManagementView({super.key});

  @override
  State<FmaSupplierManagementView> createState() => _FmaSupplierManagementViewState();
}

class _FmaSupplierManagementViewState extends State<FmaSupplierManagementView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedStatus = "All";

  // New supplier form
  String supplierName = "";
  String contactPerson = "";
  String email = "";
  String phone = "";
  String address = "";
  String category = "Produce";
  String rating = "5";
  String paymentTerms = "Net 30";
  String taxId = "";
  String notes = "";

  List<Map<String, dynamic>> categoryItems = [
    {"label": "All", "value": "All"},
    {"label": "Produce", "value": "Produce"},
    {"label": "Dairy", "value": "Dairy"},
    {"label": "Meat", "value": "Meat"},
    {"label": "Beverages", "value": "Beverages"},
    {"label": "Dry Goods", "value": "Dry Goods"},
    {"label": "Frozen", "value": "Frozen"},
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Inactive", "value": "Inactive"},
  ];

  List<Map<String, dynamic>> supplierCategoryItems = [
    {"label": "Produce", "value": "Produce"},
    {"label": "Dairy", "value": "Dairy"},
    {"label": "Meat", "value": "Meat"},
    {"label": "Beverages", "value": "Beverages"},
    {"label": "Dry Goods", "value": "Dry Goods"},
    {"label": "Frozen", "value": "Frozen"},
  ];

  List<Map<String, dynamic>> ratingItems = [
    {"label": "5 Stars", "value": "5"},
    {"label": "4 Stars", "value": "4"},
    {"label": "3 Stars", "value": "3"},
    {"label": "2 Stars", "value": "2"},
    {"label": "1 Star", "value": "1"},
  ];

  List<Map<String, dynamic>> paymentTermsItems = [
    {"label": "Net 30", "value": "Net 30"},
    {"label": "Net 15", "value": "Net 15"},
    {"label": "COD", "value": "COD"},
    {"label": "Prepaid", "value": "Prepaid"},
  ];

  List<Map<String, dynamic>> suppliers = [
    {
      "id": "1",
      "name": "Fresh Valley Farms",
      "contactPerson": "John Miller",
      "email": "john@freshvalley.com",
      "phone": "+1-555-0123",
      "address": "123 Farm Road, Valley City, CA 90210",
      "category": "Produce",
      "status": "Active",
      "rating": 4.8,
      "paymentTerms": "Net 30",
      "taxId": "12-3456789",
      "totalOrders": 245,
      "totalValue": 125000.00,
      "lastOrder": "2024-06-18",
      "deliveryTime": "24 hours",
      "products": ["Tomatoes", "Lettuce", "Onions", "Carrots"],
    },
    {
      "id": "2",
      "name": "Quality Dairy Co",
      "contactPerson": "Sarah Johnson",
      "email": "sarah@qualitydairy.com",
      "phone": "+1-555-0456",
      "address": "456 Dairy Lane, Cream City, CA 90211",
      "category": "Dairy",
      "status": "Active",
      "rating": 4.9,
      "paymentTerms": "Net 15",
      "taxId": "98-7654321",
      "totalOrders": 180,
      "totalValue": 89000.00,
      "lastOrder": "2024-06-20",
      "deliveryTime": "Same day",
      "products": ["Milk", "Cheese", "Butter", "Yogurt"],
    },
    {
      "id": "3",
      "name": "Ocean Fresh Seafood",
      "contactPerson": "Mike Rodriguez",
      "email": "mike@oceanfresh.com",
      "phone": "+1-555-0789",
      "address": "789 Harbor Drive, Port City, CA 90212",
      "category": "Meat",
      "status": "Active",
      "rating": 4.6,
      "paymentTerms": "COD",
      "taxId": "45-6789123",
      "totalOrders": 95,
      "totalValue": 67000.00,
      "lastOrder": "2024-06-19",
      "deliveryTime": "48 hours",
      "products": ["Salmon", "Tuna", "Shrimp", "Crab"],
    },
    {
      "id": "4",
      "name": "Mountain Springs Water",
      "contactPerson": "Lisa Chen",
      "email": "lisa@mountainsprings.com",
      "phone": "+1-555-0321",
      "address": "321 Spring Road, Mountain View, CA 90213",
      "category": "Beverages",
      "status": "Pending",
      "rating": 4.2,
      "paymentTerms": "Prepaid",
      "taxId": "78-9012345",
      "totalOrders": 12,
      "totalValue": 15000.00,
      "lastOrder": "2024-06-15",
      "deliveryTime": "72 hours",
      "products": ["Spring Water", "Sparkling Water", "Flavored Water"],
    },
    {
      "id": "5",
      "name": "Golden Grain Supplies",
      "contactPerson": "Robert Wilson",
      "email": "robert@goldengrain.com",
      "phone": "+1-555-0654",
      "address": "654 Grain Street, Wheat Valley, CA 90214",
      "category": "Dry Goods",
      "status": "Inactive",
      "rating": 3.8,
      "paymentTerms": "Net 30",
      "taxId": "23-4567890",
      "totalOrders": 78,
      "totalValue": 45000.00,
      "lastOrder": "2024-05-20",
      "deliveryTime": "5 days",
      "products": ["Rice", "Flour", "Beans", "Pasta"],
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Pending":
        return warningColor;
      case "Inactive":
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  Widget _buildStarRating(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating.floor() ? Icons.star : 
          (index < rating && rating % 1 >= 0.5) ? Icons.star_half : Icons.star_border,
          color: warningColor,
          size: 16,
        );
      }),
    );
  }

  void _addSupplier() async {
    if (supplierName.isNotEmpty && contactPerson.isNotEmpty) {
      setState(() {
        suppliers.insert(0, {
          "id": DateTime.now().millisecondsSinceEpoch.toString(),
          "name": supplierName,
          "contactPerson": contactPerson,
          "email": email,
          "phone": phone,
          "address": address,
          "category": category,
          "status": "Pending",
          "rating": double.parse(rating),
          "paymentTerms": paymentTerms,
          "taxId": taxId,
          "totalOrders": 0,
          "totalValue": 0.00,
          "lastOrder": "",
          "deliveryTime": "TBD",
          "products": [],
        });
        
        // Reset form
        supplierName = "";
        contactPerson = "";
        email = "";
        phone = "";
        address = "";
        taxId = "";
        notes = "";
      });
      ss("Supplier added successfully");
    } else {
      se("Please fill in supplier name and contact person");
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Supplier Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Suppliers", icon: Icon(Icons.business)),
        Tab(text: "Performance", icon: Icon(Icons.analytics)),
        Tab(text: "Orders", icon: Icon(Icons.shopping_cart)),
        Tab(text: "Add Supplier", icon: Icon(Icons.add)),
      ],
      tabChildren: [
        _buildSuppliersTab(),
        _buildPerformanceTab(),
        _buildOrdersTab(),
        _buildAddSupplierTab(),
      ],
    );
  }

  Widget _buildSuppliersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Search and Filter
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
                onPressed: () {},
              ),
            ],
          ),
          
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: categoryItems,
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
                  items: statusItems,
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          // Summary Cards
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: primaryColor.withAlpha(50)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "5",
                        style: TextStyle(
                          fontSize: fsH2,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Total Suppliers",
                        style: TextStyle(
                          fontSize: 14,
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
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: successColor.withAlpha(50)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "3",
                        style: TextStyle(
                          fontSize: fsH2,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Active",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Suppliers List
          ...suppliers.map((supplier) {
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spSm),
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
                spacing: spXs,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${supplier["name"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
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
                  Text(
                    "Contact: ${supplier["contactPerson"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Category: ${supplier["category"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Rating: ",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      _buildStarRating((supplier["rating"] as num).toDouble()),
                      SizedBox(width: spXs),
                      Text(
                        "${(supplier["rating"] as num).toStringAsFixed(1)}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Orders: ${supplier["totalOrders"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                      Text(
                        "\$${((supplier["totalValue"] as num).toDouble()).currency}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  if ("${supplier["lastOrder"]}".isNotEmpty)
                    Text(
                      "Last Order: ${DateTime.parse("${supplier["lastOrder"]}").dMMMy}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Contact",
                          size: bs.sm,
                          onPressed: () {
                            ss("Contacting ${supplier["name"]}");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "View Details",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildPerformanceTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Performance Overview
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: primaryColor.withAlpha(50)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "\$341K",
                        style: TextStyle(
                          fontSize: fsH2,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Total Spent",
                        style: TextStyle(fontSize: 14, color: disabledBoldColor),
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
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: successColor.withAlpha(50)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "4.6",
                        style: TextStyle(
                          fontSize: fsH2,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Avg Rating",
                        style: TextStyle(fontSize: 14, color: disabledBoldColor),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Top Performers
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
                  "Top Performing Suppliers",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...suppliers.take(3).map((supplier) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    margin: EdgeInsets.only(bottom: spXs),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusMd),
                          ),
                          child: Icon(Icons.business, color: primaryColor),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${supplier["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Row(
                                children: [
                                  _buildStarRating((supplier["rating"] as num).toDouble()),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${(supplier["rating"] as num).toStringAsFixed(1)}",
                                    style: TextStyle(fontSize: 12, color: disabledBoldColor),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "\$${((supplier["totalValue"] as num).toDouble()).currency}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),

          // Category Performance
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
                  "Category Performance",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusMd),
                            ),
                            child: Icon(Icons.local_grocery_store, color: primaryColor),
                          ),
                          Text("Produce", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                          Text("\$125K", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: primaryColor)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusMd),
                            ),
                            child: Icon(Icons.water_drop, color: successColor),
                          ),
                          Text("Dairy", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                          Text("\$89K", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: successColor)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: dangerColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusMd),
                            ),
                            child: Icon(Icons.set_meal, color: dangerColor),
                          ),
                          Text("Meat", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                          Text("\$67K", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: dangerColor)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: warningColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusMd),
                            ),
                            child: Icon(Icons.local_drink, color: warningColor),
                          ),
                          Text("Beverages", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                          Text("\$60K", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: warningColor)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Delivery Performance
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
                  "Delivery Performance",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: 20,
                        decoration: BoxDecoration(
                          color: successColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radiusSm),
                            bottomLeft: Radius.circular(radiusSm),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 20,
                        color: warningColor,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 20,
                        decoration: BoxDecoration(
                          color: dangerColor,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(radiusSm),
                            bottomRight: Radius.circular(radiusSm),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("On Time (60%)", style: TextStyle(fontSize: 12, color: successColor)),
                    Text("Delayed (20%)", style: TextStyle(fontSize: 12, color: warningColor)),
                    Text("Late (20%)", style: TextStyle(fontSize: 12, color: dangerColor)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Order Summary
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: primaryColor.withAlpha(50)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "610",
                        style: TextStyle(
                          fontSize: fsH2,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Total Orders",
                        style: TextStyle(fontSize: 14, color: disabledBoldColor),
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
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: successColor.withAlpha(50)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "24",
                        style: TextStyle(
                          fontSize: fsH2,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "This Month",
                        style: TextStyle(fontSize: 14, color: disabledBoldColor),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Recent Orders
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
                  "Recent Orders by Supplier",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...suppliers.where((s) => "${s["lastOrder"]}".isNotEmpty).map((supplier) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    margin: EdgeInsets.only(bottom: spXs),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.shopping_cart, color: primaryColor),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${supplier["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Last order: ${DateTime.parse("${supplier["lastOrder"]}").dMMMy}",
                                style: TextStyle(fontSize: 12, color: disabledBoldColor),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "${supplier["totalOrders"]} orders",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "\$${((supplier["totalValue"] as num).toDouble()).currency}",
                              style: TextStyle(fontSize: 12, color: disabledBoldColor),
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

          // Order Actions
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
                  "Quick Actions",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Create Order",
                        size: bs.md,
                        onPressed: () {
                          ss("Creating new order...");
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "View All Orders",
                        size: bs.md,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddSupplierTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
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
              spacing: spSm,
              children: [
                Text(
                  "Add New Supplier",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                QTextField(
                  label: "Supplier Name",
                  value: supplierName,
                  hint: "Enter company name",
                  onChanged: (value) {
                    supplierName = value;
                    setState(() {});
                  },
                ),

                QTextField(
                  label: "Contact Person",
                  value: contactPerson,
                  hint: "Primary contact name",
                  onChanged: (value) {
                    contactPerson = value;
                    setState(() {});
                  },
                ),

                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Email",
                        value: email,
                        hint: "contact@supplier.com",
                        onChanged: (value) {
                          email = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QTextField(
                        label: "Phone",
                        value: phone,
                        hint: "+1-555-0123",
                        onChanged: (value) {
                          phone = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                QMemoField(
                  label: "Address",
                  value: address,
                  hint: "Complete business address",
                  onChanged: (value) {
                    address = value;
                    setState(() {});
                  },
                ),

                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Category",
                        items: supplierCategoryItems,
                        value: category,
                        onChanged: (value, label) {
                          category = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Initial Rating",
                        items: ratingItems,
                        value: rating,
                        onChanged: (value, label) {
                          rating = value;
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
                        label: "Payment Terms",
                        items: paymentTermsItems,
                        value: paymentTerms,
                        onChanged: (value, label) {
                          paymentTerms = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QTextField(
                        label: "Tax ID",
                        value: taxId,
                        hint: "12-3456789",
                        onChanged: (value) {
                          taxId = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                QMemoField(
                  label: "Additional Notes",
                  value: notes,
                  hint: "Any special requirements or notes",
                  onChanged: (value) {
                    notes = value;
                    setState(() {});
                  },
                ),

                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Add Supplier",
                    size: bs.md,
                    onPressed: _addSupplier,
                  ),
                ),
              ],
            ),
          ),

          // Supplier Requirements
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
                  "Supplier Requirements",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "• Valid business license and insurance",
                  style: TextStyle(fontSize: 14, color: disabledBoldColor),
                ),
                Text(
                  "• Food safety certifications (if applicable)",
                  style: TextStyle(fontSize: 14, color: disabledBoldColor),
                ),
                Text(
                  "• Reliable delivery capabilities",
                  style: TextStyle(fontSize: 14, color: disabledBoldColor),
                ),
                Text(
                  "• Quality assurance procedures",
                  style: TextStyle(fontSize: 14, color: disabledBoldColor),
                ),
                Text(
                  "• Competitive pricing structure",
                  style: TextStyle(fontSize: 14, color: disabledBoldColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
