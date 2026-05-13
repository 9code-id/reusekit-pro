import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlWishlist3View extends StatefulWidget {
  @override
  State<GrlWishlist3View> createState() => _GrlWishlist3ViewState();
}

class _GrlWishlist3ViewState extends State<GrlWishlist3View> {
  bool loading = false;
  int selectedTab = 0;
  
  List<Map<String, dynamic>> collections = [
    {
      "name": "Fashion & Style",
      "icon": Icons.checkroom,
      "color": Colors.pink,
      "count": 12,
      "items": [
        {
          "id": 1,
          "title": "Designer Dress",
          "brand": "Gucci",
          "price": 2500.00,
          "image": "https://picsum.photos/200/200?random=11&keyword=dress",
          "priority": "high",
        },
        {
          "id": 2,
          "title": "Luxury Handbag",
          "brand": "Louis Vuitton",
          "price": 3200.00,
          "image": "https://picsum.photos/200/200?random=12&keyword=handbag",
          "priority": "medium",
        },
      ],
    },
    {
      "name": "Tech & Gadgets",
      "icon": Icons.devices,
      "color": Colors.blue,
      "count": 8,
      "items": [
        {
          "id": 3,
          "title": "iPhone 15 Pro Max",
          "brand": "Apple",
          "price": 1199.00,
          "image": "https://picsum.photos/200/200?random=13&keyword=iphone",
          "priority": "high",
        },
        {
          "id": 4,
          "title": "MacBook Pro M3",
          "brand": "Apple",
          "price": 2999.00,
          "image": "https://picsum.photos/200/200?random=14&keyword=macbook",
          "priority": "high",
        },
      ],
    },
    {
      "name": "Home & Living",
      "icon": Icons.home,
      "color": Colors.green,
      "count": 6,
      "items": [
        {
          "id": 5,
          "title": "Smart TV 75\"",
          "brand": "Samsung",
          "price": 1899.00,
          "image": "https://picsum.photos/200/200?random=15&keyword=tv",
          "priority": "medium",
        },
        {
          "id": 6,
          "title": "Robot Vacuum",
          "brand": "Roomba",
          "price": 799.00,
          "image": "https://picsum.photos/200/200?random=16&keyword=vacuum",
          "priority": "low",
        },
      ],
    },
    {
      "name": "Health & Fitness",
      "icon": Icons.fitness_center,
      "color": Colors.orange,
      "count": 4,
      "items": [
        {
          "id": 7,
          "title": "Peloton Bike",
          "brand": "Peloton",
          "price": 1495.00,
          "image": "https://picsum.photos/200/200?random=17&keyword=bike",
          "priority": "medium",
        },
      ],
    },
  ];

