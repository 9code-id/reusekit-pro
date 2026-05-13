import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlDiscount9View extends StatefulWidget {
  @override
  State<GrlDiscount9View> createState() => _GrlDiscount9ViewState();
}

class _GrlDiscount9ViewState extends State<GrlDiscount9View> {
  List<Map<String, dynamic>> bundleDeals = [
    {
      "id": 1,
      "title": "Complete Home Office Setup",
      "description": "Everything you need for a productive workspace",
      "originalPrice": 899.99,
      "bundlePrice": 599.99,
      "savings": 300.0,
      "discount": 33,
      "image": "https://picsum.photos/400/250?random=1&keyword=office",
      "category": "Electronics",
      "rating": 4.7,
      "reviews": 234,
      "items": [
        {
          "name": "Wireless Keyboard & Mouse",
          "price": 159.99,
          "image": "https://picsum.photos/100/100?random=11&keyword=keyboard",
        },
        {
          "name": "27\" Monitor",
          "price": 399.99,
          "image": "https://picsum.photos/100/100?random=12&keyword=monitor",
        },
        {
          "name": "Desk LED Lamp",
          "price": 89.99,
          "image": "https://picsum.photos/100/100?random=13&keyword=lamp",
        },
        {
          "name": "Ergonomic Mouse Pad",
          "price": 29.99,
          "image": "https://picsum.photos/100/100?random=14&keyword=mousepad",
        },
        {
          "name": "Cable Management Kit",
          "price": 19.99,
          "image": "https://picsum.photos/100/100?random=15&keyword=cables",
        },
      ],
      "popular": true,
      "limitedTime": true,
    },
    {
      "id": 2,
      "title": "Gaming Essentials Pack",
      "description": "Level up your gaming experience",
      "originalPrice": 649.99,
      "bundlePrice": 399.99,
      "savings": 250.0,
      "discount": 38,
      "image": "https://picsum.photos/400/250?random=2&keyword=gaming",
      "category": "Gaming",
      "rating": 4.8,
      "reviews": 456,
      "items": [
        {
          "name": "Mechanical Gaming Keyboard",
          "price": 199.99,
          "image": "https://picsum.photos/100/100?random=21&keyword=gamingkeyboard",
        },
        {
          "name": "Gaming Mouse",
          "price": 99.99,
          "image": "https://picsum.photos/100/100?random=22&keyword=gamingmouse",
        },
        {
          "name": "Gaming Headset",
          "price": 149.99,
          "image": "https://picsum.photos/100/100?random=23&keyword=headset",
        },
        {
          "name": "RGB Mouse Pad",
          "price": 59.99,
          "image": "https://picsum.photos/100/100?random=24&keyword=rgbpad",
        },
        {
          "name": "USB Hub",
          "price": 39.99,
          "image": "https://picsum.photos/100/100?random=25&keyword=usbhub",
        },
      ],
      "popular": false,
      "limitedTime": false,
    },
    {
      "id": 3,
      "title": "Smart Home Starter Kit",
      "description": "Transform your home with smart technology",
      "originalPrice": 459.99,
      "bundlePrice": 299.99,
      "savings": 160.0,
      "discount": 35,
      "image": "https://picsum.photos/400/250?random=3&keyword=smarthome",
      "category": "Smart Home",
      "rating": 4.5,
      "reviews": 178,
      "items": [
        {
          "name": "Smart Speaker",
          "price": 129.99,
          "image": "https://picsum.photos/100/100?random=31&keyword=speaker",
        },
        {
          "name": "Smart Light Bulbs (4-pack)",
          "price": 99.99,
          "image": "https://picsum.photos/100/100?random=32&keyword=smartbulb",
        },
        {
          "name": "Smart Plug (2-pack)",
          "price": 39.99,
          "image": "https://picsum.photos/100/100?random=33&keyword=smartplug",
        },
        {
          "name": "Smart Thermostat",
          "price": 149.99,
          "image": "https://picsum.photos/100/100?random=34&keyword=thermostat",
        },
        {
          "name": "Motion Sensor",
          "price": 29.99,
          "image": "https://picsum.photos/100/100?random=35&keyword=sensor",
        },
      ],
      "popular": true,
      "limitedTime": false,
    },
    {
      "id": 4,
      "title": "Fitness Enthusiast Bundle",
      "description": "Everything for your fitness journey",
      "originalPrice": 329.99,
      "bundlePrice": 199.99,
      "savings": 130.0,
      "discount": 39,
      "image": "https://picsum.photos/400/250?random=4&keyword=fitness",
      "category": "Health & Fitness",
      "rating": 4.6,
      "reviews": 312,
      "items": [
        {
          "name": "Fitness Tracker",
          "price": 129.99,
          "image": "https://picsum.photos/100/100?random=41&keyword=fitnesstracker",
        },
        {
          "name": "Wireless Earbuds",
          "price": 79.99,
          "image": "https://picsum.photos/100/100?random=42&keyword=earbuds",
        },
        {
          "name": "Yoga Mat",
          "price": 39.99,
          "image": "https://picsum.photos/100/100?random=43&keyword=yogamat",
        },
        {
          "name": "Resistance Bands Set",
          "price": 29.99,
          "image": "https://picsum.photos/100/100?random=44&keyword=resistancebands",
        },
        {
          "name": "Water Bottle",
          "price": 24.99,
          "image": "https://picsum.photos/100/100?random=45&keyword=waterbottle",
        },
      ],
      "popular": false,
      "limitedTime": true,
    },
  ];

