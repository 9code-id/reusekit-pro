import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaCategoryBrowseView extends StatefulWidget {
  const SpaCategoryBrowseView({super.key});

  @override
  State<SpaCategoryBrowseView> createState() => _SpaCategoryBrowseViewState();
}

class _SpaCategoryBrowseViewState extends State<SpaCategoryBrowseView> {
  String searchQuery = "";
  String selectedCategory = "";
  String sortBy = "name";
  bool showSubcategories = true;

  List<Map<String, dynamic>> categories = [
    {
      "id": "1",
      "name": "Facial Treatments",
      "description": "Rejuvenating facial therapies",
      "image": "https://picsum.photos/300/200?random=1&keyword=facial",
      "serviceCount": 15,
      "avgPrice": 120.0,
      "popular": true,
      "subcategories": [
        {"name": "Anti-Aging", "count": 5},
        {"name": "Hydrating", "count": 4},
        {"name": "Deep Cleansing", "count": 6},
      ]
    },
    {
      "id": "2",
      "name": "Body Massage",
      "description": "Relaxing and therapeutic massages",
      "image": "https://picsum.photos/300/200?random=2&keyword=massage",
      "serviceCount": 22,
      "avgPrice": 150.0,
      "popular": true,
      "subcategories": [
        {"name": "Swedish Massage", "count": 8},
        {"name": "Deep Tissue", "count": 6},
        {"name": "Hot Stone", "count": 4},
        {"name": "Aromatherapy", "count": 4},
      ]
    },
    {
      "id": "3",
      "name": "Body Scrubs",
      "description": "Exfoliating body treatments",
      "image": "https://picsum.photos/300/200?random=3&keyword=scrub",
      "serviceCount": 8,
      "avgPrice": 90.0,
      "popular": false,
      "subcategories": [
        {"name": "Salt Scrub", "count": 3},
        {"name": "Sugar Scrub", "count": 3},
        {"name": "Coffee Scrub", "count": 2},
      ]
    },
    {
      "id": "4",
      "name": "Nail Care",
      "description": "Professional nail treatments",
      "image": "https://picsum.photos/300/200?random=4&keyword=nails",
      "serviceCount": 12,
      "avgPrice": 60.0,
      "popular": true,
      "subcategories": [
        {"name": "Manicure", "count": 6},
        {"name": "Pedicure", "count": 4},
        {"name": "Nail Art", "count": 2},
      ]
    },
    {
      "id": "5",
      "name": "Hair Treatments",
      "description": "Luxurious hair care services",
      "image": "https://picsum.photos/300/200?random=5&keyword=hair",
      "serviceCount": 10,
      "avgPrice": 80.0,
      "popular": false,
      "subcategories": [
        {"name": "Hair Mask", "count": 4},
        {"name": "Scalp Treatment", "count": 3},
        {"name": "Hair Spa", "count": 3},
      ]
    },
    {
      "id": "6",
      "name": "Wellness Packages",
      "description": "Complete wellness experiences",
      "image": "https://picsum.photos/300/200?random=6&keyword=wellness",
      "serviceCount": 6,
      "avgPrice": 250.0,
      "popular": true,
      "subcategories": [
        {"name": "Half Day Package", "count": 3},
        {"name": "Full Day Package", "count": 2},
        {"name": "Couples Package", "count": 1},
      ]
    },
  ];

  List<Map<String, dynamic>> featuredCategories = [
    {
      "name": "Most Popular",
      "icon": Icons.star,
      "color": Colors.amber,
      "description": "Top rated services"
    },
    {
      "name": "New Arrivals",
      "icon": Icons.fiber_new,
      "color": Colors.green,
      "description": "Latest treatments"
    },
    {
      "name": "Special Offers",
      "icon": Icons.local_offer,
      "color": Colors.red,
      "description": "Limited time deals"
    },
    {
      "name": "Couples Treatments",
      "icon": Icons.favorite,
      "color": Colors.pink,
      "description": "Romantic experiences"
    },
  ];

