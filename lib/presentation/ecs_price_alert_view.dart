import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsPriceAlertView extends StatefulWidget {
  const EcsPriceAlertView({super.key});

  @override
  State<EcsPriceAlertView> createState() => _EcsPriceAlertViewState();
}

class _EcsPriceAlertViewState extends State<EcsPriceAlertView> {
  String selectedCategory = "All";
  String sortBy = "created_date";

  List<Map<String, dynamic>> priceAlerts = [
    {
      "id": 1,
      "productName": "iPhone 15 Pro",
      "productImage": "https://picsum.photos/200/200?random=1&keyword=iphone",
      "category": "Electronics",
      "currentPrice": 999.0,
      "targetPrice": 899.0,
      "originalPrice": 1199.0,
      "priceHistory": [1199.0, 1099.0, 1049.0, 999.0],
      "createdDate": "2025-06-08",
      "lastTriggered": null,
      "status": "active",
      "alertType": "below",
      "isTriggered": false,
      "triggeredCount": 0,
    },
    {
      "id": 2,
      "productName": "Samsung Galaxy Watch",
      "productImage": "https://picsum.photos/200/200?random=2&keyword=watch",
      "category": "Electronics",
      "currentPrice": 249.0,
      "targetPrice": 299.0,
      "originalPrice": 329.0,
      "priceHistory": [329.0, 309.0, 289.0, 269.0, 249.0],
      "createdDate": "2025-06-10",
      "lastTriggered": "2025-06-13",
      "status": "triggered",
      "alertType": "below",
      "isTriggered": true,
      "triggeredCount": 1,
    },
    {
      "id": 3,
      "productName": "Nike Air Jordan",
      "productImage": "https://picsum.photos/200/200?random=3&keyword=jordan",
      "category": "Fashion",
      "currentPrice": 180.0,
      "targetPrice": 150.0,
      "originalPrice": 220.0,
      "priceHistory": [220.0, 210.0, 195.0, 180.0],
      "createdDate": "2025-06-05",
      "lastTriggered": null,
      "status": "active",
      "alertType": "below",
      "isTriggered": false,
      "triggeredCount": 0,
    },
    {
      "id": 4,
      "productName": "Dyson Hair Dryer",
      "productImage": "https://picsum.photos/200/200?random=4&keyword=dyson",
      "category": "Beauty",
      "currentPrice": 429.0,
      "targetPrice": 399.0,
      "originalPrice": 449.0,
      "priceHistory": [449.0, 439.0, 429.0],
      "createdDate": "2025-06-12",
      "lastTriggered": null,
      "status": "paused",
      "alertType": "below",
      "isTriggered": false,
      "triggeredCount": 0,
    },
    {
      "id": 5,
      "productName": "MacBook Air M3",
      "productImage": "https://picsum.photos/200/200?random=5&keyword=macbook",
      "category": "Electronics",
      "currentPrice": 1299.0,
      "targetPrice": 1199.0,
      "originalPrice": 1299.0,
      "priceHistory": [1299.0, 1299.0, 1299.0],
      "createdDate": "2025-06-07",
      "lastTriggered": null,
      "status": "active",
      "alertType": "below",
      "isTriggered": false,
      "triggeredCount": 0,
    },
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "All"},
    {"label": "Electronics", "value": "Electronics"},
    {"label": "Fashion", "value": "Fashion"},
    {"label": "Beauty", "value": "Beauty"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Created Date", "value": "created_date"},
    {"label": "Product Name", "value": "product_name"},
    {"label": "Current Price", "value": "current_price"},
    {"label": "Target Price", "value": "target_price"},
    {"label": "Status", "value": "status"},
  ];

