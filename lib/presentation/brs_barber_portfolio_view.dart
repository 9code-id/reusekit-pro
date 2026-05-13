import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsBarberPortfolioView extends StatefulWidget {
  const BrsBarberPortfolioView({super.key});

  @override
  State<BrsBarberPortfolioView> createState() => _BrsBarberPortfolioViewState();
}

class _BrsBarberPortfolioViewState extends State<BrsBarberPortfolioView> {
  List<Map<String, dynamic>> portfolioItems = [
    {
      "id": 1,
      "image": "https://picsum.photos/300/400?random=1&keyword=haircut",
      "title": "Classic Gentleman Cut",
      "description": "Traditional scissor cut with refined styling",
      "category": "Men's Cut",
      "duration": "45 min",
      "price": 35.0,
      "likes": 127,
      "isLiked": false,
      "date": "2024-03-15",
    },
    {
      "id": 2,
      "image": "https://picsum.photos/300/400?random=2&keyword=beard",
      "title": "Beard Sculpting",
      "description": "Precision beard trimming and shaping",
      "category": "Beard Grooming",
      "duration": "30 min",
      "price": 25.0,
      "likes": 98,
      "isLiked": true,
      "date": "2024-03-12",
    },
    {
      "id": 3,
      "image": "https://picsum.photos/300/400?random=3&keyword=fade",
      "title": "Modern Fade",
      "description": "Contemporary fade with textured top",
      "category": "Trendy Cut",
      "duration": "50 min",
      "price": 40.0,
      "likes": 156,
      "isLiked": false,
      "date": "2024-03-10",
    },
    {
      "id": 4,
      "image": "https://picsum.photos/300/400?random=4&keyword=style",
      "title": "Wedding Style",
      "description": "Elegant formal styling for special occasions",
      "category": "Special Event",
      "duration": "60 min",
      "price": 55.0,
      "likes": 89,
      "isLiked": true,
      "date": "2024-03-08",
    },
    {
      "id": 5,
      "image": "https://picsum.photos/300/400?random=5&keyword=buzz",
      "title": "Military Buzz Cut",
      "description": "Clean, professional military-style cut",
      "category": "Classic Cut",
      "duration": "20 min",
      "price": 20.0,
      "likes": 73,
      "isLiked": false,
      "date": "2024-03-05",
    },
    {
      "id": 6,
      "image": "https://picsum.photos/300/400?random=6&keyword=mustache",
      "title": "Mustache Styling",
      "description": "Expert mustache trimming and waxing",
      "category": "Facial Hair",
      "duration": "25 min",
      "price": 22.0,
      "likes": 64,
      "isLiked": false,
      "date": "2024-03-03",
    },
  ];

  List<String> categories = ["All", "Men's Cut", "Beard Grooming", "Trendy Cut", "Special Event", "Classic Cut", "Facial Hair"];
  String selectedCategory = "All";
  
  List<Map<String, dynamic>> get filteredPortfolio {
    if (selectedCategory == "All") {
      return portfolioItems;
    }
    return portfolioItems.where((item) => item["category"] == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Portfolio"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              // Share portfolio
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Barber Info Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusLg),
                      image: DecorationImage(
                        image: NetworkImage("https://picsum.photos/160/160?random=10&keyword=barber"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Marcus Thompson",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Master Barber • 8 Years Experience",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Icon(Icons.star, color: warningColor, size: 16),
                            SizedBox(width: spXxs),
                            Text(
                              "4.9",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "250+ Works",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
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

            SizedBox(height: spLg),

            // Category Filter
            Text(
              "Categories",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            QHorizontalScroll(
              children: List.generate(categories.length, (index) {
                final category = categories[index];
                final isSelected = selectedCategory == category;
                return GestureDetector(
                  onTap: () {
                    selectedCategory = category;
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: spSm),
                    padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.grey[100],
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                      ),
                    ),
                    child: Text(
                      category,
                      style: TextStyle(
                        color: isSelected ? Colors.white : disabledBoldColor,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              }),
            ),

            SizedBox(height: spLg),

            // Portfolio Grid
            Text(
              "Portfolio (${filteredPortfolio.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: filteredPortfolio.map((item) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image with overlay
                      Stack(
                        children: [
                          Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(radiusMd),
                                topRight: Radius.circular(radiusMd),
                              ),
                              image: DecorationImage(
                                image: NetworkImage("${item["image"]}"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: GestureDetector(
                              onTap: () {
                                item["isLiked"] = !(item["isLiked"] as bool);
                                if (item["isLiked"] as bool) {
                                  item["likes"] = (item["likes"] as int) + 1;
                                } else {
                                  item["likes"] = (item["likes"] as int) - 1;
                                }
                                setState(() {});
                              },
                              child: Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: Colors.white.withAlpha(200),
                                  borderRadius: BorderRadius.circular(radiusLg),
                                ),
                                child: Icon(
                                  (item["isLiked"] as bool) ? Icons.favorite : Icons.favorite_border,
                                  color: (item["isLiked"] as bool) ? dangerColor : disabledBoldColor,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: spSm,
                            left: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${item["category"]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Content
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${item["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${item["description"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: spSm),

                            // Price and Duration
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: successColor.withAlpha(30),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "\$${(item["price"] as double).toStringAsFixed(0)}",
                                    style: TextStyle(
                                      color: successColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Icon(Icons.access_time, size: 14, color: disabledBoldColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${item["duration"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),

                            // Stats
                            Row(
                              children: [
                                Icon(Icons.favorite, size: 14, color: dangerColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${item["likes"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Icon(Icons.calendar_today, size: 14, color: disabledBoldColor),
                                SizedBox(width: spXs),
                                Text(
                                  "${item["date"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
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

            SizedBox(height: spLg),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Book Service",
                    size: bs.md,
                    onPressed: () {
                      // Navigate to booking
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.message,
                  size: bs.md,
                  onPressed: () {
                    // Send message
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
