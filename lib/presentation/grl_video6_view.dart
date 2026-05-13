import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlVideo6View extends StatefulWidget {
  @override
  State<GrlVideo6View> createState() => _GrlVideo6ViewState();
}

class _GrlVideo6ViewState extends State<GrlVideo6View> {
  int selectedVideoIndex = 0;
  bool isFollowing = false;
  bool isSubscribed = false;
  bool showComments = false;
  String newComment = "";

  Map<String, dynamic> currentVideo = {
    "id": "1",
    "title": "Complete Web Development Course 2024",
    "description": "Learn full-stack web development from scratch with this comprehensive course. Covers HTML, CSS, JavaScript, React, Node.js, and database integration.",
    "thumbnail": "https://picsum.photos/400/300?random=41&keyword=coding",
    "duration": "4:35:20",
    "views": 2500000,
    "likes": 185000,
    "dislikes": 3200,
    "creator": "CodeMaster Pro",
    "avatar": "https://picsum.photos/100/100?random=41&keyword=person",
    "subscribers": 1250000,
    "uploadDate": "3 days ago",
    "category": "Education",
    "tags": ["Web Development", "Programming", "Tutorial", "Full Stack"],
    "quality": "4K",
    "chapters": [
      {"title": "Introduction", "time": "0:00", "duration": "5:30"},
      {"title": "HTML Basics", "time": "5:30", "duration": "45:20"},
      {"title": "CSS Fundamentals", "time": "50:50", "duration": "38:15"},
      {"title": "JavaScript Essentials", "time": "1:29:05", "duration": "1:12:30"},
      {"title": "React Framework", "time": "2:41:35", "duration": "1:05:45"},
      {"title": "Backend with Node.js", "time": "3:47:20", "duration": "48:00"},
    ],
  };

  List<Map<String, dynamic>> comments = [
    {
      "id": "1",
      "author": "WebDev Student",
      "avatar": "https://picsum.photos/40/40?random=51&keyword=person",
      "content": "This is the best web development tutorial I've ever watched! The explanations are crystal clear.",
      "likes": 245,
      "replies": 12,
      "timeAgo": "2 hours ago",
      "isLiked": false,
    },
    {
      "id": "2",
      "author": "Frontend Dev",
      "avatar": "https://picsum.photos/40/40?random=52&keyword=person",
      "content": "Amazing content! The React section was particularly helpful. Thank you for creating this!",
      "likes": 189,
      "replies": 8,
      "timeAgo": "5 hours ago",
      "isLiked": true,
    },
    {
      "id": "3",
      "author": "Code Newbie",
      "avatar": "https://picsum.photos/40/40?random=53&keyword=person",
      "content": "I'm a complete beginner and this course made everything so easy to understand. Following along perfectly!",
      "likes": 156,
      "replies": 15,
      "timeAgo": "1 day ago",
      "isLiked": false,
    },
    {
      "id": "4",
      "author": "Tech Enthusiast",
      "avatar": "https://picsum.photos/40/40?random=54&keyword=person",
      "content": "The production quality is fantastic. Great audio, clear screen recordings, and excellent pacing.",
      "likes": 98,
      "replies": 5,
      "timeAgo": "1 day ago",
      "isLiked": false,
    },
  ];

  List<Map<String, dynamic>> relatedVideos = [
    {
      "title": "Advanced JavaScript Concepts",
      "thumbnail": "https://picsum.photos/200/120?random=61&keyword=javascript",
      "duration": "2:15:30",
      "views": 890000,
      "creator": "JS Expert",
      "uploadDate": "1 week ago",
    },
    {
      "title": "React Hooks Complete Guide",
      "thumbnail": "https://picsum.photos/200/120?random=62&keyword=react",
      "duration": "1:45:20",
      "views": 654000,
      "creator": "React Pro",
      "uploadDate": "5 days ago",
    },
    {
      "title": "Node.js Backend Masterclass",
      "thumbnail": "https://picsum.photos/200/120?random=63&keyword=nodejs",
      "duration": "3:20:15",
      "views": 432000,
      "creator": "Backend Guru",
      "uploadDate": "2 weeks ago",
    },
    {
      "title": "CSS Grid & Flexbox Tutorial",
      "thumbnail": "https://picsum.photos/200/120?random=64&keyword=css",
      "duration": "1:25:40",
      "views": 287000,
      "creator": "CSS Master",
      "uploadDate": "4 days ago",
    },
  ];

