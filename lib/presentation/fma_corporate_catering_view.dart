import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaCorporateCateringView extends StatefulWidget {
  const FmaCorporateCateringView({super.key});

  @override
  State<FmaCorporateCateringView> createState() => _FmaCorporateCateringViewState();
}

class _FmaCorporateCateringViewState extends State<FmaCorporateCateringView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedStatus = "all";
  String selectedService = "all";
  String selectedPriority = "all";

  List<Map<String, dynamic>> corporateOrders = [
    {
      "id": "CORP-2024-001",
      "companyName": "TechCorp Solutions",
      "contactPerson": "Sarah Mitchell",
      "eventType": "Annual Conference",
      "eventDate": "2024-05-20",
      "attendees": 500,
      "serviceType": "Full Day Catering",
      "venue": "Grand Convention Center",
      "totalAmount": 35000.0,
      "status": "confirmed",
      "priority": "high",
      "requirements": "Vegetarian options, Kosher meals, Coffee breaks",
      "setupTime": "06:00",
      "eventDuration": "10 hours",
      "contactEmail": "sarah.mitchell@techcorp.com",
      "contactPhone": "+1-555-0201",
      "accountManager": "David Chen",
      "paymentTerms": "Net 30",
      "invoiceStatus": "pending",
      "lastUpdated": "2024-04-15T09:30:00Z"
    },
    {
      "id": "CORP-2024-002",
      "companyName": "Global Finance Ltd",
      "contactPerson": "Michael Rodriguez",
      "eventType": "Board Meeting",
      "eventDate": "2024-04-25",
      "attendees": 25,
      "serviceType": "Executive Lunch",
      "venue": "Corporate Boardroom",
      "totalAmount": 2500.0,
      "status": "completed",
      "priority": "high",
      "requirements": "Premium menu, Wine service, Formal presentation",
      "setupTime": "11:30",
      "eventDuration": "3 hours",
      "contactEmail": "m.rodriguez@globalfinance.com",
      "contactPhone": "+1-555-0202",
      "accountManager": "Lisa Wang",
      "paymentTerms": "Net 15",
      "invoiceStatus": "paid",
      "lastUpdated": "2024-04-26T16:20:00Z"
    },
    {
      "id": "CORP-2024-003",
      "companyName": "Innovate Startup Inc",
      "contactPerson": "Jennifer Park",
      "eventType": "Product Launch",
      "eventDate": "2024-06-10",
      "attendees": 200,
      "serviceType": "Cocktail Reception",
      "venue": "Rooftop Terrace",
      "totalAmount": 15000.0,
      "status": "planning",
      "priority": "medium",
      "requirements": "Modern presentation, Sustainable packaging, Tech setup",
      "setupTime": "16:00",
      "eventDuration": "4 hours",
      "contactEmail": "jenny.park@innovate.com",
      "contactPhone": "+1-555-0203",
      "accountManager": "Tom Anderson",
      "paymentTerms": "50% advance",
      "invoiceStatus": "deposit_received",
      "lastUpdated": "2024-04-14T11:45:00Z"
    },
    {
      "id": "CORP-2024-004",
      "companyName": "Healthcare Partners",
      "contactPerson": "Dr. Amanda Wilson",
      "eventType": "Medical Conference",
      "eventDate": "2024-07-08",
      "attendees": 300,
      "serviceType": "Multi-Day Catering",
      "venue": "Medical Center Auditorium",
      "totalAmount": 28000.0,
      "status": "quoted",
      "priority": "medium",
      "requirements": "Healthy options, Allergy considerations, Extended hours",
      "setupTime": "07:00",
      "eventDuration": "3 days",
      "contactEmail": "a.wilson@healthcarepartners.com",
      "contactPhone": "+1-555-0204",
      "accountManager": "Emma Thompson",
      "paymentTerms": "Net 30",
      "invoiceStatus": "quote_sent",
      "lastUpdated": "2024-04-13T14:15:00Z"
    }
  ];

  List<Map<String, dynamic>> servicePackages = [
    {
      "name": "Executive Meeting Package",
      "description": "Premium catering for boardroom meetings and executive sessions",
      "duration": "Half Day (4 hours)",
      "attendeeRange": "10-50 people",
      "priceRange": "\$45-65 per person",
      "includes": [
        "Welcome coffee & pastries",
        "Premium lunch service",
        "Afternoon refreshments",
        "Professional table service",
        "Executive presentation setup"
      ],
      "addOns": [
        "Wine service",
        "Audio/visual equipment",
        "Floral arrangements",
        "Custom menu design"
      ]
    },
    {
      "name": "Conference & Convention",
      "description": "Full-scale catering for large corporate events and conferences",
      "duration": "Full Day (8-12 hours)",
      "attendeeRange": "100-1000+ people",
      "priceRange": "\$35-55 per person",
      "includes": [
        "Registration breakfast",
        "Morning & afternoon breaks",
        "Buffet or plated lunch",
        "Networking reception",
        "Multiple service stations"
      ],
      "addOns": [
        "Evening gala dinner",
        "VIP hospitality suite",
        "Branded presentations",
        "Live cooking stations"
      ]
    },
    {
      "name": "Training & Workshop",
      "description": "Focused catering for training sessions and workshops",
      "duration": "Variable (4-8 hours)",
      "attendeeRange": "20-100 people",
      "priceRange": "\$25-40 per person",
      "includes": [
        "Energizing breakfast",
        "Healthy lunch options",
        "Brain-boosting snacks",
        "Continuous beverage service",
        "Flexible scheduling"
      ],
      "addOns": [
        "Dietary specializations",
        "Extended hours service",
        "Group dining options",
        "Wellness menu focus"
      ]
    }
  ];

  List<Map<String, dynamic>> corporateMenus = [
    {
      "category": "Power Breakfast",
      "description": "Start your corporate day with energy and focus",
      "items": [
        {
          "name": "Executive Continental",
          "description": "Premium pastries, fresh fruit, artisan coffee",
          "price": 18.0
        },
        {
          "name": "Protein Power Bowl",
          "description": "Greek yogurt, granola, berries, nuts",
          "price": 15.0
        },
        {
          "name": "Business Builder Platter",
          "description": "Scrambled eggs, bacon, toast, hash browns",
          "price": 22.0
        }
      ]
    },
    {
      "category": "Executive Lunch",
      "description": "Sophisticated lunch options for professional settings",
      "items": [
        {
          "name": "CEO Signature Salad",
          "description": "Mixed greens, grilled chicken, quinoa, vinaigrette",
          "price": 24.0
        },
        {
          "name": "Boardroom Sandwich",
          "description": "Premium deli meats, artisan bread, gourmet sides",
          "price": 28.0
        },
        {
          "name": "Executive Entrée",
          "description": "Grilled salmon, seasonal vegetables, rice pilaf",
          "price": 35.0
        }
      ]
    },
    {
      "category": "Networking Reception",
      "description": "Elegant appetizers and canapés for professional networking",
      "items": [
        {
          "name": "Premium Canapé Selection",
          "description": "Assorted bite-sized appetizers, 6 pieces per person",
          "price": 32.0
        },
        {
          "name": "Artisan Cheese & Charcuterie",
          "description": "Curated selection with accompaniments",
          "price": 28.0
        },
        {
          "name": "Signature Cocktail Hour",
          "description": "Premium bar service with signature drinks",
          "price": 45.0
        }
      ]
    }
  ];

  List<Map<String, dynamic>> get filteredOrders {
    return corporateOrders.where((order) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${order["companyName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${order["contactPerson"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${order["eventType"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${order["id"]}".toLowerCase().contains(searchQuery.toLowerCase());

      bool matchesStatus = selectedStatus == "all" || order["status"] == selectedStatus;
      bool matchesService = selectedService == "all" || "${order["serviceType"]}".contains(selectedService);
      bool matchesPriority = selectedPriority == "all" || order["priority"] == selectedPriority;

      return matchesSearch && matchesStatus && matchesService && matchesPriority;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "confirmed":
        return successColor;
      case "planning":
        return warningColor;
      case "quoted":
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
      case "quoted":
        return "Quoted";
      case "completed":
        return "Completed";
      default:
        return "Unknown";
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return successColor;
      default:
        return disabledColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Corporate Catering",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Orders", icon: Icon(Icons.business)),
        Tab(text: "Service Packages", icon: Icon(Icons.room_service)),
        Tab(text: "Corporate Menus", icon: Icon(Icons.restaurant_menu)),
      ],
      tabChildren: [
        _buildCorporateOrdersTab(),
        _buildServicePackagesTab(),
        _buildCorporateMenusTab(),
      ],
    );
  }

  Widget _buildCorporateOrdersTab() {
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
                  label: "Search companies, contacts, or events",
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
                          {"label": "Quoted", "value": "quoted"},
                          {"label": "Planning", "value": "planning"},
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
                        label: "Priority",
                        items: [
                          {"label": "All Priority", "value": "all"},
                          {"label": "High", "value": "high"},
                          {"label": "Medium", "value": "medium"},
                          {"label": "Low", "value": "low"},
                        ],
                        value: selectedPriority,
                        onChanged: (value, label) {
                          selectedPriority = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Corporate Orders Summary
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
                  "Corporate Orders Overview",
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
                              "Active Orders",
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
                              "Total Value",
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
                          color: warningColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${(filteredOrders.fold(0, (sum, order) => sum + (order["attendees"] as int)) / 1000).toStringAsFixed(1)}K",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "Attendees",
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

          // Corporate Orders List
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
                              "${order["companyName"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${order["id"]} • ${order["contactPerson"]}",
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
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: _getPriorityColor("${order["priority"]}").withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${order["priority"]}".toUpperCase(),
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w600,
                                color: _getPriorityColor("${order["priority"]}"),
                              ),
                            ),
                          ),
                          SizedBox(width: spXs),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: _getStatusColor("${order["status"]}").withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              _getStatusText("${order["status"]}"),
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w600,
                                color: _getStatusColor("${order["status"]}"),
                              ),
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
                              "Event Type",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${order["eventType"]}",
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
                              "Date",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${DateTime.parse("${order["eventDate"]}T00:00:00Z").dMMMy}",
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
                              "Attendees",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${order["attendees"]} people",
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
                              "Service Type",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${order["serviceType"]}",
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
                      QButton(
                        label: "Manage",
                        size: bs.sm,
                        onPressed: () {
                          // Navigate to order management
                        },
                      ),
                    ],
                  ),
                  if (order["requirements"] != null && "${order["requirements"]}".isNotEmpty)
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
                            "Special Requirements:",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: infoColor,
                            ),
                          ),
                          Text(
                            "${order["requirements"]}",
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

  Widget _buildServicePackagesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Service Overview
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
                  "Corporate Catering Services",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Professional catering solutions designed for corporate environments. From intimate boardroom meetings to large-scale conferences, we provide exceptional service that enhances your business events.",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),

          // Service Packages
          ...servicePackages.map((package) {
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
                      QButton(
                        label: "Get Quote",
                        size: bs.sm,
                        onPressed: () {
                          // Request custom quote
                        },
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
                              "Duration",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${package["duration"]}",
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
                              "Attendees",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${package["attendeeRange"]}",
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
                              "Price Range",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${package["priceRange"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
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

          // Corporate Benefits
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: successColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: successColor.withAlpha(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.business_center,
                      color: successColor,
                      size: 20,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Corporate Partnership Benefits",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "• Dedicated account management\n• Volume discounts for regular bookings\n• Flexible payment terms (Net 30/60)\n• Priority scheduling and setup\n• Custom menu development\n• Corporate invoicing and reporting",
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
    );
  }

  Widget _buildCorporateMenusTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Menu Overview
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
                  "Corporate Menu Options",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Professional and sophisticated menu options designed for corporate environments. All items can be customized to accommodate dietary restrictions and company preferences.",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),

          // Menu Categories
          ...corporateMenus.map((menu) {
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
                              "${menu["category"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${menu["description"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      QButton(
                        label: "Customize",
                        size: bs.sm,
                        onPressed: () {
                          // Customize menu
                        },
                      ),
                    ],
                  ),
                  Divider(height: 1),
                  ...(menu["items"] as List).map((item) {
                    return Container(
                      padding: EdgeInsets.all(spXs),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${item["name"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${item["description"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "\$${(item["price"] as double).toStringAsFixed(0)}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            );
          }).toList(),

          // Dietary Options
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
                      Icons.restaurant,
                      color: infoColor,
                      size: 20,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Dietary Accommodations",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "We accommodate all dietary requirements and preferences:",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "• Vegetarian & Vegan options\n• Gluten-free alternatives\n• Kosher & Halal preparations\n• Low-sodium & heart-healthy choices\n• Allergy-conscious menu modifications\n• Keto & paleo-friendly selections",
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
}
