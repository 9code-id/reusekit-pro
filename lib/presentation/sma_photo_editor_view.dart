import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaPhotoEditorView extends StatefulWidget {
  const SmaPhotoEditorView({super.key});

  @override
  State<SmaPhotoEditorView> createState() => _SmaPhotoEditorViewState();
}

class _SmaPhotoEditorViewState extends State<SmaPhotoEditorView> {
  int currentTab = 0;
  String selectedImage = "https://picsum.photos/400/600?random=1";
  double brightness = 0.0;
  double contrast = 0.0;
  double saturation = 0.0;
  double blur = 0.0;
  double sharpen = 0.0;
  String selectedFilter = "None";

  final List<Map<String, dynamic>> filters = [
    {"name": "None", "preview": "https://picsum.photos/80/80?random=1"},
    {"name": "Vintage", "preview": "https://picsum.photos/80/80?random=2&sepia"},
    {"name": "B&W", "preview": "https://picsum.photos/80/80?random=3&grayscale"},
    {"name": "Cool", "preview": "https://picsum.photos/80/80?random=4&blue"},
    {"name": "Warm", "preview": "https://picsum.photos/80/80?random=5&orange"},
    {"name": "Dramatic", "preview": "https://picsum.photos/80/80?random=6&dark"},
    {"name": "Bright", "preview": "https://picsum.photos/80/80?random=7&light"},
    {"name": "Soft", "preview": "https://picsum.photos/80/80?random=8&pastel"},
  ];

  final List<Map<String, dynamic>> tools = [
    {"name": "Crop", "icon": Icons.crop, "color": Colors.blue},
    {"name": "Rotate", "icon": Icons.rotate_right, "color": Colors.green},
    {"name": "Flip", "icon": Icons.flip, "color": Colors.orange},
    {"name": "Text", "icon": Icons.text_fields, "color": Colors.purple},
    {"name": "Stickers", "icon": Icons.emoji_emotions, "color": Colors.pink},
    {"name": "Draw", "icon": Icons.brush, "color": Colors.red},
    {"name": "Blur", "icon": Icons.blur_on, "color": Colors.indigo},
    {"name": "Focus", "icon": Icons.center_focus_strong, "color": Colors.teal},
  ];

  final List<String> recentPhotos = [
    "https://picsum.photos/300/400?random=10",
    "https://picsum.photos/300/400?random=11",
    "https://picsum.photos/300/400?random=12",
    "https://picsum.photos/300/400?random=13",
    "https://picsum.photos/300/400?random=14",
    "https://picsum.photos/300/400?random=15",
    "https://picsum.photos/300/400?random=16",
    "https://picsum.photos/300/400?random=17",
  ];

  Widget _buildEditorTab() {
    return Column(
      children: [
        // Photo Preview Section
        Expanded(
          flex: 3,
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radiusLg),
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Image.network(
                      selectedImage,
                      fit: BoxFit.contain,
                    ),
                  ),
                  // Overlay effects preview
                  if (selectedFilter != "None")
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: selectedFilter == "B&W" ? Colors.grey.withAlpha(50) :
                               selectedFilter == "Vintage" ? Colors.brown.withAlpha(30) :
                               selectedFilter == "Cool" ? Colors.blue.withAlpha(20) :
                               selectedFilter == "Warm" ? Colors.orange.withAlpha(20) :
                               Colors.transparent,
                      ),
                    ),
                  
