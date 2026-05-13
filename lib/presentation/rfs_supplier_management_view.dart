import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RfsSupplierManagementView extends StatefulWidget {
  const RfsSupplierManagementView({super.key});

  @override
  State<RfsSupplierManagementView> createState() => _RfsSupplierManagementViewState();
}

class _RfsSupplierManagementViewState extends State<RfsSupplierManagementView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedStatus = "All";

  List<Map<String, dynamic>> supplierCategories = [
    {"label": "All", "value": "All"},
    {"label": "Produce", "value": "Produce"},
    {"label": "Dairy", "value": "Dairy"},
    {"label": "Meat", "value": "Meat"},
    {"label": "Beverages", "value": "Beverages"},
    {"label": "Dry Goods", "value": "Dry Goods"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All", "value": "All"},
    {"label": "Active", "value": "Active"},
    {"label": "Pending", "value": "Pending"},
    {"label": "Suspended", "value": "Suspended"},
  ];

  List<Map<String, dynamic>> suppliers = [
    {
      "id": "SUP001",
      "name": "Fresh Valley Produce",
      "category": "Produce",
      "contact": "John Smith",
      "phone": "+1 (555) 123-4567",
      "email": "orders@freshvalley.com",
      "address": "123 Farm Road, Green Valley, CA 90210",
      "status": "Active",
      "rating": 4.8,
      "totalOrders": 156,
      "averageDeliveryTime": 24,
      "lastOrder": "2024-12-18",
      "contractExpiry": "2024-12-31",
      "paymentTerms": "Net 30",
      "minimumOrder": 500.0,
      "products": ["Tomatoes", "Lettuce", "Onions", "Carrots"],
    },
    {
      "id": "SUP002", 
      "name": "Premium Dairy Co",
      "category": "Dairy",
      "contact": "Sarah Johnson",
      "phone": "+1 (555) 987-6543",
      "email": "sales@premiumdairy.com",
      "address": "456 Dairy Lane, Farmington, NY 14425",
      "status": "Active",
      "rating": 4.6,
      "totalOrders": 89,
      "averageDeliveryTime": 12,
      "lastOrder": "2024-12-17",
      "contractExpiry": "2025-06-30",
      "paymentTerms": "Net 15",
      "minimumOrder": 750.0,
      "products": ["Milk", "Cheese", "Butter", "Cream"],
    },
    {
      "id": "SUP003",
      "name": "Ocean Fresh Seafood",
      "category": "Meat",
      "contact": "Mike Rodriguez",
      "phone": "+1 (555) 456-7890",
      "email": "orders@oceanfresh.com",
      "address": "789 Harbor Drive, Coastal City, FL 33101",
      "status": "Pending",
      "rating": 4.3,
      "totalOrders": 34,
      "averageDeliveryTime": 18,
      "lastOrder": "2024-12-15",
      "contractExpiry": "2025-03-15",
      "paymentTerms": "Net 7",
      "minimumOrder": 1000.0,
      "products": ["Salmon", "Shrimp", "Tuna", "Crab"],
    },
    {
      "id": "SUP004",
      "name": "Mountain Beverages",
      "category": "Beverages",
      "contact": "Lisa Chen",
      "phone": "+1 (555) 321-0987",
      "email": "info@mountainbev.com",
      "address": "321 Summit Avenue, Rocky Hills, CO 80424",
      "status": "Active",
      "rating": 4.7,
      "totalOrders": 112,
      "averageDeliveryTime": 36,
      "lastOrder": "2024-12-16",
      "contractExpiry": "2024-11-30",
      "paymentTerms": "Net 30",
      "minimumOrder": 300.0,
      "products": ["Soft Drinks", "Juices", "Water", "Coffee"],
    },
    {
      "id": "SUP005",
      "name": "Golden Grains Supply",
      "category": "Dry Goods",
      "contact": "Robert Kim",
      "phone": "+1 (555) 654-3210",
      "email": "orders@goldengrains.com",
      "address": "654 Wheat Street, Grain Valley, TX 75001",
      "status": "Suspended",
      "rating": 3.9,
      "totalOrders": 67,
      "averageDeliveryTime": 48,
      "lastOrder": "2024-11-28",
      "contractExpiry": "2025-01-15",
      "paymentTerms": "Net 45",
      "minimumOrder": 400.0,
      "products": ["Rice", "Flour", "Pasta", "Beans"],
    },
  ];

  List<Map<String, dynamic>> get filteredSuppliers {
    return suppliers.where((supplier) {
      bool matchesSearch = "${supplier["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${supplier["contact"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${supplier["id"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "All" || supplier["category"] == selectedCategory;
      bool matchesStatus = selectedStatus == "All" || supplier["status"] == selectedStatus;
      
      return matchesSearch && matchesCategory && matchesStatus;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Pending":
        return warningColor;
      case "Suspended":
        return dangerColor;
      default:
        return disabledColor;
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
        Tab(text: "Contracts", icon: Icon(Icons.description)),
      ],
      tabChildren: [
        _buildSuppliersTab(),
        _buildPerformanceTab(),
        _buildContractsTab(),
      ],
    );
  }

  Widget _buildSuppliersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
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
                icon: Icons.add,
                size: bs.sm,
                onPressed: () {
                  // Add new supplier
                },
              ),
            ],
          ),
          
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: supplierCategories,
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

          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: filteredSuppliers.length,
            separatorBuilder: (context, index) => SizedBox(height: spSm),
            itemBuilder: (context, index) {
              final supplier = filteredSuppliers[index];
              return _buildSupplierCard(supplier);
            },
          ),
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
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildMetricCard("Total Suppliers", "${suppliers.length}", Icons.business, primaryColor),
              _buildMetricCard("Active Suppliers", "${suppliers.where((s) => s["status"] == "Active").length}", Icons.check_circle, successColor),
              _buildMetricCard("Avg Rating", "4.5", Icons.star, warningColor),
              _buildMetricCard("On-Time Delivery", "94%", Icons.schedule, infoColor),
            ],
          ),

          Container(
            width: double.infinity,
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
                  "Top Performing Suppliers",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...suppliers
                    .where((s) => s["status"] == "Active")
                    .take(5)
                    .map((supplier) => _buildPerformanceItem(supplier)),
              ],
            ),
          ),

          Container(
            width: double.infinity,
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
                  "Delivery Performance",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...suppliers
                    .map((supplier) => _buildDeliveryPerformanceItem(supplier)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContractsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(51),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: warningColor.withAlpha(102)),
            ),
            child: Row(
              children: [
                Icon(Icons.warning, color: warningColor),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "3 contracts expiring within 30 days",
                    style: TextStyle(
                      color: warningColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          ...suppliers.map((supplier) => _buildContractCard(supplier)),
        ],
      ),
    );
  }

  Widget _buildSupplierCard(Map<String, dynamic> supplier) {
    return Container(
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
          Row(
            children: [
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
                    Text(
                      "${supplier["id"]} • ${supplier["category"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getStatusColor("${supplier["status"]}").withAlpha(51),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${supplier["status"]}",
                  style: TextStyle(
                    color: _getStatusColor("${supplier["status"]}"),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          Row(
            children: [
              Icon(Icons.person, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${supplier["contact"]}",
                style: TextStyle(fontSize: 14, color: disabledBoldColor),
              ),
            ],
          ),

          Row(
            children: [
              Icon(Icons.phone, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${supplier["phone"]}",
                style: TextStyle(fontSize: 14, color: disabledBoldColor),
              ),
            ],
          ),

          Row(
            children: [
              Icon(Icons.star, size: 16, color: warningColor),
              SizedBox(width: spXs),
              Text(
                "${supplier["rating"]}",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              SizedBox(width: spMd),
              Icon(Icons.shopping_cart, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${supplier["totalOrders"]} orders",
                style: TextStyle(fontSize: 14, color: disabledBoldColor),
              ),
            ],
          ),

          Text(
            "Products: ${(supplier["products"] as List).join(", ")}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),

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
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {
                  // Edit supplier
                },
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  // More options
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Container(
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
              Icon(icon, color: color, size: 24),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceItem(Map<String, dynamic> supplier) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: spSm),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${supplier["name"]}",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  "${supplier["totalOrders"]} orders",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Icon(Icons.star, size: 16, color: warningColor),
              SizedBox(width: spXs),
              Text(
                "${supplier["rating"]}",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryPerformanceItem(Map<String, dynamic> supplier) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: spSm),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "${supplier["name"]}",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Text(
            "${supplier["averageDeliveryTime"]}h",
            style: TextStyle(
              color: (supplier["averageDeliveryTime"] as int) <= 24 
                  ? successColor 
                  : (supplier["averageDeliveryTime"] as int) <= 48 
                      ? warningColor 
                      : dangerColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContractCard(Map<String, dynamic> supplier) {
    bool isExpiringSoon = DateTime.parse("${supplier["contractExpiry"]}").isBefore(
      DateTime.now().add(Duration(days: 30))
    );

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: isExpiringSoon 
            ? Border.all(color: warningColor.withAlpha(102))
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
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
              if (isExpiringSoon)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(51),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "Expiring Soon",
                    style: TextStyle(
                      color: warningColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Contract Expiry",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${DateTime.parse("${supplier["contractExpiry"]}").dMMMy}",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
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
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Minimum Order",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "\$${(supplier["minimumOrder"] as double).currency}",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              QButton(
                label: "Renew Contract",
                size: bs.sm,
                onPressed: () {
                  // Renew contract
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
