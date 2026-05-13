import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlWishlist2View extends StatefulWidget {
  @override
  State<GrlWishlist2View> createState() => _GrlWishlist2ViewState();
}

class _GrlWishlist2ViewState extends State<GrlWishlist2View> {
  bool loading = false;
  String selectedSort = "newest";
  bool showOnlyInStock = false;
  
  List<Map<String, dynamic>> sortOptions = [
    {"label": "Newest First", "value": "newest"},
    {"label": "Price: Low to High", "value": "price_asc"},
    {"label": "Price: High to Low", "value": "price_desc"},
    {"label": "Most Popular", "value": "popular"},
  ];

  List<Map<String, dynamic>> wishlistItems = [
    {
      "id": 1,
      "title": "Gaming Laptop",
      "brand": "ASUS ROG",
      "price": 1299.99,
      "originalPrice": 1599.99,
      "discount": 19,
      "image": "https://picsum.photos/400/300?random=7&keyword=laptop",
      "category": "Electronics",
      "rating": 4.7,
      "reviews": 1842,
      "inStock": true,
      "dateAdded": "2024-12-15",
      "specifications": ["Intel i7", "16GB RAM", "RTX 4060", "1TB SSD"],
    },
    {
      "id": 2,
      "title": "Premium Skincare Set",
      "brand": "La Mer",
      "price": 189.99,
      "originalPrice": 249.99,
      "discount": 24,
      "image": "https://picsum.photos/400/300?random=8&keyword=skincare",
      "category": "Beauty",
      "rating": 4.9,
      "reviews": 2156,
      "inStock": false,
      "dateAdded": "2024-12-10",
      "specifications": ["Anti-aging", "Moisturizing", "Vitamin C", "SPF 30"],
    },
    {
      "id": 3,
      "title": "Professional Camera",
      "brand": "Canon EOS R6",
      "price": 2499.99,
      "originalPrice": 2899.99,
      "discount": 14,
      "image": "https://picsum.photos/400/300?random=9&keyword=camera",
      "category": "Electronics",
      "rating": 4.8,
      "reviews": 987,
      "inStock": true,
      "dateAdded": "2024-12-08",
      "specifications": ["45MP", "4K Video", "Weather Sealed", "Dual Card Slots"],
    },
    {
      "id": 4,
      "title": "Luxury Watch",
      "brand": "Rolex",
      "price": 8999.99,
      "originalPrice": 9999.99,
      "discount": 10,
      "image": "https://picsum.photos/400/300?random=10&keyword=luxury-watch",
      "category": "Accessories",
      "rating": 5.0,
      "reviews": 456,
      "inStock": true,
      "dateAdded": "2024-12-05",
      "specifications": ["Automatic", "Sapphire Crystal", "Water Resistant", "Swiss Made"],
    },
  ];

