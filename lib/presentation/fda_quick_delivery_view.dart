import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaQuickDeliveryView extends StatefulWidget {
  const FdaQuickDeliveryView({super.key});

  @override
  State<FdaQuickDeliveryView> createState() => _FdaQuickDeliveryViewState();
}

class _FdaQuickDeliveryViewState extends State<FdaQuickDeliveryView> {
  String selectedTimeSlot = "ASAP";
  String selectedLocation = "Home";
  bool expressDelivery = false;
  bool contactlessDelivery = false;
  String specialInstructions = "";
  int selectedIndex = 0;

  List<Map<String, dynamic>> timeSlots = [
    {
      "id": "asap",
      "title": "ASAP",
      "subtitle": "15-25 minutes",
      "extraCost": 0,
      "icon": Icons.flash_on,
      "color": Color(0xFFFF6B35),
    },
    {
      "id": "15min",
      "title": "15 Minutes",
      "subtitle": "Express delivery",
      "extraCost": 3,
      "icon": Icons.bolt,
      "color": Color(0xFFE91E63),
    },
    {
      "id": "30min",
      "title": "30 Minutes",
      "subtitle": "Standard quick",
      "extraCost": 1,
      "icon": Icons.timer,
      "color": Color(0xFF2196F3),
    },
    {
      "id": "45min",
      "title": "45 Minutes",
      "subtitle": "Regular delivery",
      "extraCost": 0,
      "icon": Icons.schedule,
      "color": Color(0xFF4CAF50),
    },
  ];

  List<Map<String, dynamic>> locations = [
    {
      "id": "home",
      "name": "Home",
      "address": "123 Main Street, Downtown",
      "icon": Icons.home,
      "isDefault": true,
    },
    {
      "id": "office",
      "name": "Office",
      "address": "456 Business Ave, Suite 201",
      "icon": Icons.business,
      "isDefault": false,
    },
    {
      "id": "other",
      "name": "Other Location",
      "address": "Add new address",
      "icon": Icons.add_location,
      "isDefault": false,
    },
  ];

