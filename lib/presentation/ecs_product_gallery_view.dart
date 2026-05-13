import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsProductGalleryView extends StatefulWidget {
  const EcsProductGalleryView({super.key});

  @override
  State<EcsProductGalleryView> createState() => _EcsProductGalleryViewState();
}

class _EcsProductGalleryViewState extends State<EcsProductGalleryView> {
  int selectedImageIndex = 0;
  bool isZoomed = false;
  double zoomScale = 1.0;

  List<Map<String, dynamic>> productImages = [
    {
      "url": "https://picsum.photos/400/400?random=1&keyword=product",
      "type": "main",
    },
    {
      "url": "https://picsum.photos/400/400?random=2&keyword=product",
      "type": "detail",
    },
    {
      "url": "https://picsum.photos/400/400?random=3&keyword=product",
      "type": "lifestyle",
    },
    {
      "url": "https://picsum.photos/400/400?random=4&keyword=product",
      "type": "size",
    },
    {
      "url": "https://picsum.photos/400/400?random=5&keyword=product",
      "type": "color",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Gallery"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Main Image Display
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.white,
              child: Stack(
                children: [
                  // Main Image with Zoom
                  GestureDetector(
                    onTap: () {
                      isZoomed = !isZoomed;
                      zoomScale = isZoomed ? 2.0 : 1.0;
                      setState(() {});
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      transform: Matrix4.identity()..scale(zoomScale),
                      child: Center(
                        child: Image.network(
                          "${productImages[selectedImageIndex]["url"]}",
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.contain,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        (loadingProgress.expectedTotalBytes ?? 1)
                                    : null,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),

                  // Image Counter
                  Positioned(
                    top: spMd,
                    right: spMd,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(153),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${selectedImageIndex + 1}/${productImages.length}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  // Zoom Indicator
                  if (isZoomed)
                    Positioned(
                      bottom: spMd,
                      left: spMd,
                      child: Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(153),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          Icons.zoom_in,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          // Image Navigation Dots
          Container(
            padding: EdgeInsets.symmetric(vertical: spSm),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(productImages.length, (index) {
                return GestureDetector(
                  onTap: () {
                    selectedImageIndex = index;
                    setState(() {});
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    width: selectedImageIndex == index ? 12 : 8,
                    height: selectedImageIndex == index ? 12 : 8,
                    decoration: BoxDecoration(
                      color: selectedImageIndex == index
                          ? primaryColor
                          : disabledColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              }),
            ),
          ),

          // Thumbnail Gallery
          Container(
            height: 100,
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: QHorizontalScroll(
              children: List.generate(productImages.length, (index) {
                final image = productImages[index];
                final isSelected = selectedImageIndex == index;
                
                return GestureDetector(
                  onTap: () {
                    selectedImageIndex = index;
                    setState(() {});
                  },
                  child: Container(
                    width: 80,
                    margin: EdgeInsets.only(
                      right: index < productImages.length - 1 ? spSm : 0,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
                        width: isSelected ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(radiusSm),
                      child: Image.network(
                        "${image["url"]}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),

          // Image Type Info
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Icon(
                  Icons.photo_camera,
                  color: disabledBoldColor,
                  size: 16,
                ),
                SizedBox(width: spXs),
                Text(
                  "${productImages[selectedImageIndex]["type"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: disabledBoldColor,
                    letterSpacing: 0.5,
                  ),
                ),
                Spacer(),
                Text(
                  "Tap to zoom",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),

          // Action Buttons
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "View 360°",
                    icon: Icons.threesixty,
                    size: bs.md,
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "AR Try On",
                    icon: Icons.view_in_ar,
                    size: bs.md,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