  Map<String, Color> priorityColors = {
    "high": Colors.red,
    "medium": Colors.orange,
    "low": Colors.blue,
  };

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return QTabBar(
      title: "Wishlist Collections",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Collections", icon: Icon(Icons.collections)),
        Tab(text: "All Items", icon: Icon(Icons.list)),
        Tab(text: "Priority", icon: Icon(Icons.priority_high)),
      ],
      tabChildren: [
        _buildCollectionsTab(),
        _buildAllItemsTab(),
        _buildPriorityTab(),
      ],
    );
  }

  Widget _buildCollectionsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Summary Card
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, secondaryColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "My Collections",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "${collections.fold(0, (sum, collection) => sum + (collection["count"] as int))} items in ${collections.length} collections",
                        style: TextStyle(
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.favorite,
                  size: 48,
                  color: Colors.white.withAlpha(150),
                ),
              ],
            ),
          ),

          // Collections Grid
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: collections.map((collection) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                  border: Border.all(
                    color: (collection["color"] as Color).withAlpha(50),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: (collection["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            collection["icon"] as IconData,
                            color: collection["color"] as Color,
                            size: 24,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "${collection["count"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: collection["color"] as Color,
                                ),
                              ),
                              Text(
                                "items",
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
                    
                    SizedBox(height: spSm),
                    
                    Text(
                      "${collection["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    SizedBox(height: spSm),
                    
                    // Preview Items
                    Container(
                      height: 60,
                      child: QHorizontalScroll(
                        children: (collection["items"] as List).take(3).map((item) {
                          return Container(
                            width: 60,
                            margin: EdgeInsets.only(right: spXs),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(radiusSm),
                              child: Image.network(
                                "${item["image"]}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    
                    SizedBox(height: spSm),
                    
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "View Collection",
                        size: bs.sm,
                        onPressed: () {
                          ss("Opening ${collection["name"]} collection");
                        },
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

  Widget _buildAllItemsTab() {
    List<Map<String, dynamic>> allItems = [];
    for (var collection in collections) {
      for (var item in collection["items"] as List) {
        Map<String, dynamic> itemWithCollection = Map.from(item as Map<String, dynamic>);
        itemWithCollection["collection"] = collection["name"];
        itemWithCollection["collectionColor"] = collection["color"];
        allItems.add(itemWithCollection);
      }
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Filter Bar
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "All Items (${allItems.length})",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                QButton(
                  icon: Icons.sort,
                  size: bs.sm,
                  onPressed: () {
                    ss("Sort options coming soon");
                  },
                ),
              ],
            ),
          ),

          // Items List
          ...allItems.map((item) {
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: item["collectionColor"] as Color,
                  ),
                ),
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
                                "${item["title"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: priorityColors[item["priority"]]?.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${item["priority"]}".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 10,
                                  color: priorityColors[item["priority"]],
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${item["brand"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${item["collection"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: item["collectionColor"] as Color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "\$${(item["price"] as double).currency}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      QButton(
                        icon: Icons.add_shopping_cart,
                        size: bs.sm,
                        onPressed: () {
                          ss("Added to cart");
                        },
                      ),
                      SizedBox(height: spXs),
                      QButton(
                        icon: Icons.delete,
                        size: bs.sm,
                        onPressed: () async {
                          bool isConfirmed = await confirm("Remove this item?");
                          if (isConfirmed) {
                            ss("Item removed");
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildPriorityTab() {
    List<Map<String, dynamic>> allItems = [];
    for (var collection in collections) {
      for (var item in collection["items"] as List) {
        Map<String, dynamic> itemWithCollection = Map.from(item as Map<String, dynamic>);
        itemWithCollection["collection"] = collection["name"];
        itemWithCollection["collectionColor"] = collection["color"];
        allItems.add(itemWithCollection);
      }
    }

    Map<String, List<Map<String, dynamic>>> itemsByPriority = {
      "high": [],
      "medium": [],
      "low": [],
    };

    for (var item in allItems) {
      String priority = item["priority"] as String;
      itemsByPriority[priority]?.add(item);
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Priority Stats
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildPriorityCard("High Priority", itemsByPriority["high"]!.length, Colors.red, Icons.priority_high),
              _buildPriorityCard("Medium Priority", itemsByPriority["medium"]!.length, Colors.orange, Icons.remove),
              _buildPriorityCard("Low Priority", itemsByPriority["low"]!.length, Colors.blue, Icons.keyboard_arrow_down),
            ],
          ),

          // Priority Sections
          ...itemsByPriority.entries.where((entry) => entry.value.isNotEmpty).map((entry) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: priorityColors[entry.key]?.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusLg),
                    border: Border.all(
                      color: priorityColors[entry.key]?.withAlpha(50) ?? Colors.grey,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        entry.key == "high" ? Icons.priority_high :
                        entry.key == "medium" ? Icons.remove : Icons.keyboard_arrow_down,
                        color: priorityColors[entry.key],
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "${entry.key.toUpperCase()} PRIORITY (${entry.value.length})",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: priorityColors[entry.key],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: spSm),
                ...entry.value.map((item) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                      border: Border(
                        left: BorderSide(
                          width: 4,
                          color: priorityColors[entry.key] ?? Colors.grey,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusSm),
                          child: Image.network(
                            "${item["image"]}",
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
                                "${item["title"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${item["brand"]} • ${item["collection"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "\$${(item["price"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        QButton(
                          icon: Icons.shopping_cart,
                          size: bs.sm,
                          onPressed: () {
                            ss("Added to cart");
                          },
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildPriorityCard(String title, int count, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border.all(
          color: color.withAlpha(50),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              icon,
              color: color,
              size: 32,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "$count",
            style: TextStyle(
              fontSize: fsH4,
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
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
