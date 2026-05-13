import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaProductGalleryView extends StatefulWidget {
  const SpaProductGalleryView({super.key});

  @override
  State<SpaProductGalleryView> createState() => _SpaProductGalleryViewState();
}

class _SpaProductGalleryViewState extends State<SpaProductGalleryView> {
  int currentImageIndex = 0;
  String selectedCategory = "all";
  bool isFullscreen = false;

  List<Map<String, dynamic>> galleryImages = [
    {
      "id": 1,
      "url": "https://picsum.photos/800/600?random=1&keyword=spa-massage",
      "title": "Relaxing Massage Room",
      "category": "rooms",
      "description": "Serene massage room with ambient lighting and comfortable tables",
      "tags": ["massage", "relaxation", "private"],
      "featured": true,
    },
    {
      "id": 2,
      "url": "https://picsum.photos/800/600?random=2&keyword=spa-facial",
      "title": "Luxury Facial Suite",
      "category": "rooms",
      "description": "State-of-the-art facial treatment room with premium equipment",
      "tags": ["facial", "luxury", "treatment"],
      "featured": true,
    },
    {
      "id": 3,
      "url": "https://picsum.photos/800/600?random=3&keyword=spa-sauna",
      "title": "Traditional Finnish Sauna",
      "category": "facilities",
      "description": "Authentic cedar sauna with temperature control and aromatherapy",
      "tags": ["sauna", "detox", "wellness"],
      "featured": false,
    },
    {
      "id": 4,
      "url": "https://picsum.photos/800/600?random=4&keyword=spa-pool",
      "title": "Vitality Pool",
      "category": "facilities",
      "description": "Heated mineral pool with hydrotherapy jets",
      "tags": ["pool", "hydrotherapy", "mineral"],
      "featured": true,
    },
    {
      "id": 5,
      "url": "https://picsum.photos/800/600?random=5&keyword=spa-products",
      "title": "Premium Skincare Products",
      "category": "products",
      "description": "Organic and natural skincare products used in our treatments",
      "tags": ["organic", "skincare", "natural"],
      "featured": false,
    },
    {
      "id": 6,
      "url": "https://picsum.photos/800/600?random=6&keyword=spa-treatment",
      "title": "Hot Stone Therapy",
      "category": "treatments",
      "description": "Therapeutic hot stone massage for deep muscle relaxation",
      "tags": ["hot-stone", "therapy", "muscle"],
      "featured": true,
    },
    {
      "id": 7,
      "url": "https://picsum.photos/800/600?random=7&keyword=spa-reception",
      "title": "Elegant Reception Area",
      "category": "facilities",
      "description": "Welcoming reception with comfortable seating and tea service",
      "tags": ["reception", "comfort", "service"],
      "featured": false,
    },
    {
      "id": 8,
      "url": "https://picsum.photos/800/600?random=8&keyword=spa-oils",
      "title": "Essential Oil Collection",
      "category": "products",
      "description": "Pure essential oils for aromatherapy and massage treatments",
      "tags": ["essential-oils", "aromatherapy", "pure"],
      "featured": false,
    },
    {
      "id": 9,
      "url": "https://picsum.photos/800/600?random=9&keyword=spa-yoga",
      "title": "Tranquil Yoga Studio",
      "category": "facilities",
      "description": "Peaceful space for yoga classes and meditation sessions",
      "tags": ["yoga", "meditation", "peaceful"],
      "featured": true,
    },
    {
      "id": 10,
      "url": "https://picsum.photos/800/600?random=10&keyword=spa-couples",
      "title": "Couples Treatment Room",
      "category": "rooms",
      "description": "Intimate space designed for couples spa experiences",
      "tags": ["couples", "intimate", "romantic"],
      "featured": true,
    },
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Photos", "value": "all", "icon": Icons.photo_library},
    {"label": "Treatment Rooms", "value": "rooms", "icon": Icons.hotel},
    {"label": "Spa Facilities", "value": "facilities", "icon": Icons.spa},
    {"label": "Treatments", "value": "treatments", "icon": Icons.healing},
    {"label": "Products", "value": "products", "icon": Icons.shopping_bag},
  ];

