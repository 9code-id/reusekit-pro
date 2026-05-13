import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaAutoPartsView extends StatefulWidget {
  const CmaAutoPartsView({super.key});

  @override
  State<CmaAutoPartsView> createState() => _CmaAutoPartsViewState();
}

class _CmaAutoPartsViewState extends State<CmaAutoPartsView> {
  int currentTab = 0;
  String selectedCategory = "All Categories";
  String selectedBrand = "All Brands";
  String selectedCompatibility = "All Vehicles";
  String selectedAvailability = "All";
  String searchQuery = "";

  List<Map<String, dynamic>> partsData = [
    {
      "id": "PART-001",
      "name": "Premium Brake Pads Set",
      "category": "Brakes",
      "brand": "Brembo",
      "partNumber": "P56044",
      "price": 89.99,
      "originalPrice": 109.99,
      "discount": 18,
      "availability": "In Stock",
      "quantity": 25,
      "compatibility": ["Ford Transit", "Ford E-Series", "Chevrolet Express"],
      "description": "High-performance ceramic brake pads for commercial vehicles",
      "features": ["Ceramic compound", "Low dust", "Extended wear"],
      "warranty": "2 years / 50,000 miles",
      "imageUrl": "https://picsum.photos/300/200?random=1&keyword=brake",
      "rating": 4.8,
      "reviewCount": 156,
      "supplier": "AutoParts Plus",
      "estimatedDelivery": "1-2 business days",
      "isPopular": true,
      "isDealOfTheDay": false
    },
    {
      "id": "PART-002",
      "name": "Heavy Duty Air Filter",
      "category": "Engine",
      "brand": "K&N",
      "partNumber": "33-2116",
      "price": 45.50,
      "originalPrice": 45.50,
      "discount": 0,
      "availability": "In Stock",
      "quantity": 18,
      "compatibility": ["Ram ProMaster", "Mercedes Sprinter", "Nissan NV200"],
      "description": "Washable, reusable high-flow air filter",
      "features": ["Washable", "High-flow design", "Oiled cotton"],
      "warranty": "10 years / 1 million miles",
      "imageUrl": "https://picsum.photos/300/200?random=2&keyword=filter",
      "rating": 4.7,
      "reviewCount": 89,
      "supplier": "Performance Parts Co",
      "estimatedDelivery": "Same day",
      "isPopular": false,
      "isDealOfTheDay": true
    },
    {
      "id": "PART-003",
      "name": "Commercial Grade Oil Filter",
      "category": "Engine",
      "brand": "Mobil 1",
      "partNumber": "M1-110A",
      "price": 12.99,
      "originalPrice": 15.99,
      "discount": 19,
      "availability": "Low Stock",
      "quantity": 5,
      "compatibility": ["Isuzu NPR", "Ford F-550", "Chevrolet 4500"],
      "description": "Extended performance oil filter for commercial applications",
      "features": ["Extended life", "99% efficiency", "Anti-drainback valve"],
      "warranty": "1 year",
      "imageUrl": "https://picsum.photos/300/200?random=3&keyword=oil",
      "rating": 4.9,
      "reviewCount": 203,
      "supplier": "Fleet Supply Direct",
      "estimatedDelivery": "2-3 business days",
      "isPopular": true,
      "isDealOfTheDay": false
    },
    {
      "id": "PART-004",
      "name": "LED Headlight Assembly",
      "category": "Lighting",
      "brand": "Philips",
      "partNumber": "9007-LED",
      "price": 178.00,
      "originalPrice": 198.00,
      "discount": 10,
      "availability": "In Stock",
      "quantity": 12,
      "compatibility": ["Ford Transit", "Chevrolet Express", "GMC Savana"],
      "description": "Ultra-bright LED headlight with long lifespan",
      "features": ["6000K color temp", "50,000 hour life", "DOT approved"],
      "warranty": "5 years",
      "imageUrl": "https://picsum.photos/300/200?random=4&keyword=headlight",
      "rating": 4.6,
      "reviewCount": 127,
      "supplier": "Lighting Solutions Inc",
      "estimatedDelivery": "1-2 business days",
      "isPopular": false,
      "isDealOfTheDay": false
    },
    {
      "id": "PART-005",
      "name": "Heavy Duty Shock Absorber",
      "category": "Suspension",
      "brand": "Monroe",
      "partNumber": "58640",
      "price": 89.00,
      "originalPrice": 105.00,
      "discount": 15,
      "availability": "In Stock",
      "quantity": 8,
      "compatibility": ["Ram ProMaster", "Mercedes Sprinter"],
      "description": "Gas-charged shock absorber for commercial vehicles",
      "features": ["Gas-charged", "All-weather fluid", "Precision valve"],
      "warranty": "Limited lifetime",
      "imageUrl": "https://picsum.photos/300/200?random=5&keyword=shock",
      "rating": 4.5,
      "reviewCount": 74,
      "supplier": "Suspension Specialists",
      "estimatedDelivery": "2-3 business days",
      "isPopular": false,
      "isDealOfTheDay": false
    },
    {
      "id": "PART-006",
      "name": "Commercial Tire 235/65R16",
      "category": "Tires",
      "brand": "Michelin",
      "partNumber": "LTX-M/S2",
      "price": 156.00,
      "originalPrice": 175.00,
      "discount": 11,
      "availability": "In Stock",
      "quantity": 20,
      "compatibility": ["Ford Transit", "Ram ProMaster", "Nissan NV200"],
      "description": "All-season commercial tire with enhanced durability",
      "features": ["All-season tread", "80,000 mile warranty", "Enhanced sidewall"],
      "warranty": "6 years / 80,000 miles",
      "imageUrl": "https://picsum.photos/300/200?random=6&keyword=tire",
      "rating": 4.7,
      "reviewCount": 98,
      "supplier": "Tire World Commercial",
      "estimatedDelivery": "1-2 business days",
      "isPopular": true,
      "isDealOfTheDay": true
    }
  ];

