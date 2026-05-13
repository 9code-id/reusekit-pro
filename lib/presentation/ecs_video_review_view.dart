import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsVideoReviewView extends StatefulWidget {
  const EcsVideoReviewView({super.key});

  @override
  State<EcsVideoReviewView> createState() => _EcsVideoReviewViewState();
}

class _EcsVideoReviewViewState extends State<EcsVideoReviewView> {
  String selectedFilter = "All";
  String sortBy = "Most Recent";
  bool isRecordingReview = false;
  double recordingProgress = 0.0;
  String selectedProduct = "Wireless Headphones";
  
  List<String> filterOptions = ["All", "5 Stars", "4 Stars", "3 Stars", "2 Stars", "1 Star"];
  List<String> sortOptions = ["Most Recent", "Most Helpful", "Highest Rating", "Lowest Rating"];
  
  List<Map<String, dynamic>> videoReviews = [
    {
      "id": 1,
      "user": "TechReviewer2024",
      "userImage": "https://picsum.photos/80/80?random=1&keyword=person",
      "rating": 5,
      "title": "Amazing sound quality!",
      "description": "These headphones exceeded my expectations. The noise cancellation is incredible and battery life is outstanding.",
      "videoThumbnail": "https://picsum.photos/300/200?random=1&keyword=headphones",
      "videoDuration": "2:45",
      "uploadDate": "2024-01-15",
      "likes": 324,
      "isHelpful": true,
      "isVerifiedPurchase": true,
      "productUsageDays": 30,
    },
    {
      "id": 2,
      "user": "MusicLover88",
      "userImage": "https://picsum.photos/80/80?random=2&keyword=person",
      "rating": 4,
      "title": "Good for the price",
      "description": "Solid build quality and decent sound. The bass could be better but overall satisfied with the purchase.",
      "videoThumbnail": "https://picsum.photos/300/200?random=2&keyword=audio",
      "videoDuration": "1:30",
      "uploadDate": "2024-01-12",
      "likes": 156,
      "isHelpful": false,
      "isVerifiedPurchase": true,
      "productUsageDays": 15,
    },
    {
      "id": 3,
      "user": "AudioPhile_Pro",
      "userImage": "https://picsum.photos/80/80?random=3&keyword=person",
      "rating": 5,
      "title": "Professional quality",
      "description": "Perfect for studio work. The frequency response is flat and accurate. Highly recommend for professionals.",
      "videoThumbnail": "https://picsum.photos/300/200?random=3&keyword=studio",
      "videoDuration": "4:12",
      "uploadDate": "2024-01-10",
      "likes": 892,
      "isHelpful": true,
      "isVerifiedPurchase": true,
      "productUsageDays": 60,
    },
    {
      "id": 4,
      "user": "GamerGirl23",
      "userImage": "https://picsum.photos/80/80?random=4&keyword=person",
      "rating": 3,
      "title": "Okay for gaming",
      "description": "The microphone quality is not great for streaming. Sound is good but comfort could be improved for long sessions.",
      "videoThumbnail": "https://picsum.photos/300/200?random=4&keyword=gaming",
      "videoDuration": "3:20",
      "uploadDate": "2024-01-08",
      "likes": 67,
      "isHelpful": false,
      "isVerifiedPurchase": true,
      "productUsageDays": 7,
    },
  ];

