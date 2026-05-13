import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaTimelineView extends StatefulWidget {
  const SmaTimelineView({super.key});

  @override
  State<SmaTimelineView> createState() => _SmaTimelineViewState();
}

class _SmaTimelineViewState extends State<SmaTimelineView> {
  String selectedFilter = "all";
  
  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Posts", "value": "all"},
    {"label": "Photos", "value": "photos"},
    {"label": "Videos", "value": "videos"},
    {"label": "Text Only", "value": "text"},
  ];
  
  List<Map<String, dynamic>> timelinePosts = [
    {
      "id": "1",
      "type": "post",
      "timestamp": "Today",
      "author": {
        "name": "You",
        "avatar": "https://picsum.photos/60/60?random=1&keyword=person",
      },
      "content": "Just launched my new project! Excited to share this journey with everyone. Hard work really pays off! 🚀",
      "images": [
        "https://picsum.photos/400/300?random=1&keyword=tech",
        "https://picsum.photos/400/300?random=2&keyword=workspace",
      ],
      "likes": 45,
      "comments": 12,
      "shares": 3,
      "privacy": "public",
    },
    {
      "id": "2",
      "type": "milestone",
      "timestamp": "2 days ago",
      "milestone": "Profile Photo Updated",
      "content": "Updated profile picture",
      "images": ["https://picsum.photos/200/200?random=3&keyword=person"],
      "likes": 23,
      "comments": 8,
    },
    {
      "id": "3",
      "type": "post",
      "timestamp": "1 week ago",
      "author": {
        "name": "You",
        "avatar": "https://picsum.photos/60/60?random=1&keyword=person",
      },
      "content": "Weekend vibes! Spent the day hiking with friends. Nature is the best therapy. Who else loves outdoor adventures?",
      "images": [
        "https://picsum.photos/400/300?random=4&keyword=hiking",
        "https://picsum.photos/400/300?random=5&keyword=nature",
        "https://picsum.photos/400/300?random=6&keyword=mountains",
      ],
      "likes": 78,
      "comments": 24,
      "shares": 15,
      "privacy": "friends",
    },
    {
      "id": "4",
      "type": "memory",
      "timestamp": "1 month ago",
      "content": "Memory from last year: First day at the new job! Time flies so fast.",
      "images": ["https://picsum.photos/400/300?random=7&keyword=office"],
      "originalDate": "March 15, 2023",
      "likes": 56,
      "comments": 18,
    },
    {
      "id": "5",
      "type": "post",
      "timestamp": "2 months ago",
      "author": {
        "name": "You",
        "avatar": "https://picsum.photos/60/60?random=1&keyword=person",
      },
      "content": "Cooking Sunday! Made homemade pizza from scratch. The secret is in the dough preparation. Recipe coming soon!",
      "images": [
        "https://picsum.photos/400/300?random=8&keyword=pizza",
        "https://picsum.photos/400/300?random=9&keyword=cooking",
      ],
      "likes": 124,
      "comments": 35,
      "shares": 8,
      "privacy": "public",
    },
    {
      "id": "6",
      "type": "achievement",
      "timestamp": "3 months ago",
      "achievement": "Marathon Completed",
      "content": "First marathon completed! 26.2 miles of pure determination and willpower.",
      "images": ["https://picsum.photos/400/300?random=10&keyword=marathon"],
      "likes": 189,
      "comments": 67,
      "shares": 42,
    },
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Timeline"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          _buildFilterSection(),
          _buildTimelineStats(),
          Expanded(
            child: _buildTimelineList(),
          ),
        ],
      ),
    );
  }
  
  Widget _buildFilterSection() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: QCategoryPicker(
        items: filterOptions,
        value: selectedFilter,
        onChanged: (index, label, value, item) {
          selectedFilter = value;
          setState(() {});
        },
      ),
    );
  }
  
  Widget _buildTimelineStats() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(30),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem("Posts", "24", Icons.post_add),
          ),
          Expanded(
            child: _buildStatItem("Photos", "156", Icons.photo),
          ),
          Expanded(
            child: _buildStatItem("Videos", "12", Icons.video_library),
          ),
          Expanded(
            child: _buildStatItem("Memories", "8", Icons.memory),
          ),
        ],
      ),
    );
  }
  
  Widget _buildStatItem(String label, String count, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: primaryColor,
          size: 24,
        ),
        SizedBox(height: spXs),
        Text(
          count,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: primaryColor,
          ),
        ),
      ],
    );
  }
  
  Widget _buildTimelineList() {
    final filteredPosts = _filterPosts();
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        children: List.generate(filteredPosts.length, (index) {
          final post = filteredPosts[index];
          return _buildTimelineItem(post, index);
        }),
      ),
    );
  }
  
  List<Map<String, dynamic>> _filterPosts() {
    if (selectedFilter == "all") return timelinePosts;
    
    return timelinePosts.where((post) {
      if (selectedFilter == "photos") {
        return (post["images"] as List).isNotEmpty;
      } else if (selectedFilter == "videos") {
        return post["type"] == "video";
      } else if (selectedFilter == "text") {
        return (post["images"] as List).isEmpty;
      }
      return true;
    }).toList();
  }
  
  Widget _buildTimelineItem(Map<String, dynamic> post, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTimelineIndicator(post, index == 0),
          SizedBox(width: spMd),
          Expanded(
            child: _buildTimelineContent(post),
          ),
        ],
      ),
    );
  }
  
  Widget _buildTimelineIndicator(Map<String, dynamic> post, bool isFirst) {
    Color indicatorColor = primaryColor;
    IconData indicatorIcon = Icons.circle;
    
    switch (post["type"]) {
      case "milestone":
        indicatorColor = successColor;
        indicatorIcon = Icons.star;
        break;
      case "achievement":
        indicatorColor = warningColor;
        indicatorIcon = Icons.emoji_events;
        break;
      case "memory":
        indicatorColor = infoColor;
        indicatorIcon = Icons.memory;
        break;
      default:
        indicatorColor = primaryColor;
        indicatorIcon = Icons.article;
    }
    
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: indicatorColor,
            shape: BoxShape.circle,
            boxShadow: [shadowSm],
          ),
          child: Icon(
            indicatorIcon,
            color: Colors.white,
            size: 20,
          ),
        ),
        if (!isFirst)
          Container(
            width: 2,
            height: 60,
            color: disabledOutlineBorderColor,
            margin: EdgeInsets.only(top: spXs),
          ),
      ],
    );
  }
  
  Widget _buildTimelineContent(Map<String, dynamic> post) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          _buildPostHeader(post),
          _buildPostContent(post),
          if ((post["images"] as List).isNotEmpty) _buildPostImages(post),
          _buildPostFooter(post),
        ],
      ),
    );
  }
  
  Widget _buildPostHeader(Map<String, dynamic> post) {
    return Row(
      children: [
        if (post["type"] == "post" && post.containsKey("author")) ...[
          Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage("${post["author"]["avatar"]}"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: spSm),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _getPostTitle(post),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Text(
                "${post["timestamp"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
        if (post.containsKey("privacy"))
          Container(
            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "${post["privacy"]}",
              style: TextStyle(
                fontSize: 10,
                color: primaryColor,
              ),
            ),
          ),
        IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: () {},
          color: disabledBoldColor,
        ),
      ],
    );
  }
  
  String _getPostTitle(Map<String, dynamic> post) {
    switch (post["type"]) {
      case "milestone":
        return "${post["milestone"]}";
      case "achievement":
        return "${post["achievement"]}";
      case "memory":
        return "Memory";
      default:
        return "Post";
    }
  }
  
  Widget _buildPostContent(Map<String, dynamic> post) {
    return Text(
      "${post["content"]}",
      style: TextStyle(
        fontSize: 16,
        color: primaryColor,
        height: 1.4,
      ),
    );
  }
  
  Widget _buildPostImages(Map<String, dynamic> post) {
    final images = post["images"] as List;
    
    if (images.length == 1) {
      return Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radiusSm),
          image: DecorationImage(
            image: NetworkImage("${images[0]}"),
            fit: BoxFit.cover,
          ),
        ),
      );
    } else if (images.length == 2) {
      return Row(
        spacing: spXs,
        children: images.map((image) {
          return Expanded(
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusSm),
                image: DecorationImage(
                  image: NetworkImage("$image"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        }).toList(),
      );
    } else {
      return Container(
        height: 200,
        child: QHorizontalScroll(
          children: images.map((image) {
            return Container(
              width: 160,
              margin: EdgeInsets.only(right: spXs),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusSm),
                image: DecorationImage(
                  image: NetworkImage("$image"),
                  fit: BoxFit.cover,
                ),
              ),
            );
          }).toList(),
        ),
      );
    }
  }
  
  Widget _buildPostFooter(Map<String, dynamic> post) {
    return Column(
      spacing: spSm,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${post["likes"]} likes",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
            if (post.containsKey("comments"))
              Text(
                "${post["comments"]} comments",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
          ],
        ),
        Divider(),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_border,
                      color: disabledBoldColor,
                      size: 18,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Like",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (post.containsKey("comments")) ...[
              Expanded(
                child: GestureDetector(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.comment,
                        color: disabledBoldColor,
                        size: 18,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Comment",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            if (post.containsKey("shares")) ...[
              Expanded(
                child: GestureDetector(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.share,
                        color: disabledBoldColor,
                        size: 18,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Share",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
