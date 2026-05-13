import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaCuisineView extends StatefulWidget {
  const FdaCuisineView({super.key});

  @override
  State<FdaCuisineView> createState() => _FdaCuisineViewState();
}

class _FdaCuisineViewState extends State<FdaCuisineView> {
  String selectedCuisine = "Italian";
  String selectedFilter = "popular";
  String searchQuery = "";

  final List<Map<String, dynamic>> cuisines = [
    {"name": "Italian", "image": "https://picsum.photos/100/100?random=1&keyword=italian"},
    {"name": "Chinese", "image": "https://picsum.photos/100/100?random=2&keyword=chinese"},
    {"name": "Mexican", "image": "https://picsum.photos/100/100?random=3&keyword=mexican"},
    {"name": "Indian", "image": "https://picsum.photos/100/100?random=4&keyword=indian"},
    {"name": "Thai", "image": "https://picsum.photos/100/100?random=5&keyword=thai"},
    {"name": "Japanese", "image": "https://picsum.photos/100/100?random=6&keyword=japanese"},
    {"name": "French", "image": "https://picsum.photos/100/100?random=7&keyword=french"},
    {"name": "Greek", "image": "https://picsum.photos/100/100?random=8&keyword=greek"},
  ];

  final List<Map<String, dynamic>> filterOptions = [
    {"label": "Popular", "value": "popular"},
    {"label": "Rating", "value": "rating"},
    {"label": "Price: Low to High", "value": "price_low"},
    {"label": "Price: High to Low", "value": "price_high"},
    {"label": "Delivery Time", "value": "delivery_time"},
    {"label": "Distance", "value": "distance"},
  ];

  final List<Map<String, dynamic>> restaurants = [
    {
      "id": 1,
      "name": "Mario's Authentic Italian",
      "cuisine": "Italian",
      "image": "https://picsum.photos/300/200?random=10&keyword=restaurant",
      "rating": 4.8,
      "reviewCount": 342,
      "deliveryTime": "25-35 min",
      "deliveryFee": 2.99,
      "minOrder": 15.00,
      "distance": 1.2,
      "isOpen": true,
      "priceRange": "\$\$\$",
      "specialties": ["Pizza", "Pasta", "Risotto"],
      "offers": ["Free delivery on orders over \$30", "20% off first order"],
    },
    {
      "id": 2,
      "name": "Golden Dragon Chinese",
      "cuisine": "Chinese",
      "image": "https://picsum.photos/300/200?random=11&keyword=restaurant",
      "rating": 4.6,
      "reviewCount": 189,
      "deliveryTime": "30-40 min",
      "deliveryFee": 3.49,
      "minOrder": 20.00,
      "distance": 2.1,
      "isOpen": true,
      "priceRange": "\$\$",
      "specialties": ["Dim Sum", "Noodles", "Fried Rice"],
      "offers": ["Buy 2 Get 1 Free on selected items"],
    },
    {
      "id": 3,
      "name": "Spice Village Indian",
      "cuisine": "Indian",
      "image": "https://picsum.photos/300/200?random=12&keyword=restaurant",
      "rating": 4.7,
      "reviewCount": 267,
      "deliveryTime": "35-45 min",
      "deliveryFee": 2.49,
      "minOrder": 18.00,
      "distance": 1.8,
      "isOpen": false,
      "priceRange": "\$\$",
      "specialties": ["Curry", "Biryani", "Tandoori"],
      "offers": ["15% off on orders above \$25"],
    },
    {
      "id": 4,
      "name": "El Sombrero Mexican",
      "cuisine": "Mexican",
      "image": "https://picsum.photos/300/200?random=13&keyword=restaurant",
      "rating": 4.5,
      "reviewCount": 158,
      "deliveryTime": "20-30 min",
      "deliveryFee": 1.99,
      "minOrder": 12.00,
      "distance": 0.9,
      "isOpen": true,
      "priceRange": "\$\$",
      "specialties": ["Tacos", "Burritos", "Quesadillas"],
      "offers": ["Free nachos with every order"],
    },
    {
      "id": 5,
      "name": "Bangkok Express Thai",
      "cuisine": "Thai",
      "image": "https://picsum.photos/300/200?random=14&keyword=restaurant",
      "rating": 4.9,
      "reviewCount": 401,
      "deliveryTime": "25-35 min",
      "deliveryFee": 2.99,
      "minOrder": 16.00,
      "distance": 1.5,
      "isOpen": true,
      "priceRange": "\$\$",
      "specialties": ["Pad Thai", "Green Curry", "Tom Yum"],
      "offers": ["10% off for new customers"],
    },
  ];