  List<Map<String, dynamic>> categoryItems = [
    {"label": "All Categories", "value": "All Categories"},
    {"label": "Engine", "value": "Engine"},
    {"label": "Brakes", "value": "Brakes"},
    {"label": "Suspension", "value": "Suspension"},
    {"label": "Lighting", "value": "Lighting"},
    {"label": "Tires", "value": "Tires"},
    {"label": "Electrical", "value": "Electrical"},
  ];

  List<Map<String, dynamic>> brandItems = [
    {"label": "All Brands", "value": "All Brands"},
    {"label": "Brembo", "value": "Brembo"},
    {"label": "K&N", "value": "K&N"},
    {"label": "Mobil 1", "value": "Mobil 1"},
    {"label": "Philips", "value": "Philips"},
    {"label": "Monroe", "value": "Monroe"},
    {"label": "Michelin", "value": "Michelin"},
  ];

  List<Map<String, dynamic>> compatibilityItems = [
    {"label": "All Vehicles", "value": "All Vehicles"},
    {"label": "Ford Transit", "value": "Ford Transit"},
    {"label": "Chevrolet Express", "value": "Chevrolet Express"},
    {"label": "Ram ProMaster", "value": "Ram ProMaster"},
    {"label": "Mercedes Sprinter", "value": "Mercedes Sprinter"},
    {"label": "Isuzu NPR", "value": "Isuzu NPR"},
  ];

  List<Map<String, dynamic>> availabilityItems = [
    {"label": "All", "value": "All"},
    {"label": "In Stock", "value": "In Stock"},
    {"label": "Low Stock", "value": "Low Stock"},
    {"label": "Out of Stock", "value": "Out of Stock"},
  ];

  List<Map<String, dynamic>> get filteredParts {
    return partsData.where((part) {
      if (selectedCategory != "All Categories" && part["category"] != selectedCategory) return false;
      if (selectedBrand != "All Brands" && part["brand"] != selectedBrand) return false;
      if (selectedCompatibility != "All Vehicles" && !(part["compatibility"] as List).contains(selectedCompatibility)) return false;
      if (selectedAvailability != "All" && part["availability"] != selectedAvailability) return false;
      if (searchQuery.isNotEmpty) {
        final query = searchQuery.toLowerCase();
        if (!part["name"].toString().toLowerCase().contains(query) &&
            !part["partNumber"].toString().toLowerCase().contains(query) &&
            !part["brand"].toString().toLowerCase().contains(query)) {
          return false;
        }
      }
      return true;
    }).toList();
  }

