import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaOfflineMenuView extends StatefulWidget {
  const FdaOfflineMenuView({super.key});

  @override
  State<FdaOfflineMenuView> createState() => _FdaOfflineMenuViewState();
}

class _FdaOfflineMenuViewState extends State<FdaOfflineMenuView> {
  bool offlineMode = false;
  String selectedRestaurant = "all";
  String sortBy = "name";
  String searchQuery = "";
  
  DateTime lastSync = DateTime.now().subtract(Duration(hours: 2));
  String offlineDataSize = "15.2 MB";
  int totalOfflineItems = 245;

  List<Map<String, dynamic>> restaurants = [
    {
      "id": "1",
      "name": "Pizza Palace",
      "isDownloaded": true,
      "downloadSize": "4.2 MB",
      "menuItems": 45,
      "lastUpdated": DateTime.now().subtract(Duration(hours: 2)),
      "image": "https://picsum.photos/100/100?random=1&keyword=pizza"
    },
    {
      "id": "2",
      "name": "Burger Junction",
      "isDownloaded": true,
      "downloadSize": "3.8 MB",
      "menuItems": 32,
      "lastUpdated": DateTime.now().subtract(Duration(hours: 4)),
      "image": "https://picsum.photos/100/100?random=2&keyword=burger"
    },
    {
      "id": "3",
      "name": "Sushi Master",
      "isDownloaded": false,
      "downloadSize": "5.1 MB",
      "menuItems": 67,
      "lastUpdated": DateTime.now().subtract(Duration(days: 1)),
      "image": "https://picsum.photos/100/100?random=3&keyword=sushi"
    },
    {
      "id": "4",
      "name": "Pasta Corner",
      "isDownloaded": true,
      "downloadSize": "3.5 MB",
      "menuItems": 28,
      "lastUpdated": DateTime.now().subtract(Duration(hours: 6)),
      "image": "https://picsum.photos/100/100?random=4&keyword=pasta"
    },
  ];

