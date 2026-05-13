import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaPhotoViewerView extends StatefulWidget {
  const PpaPhotoViewerView({super.key});

  @override
  State<PpaPhotoViewerView> createState() => _PpaPhotoViewerViewState();
}

class _PpaPhotoViewerViewState extends State<PpaPhotoViewerView> {
  int currentPhotoIndex = 0;
  bool showControls = true;
  bool isFavorite = false;
  bool isZoomed = false;
  double zoomLevel = 1.0;
  bool showInfo = false;
  
  List<Map<String, dynamic>> photos = [
    {
      "id": "1",
      "url": "https://picsum.photos/800/600?random=1&keyword=landscape",
      "title": "Mountain Landscape",
      "description": "A breathtaking view of snow-capped mountains during golden hour",
      "date": "2024-03-15 14:30",
      "location": "Swiss Alps, Switzerland",
      "camera": "Canon EOS R5",
      "lens": "24-70mm f/2.8",
      "settings": "ISO 100, f/8, 1/250s",
      "size": "2.3 MB",
      "resolution": "1920x1080",
      "favorite": true,
      "tags": ["landscape", "mountain", "nature", "golden hour"]
    },
    {
      "id": "2",
      "url": "https://picsum.photos/800/600?random=2&keyword=sunset",
      "title": "Ocean Sunset",
      "description": "Peaceful sunset over calm ocean waters with gentle waves",
      "date": "2024-03-14 18:45",
      "location": "Maldives",
      "camera": "Sony A7R IV",
      "lens": "16-35mm f/2.8",
      "settings": "ISO 200, f/11, 1/60s",
      "size": "1.8 MB",
      "resolution": "1920x1080",
      "favorite": false,
      "tags": ["sunset", "ocean", "seascape", "peaceful"]
    },
    {
      "id": "3",
      "url": "https://picsum.photos/800/600?random=3&keyword=forest",
      "title": "Autumn Forest",
      "description": "Mystical forest path surrounded by colorful autumn leaves",
      "date": "2024-03-13 11:20",
      "location": "Black Forest, Germany",
      "camera": "Nikon D850",
      "lens": "85mm f/1.4",
      "settings": "ISO 400, f/5.6, 1/125s",
      "size": "2.1 MB",
      "resolution": "1920x1080",
      "favorite": true,
      "tags": ["forest", "autumn", "path", "nature"]
    },
    {
      "id": "4",
      "url": "https://picsum.photos/800/600?random=4&keyword=architecture",
      "title": "Modern Architecture",
      "description": "Contemporary building with unique geometric design",
      "date": "2024-03-12 09:15",
      "location": "Tokyo, Japan",
      "camera": "Fuji X-T4",
      "lens": "10-24mm f/4",
      "settings": "ISO 100, f/8, 1/200s",
      "size": "2.7 MB",
      "resolution": "1920x1080",
      "favorite": false,
      "tags": ["architecture", "modern", "building", "geometric"]
    },
    {
      "id": "5",
      "url": "https://picsum.photos/800/600?random=5&keyword=city",
      "title": "City Lights",
      "description": "Vibrant city skyline illuminated at night",
      "date": "2024-03-11 20:00",
      "location": "New York City, USA",
      "camera": "Canon EOS R6",
      "lens": "70-200mm f/2.8",
      "settings": "ISO 800, f/4, 1/30s",
      "size": "1.9 MB",
      "resolution": "1920x1080",
      "favorite": true,
      "tags": ["city", "night", "lights", "skyline"]
    }
  ];

  @override
  void initState() {
    super.initState();
    isFavorite = photos[currentPhotoIndex]["favorite"];
  }

