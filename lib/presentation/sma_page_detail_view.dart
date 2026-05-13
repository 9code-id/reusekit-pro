import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaPageDetailView extends StatefulWidget {
  const SmaPageDetailView({super.key});

  @override
  State<SmaPageDetailView> createState() => _SmaPageDetailViewState();
}

class _SmaPageDetailViewState extends State<SmaPageDetailView> {
  int selectedTab = 0;
  bool isLiked = false;
  bool isFollowing = false;
  String newPost = "";

  final Map<String, dynamic> pageData = {
    "id": 1,
    "name": "TechFlow Solutions",
    "description": "Leading software development company specializing in mobile applications, web development, and digital transformation solutions. We help businesses innovate and grow through cutting-edge technology.",
    "category": "Technology Company",
    "followers": 25684,
    "likes": 18953,
    "verified": true,
    "website": "https://techflow.solutions",
    "phone": "+1 (555) 123-4567",
    "email": "info@techflow.solutions",
    "address": "123 Innovation Drive, Tech Valley, CA 94025",
    "founded": "2018",
    "employees": "50-100",
    "coverImage": "https://picsum.photos/400/200?random=1&keyword=office",
    "profileImage": "https://picsum.photos/100/100?random=2&keyword=company",
    "businessHours": {
      "monday": "9:00 AM - 6:00 PM",
      "tuesday": "9:00 AM - 6:00 PM",
      "wednesday": "9:00 AM - 6:00 PM",
      "thursday": "9:00 AM - 6:00 PM",
      "friday": "9:00 AM - 6:00 PM",
      "saturday": "Closed",
      "sunday": "Closed",
    },
    "services": [
      "Mobile App Development",
      "Web Development",
      "UI/UX Design",
      "Cloud Solutions",
      "Digital Marketing",
    ],
  };

  final List<Map<String, dynamic>> posts = [
    {
      "id": 1,
      "content": "We're excited to announce the launch of our new mobile app development framework! This cutting-edge solution reduces development time by 40% while maintaining high code quality. Check out our case studies and see how we've helped businesses transform digitally.",
      "timestamp": "3 hours ago",
      "likes": 156,
      "comments": 23,
      "shares": 12,
      "isLiked": false,
      "attachments": [
        "https://picsum.photos/300/200?random=10&keyword=mobile",
        "https://picsum.photos/300/200?random=11&keyword=app"
      ],
      "type": "announcement",
    },
    {
      "id": 2,
      "content": "Behind the scenes at TechFlow! Our amazing development team working on the next generation of cloud-native applications. We're always looking for talented developers to join our growing team. #TechLife #CloudDevelopment #Hiring",
      "timestamp": "1 day ago",
      "likes": 89,
      "comments": 15,
      "shares": 8,
      "isLiked": true,
      "attachments": [
        "https://picsum.photos/300/200?random=12&keyword=team"
      ],
      "type": "behind_scenes",
    },
    {
      "id": 3,
      "content": "Client Success Story: We helped XYZ Corp increase their online sales by 300% through our comprehensive digital transformation strategy. From redesigning their e-commerce platform to implementing advanced analytics, we delivered results that matter.",
      "timestamp": "2 days ago",
      "likes": 234,
      "comments": 45,
      "shares": 67,
      "isLiked": false,
      "attachments": [],
      "type": "case_study",
    },
    {
      "id": 4,
      "content": "Join us at the upcoming Tech Innovation Summit 2024! Our CEO will be speaking about 'The Future of Mobile Development' on February 20th. Don't miss this opportunity to network with industry leaders and learn about the latest tech trends.",
      "timestamp": "3 days ago",
      "likes": 78,
      "comments": 12,
      "shares": 34,
      "isLiked": false,
      "attachments": [
        "https://picsum.photos/300/200?random=13&keyword=conference"
      ],
      "type": "event",
    },
  ];

  final List<Map<String, dynamic>> reviews = [
    {
      "id": 1,
      "author": "Sarah Johnson",
      "authorImage": "https://picsum.photos/40/40?random=20&keyword=reviewer",
      "rating": 5,
      "review": "Exceptional service! TechFlow delivered our mobile app ahead of schedule and exceeded all our expectations. The team was professional, communicative, and truly understood our business needs.",
      "date": "2024-01-15",
      "helpful": 24,
    },
    {
      "id": 2,
      "author": "Michael Chen",
      "authorImage": "https://picsum.photos/40/40?random=21&keyword=reviewer",
      "rating": 5,
      "review": "Working with TechFlow was a game-changer for our startup. They not only built an amazing product but also provided valuable insights that helped shape our business strategy.",
      "date": "2024-01-10",
      "helpful": 18,
    },
    {
      "id": 3,
      "author": "Emily Rodriguez",
      "authorImage": "https://picsum.photos/40/40?random=22&keyword=reviewer",
      "rating": 4,
      "review": "Great experience overall. The development process was smooth and the final product met our requirements. The team was responsive and made adjustments based on our feedback.",
      "date": "2024-01-05",
      "helpful": 12,
    },
  ];

