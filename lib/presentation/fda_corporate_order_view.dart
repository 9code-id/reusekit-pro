import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaCorporateOrderView extends StatefulWidget {
  const FdaCorporateOrderView({super.key});

  @override
  State<FdaCorporateOrderView> createState() => _FdaCorporateOrderViewState();
}

class _FdaCorporateOrderViewState extends State<FdaCorporateOrderView> {
  String companyName = "";
  String contactPerson = "";
  String contactEmail = "";
  String contactPhone = "";
  String deliveryAddress = "";
  String specialRequirements = "";
  DateTime eventDate = DateTime.now().add(Duration(days: 7));
  TimeOfDay eventTime = TimeOfDay(hour: 12, minute: 0);
  int guestCount = 50;
  String mealType = "Lunch";
  String budgetRange = "\$15-25 per person";
  
  bool needsSetup = false;
  bool needsCutlery = true;
  bool needsBeverage = true;
  int selectedIndex = 0;

  List<Map<String, dynamic>> corporatePackages = [
    {
      "id": "1",
      "name": "Executive Lunch Package",
      "description": "Premium catered lunch for corporate meetings",
      "pricePerPerson": 28.0,
      "minOrder": 20,
      "includes": ["Main course", "Salad", "Dessert", "Beverages", "Setup service"],
      "cuisine": "International",
      "setupTime": "30 minutes",
      "image": "https://picsum.photos/300/200?random=50&keyword=catering",
      "rating": 4.9,
      "provider": "Elite Catering",
    },
    {
      "id": "2",
      "name": "Office Breakfast Box",
      "description": "Individual breakfast boxes for team meetings",
      "pricePerPerson": 15.0,
      "minOrder": 15,
      "includes": ["Sandwich", "Fresh fruit", "Yogurt", "Coffee", "Napkins"],
      "cuisine": "Continental",
      "setupTime": "15 minutes",
      "image": "https://picsum.photos/300/200?random=51&keyword=breakfast",
      "rating": 4.7,
      "provider": "Morning Fresh",
    },
    {
      "id": "3",
      "name": "Team Dinner Buffet",
      "description": "Complete buffet setup for corporate events",
      "pricePerPerson": 35.0,
      "minOrder": 30,
      "includes": ["Multiple entrees", "Sides", "Salads", "Desserts", "Full service"],
      "cuisine": "Mixed",
      "setupTime": "60 minutes",
      "image": "https://picsum.photos/300/200?random=52&keyword=buffet",
      "rating": 4.8,
      "provider": "Grand Events",
    },
  ];

  List<Map<String, dynamic>> pastOrders = [
    {
      "id": "1",
      "eventName": "Q4 Board Meeting",
      "date": "2024-11-15",
      "guests": 25,
      "package": "Executive Lunch Package",
      "total": 700.0,
      "status": "Completed",
      "rating": 5,
      "feedback": "Excellent service and food quality",
    },
    {
      "id": "2",
      "eventName": "Team Building Breakfast",
      "date": "2024-10-22",
      "guests": 40,
      "package": "Office Breakfast Box",
      "total": 600.0,
      "status": "Completed",
      "rating": 4,
      "feedback": "Good variety, timely delivery",
    },
    {
      "id": "3",
      "eventName": "Annual Dinner",
      "date": "2024-09-10",
      "guests": 80,
      "package": "Team Dinner Buffet",
      "total": 2800.0,
      "status": "Completed",
      "rating": 5,
      "feedback": "Outstanding experience",
    },
  ];

