import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaVideoSharingView extends StatefulWidget {
  const EmaVideoSharingView({super.key});

  @override
  State<EmaVideoSharingView> createState() => _EmaVideoSharingViewState();
}

class _EmaVideoSharingViewState extends State<EmaVideoSharingView> {
  int currentTab = 0;
  bool isRecording = false;
  bool isUploading = false;
  String selectedCategory = "Healthcare";
  String videoTitle = "";
  String videoDescription = "";
  String privacy = "Public";
  List<String> selectedTags = [];

  List<Map<String, dynamic>> videoCategories = [
    {"label": "Healthcare", "value": "Healthcare"},
    {"label": "Medical Research", "value": "Medical Research"},
    {"label": "Patient Care", "value": "Patient Care"},
    {"label": "Technology", "value": "Technology"},
    {"label": "Education", "value": "Education"},
    {"label": "Training", "value": "Training"},
  ];

  List<Map<String, dynamic>> privacyOptions = [
    {"label": "Public", "value": "Public"},
    {"label": "Unlisted", "value": "Unlisted"},
    {"label": "Private", "value": "Private"},
    {"label": "Healthcare Professionals Only", "value": "Healthcare Professionals Only"},
  ];

  List<Map<String, dynamic>> myVideos = [
    {
      "id": "video_001",
      "title": "AI-Powered Diagnostic Tools in Radiology",
      "thumbnail": "https://picsum.photos/300/170?random=1&keyword=medical",
      "duration": "12:45",
      "views": 15420,
      "likes": 892,
      "comments": 156,
      "uploadDate": "2024-03-15",
      "status": "Published",
      "privacy": "Public",
      "category": "Medical Research",
    },
    {
      "id": "video_002", 
      "title": "Machine Learning in Patient Monitoring Systems",
      "thumbnail": "https://picsum.photos/300/170?random=2&keyword=technology",
      "duration": "18:23",
      "views": 8230,
      "likes": 445,
      "comments": 78,
      "uploadDate": "2024-03-10",
      "status": "Published",
      "privacy": "Healthcare Professionals Only",
      "category": "Technology",
    },
    {
      "id": "video_003",
      "title": "Telemedicine Best Practices During Pandemic",
      "thumbnail": "https://picsum.photos/300/170?random=3&keyword=healthcare",
      "duration": "25:12",
      "views": 23100,
      "likes": 1340,
      "comments": 267,
      "uploadDate": "2024-03-05",
      "status": "Published", 
      "privacy": "Public",
      "category": "Patient Care",
    },
    {
      "id": "video_004",
      "title": "Electronic Health Records Implementation Guide",
      "thumbnail": "https://picsum.photos/300/170?random=4&keyword=medical",
      "duration": "15:30",
      "views": 5670,
      "likes": 234,
      "comments": 89,
      "uploadDate": "2024-02-28",
      "status": "Processing",
      "privacy": "Unlisted",
      "category": "Healthcare",
    },
  ];

  List<Map<String, dynamic>> sharedVideos = [
    {
      "id": "shared_001",
      "title": "Deep Learning Applications in Medical Imaging",
      "author": "Dr. Michael Chen",
      "authorAvatar": "https://picsum.photos/40/40?random=10&keyword=doctor",
      "thumbnail": "https://picsum.photos/300/170?random=10&keyword=medical",
      "duration": "22:15",
      "views": 45230,
      "likes": 2840,
      "comments": 456,
      "shareDate": "2024-03-16",
      "category": "Medical Research",
      "institution": "Stanford Medical Center",
    },
    {
      "id": "shared_002",
      "title": "Virtual Reality Therapy for PTSD Treatment",
      "author": "Dr. Sarah Williams",
      "authorAvatar": "https://picsum.photos/40/40?random=11&keyword=doctor", 
      "thumbnail": "https://picsum.photos/300/170?random=11&keyword=therapy",
      "duration": "16:45",
      "views": 18960,
      "likes": 1120,
      "comments": 198,
      "shareDate": "2024-03-14",
      "category": "Patient Care",
      "institution": "Mayo Clinic",
    },
    {
      "id": "shared_003",
      "title": "Blockchain Technology in Healthcare Data Security",
      "author": "Prof. James Rodriguez",
      "authorAvatar": "https://picsum.photos/40/40?random=12&keyword=professor",
      "thumbnail": "https://picsum.photos/300/170?random=12&keyword=technology",
      "duration": "28:30",
      "views": 12450,
      "likes": 789,
      "comments": 123,
      "shareDate": "2024-03-12",
      "category": "Technology",
      "institution": "MIT Technology Review",
    },
  ];

