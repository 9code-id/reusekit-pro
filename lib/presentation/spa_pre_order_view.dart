import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaPreOrderView extends StatefulWidget {
  const SpaPreOrderView({super.key});

  @override
  State<SpaPreOrderView> createState() => _SpaPreOrderViewState();
}

class _SpaPreOrderViewState extends State<SpaPreOrderView> {
  int selectedTab = 0;
  String searchQuery = "";
  String selectedCategory = "All";
  String sortBy = "Name";
  
  List<String> categories = ["All", "Skincare", "Hair Care", "Aromatherapy", "Equipment", "Accessories"];
  List<String> sortOptions = ["Name", "Price", "Availability Date", "Popularity"];
  
  List<Map<String, dynamic>> preOrderProducts = [
    {
      "id": "PRE001",
      "name": "Advanced Collagen Facial Serum",
      "brand": "LuxeSpa Pro",
      "category": "Skincare",
      "image": "https://picsum.photos/200/200?random=1&keyword=serum",
      "originalPrice": 189.99,
      "preOrderPrice": 149.99,
      "savings": 40.00,
      "availableDate": "February 15, 2025",
      "description": "Revolutionary anti-aging serum with marine collagen and peptides",
      "inStock": false,
      "preOrderQuantity": 156,
      "estimatedDelivery": "Feb 15-20, 2025",
      "popularity": 95
    },
    {
      "id": "PRE002", 
      "name": "Himalayan Salt Stone Warmer",
      "brand": "ThermalSpa",
      "category": "Equipment",
      "image": "https://picsum.photos/200/200?random=2&keyword=spa",
      "originalPrice": 899.99,
      "preOrderPrice": 699.99,
      "savings": 200.00,
      "availableDate": "March 1, 2025",
      "description": "Professional-grade heated stone therapy system",
      "inStock": false,
      "preOrderQuantity": 43,
      "estimatedDelivery": "Mar 1-5, 2025",
      "popularity": 88
    },
    {
      "id": "PRE003",
      "name": "Organic Rose Hip Oil Blend",
      "brand": "BotanicLux",
      "category": "Skincare",
      "image": "https://picsum.photos/200/200?random=3&keyword=oil",
      "originalPrice": 79.99,
      "preOrderPrice": 59.99,
      "savings": 20.00,
      "availableDate": "January 30, 2025",
      "description": "Cold-pressed organic rose hip oil with vitamin E",
      "inStock": false,
      "preOrderQuantity": 289,
      "estimatedDelivery": "Jan 30-Feb 3, 2025",
      "popularity": 92
    },
    {
      "id": "PRE004",
      "name": "Ultrasonic Essential Oil Diffuser Pro",
      "brand": "AromaElite",
      "category": "Aromatherapy", 
      "image": "https://picsum.photos/200/200?random=4&keyword=diffuser",
      "originalPrice": 299.99,
      "preOrderPrice": 229.99,
      "savings": 70.00,
      "availableDate": "February 20, 2025",
      "description": "Professional aromatherapy diffuser with smart controls",
      "inStock": false,
      "preOrderQuantity": 78,
      "estimatedDelivery": "Feb 20-25, 2025",
      "popularity": 85
    },
    {
      "id": "PRE005",
      "name": "Keratin Repair Hair Mask Set",
      "brand": "SalonGrade",
      "category": "Hair Care",
      "image": "https://picsum.photos/200/200?random=5&keyword=hair",
      "originalPrice": 159.99,
      "preOrderPrice": 119.99,
      "savings": 40.00,
      "availableDate": "February 10, 2025",
      "description": "Professional keratin treatment system for damaged hair",
      "inStock": false,
      "preOrderQuantity": 134,
      "estimatedDelivery": "Feb 10-15, 2025",
      "popularity": 90
    },
    {
      "id": "PRE006",
      "name": "Bamboo Massage Tool Set",
      "brand": "EcoSpa",
      "category": "Accessories",
      "image": "https://picsum.photos/200/200?random=6&keyword=bamboo",
      "originalPrice": 129.99,
      "preOrderPrice": 99.99,
      "savings": 30.00,
      "availableDate": "March 5, 2025",
      "description": "Sustainable bamboo massage tools for body therapy",
      "inStock": false,
      "preOrderQuantity": 67,
      "estimatedDelivery": "Mar 5-10, 2025",
      "popularity": 78
    }
  ];
  