  List<Map<String, dynamic>> quickOrders = [
    {
      "id": "1",
      "restaurant": "Pizza Palace",
      "items": ["Large Pepperoni Pizza", "Garlic Bread"],
      "total": 24.99,
      "deliveryTime": "12 min",
      "image": "https://picsum.photos/300/200?random=21&keyword=pizza",
      "rating": 4.8,
      "distance": "0.8 km",
    },
    {
      "id": "2",
      "restaurant": "Burger Express",
      "items": ["Double Cheeseburger", "Fries", "Coke"],
      "total": 18.50,
      "deliveryTime": "8 min",
      "image": "https://picsum.photos/300/200?random=22&keyword=burger",
      "rating": 4.6,
      "distance": "0.5 km",
    },
    {
      "id": "3",
      "restaurant": "Sushi Fast",
      "items": ["Salmon Roll", "Tuna Roll", "Miso Soup"],
      "total": 32.00,
      "deliveryTime": "18 min",
      "image": "https://picsum.photos/300/200?random=23&keyword=sushi",
      "rating": 4.9,
      "distance": "1.2 km",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quick Delivery"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () => _showDeliveryInfo(),
          ),
        ],
      ),
      body: QTabBar(
        withoutAppBar: true,
        selectedIndex: selectedIndex,
        tabs: [
          Tab(text: "Time Slots", icon: Icon(Icons.access_time)),
          Tab(text: "Quick Orders", icon: Icon(Icons.restaurant)),
          Tab(text: "Settings", icon: Icon(Icons.settings)),
        ],
        tabChildren: [
          _buildTimeSlotsTab(),
          _buildQuickOrdersTab(),
          _buildSettingsTab(),
        ],
      ),
    );
  }

  Widget _buildTimeSlotsTab() {
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
                colors: [Color(0xFFFF6B35), Color(0xFFFF8E53)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.delivery_dining,
                  size: 48,
                  color: Colors.white,
                ),
                SizedBox(height: spSm),
                Text(
                  "Quick Delivery Available",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Get your food delivered in minutes!",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withAlpha(230),
                  ),
                ),
              ],
            ),
          ),

          // Delivery Location
          Text(
            "Delivery Location",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
              border: Border.all(color: primaryColor.withAlpha(50)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: primaryColor,
                  size: 24,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        selectedLocation,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "123 Main Street, Downtown",
                        style: TextStyle(
                          fontSize: 13,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => _showLocationSelector(),
                  child: Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Icon(
                      Icons.edit,
                      color: primaryColor,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Time Slots
          Text(
            "Choose Delivery Time",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Column(
            spacing: spSm,
            children: timeSlots.map((slot) {
              bool isSelected = selectedTimeSlot == slot["id"];
              return GestureDetector(
                onTap: () {
                  selectedTimeSlot = slot["id"];
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                    border: Border.all(
                      color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: (slot["color"] as Color).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          slot["icon"] as IconData,
                          color: slot["color"] as Color,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${slot["title"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                if ((slot["extraCost"] as int) > 0) ...[
                                  SizedBox(width: spSm),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: warningColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "+\$${slot["extraCost"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: warningColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${slot["subtitle"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isSelected) ...[
                        Icon(
                          Icons.check_circle,
                          color: primaryColor,
                          size: 24,
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }).toList(),
          ),

          // Quick Options
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
                Text(
                  "Delivery Options",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: expressDelivery,
                      onChanged: (value) {
                        expressDelivery = value!;
                        setState(() {});
                      },
                      activeColor: primaryColor,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Express Delivery (+\$5)",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Priority delivery with tracking",
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
                Row(
                  children: [
                    Checkbox(
                      value: contactlessDelivery,
                      onChanged: (value) {
                        contactlessDelivery = value!;
                        setState(() {});
                      },
                      activeColor: primaryColor,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Contactless Delivery",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Leave at door with photo confirmation",
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
              ],
            ),
          ),

          // Confirm Button
          Container(
            width: double.infinity,
            child: QButton(
              label: "Confirm Quick Delivery",
              size: bs.md,
              onPressed: () => _confirmQuickDelivery(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickOrdersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Quick Order Header
          Row(
            children: [
              Icon(
                Icons.flash_on,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Quick Order Options",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          
          Text(
            "Pre-made orders ready for quick delivery",
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),

          // Quick Orders List
          Column(
            spacing: spMd,
            children: quickOrders.map((order) => _buildQuickOrderCard(order)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickOrderCard(Map<String, dynamic> order) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Restaurant Image
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusSm)),
            child: Stack(
              children: [
                Image.network(
                  "${order["image"]}",
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
                      color: successColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.flash_on,
                          color: Colors.white,
                          size: 12,
                        ),
                        SizedBox(width: 2),
                        Text(
                          "${order["deliveryTime"]}",
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
              children: [
                // Restaurant Info
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${order["restaurant"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.star,
                            color: warningColor,
                            size: 12,
                          ),
                          SizedBox(width: 2),
                          Text(
                            "${order["rating"]}",
                            style: TextStyle(
                              color: warningColor,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                // Items
                Text(
                  "Items:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                ...((order["items"] as List).map((item) => Padding(
                  padding: EdgeInsets.only(left: spSm, bottom: 2),
                  child: Text(
                    "• $item",
                    style: TextStyle(
                      fontSize: 13,
                      color: disabledBoldColor,
                    ),
                  ),
                ))).toList(),
                
                SizedBox(height: spMd),
                
                // Price and Distance
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: primaryColor,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${order["distance"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "\$${(order["total"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spMd),
                
                // Order Button
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Quick Order Now",
                    size: bs.sm,
                    onPressed: () => _orderQuickOrder(order),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Special Instructions
          Text(
            "Delivery Instructions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          QMemoField(
            label: "Special Instructions",
            value: specialInstructions,
            hint: "Any special delivery instructions? (e.g., gate code, apartment number, specific location)",
            onChanged: (value) {
              specialInstructions = value;
              setState(() {});
            },
          ),

          // Default Settings
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
                  "Quick Delivery Preferences",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                _buildSettingTile(
                  icon: Icons.notifications,
                  title: "Delivery Notifications",
                  subtitle: "Get updates about your quick delivery",
                  onTap: () => ss("Opening notification settings"),
                ),
                
                _buildSettingTile(
                  icon: Icons.payment,
                  title: "Payment Method",
                  subtitle: "Credit Card ending in 1234",
                  onTap: () => ss("Opening payment settings"),
                ),
                
                _buildSettingTile(
                  icon: Icons.history,
                  title: "Quick Order History",
                  subtitle: "View your previous quick orders",
                  onTap: () => ss("Opening order history"),
                ),
                
                _buildSettingTile(
                  icon: Icons.help,
                  title: "Delivery Help",
                  subtitle: "FAQ and support for quick delivery",
                  onTap: () => _showDeliveryInfo(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: spSm),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: disabledOutlineBorderColor,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: primaryColor,
              size: 24,
            ),
            SizedBox(width: spMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: disabledBoldColor,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  void _showLocationSelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: disabledOutlineBorderColor)),
              ),
              child: Row(
                children: [
                  Text(
                    "Select Delivery Location",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => back(),
                  ),
                ],
              ),
            ),
            ...locations.map((location) => ListTile(
              leading: Icon(
                location["icon"] as IconData,
                color: primaryColor,
              ),
              title: Text("${location["name"]}"),
              subtitle: Text("${location["address"]}"),
              trailing: location["isDefault"] == true
                  ? Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "Default",
                        style: TextStyle(
                          fontSize: 10,
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : null,
              onTap: () {
                selectedLocation = location["name"];
                setState(() {});
                back();
              },
            )).toList(),
            SizedBox(height: spMd),
          ],
        ),
      ),
    );
  }

  void _showDeliveryInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.info_outline, color: primaryColor),
            SizedBox(width: spSm),
            Text("Quick Delivery Info"),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "How Quick Delivery Works:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Text("• Orders are prepared immediately"),
            Text("• Dedicated delivery drivers"),
            Text("• Real-time tracking available"),
            Text("• Priority handling"),
            SizedBox(height: spMd),
            Text(
              "Delivery Times:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Text("• ASAP: 15-25 minutes"),
            Text("• Express: 10-15 minutes (+\$3)"),
            Text("• Standard: 20-30 minutes"),
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

  void _confirmQuickDelivery() {
    String message = "Quick delivery confirmed for $selectedTimeSlot";
    if (expressDelivery) message += " with express service";
    if (contactlessDelivery) message += " (contactless)";
    
    ss(message);
    back();
  }

  void _orderQuickOrder(Map<String, dynamic> order) {
    ss("Quick order placed from ${order["restaurant"]} - \$${(order["total"] as double).toStringAsFixed(2)}");
  }
}
