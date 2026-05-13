import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlRating10View extends StatefulWidget {
  @override
  State<GrlRating10View> createState() => _GrlRating10ViewState();
}

class _GrlRating10ViewState extends State<GrlRating10View> {
  String selectedCategory = 'all';
  String selectedRating = 'all';
  String searchQuery = '';
  bool showFilters = false;
  
  List<Map<String, dynamic>> businesses = [
    {
      "id": 1,
      "name": "Artisan Coffee House",
      "category": "restaurant",
      "image": "https://picsum.photos/300/200?random=1&keyword=coffee",
      "rating": 4.8,
      "totalReviews": 1247,
      "location": "Downtown Manhattan",
      "verified": true,
      "tags": ["Coffee", "Breakfast", "WiFi"],
      "priceRange": "\$\$",
      "openNow": true,
      "distance": 0.3,
      "topReview": {
        "author": "Sarah M.",
        "rating": 5.0,
        "text": "Amazing coffee and cozy atmosphere. Perfect for work meetings!",
        "date": "2 days ago"
      }
    },
    {
      "id": 2,
      "name": "TechFix Solutions",
      "category": "service",
      "image": "https://picsum.photos/300/200?random=2&keyword=technology",
      "rating": 4.6,
      "totalReviews": 832,
      "location": "Silicon Valley",
      "verified": true,
      "tags": ["Repair", "Electronics", "Fast Service"],
      "priceRange": "\$\$\$",
      "openNow": false,
      "distance": 1.2,
      "topReview": {
        "author": "Mike Johnson",
        "rating": 5.0,
        "text": "Fixed my laptop in 30 minutes. Excellent service and fair prices.",
        "date": "1 week ago"
      }
    },
    {
      "id": 3,
      "name": "Bella Vista Hotel",
      "category": "hotel",
      "image": "https://picsum.photos/300/200?random=3&keyword=hotel",
      "rating": 4.9,
      "totalReviews": 2156,
      "location": "Miami Beach",
      "verified": true,
      "tags": ["Luxury", "Ocean View", "Spa"],
      "priceRange": "\$\$\$\$",
      "openNow": true,
      "distance": 2.8,
      "topReview": {
        "author": "Jennifer L.",
        "rating": 5.0,
        "text": "Stunning ocean views and impeccable service. Worth every penny!",
        "date": "3 days ago"
      }
    },
    {
      "id": 4,
      "name": "Metro Fitness Center",
      "category": "fitness",
      "image": "https://picsum.photos/300/200?random=4&keyword=gym",
      "rating": 4.4,
      "totalReviews": 645,
      "location": "Midtown West",
      "verified": false,
      "tags": ["24/7", "Personal Training", "Modern Equipment"],
      "priceRange": "\$\$",
      "openNow": true,
      "distance": 0.7,
      "topReview": {
        "author": "David K.",
        "rating": 4.0,
        "text": "Great equipment and convenient hours. Could use better AC.",
        "date": "5 days ago"
      }
    },
    {
      "id": 5,
      "name": "Garden Fresh Market",
      "category": "shopping",
      "image": "https://picsum.photos/300/200?random=5&keyword=market",
      "rating": 4.7,
      "totalReviews": 1893,
      "location": "Brooklyn Heights",
      "verified": true,
      "tags": ["Organic", "Local Produce", "Fresh"],
      "priceRange": "\$\$",
      "openNow": true,
      "distance": 1.5,
      "topReview": {
        "author": "Emily R.",
        "rating": 5.0,
        "text": "Best organic produce in the city. Friendly staff and fair prices.",
        "date": "1 day ago"
      }
    }
  ];