  @override
  Widget build(BuildContext context) {
    final currentPhoto = photos[currentPhotoIndex];
    
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          showControls = !showControls;
          setState(() {});
        },
        child: Stack(
          children: [
            // Main Photo Display
            Center(
              child: InteractiveViewer(
                minScale: 0.5,
                maxScale: 5.0,
                onInteractionStart: (details) {
                  showControls = false;
                  setState(() {});
                },
                onInteractionEnd: (details) {
                  showControls = true;
                  setState(() {});
                },
                onInteractionUpdate: (details) {
                  zoomLevel = details.scale;
                  isZoomed = zoomLevel > 1.0;
                  setState(() {});
                },
                child: Image.network(
                  "${currentPhoto["url"]}",
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: double.infinity,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded / 
                                  loadingProgress.expectedTotalBytes!
                                : null,
                            color: Colors.white,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Loading...",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),

            // Top Controls
            if (showControls && !isZoomed)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + spSm,
                    left: spMd,
                    right: spMd,
                    bottom: spMd,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withAlpha(200),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => back(),
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(150),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${currentPhoto["title"]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${currentPhotoIndex + 1} of ${photos.length}",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              isFavorite = !isFavorite;
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(150),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                isFavorite ? Icons.favorite : Icons.favorite_border,
                                color: isFavorite ? Colors.red : Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                          SizedBox(width: spXs),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(150),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                Icons.share,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                          SizedBox(width: spXs),
                          GestureDetector(
                            onTap: () {
                              showInfo = !showInfo;
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: showInfo ? primaryColor : Colors.black.withAlpha(150),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                Icons.info,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                          SizedBox(width: spXs),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(150),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                Icons.more_vert,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

            // Bottom Controls
            if (showControls && !isZoomed)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.only(
                    left: spMd,
                    right: spMd,
                    top: spMd,
                    bottom: MediaQuery.of(context).padding.bottom + spMd,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withAlpha(200),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Photo Thumbnails
                      Container(
                        height: 60,
                        child: QHorizontalScroll(
                          children: List.generate(photos.length, (index) {
                            final photo = photos[index];
                            final isSelected = index == currentPhotoIndex;
                            return GestureDetector(
                              onTap: () {
                                currentPhotoIndex = index;
                                isFavorite = photos[currentPhotoIndex]["favorite"];
                                setState(() {});
                              },
                              child: Container(
                                width: 60,
                                height: 60,
                                margin: EdgeInsets.only(
                                  right: index < photos.length - 1 ? spXs : 0,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  border: Border.all(
                                    color: isSelected ? Colors.white : Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  child: Image.network(
                                    "${photo["url"]}",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      
                      SizedBox(height: spSm),
                      
                      // Navigation Controls
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: currentPhotoIndex > 0 ? () {
                              currentPhotoIndex--;
                              isFavorite = photos[currentPhotoIndex]["favorite"];
                              setState(() {});
                            } : null,
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(150),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                Icons.skip_previous,
                                color: currentPhotoIndex > 0 ? Colors.white : Colors.white38,
                                size: 24,
                              ),
                            ),
                          ),
                          
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(150),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                Icons.slideshow,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                          
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(150),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                          
                          GestureDetector(
                            onTap: currentPhotoIndex < photos.length - 1 ? () {
                              currentPhotoIndex++;
                              isFavorite = photos[currentPhotoIndex]["favorite"];
                              setState(() {});
                            } : null,
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(150),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                Icons.skip_next,
                                color: currentPhotoIndex < photos.length - 1 ? Colors.white : Colors.white38,
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

            // Photo Information Panel
            if (showInfo)
              Positioned(
                right: 0,
                top: 100,
                bottom: 100,
                width: 300,
                child: Container(
                  margin: EdgeInsets.all(spMd),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(220),
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowLg],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Photo Details",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showInfo = false;
                                setState(() {});
                              },
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: spMd),
                        
                        _buildInfoItem("Title", "${currentPhoto["title"]}"),
                        _buildInfoItem("Description", "${currentPhoto["description"]}"),
                        _buildInfoItem("Date", "${currentPhoto["date"]}"),
                        _buildInfoItem("Location", "${currentPhoto["location"]}"),
                        _buildInfoItem("Camera", "${currentPhoto["camera"]}"),
                        _buildInfoItem("Lens", "${currentPhoto["lens"]}"),
                        _buildInfoItem("Settings", "${currentPhoto["settings"]}"),
                        _buildInfoItem("Size", "${currentPhoto["size"]}"),
                        _buildInfoItem("Resolution", "${currentPhoto["resolution"]}"),
                        
                        SizedBox(height: spMd),
                        
                        Text(
                          "Tags",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Wrap(
                          spacing: spXs,
                          runSpacing: spXs,
                          children: (currentPhoto["tags"] as List).map((tag) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(150),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "#$tag",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            // Swipe Areas for Navigation
            Positioned(
              left: 0,
              top: 100,
              bottom: 100,
              width: 80,
              child: GestureDetector(
                onTap: currentPhotoIndex > 0 ? () {
                  currentPhotoIndex--;
                  isFavorite = photos[currentPhotoIndex]["favorite"];
                  setState(() {});
                } : null,
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
            
            Positioned(
              right: showInfo ? 320 : 0,
              top: 100,
              bottom: 100,
              width: 80,
              child: GestureDetector(
                onTap: currentPhotoIndex < photos.length - 1 ? () {
                  currentPhotoIndex++;
                  isFavorite = photos[currentPhotoIndex]["favorite"];
                  setState(() {});
                } : null,
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
            
            // Zoom Level Indicator
            if (isZoomed)
              Positioned(
                top: MediaQuery.of(context).padding.top + spMd,
                right: spMd,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spSm,
                    vertical: spXs,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(150),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${(zoomLevel * 100).round()}%",
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
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