  void _showBundleDetails(Map<String, dynamic> bundle) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.8,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: disabledColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              SizedBox(height: spMd),

              // Bundle title
              Text(
                "${bundle["title"]}",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),

              // Bundle items
              Expanded(
                child: ListView(
                  controller: scrollController,
                  children: [
                    Text(
                      "Bundle includes:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Column(
                      spacing: spSm,
                      children: (bundle["items"] as List).map((item) {
                        return Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: disabledColor.withAlpha(100)),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(radiusXs),
                                child: Image.network(
                                  "${item["image"]}",
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
                                    Text(
                                      "${item["name"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "\$${((item["price"] as double).toDouble()).currency}",
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
                      }).toList(),
                    ),
                    SizedBox(height: spLg),

                    // Price summary
                    Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Individual Total:",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "\$${((bundle["originalPrice"] as double).toDouble()).currency}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Bundle Price:",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "\$${((bundle["bundlePrice"] as double).toDouble()).currency}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "You Save:",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "\$${((bundle["savings"] as double).toDouble()).currency}",
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
                    ),
                    SizedBox(height: spMd),

                    // Add to cart button
                    QButton(
                      label: "Add Bundle to Cart",
                      size: bs.md,
                      onPressed: () {
                        back();
                        ss("Bundle added to cart!");
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bundle Deals"),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    successColor,
                    successColor.withAlpha(180),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.inventory,
                        color: Colors.white,
                        size: 28,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Bundle & Save",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Buy together and save more",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(220),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "Total savings up to \$${((bundleDeals.map((b) => b["savings"] as double).reduce((a, b) => a + b)).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),

            // Stats row
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${bundleDeals.length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Bundles",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
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
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${bundleDeals.where((b) => b["popular"] as bool).length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Popular",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
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
                      color: warningColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${bundleDeals.where((b) => b["limitedTime"] as bool).length}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Limited",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spLg),

            // Bundle deals
            Column(
              spacing: spLg,
              children: bundleDeals.map((bundle) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowMd],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Bundle image with badges
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(radiusLg),
                            ),
                            child: Image.network(
                              "${bundle["image"]}",
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),

                          // Badges
                          Positioned(
                            top: spMd,
                            left: spMd,
                            child: Row(
                              children: [
                                if (bundle["popular"] as bool)
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "POPULAR",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                if (bundle["popular"] as bool && bundle["limitedTime"] as bool)
                                  SizedBox(width: spXs),
                                if (bundle["limitedTime"] as bool)
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: dangerColor,
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "LIMITED TIME",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),

                          // Discount badge
                          Positioned(
                            top: spMd,
                            right: spMd,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: successColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "SAVE ${bundle["discount"]}%",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Bundle content
                      Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title and category
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${bundle["title"]}",
                                    style: TextStyle(
                                      fontSize: fsH5,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: infoColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${bundle["category"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: infoColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),

                            Text(
                              "${bundle["description"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spSm),

                            // Rating
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: warningColor,
                                  size: 18,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "${bundle["rating"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "(${bundle["reviews"]} reviews)",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),

                            // Items preview
                            Text(
                              "Includes ${(bundle["items"] as List).length} items:",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            QHorizontalScroll(
                              children: (bundle["items"] as List).map((item) {
                                return Container(
                                  width: 80,
                                  margin: EdgeInsets.only(right: spSm),
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(radiusXs),
                                        child: Image.network(
                                          "${item["image"]}",
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "${item["name"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledBoldColor,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                            SizedBox(height: spMd),

                            // Price section
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Individual Total:",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      Text(
                                        "\$${((bundle["originalPrice"] as double).toDouble()).currency}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: disabledBoldColor,
                                          decoration: TextDecoration.lineThrough,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Bundle Price:",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "\$${((bundle["bundlePrice"] as double).toDouble()).currency}",
                                        style: TextStyle(
                                          fontSize: fsH5,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "You Save:",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: successColor,
                                        ),
                                      ),
                                      Text(
                                        "\$${((bundle["savings"] as double).toDouble()).currency}",
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
                            ),
                            SizedBox(height: spMd),

                            // Action buttons
                            Row(
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: "View Details",
                                    size: bs.sm,
                                    onPressed: () => _showBundleDetails(bundle),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: QButton(
                                    label: "Add Bundle",
                                    size: bs.sm,
                                    onPressed: () {
                                      ss("Bundle added to cart!");
                                    },
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
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
