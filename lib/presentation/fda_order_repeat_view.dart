import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaOrderRepeatView extends StatefulWidget {
  const FdaOrderRepeatView({super.key});

  @override
  State<FdaOrderRepeatView> createState() => _FdaOrderRepeatViewState();
}

class _FdaOrderRepeatViewState extends State<FdaOrderRepeatView> {
  String selectedFilter = "All";
  bool isLoading = false;

  List<Map<String, dynamic>> recentOrders = [
    {
      "orderId": "#FDA001",
      "restaurant": "Tony's Pizzeria",
      "date": "2024-01-14",
      "time": "07:30 PM",
      "total": 24.50,
      "items": [
        {"name": "Margherita Pizza", "quantity": 1, "price": 14.99},
        {"name": "Garlic Bread", "quantity": 1, "price": 4.99},
        {"name": "Caesar Salad", "quantity": 1, "price": 8.99}
      ],
      "status": "delivered",
      "rating": 5,
    },
    {
      "orderId": "#FDA002", 
      "restaurant": "Sushi Master",
      "date": "2024-01-12",
      "time": "06:15 PM",
      "total": 32.80,
      "items": [
        {"name": "California Roll", "quantity": 2, "price": 12.99},
        {"name": "Miso Soup", "quantity": 1, "price": 4.50},
        {"name": "Chicken Teriyaki", "quantity": 1, "price": 15.30}
      ],
      "status": "delivered",
      "rating": 4,
    },
    {
      "orderId": "#FDA003",
      "restaurant": "Burger Palace", 
      "date": "2024-01-10",
      "time": "08:00 PM",
      "total": 18.75,
      "items": [
        {"name": "Classic Burger", "quantity": 1, "price": 12.99},
        {"name": "French Fries", "quantity": 1, "price": 4.50},
        {"name": "Coke", "quantity": 1, "price": 2.25}
      ],
      "status": "delivered", 
      "rating": 5,
    },
  ];

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "All"},
    {"label": "Last Week", "value": "week"},
    {"label": "Last Month", "value": "month"},
    {"label": "Favorites", "value": "favorites"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Repeat Orders"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: _searchOrders,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildFilterSection(),
            _buildQuickReorder(),
            _buildOrderHistory(),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterSection() {
    return QCategoryPicker(
      label: "Filter Orders",
      items: filterOptions,
      value: selectedFilter,
      onChanged: (index, label, value, item) {
        selectedFilter = value;
        setState(() {});
      },
    );
  }

  Widget _buildQuickReorder() {
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
              Icon(
                Icons.flash_on,
                color: warningColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Quick Reorder",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Text(
            "Reorder your most recent favorites with one tap",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Divider(color: disabledColor),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Reorder Last Order - Tony's Pizzeria (\$24.50)",
              size: bs.sm,
              onPressed: () => _quickReorder(recentOrders.first),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderHistory() {
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
              Icon(
                Icons.history,
                color: primaryColor,
                size: 20,
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
          Divider(color: disabledColor),
          if (isLoading)
            Container(
              height: 200,
              child: Center(child: CircularProgressIndicator()),
            )
          else
            ...recentOrders.map((order) => _buildOrderCard(order)),
        ],
      ),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledColor, width: 1),
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
                      "${order["restaurant"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${order["orderId"]} • ${order["date"]} at ${order["time"]}",
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
                    "\$${((order["total"] as double)).toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: List.generate(5, (index) => Icon(
                      Icons.star,
                      size: 12,
                      color: index < (order["rating"] as int) ? warningColor : disabledColor,
                    )),
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "Items:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: disabledBoldColor,
                  ),
                ),
                ...(order["items"] as List).map((item) => Text(
                  "${item["quantity"]}x ${item["name"]} - \$${((item["price"] as double)).toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 11,
                    color: disabledBoldColor,
                  ),
                )),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Reorder",
                  size: bs.sm,
                  onPressed: () => _reorderExact(order),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Modify & Order",
                  size: bs.sm,
                  onPressed: () => _modifyAndOrder(order),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _searchOrders() {
    ss("Opening order search...");
  }

  void _quickReorder(Map<String, dynamic> order) {
    isLoading = true;
    setState(() {});
    
    Future.delayed(Duration(seconds: 2), () {
      isLoading = false;
      setState(() {});
      ss("Order from ${order["restaurant"]} added to cart!");
    });
  }

  void _reorderExact(Map<String, dynamic> order) {
    ss("Reordering exact items from ${order["restaurant"]}...");
  }

  void _modifyAndOrder(Map<String, dynamic> order) {
    ss("Opening ${order["restaurant"]} with previous items...");
  }
}
