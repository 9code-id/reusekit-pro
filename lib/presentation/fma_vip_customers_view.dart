import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaVipCustomersView extends StatefulWidget {
  const FmaVipCustomersView({super.key});

  @override
  State<FmaVipCustomersView> createState() => _FmaVipCustomersViewState();
}

class _FmaVipCustomersViewState extends State<FmaVipCustomersView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedTier = "all";
  String selectedStatus = "all";

  List<Map<String, dynamic>> vipCustomers = [
    {
      "id": "VIP001",
      "name": "Alexander Windsor",
      "email": "alex.windsor@email.com",
      "phone": "+1 (555) 123-4567",
      "tier": "Platinum",
      "status": "Active",
      "join_date": "2023-01-15",
      "total_spent": 2580.50,
      "orders_count": 45,
      "avg_order_value": 57.34,
      "last_order": "2024-06-18",
      "favorite_cuisine": "Italian",
      "dietary_preferences": ["Gluten-Free"],
      "special_occasions": ["Birthday: Dec 25"],
      "loyalty_points": 12600,
      "discount_percentage": 15,
      "personal_chef": "Marco Rodriguez",
      "vip_since": "2023-03-20",
      "preferred_time": "7:00 PM",
      "delivery_notes": "Ring doorbell twice, leave at front door"
    },
    {
      "id": "VIP002", 
      "name": "Sophia Chen",
      "email": "sophia.chen@email.com",
      "phone": "+1 (555) 987-6543",
      "tier": "Gold",
      "status": "Active",
      "join_date": "2023-04-22",
      "total_spent": 1890.75,
      "orders_count": 38,
      "avg_order_value": 49.76,
      "last_order": "2024-06-19",
      "favorite_cuisine": "Asian",
      "dietary_preferences": ["Vegetarian", "Low Sodium"],
      "special_occasions": ["Anniversary: Aug 14"],
      "loyalty_points": 9450,
      "discount_percentage": 12,
      "personal_chef": "Sarah Chen",
      "vip_since": "2023-07-10",
      "preferred_time": "6:30 PM",
      "delivery_notes": "Call upon arrival, apartment 4B"
    },
    {
      "id": "VIP003",
      "name": "James Morrison",
      "email": "j.morrison@email.com", 
      "phone": "+1 (555) 456-7890",
      "tier": "Silver",
      "status": "Active",
      "join_date": "2023-08-05",
      "total_spent": 1245.20,
      "orders_count": 28,
      "avg_order_value": 44.47,
      "last_order": "2024-06-17",
      "favorite_cuisine": "American",
      "dietary_preferences": ["Keto"],
      "special_occasions": ["Wife's Birthday: Oct 3"],
      "loyalty_points": 6225,
      "discount_percentage": 8,
      "personal_chef": "David Kim",
      "vip_since": "2023-11-12",
      "preferred_time": "8:00 PM",
      "delivery_notes": "Use side entrance, watch for dog"
    },
    {
      "id": "VIP004",
      "name": "Isabella Rodriguez",
      "email": "isabella.r@email.com",
      "phone": "+1 (555) 234-5678",
      "tier": "Platinum",
      "status": "Inactive",
      "join_date": "2022-12-10",
      "total_spent": 3125.80,
      "orders_count": 62,
      "avg_order_value": 50.42,
      "last_order": "2024-05-28",
      "favorite_cuisine": "Mediterranean",
      "dietary_preferences": ["Organic Only"],
      "special_occasions": ["Birthday: May 18", "Anniversary: Sep 22"],
      "loyalty_points": 15600,
      "discount_percentage": 18,
      "personal_chef": "Isabella Martinez",
      "vip_since": "2023-02-08",
      "preferred_time": "7:30 PM",
      "delivery_notes": "Security code: 1234, penthouse level"
    },
  ];

  List<Map<String, dynamic>> tierItems = [
    {"label": "All Tiers", "value": "all"},
    {"label": "Platinum", "value": "Platinum"},
    {"label": "Gold", "value": "Gold"},
    {"label": "Silver", "value": "Silver"},
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "All Status", "value": "all"},
    {"label": "Active", "value": "Active"},
    {"label": "Inactive", "value": "Inactive"},
    {"label": "Suspended", "value": "Suspended"},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "VIP Customers",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Customers", icon: Icon(Icons.star)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "Benefits", icon: Icon(Icons.card_giftcard)),
      ],
      tabChildren: [
        _buildCustomersTab(),
        _buildAnalyticsTab(),
        _buildBenefitsTab(),
      ],
    );
  }

  Widget _buildCustomersTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildSearchAndFilters(),
          _buildCustomersList(),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Column(
      spacing: spSm,
      children: [
        Row(
          children: [
            Expanded(
              child: QTextField(
                label: "Search VIP customers...",
                value: searchQuery,
                hint: "Search by name, email, or VIP ID",
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
          spacing: spSm,
          children: [
            Expanded(
              child: QDropdownField(
                label: "Tier",
                items: tierItems,
                value: selectedTier,
                onChanged: (value, label) {
                  selectedTier = value;
                  setState(() {});
                },
              ),
            ),
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
      ],
    );
  }

  Widget _buildCustomersList() {
    return Column(
      spacing: spSm,
      children: vipCustomers.map((customer) => _buildCustomerCard(customer)).toList(),
    );
  }

  Widget _buildCustomerCard(Map<String, dynamic> customer) {
    Color tierColor = _getTierColor("${customer["tier"]}");
    Color statusColor = _getStatusColor("${customer["status"]}");
    double totalSpent = customer["total_spent"] as double;
    double avgOrderValue = customer["avg_order_value"] as double;
    int ordersCount = customer["orders_count"] as int;
    int loyaltyPoints = customer["loyalty_points"] as int;
    int discountPercentage = customer["discount_percentage"] as int;
    List<String> dietaryPreferences = (customer["dietary_preferences"] as List).cast<String>();
    List<String> specialOccasions = (customer["special_occasions"] as List).cast<String>();

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: tierColor,
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: spSm,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: tierColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(Icons.person, color: tierColor, size: 24),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${customer["name"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${customer["id"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                spacing: spXs,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: tierColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.star, size: 12, color: tierColor),
                        SizedBox(width: 2),
                        Text(
                          "${customer["tier"]}",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: tierColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${customer["status"]}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.email, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${customer["email"]}",
                  style: TextStyle(fontSize: 14, color: disabledBoldColor),
                ),
              ),
              Icon(Icons.phone, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${customer["phone"]}",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "\$${totalSpent.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Total Spent",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 30,
                  color: disabledColor,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "$ordersCount",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Orders",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 30,
                  color: disabledColor,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "\$${avgOrderValue.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Avg Order",
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
          ),
          Row(
            children: [
              Icon(Icons.restaurant, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Favorite: ${customer["favorite_cuisine"]}",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
              Spacer(),
              Icon(Icons.schedule, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${customer["preferred_time"]}",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.person_outline, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Chef: ${customer["personal_chef"]}",
                style: TextStyle(fontSize: 12, color: disabledBoldColor),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "$discountPercentage% OFF",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: warningColor,
                  ),
                ),
              ),
            ],
          ),
          if (dietaryPreferences.isNotEmpty)
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Text(
                    "Dietary Preferences:",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: infoColor,
                    ),
                  ),
                  Wrap(
                    spacing: spXs,
                    children: dietaryPreferences.map((pref) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          pref,
                          style: TextStyle(
                            fontSize: 10,
                            color: infoColor,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          if (specialOccasions.isNotEmpty)
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
                  Row(
                    children: [
                      Icon(Icons.cake, size: 16, color: successColor),
                      SizedBox(width: spXs),
                      Text(
                        "Special Occasions:",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: specialOccasions.map((occasion) {
                      return Text(
                        "• $occasion",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          Row(
            children: [
              Icon(Icons.card_giftcard, size: 16, color: warningColor),
              SizedBox(width: spXs),
              Text(
                "$loyaltyPoints points",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: warningColor,
                ),
              ),
              Spacer(),
              Text(
                "VIP since ${customer["vip_since"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Row(
              children: [
                Icon(Icons.local_shipping, size: 16, color: disabledBoldColor),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "${customer["delivery_notes"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "View Profile",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Order History",
                  size: bs.sm,
                  onPressed: () {},
                ),
              ),
              QButton(
                icon: Icons.phone,
                size: bs.sm,
                onPressed: () {},
              ),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildMetricCard("Total VIPs", "1,248", Icons.star, primaryColor),
              _buildMetricCard("Active VIPs", "1,156", Icons.check_circle, successColor),
              _buildMetricCard("Avg Spent", "\$1,824", Icons.attach_money, infoColor),
              _buildMetricCard("Retention", "89%", Icons.trending_up, warningColor),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Text(
                        "Tier Distribution",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      _buildTierItem("Platinum", 125, warningColor),
                      _buildTierItem("Gold", 386, infoColor),
                      _buildTierItem("Silver", 645, successColor),
                      _buildTierItem("Bronze", 92, disabledBoldColor),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Text(
                        "VIP Revenue",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      _buildRevenueItem("This Month", 284500, primaryColor),
                      _buildRevenueItem("Last Month", 256800, infoColor),
                      _buildRevenueItem("Growth", 10.8, successColor, isPercentage: true),
                      _buildRevenueItem("YTD Total", 2840000, warningColor),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Popular Cuisines Among VIPs",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildCuisineItem("Italian", 28, primaryColor),
                _buildCuisineItem("Asian", 22, infoColor),
                _buildCuisineItem("Mediterranean", 18, successColor),
                _buildCuisineItem("American", 15, warningColor),
                _buildCuisineItem("French", 12, dangerColor),
                _buildCuisineItem("Other", 5, disabledBoldColor),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "VIP Customer Lifetime Value",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spSm),
                Container(
                  height: 150,
                  child: Center(
                    child: Text(
                      "Chart showing VIP customer value trends over time",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH3,
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

  Widget _buildTierItem(String tier, int count, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radiusXs),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Text(tier, style: TextStyle(fontSize: 14)),
        ),
        Text(
          "$count",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildRevenueItem(String period, double amount, Color color, {bool isPercentage = false}) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radiusXs),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Text(period, style: TextStyle(fontSize: 14)),
        ),
        Text(
          isPercentage ? "+${amount.toStringAsFixed(1)}%" : "\$${(amount / 1000).toStringAsFixed(1)}K",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildCuisineItem(String cuisine, int percentage, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radiusXs),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Text(cuisine, style: TextStyle(fontSize: 14)),
        ),
        Text(
          "$percentage%",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildBenefitsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "VIP Tier Benefits",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildTierBenefits("Platinum", warningColor, [
                  "20% discount on all orders",
                  "Free delivery always",
                  "Personal chef consultation",
                  "Priority customer service",
                  "Exclusive menu items",
                  "Birthday & anniversary specials"
                ]),
                _buildTierBenefits("Gold", infoColor, [
                  "15% discount on all orders",
                  "Free delivery over \$30",
                  "Monthly chef recommendations",
                  "Priority support",
                  "Early access to new items"
                ]),
                _buildTierBenefits("Silver", successColor, [
                  "10% discount on all orders",
                  "Free delivery over \$50",
                  "Loyalty points double",
                  "Special occasion reminders"
                ]),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "VIP Qualification Criteria",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildQualificationItem(
                  "Platinum",
                  "\$2,500+ spent annually",
                  "40+ orders per year",
                  warningColor,
                ),
                _buildQualificationItem(
                  "Gold",
                  "\$1,500+ spent annually",
                  "25+ orders per year",
                  infoColor,
                ),
                _buildQualificationItem(
                  "Silver",
                  "\$750+ spent annually",
                  "15+ orders per year",
                  successColor,
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "VIP Services",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildServiceItem(
                  "Personal Chef Consultation",
                  "One-on-one menu planning and dietary advice",
                  Icons.person,
                  primaryColor,
                ),
                _buildServiceItem(
                  "Priority Delivery",
                  "Guaranteed faster delivery during peak hours",
                  Icons.delivery_dining,
                  successColor,
                ),
                _buildServiceItem(
                  "Custom Menu Creation",
                  "Personalized dishes based on preferences",
                  Icons.restaurant_menu,
                  infoColor,
                ),
                _buildServiceItem(
                  "Event Catering Discounts",
                  "Special pricing for parties and events",
                  Icons.celebration,
                  warningColor,
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "VIP Communication Channels",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildCommunicationItem("Dedicated VIP Hotline", "+1 (555) VIP-FOOD", Icons.phone),
                _buildCommunicationItem("VIP WhatsApp", "24/7 instant messaging", Icons.message),
                _buildCommunicationItem("Personal Account Manager", "Direct contact person", Icons.person_pin),
                _buildCommunicationItem("VIP Email Support", "vip@fooddelivery.com", Icons.email),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTierBenefits(String tier, Color tierColor, List<String> benefits) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        border: Border.all(color: tierColor.withAlpha(50)),
        borderRadius: BorderRadius.circular(radiusSm),
        color: tierColor.withAlpha(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Row(
            children: [
              Icon(Icons.star, color: tierColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "$tier Tier",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: tierColor,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: benefits.map((benefit) {
              return Padding(
                padding: EdgeInsets.only(left: spSm, top: 2),
                child: Row(
                  children: [
                    Icon(Icons.check, size: 16, color: tierColor),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        benefit,
                        style: TextStyle(fontSize: 14),
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

  Widget _buildQualificationItem(String tier, String spending, String orders, Color color) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(Icons.star, color: color, size: 20),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$tier Tier",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
                Text(
                  spending,
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  orders,
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

  Widget _buildServiceItem(String service, String description, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  description,
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

  Widget _buildCommunicationItem(String channel, String contact, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Row(
        children: [
          Icon(icon, color: primaryColor, size: 20),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  channel,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  contact,
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

  Color _getTierColor(String tier) {
    switch (tier) {
      case "Platinum":
        return warningColor;
      case "Gold":
        return infoColor;
      case "Silver":
        return successColor;
      case "Bronze":
        return disabledBoldColor;
      default:
        return primaryColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "Inactive":
        return warningColor;
      case "Suspended":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }
}