  List<String> mealTypes = ["Breakfast", "Brunch", "Lunch", "Afternoon Tea", "Dinner"];
  List<String> budgetRanges = [
    "\$10-15 per person",
    "\$15-25 per person",
    "\$25-35 per person",
    "\$35-50 per person",
    "\$50+ per person"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Corporate Catering"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () => _showCorporateInfo(),
          ),
        ],
      ),
      body: QTabBar(
        withoutAppBar: true,
        selectedIndex: selectedIndex,
        tabs: [
          Tab(text: "Order Form", icon: Icon(Icons.assignment)),
          Tab(text: "Packages", icon: Icon(Icons.restaurant_menu)),
          Tab(text: "History", icon: Icon(Icons.history)),
        ],
        tabChildren: [
          _buildOrderFormTab(),
          _buildPackagesTab(),
          _buildHistoryTab(),
        ],
      ),
    );
  }

  Widget _buildOrderFormTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(150)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.business,
                  size: 48,
                  color: Colors.white,
                ),
                SizedBox(height: spSm),
                Text(
                  "Corporate Catering Order",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Professional catering for your business events",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withAlpha(230),
                  ),
                ),
              ],
            ),
          ),

          // Company Information
          Text(
            "Company Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spMd,
              children: [
                QTextField(
                  label: "Company Name",
                  value: companyName,
                  hint: "Enter your company name",
                  onChanged: (value) {
                    companyName = value;
                    setState(() {});
                  },
                ),
                
                QTextField(
                  label: "Contact Person",
                  value: contactPerson,
                  hint: "Name of the person organizing",
                  onChanged: (value) {
                    contactPerson = value;
                    setState(() {});
                  },
                ),
                
                QTextField(
                  label: "Contact Email",
                  value: contactEmail,
                  hint: "Email for order confirmations",
                  onChanged: (value) {
                    contactEmail = value;
                    setState(() {});
                  },
                ),
                
                QTextField(
                  label: "Contact Phone",
                  value: contactPhone,
                  hint: "Phone number for coordination",
                  onChanged: (value) {
                    contactPhone = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Event Details
          Text(
            "Event Details",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spMd,
              children: [
                QDatePicker(
                  label: "Event Date",
                  value: eventDate,
                  onChanged: (value) {
                    eventDate = value;
                    setState(() {});
                  },
                ),
                
                QTimePicker(
                  label: "Event Time",
                  value: eventTime,
                  onChanged: (value) {
                    eventTime = value!;
                    setState(() {});
                  },
                ),
                
                QNumberField(
                  label: "Number of Guests",
                  value: guestCount.toString(),
                  onChanged: (value) {
                    guestCount = int.tryParse(value) ?? 50;
                    setState(() {});
                  },
                ),
                
                QDropdownField(
                  label: "Meal Type",
                  items: mealTypes.map((type) => {
                    "label": type,
                    "value": type,
                  }).toList(),
                  value: mealType,
                  onChanged: (value, label) {
                    mealType = value;
                    setState(() {});
                  },
                ),                QDropdownField(
                  label: "Budget Range",
                  items: budgetRanges.map((range) => {
                    "label": range,
                    "value": range,
                  }).toList(),
                  value: budgetRange,
                  onChanged: (value, label) {
                    budgetRange = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Delivery Information
          Text(
            "Delivery Information",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          QMemoField(
            label: "Delivery Address",
            value: deliveryAddress,
            hint: "Complete address including floor and room details",
            onChanged: (value) {
              deliveryAddress = value;
              setState(() {});
            },
          ),

          // Additional Services
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Additional Services",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                Row(
                  children: [
                    Checkbox(
                      value: needsSetup,
                      onChanged: (value) {
                        needsSetup = value!;
                        setState(() {});
                      },
                      activeColor: primaryColor,
                    ),
                    Expanded(
                      child: Text(
                        "Setup and serving assistance (+\$5 per person)",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
                
                Row(
                  children: [
                    Checkbox(
                      value: needsCutlery,
                      onChanged: (value) {
                        needsCutlery = value!;
                        setState(() {});
                      },
                      activeColor: primaryColor,
                    ),
                    Expanded(
                      child: Text(
                        "Disposable cutlery and plates",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
                
                Row(
                  children: [
                    Checkbox(
                      value: needsBeverage,
                      onChanged: (value) {
                        needsBeverage = value!;
                        setState(() {});
                      },
                      activeColor: primaryColor,
                    ),
                    Expanded(
                      child: Text(
                        "Beverages (coffee, tea, soft drinks)",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Special Requirements
          QMemoField(
            label: "Special Requirements",
            value: specialRequirements,
            hint: "Any dietary restrictions, allergies, or special requests",
            onChanged: (value) {
              specialRequirements = value;
              setState(() {});
            },
          ),

          // Submit Button
          Container(
            width: double.infinity,
            child: QButton(
              label: "Get Quote & Submit Order",
              size: bs.md,
              onPressed: () => _submitCorporateOrder(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPackagesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Header
          Row(
            children: [
              Icon(
                Icons.restaurant_menu,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Corporate Packages",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          
          Text(
            "Pre-designed packages for different corporate events",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),

          // Packages
          Column(
            spacing: spMd,
            children: corporatePackages.map((package) => _buildPackageCard(package)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPackageCard(Map<String, dynamic> package) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Package Image
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusSm)),
            child: Stack(
              children: [
                Image.network(
                  "${package["image"]}",
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: spSm,
                  right: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.white,
                          size: 12,
                        ),
                        SizedBox(width: 2),
                        Text(
                          "${package["rating"]}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                // Package Info
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${package["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${package["provider"]}",
                            style: TextStyle(
                              fontSize: 13,
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
                          "\$${(package["pricePerPerson"] as double).toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "per person",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                // Description
                Text(
                  "${package["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),

                // Package Details
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.people,
                            color: primaryColor,
                            size: 16,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Minimum order: ${package["minOrder"]} people",
                            style: TextStyle(
                              fontSize: 13,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.schedule,
                            color: primaryColor,
                            size: 16,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Setup time: ${package["setupTime"]}",
                            style: TextStyle(
                              fontSize: 13,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.restaurant,
                            color: primaryColor,
                            size: 16,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Cuisine: ${package["cuisine"]}",
                            style: TextStyle(
                              fontSize: 13,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Includes
                Text(
                  "Includes:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: (package["includes"] as List).map((item) => Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "$item",
                      style: TextStyle(
                        fontSize: 11,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )).toList(),
                ),

                // Select Package Button
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Select This Package",
                    size: bs.sm,
                    onPressed: () => _selectPackage(package),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Header
          Row(
            children: [
              Icon(
                Icons.history,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Order History",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          
          Text(
            "Your corporate catering order history",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),

          // Past Orders
          Column(
            spacing: spMd,
            children: pastOrders.map((order) => _buildOrderCard(order)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          // Order Header
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${order["eventName"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${DateTime.parse(order["date"]).dMMMy}",
                      style: TextStyle(
                        fontSize: 13,
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
                    "\$${(order["total"] as double).toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${order["status"]}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Order Details
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              spacing: spXs,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.restaurant_menu,
                      color: primaryColor,
                      size: 16,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${order["package"]}",
                      style: TextStyle(
                        fontSize: 13,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.people,
                      color: primaryColor,
                      size: 16,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${order["guests"]} guests",
                      style: TextStyle(
                        fontSize: 13,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Rating & Feedback
          if (order["rating"] != null) ...[
            Row(
              children: [
                Text(
                  "Rating: ",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                ...List.generate(5, (index) => Icon(
                  Icons.star,
                  size: 16,
                  color: index < (order["rating"] as int) 
                      ? warningColor 
                      : disabledBoldColor,
                )),
              ],
            ),
            if (order["feedback"] != null) ...[
              Text(
                "\"${order["feedback"]}\"",
                style: TextStyle(
                  fontSize: 13,
                  color: disabledBoldColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ],

          // Actions
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Reorder",
                  size: bs.sm,
                  onPressed: () => _reorder(order),
                ),
              ),
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () => _viewOrderDetails(order),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showCorporateInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.info_outline, color: primaryColor),
            SizedBox(width: spSm),
            Text("Corporate Catering"),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Our Corporate Catering Services:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Text("• Minimum 15 people for all orders"),
            Text("• 48-hour advance notice required"),
            Text("• Professional setup and cleanup"),
            Text("• Customizable menus available"),
            Text("• Volume discounts for large orders"),
            SizedBox(height: spMd),
            Text(
              "Need Help?",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Text("Contact our corporate team:"),
            Text("📞 (555) 123-4567"),
            Text("📧 corporate@fooddelivery.com"),
          ],
        ),
        actions: [
          QButton(
            label: "Got it",
            size: bs.sm,
            onPressed: () => back(),
          ),
        ],
      ),
    );
  }
  void _submitCorporateOrder() {
    if (companyName.isEmpty || contactPerson.isEmpty || contactEmail.isEmpty) {
      se("Please fill in all required company information");
      return;
    }
    
    double estimatedTotal = ((guestCount * 25.0) + (needsSetup ? (guestCount * 5.0) : 0.0));
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Order Confirmation"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Company: $companyName"),
            Text("Event: ${eventDate.dMMMy} at ${eventTime.kkmm}"),
            Text("Guests: $guestCount people"),
            Text("Meal Type: $mealType"),
            SizedBox(height: spMd),
            Text(
              "Estimated Total: \$${estimatedTotal.toStringAsFixed(2)}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            Text(
              "Our team will contact you within 2 business hours with a detailed quote and menu options.",
              style: TextStyle(fontSize: 13),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Confirm",
            size: bs.sm,
            onPressed: () {
              back();
              ss("Corporate order submitted successfully! We'll contact you soon.");
            },
          ),
        ],
      ),
    );
  }

  void _selectPackage(Map<String, dynamic> package) {
    ss("Selected ${package["name"]} package");
    selectedIndex = 0;
    setState(() {});
  }

  void _reorder(Map<String, dynamic> order) {
    ss("Reordering ${order["eventName"]} package");
  }

  void _viewOrderDetails(Map<String, dynamic> order) {
    ss("Viewing details for ${order["eventName"]}");
  }
}