  @override
  Widget build(BuildContext context) {
    if (isFullscreen) {
      return _buildFullscreenGallery();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Photo Gallery"),
        actions: [
          QButton(
            icon: Icons.grid_view,
            size: bs.sm,
            onPressed: () {
              _toggleViewMode();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Gallery Header
          _buildGalleryHeader(),

          // Category Filter
          _buildCategoryFilter(),

          // Main Gallery
          Expanded(
            child: _buildPhotoGrid(),
          ),
        ],
      ),
    );
  }

  Widget _buildGalleryHeader() {
    final filteredImages = _getFilteredImages();
    final featuredCount = filteredImages.where((img) => img["featured"]).length;
    
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
              Icon(Icons.photo_camera, color: Colors.white, size: 28),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Spa Photo Gallery",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Explore our beautiful facilities and treatments",
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
          
          // Gallery Stats
          Row(
            children: [
              _buildStatItem("${filteredImages.length}", "Total Photos", Icons.photo),
              SizedBox(width: spMd),
              _buildStatItem("$featuredCount", "Featured", Icons.star),
              SizedBox(width: spMd),
              _buildStatItem("${categoryOptions.length - 1}", "Categories", Icons.category),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(51),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: Colors.white.withAlpha(100),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 16),
          SizedBox(width: spXs),
          Column(
            children: [
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
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: spSm),
      color: Colors.grey[50],
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: spMd),
        child: Row(
          children: categoryOptions.map((category) {
            bool isSelected = selectedCategory == category["value"];
            final filteredCount = selectedCategory == "all" 
                ? galleryImages.length 
                : galleryImages.where((img) => img["category"] == category["value"]).length;
            
            return GestureDetector(
              onTap: () {
                selectedCategory = category["value"];
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
                      category["icon"] as IconData,
                      color: isSelected ? Colors.white : disabledBoldColor,
                      size: 18,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${category["label"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : disabledBoldColor,
                      ),
                    ),
                    if (category["value"] == selectedCategory) ...[
                      SizedBox(width: spXs),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(100),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "$filteredCount",
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

  Widget _buildPhotoGrid() {
    final filteredImages = _getFilteredImages();
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: ResponsiveGridView(
        padding: EdgeInsets.zero,
        minItemWidth: 280,
        children: filteredImages.map((image) {
          return _buildPhotoCard(image);
        }).toList(),
      ),
    );
  }

  Widget _buildPhotoCard(Map<String, dynamic> image) {
    return GestureDetector(
      onTap: () {
        currentImageIndex = galleryImages.indexWhere((img) => img["id"] == image["id"]);
        isFullscreen = true;
        setState(() {});
      },
      child: Container(
        margin: EdgeInsets.only(bottom: spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                  child: Image.network(
                    "${image["url"]}",
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),

                // Featured Badge
                if (image["featured"])
                  Positioned(
                    top: spSm,
                    left: spSm,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: warningColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star, color: Colors.white, size: 12),
                          SizedBox(width: spXs),
                          Text(
                            "Featured",
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

                // Zoom Icon
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
                      Icons.zoom_in,
                      color: Colors.white,
                      size: 20,
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
                  // Title and Category
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${image["title"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${image["category"].toString().toUpperCase()}",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Description
                  Text(
                    "${image["description"]}",
                    style: TextStyle(
                      fontSize: 13,
                      color: disabledBoldColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  // Tags
                  Wrap(
                    spacing: spXs,
                    runSpacing: spXs,
                    children: (image["tags"] as List<String>).map((tag) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "#$tag",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "View Full",
                          size: bs.sm,
                          onPressed: () {
                            currentImageIndex = galleryImages.indexWhere((img) => img["id"] == image["id"]);
                            isFullscreen = true;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.share,
                        size: bs.sm,
                        onPressed: () {
                          _shareImage(image);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFullscreenGallery() {
    final currentImage = galleryImages[currentImageIndex];
    
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Full Image
          Center(
            child: InteractiveViewer(
              child: Image.network(
                "${currentImage["url"]}",
                fit: BoxFit.contain,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),

          // Top Controls
          Positioned(
            top: MediaQuery.of(context).padding.top,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withAlpha(128), Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Row(
                children: [
                  QButton(
                    icon: Icons.close,
                    size: bs.sm,
                    onPressed: () {
                      isFullscreen = false;
                      setState(() {});
                    },
                  ),
                  Spacer(),
                  Text(
                    "${currentImageIndex + 1} / ${galleryImages.length}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  QButton(
                    icon: Icons.share,
                    size: bs.sm,
                    onPressed: () {
                      _shareImage(currentImage);
                    },
                  ),
                ],
              ),
            ),
          ),

          // Bottom Info
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.black.withAlpha(180)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${currentImage["title"]}",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${currentImage["description"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withAlpha(200),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Navigation Arrows
          if (currentImageIndex > 0)
            Positioned(
              left: spMd,
              top: 0,
              bottom: 0,
              child: Center(
                child: QButton(
                  icon: Icons.chevron_left,
                  size: bs.sm,
                  onPressed: () {
                    currentImageIndex--;
                    setState(() {});
                  },
                ),
              ),
            ),

          if (currentImageIndex < galleryImages.length - 1)
            Positioned(
              right: spMd,
              top: 0,
              bottom: 0,
              child: Center(
                child: QButton(
                  icon: Icons.chevron_right,
                  size: bs.sm,
                  onPressed: () {
                    currentImageIndex++;
                    setState(() {});
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredImages() {
    if (selectedCategory == "all") {
      return galleryImages;
    }
    return galleryImages.where((image) => image["category"] == selectedCategory).toList();
  }

  void _toggleViewMode() {
    ss("View mode toggled");
  }

  void _shareImage(Map<String, dynamic> image) {
    ss("Sharing: ${image["title"]}");
  }
}