  List<Map<String, dynamic>> offlineMenuItems = [
    {
      "id": "1",
      "name": "Margherita Pizza",
      "restaurant": "Pizza Palace",
      "price": 18.99,
      "description": "Fresh tomatoes, mozzarella, basil",
      "image": "https://picsum.photos/300/200?random=1&keyword=pizza",
      "category": "Pizza",
      "isAvailable": true,
      "downloadDate": DateTime.now().subtract(Duration(hours: 2))
    },
    {
      "id": "2",
      "name": "Classic Burger",
      "restaurant": "Burger Junction",
      "price": 14.99,
      "description": "Beef patty, lettuce, tomato, cheese",
      "image": "https://picsum.photos/300/200?random=2&keyword=burger",
      "category": "Burger",
      "isAvailable": true,
      "downloadDate": DateTime.now().subtract(Duration(hours: 4))
    },
    {
      "id": "3",
      "name": "Salmon Roll",
      "restaurant": "Sushi Master",
      "price": 12.99,
      "description": "Fresh salmon, avocado, cucumber",
      "image": "https://picsum.photos/300/200?random=3&keyword=sushi",
      "category": "Sushi",
      "isAvailable": false,
      "downloadDate": DateTime.now().subtract(Duration(days: 1))
    },
    {
      "id": "4",
      "name": "Carbonara Pasta",
      "restaurant": "Pasta Corner",
      "price": 16.99,
      "description": "Creamy sauce, bacon, parmesan",
      "image": "https://picsum.photos/300/200?random=4&keyword=pasta",
      "category": "Pasta",
      "isAvailable": true,
      "downloadDate": DateTime.now().subtract(Duration(hours: 6))
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredItems = _getFilteredItems();

    return Scaffold(
      appBar: AppBar(
        title: Text("Offline Menu"),
        actions: [
          IconButton(
            icon: Icon(offlineMode ? Icons.cloud_off : Icons.cloud),
            onPressed: () {
              offlineMode = !offlineMode;
              setState(() {});
              if (offlineMode) {
                si("Offline mode enabled");
              } else {
                si("Online mode enabled");
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.sync),
            onPressed: _syncOfflineData,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildOfflineStatusCard(),
            _buildDownloadManagementSection(),
            _buildSearchAndFilters(),
            _buildOfflineMenuSection(filteredItems),
          ],
        ),
      ),
    );
  }

  Widget _buildOfflineStatusCard() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: offlineMode 
              ? [warningColor, warningColor.withAlpha(200)]
              : [successColor, successColor.withAlpha(200)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                offlineMode ? Icons.cloud_off : Icons.cloud_done,
                color: Colors.white,
                size: 32,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      offlineMode ? "Offline Mode" : "Online Mode",
                      style: TextStyle(
                        color: Colors.white.withAlpha(200),
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      offlineMode ? "Using downloaded data" : "Live data available",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(40),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Text(
                  offlineDataSize,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(40),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Column(
              spacing: spXs,
              children: [
                _buildStatusRow("Downloaded items", "$totalOfflineItems items"),
                _buildStatusRow("Last sync", "${lastSync.dMMMy} at ${lastSync.kkmm}"),
                _buildStatusRow("Downloaded restaurants", "${restaurants.where((r) => r["isDownloaded"] as bool).length} of ${restaurants.length}"),
                _buildStatusRow("Storage used", offlineDataSize),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusRow(String label, String value) {
    return Row(
      children: [
        Text(
          "$label: ",
          style: TextStyle(
            color: Colors.white.withAlpha(200),
            fontSize: 12,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDownloadManagementSection() {
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
              Icon(Icons.download, color: primaryColor),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "Download Management",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                label: "Download All",
                size: bs.sm,
                onPressed: _downloadAllMenus,
              ),
            ],
          ),
          Column(
            spacing: spXs,
            children: restaurants.map((restaurant) => _buildRestaurantDownloadCard(restaurant)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildRestaurantDownloadCard(Map<String, dynamic> restaurant) {
    final bool isDownloaded = restaurant["isDownloaded"] as bool;
    final DateTime lastUpdated = restaurant["lastUpdated"] as DateTime;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: isDownloaded ? successColor.withAlpha(20) : Colors.grey.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: isDownloaded ? Border.all(color: successColor.withAlpha(100)) : null,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusSm),
            child: Image.network(
              "${restaurant["image"]}",
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${restaurant["name"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Icon(
                      isDownloaded ? Icons.cloud_done : Icons.cloud_download,
                      color: isDownloaded ? successColor : disabledBoldColor,
                      size: 16,
                    ),
                  ],
                ),
                Text(
                  "${restaurant["menuItems"]} items • ${restaurant["downloadSize"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "Updated ${lastUpdated.dMMMy}",
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledColor,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              QButton(
                icon: isDownloaded ? Icons.refresh : Icons.download,
                size: bs.sm,
                onPressed: () {
                  if (isDownloaded) {
                    _updateRestaurantMenu(restaurant);
                  } else {
                    _downloadRestaurantMenu(restaurant);
                  }
                },
              ),
              if (isDownloaded) ...[
                SizedBox(height: spXs),
                QButton(
                  icon: Icons.delete,
                  size: bs.sm,
                  onPressed: () {
                    _deleteRestaurantMenu(restaurant);
                  },
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search menu items...",
                  value: searchQuery,
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
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Restaurant",
                  items: [
                    {"label": "All Restaurants", "value": "all"},
                    ...restaurants.where((r) => r["isDownloaded"] as bool).map((r) => {
                      "label": r["name"],
                      "value": r["id"],
                    }).toList(),
                  ],
                  value: selectedRestaurant,
                  onChanged: (value, label) {
                    selectedRestaurant = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Sort by",
                  items: [
                    {"label": "Name A-Z", "value": "name"},
                    {"label": "Price Low-High", "value": "price_asc"},
                    {"label": "Price High-Low", "value": "price_desc"},
                    {"label": "Recently Downloaded", "value": "download_date"},
                  ],
                  value: sortBy,
                  onChanged: (value, label) {
                    sortBy = value;
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

  Widget _buildOfflineMenuSection(List<Map<String, dynamic>> items) {
    if (items.isEmpty) {
      return Container(
        padding: EdgeInsets.all(spLg),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
        ),
        child: Column(
          children: [
            Icon(
              offlineMode ? Icons.cloud_off : Icons.restaurant_menu,
              size: 64,
              color: disabledColor,
            ),
            SizedBox(height: spSm),
            Text(
              offlineMode ? "No offline menu available" : "No menu items found",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              offlineMode 
                  ? "Download restaurant menus to browse offline"
                  : "Try adjusting your search or filters",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: disabledColor,
              ),
            ),
            if (offlineMode) ...[
              SizedBox(height: spMd),
              QButton(
                label: "Download Menus",
                onPressed: _downloadAllMenus,
              ),
            ],
          ],
        ),
      );
    }

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
              Icon(Icons.restaurant_menu, color: primaryColor),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  offlineMode ? "Offline Menu (${items.length})" : "Available Menu (${items.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          Column(
            spacing: spXs,
            children: items.map((item) => _buildMenuItemCard(item)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItemCard(Map<String, dynamic> item) {
    final bool isAvailable = item["isAvailable"] as bool;
    final DateTime downloadDate = item["downloadDate"] as DateTime;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: isAvailable ? Colors.white : Colors.grey.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: isAvailable ? [shadowXxs] : null,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusSm),
            child: Image.network(
              "${item["image"]}",
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
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${item["name"]}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isAvailable ? primaryColor : disabledBoldColor,
                        ),
                      ),
                    ),
                    if (!isAvailable)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: dangerColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "Offline",
                          style: TextStyle(
                            fontSize: 10,
                            color: dangerColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
                Text(
                  "${item["restaurant"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(
                  "${item["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Text(
                      "\$${(item["price"] as double).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    if (offlineMode)
                      Text(
                        "Downloaded ${downloadDate.dMMMy}",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledColor,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              QButton(
                label: "Add",
                size: bs.sm,
                onPressed: isAvailable ? () {
                  _addToCart(item);
                } : null,
              ),
              if (offlineMode) ...[
                SizedBox(height: spXs),
                QButton(
                  icon: Icons.refresh,
                  size: bs.sm,
                  onPressed: () {
                    _updateMenuItem(item);
                  },
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredItems() {
    var filtered = offlineMenuItems.where((item) {
      bool matchesSearch = searchQuery.isEmpty || 
          (item["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (item["restaurant"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesRestaurant = selectedRestaurant == "all" || 
          restaurants.any((r) => r["id"] == selectedRestaurant && r["name"] == item["restaurant"]);
      
      bool isAccessible = !offlineMode || (item["isAvailable"] as bool);
      
      return matchesSearch && matchesRestaurant && isAccessible;
    }).toList();

    // Sort items
    filtered.sort((a, b) {
      switch (sortBy) {
        case "name":
          return (a["name"] as String).compareTo(b["name"] as String);
        case "price_asc":
          return (a["price"] as double).compareTo(b["price"] as double);
        case "price_desc":
          return (b["price"] as double).compareTo(a["price"] as double);
        case "download_date":
          return (b["downloadDate"] as DateTime).compareTo(a["downloadDate"] as DateTime);
        default:
          return 0;
      }
    });

    return filtered;
  }

  void _syncOfflineData() async {
    showLoading();
    
    // Simulate sync process
    await Future.delayed(Duration(seconds: 2));
    
    hideLoading();
    
    setState(() {
      lastSync = DateTime.now();
      // Update some items as available
      for (var item in offlineMenuItems) {
        if (!(item["isAvailable"] as bool)) {
          item["isAvailable"] = true;
        }
      }
    });
    
    ss("Offline data synced successfully!");
  }

  void _downloadAllMenus() async {
    showLoading();
    
    // Simulate download process
    await Future.delayed(Duration(seconds: 3));
    
    hideLoading();
    
    setState(() {
      for (var restaurant in restaurants) {
        restaurant["isDownloaded"] = true;
        restaurant["lastUpdated"] = DateTime.now();
      }
      totalOfflineItems = 245;
      offlineDataSize = "18.7 MB";
    });
    
    ss("All restaurant menus downloaded!");
  }

  void _downloadRestaurantMenu(Map<String, dynamic> restaurant) async {
    showLoading();
    
    // Simulate download
    await Future.delayed(Duration(seconds: 2));
    
    hideLoading();
    
    setState(() {
      restaurant["isDownloaded"] = true;
      restaurant["lastUpdated"] = DateTime.now();
    });
    
    ss("${restaurant["name"]} menu downloaded!");
  }

  void _updateRestaurantMenu(Map<String, dynamic> restaurant) async {
    showLoading();
    
    // Simulate update
    await Future.delayed(Duration(seconds: 1));
    
    hideLoading();
    
    setState(() {
      restaurant["lastUpdated"] = DateTime.now();
    });
    
    ss("${restaurant["name"]} menu updated!");
  }

  void _deleteRestaurantMenu(Map<String, dynamic> restaurant) async {
    bool isConfirmed = await confirm("Delete offline menu for ${restaurant["name"]}?");
    
    if (isConfirmed) {
      setState(() {
        restaurant["isDownloaded"] = false;
      });
      
      ss("${restaurant["name"]} offline menu deleted");
    }
  }

  void _addToCart(Map<String, dynamic> item) {
    ss("${item["name"]} added to cart!");
  }

  void _updateMenuItem(Map<String, dynamic> item) async {
    showLoading();
    
    // Simulate update
    await Future.delayed(Duration(seconds: 1));
    
    hideLoading();
    
    setState(() {
      item["downloadDate"] = DateTime.now();
      item["isAvailable"] = true;
    });
    
    ss("${item["name"]} updated!");
  }
}
