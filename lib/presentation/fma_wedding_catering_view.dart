import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaWeddingCateringView extends StatefulWidget {
  const FmaWeddingCateringView({super.key});

  @override
  State<FmaWeddingCateringView> createState() => _FmaWeddingCateringViewState();
}

class _FmaWeddingCateringViewState extends State<FmaWeddingCateringView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedStatus = "all";
  String selectedPackage = "all";
  String selectedSeason = "all";

  List<Map<String, dynamic>> weddingOrders = [
    {
      "id": "WED-2024-001",
      "coupleName": "Sarah & Michael Johnson",
      "weddingDate": "2024-07-15",
      "venue": "Grand Ballroom Hotel",
      "guestCount": 200,
      "package": "Premium Gold",
      "totalAmount": 25000.0,
      "status": "confirmed",
      "menuStyle": "Buffet & Plated",
      "coordinator": "Emma Wilson",
      "tastingDate": "2024-05-20",
      "paymentStatus": "50% paid",
      "specialRequests": "Vegan options, Gluten-free cake",
      "setupTime": "14:00",
      "eventTime": "18:00",
      "contactPhone": "+1-555-0123",
      "contactEmail": "sarah.johnson@email.com",
      "deposit": 5000.0,
      "balance": 20000.0,
      "lastUpdated": "2024-04-15T10:30:00Z"
    },
    {
      "id": "WED-2024-002",
      "coupleName": "David & Jennifer Martinez",
      "weddingDate": "2024-08-22",
      "venue": "Sunset Garden Resort",
      "guestCount": 150,
      "package": "Classic Silver",
      "totalAmount": 18000.0,
      "status": "pending_tasting",
      "menuStyle": "Family Style",
      "coordinator": "Lisa Chen",
      "tastingDate": "2024-05-25",
      "paymentStatus": "Deposit paid",
      "specialRequests": "Kosher menu, Late night snacks",
      "setupTime": "15:00",
      "eventTime": "17:30",
      "contactPhone": "+1-555-0124",
      "contactEmail": "david.martinez@email.com",
      "deposit": 3600.0,
      "balance": 14400.0,
      "lastUpdated": "2024-04-14T14:20:00Z"
    },
    {
      "id": "WED-2024-003",
      "coupleName": "Robert & Amanda Taylor",
      "weddingDate": "2024-09-10",
      "venue": "Historic Manor Estate",
      "guestCount": 300,
      "package": "Luxury Platinum",
      "totalAmount": 45000.0,
      "status": "planning",
      "menuStyle": "Multi-Course Plated",
      "coordinator": "Victoria Stone",
      "tastingDate": "2024-06-05",
      "paymentStatus": "Contract signed",
      "specialRequests": "Wine pairing, Midnight dessert bar",
      "setupTime": "12:00",
      "eventTime": "16:00",
      "contactPhone": "+1-555-0125",
      "contactEmail": "robert.taylor@email.com",
      "deposit": 9000.0,
      "balance": 36000.0,
      "lastUpdated": "2024-04-13T16:45:00Z"
    },
    {
      "id": "WED-2024-004",
      "coupleName": "James & Nicole Brown",
      "weddingDate": "2024-06-30",
      "venue": "Lakeside Pavilion",
      "guestCount": 120,
      "package": "Intimate Gold",
      "totalAmount": 15000.0,
      "status": "completed",
      "menuStyle": "Cocktail Reception",
      "coordinator": "Maria Rodriguez",
      "tastingDate": "2024-04-10",
      "paymentStatus": "Fully paid",
      "specialRequests": "Outdoor setup, Weather backup plan",
      "setupTime": "16:00",
      "eventTime": "19:00",
      "contactPhone": "+1-555-0126",
      "contactEmail": "james.brown@email.com",
      "deposit": 3000.0,
      "balance": 0.0,
      "lastUpdated": "2024-07-01T09:15:00Z"
    }
  ];

  List<Map<String, dynamic>> cateringPackages = [
    {
      "name": "Intimate Silver",
      "description": "Perfect for small weddings up to 75 guests",
      "pricePerPerson": 65.0,
      "minGuests": 30,
      "maxGuests": 75,
      "includes": [
        "3-course plated dinner",
        "Welcome cocktail hour",
        "Wedding cake service",
        "Basic linens & tableware",
        "Service coordinator"
      ],
      "addOns": [
        "Premium bar package",
        "Upgraded linens",
        "Floral centerpieces"
      ]
    },
    {
      "name": "Classic Gold",
      "description": "Elegant catering for medium weddings",
      "pricePerPerson": 85.0,
      "minGuests": 75,
      "maxGuests": 150,
      "includes": [
        "4-course plated dinner",
        "Extended cocktail hour",
        "Premium bar service",
        "Wedding cake & dessert station",
        "Upgraded linens & tableware",
        "Dedicated coordinator"
      ],
      "addOns": [
        "Live cooking stations",
        "Champagne toast",
        "Late night snacks",
        "Brunch service"
      ]
    },
    {
      "name": "Premium Platinum",
      "description": "Luxury catering for grand celebrations",
      "pricePerPerson": 125.0,
      "minGuests": 150,
      "maxGuests": 300,
      "includes": [
        "5-course gourmet dinner",
        "Premium cocktail experience",
        "Top-shelf bar service",
        "Multi-tier wedding cake",
        "Luxury linens & china",
        "Full-service coordination",
        "Sommelier service"
      ],
      "addOns": [
        "Wine pairing dinner",
        "Midnight dessert bar",
        "Brunch the next day",
        "Rehearsal dinner"
      ]
    }
  ];

  List<Map<String, dynamic>> seasonalMenus = [
    {
      "season": "Spring",
      "theme": "Fresh & Light",
      "featuredIngredients": [
        "Asparagus",
        "Spring lamb",
        "Fresh herbs",
        "Strawberries",
        "Peas"
      ],
      "sampleMenu": {
        "appetizer": "Pan-seared scallops with pea puree",
        "soup": "Spring vegetable bisque",
        "salad": "Mixed greens with strawberry vinaigrette",
        "main": "Herb-crusted rack of lamb",
        "dessert": "Lemon lavender wedding cake"
      }
    },
    {
      "season": "Summer",
      "theme": "Garden Fresh",
      "featuredIngredients": [
        "Tomatoes",
        "Zucchini",
        "Peaches",
        "Corn",
        "Berries"
      ],
      "sampleMenu": {
        "appetizer": "Caprese skewers with heirloom tomatoes",
        "soup": "Chilled gazpacho",
        "salad": "Peach and burrata salad",
        "main": "Grilled salmon with summer vegetables",
        "dessert": "Berry medley wedding cake"
      }
    },
    {
      "season": "Fall",
      "theme": "Harvest Celebration",
      "featuredIngredients": [
        "Pumpkin",
        "Apples",
        "Root vegetables",
        "Mushrooms",
        "Cranberries"
      ],
      "sampleMenu": {
        "appetizer": "Butternut squash soup shooters",
        "soup": "Wild mushroom bisque",
        "salad": "Apple walnut salad",
        "main": "Roasted turkey with sage stuffing",
        "dessert": "Spiced apple wedding cake"
      }
    }
  ];

  List<Map<String, dynamic>> get filteredOrders {
    return weddingOrders.where((order) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${order["coupleName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${order["venue"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${order["id"]}".toLowerCase().contains(searchQuery.toLowerCase());

      bool matchesStatus = selectedStatus == "all" || order["status"] == selectedStatus;
      bool matchesPackage = selectedPackage == "all" || "${order["package"]}".contains(selectedPackage);

      return matchesSearch && matchesStatus && matchesPackage;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "confirmed":
        return successColor;
      case "planning":
        return warningColor;
      case "pending_tasting":
        return infoColor;
      case "completed":
        return primaryColor;
      default:
        return disabledColor;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case "confirmed":
        return "Confirmed";
      case "planning":
        return "Planning";
      case "pending_tasting":
        return "Pending Tasting";
      case "completed":
        return "Completed";
      default:
        return "Unknown";
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Wedding Catering",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Orders", icon: Icon(Icons.favorite)),
        Tab(text: "Packages", icon: Icon(Icons.card_giftcard)),
        Tab(text: "Seasonal Menus", icon: Icon(Icons.restaurant_menu)),
      ],
      tabChildren: [
        _buildWeddingOrdersTab(),
        _buildPackagesTab(),
        _buildSeasonalMenusTab(),
      ],
    );
  }

  Widget _buildWeddingOrdersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
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
              spacing: spSm,
              children: [
                QTextField(
                  label: "Search orders, couples, or venues",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Status",
                        items: [
                          {"label": "All Status", "value": "all"},
                          {"label": "Planning", "value": "planning"},
                          {"label": "Pending Tasting", "value": "pending_tasting"},
                          {"label": "Confirmed", "value": "confirmed"},
                          {"label": "Completed", "value": "completed"},
                        ],
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
                        label: "Package",
                        items: [
                          {"label": "All Packages", "value": "all"},
                          {"label": "Silver", "value": "Silver"},
                          {"label": "Gold", "value": "Gold"},
                          {"label": "Platinum", "value": "Platinum"},
                        ],
                        value: selectedPackage,
                        onChanged: (value, label) {
                          selectedPackage = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Orders Summary
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
                  "Wedding Orders Overview",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${filteredOrders.length}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Total Orders",
                              style: TextStyle(
                                fontSize: 12,
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
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "\$${((filteredOrders.fold(0.0, (sum, order) => sum + (order["totalAmount"] as double))) / 1000).toStringAsFixed(0)}K",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Total Revenue",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Wedding Orders List
          ...filteredOrders.map((order) {
            return Container(
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
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${order["coupleName"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${order["id"]} • ${order["venue"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getStatusColor("${order["status"]}").withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          _getStatusText("${order["status"]}"),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: _getStatusColor("${order["status"]}"),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(height: 1),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Wedding Date",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${DateTime.parse("${order["weddingDate"]}T00:00:00Z").dMMMy}",
                              style: TextStyle(
                                fontSize: 12,
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
                              "Guests",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${order["guestCount"]} people",
                              style: TextStyle(
                                fontSize: 12,
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
                              "Package",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${order["package"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
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
                              "Total Amount",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "\$${((order["totalAmount"] as double)).currency}",
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Coordinator",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${order["coordinator"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      QButton(
                        label: "View Details",
                        size: bs.sm,
                        onPressed: () {
                          // Navigate to order details
                        },
                      ),
                    ],
                  ),
                  if (order["specialRequests"] != null && "${order["specialRequests"]}".isNotEmpty)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Special Requests:",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: infoColor,
                            ),
                          ),
                          Text(
                            "${order["specialRequests"]}",
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
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildPackagesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Package Overview
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
                  "Wedding Catering Packages",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Our comprehensive wedding catering packages are designed to make your special day unforgettable. Each package includes professional service, high-quality ingredients, and attention to detail.",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),

          // Packages List
          ...cateringPackages.map((package) {
            return Container(
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
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${package["name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${package["description"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "\$${(package["pricePerPerson"] as double).toStringAsFixed(0)}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "per person",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(height: 1),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Guest Range",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${package["minGuests"]} - ${package["maxGuests"]} guests",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      QButton(
                        label: "Customize",
                        size: bs.sm,
                        onPressed: () {
                          // Navigate to package customization
                        },
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "Package Includes:",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        ...(package["includes"] as List).map((item) {
                          return Row(
                            children: [
                              Icon(
                                Icons.check_circle,
                                size: 12,
                                color: successColor,
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "$item",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                  if ((package["addOns"] as List).isNotEmpty)
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "Available Add-ons:",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: warningColor,
                            ),
                          ),
                          ...(package["addOns"] as List).map((item) {
                            return Row(
                              children: [
                                Icon(
                                  Icons.add_circle_outline,
                                  size: 12,
                                  color: warningColor,
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    "$item",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildSeasonalMenusTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Seasonal Menu Overview
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
                  "Seasonal Wedding Menus",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Our seasonal menus feature the finest ingredients at their peak freshness. Each season offers unique flavors and presentations to complement your wedding celebration.",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),

          // Seasonal Menus List
          ...seasonalMenus.map((menu) {
            return Container(
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
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${menu["season"]} Wedding Menu",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${menu["theme"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                      QButton(
                        label: "Request Tasting",
                        size: bs.sm,
                        onPressed: () {
                          // Schedule tasting appointment
                        },
                      ),
                    ],
                  ),
                  Divider(height: 1),
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "Featured Seasonal Ingredients:",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: successColor,
                          ),
                        ),
                        Wrap(
                          spacing: spXs,
                          runSpacing: spXs,
                          children: (menu["featuredIngredients"] as List).map((ingredient) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "$ingredient",
                                style: TextStyle(
                                  fontSize: 9,
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
                  Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Text(
                          "Sample Menu:",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        _buildMenuCourse("Appetizer", "${(menu["sampleMenu"] as Map)["appetizer"]}"),
                        _buildMenuCourse("Soup", "${(menu["sampleMenu"] as Map)["soup"]}"),
                        _buildMenuCourse("Salad", "${(menu["sampleMenu"] as Map)["salad"]}"),
                        _buildMenuCourse("Main Course", "${(menu["sampleMenu"] as Map)["main"]}"),
                        _buildMenuCourse("Dessert", "${(menu["sampleMenu"] as Map)["dessert"]}"),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),

          // Menu Customization Info
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: infoColor.withAlpha(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: infoColor,
                      size: 20,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Menu Customization",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "All our seasonal menus can be customized to accommodate dietary restrictions, cultural preferences, and personal tastes. Our executive chef will work with you to create the perfect menu for your special day.",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "• Vegetarian & vegan options available\n• Gluten-free alternatives\n• Halal & kosher preparations\n• Custom cultural dishes\n• Wine pairing recommendations",
                  style: TextStyle(
                    fontSize: 11,
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

  Widget _buildMenuCourse(String course, String dish) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 60,
          child: Text(
            "$course:",
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
        ),
        Expanded(
          child: Text(
            dish,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ),
      ],
    );
  }
}