  void _startRecording() {
    isRecording = true;
    setState(() {});
    
    // Simulate recording for 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      isRecording = false;
      setState(() {});
      ss("Video recorded successfully!");
    });
  }

  void _uploadVideo() {
    if (videoTitle.isEmpty) {
      se("Please enter a video title");
      return;
    }
    
    isUploading = true;
    setState(() {});
    
    // Simulate upload process
    Future.delayed(Duration(seconds: 2), () {
      isUploading = false;
      videoTitle = "";
      videoDescription = "";
      selectedTags = [];
      setState(() {});
      ss("Video uploaded successfully!");
    });
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Video Sharing",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Share", icon: Icon(Icons.video_call)),
        Tab(text: "My Videos", icon: Icon(Icons.video_library)),
        Tab(text: "Shared", icon: Icon(Icons.share)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildShareTab(),
        _buildMyVideosTab(),
        _buildSharedTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildShareTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Record Video Section
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spLg),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.videocam,
                  size: 48,
                  color: Colors.white,
                ),
                SizedBox(height: spMd),
                Text(
                  "Share Medical Knowledge",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "Record and share educational videos with healthcare professionals worldwide",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withAlpha(220),
                  ),
                ),
                SizedBox(height: spLg),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: isRecording ? "Recording..." : "Start Recording",
                    icon: isRecording ? Icons.stop : Icons.play_circle,
                    size: bs.md,
                    onPressed: isRecording ? null : _startRecording,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: spLg),

          // Upload Form
          Text(
            "Upload Video",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),

          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spMd,
              children: [
                QTextField(
                  label: "Video Title",
                  value: videoTitle,
                  hint: "Enter descriptive title for your video",
                  onChanged: (value) {
                    videoTitle = value;
                    setState(() {});
                  },
                ),

                QMemoField(
                  label: "Description",
                  value: videoDescription,
                  hint: "Describe the content and learning objectives",
                  onChanged: (value) {
                    videoDescription = value;
                    setState(() {});
                  },
                ),

                QDropdownField(
                  label: "Category",
                  items: videoCategories,
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),

                QDropdownField(
                  label: "Privacy Setting",
                  items: privacyOptions,
                  value: privacy,
                  onChanged: (value, label) {
                    privacy = value;
                    setState(() {});
                  },
                ),

                Container(
                  width: double.infinity,
                  child: QButton(
                    label: isUploading ? "Uploading..." : "Upload Video",
                    icon: isUploading ? Icons.upload : Icons.cloud_upload,
                    size: bs.md,
                    onPressed: isUploading ? null : _uploadVideo,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: spLg),

          // Quick Actions
          Text(
            "Quick Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),

          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: successColor.withAlpha(50)),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.live_tv, color: successColor, size: 32),
                      SizedBox(height: spSm),
                      Text(
                        "Go Live",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(color: warningColor.withAlpha(50)),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.schedule, color: warningColor, size: 32),
                      SizedBox(height: spSm),
                      Text(
                        "Schedule",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMyVideosTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stats Summary
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.video_library, color: primaryColor, size: 24),
                        Spacer(),
                        Text(
                          "${myVideos.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Total Videos",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.visibility, color: successColor, size: 24),
                        Spacer(),
                        Text(
                          "${((myVideos.fold(0, (sum, video) => sum + (video["views"] as int))) / 1000).toInt()}K",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Total Views",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.thumb_up, color: infoColor, size: 24),
                        Spacer(),
                        Text(
                          "${((myVideos.fold(0, (sum, video) => sum + (video["likes"] as int))) / 1000).toInt()}K",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Total Likes",
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

          SizedBox(height: spLg),

          // Video List
          Text(
            "My Videos",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),

          ...myVideos.map((video) => Container(
            margin: EdgeInsets.only(bottom: spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Container(
                  width: 120,
                  height: 68,
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
                            color: Colors.black.withAlpha(180),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${video["duration"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
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
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: video["status"] == "Published" ? successColor.withAlpha(25) : warningColor.withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${video["status"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: video["status"] == "Published" ? successColor : warningColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "${video["privacy"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Icon(Icons.visibility, size: 12, color: disabledBoldColor),
                          SizedBox(width: spXs),
                          Text(
                            "${((video["views"] as int) / 1000).toStringAsFixed(1)}K",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Icon(Icons.thumb_up, size: 12, color: disabledBoldColor),
                          SizedBox(width: spXs),
                          Text(
                            "${video["likes"]}",
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
                GestureDetector(
                  onTap: () {
                    //navigateTo video details
                  },
                  child: Icon(
                    Icons.more_vert,
                    color: disabledBoldColor,
                    size: 20,
                  ),
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildSharedTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Shared with Healthcare Community",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),

          ...sharedVideos.map((video) => Container(
            margin: EdgeInsets.only(bottom: spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusMd),
                        image: DecorationImage(
                          image: NetworkImage("${video["authorAvatar"]}"),
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
                            "${video["author"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${video["institution"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "${video["shareDate"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Container(
                      width: 120,
                      height: 68,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusSm),
                        image: DecorationImage(
                          image: NetworkImage("${video["thumbnail"]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: Icon(
                              Icons.play_circle,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                          Positioned(
                            bottom: spXs,
                            right: spXs,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(180),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${video["duration"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
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
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${video["category"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: infoColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Icon(Icons.visibility, size: 12, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text(
                                "${((video["views"] as int) / 1000).toStringAsFixed(1)}K",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Icon(Icons.thumb_up, size: 12, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text(
                                "${((video["likes"] as int) / 1000).toStringAsFixed(1)}K",
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
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Overview Stats
          Text(
            "Analytics Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),

          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.trending_up, color: successColor, size: 24),
                        Spacer(),
                        Text(
                          "+15.2%",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "52.4K",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Total Views",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.access_time, color: warningColor, size: 24),
                        Spacer(),
                        Text(
                          "+8.7%",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "4.2m",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Watch Time",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.people, color: infoColor, size: 24),
                        Spacer(),
                        Text(
                          "+12.1%",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "1,847",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Subscribers",
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

          SizedBox(height: spLg),

          // Top Performing Videos
          Text(
            "Top Performing Videos",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),

          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spMd,
              children: [
                Row(
                  children: [
                    Text("Video", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: disabledBoldColor)),
                    Spacer(),
                    Text("Views", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: disabledBoldColor)),
                    SizedBox(width: spLg),
                    Text("Engagement", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: disabledBoldColor)),
                  ],
                ),
                Divider(color: disabledOutlineBorderColor),
                ...myVideos.take(3).map((video) => Row(
                  children: [
                    Container(
                      width: 40,
                      height: 24,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusXs),
                        image: DecorationImage(
                          image: NetworkImage("${video["thumbnail"]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Text(
                        "${video["title"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Text(
                      "${((video["views"] as int) / 1000).toStringAsFixed(1)}K",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    SizedBox(width: spLg),
                    Text(
                      "${(((video["likes"] as int) / (video["views"] as int)) * 100).toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                )).toList(),
              ],
            ),
          ),

          SizedBox(height: spLg),

          // Audience Insights
          Text(
            "Audience Insights",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),

          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Top Locations",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spMd),
                      Column(
                        spacing: spSm,
                        children: [
                          Row(
                            children: [
                              Text("United States", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                              Spacer(),
                              Text("34.2%", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: primaryColor)),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Canada", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                              Spacer(),
                              Text("18.7%", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: primaryColor)),
                            ],
                          ),
                          Row(
                            children: [
                              Text("United Kingdom", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                              Spacer(),
                              Text("12.9%", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: primaryColor)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Viewer Type",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spMd),
                      Column(
                        spacing: spSm,
                        children: [
                          Row(
                            children: [
                              Text("Healthcare Professionals", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                              Spacer(),
                              Text("67%", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: primaryColor)),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Medical Students", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                              Spacer(),
                              Text("24%", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: primaryColor)),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Researchers", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                              Spacer(),
                              Text("9%", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: primaryColor)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
