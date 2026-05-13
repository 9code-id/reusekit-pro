import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaRestaurantInfoView extends StatefulWidget {
  const FdaRestaurantInfoView({super.key});

  @override
  State<FdaRestaurantInfoView> createState() => _FdaRestaurantInfoViewState();
}

class _FdaRestaurantInfoViewState extends State<FdaRestaurantInfoView> {
  bool isFavorite = false;
  int currentImageIndex = 0;

  Map<String, dynamic> restaurantData = {    "id": 1,
    "name": "Gourmet Bistro",
    "category": "Fine Dining",
    "rating": 4.8,
    "totalReviews": 2847,
    "deliveryTime": "35-45 min",
    "deliveryFee": 4.99,
    "minimumOrder": 35.00,
    "isOpen": true,
    "images": [
      "https://picsum.photos/400/300?random=1&keyword=restaurant",
      "https://picsum.photos/400/300?random=2&keyword=fine+dining",
      "https://picsum.photos/400/300?random=3&keyword=kitchen",
      "https://picsum.photos/400/300?random=4&keyword=dining+room",
      "https://picsum.photos/400/300?random=5&keyword=food+plating"
    ],
    "address": "456 Culinary Avenue, Uptown District, City 12345",
    "phone": "+1 (555) 987-6543",
    "email": "contact@gourmetbistro.com",
    "website": "www.gourmetbistro.com",
    "description": "Experience culinary excellence at Gourmet Bistro. Our award-winning chefs create innovative dishes using locally sourced, premium ingredients. Perfect for special occasions and fine dining experiences.",
    "cuisine": "Contemporary American",
    "priceRange": "\$\$\$\$",
    "established": "2011",    "tags": ["Fine Dining", "Date Night", "Business Dining", "Special Occasions", "Wine Pairing", "Chef's Specials"],
    "features": [
      {"icon": Icons.local_parking, "title": "Valet Parking", "subtitle": "Complimentary valet service"},
      {"icon": Icons.wine_bar, "title": "Wine Cellar", "subtitle": "Extensive wine collection"},
      {"icon": Icons.restaurant_menu, "title": "Private Dining", "subtitle": "Exclusive dining rooms"},
      {"icon": Icons.weekend, "title": "Chef's Table", "subtitle": "Interactive dining experience"},
      {"icon": Icons.outdoor_grill, "title": "Outdoor Terrace", "subtitle": "Scenic dining area"},
      {"icon": Icons.wheelchair_pickup, "title": "Accessible", "subtitle": "Fully wheelchair accessible"}
    ],
    "hours": {
      "Monday": "5:00 PM - 10:00 PM",
      "Tuesday": "5:00 PM - 10:00 PM", 
      "Wednesday": "5:00 PM - 10:00 PM",
      "Thursday": "5:00 PM - 10:00 PM",
      "Friday": "5:00 PM - 11:00 PM",
      "Saturday": "5:00 PM - 11:00 PM",
      "Sunday": "5:00 PM - 9:00 PM"
    },
    "stats": {
      "totalOrders": 28750,
      "happyCustomers": 25680,
      "yearsServing": 12,
      "menuItems": 120,
      "chefRating": 4.9,
      "avgMealPrice": 85.50
    },
    "paymentMethods": ["Cash", "Credit Card", "Debit Card", "Apple Pay", "Google Pay"],
    "certifications": ["Michelin Recommended", "Farm-to-Table Certified", "Organic Certified"],
    "awards": ["Best Restaurant 2023", "Chef's Choice Award", "Excellence in Service"],
    "socialMedia": {
      "instagram": "@gourmetbistro",
      "facebook": "GourmetBistroOfficial",
      "twitter": "@GourmetBistro"
    }
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image Gallery with App Bar
            Stack(
              children: [                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("${(restaurantData["images"] as List)[0]}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                
                // App Bar Overlay
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leading: Container(
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(100),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => back(),
                      ),
                    ),
                    actions: [
                      Container(
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(100),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? dangerColor : Colors.white,
                          ),
                          onPressed: () {
                            isFavorite = !isFavorite;
                            setState(() {});
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(100),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: Icon(Icons.share, color: Colors.white),
                          onPressed: () {
                            // Share restaurant
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // Image Counter
                Positioned(
                  bottom: spMd,
                  right: spMd,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spSm,
                      vertical: spXs,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(150),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),                    child: Text(
                      "1/${(restaurantData["images"] as List).length}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                // View All Photos Button
                Positioned(
                  bottom: spMd,
                  left: spMd,
                  child: QButton(
                    label: "View All Photos",
                    icon: Icons.photo_library,
                    size: bs.sm,
                    onPressed: () {
                      // Navigate to gallery view
                    },
                  ),
                ),
              ],
            ),

            Padding(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                children: [
                  // Basic Info
                  Container(
                    padding: EdgeInsets.all(spMd),
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
                            Expanded(
                              child: Text(
                                "${restaurantData["name"]}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "Open",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: successColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            Icon(Icons.restaurant, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "${restaurantData["cuisine"]} Cuisine",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            Icon(Icons.star, size: 16, color: warningColor),
                            SizedBox(width: spXs),
                            Text(
                              "${restaurantData["rating"]} (${restaurantData["totalReviews"]} reviews)",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),

                        Divider(),

                        // Delivery Info
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Delivery Time",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${restaurantData["deliveryTime"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Delivery Fee",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "\$${(restaurantData["deliveryFee"] as double).toStringAsFixed(2)}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Minimum Order",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "\$${(restaurantData["minimumOrder"] as double).toStringAsFixed(2)}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),                  ),

                  // Restaurant Stats
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Text(
                          "Restaurant Statistics",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(10),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      "${((restaurantData["stats"]["totalOrders"] as int) / 1000).toInt()}K+",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "Total Orders",
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
                                  color: successColor.withAlpha(10),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      "${((restaurantData["stats"]["happyCustomers"] as int) / 1000).toInt()}K+",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: successColor,
                                      ),
                                    ),
                                    Text(
                                      "Happy Customers",
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
                                  color: warningColor.withAlpha(10),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      "${restaurantData["stats"]["yearsServing"]}+",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: warningColor,
                                      ),
                                    ),
                                    Text(
                                      "Years Serving",
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
                      ],
                    ),
                  ),

                  // Description
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Text(
                          "About ${restaurantData["name"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${restaurantData["description"]}",
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Operating Hours
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Text(
                          "Operating Hours",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Column(
                          spacing: spXs,
                          children: (restaurantData["hours"] as Map<String, dynamic>).entries.map((entry) => Row(
                            children: [
                              Container(
                                width: 80,
                                child: Text(
                                  entry.key,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Text(
                                "${entry.value}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          )).toList(),
                        ),
                      ],
                    ),
                  ),

                  // Tags
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Text(
                          "Specialties",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Wrap(
                          spacing: spXs,
                          runSpacing: spXs,
                          children: (restaurantData["tags"] as List).map((tag) => Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: primaryColor.withAlpha(50),
                              ),
                            ),
                            child: Text(
                              "$tag",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )).toList(),
                        ),
                      ],
                    ),
                  ),

                  // Features
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Text(
                          "Features & Services",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Column(
                          children: (restaurantData["features"] as List).map((feature) => Padding(
                            padding: EdgeInsets.only(bottom: spSm),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Icon(
                                    feature["icon"],
                                    size: 20,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${feature["title"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "${feature["subtitle"]}",
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
                          )).toList(),
                        ),
                      ],
                    ),
                  ),

                  // Contact Info
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Text(
                          "Contact Information",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        
                        // Address
                        Row(
                          children: [
                            Icon(Icons.location_on, size: 20, color: primaryColor),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Address",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${restaurantData["address"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            QButton(
                              icon: Icons.directions,
                              size: bs.sm,
                              onPressed: () {
                                // Open directions
                              },
                            ),
                          ],
                        ),

                        Divider(),

                        // Phone
                        Row(
                          children: [
                            Icon(Icons.phone, size: 20, color: primaryColor),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Phone",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${restaurantData["phone"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            QButton(
                              icon: Icons.call,
                              size: bs.sm,
                              onPressed: () {
                                // Make phone call
                              },
                            ),
                          ],
                        ),

                        Divider(),

                        // Website
                        Row(
                          children: [
                            Icon(Icons.language, size: 20, color: primaryColor),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Website",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${restaurantData["website"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            QButton(
                              icon: Icons.open_in_new,
                              size: bs.sm,
                              onPressed: () {
                                // Open website
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Awards & Certifications
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Text(
                          "Awards & Certifications",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        
                        // Awards
                        ...((restaurantData["awards"] as List).map((award) => Row(
                          children: [
                            Icon(Icons.emoji_events, size: 16, color: warningColor),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "$award",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ))),

                        Divider(),

                        // Certifications
                        ...((restaurantData["certifications"] as List).map((cert) => Row(
                          children: [
                            Icon(Icons.verified, size: 16, color: successColor),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "$cert",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ))),
                      ],
                    ),
                  ),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "View Menu",
                          size: bs.md,
                          onPressed: () {
                            // Navigate to menu
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Order Now",
                          size: bs.md,
                          onPressed: () {
                            // Start ordering
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
      ),
    );
  }
}
