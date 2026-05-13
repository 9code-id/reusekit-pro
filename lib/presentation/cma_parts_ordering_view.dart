import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaPartsOrderingView extends StatefulWidget {
  const CmaPartsOrderingView({super.key});

  @override
  State<CmaPartsOrderingView> createState() => _CmaPartsOrderingViewState();
}

class _CmaPartsOrderingViewState extends State<CmaPartsOrderingView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedBrand = "";
  List<String> cartItems = [];

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Engine", "value": "Engine"},
    {"label": "Brake", "value": "Brake"},
    {"label": "Suspension", "value": "Suspension"},
    {"label": "Electrical", "value": "Electrical"},
    {"label": "Filters", "value": "Filters"},
    {"label": "Belts", "value": "Belts"},
    {"label": "Fluids", "value": "Fluids"},
  ];

  List<Map<String, dynamic>> brands = [
    {"label": "All Brands", "value": ""},
    {"label": "Bosch", "value": "Bosch"},
    {"label": "Denso", "value": "Denso"},
    {"label": "ACDelco", "value": "ACDelco"},
    {"label": "Mobil 1", "value": "Mobil 1"},
    {"label": "Castrol", "value": "Castrol"},
    {"label": "NGK", "value": "NGK"},
  ];

  List<Map<String, dynamic>> parts = [
    {
      "id": "1",
      "name": "Bosch Spark Plugs Set",
      "category": "Engine",
      "brand": "Bosch",
      "price": 45.99,
      "originalPrice": 52.99,
      "rating": 4.8,
      "reviews": 324,
      "image": "https://picsum.photos/200/200?random=1&keyword=sparkplug",
      "description": "High performance iridium spark plugs for improved combustion",
      "compatibility": ["Honda Civic", "Toyota Corolla", "Nissan Sentra"],
      "inStock": true,
      "stock": 25,
      "estimatedDelivery": "2-3 days",
    },
    {
      "id": "2",
      "name": "Castrol GTX Motor Oil 5W-30",
      "category": "Fluids",
      "brand": "Castrol",
      "price": 24.99,
      "originalPrice": 29.99,
      "rating": 4.6,
      "reviews": 156,
      "image": "https://picsum.photos/200/200?random=2&keyword=motoroil",
      "description": "Premium motor oil for superior engine protection",
      "compatibility": ["Most vehicles"],
      "inStock": true,
      "stock": 50,
      "estimatedDelivery": "1-2 days",
    },
    {
      "id": "3",
      "name": "ACDelco Brake Pads Front",
      "category": "Brake",
      "brand": "ACDelco",
      "price": 78.50,
      "originalPrice": 89.99,
      "rating": 4.7,
      "reviews": 89,
      "image": "https://picsum.photos/200/200?random=3&keyword=brakepad",
      "description": "OEM quality ceramic brake pads for superior stopping power",
      "compatibility": ["Ford F-150", "Chevrolet Silverado"],
      "inStock": true,
      "stock": 12,
      "estimatedDelivery": "3-5 days",
    },
    {
      "id": "4",
      "name": "Denso Air Filter",
      "category": "Filters",
      "brand": "Denso",
      "price": 18.75,
      "originalPrice": 22.99,
      "rating": 4.5,
      "reviews": 203,
      "image": "https://picsum.photos/200/200?random=4&keyword=airfilter",
      "description": "High efficiency air filter for optimal engine performance",
      "compatibility": ["Toyota Camry", "Honda Accord"],
      "inStock": false,
      "stock": 0,
      "estimatedDelivery": "7-10 days",
    },
    {
      "id": "5",
      "name": "NGK Ignition Coil",
      "category": "Electrical",
      "brand": "NGK",
      "price": 89.99,
      "originalPrice": 99.99,
      "rating": 4.9,
      "reviews": 67,
      "image": "https://picsum.photos/200/200?random=5&keyword=ignitioncoil",
      "description": "Premium ignition coil for reliable engine starting",
      "compatibility": ["BMW 3 Series", "Mercedes C-Class"],
      "inStock": true,
      "stock": 8,
      "estimatedDelivery": "2-4 days",
    },
    {
      "id": "6",
      "name": "Monroe Shock Absorber",
      "category": "Suspension",
      "brand": "Monroe",
      "price": 125.00,
      "originalPrice": 145.99,
      "rating": 4.4,
      "reviews": 142,
      "image": "https://picsum.photos/200/200?random=6&keyword=shock",
      "description": "Gas-charged shock absorber for smooth ride quality",
      "compatibility": ["Various models"],
      "inStock": true,
      "stock": 15,
      "estimatedDelivery": "3-5 days",
    },
  ];

  List<Map<String, dynamic>> get filteredParts {
    return parts.where((part) {
      bool matchesSearch = searchQuery.isEmpty ||
          (part["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (part["brand"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "All" || part["category"] == selectedCategory;
      bool matchesBrand = selectedBrand.isEmpty || part["brand"] == selectedBrand;
      
      return matchesSearch && matchesCategory && matchesBrand;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Auto Parts",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Browse", icon: Icon(Icons.search)),
        Tab(text: "Cart", icon: Icon(Icons.shopping_cart)),
        Tab(text: "Orders", icon: Icon(Icons.receipt)),
      ],
      tabChildren: [
        _buildBrowseTab(),
        _buildCartTab(),
        _buildOrdersTab(),
      ],
      onInit: (tabController) {},
    );
  }

  Widget _buildBrowseTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search parts...",
                  value: searchQuery,
                  hint: "Enter part name or brand",
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

          // Filters
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
                  label: "Brand",
                  items: brands,
                  value: selectedBrand,
                  onChanged: (value, label) {
                    selectedBrand = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          // Results Count
          Text(
            "${filteredParts.length} parts found",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),

          // Parts Grid
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: filteredParts.map((part) {
              bool isInCart = cartItems.contains(part["id"]);
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Part Image
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radiusMd),
                        topRight: Radius.circular(radiusMd),
                      ),
                      child: Stack(
                        children: [
                          Image.network(
                            "${part["image"]}",
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          if (!(part["inStock"] as bool))
                            Container(
                              height: 150,
                              width: double.infinity,
                              color: Colors.black.withAlpha(150),
                              child: Center(
                                child: Text(
                                  "Out of Stock",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          if ((part["originalPrice"] as double) > (part["price"] as double))
                            Positioned(
                              top: spSm,
                              left: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: dangerColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "Sale",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),

                    // Part Details
                    Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        spacing: spXs,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${part["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          
                          Text(
                            "${part["brand"]} • ${part["category"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),

                          Row(
                            children: [
                              Icon(Icons.star, color: warningColor, size: 16),
                              SizedBox(width: spXs),
                              Text(
                                "${part["rating"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                " (${part["reviews"]})",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              Text(
                                "\$${(part["price"] as double).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              if ((part["originalPrice"] as double) > (part["price"] as double)) ...[
                                SizedBox(width: spXs),
                                Text(
                                  "\$${(part["originalPrice"] as double).toStringAsFixed(2)}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ],
                            ],
                          ),

                          if (part["inStock"] as bool)
                            Row(
                              children: [
                                Icon(Icons.check_circle, color: successColor, size: 16),
                                SizedBox(width: spXs),
                                Text(
                                  "In Stock (${part["stock"]})",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: successColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            )
                          else
                            Row(
                              children: [
                                Icon(Icons.schedule, color: disabledBoldColor, size: 16),
                                SizedBox(width: spXs),
                                Text(
                                  "Back in ${part["estimatedDelivery"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),

                          Text(
                            "Delivery: ${part["estimatedDelivery"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: infoColor,
                            ),
                          ),

                          SizedBox(height: spSm),

                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: isInCart ? "In Cart" : "Add to Cart",
                                  size: bs.sm,
                                  onPressed: (part["inStock"] as bool) ? () {
                                    if (isInCart) {
                                      cartItems.remove(part["id"]);
                                      se("Removed from cart");
                                    } else {
                                      cartItems.add(part["id"] as String);
                                      ss("Added to cart");
                                    }
                                    setState(() {});
                                  } : null,
                                ),
                              ),
                              SizedBox(width: spXs),
                              QButton(
                                icon: Icons.info_outline,
                                size: bs.sm,
                                onPressed: () => _showPartDetails(part),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCartTab() {
    List<Map<String, dynamic>> cartParts = parts.where((part) => cartItems.contains(part["id"])).toList();
    double subtotal = cartParts.fold(0.0, (sum, part) => sum + (part["price"] as double));
    double shipping = 15.99;
    double tax = subtotal * 0.08;
    double total = subtotal + shipping + tax;

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Shopping Cart (${cartParts.length} items)",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          if (cartParts.isEmpty)
            Center(
              child: Column(
                spacing: spMd,
                children: [
                  SizedBox(height: 100),
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 80,
                    color: disabledBoldColor,
                  ),
                  Text(
                    "Your cart is empty",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "Browse parts and add them to your cart",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  QButton(
                    label: "Browse Parts",
                    size: bs.sm,
                    onPressed: () {
                      currentTab = 0;
                      setState(() {});
                    },
                  ),
                ],
              ),
            )
          else ...[
            // Cart Items
            ...cartParts.map((part) => Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusSm),
                    child: Image.network(
                      "${part["image"]}",
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${part["name"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${part["brand"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "\$${(part["price"] as double).toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  QButton(
                    icon: Icons.delete,
                    size: bs.sm,
                    onPressed: () {
                      cartItems.remove(part["id"]);
                      setState(() {});
                      se("Item removed from cart");
                    },
                  ),
                ],
              ),
            )),

            // Order Summary
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
                  Text(
                    "Order Summary",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Subtotal:", style: TextStyle(fontSize: 14)),
                      Text("\$${subtotal.toStringAsFixed(2)}", style: TextStyle(fontSize: 14)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Shipping:", style: TextStyle(fontSize: 14)),
                      Text("\$${shipping.toStringAsFixed(2)}", style: TextStyle(fontSize: 14)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Tax:", style: TextStyle(fontSize: 14)),
                      Text("\$${tax.toStringAsFixed(2)}", style: TextStyle(fontSize: 14)),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "\$${total.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  QButton(
                    label: "Proceed to Checkout",
                    size: bs.md,
                    onPressed: () {
                      ss("Order placed successfully!");
                      cartItems.clear();
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildOrdersTab() {
    List<Map<String, dynamic>> orders = [
      {
        "id": "ORD-001",
        "date": "2024-12-15",
        "status": "Delivered",
        "total": 89.99,
        "items": 3,
        "trackingNumber": "1Z999AA1012345675",
      },
      {
        "id": "ORD-002",
        "date": "2024-12-10",
        "status": "In Transit",
        "total": 156.50,
        "items": 2,
        "trackingNumber": "1Z999AA1012345676",
      },
      {
        "id": "ORD-003",
        "date": "2024-12-05",
        "status": "Processing",
        "total": 45.99,
        "items": 1,
        "trackingNumber": "1Z999AA1012345677",
      },
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Order History",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          ...orders.map((order) {
            Color statusColor = order["status"] == "Delivered" ? successColor :
                               order["status"] == "In Transit" ? warningColor : infoColor;
            
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Order ${order["id"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: statusColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${order["status"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: statusColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "${order["date"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${order["items"]} items",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Icon(Icons.local_shipping, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "Tracking: ${order["trackingNumber"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total: \$${(order["total"] as double).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Row(
                        children: [
                          QButton(
                            label: "Track",
                            size: bs.sm,
                            onPressed: () {
                              si("Tracking information updated");
                            },
                          ),
                          SizedBox(width: spXs),
                          QButton(
                            label: "Details",
                            size: bs.sm,
                            onPressed: () {
                              _showOrderDetails(order);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  void _showPartDetails(Map<String, dynamic> part) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${part["name"]}"),
        content: SingleChildScrollView(
          child: Column(
            spacing: spSm,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                "${part["image"]}",
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Text(
                "${part["description"]}",
                style: TextStyle(fontSize: 14),
              ),
              Text(
                "Compatibility:",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ...(part["compatibility"] as List).map((vehicle) => Text(
                "• $vehicle",
                style: TextStyle(fontSize: 12),
              )),
              Row(
                children: [
                  Icon(Icons.star, color: warningColor, size: 16),
                  SizedBox(width: spXs),
                  Text("${part["rating"]} (${part["reviews"]} reviews)"),
                ],
              ),
            ],
          ),
        ),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _showOrderDetails(Map<String, dynamic> order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Order ${order["id"]}"),
        content: Column(
          spacing: spSm,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Date: ${order["date"]}"),
            Text("Status: ${order["status"]}"),
            Text("Total: \$${(order["total"] as double).toStringAsFixed(2)}"),
            Text("Items: ${order["items"]}"),
            Text("Tracking: ${order["trackingNumber"]}"),
          ],
        ),
        actions: [
          QButton(
            label: "Close",
            size: bs.sm,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