  List<Map<String, dynamic>> get filteredReviews {
    var filtered = videoReviews.where((review) {
      if (selectedFilter == "All") return true;
      return "${review["rating"]} Stars" == selectedFilter;
    }).toList();

    filtered.sort((a, b) {
      switch (sortBy) {
        case "Most Recent":
          return DateTime.parse(b["uploadDate"]).compareTo(DateTime.parse(a["uploadDate"]));
        case "Most Helpful":
          return (b["likes"] as int).compareTo(a["likes"] as int);
        case "Highest Rating":
          return (b["rating"] as int).compareTo(a["rating"] as int);
        case "Lowest Rating":
          return (a["rating"] as int).compareTo(b["rating"] as int);
        default:
          return 0;
      }
    });

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video Reviews"),
        actions: [
          IconButton(
            icon: Icon(Icons.video_call),
            onPressed: _startVideoReview,
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: _showFilterOptions,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProductHeader(),
            SizedBox(height: spLg),
            _buildReviewStats(),
            SizedBox(height: spLg),
            _buildFilterSort(),
            SizedBox(height: spLg),
            _buildVideoReviewsList(),
            SizedBox(height: spLg),
            _buildCreateReviewPrompt(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _startVideoReview,
        backgroundColor: primaryColor,
        icon: Icon(Icons.videocam),
        label: Text("Record Review"),
      ),
    );
  }

  Widget _buildProductHeader() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radiusSm),
            child: Image.network(
              "https://picsum.photos/100/100?random=5&keyword=headphones",
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  selectedProduct,
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    ...List.generate(5, (index) {
                      return Icon(
                        Icons.star,
                        size: 16,
                        color: index < 4 ? warningColor : disabledColor,
                      );
                    }),
                    SizedBox(width: spXs),
                    Text(
                      "4.2 (${videoReviews.length} video reviews)",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "\$299.99",
                  style: TextStyle(
                    fontSize: fsH6,
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewStats() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Video Review Statistics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  "Total Videos",
                  "${videoReviews.length}",
                  Icons.video_library,
                  primaryColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard(
                  "Total Views",
                  "12.5K",
                  Icons.visibility,
                  successColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  "Avg Duration",
                  "2:52",
                  Icons.access_time,
                  infoColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard(
                  "Helpful Reviews",
                  "${videoReviews.where((r) => r["isHelpful"]).length}",
                  Icons.thumb_up,
                  warningColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSort() {
    return Row(
      children: [
        Expanded(
          child: QDropdownField(
            label: "Filter",
            items: filterOptions.map((option) => {
              "label": option,
              "value": option,
            }).toList(),
            value: selectedFilter,
            onChanged: (value, label) {
              selectedFilter = value;
              setState(() {});
            },
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: QDropdownField(
            label: "Sort By",
            items: sortOptions.map((option) => {
              "label": option,
              "value": option,
            }).toList(),
            value: sortBy,
            onChanged: (value, label) {
              sortBy = value;
              setState(() {});
            },
          ),
        ),
      ],
    );
  }

  Widget _buildVideoReviewsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Video Reviews (${filteredReviews.length})",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: spSm),
        ...filteredReviews.map((review) {
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
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage("${review["userImage"]}"),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${review["user"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (review["isVerifiedPurchase"]) ...[
                                SizedBox(width: spXs),
                                Icon(
                                  Icons.verified,
                                  size: 16,
                                  color: successColor,
                                ),
                              ],
                            ],
                          ),
                          Row(
                            children: [
                              ...List.generate(5, (index) {
                                return Icon(
                                  Icons.star,
                                  size: 14,
                                  color: index < (review["rating"] as int)
                                      ? warningColor
                                      : disabledColor,
                                );
                              }),
                              SizedBox(width: spXs),
                              Text(
                                DateTime.parse(review["uploadDate"]).dMMMy,
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
                    Text(
                      "${review["productUsageDays"]} days usage",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                
                // Video Thumbnail
                GestureDetector(
                  onTap: () => _playVideo(review),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusSm),
                        child: Image.network(
                          "${review["videoThumbnail"]}",
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(100),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Center(
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(180),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: spXs,
                        right: spXs,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(180),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${review["videoDuration"]}",
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
                ),
                
                SizedBox(height: spSm),
                Text(
                  "${review["title"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: fsH6,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${review["description"]}",
                  style: TextStyle(
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => _toggleHelpful(review["id"]),
                      child: Row(
                        children: [
                          Icon(
                            review["isHelpful"] ? Icons.thumb_up : Icons.thumb_up_outlined,
                            size: 16,
                            color: review["isHelpful"] ? primaryColor : disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${review["likes"]}",
                            style: TextStyle(
                              color: review["isHelpful"] ? primaryColor : disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: spMd),
                    GestureDetector(
                      onTap: () => _shareReview(review),
                      child: Row(
                        children: [
                          Icon(
                            Icons.share,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Share",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    if (review["isVerifiedPurchase"]) ...[
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "Verified Purchase",
                          style: TextStyle(
                            color: successColor,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildCreateReviewPrompt() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: primaryColor),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.videocam,
                color: primaryColor,
                size: 32,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Share Your Experience",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Help others by recording a video review of this product",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Record Video Review",
              size: bs.sm,
              onPressed: _startVideoReview,
            ),
          ),
        ],
      ),
    );
  }

  void _startVideoReview() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Record Video Review"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Choose how you'd like to record your video review:"),
            SizedBox(height: spSm),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Record Now",
                size: bs.sm,
                onPressed: () {
                  Navigator.pop(context);
                  _recordVideo();
                },
              ),
            ),
            SizedBox(height: spXs),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Upload Video",
                size: bs.sm,
                onPressed: () {
                  Navigator.pop(context);
                  _uploadVideo();
                },
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }

  void _recordVideo() {
    si("Starting video recording...");
  }

  void _uploadVideo() {
    si("Opening video file picker...");
  }

  void _playVideo(Map<String, dynamic> review) {
    si("Playing video review by ${review["user"]}");
  }

  void _toggleHelpful(int reviewId) {
    var reviewIndex = videoReviews.indexWhere((r) => r["id"] == reviewId);
    if (reviewIndex != -1) {
      videoReviews[reviewIndex]["isHelpful"] = !videoReviews[reviewIndex]["isHelpful"];
      if (videoReviews[reviewIndex]["isHelpful"]) {
        videoReviews[reviewIndex]["likes"]++;
      } else {
        videoReviews[reviewIndex]["likes"]--;
      }
      setState(() {});
    }
  }

  void _shareReview(Map<String, dynamic> review) {
    si("Sharing video review by ${review["user"]}");
  }

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Filter & Sort Options",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            QDropdownField(
              label: "Filter by Rating",
              items: filterOptions.map((option) => {
                "label": option,
                "value": option,
              }).toList(),
              value: selectedFilter,
              onChanged: (value, label) {
                selectedFilter = value;
                setState(() {});
                Navigator.pop(context);
              },
            ),
            SizedBox(height: spSm),
            QDropdownField(
              label: "Sort By",
              items: sortOptions.map((option) => {
                "label": option,
                "value": option,
              }).toList(),
              value: sortBy,
              onChanged: (value, label) {
                sortBy = value;
                setState(() {});
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