  List<Map<String, dynamic>> get filteredCategories {
    var filtered = categories.where((category) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${category["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${category["description"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesCategory = selectedCategory.isEmpty || 
          "${category["name"]}" == selectedCategory;
      
      return matchesSearch && matchesCategory;
    }).toList();

    switch (sortBy) {
      case "name":
        filtered.sort((a, b) => "${a["name"]}".compareTo("${b["name"]}"));
        break;
      case "popular":
        filtered.sort((a, b) => (b["popular"] as bool ? 1 : 0).compareTo(a["popular"] as bool ? 1 : 0));
        break;
      case "price":
        filtered.sort((a, b) => (a["avgPrice"] as double).compareTo(b["avgPrice"] as double));
        break;
      case "services":
        filtered.sort((a, b) => (b["serviceCount"] as int).compareTo(a["serviceCount"] as int));
        break;
    }

    return filtered;
  }

  void _showFilterModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: disabledOutlineBorderColor)),
              ),
              child: Row(
                children: [
                  Text(
                    "Filter Categories",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close, color: disabledBoldColor),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sort By",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    QDropdownField(
                      label: "Sort Order",
                      items: [
                        {"label": "Name (A-Z)", "value": "name"},
                        {"label": "Most Popular", "value": "popular"},
                        {"label": "Price (Low to High)", "value": "price"},
                        {"label": "Most Services", "value": "services"},
                      ],
                      value: sortBy,
                      onChanged: (value, label) {
                        sortBy = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: spLg),
                    Row(
                      children: [
                        Text(
                          "Show Subcategories",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Switch(
                          value: showSubcategories,
                          onChanged: (value) {
                            showSubcategories = value;
                            setState(() {});
                          },
                          activeColor: primaryColor,
                        ),
                      ],
                    ),
                    SizedBox(height: spLg),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Apply Filters",
                        size: bs.md,
                        onPressed: () {
                          Navigator.pop(context);
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCategoryDetail(Map<String, dynamic> category) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
        ),
        child: Column(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                image: DecorationImage(
                  image: NetworkImage("${category["image"]}"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withAlpha(180),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: spMd,
                      right: spMd,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(200),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Icon(Icons.close, size: 20),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: spMd,
                      left: spMd,
                      right: spMd,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${category["name"]}",
                                  style: TextStyle(
                                    fontSize: fsH4,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              if (category["popular"] as bool)
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.star, size: 14, color: Colors.white),
                                      SizedBox(width: 4),
                                      Text(
                                        "Popular",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${category["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withAlpha(230),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${category["serviceCount"]} Services",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "From \$${(category["avgPrice"] as double).toInt()}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: successColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (showSubcategories && (category["subcategories"] as List).isNotEmpty) ...[
                      SizedBox(height: spLg),
                      Text(
                        "Subcategories",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      ...(category["subcategories"] as List).map((subcategory) {
                        return Container(
                          margin: EdgeInsets.only(bottom: spSm),
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.grey.withAlpha(13),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: disabledOutlineBorderColor),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${subcategory["name"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Text(
                                "${subcategory["count"]} services",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                    SizedBox(height: spLg),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Browse ${category["name"]}",
                        size: bs.md,
                        onPressed: () {
                          Navigator.pop(context);
                          // navigateTo("spa_product_list_view", category: category)
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Browse Categories"),
        actions: [
          GestureDetector(
            onTap: _showFilterModal,
            child: Container(
              padding: EdgeInsets.all(spXs),
              margin: EdgeInsets.only(right: spSm),
              child: Icon(Icons.tune),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search categories...",
                    value: searchQuery,
                    hint: "Find your perfect treatment",
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
                  onPressed: () {
                    // Perform search
                    setState(() {});
                  },
                ),
              ],
            ),

            SizedBox(height: spLg),

            // Featured Categories
            Text(
              "Featured Collections",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            QHorizontalScroll(
              children: featuredCategories.map((featured) {
                return Container(
                  width: 160,
                  margin: EdgeInsets.only(right: spSm),
                  child: GestureDetector(
                    onTap: () {
                      // navigateTo("spa_product_list_view", filter: featured["name"])
                    },
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                        border: Border.all(color: disabledOutlineBorderColor),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: (featured["color"] as Color).withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Icon(
                              featured["icon"] as IconData,
                              color: featured["color"] as Color,
                              size: 28,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "${featured["name"]}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${featured["description"]}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: spLg),

            // Category Stats
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(13),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${filteredCategories.length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Categories",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 30,
                    color: disabledOutlineBorderColor,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "${filteredCategories.fold(0, (sum, cat) => sum + (cat["serviceCount"] as int))}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Total Services",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 30,
                    color: disabledOutlineBorderColor,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "\$${((filteredCategories.fold(0.0, (sum, cat) => sum + (cat["avgPrice"] as double)) / filteredCategories.length).toInt())}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Avg Price",
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
            ),

            SizedBox(height: spLg),

            // Categories Header
            Row(
              children: [
                Text(
                  "All Categories",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "${filteredCategories.length} found",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),

            SizedBox(height: spSm),

            // Categories Grid
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: filteredCategories.map((category) {
                return GestureDetector(
                  onTap: () => _showCategoryDetail(category),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                      border: Border.all(color: disabledOutlineBorderColor),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Category Image
                        Container(
                          height: 140,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                            image: DecorationImage(
                              image: NetworkImage("${category["image"]}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withAlpha(100),
                                ],
                              ),
                            ),
                            child: Stack(
                              children: [
                                if (category["popular"] as bool)
                                  Positioned(
                                    top: spSm,
                                    right: spSm,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spSm,
                                        vertical: spXs,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.star, size: 12, color: Colors.white),
                                          SizedBox(width: 4),
                                          Text(
                                            "Popular",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                Positioned(
                                  bottom: spSm,
                                  left: spSm,
                                  right: spSm,
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spSm,
                                          vertical: spXs,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withAlpha(200),
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Text(
                                          "${category["serviceCount"]} services",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spSm,
                                          vertical: spXs,
                                        ),
                                        decoration: BoxDecoration(
                                          color: successColor.withAlpha(200),
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Text(
                                          "From \$${(category["avgPrice"] as double).toInt()}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Category Info
                        Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${category["name"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${category["description"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),

                              if (showSubcategories && (category["subcategories"] as List).isNotEmpty) ...[
                                SizedBox(height: spSm),
                                Wrap(
                                  spacing: 6,
                                  runSpacing: 4,
                                  children: (category["subcategories"] as List).take(3).map((subcategory) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: primaryColor.withAlpha(13),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${subcategory["name"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: primaryColor,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],

                              SizedBox(height: spSm),

                              // Browse Button
                              Container(
                                width: double.infinity,
                                child: QButton(
                                  label: "Browse",
                                  size: bs.sm,
                                  onPressed: () {
                                    // navigateTo("spa_product_list_view", category: category)
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
