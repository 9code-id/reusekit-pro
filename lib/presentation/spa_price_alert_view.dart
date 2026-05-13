import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaPriceAlertView extends StatefulWidget {
  const SpaPriceAlertView({super.key});

  @override
  State<SpaPriceAlertView> createState() => _SpaPriceAlertViewState();
}

class _SpaPriceAlertViewState extends State<SpaPriceAlertView> {
  int activeAlerts = 12;
  int triggeredAlerts = 8;
  String searchQuery = "";
  String selectedCategory = "all";
  String selectedStatus = "all";
  bool notificationsEnabled = true;

  List<Map<String, dynamic>> priceAlerts = [
    {
      "id": "PA001",
      "product_name": "iPhone 14 Pro Max",
      "current_price": 1099.00,
      "target_price": 999.00,
      "original_price": 1199.00,
      "price_drop": 100.00,
      "status": "active",
      "category": "Electronics",
      "merchant": "Best Buy",
      "image": "https://picsum.photos/80/80?random=1&keyword=phone",
      "created_date": "2024-01-10",
      "last_checked": "2024-01-15 14:30",
      "percentage_target": 83.4,
      "is_favorite": true,
    },
    {
      "id": "PA002",
      "product_name": "Sony WH-1000XM4 Headphones",
      "current_price": 249.99,
      "target_price": 199.99,
      "original_price": 349.99,
      "price_drop": 100.00,
      "status": "triggered",
      "category": "Electronics",
      "merchant": "Amazon",
      "image": "https://picsum.photos/80/80?random=2&keyword=headphones",
      "created_date": "2024-01-08",
      "last_checked": "2024-01-15 12:00",
      "percentage_target": 125.0,
      "is_favorite": false,
      "triggered_date": "2024-01-14 09:15",
      "triggered_price": 199.99,
    },
    {
      "id": "PA003",
      "product_name": "Nike Air Jordan 1 Retro",
      "current_price": 170.00,
      "target_price": 150.00,
      "original_price": 200.00,
      "price_drop": 30.00,
      "status": "active",
      "category": "Fashion",
      "merchant": "Nike",
      "image": "https://picsum.photos/80/80?random=3&keyword=shoes",
      "created_date": "2024-01-12",
      "last_checked": "2024-01-15 16:45",
      "percentage_target": 113.3,
      "is_favorite": true,
    },
    {
      "id": "PA004",
      "product_name": "KitchenAid Stand Mixer",
      "current_price": 299.99,
      "target_price": 249.99,
      "original_price": 399.99,
      "price_drop": 100.00,
      "status": "paused",
      "category": "Home & Kitchen",
      "merchant": "Williams Sonoma",
      "image": "https://picsum.photos/80/80?random=4&keyword=mixer",
      "created_date": "2024-01-05",
      "last_checked": "2024-01-13 10:20",
      "percentage_target": 120.0,
      "is_favorite": false,
    },
    {
      "id": "PA005",
      "product_name": "Dell XPS 13 Laptop",
      "current_price": 999.99,
      "target_price": 899.99,
      "original_price": 1299.99,
      "price_drop": 300.00,
      "status": "triggered",
      "category": "Electronics",
      "merchant": "Dell",
      "image": "https://picsum.photos/80/80?random=5&keyword=laptop",
      "created_date": "2024-01-01",
      "last_checked": "2024-01-15 08:30",
      "percentage_target": 111.1,
      "is_favorite": true,
      "triggered_date": "2024-01-12 15:20",
      "triggered_price": 899.99,
    },
    {
      "id": "PA006",
      "product_name": "Adidas Ultraboost 22",
      "current_price": 180.00,
      "target_price": 140.00,
      "original_price": 220.00,
      "price_drop": 40.00,
      "status": "active",
      "category": "Fashion",
      "merchant": "Adidas",
      "image": "https://picsum.photos/80/80?random=6&keyword=sneakers",
      "created_date": "2024-01-14",
      "last_checked": "2024-01-15 18:00",
      "percentage_target": 128.6,
      "is_favorite": false,
    },
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "all"},
    {"label": "Electronics", "value": "Electronics"},
    {"label": "Fashion", "value": "Fashion"},
    {"label": "Home & Kitchen", "value": "Home & Kitchen"},
    {"label": "Sports", "value": "Sports"},
    {"label": "Books", "value": "Books"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Triggered", "value": "triggered"},
    {"label": "Paused", "value": "paused"},
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredAlerts = _getFilteredAlerts();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Price Alerts"),
        actions: [
          GestureDetector(
            onTap: () => _showNotificationSettings(),
            child: Icon(
              notificationsEnabled ? Icons.notifications : Icons.notifications_off,
              color: primaryColor,
            ),
          ),
          SizedBox(width: spSm),
          GestureDetector(
            onTap: () => _showAddAlertDialog(),
            child: Icon(
              Icons.add,
              color: primaryColor,
            ),
          ),
          SizedBox(width: spMd),
        ],
      ),
      body: Column(
        children: [
          _buildStatsCards(),
          _buildFilters(),
          Expanded(
            child: _buildAlertsList(filteredAlerts),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCards() {
    return Container(
      padding: EdgeInsets.all(spMd),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: primaryColor.withAlpha(50)),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.notification_important,
                    color: primaryColor,
                    size: 24,
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "$activeAlerts",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Active Alerts",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                      fontWeight: FontWeight.w500,
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
                color: successColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: successColor.withAlpha(50)),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: successColor,
                    size: 24,
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "$triggeredAlerts",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  Text(
                    "Triggered",
                    style: TextStyle(
                      fontSize: 12,
                      color: successColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      color: Colors.white,
      child: Column(
        spacing: spSm,
        children: [
          QTextField(
            label: "Search products...",
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
                  label: "Category",
                  items: categoryOptions,
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
        ],
      ),
    );
  }

  Widget _buildAlertsList(List<Map<String, dynamic>> alerts) {
    if (alerts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_none,
              size: 64,
              color: disabledColor,
            ),
            SizedBox(height: spSm),
            Text(
              "No price alerts found",
              style: TextStyle(
                fontSize: 16,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spSm),
            QButton(
              label: "Create Alert",
              size: bs.sm,
              onPressed: () => _showAddAlertDialog(),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: alerts.length,
      itemBuilder: (context, index) {
        var alert = alerts[index];
        return _buildAlertCard(alert);
      },
    );
  }

  Widget _buildAlertCard(Map<String, dynamic> alert) {
    Color statusColor = _getStatusColor(alert["status"]);
    bool isTriggered = alert["status"] == "triggered";
    
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
        border: isTriggered ? Border.all(color: successColor, width: 2) : null,
      ),
      child: Column(
        children: [
          if (isTriggered)
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: spXs, horizontal: spSm),
              decoration: BoxDecoration(
                color: successColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(radiusSm),
                  topRight: Radius.circular(radiusSm),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.celebration,
                    color: Colors.white,
                    size: 16,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Price Alert Triggered on ${alert["triggered_date"]}!",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusSm),
                      child: Image.network(
                        "${alert["image"]}",
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.image,
                            color: primaryColor,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${alert["product_name"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => _toggleFavorite(alert),
                                child: Icon(
                                  alert["is_favorite"] ? Icons.favorite : Icons.favorite_border,
                                  color: alert["is_favorite"] ? dangerColor : disabledBoldColor,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${alert["merchant"]} • ${alert["category"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: statusColor.withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${alert["status"]}".toUpperCase(),
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: statusColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: disabledColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Column(
                    spacing: spSm,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Current Price",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "\$${(alert["current_price"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Target Price",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "\$${(alert["target_price"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isTriggered ? successColor : warningColor,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Price Drop",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "-\$${(alert["price_drop"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      
                      Column(
                        spacing: spXs,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Progress to Target",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${((alert["percentage_target"] as double) - 100).abs().toStringAsFixed(1)}% ${isTriggered ? 'reached' : 'to go'}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: isTriggered ? successColor : primaryColor,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 6,
                            decoration: BoxDecoration(
                              color: disabledColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: isTriggered ? 1.0 : (100.0 / (alert["percentage_target"] as double)).clamp(0.0, 1.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: isTriggered ? successColor : primaryColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                Row(
                  children: [
                    Text(
                      "Last checked: ${alert["last_checked"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    if (isTriggered) ...[
                      QButton(
                        label: "Buy Now",
                        size: bs.sm,
                        onPressed: () => _buyNow(alert),
                      ),
                      SizedBox(width: spSm),
                    ],
                    GestureDetector(
                      onTap: () => _showAlertOptions(alert),
                      child: Icon(
                        Icons.more_vert,
                        color: disabledBoldColor,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return primaryColor;
      case "triggered":
        return successColor;
      case "paused":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  List<Map<String, dynamic>> _getFilteredAlerts() {
    return priceAlerts.where((alert) {
      bool matchesSearch = searchQuery.isEmpty ||
          alert["product_name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          alert["merchant"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory == "all" || alert["category"] == selectedCategory;
      bool matchesStatus = selectedStatus == "all" || alert["status"] == selectedStatus;
      
      return matchesSearch && matchesCategory && matchesStatus;
    }).toList();
  }

  void _toggleFavorite(Map<String, dynamic> alert) {
    setState(() {
      alert["is_favorite"] = !alert["is_favorite"];
    });
    
    String message = alert["is_favorite"] ? "Added to favorites" : "Removed from favorites";
    ss(message);
  }

  void _showAddAlertDialog() {
    String productUrl = "";
    String targetPrice = "";
    String selectedCategoryValue = categoryOptions[1]["value"]; // First non-"all" option
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Create Price Alert"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            QTextField(
              label: "Product URL",
              value: productUrl,
              hint: "Paste product link here",
              onChanged: (value) => productUrl = value,
            ),
            QNumberField(
              label: "Target Price (\$)",
              value: targetPrice,
              onChanged: (value) => targetPrice = value,
            ),
            QDropdownField(
              label: "Category",
              items: categoryOptions.where((option) => option["value"] != "all").toList(),
              value: selectedCategoryValue,
              onChanged: (value, label) => selectedCategoryValue = value,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Create Alert",
            size: bs.sm,
            onPressed: () {
              if (productUrl.isNotEmpty && targetPrice.isNotEmpty) {
                Navigator.pop(context);
                ss("Price alert created successfully!");
                // In real app, would parse URL and create alert
              } else {
                se("Please fill all required fields");
              }
            },
          ),
        ],
      ),
    );
  }

  void _showAlertOptions(Map<String, dynamic> alert) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Alert Options"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.edit),
              title: Text("Edit Alert"),
              onTap: () {
                Navigator.pop(context);
                _editAlert(alert);
              },
            ),
            ListTile(
              leading: Icon(
                alert["status"] == "paused" ? Icons.play_arrow : Icons.pause,
              ),
              title: Text(alert["status"] == "paused" ? "Resume Alert" : "Pause Alert"),
              onTap: () {
                Navigator.pop(context);
                _toggleAlertStatus(alert);
              },
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text("Share Product"),
              onTap: () {
                Navigator.pop(context);
                ss("Sharing feature coming soon!");
              },
            ),
            ListTile(
              leading: Icon(Icons.open_in_new),
              title: Text("View Product"),
              onTap: () {
                Navigator.pop(context);
                si("Opening product page...");
              },
            ),
            ListTile(
              leading: Icon(Icons.delete, color: dangerColor),
              title: Text("Delete Alert", style: TextStyle(color: dangerColor)),
              onTap: () {
                Navigator.pop(context);
                _deleteAlert(alert);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _editAlert(Map<String, dynamic> alert) {
    String newTargetPrice = alert["target_price"].toString();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Price Alert"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            Text(
              "${alert["product_name"]}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              "Current Price: \$${(alert["current_price"] as double).currency}",
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
            QNumberField(
              label: "New Target Price (\$)",
              value: newTargetPrice,
              onChanged: (value) => newTargetPrice = value,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Update",
            size: bs.sm,
            onPressed: () {
              if (newTargetPrice.isNotEmpty) {
                setState(() {
                  alert["target_price"] = double.parse(newTargetPrice);
                  alert["percentage_target"] = (alert["current_price"] as double) / double.parse(newTargetPrice) * 100;
                });
                Navigator.pop(context);
                ss("Price alert updated!");
              }
            },
          ),
        ],
      ),
    );
  }

  void _toggleAlertStatus(Map<String, dynamic> alert) {
    setState(() {
      if (alert["status"] == "paused") {
        alert["status"] = "active";
        activeAlerts++;
      } else if (alert["status"] == "active") {
        alert["status"] = "paused";
        activeAlerts--;
      }
    });
    
    String message = alert["status"] == "paused" ? "Alert paused" : "Alert resumed";
    ss(message);
  }

  void _deleteAlert(Map<String, dynamic> alert) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete Price Alert"),
        content: Text("Are you sure you want to delete this price alert for ${alert["product_name"]}?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Delete",
            size: bs.sm,
            onPressed: () {
              setState(() {
                priceAlerts.removeWhere((a) => a["id"] == alert["id"]);
                if (alert["status"] == "active") activeAlerts--;
                if (alert["status"] == "triggered") triggeredAlerts--;
              });
              Navigator.pop(context);
              ss("Price alert deleted!");
            },
          ),
        ],
      ),
    );
  }

  void _buyNow(Map<String, dynamic> alert) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Buy Now"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(radiusSm),
              child: Image.network(
                "${alert["image"]}",
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    Icons.image,
                    color: primaryColor,
                    size: 40,
                  ),
                ),
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "${alert["product_name"]}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              "at ${alert["merchant"]}",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                children: [
                  Text(
                    "Target Price Reached!",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  Text(
                    "\$${(alert["triggered_price"] as double).currency}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                  Text(
                    "You save \$${((alert["original_price"] as double) - (alert["triggered_price"] as double)).currency}",
                    style: TextStyle(
                      fontSize: 12,
                      color: successColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Later"),
          ),
          QButton(
            label: "Go to Store",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              si("Redirecting to ${alert["merchant"]}...");
            },
          ),
        ],
      ),
    );
  }

  void _showNotificationSettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Notification Settings"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QSwitch(
              label: "Enable Price Alert Notifications",
              items: [
                {
                  "label": "Enable Notifications",
                  "value": true,
                  "checked": notificationsEnabled,
                }
              ],
              value: [
                if (notificationsEnabled)
                  {
                    "label": "Enable Notifications",
                    "value": true,
                    "checked": true
                  }
              ],
              onChanged: (values, ids) {
                setState(() {
                  notificationsEnabled = values.isNotEmpty;
                });
              },
            ),
            SizedBox(height: spSm),
            ListTile(
              leading: Icon(Icons.email),
              title: Text("Email Notifications"),
              subtitle: Text("Receive alerts via email"),
              onTap: () {
                Navigator.pop(context);
                si("Email notification settings coming soon!");
              },
            ),
            ListTile(
              leading: Icon(Icons.sms),
              title: Text("SMS Notifications"),
              subtitle: Text("Receive alerts via SMS"),
              onTap: () {
                Navigator.pop(context);
                si("SMS notification settings coming soon!");
              },
            ),
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