  List<Map<String, dynamic>> get filteredBusinesses {
    return businesses.where((business) {
      bool matchesCategory = selectedCategory == 'all' || business["category"] == selectedCategory;
      bool matchesRating = selectedRating == 'all' || _matchesRatingFilter(business["rating"]);
      bool matchesSearch = searchQuery.isEmpty || 
          (business["name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
          (business["location"] as String).toLowerCase().contains(searchQuery.toLowerCase());
      
      return matchesCategory && matchesRating && matchesSearch;
    }).toList();
  }

  bool _matchesRatingFilter(double rating) {
    switch (selectedRating) {
      case '5':
        return rating >= 4.8;
      case '4':
        return rating >= 4.0 && rating < 4.8;
      case '3':
        return rating >= 3.0 && rating < 4.0;
      case '2':
        return rating >= 2.0 && rating < 3.0;
      case '1':
        return rating < 2.0;
      default:
        return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Business Directory"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              showFilters = !showFilters;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {
              // navigateTo(MapView());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Icon(
                            Icons.search,
                            color: disabledBoldColor,
                            size: 20,
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            onChanged: (value) {
                              searchQuery = value;
                              setState(() {});
                            },
                            decoration: InputDecoration(
                              hintText: "Search businesses, locations...",
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Icon(
                    Icons.tune,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),

          // Filter Options
          if (showFilters)
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Category",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  QHorizontalScroll(
                    children: [
                      'all', 'restaurant', 'service', 'hotel', 'fitness', 'shopping'
                    ].map((category) => GestureDetector(
                      onTap: () {
                        selectedCategory = category;
                        setState(() {});
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: spSm),
                        padding: EdgeInsets.symmetric(
                          horizontal: spMd,
                          vertical: spSm,
                        ),
                        decoration: BoxDecoration(
                          color: selectedCategory == category ? primaryColor : Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(
                            color: primaryColor.withAlpha(50),
                          ),
                        ),
                        child: Text(
                          category == 'all' ? 'All' : category.toUpperCase(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: selectedCategory == category ? Colors.white : primaryColor,
                          ),
                        ),
                      ),
                    )).toList(),
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Rating",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      'all', '5', '4', '3', '2', '1'
                    ].map((rating) => Expanded(
                      child: GestureDetector(
                        onTap: () {
                          selectedRating = rating;
                          setState(() {});
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: spXs),
                          padding: EdgeInsets.symmetric(vertical: spSm),
                          decoration: BoxDecoration(
                            color: selectedRating == rating ? primaryColor : Colors.white,
                            borderRadius: BorderRadius.circular(radiusLg),
                            border: Border.all(
                              color: primaryColor.withAlpha(50),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (rating != 'all')
                                Icon(
                                  Icons.star,
                                  size: 12,
                                  color: selectedRating == rating ? Colors.white : primaryColor,
                                ),
                              Text(
                                rating == 'all' ? 'All' : rating + '+',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: selectedRating == rating ? Colors.white : primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )).toList(),
                  ),
                ],
              ),
            ),

          // Results Summary
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Text(
                  "${filteredBusinesses.length} businesses found",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: disabledBoldColor,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    // Sort options
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.sort,
                        size: 16,
                        color: primaryColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Sort by Rating",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Business List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              itemCount: filteredBusinesses.length,
              itemBuilder: (context, index) {
                final business = filteredBusinesses[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowMd],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Business Image
                      Stack(
                        children: [
                          Container(
                            height: 180,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(radiusLg),
                                topRight: Radius.circular(radiusLg),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(radiusLg),
                                topRight: Radius.circular(radiusLg),
                              ),
                              child: Image.network(
                                "${business["image"]}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(150),
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${business["rating"]}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (business["verified"] as bool)
                            Positioned(
                              top: spSm,
                              left: spSm,
                              child: Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: successColor,
                                  borderRadius: BorderRadius.circular(radiusLg),
                                ),
                                child: Icon(
                                  Icons.verified,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          Positioned(
                            bottom: spSm,
                            right: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: business["openNow"] as bool ? successColor : dangerColor,
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Text(
                                business["openNow"] as bool ? "Open Now" : "Closed",
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

                      // Business Info
                      Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${business["name"]}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  "${business["priceRange"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 14,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${business["location"]} • ${(business["distance"] as double).toStringAsFixed(1)} km",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            
                            // Rating Info
                            Row(
                              children: [
                                Row(
                                  children: List.generate(5, (i) => Icon(
                                    i < (business["rating"] as double).floor() 
                                        ? Icons.star 
                                        : Icons.star_border,
                                    size: 16,
                                    color: Colors.amber,
                                  )),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${business["rating"]} (${business["totalReviews"]} reviews)",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spMd),
                            
                            // Tags
                            Wrap(
                              spacing: spXs,
                              runSpacing: spXs,
                              children: (business["tags"] as List).map((tag) => Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "$tag",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              )).toList(),
                            ),
                            SizedBox(height: spMd),
                            
                            // Top Review
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Top Review",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Spacer(),
                                      Row(
                                        children: List.generate(5, (i) => Icon(
                                          i < ((business["topReview"] as Map)["rating"] as double).floor() 
                                              ? Icons.star 
                                              : Icons.star_border,
                                          size: 12,
                                          color: Colors.amber,
                                        )),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${(business["topReview"] as Map)["text"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Text(
                                        "— ${(business["topReview"] as Map)["author"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "${(business["topReview"] as Map)["date"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: spMd),
                            
                            // Action Buttons
                            Row(
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: "View Details",
                                    size: bs.sm,
                                    onPressed: () {
                                      // navigateTo(BusinessDetailView(business: business));
                                    },
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Container(
                                  padding: EdgeInsets.all(spSm),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: primaryColor.withAlpha(50)),
                                    borderRadius: BorderRadius.circular(radiusLg),
                                  ),
                                  child: Icon(
                                    Icons.favorite_border,
                                    color: primaryColor,
                                    size: 18,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Container(
                                  padding: EdgeInsets.all(spSm),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: primaryColor.withAlpha(50)),
                                    borderRadius: BorderRadius.circular(radiusLg),
                                  ),
                                  child: Icon(
                                    Icons.share,
                                    color: primaryColor,
                                    size: 18,
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
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // navigateTo(AddBusinessView());
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add_business,
          color: Colors.white,
        ),
      ),
    );
  }
}
