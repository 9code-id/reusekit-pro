import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaVideoReviewView extends StatefulWidget {
  const SpaVideoReviewView({super.key});

  @override
  State<SpaVideoReviewView> createState() => _SpaVideoReviewViewState();
}

class _SpaVideoReviewViewState extends State<SpaVideoReviewView> {
  String selectedFilter = "all";
  String selectedSort = "newest";
  bool isPlaying = false;
  int currentVideoIndex = 0;

  List<Map<String, dynamic>> videoReviews = [
    {
      "id": 1,
      "title": "Amazing Deep Tissue Massage Experience",
      "customer": "Sarah Johnson",
      "avatar": "https://picsum.photos/100/100?random=1&keyword=woman",
      "rating": 5.0,
      "duration": "2:34",
      "thumbnail": "https://picsum.photos/400/300?random=1&keyword=spa-massage",
      "treatment": "Deep Tissue Massage",
      "date": "2024-01-15",
      "verified": true,
      "likes": 42,
      "views": 1250,
      "description": "The therapist was incredibly professional and the massage really helped with my chronic back pain. The ambiance was perfect and I felt completely relaxed.",
      "helpful_votes": 38,
      "category": "massage",
    },
    {
      "id": 2,
      "title": "HydraFacial Results - Before & After",
      "customer": "Emily Chen",
      "avatar": "https://picsum.photos/100/100?random=2&keyword=asian-woman",
      "rating": 4.8,
      "duration": "1:45",
      "thumbnail": "https://picsum.photos/400/300?random=2&keyword=facial",
      "treatment": "HydraFacial",
      "date": "2024-01-12",
      "verified": true,
      "likes": 67,
      "views": 2100,
      "description": "Immediate results after just one session! My skin feels so smooth and glowing. The staff explained each step of the process.",
      "helpful_votes": 59,
      "category": "facial",
    },
    {
      "id": 3,
      "title": "Couples Spa Day Highlights",
      "customer": "Mark & Lisa Rodriguez",
      "avatar": "https://picsum.photos/100/100?random=3&keyword=couple",
      "rating": 4.9,
      "duration": "3:12",
      "thumbnail": "https://picsum.photos/400/300?random=3&keyword=couples-spa",
      "treatment": "Couples Package",
      "date": "2024-01-10",
      "verified": true,
      "likes": 89,
      "views": 1850,
      "description": "Perfect anniversary treat! The couples suite was beautiful and the synchronized massage was incredible. We'll definitely be back.",
      "helpful_votes": 74,
      "category": "packages",
    },
    {
      "id": 4,
      "title": "Hot Stone Therapy Session",
      "customer": "David Kim",
      "avatar": "https://picsum.photos/100/100?random=4&keyword=man",
      "rating": 4.7,
      "duration": "2:58",
      "thumbnail": "https://picsum.photos/400/300?random=4&keyword=hot-stone",
      "treatment": "Hot Stone Massage",
      "date": "2024-01-08",
      "verified": true,
      "likes": 34,
      "views": 980,
      "description": "First time trying hot stone therapy and it exceeded my expectations. The heat penetrated deep into my muscles and I felt so relaxed.",
      "helpful_votes": 31,
      "category": "massage",
    },
    {
      "id": 5,
      "title": "Anti-Aging Facial Treatment Review",
      "customer": "Patricia Williams",
      "avatar": "https://picsum.photos/100/100?random=5&keyword=older-woman",
      "rating": 4.6,
      "duration": "2:15",
      "thumbnail": "https://picsum.photos/400/300?random=5&keyword=anti-aging",
      "treatment": "Anti-Aging Facial",
      "date": "2024-01-05",
      "verified": false,
      "likes": 28,
      "views": 750,
      "description": "Noticeable improvement in my skin texture and fine lines. The aesthetician was knowledgeable about mature skin care.",
      "helpful_votes": 25,
      "category": "facial",
    },
    {
      "id": 6,
      "title": "Prenatal Massage - Safe & Soothing",
      "customer": "Jessica Brown",
      "avatar": "https://picsum.photos/100/100?random=6&keyword=pregnant-woman",
      "rating": 5.0,
      "duration": "1:52",
      "thumbnail": "https://picsum.photos/400/300?random=6&keyword=prenatal",
      "treatment": "Prenatal Massage",
      "date": "2024-01-03",
      "verified": true,
      "likes": 56,
      "views": 1320,
      "description": "As a first-time mom, I was nervous but the therapist made me feel completely comfortable. Great for pregnancy aches and pains.",
      "helpful_votes": 48,
      "category": "massage",
    },
  ];

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Reviews", "value": "all", "icon": Icons.video_library},
    {"label": "Massage", "value": "massage", "icon": Icons.healing},
    {"label": "Facial", "value": "facial", "icon": Icons.face_retouching_natural},
    {"label": "Packages", "value": "packages", "icon": Icons.card_giftcard},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Newest First", "value": "newest"},
    {"label": "Highest Rated", "value": "rating"},
    {"label": "Most Liked", "value": "likes"},
    {"label": "Most Viewed", "value": "views"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video Reviews"),
        actions: [
          QButton(
            icon: Icons.sort,
            size: bs.sm,
            onPressed: () {
              _showSortOptions();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Video Reviews Header
          _buildVideoReviewsHeader(),

          // Filter Tabs
          _buildFilterTabs(),

          // Video Reviews List
          Expanded(
            child: _buildVideoReviewsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoReviewsHeader() {
    final filteredReviews = _getFilteredReviews();
    final avgRating = filteredReviews.isEmpty ? 0.0 : 
        filteredReviews.map((r) => r["rating"] as double).reduce((a, b) => a + b) / filteredReviews.length;
    final totalViews = filteredReviews.map((r) => r["views"] as int).reduce((a, b) => a + b);
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(180)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.video_collection, color: Colors.white, size: 28),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Video Reviews",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Real experiences from our customers",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          
          // Stats Row
          Row(
            children: [
              _buildStatCard("${filteredReviews.length}", "Videos", Icons.play_circle),
              SizedBox(width: spSm),
              _buildStatCard("${avgRating.toStringAsFixed(1)}", "Avg Rating", Icons.star),
              SizedBox(width: spSm),
              _buildStatCard("${(totalViews / 1000).toStringAsFixed(1)}K", "Total Views", Icons.visibility),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(51),
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: Colors.white.withAlpha(100),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 20),
            SizedBox(height: spXs),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: Colors.white.withAlpha(180),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterTabs() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: spSm),
      color: Colors.grey[50],
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: spMd),
        child: Row(
          children: filterOptions.map((filter) {
            bool isSelected = selectedFilter == filter["value"];
            final count = selectedFilter == "all" 
                ? videoReviews.length 
                : videoReviews.where((v) => v["category"] == filter["value"]).length;
            
            return GestureDetector(
              onTap: () {
                selectedFilter = filter["value"];
                setState(() {});
              },
              child: Container(
                margin: EdgeInsets.only(right: spSm),
                padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor : Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(
                    color: isSelected ? primaryColor : Colors.grey[300]!,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      filter["icon"] as IconData,
                      color: isSelected ? Colors.white : disabledBoldColor,
                      size: 18,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${filter["label"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : disabledBoldColor,
                      ),
                    ),
                    if (isSelected) ...[
                      SizedBox(width: spXs),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(100),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "$count",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildVideoReviewsList() {
    final sortedReviews = _getSortedReviews();
    
    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: sortedReviews.length,
      itemBuilder: (context, index) {
        final review = sortedReviews[index];
        return _buildVideoReviewCard(review);
      },
    );
  }

  Widget _buildVideoReviewCard(Map<String, dynamic> review) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Video Thumbnail
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                child: Image.network(
                  "${review["thumbnail"]}",
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),

              // Play Button Overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(76),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                  ),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        _playVideo(review);
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [shadowMd],
                        ),
                        child: Icon(
                          Icons.play_arrow,
                          color: primaryColor,
                          size: 32,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Duration Badge
              Positioned(
                bottom: spSm,
                right: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(180),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${review["duration"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              // Verified Badge
              if (review["verified"])
                Positioned(
                  top: spSm,
                  left: spSm,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: successColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.verified, color: Colors.white, size: 12),
                        SizedBox(width: spXs),
                        Text(
                          "Verified",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),

          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                // Customer Info and Rating
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage("${review["avatar"]}"),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${review["customer"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              ...List.generate(5, (starIndex) {
                                return Icon(
                                  Icons.star,
                                  size: 16,
                                  color: starIndex < (review["rating"] as double).floor()
                                      ? warningColor
                                      : Colors.grey[300],
                                );
                              }),
                              SizedBox(width: spXs),
                              Text(
                                "${review["rating"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "${DateTime.parse(review["date"]).dMMMy}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),

                // Video Title
                Text(
                  "${review["title"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // Treatment Badge
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${review["treatment"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ),

                // Description
                Text(
                  "${review["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),

                // Video Stats
                Row(
                  children: [
                    _buildStatChip(Icons.thumb_up, "${review["likes"]}", "Likes"),
                    SizedBox(width: spSm),
                    _buildStatChip(Icons.visibility, "${review["views"]}", "Views"),
                    SizedBox(width: spSm),
                    _buildStatChip(Icons.help, "${review["helpful_votes"]}", "Helpful"),
                  ],
                ),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Play Video",
                        size: bs.sm,
                        onPressed: () {
                          _playVideo(review);
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.thumb_up_outlined,
                      size: bs.sm,
                      onPressed: () {
                        _likeVideo(review["id"]);
                      },
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      icon: Icons.share,
                      size: bs.sm,
                      onPressed: () {
                        _shareVideo(review);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatChip(IconData icon, String value, String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: disabledBoldColor),
          SizedBox(width: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredReviews() {
    if (selectedFilter == "all") {
      return videoReviews;
    }
    return videoReviews.where((review) => review["category"] == selectedFilter).toList();
  }

  List<Map<String, dynamic>> _getSortedReviews() {
    final filteredReviews = _getFilteredReviews();
    
    switch (selectedSort) {
      case "rating":
        filteredReviews.sort((a, b) => (b["rating"] as double).compareTo(a["rating"] as double));
        break;
      case "likes":
        filteredReviews.sort((a, b) => (b["likes"] as int).compareTo(a["likes"] as int));
        break;
      case "views":
        filteredReviews.sort((a, b) => (b["views"] as int).compareTo(a["views"] as int));
        break;
      case "newest":
      default:
        filteredReviews.sort((a, b) => DateTime.parse(b["date"]).compareTo(DateTime.parse(a["date"])));
        break;
    }
    
    return filteredReviews;
  }

  void _showSortOptions() {
    // Show sort options modal
    ss("Sort options opened");
  }

  void _playVideo(Map<String, dynamic> review) {
    ss("Playing: ${review["title"]}");
    //navigateTo ( VideoPlayerView )
  }

  void _likeVideo(int videoId) {
    setState(() {
      final index = videoReviews.indexWhere((v) => v["id"] == videoId);
      if (index != -1) {
        videoReviews[index]["likes"] = (videoReviews[index]["likes"] as int) + 1;
      }
    });
    ss("Video liked");
  }

  void _shareVideo(Map<String, dynamic> review) {
    ss("Sharing: ${review["title"]}");
  }
}