  List<Map<String, dynamic>> myPreOrders = [
    {
      "orderNumber": "PO-2025-001",
      "productName": "Advanced Collagen Facial Serum",
      "quantity": 2,
      "totalAmount": 299.98,
      "orderDate": "January 10, 2025",
      "availableDate": "February 15, 2025",
      "status": "Confirmed",
      "tracking": "PO001234567890",
      "image": "https://picsum.photos/100/100?random=1&keyword=serum"
    },
    {
      "orderNumber": "PO-2025-002",
      "productName": "Organic Rose Hip Oil Blend",
      "quantity": 3,
      "totalAmount": 179.97,
      "orderDate": "January 8, 2025",
      "availableDate": "January 30, 2025",
      "status": "Ready to Ship",
      "tracking": "PO001234567891",
      "image": "https://picsum.photos/100/100?random=3&keyword=oil"
    }
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredProducts = _getFilteredProducts();
    
    return QTabBar(
      title: "Pre-Orders",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Available", icon: Icon(Icons.shopping_bag)),
        Tab(text: "My Orders", icon: Icon(Icons.list_alt)),
      ],
      tabChildren: [
        _buildAvailableTab(filteredProducts),
        _buildMyOrdersTab(),
      ],
    );
  }
  
  Widget _buildAvailableTab(List<Map<String, dynamic>> products) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Search and Filters
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              spacing: spMd,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search pre-order products...",
                        value: searchQuery,
                        onChanged: (value) {
                          searchQuery = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spMd),
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
                        items: categories.map((cat) => {"label": cat, "value": cat}).toList(),
                        value: selectedCategory,
                        onChanged: (value, label) {
                          selectedCategory = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: QDropdownField(
                        label: "Sort By",
                        items: sortOptions.map((sort) => {"label": sort, "value": sort}).toList(),
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
          
          // Pre-order Stats
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Pre-Order Statistics",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 200,
                  children: [
                    _buildStatCard("Available Products", "${products.length}", primaryColor, Icons.inventory),
                    _buildStatCard("Total Pre-Orders", "${products.fold(0, (sum, product) => sum + (product["preOrderQuantity"] as int))}", successColor, Icons.shopping_cart),
                    _buildStatCard("Average Savings", "${((products.fold(0.0, (sum, product) => sum + (product["savings"] as double)) / products.length)).toStringAsFixed(0)}%", warningColor, Icons.savings),
                    _buildStatCard("Coming This Month", "${products.where((p) => (p["availableDate"] as String).contains("January")).length}", infoColor, Icons.calendar_today),
                  ],
                ),
              ],
            ),
          ),
          
          // Products Grid
          if (products.isNotEmpty)
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: products.map((product) => _buildPreOrderCard(product)).toList(),
            )
          else
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
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
                    "No products found",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Try adjusting your search or filters",
                    style: TextStyle(
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
  
  Widget _buildMyOrdersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Order Summary
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "My Pre-Orders Summary",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 200,
                  children: [
                    _buildStatCard("Active Orders", "${myPreOrders.length}", primaryColor, Icons.shopping_bag),
                    _buildStatCard("Total Value", "\$${myPreOrders.fold(0.0, (sum, order) => sum + (order["totalAmount"] as double)).toStringAsFixed(2)}", successColor, Icons.attach_money),
                    _buildStatCard("Ready to Ship", "${myPreOrders.where((o) => o["status"] == "Ready to Ship").length}", warningColor, Icons.local_shipping),
                    _buildStatCard("Confirmed", "${myPreOrders.where((o) => o["status"] == "Confirmed").length}", infoColor, Icons.check_circle),
                  ],
                ),
              ],
            ),
          ),
          
          // Orders List
          if (myPreOrders.isNotEmpty)
            ...myPreOrders.map((order) => _buildPreOrderItem(order)).toList()
          else
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.shopping_bag_outlined,
                    size: 64,
                    color: disabledColor,
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "No pre-orders yet",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Browse available products to place your first pre-order",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  QButton(
                    label: "Browse Products",
                    size: bs.md,
                    onPressed: () {
                      selectedTab = 0;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
  
  Widget _buildStatCard(String title, String value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: color.withAlpha(60)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: fsH5,
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
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildPreOrderCard(Map<String, dynamic> product) {
    double discountPercent = ((product["savings"] as double) / (product["originalPrice"] as double)) * 100;
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                child: Image.network(
                  "${product["image"]}",
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: spSm,
                right: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: dangerColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "-${discountPercent.toStringAsFixed(0)}%",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: spSm,
                left: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "PRE-ORDER",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                // Brand and Category
                Row(
                  children: [
                    Text(
                      "${product["brand"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
                      decoration: BoxDecoration(
                        color: disabledColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${product["category"]}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                
                // Product Name
                Text(
                  "${product["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                // Description
                Text(
                  "${product["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                // Pricing
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "\$${(product["preOrderPrice"] as double).toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "\$${(product["originalPrice"] as double).toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Text(
                      "Save \$${(product["savings"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 12,
                        color: dangerColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                
                // Availability Info
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.schedule,
                            size: 16,
                            color: infoColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Available: ${product["availableDate"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: infoColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.people,
                            size: 16,
                            color: infoColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${product["preOrderQuantity"]} pre-orders",
                            style: TextStyle(
                              fontSize: 12,
                              color: infoColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Pre-Order Button
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Pre-Order Now",
                    size: bs.md,
                    icon: Icons.shopping_cart,
                    onPressed: () {
                      _preOrderProduct(product);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildPreOrderItem(Map<String, dynamic> order) {
    Color statusColor = order["status"] == "Ready to Ship" ? successColor : 
                       order["status"] == "Confirmed" ? infoColor : warningColor;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${order["image"]}",
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${order["productName"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Order #${order["orderNumber"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "Qty: ${order["quantity"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Text(
                          "\$${(order["totalAmount"] as double).toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${order["status"]}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildOrderInfoCard("Order Date", "${order["orderDate"]}", Icons.calendar_today),
              _buildOrderInfoCard("Available Date", "${order["availableDate"]}", Icons.schedule),
              _buildOrderInfoCard("Tracking", "${order["tracking"]}", Icons.local_shipping),
              _buildOrderInfoCard("Status", "${order["status"]}", Icons.info),
            ],
          ),
          
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  icon: Icons.visibility,
                  color: infoColor,
                  onPressed: () {
                    _viewOrderDetails(order);
                  },
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QButton(
                  label: "Track Order",
                  size: bs.sm,
                  icon: Icons.location_on,
                  color: primaryColor,
                  onPressed: () {
                    _trackOrder(order);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildOrderInfoCard(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: primaryColor,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 11,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  List<Map<String, dynamic>> _getFilteredProducts() {
    List<Map<String, dynamic>> filtered = List.from(preOrderProducts);
    
    // Filter by category
    if (selectedCategory != "All") {
      filtered = filtered.where((product) => product["category"] == selectedCategory).toList();
    }
    
    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((product) => 
        (product["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (product["brand"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (product["description"] as String).toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    // Sort products
    switch (sortBy) {
      case "Name":
        filtered.sort((a, b) => (a["name"] as String).compareTo(b["name"] as String));
        break;
      case "Price":
        filtered.sort((a, b) => (a["preOrderPrice"] as double).compareTo(b["preOrderPrice"] as double));
        break;
      case "Availability Date":
        filtered.sort((a, b) => (a["availableDate"] as String).compareTo(b["availableDate"] as String));
        break;
      case "Popularity":
        filtered.sort((a, b) => (b["popularity"] as int).compareTo(a["popularity"] as int));
        break;
    }
    
    return filtered;
  }
  
  void _preOrderProduct(Map<String, dynamic> product) {
    ss("Pre-order placed for ${product["name"]}");
  }
  
  void _viewOrderDetails(Map<String, dynamic> order) {
    ss("Viewing details for order ${order["orderNumber"]}");
  }
  
  void _trackOrder(Map<String, dynamic> order) {
    ss("Tracking order ${order["orderNumber"]}");
  }
}
