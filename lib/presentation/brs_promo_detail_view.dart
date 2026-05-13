import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsPromoDetailView extends StatefulWidget {
  const BrsPromoDetailView({super.key});

  @override
  State<BrsPromoDetailView> createState() => _BrsPromoDetailViewState();
}

class _BrsPromoDetailViewState extends State<BrsPromoDetailView> {
  bool isFavorited = false;
  bool isBookmarked = false;
  
  Map<String, dynamic> promoDetail = {
    "id": 1,
    "title": "Weekend Flash Sale",
    "subtitle": "Premium Grooming at Half Price",
    "description": "Experience our premium grooming services at an unbeatable 50% discount. This exclusive weekend offer includes our signature cuts, professional beard styling, and relaxing hot towel treatments.",
    "category": "Flash Sale",
    "originalPrice": 60,
    "discountedPrice": 30,
    "discountPercent": 50,
    "validFrom": "March 15, 2024",
    "validUntil": "March 17, 2024",
    "timeLeft": "1 day 14 hours left",
    "image": "https://picsum.photos/400/250?random=1&keyword=barbershop",
    "barbershop": {
      "name": "Elite Cuts Barbershop",
      "address": "123 Main Street, Downtown",
      "rating": 4.8,
      "reviews": 156,
      "distance": "0.5 km",
      "image": "https://picsum.photos/100/100?random=2&keyword=barber",
    },
    "services": [
      {"name": "Premium Haircut", "originalPrice": 35, "discountedPrice": 18},
      {"name": "Beard Styling", "originalPrice": 20, "discountedPrice": 10},
      {"name": "Hot Towel Treatment", "originalPrice": 15, "discountedPrice": 8},
    ],
    "claimed": 45,
    "totalLimit": 100,
    "code": "WEEKEND50",
    "terms": [
      "Valid only on weekends (Saturday & Sunday)",
      "Cannot be combined with other offers",
      "Appointment must be booked in advance",
      "Limited to one use per customer",
      "Valid at Elite Cuts Barbershop only",
    ],
    "howToUse": [
      "Book your appointment through the app",
      "Select your preferred services",
      "Apply the promo code at checkout",
      "Show this offer at the barbershop",
    ],
  };

  @override
  Widget build(BuildContext context) {
    double progressValue = (promoDetail["claimed"] as int) / (promoDetail["totalLimit"] as int);
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Offer Details"),
        actions: [
          IconButton(
            icon: Icon(
              isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: isBookmarked ? warningColor : null,
            ),
            onPressed: () {
              isBookmarked = !isBookmarked;
              setState(() {});
              ss(isBookmarked ? "Offer bookmarked" : "Bookmark removed");
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              ss("Sharing offer details");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Image & Discount Badge
            Stack(
              children: [
                Image.network(
                  "${promoDetail["image"]}",
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: spMd,
                  left: spMd,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: dangerColor,
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Text(
                      "${promoDetail["discountPercent"]}% OFF",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: spMd,
                  right: spMd,
                  child: GestureDetector(
                    onTap: () {
                      isFavorited = !isFavorited;
                      setState(() {});
                      ss(isFavorited ? "Added to favorites" : "Removed from favorites");
                    },
                    child: Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(200),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Icon(
                        isFavorited ? Icons.favorite : Icons.favorite_border,
                        color: isFavorited ? dangerColor : Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            // Offer Details
            Padding(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title & Category
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${promoDetail["title"]}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${promoDetail["subtitle"]}",
                              style: TextStyle(
                                fontSize: 16,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${promoDetail["category"]}",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Price Information
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: successColor.withAlpha(100)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Special Price",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "\$${promoDetail["originalPrice"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: disabledBoldColor,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "\$${promoDetail["discountedPrice"]}",
                                    style: TextStyle(
                                      fontSize: fsH4,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "Save \$${(promoDetail["originalPrice"] as int) - (promoDetail["discountedPrice"] as int)}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.savings,
                          color: successColor,
                          size: 32,
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Time Remaining
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: warningColor.withAlpha(100)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: warningColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Limited Time Offer",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: warningColor,
                                ),
                              ),
                              Text(
                                "${promoDetail["timeLeft"]}",
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
                  
                  SizedBox(height: spMd),
                  
                  // Description
                  Text(
                    "About This Offer",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${promoDetail["description"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.5,
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Barbershop Info
                  Text(
                    "Barbershop",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: disabledOutlineBorderColor),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusSm),
                          child: Image.network(
                            "${promoDetail["barbershop"]["image"]}",
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
                                "${promoDetail["barbershop"]["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${promoDetail["barbershop"]["address"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.star, color: warningColor, size: 14),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${promoDetail["barbershop"]["rating"]} (${promoDetail["barbershop"]["reviews"]})",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "${promoDetail["barbershop"]["distance"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        QButton(
                          icon: Icons.directions,
                          size: bs.sm,
                          onPressed: () {
                            si("Getting directions");
                          },
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Services Included
                  Text(
                    "Services Included",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ...(promoDetail["services"] as List).map((service) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: disabledOutlineBorderColor),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: successColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "${service["name"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "\$${service["originalPrice"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              Text(
                                "\$${service["discountedPrice"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  
                  SizedBox(height: spMd),
                  
                  // Offer Usage Progress
                  Text(
                    "Offer Availability",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: infoColor.withAlpha(100)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Claimed: ${promoDetail["claimed"]}/${promoDetail["totalLimit"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${((1 - progressValue) * 100).toInt()}% left",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: progressValue > 0.8 ? dangerColor : successColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        LinearProgressIndicator(
                          value: progressValue,
                          backgroundColor: disabledColor,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            progressValue > 0.8 ? dangerColor : primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Promo Code
                  Text(
                    "Promo Code",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: primaryColor, style: BorderStyle.solid, width: 2),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.confirmation_number,
                          color: primaryColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${promoDetail["code"]}",
                                style: TextStyle(
                                  fontSize: fsH5,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                  letterSpacing: 2,
                                ),
                              ),
                              Text(
                                "Tap to copy code",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            ss("Code ${promoDetail["code"]} copied to clipboard");
                          },
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.copy,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // How to Use
                  Text(
                    "How to Use",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ...(promoDetail["howToUse"] as List).asMap().entries.map((entry) {
                    int index = entry.key;
                    String step = entry.value;
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Center(
                              child: Text(
                                "${index + 1}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              step,
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  
                  SizedBox(height: spMd),
                  
                  // Terms & Conditions
                  Text(
                    "Terms & Conditions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ...(promoDetail["terms"] as List).map((term) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spXs),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 6),
                            width: 4,
                            height: 4,
                            decoration: BoxDecoration(
                              color: disabledBoldColor,
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "$term",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [shadowMd],
        ),
        child: Row(
          children: [
            Expanded(
              child: QButton(
                label: "Share Offer",
                size: bs.md,
                onPressed: () {
                  ss("Sharing offer with friends");
                },
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              flex: 2,
              child: QButton(
                label: "Book Appointment",
                size: bs.md,
                onPressed: () {
                  si("Booking appointment with offer");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