  List<Map<String, dynamic>> get filteredAlerts {
    List<Map<String, dynamic>> filtered = priceAlerts.where((alert) {
      return selectedCategory == "All" || alert["category"] == selectedCategory;
    }).toList();

    // Sort alerts
    filtered.sort((a, b) {
      switch (sortBy) {
        case "product_name":
          return (a["productName"] as String).compareTo(b["productName"] as String);
        case "current_price":
          return (a["currentPrice"] as double).compareTo(b["currentPrice"] as double);
        case "target_price":
          return (a["targetPrice"] as double).compareTo(b["targetPrice"] as double);
        case "status":
          return (a["status"] as String).compareTo(b["status"] as String);
        case "created_date":
        default:
          return DateTime.parse("${b["createdDate"]}").compareTo(DateTime.parse("${a["createdDate"]}"));
      }
    });

    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return primaryColor;
      case "triggered":
        return successColor;
      case "paused":
        return disabledBoldColor;
      default:
        return primaryColor;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case "active":
        return "Active";
      case "triggered":
        return "Triggered";
      case "paused":
        return "Paused";
      default:
        return "Unknown";
    }
  }

  double _getPriceChangePercentage(double currentPrice, double originalPrice) {
    return ((currentPrice - originalPrice) / originalPrice) * 100;
  }

  @override
  Widget build(BuildContext context) {
    int activeAlerts = priceAlerts.where((a) => a["status"] == "active").length;
    int triggeredAlerts = priceAlerts.where((a) => a["status"] == "triggered").length;
    int pausedAlerts = priceAlerts.where((a) => a["status"] == "paused").length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Price Alerts"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              _showAlertHistory();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Statistics Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildStatCard("Active", "$activeAlerts", primaryColor),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildStatCard("Triggered", "$triggeredAlerts", successColor),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: _buildStatCard("Paused", "$pausedAlerts", disabledBoldColor),
                ),
              ],
            ),
          ),

          // Filters
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
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
                    label: "Sort by",
                    items: sortOptions,
                    value: sortBy,
                    onChanged: (value, label) {
                      sortBy = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),

          // Alerts List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: filteredAlerts.length,
              itemBuilder: (context, index) {
                final alert = filteredAlerts[index];
                double priceChangePercentage = _getPriceChangePercentage(
                  alert["currentPrice"] as double,
                  alert["originalPrice"] as double,
                );
                bool isPriceReached = (alert["currentPrice"] as double) <= (alert["targetPrice"] as double);

                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: alert["isTriggered"] == true 
                      ? Border.all(color: successColor, width: 2)
                      : null,
                  ),
                  child: Column(
                    children: [
                      // Main Content
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Row(
                          children: [
                            // Product Image
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  child: Image.network(
                                    "${alert["productImage"]}",
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                if (alert["isTriggered"] == true)
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Container(
                                      padding: EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        color: successColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.notifications_active,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            SizedBox(width: spSm),
                            
                            // Product Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${alert["productName"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: spXs),
                                  
                                  // Status
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor(alert["status"]).withAlpha(50),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      _getStatusText(alert["status"]),
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: _getStatusColor(alert["status"]),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: spSm),
                                  
                                  // Price Info
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Current",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                          Text(
                                            "\$${(alert["currentPrice"] as double).currency}",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: spMd),
                                      Icon(
                                        Icons.arrow_forward,
                                        size: 16,
                                        color: disabledBoldColor,
                                      ),
                                      SizedBox(width: spMd),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Target",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                          Text(
                                            "\$${(alert["targetPrice"] as double).currency}",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: isPriceReached ? successColor : warningColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            
                            // Action Menu
                            PopupMenuButton(
                              icon: Icon(Icons.more_vert, color: disabledBoldColor),
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  value: "edit",
                                  child: Row(
                                    children: [
                                      Icon(Icons.edit, size: 18),
                                      SizedBox(width: spSm),
                                      Text("Edit Alert"),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  value: alert["status"] == "paused" ? "resume" : "pause",
                                  child: Row(
                                    children: [
                                      Icon(
                                        alert["status"] == "paused" ? Icons.play_arrow : Icons.pause,
                                        size: 18,
                                      ),
                                      SizedBox(width: spSm),
                                      Text(alert["status"] == "paused" ? "Resume" : "Pause"),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  value: "delete",
                                  child: Row(
                                    children: [
                                      Icon(Icons.delete, size: 18, color: dangerColor),
                                      SizedBox(width: spSm),
                                      Text("Delete", style: TextStyle(color: dangerColor)),
                                    ],
                                  ),
                                ),
                              ],
                              onSelected: (value) {
                                _handleMenuAction(value as String, alert);
                              },
                            ),
                          ],
                        ),
                      ),

                      // Price Details Footer
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(25),
                          borderRadius: BorderRadius.vertical(bottom: Radius.circular(radiusMd)),
                        ),
                        child: Column(
                          children: [
                            // Price Change
                            Row(
                              children: [
                                Icon(
                                  priceChangePercentage < 0 ? Icons.trending_down : Icons.trending_up,
                                  size: 16,
                                  color: priceChangePercentage < 0 ? successColor : dangerColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${priceChangePercentage >= 0 ? '+' : ''}${priceChangePercentage.toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: priceChangePercentage < 0 ? successColor : dangerColor,
                                  ),
                                ),
                                Text(
                                  " from original price",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                
                                // Created Date
                                Text(
                                  "Created: ${DateTime.parse("${alert["createdDate"]}").dMMMy}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            
                            // Last Triggered
                            if (alert["lastTriggered"] != null) ...[
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Icon(Icons.notifications, size: 14, color: successColor),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Last triggered: ${DateTime.parse("${alert["lastTriggered"]}").dMMMy}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: successColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  if ((alert["triggeredCount"] as int) > 1) ...[
                                    Text(
                                      " (${alert["triggeredCount"]} times)",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddAlertDialog();
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add_alert, color: Colors.white),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(50),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _handleMenuAction(String action, Map<String, dynamic> alert) {
    switch (action) {
      case "edit":
        _showEditAlertDialog(alert);
        break;
      case "pause":
        int index = priceAlerts.indexWhere((a) => a["id"] == alert["id"]);
        if (index != -1) {
          priceAlerts[index]["status"] = "paused";
          setState(() {});
          si("Price alert paused for ${alert["productName"]}");
        }
        break;
      case "resume":
        int index = priceAlerts.indexWhere((a) => a["id"] == alert["id"]);
        if (index != -1) {
          priceAlerts[index]["status"] = "active";
          setState(() {});
          ss("Price alert resumed for ${alert["productName"]}");
        }
        break;
      case "delete":
        priceAlerts.removeWhere((a) => a["id"] == alert["id"]);
        setState(() {});
        si("Price alert deleted for ${alert["productName"]}");
        break;
    }
  }

  void _showAddAlertDialog() {
    String productName = "";
    String targetPrice = "";
    String selectedCategory = "Electronics";
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Price Alert"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QTextField(
              label: "Product Name",
              value: productName,
              onChanged: (value) {
                productName = value;
              },
            ),
            SizedBox(height: spSm),
            QNumberField(
              label: "Target Price (\$)",
              value: targetPrice,
              onChanged: (value) {
                targetPrice = value;
              },
            ),
            SizedBox(height: spSm),
            QDropdownField(
              label: "Category",
              items: categories.where((c) => c["value"] != "All").toList(),
              value: selectedCategory,
              onChanged: (value, label) {
                selectedCategory = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              if (productName.isNotEmpty && targetPrice.isNotEmpty) {
                Navigator.pop(context);
                ss("Price alert created for $productName");
              }
            },
            child: Text("Create"),
          ),
        ],
      ),
    );
  }

  void _showEditAlertDialog(Map<String, dynamic> alert) {
    String targetPrice = "${alert["targetPrice"]}";
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Price Alert"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${alert["productName"]}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: spMd),
            QNumberField(
              label: "Target Price (\$)",
              value: targetPrice,
              onChanged: (value) {
                targetPrice = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              if (targetPrice.isNotEmpty) {
                int index = priceAlerts.indexWhere((a) => a["id"] == alert["id"]);
                if (index != -1) {
                  priceAlerts[index]["targetPrice"] = double.tryParse(targetPrice) ?? 0.0;
                  setState(() {});
                }
                Navigator.pop(context);
                ss("Price alert updated for ${alert["productName"]}");
              }
            },
            child: Text("Update"),
          ),
        ],
      ),
    );
  }

  void _showAlertHistory() {
    List<Map<String, dynamic>> triggeredAlerts = priceAlerts.where((a) => a["lastTriggered"] != null).toList();
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Alert History"),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          body: ListView.builder(
            padding: EdgeInsets.all(spMd),
            itemCount: triggeredAlerts.length,
            itemBuilder: (context, index) {
              final alert = triggeredAlerts[index];
              return Container(
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
                        "${alert["productImage"]}",
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${alert["productName"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Triggered: ${DateTime.parse("${alert["lastTriggered"]}").dMMMy}",
                            style: TextStyle(
                              fontSize: 14,
                              color: successColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Target: \$${(alert["targetPrice"] as double).currency}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.check_circle, color: successColor),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