  Widget _buildVideoPlayer() {
    return Container(
      height: 220,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusLg),
              image: DecorationImage(
                image: NetworkImage("${currentVideo["thumbnail"]}"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusLg),
              gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withAlpha(102),
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(230),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.play_arrow,
                color: primaryColor,
                size: 45,
              ),
            ),
          ),
          Positioned(
            top: spSm,
            right: spSm,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${currentVideo["quality"]}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: spXs),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(179),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${currentVideo["duration"]}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 4,
              margin: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: LinearProgressIndicator(
                value: 0.35,
                backgroundColor: Colors.white.withAlpha(77),
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoInfo() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${currentVideo["title"]}",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Text(
                "${((currentVideo["views"] as int) / 1000000).toStringAsFixed(1)}M views",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "•",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "${currentVideo["uploadDate"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [
                          Icon(
                            Icons.thumb_up,
                            color: primaryColor,
                            size: 20,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${((currentVideo["likes"] as int) / 1000).toInt()}K",
                            style: TextStyle(
                              fontSize: 14,
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
                      child: Row(
                        children: [
                          Icon(
                            Icons.thumb_down_outlined,
                            color: disabledBoldColor,
                            size: 20,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${((currentVideo["dislikes"] as int) / 1000).toInt()}K",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.share,
                      color: primaryColor,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: spMd),
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.download,
                      color: primaryColor,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: spMd),
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.playlist_add,
                      color: primaryColor,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spMd),
          Divider(color: disabledColor),
          SizedBox(height: spMd),
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage("${currentVideo["avatar"]}"),
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
                      "${currentVideo["creator"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${((currentVideo["subscribers"] as int) / 1000000).toStringAsFixed(1)}M subscribers",
                      style: TextStyle(
                        fontSize: 13,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              QButton(
                label: isSubscribed ? "Subscribed" : "Subscribe",
                size: bs.sm,
                color: isSubscribed ? disabledBoldColor : primaryColor,
                onPressed: () {
                  isSubscribed = !isSubscribed;
                  setState(() {});
                },
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            "${currentVideo["description"]}",
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
              height: 1.5,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: spSm),
          QHorizontalScroll(
            children: (currentVideo["tags"] as List).map((tag) {
              return Container(
                margin: EdgeInsets.only(right: spSm),
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(26),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Text(
                  "#$tag",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildChaptersList() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Text(
              "Chapters",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
          Divider(height: 1, color: disabledColor),
          Column(
            children: (currentVideo["chapters"] as List).asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> chapter = entry.value;
              bool isActive = index == 0;
              return Container(
                decoration: BoxDecoration(
                  color: isActive ? primaryColor.withAlpha(26) : Colors.transparent,
                  border: Border(
                    bottom: BorderSide(color: disabledColor, width: 0.5),
                  ),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: spMd, vertical: spXs),
                  leading: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: isActive ? primaryColor : disabledColor,
                      shape: BoxShape.circle,
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
                  title: Text(
                    "${chapter["title"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isActive ? primaryColor : primaryColor,
                    ),
                  ),
                  subtitle: Text(
                    "${chapter["time"]} • ${chapter["duration"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  trailing: Icon(
                    isActive ? Icons.pause : Icons.play_arrow,
                    color: isActive ? primaryColor : disabledBoldColor,
                  ),
                  onTap: () {},
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentsSection() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Comments (${comments.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showComments = !showComments;
                    setState(() {});
                  },
                  child: Icon(
                    showComments ? Icons.expand_less : Icons.expand_more,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          if (showComments) ...[
            Divider(height: 1, color: disabledColor),
            Padding(
              padding: EdgeInsets.all(spMd),
              child: Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Add a comment...",
                      value: newComment,
                      onChanged: (value) {
                        newComment = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    label: "Post",
                    size: bs.sm,
                    onPressed: () {
                      if (newComment.isNotEmpty) {
                        newComment = "";
                        setState(() {});
                      }
                    },
                  ),
                ],
              ),
            ),
            Column(
              children: comments.map((comment) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: disabledColor, width: 0.5),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage("${comment["avatar"]}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${comment["author"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${comment["timeAgo"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${comment["content"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: primaryColor,
                                height: 1.4,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Row(
                                    children: [
                                      Icon(
                                        comment["isLiked"] as bool ? Icons.thumb_up : Icons.thumb_up_outlined,
                                        color: comment["isLiked"] as bool ? primaryColor : disabledBoldColor,
                                        size: 16,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${comment["likes"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
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
                                if ((comment["replies"] as int) > 0) ...[
                                  SizedBox(width: spMd),
                                  Text(
                                    "View ${comment["replies"]} replies",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
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
        ],
      ),
    );
  }

  Widget _buildRelatedVideos() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Text(
              "Related Videos",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
          Divider(height: 1, color: disabledColor),
          Column(
            children: relatedVideos.map((video) {
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: disabledColor, width: 0.5),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 120,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusSm),
                        image: DecorationImage(
                          image: NetworkImage("${video["thumbnail"]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: spXs,
                            right: spXs,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(179),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${video["duration"]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${video["title"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${video["creator"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Text(
                                "${((video["views"] as int) / 1000).toInt()}K views",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "•",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "${video["uploadDate"]}",
                                style: TextStyle(
                                  fontSize: 11,
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
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video Details"),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(right: spMd),
              child: Icon(
                Icons.cast,
                color: primaryColor,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(right: spMd),
              child: Icon(
                Icons.more_vert,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            _buildVideoPlayer(),
            SizedBox(height: spMd),
            _buildVideoInfo(),
            _buildChaptersList(),
            _buildCommentsSection(),
            _buildRelatedVideos(),
          ],
        ),
      ),
    );
  }
}