  Widget _buildCatalogTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Search and Filters
          QTextField(
            label: "Search parts...",
            value: searchQuery,
            hint: "Part name, number, or brand",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
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
                  label: "Brand",
                  items: brandItems,
                  value: selectedBrand,
                  onChanged: (value, label) {
                    selectedBrand = value;
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
                  label: "Vehicle Compatibility",
                  items: compatibilityItems,
                  value: selectedCompatibility,
                  onChanged: (value, label) {
                    selectedCompatibility = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Availability",
                  items: availabilityItems,
                  value: selectedAvailability,
                  onChanged: (value, label) {
                    selectedAvailability = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          // Results Header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: primaryColor.withAlpha(100)),
            ),
            child: Row(
              children: [
                Icon(Icons.inventory, color: primaryColor),
                SizedBox(width: spSm),
                Text(
                  "Found ${filteredParts.length} parts",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "Sorted by popularity",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),

          // Parts Grid
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 300,
            children: filteredParts.map((part) => _buildPartCard(part)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDealsTab() {
    final dealsOfTheDay = filteredParts.where((p) => p["isDealOfTheDay"] as bool).toList();
    final discountedParts = filteredParts.where((p) => (p["discount"] as int) > 0).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Deal of the Day
          if (dealsOfTheDay.isNotEmpty) ...[
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [dangerColor, warningColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.local_fire_department, color: Colors.white, size: 24),
                      SizedBox(width: spSm),
                      Text(
                        "Deal of the Day",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  ...dealsOfTheDay.map((part) => _buildDealCard(part, true)),
                ],
              ),
            ),
          ],

          // Discounted Parts
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Special Discounts",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 280,
                  children: discountedParts.map((part) => _buildDealCard(part, false)).toList(),
                ),
              ],
            ),
          ),

          // Bulk Order Discounts
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: successColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: successColor.withAlpha(100)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.inventory_2, color: successColor),
                    SizedBox(width: spSm),
                    Text(
                      "Bulk Order Discounts",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                _buildBulkDiscountItem("10+ items", "5% off", successColor),
                _buildBulkDiscountItem("25+ items", "10% off", infoColor),
                _buildBulkDiscountItem("50+ items", "15% off", warningColor),
                _buildBulkDiscountItem("100+ items", "20% off", dangerColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersTab() {
    final orderHistory = [
      {
        "orderId": "ORD-2024-001",
        "date": "2024-06-15",
        "status": "Delivered",
        "items": 3,
        "total": 245.48,
        "supplier": "AutoParts Plus",
        "estimatedDelivery": "2024-06-18",
        "trackingNumber": "1Z999AA1234567890"
      },
      {
        "orderId": "ORD-2024-002", 
        "date": "2024-06-10",
        "status": "In Transit",
        "items": 1,
        "total": 89.99,
        "supplier": "Performance Parts Co",
        "estimatedDelivery": "2024-06-20",
        "trackingNumber": "1Z999BB1234567891"
      },
      {
        "orderId": "ORD-2024-003",
        "date": "2024-06-08",
        "status": "Processing",
        "items": 2,
        "total": 167.50,
        "supplier": "Fleet Supply Direct",
        "estimatedDelivery": "2024-06-22",
        "trackingNumber": "Pending"
      }
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Order Summary
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 160,
            children: [
              _buildStatCard("Total Orders", "${orderHistory.length}", Icons.shopping_cart, primaryColor),
              _buildStatCard("Active Orders", "2", Icons.pending, warningColor),
              _buildStatCard("This Month", "\$502.97", Icons.attach_money, successColor),
              _buildStatCard("Avg Order", "\$167.65", Icons.analytics, infoColor),
            ],
          ),

          // Order History
          Container(
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
                    Text(
                      "Order History",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "View All",
                      icon: Icons.list,
                      size: bs.sm,
                      onPressed: () {
                        ss("Viewing all orders");
                      },
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                ...orderHistory.map((order) => _buildOrderItem(order)),
              ],
            ),
          ),

          // Quick Reorder
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Quick Reorder",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                Text(
                  "Frequently ordered parts for easy reordering",
                  style: TextStyle(color: disabledBoldColor),
                ),
                SizedBox(height: spMd),
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 200,
                  children: filteredParts.where((p) => p["isPopular"] as bool).take(4).map((part) => _buildQuickOrderCard(part)).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInventoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Inventory Status
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 160,
            children: [
              _buildStatCard("Total Parts", "${filteredParts.length}", Icons.inventory, primaryColor),
              _buildStatCard("In Stock", "${filteredParts.where((p) => p["availability"] == "In Stock").length}", Icons.check_circle, successColor),
              _buildStatCard("Low Stock", "${filteredParts.where((p) => p["availability"] == "Low Stock").length}", Icons.warning, warningColor),
              _buildStatCard("Out of Stock", "0", Icons.cancel, dangerColor),
            ],
          ),

