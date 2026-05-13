import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsServiceDetailView extends StatefulWidget {
  const BrsServiceDetailView({super.key});

  @override
  State<BrsServiceDetailView> createState() => _BrsServiceDetailViewState();
}

class _BrsServiceDetailViewState extends State<BrsServiceDetailView> {
  bool isFavorite = false;
  int selectedAddOn = -1;
  
  List<Map<String, dynamic>> serviceImages = [
    {
      "url": "https://picsum.photos/400/300?random=1&keyword=haircut",
    },
    {
      "url": "https://picsum.photos/400/300?random=2&keyword=barber",
    },
    {
      "url": "https://picsum.photos/400/300?random=3&keyword=salon",
    },
  ];

  List<Map<String, dynamic>> addOns = [
    {
      "name": "Hair Wash",
      "price": 8.0,
      "duration": 10,
      "description": "Premium shampoo and conditioning",
    },
    {
      "name": "Beard Trim",
      "price": 10.0,
      "duration": 15,
      "description": "Precise beard shaping and styling",
    },
    {
      "name": "Hot Towel",
      "price": 5.0,
      "duration": 5,
      "description": "Relaxing hot towel treatment",
    },
  ];

  List<Map<String, dynamic>> relatedServices = [
    {
      "name": "Fade Cut",
      "price": 30.0,
      "duration": 45,
      "image": "https://picsum.photos/80/80?random=10&keyword=fade",
      "rating": 4.9,
    },
    {
      "name": "Beard Styling",
      "price": 20.0,
      "duration": 25,
      "image": "https://picsum.photos/80/80?random=11&keyword=beard",
      "rating": 4.7,
    },
    {
      "name": "Hair Treatment",
      "price": 35.0,
      "duration": 40,
      "image": "https://picsum.photos/80/80?random=12&keyword=treatment",
      "rating": 4.8,
    },
  ];

  List<Map<String, dynamic>> reviews = [
    {
      "name": "John Smith",
      "rating": 5,
      "date": "2024-06-10",
      "comment": "Amazing haircut! Very professional and attention to detail is excellent.",
      "avatar": "https://picsum.photos/40/40?random=20&keyword=man",
    },
    {
      "name": "Michael Brown",
      "rating": 4,
      "date": "2024-06-08",
      "comment": "Great service, will definitely come back. Highly recommended!",
      "avatar": "https://picsum.photos/40/40?random=21&keyword=person",
    },
    {
      "name": "David Wilson",
      "rating": 5,
      "date": "2024-06-05",
      "comment": "Best haircut I've had in years. The barber really knows what he's doing.",
      "avatar": "https://picsum.photos/40/40?random=22&keyword=male",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Classic Haircut"),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? dangerColor : null,
            ),
            onPressed: () {
              isFavorite = !isFavorite;
              setState(() {});
              ss(isFavorite ? "Added to favorites" : "Removed from favorites");
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              ss("Share service details");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Service Images Gallery
            Container(
              height: 250,
              child: QHorizontalScroll(
                children: List.generate(serviceImages.length, (index) {
                  final image = serviceImages[index];
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                      "${image["url"]}",
                      fit: BoxFit.cover,
                    ),
                  );
                }),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Service Basic Info
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Classic Haircut",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "Traditional scissors cut with precision styling",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
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
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: spMd),

                  // Price and Duration
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.attach_money, color: primaryColor, size: 20),
                            Text(
                              "\$25.00",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: spSm),
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.access_time, color: primaryColor, size: 20),
                            SizedBox(width: spXs),
                            Text(
                              "30 min",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: spMd),

                  // Rating Section
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.star, color: warningColor, size: 24),
                        SizedBox(width: spSm),
                        Text(
                          "4.8",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Based on 156 reviews",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            ss("View all reviews");
                          },
                          child: Text(
                            "View All",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: spMd),

                  // Description
                  Text(
                    "About This Service",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Our classic haircut service includes a consultation to understand your style preferences, precise cutting with professional scissors, and styling to achieve your desired look. Perfect for both traditional and modern styles.",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      height: 1.5,
                    ),
                  ),

                  SizedBox(height: spMd),

                  // What's Included
                  Text(
                    "What's Included",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Column(
                    children: [
                      _buildIncludedItem("Consultation & style advice"),
                      _buildIncludedItem("Precision scissor cutting"),
                      _buildIncludedItem("Basic styling"),
                      _buildIncludedItem("Final touch-ups"),
                    ],
                  ),

                  SizedBox(height: spMd),

                  // Add-Ons Section
                  Text(
                    "Add-Ons",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Column(
                    children: List.generate(addOns.length, (index) {
                      final addOn = addOns[index];
                      bool isSelected = selectedAddOn == index;
                      
                      return GestureDetector(
                        onTap: () {
                          selectedAddOn = isSelected ? -1 : index;
                          setState(() {});
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: spSm),
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor.withAlpha(26) : Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: isSelected ? primaryColor : disabledOutlineBorderColor,
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: isSelected ? primaryColor : Colors.transparent,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                  border: Border.all(
                                    color: isSelected ? primaryColor : disabledBoldColor,
                                    width: 2,
                                  ),
                                ),
                                child: isSelected
                                    ? Icon(
                                        Icons.check,
                                        size: 14,
                                        color: Colors.white,
                                      )
                                    : null,
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${addOn["name"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "${addOn["description"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                "+\$${(addOn["price"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),

                  SizedBox(height: spMd),

                  // Related Services
                  Text(
                    "Related Services",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  QHorizontalScroll(
                    children: List.generate(relatedServices.length, (index) {
                      final service = relatedServices[index];
                      return Container(
                        width: 160,
                        margin: EdgeInsets.only(right: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(radiusSm),
                                child: Image.network(
                                  "${service["image"]}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${service["name"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(Icons.star, color: warningColor, size: 14),
                                SizedBox(width: spXs),
                                Text(
                                  "${service["rating"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "\$${(service["price"] as double).currency}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),

                  SizedBox(height: spMd),

                  // Recent Reviews
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Recent Reviews",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          ss("View all reviews");
                        },
                        child: Text(
                          "View All",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Column(
                    children: List.generate(2, (index) {
                      final review = reviews[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(radiusLg),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(radiusLg),
                                    child: Image.network(
                                      "${review["avatar"]}",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${review["name"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Row(
                                        children: [
                                          ...List.generate(5, (starIndex) {
                                            return Icon(
                                              Icons.star,
                                              size: 14,
                                              color: starIndex < (review["rating"] as int)
                                                  ? warningColor
                                                  : disabledColor,
                                            );
                                          }),
                                          SizedBox(width: spSm),
                                          Text(
                                            "${review["date"]}",
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
                              ],
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${review["comment"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),

                  SizedBox(height: spMd),

                  // Book Now Button
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Book This Service",
                      size: bs.md,
                      onPressed: () {
                        ss("Booking Classic Haircut service");
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
  }

  Widget _buildIncludedItem(String text) {
    return Container(
      margin: EdgeInsets.only(bottom: spXs),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            color: successColor,
            size: 16,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