  List<Map<String, dynamic>> get filteredRestaurants {
    List<Map<String, dynamic>> filtered = restaurants;

    // Filter by cuisine
    if (selectedCuisine != "All") {
      filtered = filtered.where((restaurant) => restaurant["cuisine"] == selectedCuisine).toList();
    }

    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((restaurant) {
        return (restaurant["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
               (restaurant["cuisine"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
               (restaurant["specialties"] as List).any((specialty) => 
                 (specialty as String).toLowerCase().contains(searchQuery.toLowerCase()));
      }).toList();
    }

    // Sort by selected filter
    switch (selectedFilter) {
      case "rating":
        filtered.sort((a, b) => (b["rating"] as double).compareTo(a["rating"] as double));
        break;
      case "price_low":
        filtered.sort((a, b) => (a["priceRange"] as String).length.compareTo((b["priceRange"] as String).length));
        break;
      case "price_high":
        filtered.sort((a, b) => (b["priceRange"] as String).length.compareTo((a["priceRange"] as String).length));
        break;
      case "delivery_time":
        filtered.sort((a, b) => (a["deliveryTime"] as String).compareTo(b["deliveryTime"] as String));
        break;
      case "distance":
        filtered.sort((a, b) => (a["distance"] as double).compareTo(b["distance"] as double));
        break;
      default: // popular
        filtered.sort((a, b) => (b["reviewCount"] as int).compareTo(a["reviewCount"] as int));
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cuisines"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              _showSearchBottomSheet();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cuisine Categories
            Text(
              "Browse by Cuisine",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),

            // Cuisine Grid
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 150,
              children: cuisines.map((cuisine) {
                final isSelected = selectedCuisine == cuisine["name"];
                return GestureDetector(
                  onTap: () {
                    selectedCuisine = cuisine["name"];
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                        width: isSelected ? 2 : 1,
                      ),
                      boxShadow: isSelected ? [shadowMd] : [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusSm)),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusSm)),
                            child: Image.network(
                              "${cuisine["image"]}",
                              width: double.infinity,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Text(
                            "${cuisine["name"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: isSelected ? primaryColor : disabledBoldColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: spLg),

            // Filter and Results Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${selectedCuisine} Restaurants",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _showFilterBottomSheet();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: primaryColor),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.filter_list,
                          size: 16,
                          color: primaryColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Filter",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: spMd),

            // Restaurant List
            if (filteredRestaurants.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.restaurant,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No restaurants found",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Try adjusting your filters or search terms",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            else
              Column(
                children: filteredRestaurants.map((restaurant) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Restaurant Image
                        Stack(
                          children: [
                            Container(
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusSm)),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusSm)),
                                child: Image.network(
                                  "${restaurant["image"]}",
                                  width: double.infinity,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            if (!(restaurant["isOpen"] as bool))
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withAlpha(150),
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(radiusSm)),
                                  ),
                                  child: Center(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                                      decoration: BoxDecoration(
                                        color: dangerColor,
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Text(
                                        "CLOSED",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            // Offers Badge
                            if ((restaurant["offers"] as List).isNotEmpty)
                              Positioned(
                                top: spSm,
                                left: spSm,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: successColor,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "OFFERS",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),

                        // Restaurant Details
                        Padding(
                          padding: EdgeInsets.all(spMd),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Name and Rating
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${restaurant["name"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: warningColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: warningColor,
                                          size: 14,
                                        ),
                                        SizedBox(width: spXs),
                                        Text(
                                          "${restaurant["rating"]}",
                                          style: TextStyle(
                                            color: warningColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: spSm),

                              // Info Row
                              Row(
                                children: [
                                  Text(
                                    "${restaurant["cuisine"]} • ${restaurant["priceRange"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Icon(
                                    Icons.access_time,
                                    size: 14,
                                    color: disabledBoldColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${restaurant["deliveryTime"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: spSm),

                              // Specialties
                              Wrap(
                                spacing: spXs,
                                runSpacing: spXs,
                                children: (restaurant["specialties"] as List).take(3).map((specialty) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: infoColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "$specialty",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: infoColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),

                              SizedBox(height: spSm),

                              // Delivery Info
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.delivery_dining,
                                        size: 16,
                                        color: primaryColor,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "\$${(restaurant["deliveryFee"] as double).toStringAsFixed(2)} delivery",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: primaryColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "Min \$${(restaurant["minOrder"] as double).toStringAsFixed(2)}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),

                              if ((restaurant["offers"] as List).isNotEmpty) ...[
                                SizedBox(height: spSm),
                                Container(
                                  padding: EdgeInsets.all(spSm),
                                  decoration: BoxDecoration(
                                    color: successColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                    border: Border.all(color: successColor.withAlpha(50)),
                                  ),
                                  child: Text(
                                    "${(restaurant["offers"] as List).first}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: successColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: EdgeInsets.all(spMd),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sort & Filter",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Column(
                    children: filterOptions.map((option) {
                      return RadioListTile<String>(
                        title: Text("${option["label"]}"),
                        value: option["value"],
                        groupValue: selectedFilter,
                        onChanged: (value) {
                          selectedFilter = value!;
                          setModalState(() {});
                          setState(() {});
                          Navigator.pop(context);
                        },
                      );
                    }).toList(),
                  ),
                  SizedBox(height: spMd),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showSearchBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Search Restaurants",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              QTextField(
                label: "Search",
                value: searchQuery,
                hint: "Restaurant name, cuisine, or dish...",
                onChanged: (value) {
                  searchQuery = value;
                  setState(() {});
                },
              ),
              SizedBox(height: spMd),
              Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: "Clear",
                      size: bs.sm,
                      onPressed: () {
                        searchQuery = "";
                        setState(() {});
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: "Search",
                      size: bs.sm,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
