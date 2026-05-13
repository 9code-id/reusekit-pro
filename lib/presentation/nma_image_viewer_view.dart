import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaImageViewerView extends StatefulWidget {
  const NmaImageViewerView({super.key});

  @override
  State<NmaImageViewerView> createState() => _NmaImageViewerViewState();
}

class _NmaImageViewerViewState extends State<NmaImageViewerView> {
  int currentImageIndex = 0;
  bool isZoomed = false;
  bool showInfo = true;
  bool isFullscreen = false;
  double zoomLevel = 1.0;

  final List<Map<String, dynamic>> images = [
    {
      "id": "img_001",
      "url": "https://picsum.photos/800/600?random=1&landscape",
      "title": "Mountain Landscape",
      "description": "Beautiful mountain view captured during golden hour with dramatic clouds and pristine wilderness.",
      "photographer": "Sarah Johnson",
      "location": "Rocky Mountains, Colorado",
      "camera": "Canon EOS R5",
      "settings": "f/8, 1/125s, ISO 200",
      "date": "2024-01-15",
      "likes": 342,
      "comments": 28,
      "downloads": 156,
      "tags": ["landscape", "mountains", "nature", "golden hour", "wilderness"]
    },
    {
      "id": "img_002",
      "url": "https://picsum.photos/800/600?random=2&ocean",
      "title": "Ocean Waves",
      "description": "Powerful ocean waves crashing against rugged coastal rocks during a spectacular sunset.",
      "photographer": "Michael Chen",
      "location": "Big Sur, California",
      "camera": "Sony A7R IV",
      "settings": "f/11, 1/60s, ISO 100",
      "date": "2024-01-12",
      "likes": 589,
      "comments": 45,
      "downloads": 234,
      "tags": ["ocean", "waves", "sunset", "coastal", "seascape"]
    },
    {
      "id": "img_003",
      "url": "https://picsum.photos/800/600?random=3&forest",
      "title": "Forest Pathway",
      "description": "Mysterious forest path covered in morning mist with ancient trees creating a natural tunnel.",
      "photographer": "Emma Williams",
      "location": "Pacific Northwest",
      "camera": "Nikon Z9",
      "settings": "f/5.6, 1/80s, ISO 400",
      "date": "2024-01-10",
      "likes": 267,
      "comments": 19,
      "downloads": 98,
      "tags": ["forest", "path", "mist", "trees", "mysterious"]
    },
    {
      "id": "img_004",
      "url": "https://picsum.photos/800/600?random=4&city",
      "title": "City Skyline",
      "description": "Urban skyline at twilight with illuminated skyscrapers reflecting in the calm river below.",
      "photographer": "David Rodriguez",
      "location": "New York City",
      "camera": "Canon EOS R6",
      "settings": "f/9, 2s, ISO 100",
      "date": "2024-01-08",
      "likes": 445,
      "comments": 32,
      "downloads": 187,
      "tags": ["city", "skyline", "twilight", "urban", "reflection"]
    },
    {
      "id": "img_005",
      "url": "https://picsum.photos/800/600?random=5&desert",
      "title": "Desert Dunes",
      "description": "Flowing sand dunes creating mesmerizing patterns under the harsh desert sun.",
      "photographer": "Lisa Martinez",
      "location": "Sahara Desert, Morocco",
      "camera": "Fujifilm X-T5",
      "settings": "f/13, 1/200s, ISO 200",
      "date": "2024-01-05",
      "likes": 398,
      "comments": 23,
      "downloads": 145,
      "tags": ["desert", "dunes", "sand", "patterns", "minimalist"]
    }
  ];

  Map<String, dynamic> get currentImage => images[currentImageIndex];

  void _previousImage() {
    if (currentImageIndex > 0) {
      currentImageIndex--;
      setState(() {});
    }
  }

  void _nextImage() {
    if (currentImageIndex < images.length - 1) {
      currentImageIndex++;
      setState(() {});
    }
  }

  void _toggleZoom() {
    isZoomed = !isZoomed;
    zoomLevel = isZoomed ? 2.0 : 1.0;
    setState(() {});
  }

  void _toggleInfo() {
    showInfo = !showInfo;
    setState(() {});
  }

  void _toggleFullscreen() {
    isFullscreen = !isFullscreen;
    setState(() {});
  }

