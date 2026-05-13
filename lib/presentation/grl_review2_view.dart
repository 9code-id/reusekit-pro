import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlReview2View extends StatefulWidget {
  @override
  State<GrlReview2View> createState() => _GrlReview2ViewState();
}

class _GrlReview2ViewState extends State<GrlReview2View> {
  String selectedCategory = "all";
  String sortBy = "newest";
  
  List<Map<String, dynamic>> reviews = [
    {
      "id": 1,
      "user": "Sarah Johnson",
      "avatar": "https://picsum.photos/40/40?random=1&keyword=woman",
      "rating": 5,
      "title": "Outstanding service quality!",
      "content": "I've been using this service for over a year now and the quality has been consistently excellent. The staff is professional, responsive, and always goes above and beyond to ensure customer satisfaction.",
      "date": DateTime.now().subtract(Duration(hours: 2)),
      "category": "service",
      "verified": true,
      "helpful": 24,
      "photos": [
        "https://picsum.photos/100/100?random=10&keyword=product",
        "https://picsum.photos/100/100?random=11&keyword=quality",
      ],
    },
    {
      "id": 2,
      "user": "Mike Chen",
      "avatar": "https://picsum.photos/40/40?random=2&keyword=man",
      "rating": 4,
      "title": "Great value for money",
      "content": "Good product overall. The quality is solid and the price point is very competitive. Delivery was fast and packaging was secure. Would definitely recommend to others.",
      "date": DateTime.now().subtract(Duration(days: 1)),
      "category": "product",
      "verified": true,
      "helpful": 18,
      "photos": [],
    },
    {
      "id": 3,
      "user": "Emily Rodriguez",
      "avatar": "https://picsum.photos/40/40?random=3&keyword=woman",
      "rating": 3,
      "title": "Average experience",
      "content": "The service was okay but nothing special. There's room for improvement in communication and response time. Product quality is decent but could be better for the price.",
      "date": DateTime.now().subtract(Duration(days: 3)),
      "category": "service",
      "verified": false,
      "helpful": 7,
      "photos": [],
    },
    {
      "id": 4,
      "user": "David Kim",
      "avatar": "https://picsum.photos/40/40?random=4&keyword=man",
      "rating": 5,
      "title": "Exceeded expectations!",
      "content": "Absolutely fantastic! The attention to detail is remarkable and the customer service is top-notch. I'm impressed with how they handle issues and their commitment to quality.",
      "date": DateTime.now().subtract(Duration(days: 5)),
      "category": "service",
      "verified": true,
      "helpful": 31,
      "photos": [
        "https://picsum.photos/100/100?random=12&keyword=excellent",
      ],
    },
    {
      "id": 5,
      "user": "Lisa Wang",
      "avatar": "https://picsum.photos/40/40?random=5&keyword=woman",
      "rating": 2,
      "title": "Not satisfied with the purchase",
      "content": "Unfortunately, the product didn't meet my expectations. The quality is below average and the customer support was unhelpful when I tried to resolve the issue.",
      "date": DateTime.now().subtract(Duration(days: 7)),
      "category": "product",
      "verified": true,
      "helpful": 12,
      "photos": [],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredReviews = _getFilteredReviews();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Reviews"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterModal();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Review Summary
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spLg),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "4.2",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Row(
                            children: List.generate(5, (index) => Icon(
                              index < 4 ? Icons.star : Icons.star_border,
                              size: 16,
                              color: Colors.white,
                            )),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Based on ${reviews.length} reviews",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        children: List.generate(5, (index) {
                          int starCount = 5 - index;
                          int reviewCount = reviews.where((r) => r["rating"] == starCount).length;
                          double percentage = reviewCount / reviews.length;
                          
                          return Container(
                            margin: EdgeInsets.only(bottom: spXs),
                            child: Row(
                              children: [
                                Text(
                                  "$starCount",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: spXs),
                                Icon(
                                  Icons.star,
                                  size: 12,
                                  color: Colors.white,
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Container(
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withAlpha(50),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: FractionallySizedBox(
                                      alignment: Alignment.centerLeft,
                                      widthFactor: percentage,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "$reviewCount",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Filter Bar
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Expanded(
                  child: QHorizontalScroll(
                    children: [
                      'all', 'service', 'product', 'verified'
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
                          color: selectedCategory == category ? primaryColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(
                            color: selectedCategory == category ? primaryColor : disabledColor,
                          ),
                        ),
                        child: Text(
                          category.toUpperCase(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: selectedCategory == category ? Colors.white : disabledBoldColor,
                          ),
                        ),
                      ),
                    )).toList(),
                  ),
                ),
                SizedBox(width: spSm),
                GestureDetector(
                  onTap: () {
                    _showSortModal();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spMd,
                      vertical: spSm,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(color: disabledColor),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.sort,
                          size: 16,
                          color: primaryColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          sortBy.toUpperCase(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Reviews List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(spMd),
              itemCount: filteredReviews.length,
              itemBuilder: (context, index) {
                final review = filteredReviews[index];
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowMd],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // User Info
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage("${review["avatar"]}"),
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${review["user"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    if (review["verified"] as bool)
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spSm,
                                          vertical: spXs,
                                        ),
                                        decoration: BoxDecoration(
                                          color: successColor,
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Text(
                                          "VERIFIED",
                                          style: TextStyle(
                                            fontSize: 8,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Row(
                                      children: List.generate(5, (starIndex) => Icon(
                                        starIndex < (review["rating"] as int) ? Icons.star : Icons.star_border,
                                        size: 14,
                                        color: starIndex < (review["rating"] as int) ? warningColor : disabledColor,
                                      )),
                                    ),
                                    SizedBox(width: spSm),
                                    Text(
                                      "${(review["date"] as DateTime).dMMMy}",
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
                          IconButton(
                            icon: Icon(
                              Icons.more_vert,
                              color: disabledBoldColor,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      
                      SizedBox(height: spMd),
                      
                      // Review Content
                      Text(
                        "${review["title"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${review["content"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                          height: 1.5,
                        ),
                      ),
                      
                      // Photos
                      if ((review["photos"] as List).isNotEmpty) ...[
                        SizedBox(height: spMd),
                        QHorizontalScroll(
                          children: (review["photos"] as List).map((photo) => Container(
                            margin: EdgeInsets.only(right: spSm),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(radiusLg),
                              child: Image.network(
                                "$photo",
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )).toList(),
                        ),
                      ],
                      
                      SizedBox(height: spMd),
                      
                      // Actions
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Row(
                              children: [
                                Icon(
                                  Icons.thumb_up,
                                  size: 16,
                                  color: primaryColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Helpful (${review["helpful"]})",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: spMd),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              "Reply",
                              style: TextStyle(
                                fontSize: 12,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
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
                              color: _getCategoryColor(review["category"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${review["category"]}".toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: _getCategoryColor(review["category"]),
                              ),
                            ),
                          ),
                        ],
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
          // navigateTo(WriteReviewView());
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredReviews() {
    List<Map<String, dynamic>> filtered = reviews;
    
    if (selectedCategory != "all") {
      if (selectedCategory == "verified") {
        filtered = filtered.where((r) => r["verified"] as bool).toList();
      } else {
        filtered = filtered.where((r) => r["category"] == selectedCategory).toList();
      }
    }
    
    // Sort
    switch (sortBy) {
      case "newest":
        filtered.sort((a, b) => (b["date"] as DateTime).compareTo(a["date"] as DateTime));
        break;
      case "oldest":
        filtered.sort((a, b) => (a["date"] as DateTime).compareTo(b["date"] as DateTime));
        break;
      case "highest":
        filtered.sort((a, b) => (b["rating"] as int).compareTo(a["rating"] as int));
        break;
      case "lowest":
        filtered.sort((a, b) => (a["rating"] as int).compareTo(b["rating"] as int));
        break;
      case "helpful":
        filtered.sort((a, b) => (b["helpful"] as int).compareTo(a["helpful"] as int));
        break;
    }
    
    return filtered;
  }

  void _showFilterModal() {
    // Filter modal implementation
  }

  void _showSortModal() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Sort by",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spMd),
            ...['newest', 'oldest', 'highest', 'lowest', 'helpful'].map((sort) => ListTile(
              title: Text(sort.toUpperCase()),
              leading: Radio<String>(
                value: sort,
                groupValue: sortBy,
                onChanged: (value) {
                  sortBy = value!;
                  setState(() {});
                  Navigator.pop(context);
                },
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'service':
        return primaryColor;
      case 'product':
        return successColor;
      default:
        return infoColor;
    }
  }
}