                  // Top Controls
                  Positioned(
                    top: spMd,
                    left: spMd,
                    right: spMd,
                    child: Row(
                      children: [
                        QButton(
                          icon: Icons.arrow_back,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                        Spacer(),
                        QButton(
                          icon: Icons.undo,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.redo,
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  
                  // Bottom Action Bar
                  Positioned(
                    bottom: spMd,
                    left: spMd,
                    right: spMd,
                    child: Container(
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(180),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          QButton(
                            icon: Icons.photo_library,
                            size: bs.sm,
                            onPressed: () {},
                          ),
                          QButton(
                            icon: Icons.camera_alt,
                            size: bs.sm,
                            onPressed: () {},
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: Text(
                              "Save",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          QButton(
                            icon: Icons.share,
                            size: bs.sm,
                            onPressed: () {},
                          ),
                          QButton(
                            icon: Icons.more_vert,
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        
        // Tools Section
        Container(
          height: 120,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: Row(
              children: tools.map((tool) {
                return Container(
                  width: 80,
                  margin: EdgeInsets.only(right: spSm),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: (tool["color"] as Color).withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(
                            color: (tool["color"] as Color),
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          tool["icon"] as IconData,
                          color: tool["color"] as Color,
                          size: 24,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${tool["name"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFiltersTab() {
    return Column(
      children: [
        // Photo Preview
        Expanded(
          flex: 2,
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radiusLg),
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Image.network(
                      selectedImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                  if (selectedFilter != "None")
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: selectedFilter == "B&W" ? Colors.grey.withAlpha(100) :
                               selectedFilter == "Vintage" ? Colors.brown.withAlpha(50) :
                               selectedFilter == "Cool" ? Colors.blue.withAlpha(40) :
                               selectedFilter == "Warm" ? Colors.orange.withAlpha(40) :
                               selectedFilter == "Dramatic" ? Colors.black.withAlpha(60) :
                               selectedFilter == "Bright" ? Colors.white.withAlpha(30) :
                               selectedFilter == "Soft" ? Colors.pink.withAlpha(20) :
                               Colors.transparent,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        
        // Filter Selection
        Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Filters",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              Container(
                height: 100,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: filters.map((filter) {
                      final isSelected = selectedFilter == filter["name"];
                      return GestureDetector(
                        onTap: () {
                          selectedFilter = filter["name"];
                          setState(() {});
                        },
                        child: Container(
                          width: 70,
                          margin: EdgeInsets.only(right: spSm),
                          child: Column(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  border: Border.all(
                                    color: isSelected ? primaryColor : Colors.grey.shade300,
                                    width: isSelected ? 3 : 1,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  child: Image.network(
                                    "${filter["preview"]}",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${filter["name"]}",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                  color: isSelected ? primaryColor : disabledBoldColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAdjustTab() {
    return Column(
      children: [
        // Photo Preview
        Expanded(
          flex: 2,
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radiusLg),
              child: Image.network(
                selectedImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        
        // Adjustment Controls
        Expanded(
          flex: 1,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              spacing: spMd,
              children: [
                // Brightness
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.brightness_6, color: primaryColor),
                          SizedBox(width: spSm),
                          Text(
                            "Brightness",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${brightness.toInt()}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Slider(
                        value: brightness,
                        min: -100,
                        max: 100,
                        divisions: 200,
                        activeColor: primaryColor,
                        onChanged: (value) {
                          brightness = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
                
                // Contrast
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.contrast, color: primaryColor),
                          SizedBox(width: spSm),
                          Text(
                            "Contrast",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${contrast.toInt()}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Slider(
                        value: contrast,
                        min: -100,
                        max: 100,
                        divisions: 200,
                        activeColor: primaryColor,
                        onChanged: (value) {
                          contrast = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
                
                // Saturation
                Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.palette, color: primaryColor),
                          SizedBox(width: spSm),
                          Text(
                            "Saturation",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${saturation.toInt()}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Slider(
                        value: saturation,
                        min: -100,
                        max: 100,
                        divisions: 200,
                        activeColor: primaryColor,
                        onChanged: (value) {
                          saturation = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
                
                // Quick Reset Button
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Reset All",
                    size: bs.sm,
                    onPressed: () {
                      brightness = 0.0;
                      contrast = 0.0;
                      saturation = 0.0;
                      blur = 0.0;
                      sharpen = 0.0;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGalleryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Upload Options
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor.withAlpha(20), Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(color: primaryColor.withAlpha(50)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.cloud_upload, color: primaryColor, size: 32),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Upload New Photo",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Select from gallery or take a new photo",
                            style: TextStyle(
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Gallery",
                        icon: Icons.photo_library,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Camera",
                        icon: Icons.camera_alt,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Recent Photos
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Recent Photos",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "View All",
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                ResponsiveGridView(
                  minItemWidth: 150,
                  children: recentPhotos.map((photo) {
                    return GestureDetector(
                      onTap: () {
                        selectedImage = photo;
                        currentTab = 0; // Switch to editor tab
                        setState(() {});
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowSm],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(radiusLg),
                          child: Stack(
                            children: [
                              AspectRatio(
                                aspectRatio: 3/4,
                                child: Image.network(
                                  photo,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: spSm,
                                right: spSm,
                                child: Container(
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withAlpha(128),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          
          // Popular Templates
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Popular Templates",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                Container(
                  height: 120,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        "Instagram Story",
                        "Instagram Post",
                        "Facebook Cover",
                        "Twitter Header",
                        "YouTube Thumbnail",
                        "Business Card",
                      ].map((template) {
                        return Container(
                          width: 100,
                          margin: EdgeInsets.only(right: spSm),
                          child: Column(
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [primaryColor.withAlpha(100), primaryColor.withAlpha(50)],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(radiusLg),
                                  border: Border.all(color: primaryColor.withAlpha(100)),
                                ),
                                child: Icon(
                                  Icons.image,
                                  color: primaryColor,
                                  size: 32,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                template,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Photo Editor",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Editor", icon: Icon(Icons.edit)),
        Tab(text: "Filters", icon: Icon(Icons.filter)),
        Tab(text: "Adjust", icon: Icon(Icons.tune)),
        Tab(text: "Gallery", icon: Icon(Icons.photo_library)),
      ],
      tabChildren: [
        _buildEditorTab(),
        _buildFiltersTab(),
        _buildAdjustTab(),
        _buildGalleryTab(),
      ],
    );
  }
}