  List<Map<String, dynamic>> get filteredAndSortedItems {
    List<Map<String, dynamic>> items = List.from(wishlistItems);
    
    if (showOnlyInStock) {
      items = items.where((item) => item["inStock"] as bool).toList();
    }

    switch (selectedSort) {
      case "price_asc":
        items.sort((a, b) => (a["price"] as double).compareTo(b["price"] as double));
        break;
      case "price_desc":
        items.sort((a, b) => (b["price"] as double).compareTo(a["price"] as double));
        break;
      case "popular":
        items.sort((a, b) => (b["reviews"] as int).compareTo(a["reviews"] as int));
        break;
      default: // newest
        items.sort((a, b) => DateTime.parse("${b["dateAdded"]}").compareTo(DateTime.parse("${a["dateAdded"]}")));
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Premium Wishlist"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterBottomSheet();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Header with actions
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(200)],
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
                          "Your Collection",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "${filteredAndSortedItems.length} premium items",
                          style: TextStyle(
                            color: Colors.white.withAlpha(200),
                          ),
                        ),
                      ],
                    ),
                  ),
                  QButton(
                    icon: Icons.share,
                    size: bs.sm,
                    onPressed: () {
                      ss("Collection shared successfully");
                    },
                  ),
                ],
              ),
            ),

            // Filter Controls
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Sort by",
                          items: sortOptions,
                          value: selectedSort,
                          onChanged: (value, label) {
                            selectedSort = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Show only in stock items",
                        "value": true,
                        "checked": showOnlyInStock,
                      }
                    ],
                    value: [
                      if (showOnlyInStock)
                        {
                          "label": "Show only in stock items",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      showOnlyInStock = values.isNotEmpty;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Wishlist Items Grid
            ...filteredAndSortedItems.map((item) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                  border: Border.all(
                    color: disabledOutlineBorderColor,
                    width: 0.5,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image and Badge
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusLg),
                          child: Image.network(
                            "${item["image"]}",
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: spSm,
                          right: spSm,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: dangerColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${item["discount"]}% OFF",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        if (!(item["inStock"] as bool))
                          Positioned(
                            top: spSm,
                            left: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(150),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "Out of Stock",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    
                    SizedBox(height: spSm),
                    
                    // Title and Brand
                    Text(
                      "${item["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    Text(
                      "${item["brand"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    
                    SizedBox(height: spXs),
                    
                    // Rating
                    Row(
                      children: [
                        ...List.generate(5, (index) {
                          return Icon(
                            Icons.star,
                            size: 16,
                            color: index < (item["rating"] as double).floor() 
                                ? warningColor 
                                : disabledColor,
                          );
                        }),
                        SizedBox(width: spXs),
                        Text(
                          "${item["rating"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          " (${item["reviews"]})",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spSm),
                    
                    // Specifications
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: (item["specifications"] as List).map((spec) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                            border: Border.all(
                              color: infoColor.withAlpha(50),
                              width: 0.5,
                            ),
                          ),
                          child: Text(
                            "$spec",
                            style: TextStyle(
                              fontSize: 10,
                              color: infoColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    
                    SizedBox(height: spSm),
                    
                    // Price Section
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "\$${(item["price"] as double).currency}",
                                style: TextStyle(
                                  fontSize: fsH5,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "\$${(item["originalPrice"] as double).currency}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Save \$${((item["originalPrice"] as double) - (item["price"] as double)).currency}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: successColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spSm),
                    
                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: QButton(
                            label: (item["inStock"] as bool) ? "Add to Cart" : "Notify When Available",
                            size: bs.sm,
                            onPressed: () {
                              if (item["inStock"] as bool) {
                                ss("Added to cart successfully");
                              } else {
                                ss("You'll be notified when item is back in stock");
                              }
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.favorite,
                          size: bs.sm,
                          onPressed: () async {
                            bool isConfirmed = await confirm("Remove from wishlist?");
                            if (isConfirmed) {
                              wishlistItems.removeWhere((i) => i["id"] == item["id"]);
                              setState(() {});
                              ss("Removed from wishlist");
                            }
                          },
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.share,
                          size: bs.sm,
                          onPressed: () {
                            ss("Product shared successfully");
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
      ),
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: EdgeInsets.all(spMd),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Filter & Sort",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  QDropdownField(
                    label: "Sort by",
                    items: sortOptions,
                    value: selectedSort,
                    onChanged: (value, label) {
                      selectedSort = value;
                      setState(() {});
                      setModalState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  QSwitch(
                    items: [
                      {
                        "label": "Show only available items",
                        "value": true,
                        "checked": showOnlyInStock,
                      }
                    ],
                    value: [
                      if (showOnlyInStock)
                        {
                          "label": "Show only available items",
                          "value": true,
                          "checked": true
                        }
                    ],
                    onChanged: (values, ids) {
                      showOnlyInStock = values.isNotEmpty;
                      setState(() {});
                      setModalState(() {});
                    },
                  ),
                  SizedBox(height: spMd),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Apply Filters",
                      size: bs.md,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