  Widget _buildImageControls() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(150),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: IconButton(
              onPressed: currentImageIndex > 0 ? _previousImage : null,
              icon: Icon(
                Icons.arrow_back_ios,
                color: currentImageIndex > 0 ? Colors.white : Colors.grey,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(150),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: IconButton(
              onPressed: _toggleZoom,
              icon: Icon(
                isZoomed ? Icons.zoom_out : Icons.zoom_in,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(150),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: IconButton(
              onPressed: _toggleInfo,
              icon: Icon(
                showInfo ? Icons.info : Icons.info_outline,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(150),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: IconButton(
              onPressed: _toggleFullscreen,
              icon: Icon(
                isFullscreen ? Icons.fullscreen_exit : Icons.fullscreen,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(150),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: IconButton(
              onPressed: currentImageIndex < images.length - 1 ? _nextImage : null,
              icon: Icon(
                Icons.arrow_forward_ios,
                color: currentImageIndex < images.length - 1 ? Colors.white : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageInfo() {
    if (!showInfo) return SizedBox.shrink();

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.black.withAlpha(180),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "${currentImage["title"]}",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "${currentImage["description"]}",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              height: 1.4,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Icon(Icons.person, color: Colors.white, size: 16),
              SizedBox(width: spXs),
              Text(
                "${currentImage["photographer"]}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: spMd),
              Icon(Icons.location_on, color: Colors.white, size: 16),
              SizedBox(width: spXs),
              Text(
                "${currentImage["location"]}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.camera_alt, color: Colors.white, size: 16),
              SizedBox(width: spXs),
              Text(
                "${currentImage["camera"]} • ${currentImage["settings"]}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.favorite, color: Colors.red, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "${currentImage["likes"]}",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spSm),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.comment, color: Colors.blue, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "${currentImage["comments"]}",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spSm),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.download, color: Colors.green, size: 16),
                    SizedBox(width: spXs),
                    Text(
                      "${currentImage["downloads"]}",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildThumbnails() {
    return Container(
      height: 80,
      padding: EdgeInsets.symmetric(horizontal: spMd),
      child: QHorizontalScroll(
        children: images.asMap().entries.map((entry) {
          final index = entry.key;
          final image = entry.value;
          final isSelected = index == currentImageIndex;
          
          return GestureDetector(
            onTap: () {
              currentImageIndex = index;
              setState(() {});
            },
            child: Container(
              width: 80,
              margin: EdgeInsets.only(right: spSm),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: isSelected ? primaryColor : Colors.transparent,
                  width: 3,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${image["url"]}",
                  fit: BoxFit.cover,
                  width: 80,
                  height: 80,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTagsSection() {
    return Container(
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
            "Tags",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Wrap(
            spacing: spSm,
            runSpacing: spSm,
            children: (currentImage["tags"] as List).map((tag) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "#${tag}",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 14,
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

  Widget _buildActionButtons() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Row(
        children: [
          Expanded(
            child: QButton(
              label: "Like",
              icon: Icons.favorite_border,
              size: bs.md,
              onPressed: () {
                ss("Image liked!");
              },
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: QButton(
              label: "Share",
              icon: Icons.share,
              size: bs.md,
              onPressed: () {
                ss("Share feature coming soon");
              },
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: QButton(
              label: "Download",
              icon: Icons.download,
              size: bs.md,
              onPressed: () {
                ss("Download started");
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isFullscreen) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Center(
              child: InteractiveViewer(
                minScale: 1.0,
                maxScale: 4.0,
                child: Image.network(
                  "${currentImage["url"]}",
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  Expanded(child: SizedBox()),
                  _buildImageControls(),
                ],
              ),
            ),
            if (showInfo)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SafeArea(child: _buildImageInfo()),
              ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Image Viewer"),
        actions: [
          IconButton(
            onPressed: () {
              ss("Added to favorites");
            },
            icon: Icon(Icons.favorite_border),
          ),
          IconButton(
            onPressed: () {
              ss("More options coming soon");
            },
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.black,
              child: Stack(
                children: [
                  Center(
                    child: InteractiveViewer(
                      minScale: 1.0,
                      maxScale: 3.0,
                      child: Image.network(
                        "${currentImage["url"]}",
                        fit: BoxFit.contain,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Positioned(
                    top: spMd,
                    left: spMd,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(150),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${currentImageIndex + 1} / ${images.length}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: _buildImageControls(),
                  ),
                ],
              ),
            ),
          ),
          
          Container(
            color: Colors.grey.shade100,
            child: Column(
              children: [
                SizedBox(height: spMd),
                _buildThumbnails(),
                SizedBox(height: spMd),
              ],
            ),
          ),
          
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spMd,
                children: [
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
                          "${currentImage["title"]}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${currentImage["description"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            height: 1.4,
                          ),
                        ),
                        SizedBox(height: spMd),
                        Row(
                          children: [
                            Icon(Icons.person, color: disabledBoldColor, size: 16),
                            SizedBox(width: spXs),
                            Text(
                              "${currentImage["photographer"]}",
                              style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: spMd),
                            Icon(Icons.calendar_today, color: disabledBoldColor, size: 16),
                            SizedBox(width: spXs),
                            Text(
                              "${currentImage["date"]}",
                              style: TextStyle(color: disabledBoldColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  _buildTagsSection(),
                  _buildActionButtons(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