          // Stock Alerts
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Stock Alerts",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                ...filteredParts.where((p) => p["availability"] == "Low Stock").map((part) => _buildStockAlertItem(part)),
              ],
            ),
          ),

          // Inventory by Category
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Inventory by Category",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                _buildCategoryInventoryChart(),
              ],
            ),
          ),

          // Supplier Information
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Supplier Information",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                _buildSupplierList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPartCard(Map<String, dynamic> part) {
    Color availabilityColor = part["availability"] == "In Stock" ? successColor :
                             part["availability"] == "Low Stock" ? warningColor : dangerColor;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: part["isPopular"] ? Border.all(color: warningColor.withAlpha(100), width: 2) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Part Image
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusSm),
              image: DecorationImage(
                image: NetworkImage("${part["imageUrl"]}"),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                if (part["isPopular"])
                  Positioned(
                    top: spSm,
                    left: spSm,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: warningColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "Popular",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                if ((part["discount"] as int) > 0)
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
                        "-${part["discount"]}%",
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
          ),
          SizedBox(height: spMd),

          // Part Info
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
          SizedBox(height: spXs),
          Text(
            "${part["brand"]} • ${part["partNumber"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),

          // Rating
          Row(
            children: [
              Icon(Icons.star, color: warningColor, size: 14),
              SizedBox(width: spXs),
              Text(
                "${part["rating"]}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: warningColor,
                ),
              ),
              Text(
                " (${part["reviewCount"]})",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),

          // Compatibility
          Text(
            "Fits: ${(part["compatibility"] as List).take(2).join(", ")}${(part["compatibility"] as List).length > 2 ? "..." : ""}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: spMd),

          // Price and Availability
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if ((part["discount"] as int) > 0) ...[
                      Text(
                        "\$${(part["originalPrice"] as double).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                    Text(
                      "\$${(part["price"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: availabilityColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${part["availability"]}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),

          // Actions
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Add to Cart",
                  icon: Icons.add_shopping_cart,
                  size: bs.sm,
                  onPressed: () {
                    ss("Added ${part["name"]} to cart");
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.info,
                size: bs.sm,
                onPressed: () {
                  ss("Viewing details for ${part["name"]}");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDealCard(Map<String, dynamic> part, bool isDealOfDay) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: isDealOfDay ? Colors.white.withAlpha(20) : Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(
          color: isDealOfDay ? Colors.white.withAlpha(100) : dangerColor.withAlpha(100),
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusSm),
              image: DecorationImage(
                image: NetworkImage("${part["imageUrl"]}"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${part["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDealOfDay ? Colors.white : primaryColor,
                  ),
                ),
                Text(
                  "${part["brand"]} • ${part["partNumber"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: isDealOfDay ? Colors.white.withAlpha(180) : disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    if ((part["discount"] as int) > 0) ...[
                      Text(
                        "\$${(part["originalPrice"] as double).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 12,
                          color: isDealOfDay ? Colors.white.withAlpha(180) : disabledBoldColor,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      SizedBox(width: spSm),
                    ],
                    Text(
                      "\$${(part["price"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDealOfDay ? Colors.white : dangerColor,
                      ),
                    ),
                    if ((part["discount"] as int) > 0) ...[
                      SizedBox(width: spSm),
                      Text(
                        "Save ${part["discount"]}%",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isDealOfDay ? Colors.white : successColor,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          QButton(
            label: "Add to Cart",
            size: bs.sm,
            onPressed: () {
              ss("Added ${part["name"]} to cart");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBulkDiscountItem(String quantity, String discount, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(100)),
      ),
      child: Row(
        children: [
          Icon(Icons.shopping_cart, color: color, size: 20),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              quantity,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
          Text(
            discount,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Icon(icon, size: 32, color: color),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItem(Map<String, dynamic> order) {
    Color statusColor = order["status"] == "Delivered" ? successColor :
                       order["status"] == "In Transit" ? warningColor : infoColor;

    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border(
          left: BorderSide(width: 4, color: statusColor),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${order["orderId"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${order["date"]} • ${order["items"]} items",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${order["supplier"]}",
                  style: TextStyle(fontSize: 12),
                ),
                if (order["trackingNumber"] != "Pending")
                  Text(
                    "Tracking: ${order["trackingNumber"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                    ),
                  ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
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
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: spXs),
              Text(
                "\$${(order["total"] as double).toStringAsFixed(2)}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickOrderCard(Map<String, dynamic> part) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${part["name"]}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: spXs),
          Text(
            "${part["brand"]} • ${part["partNumber"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Text(
                  "\$${(part["price"] as double).toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                icon: Icons.add_shopping_cart,
                size: bs.sm,
                onPressed: () {
                  ss("Added ${part["name"]} to cart");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStockAlertItem(Map<String, dynamic> part) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: warningColor.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: warningColor.withAlpha(100)),
      ),
      child: Row(
        children: [
          Icon(Icons.warning, color: warningColor, size: 20),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${part["name"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Only ${part["quantity"]} left in stock",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            label: "Reorder",
            size: bs.sm,
            onPressed: () {
              ss("Reordering ${part["name"]}");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryInventoryChart() {
    final categories = ["Engine", "Brakes", "Suspension", "Lighting", "Tires"];
    final counts = categories.map((cat) => filteredParts.where((p) => p["category"] == cat).length).toList();
    final maxCount = counts.reduce((a, b) => a > b ? a : b);

    return Column(
      children: List.generate(categories.length, (index) {
        final percentage = maxCount > 0 ? (counts[index] / maxCount) : 0.0;
        final colors = [primaryColor, successColor, warningColor, infoColor, dangerColor];
        
        return Container(
          margin: EdgeInsets.only(bottom: spSm),
          child: Row(
            children: [
              SizedBox(
                width: 80,
                child: Text(
                  categories[index],
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
              Expanded(
                child: Container(
                  height: 20,
                  decoration: BoxDecoration(
                    color: disabledColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: percentage,
                    child: Container(
                      decoration: BoxDecoration(
                        color: colors[index % colors.length],
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Text("${counts[index]}", style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildSupplierList() {
    final suppliers = [
      {"name": "AutoParts Plus", "parts": 45, "rating": 4.8, "deliveryTime": "1-2 days"},
      {"name": "Performance Parts Co", "parts": 32, "rating": 4.7, "deliveryTime": "Same day"},
      {"name": "Fleet Supply Direct", "parts": 28, "rating": 4.6, "deliveryTime": "2-3 days"},
      {"name": "Lighting Solutions Inc", "parts": 18, "rating": 4.5, "deliveryTime": "1-2 days"},
    ];

    return Column(
      children: suppliers.map((supplier) {
        return Container(
          margin: EdgeInsets.only(bottom: spSm),
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${supplier["name"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${supplier["parts"]} parts • ${supplier["deliveryTime"]}",
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
                  Icon(Icons.star, color: warningColor, size: 14),
                  Text(
                    " ${supplier["rating"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: warningColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Auto Parts",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Catalog", icon: Icon(Icons.inventory)),
        Tab(text: "Deals", icon: Icon(Icons.local_offer)),
        Tab(text: "Orders", icon: Icon(Icons.shopping_cart)),
        Tab(text: "Inventory", icon: Icon(Icons.warehouse)),
      ],
      tabChildren: [
        _buildCatalogTab(),
        _buildDealsTab(),
        _buildOrdersTab(),
        _buildInventoryTab(),
      ],
      onInit: (tabController) {
        // Optional: Access to TabController if needed
      },
    );
  }
}