  final List<Map<String, dynamic>> team = [
    {
      "name": "Alex Thompson",
      "position": "CEO & Founder",
      "image": "https://picsum.photos/60/60?random=30&keyword=ceo",
      "experience": "15+ years",
    },
    {
      "name": "Maria Garcia",
      "position": "CTO",
      "image": "https://picsum.photos/60/60?random=31&keyword=cto",
      "experience": "12+ years",
    },
    {
      "name": "David Kim",
      "position": "Lead Developer",
      "image": "https://picsum.photos/60/60?random=32&keyword=developer",
      "experience": "8+ years",
    },
    {
      "name": "Jennifer Wu",
      "position": "UI/UX Director",
      "image": "https://picsum.photos/60/60?random=33&keyword=designer",
      "experience": "10+ years",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 220,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Cover Image
                    Image.network(
                      "${pageData["coverImage"]}",
                      fit: BoxFit.cover,
                    ),
                    // Gradient Overlay
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withAlpha(150),
                          ],
                        ),
                      ),
                    ),
                    // Page Info
                    Positioned(
                      bottom: spMd,
                      left: spMd,
                      right: spMd,
                      child: Row(
                        children: [
                          // Profile Image
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 3),
                            ),
                            child: CircleAvatar(
                              radius: 37,
                              backgroundImage: NetworkImage("${pageData["profileImage"]}"),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${pageData["name"]}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: fsH6,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    if (pageData["verified"] as bool)
                                      Icon(
                                        Icons.verified,
                                        color: successColor,
                                        size: 20,
                                      ),
                                  ],
                                ),
                                Text(
                                  "${pageData["category"]}",
                                  style: TextStyle(
                                    color: Colors.white.withAlpha(200),
                                    fontSize: 12,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${((pageData["followers"] as int) / 1000).toStringAsFixed(1)}K followers",
                                      style: TextStyle(
                                        color: Colors.white.withAlpha(200),
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      " • ",
                                      style: TextStyle(
                                        color: Colors.white.withAlpha(200),
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      "${((pageData["likes"] as int) / 1000).toStringAsFixed(1)}K likes",
                                      style: TextStyle(
                                        color: Colors.white.withAlpha(200),
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
                    ),
                  ],
                ),
              ),
              actions: [
                Icon(Icons.share),
                SizedBox(width: spSm),
                Icon(Icons.more_vert),
                SizedBox(width: spSm),
              ],
            ),
          ];
        },
        body: Column(
          children: [
            // Action Buttons
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: QButton(
                      label: isLiked ? "Liked" : "Like",
                      size: bs.sm,
                      onPressed: () {
                        isLiked = !isLiked;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QButton(
                      label: isFollowing ? "Following" : "Follow",
                      size: bs.sm,
                      onPressed: () {
                        isFollowing = !isFollowing;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    icon: Icons.message,
                    size: bs.sm,
                    onPressed: () {
                      // Message page
                    },
                  ),
                ],
              ),
            ),

            // Tab Content
            Expanded(
              child: QTabBar(
                withoutAppBar: true,
                selectedIndex: selectedTab,
                tabs: [
                  Tab(text: "Posts", icon: Icon(Icons.article)),
                  Tab(text: "About", icon: Icon(Icons.info)),
                  Tab(text: "Reviews", icon: Icon(Icons.star)),
                  Tab(text: "Team", icon: Icon(Icons.group)),
                ],
                tabChildren: [
                  _buildPostsTab(),
                  _buildAboutTab(),
                  _buildReviewsTab(),
                  _buildTeamTab(),
                ],
                onInit: (tabController) {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Write Post (if following)
          if (isFollowing)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  QTextField(
                    label: "Write something to this page",
                    value: newPost,
                    hint: "Share your thoughts...",
                    onChanged: (value) {
                      newPost = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Spacer(),
                      QButton(
                        label: "Post",
                        size: bs.sm,
                        onPressed: _createPost,
                      ),
                    ],
                  ),
                ],
              ),
            ),

          // Posts List
          ...posts.map((post) {
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
                  // Post Header
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage("${pageData["profileImage"]}"),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${pageData["name"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                if (pageData["verified"] as bool) ...[
                                  SizedBox(width: spXs),
                                  Icon(
                                    Icons.verified,
                                    color: successColor,
                                    size: 16,
                                  ),
                                ],
                              ],
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
                      Icon(
                        Icons.more_vert,
                        color: disabledBoldColor,
                        size: 20,
                      ),
                    ],
                  ),

                  SizedBox(height: spSm),

                  // Post Content
                  Text(
                    "${post["content"]}",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 14,
                    ),
                  ),

                  // Post Attachments
                  if ((post["attachments"] as List).isNotEmpty)
                    Column(
                      children: [
                        SizedBox(height: spSm),
                        Container(
                          height: 200,
                          child: QHorizontalScroll(
                            children: (post["attachments"] as List).map((attachment) {
                              return Container(
                                width: 300,
                                margin: EdgeInsets.only(right: spSm),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  child: Image.network(
                                    "$attachment",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),

                  SizedBox(height: spSm),

                  // Post Actions
                  Row(
                    children: [
                      _buildPostAction(
                        icon: post["isLiked"] as bool ? Icons.favorite : Icons.favorite_border,
                        label: "${post["likes"]}",
                        color: post["isLiked"] as bool ? dangerColor : disabledBoldColor,
                        onTap: () => _togglePostLike(post["id"]),
                      ),
                      SizedBox(width: spMd),
                      _buildPostAction(
                        icon: Icons.comment,
                        label: "${post["comments"]}",
                        color: disabledBoldColor,
                        onTap: () => _openComments(post["id"]),
                      ),
                      SizedBox(width: spMd),
                      _buildPostAction(
                        icon: Icons.share,
                        label: "${post["shares"]}",
                        color: disabledBoldColor,
                        onTap: () => _sharePost(post["id"]),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildAboutTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Description
          Container(
            width: double.infinity,
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
                  "About",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "${pageData["description"]}",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // Contact Information
          Container(
            width: double.infinity,
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
                  "Contact Information",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                _buildContactRow(Icons.web, "Website", "${pageData["website"]}"),
                _buildContactRow(Icons.phone, "Phone", "${pageData["phone"]}"),
                _buildContactRow(Icons.email, "Email", "${pageData["email"]}"),
                _buildContactRow(Icons.location_on, "Address", "${pageData["address"]}"),
              ],
            ),
          ),

          // Business Information
          Container(
            width: double.infinity,
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
                  "Business Information",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                _buildInfoRow("Founded", "${pageData["founded"]}"),
                _buildInfoRow("Employees", "${pageData["employees"]}"),
                _buildInfoRow("Category", "${pageData["category"]}"),
              ],
            ),
          ),

          // Services
          Container(
            width: double.infinity,
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
                  "Services",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: (pageData["services"] as List).map((service) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Text(
                        "$service",
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
          ),

          // Business Hours
          Container(
            width: double.infinity,
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
                  "Business Hours",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                ...(pageData["businessHours"] as Map<String, dynamic>).entries.map((entry) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: spXs),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 80,
                          child: Text(
                            "${entry.key.substring(0, 1).toUpperCase()}${entry.key.substring(1)}",
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          "${entry.value}",
                          style: TextStyle(
                            color: disabledBoldColor,
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
    );
  }

  Widget _buildReviewsTab() {
    double averageRating = reviews.fold(0.0, (sum, review) => sum + (review["rating"] as int)) / reviews.length;

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Rating Summary
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Column(
                  children: [
                    Text(
                      "${averageRating.toStringAsFixed(1)}",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < averageRating ? Icons.star : Icons.star_border,
                          color: warningColor,
                          size: 16,
                        );
                      }),
                    ),
                    Text(
                      "${reviews.length} reviews",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: QButton(
                    label: "Write a Review",
                    size: bs.sm,
                    onPressed: () {
                      // Write review
                    },
                  ),
                ),
              ],
            ),
          ),

          // Reviews List
          ...reviews.map((review) {
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
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage("${review["authorImage"]}"),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${review["author"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Row(
                              children: [
                                ...List.generate((review["rating"] as int), (index) {
                                  return Icon(
                                    Icons.star,
                                    color: warningColor,
                                    size: 14,
                                  );
                                }),
                                SizedBox(width: spXs),
                                Text(
                                  "${DateTime.parse(review["date"]).dMMMy}",
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
                    "${review["review"]}",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Icon(
                        Icons.thumb_up,
                        size: 16,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${review["helpful"]} found this helpful",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          // Mark as helpful
                        },
                        child: Text(
                          "Helpful",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildTeamTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Team Header
          Text(
            "Meet Our Team",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          // Team Members
          ResponsiveGridView(
            padding: EdgeInsets.all(0),
            minItemWidth: 200,
            children: team.map((member) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage("${member["image"]}"),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${member["name"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "${member["position"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "${member["experience"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                      textAlign: TextAlign.center,
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

  Widget _buildPostAction({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: color,
          ),
          SizedBox(width: spXs),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: disabledBoldColor,
          ),
          SizedBox(width: spSm),
          Text(
            "$label:",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: disabledBoldColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              "$label:",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: primaryColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: disabledBoldColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _createPost() {
    if (newPost.trim().isNotEmpty) {
      ss("Post created successfully!");
      newPost = "";
      setState(() {});
    }
  }

  void _togglePostLike(int postId) {
    int index = posts.indexWhere((post) => post["id"] == postId);
    if (index != -1) {
      posts[index]["isLiked"] = !(posts[index]["isLiked"] as bool);
      if (posts[index]["isLiked"] as bool) {
        posts[index]["likes"] = (posts[index]["likes"] as int) + 1;
      } else {
        posts[index]["likes"] = (posts[index]["likes"] as int) - 1;
      }
      setState(() {});
    }
  }

  void _openComments(int postId) {
    // Navigate to comments
  }

  void _sharePost(int postId) {
    ss("Post shared!");
  }
}
