import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaFramesBordersView extends StatefulWidget {
  const PpaFramesBordersView({super.key});

  @override
  State<PpaFramesBordersView> createState() => _PpaFramesBordersViewState();
}

class _PpaFramesBordersViewState extends State<PpaFramesBordersView> {
  String selectedCategory = "Classic";
  String selectedFrame = "frame_1";
  double frameWidth = 20.0;
  Color frameColor = Colors.white;
  bool showOriginal = false;
  
  String originalImage = "https://picsum.photos/600/800?random=1&keyword=portrait";

  List<Map<String, dynamic>> categories = [
    {"label": "Classic", "value": "Classic"},
    {"label": "Modern", "value": "Modern"},
    {"label": "Vintage", "value": "Vintage"},
    {"label": "Artistic", "value": "Artistic"},
    {"label": "Polaroid", "value": "Polaroid"},
    {"label": "Decorative", "value": "Decorative"},
  ];

  List<Map<String, dynamic>> frames = [
    {
      "id": "frame_1",
      "name": "Simple White",
      "category": "Classic",
      "preview": "https://picsum.photos/100/100?random=10",
      "color": Colors.white,
      "style": "solid",
    },
    {
      "id": "frame_2",
      "name": "Black Border",
      "category": "Classic",
      "preview": "https://picsum.photos/100/100?random=11",
      "color": Colors.black,
      "style": "solid",
    },
    {
      "id": "frame_3",
      "name": "Gold Frame",
      "category": "Classic",
      "preview": "https://picsum.photos/100/100?random=12",
      "color": Color(0xFFFFD700),
      "style": "ornate",
    },
    {
      "id": "frame_4",
      "name": "Silver Metal",
      "category": "Modern",
      "preview": "https://picsum.photos/100/100?random=13",
      "color": Color(0xFFC0C0C0),
      "style": "metallic",
    },
    {
      "id": "frame_5",
      "name": "Neon Glow",
      "category": "Modern",
      "preview": "https://picsum.photos/100/100?random=14",
      "color": Color(0xFF00FFFF),
      "style": "glow",
    },
    {
      "id": "frame_6",
      "name": "Wood Rustic",
      "category": "Vintage",
      "preview": "https://picsum.photos/100/100?random=15",
      "color": Color(0xFF8B4513),
      "style": "textured",
    },
    {
      "id": "frame_7",
      "name": "Antique Gold",
      "category": "Vintage",
      "preview": "https://picsum.photos/100/100?random=16",
      "color": Color(0xFFB8860B),
      "style": "vintage",
    },
    {
      "id": "frame_8",
      "name": "Paint Splash",
      "category": "Artistic",
      "preview": "https://picsum.photos/100/100?random=17",
      "color": Color(0xFF9932CC),
      "style": "artistic",
    },
    {
      "id": "frame_9",
      "name": "Film Strip",
      "category": "Artistic",
      "preview": "https://picsum.photos/100/100?random=18",
      "color": Colors.black,
      "style": "film",
    },
    {
      "id": "frame_10",
      "name": "Instant Photo",
      "category": "Polaroid",
      "preview": "https://picsum.photos/100/100?random=19",
      "color": Colors.white,
      "style": "polaroid",
    },
    {
      "id": "frame_11",
      "name": "Retro Square",
      "category": "Polaroid",
      "preview": "https://picsum.photos/100/100?random=20",
      "color": Color(0xFFFFF8DC),
      "style": "retro",
    },
    {
      "id": "frame_12",
      "name": "Floral Border",
      "category": "Decorative",
      "preview": "https://picsum.photos/100/100?random=21",
      "color": Color(0xFFFFB6C1),
      "style": "floral",
    },
  ];

  List<Color> borderColors = [
    Colors.white,
    Colors.black,
    Colors.grey,
    Color(0xFFFFD700), // Gold
    Color(0xFFC0C0C0), // Silver
    Color(0xFF8B4513), // Brown
    primaryColor,
    successColor,
    warningColor,
    dangerColor,
    infoColor,
    Color(0xFF9932CC), // Purple
  ];

  List<Map<String, dynamic>> get filteredFrames {
    return frames.where((frame) => frame["category"] == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Frames & Borders"),
        actions: [
          IconButton(
            onPressed: () {
              showOriginal = !showOriginal;
              setState(() {});
            },
            icon: Icon(showOriginal ? Icons.visibility_off : Icons.visibility),
          ),
          IconButton(
            onPressed: () => _resetSettings(),
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: Column(
        children: [
          // Image Preview
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              child: Stack(
                children: [
                  // Main Image with Frame
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(showOriginal ? 0 : frameWidth),
                    decoration: BoxDecoration(
                      color: showOriginal ? Colors.transparent : frameColor,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowMd],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(radiusMd),
                      child: Image.network(
                        originalImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  
                  // Frame Overlay Effect
                  if (!showOriginal) _buildFrameOverlay(),
                  
                  // Preview Toggle
                  Positioned(
                    top: spSm,
                    right: spSm,
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(150),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        showOriginal ? "ORIGINAL" : "WITH FRAME",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Controls Panel
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                boxShadow: [shadowMd],
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    // Category Selector
                    Text(
                      "Frame Categories",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    QCategoryPicker(
                      items: categories,
                      value: selectedCategory,
                      onChanged: (index, label, value, item) {
                        selectedCategory = value;
                        setState(() {});
                      },
                    ),

                    // Frame Gallery
                    _buildFrameGallery(),

                    // Frame Width Control
                    _buildFrameWidthControl(),

                    // Color Selector
                    _buildColorSelector(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [shadowSm],
        ),
        child: Row(
          children: [
            Expanded(
              child: QButton(
                label: "Remove Frame",
                size: bs.sm,
                onPressed: () => _removeFrame(),
              ),
            ),
            SizedBox(width: spMd),
            Expanded(
              flex: 2,
              child: QButton(
                label: "Apply Frame",
                size: bs.sm,
                onPressed: () => _applyFrame(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFrameOverlay() {
    var selectedFrameData = frames.firstWhere((f) => f["id"] == selectedFrame);
    String style = selectedFrameData["style"];
    
    switch (style) {
      case "glow":
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [
              BoxShadow(
                color: frameColor.withAlpha(200),
                blurRadius: frameWidth / 2,
                spreadRadius: frameWidth / 4,
              ),
            ],
          ),
        );
      case "film":
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radiusMd),
            border: Border.all(color: frameColor, width: frameWidth),
          ),
          child: Column(
            children: List.generate(20, (index) => Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: frameWidth / 4),
                decoration: BoxDecoration(
                  color: index % 2 == 0 ? Colors.transparent : Colors.black,
                ),
              ),
            )),
          ),
        );
      case "polaroid":
        return Container(
          margin: EdgeInsets.all(frameWidth),
          decoration: BoxDecoration(
            color: frameColor,
            borderRadius: BorderRadius.circular(radiusSm),
            boxShadow: [shadowMd],
          ),
          child: Column(
            children: [
              Expanded(
                flex: 8,
                child: Container(),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  color: frameColor,
                ),
              ),
            ],
          ),
        );
      default:
        return Container();
    }
  }

  Widget _buildFrameGallery() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Available Frames",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(
          height: 100,
          child: QHorizontalScroll(
            children: filteredFrames.map((frame) => Container(
              width: 80,
              margin: EdgeInsets.only(right: spSm),
              child: _buildFrameCard(frame),
            )).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildFrameCard(Map<String, dynamic> frame) {
    bool isSelected = selectedFrame == frame["id"];
    
    return GestureDetector(
      onTap: () {
        selectedFrame = frame["id"];
        frameColor = frame["color"];
        setState(() {});
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: isSelected ? primaryColor : disabledColor,
            width: isSelected ? 3 : 1,
          ),
          boxShadow: [shadowSm],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radiusSm),
          child: Stack(
            children: [
              Image.network(
                "${frame["preview"]}",
                width: 80,
                height: 100,
                fit: BoxFit.cover,
              ),
              Container(
                width: 80,
                height: 100,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: frame["color"], width: 6),
                ),
              ),
              Positioned(
                bottom: spXs,
                left: spXs,
                right: spXs,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(150),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${frame["name"]}",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFrameWidthControl() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Row(
          children: [
            Icon(Icons.border_style, color: primaryColor, size: 20),
            SizedBox(width: spSm),
            Text(
              "Frame Width",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "${frameWidth.toInt()}px",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ),
          ],
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: primaryColor,
            inactiveTrackColor: primaryColor.withAlpha(100),
            thumbColor: primaryColor,
            overlayColor: primaryColor.withAlpha(50),
          ),
          child: Slider(
            value: frameWidth,
            min: 5.0,
            max: 50.0,
            divisions: 45,
            onChanged: (value) {
              frameWidth = value;
              setState(() {});
            },
          ),
        ),
      ],
    );
  }

  Widget _buildColorSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Frame Color",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        Wrap(
          spacing: spSm,
          runSpacing: spSm,
          children: borderColors.map((color) => GestureDetector(
            onTap: () {
              frameColor = color;
              setState(() {});
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: frameColor == color ? primaryColor : disabledColor,
                  width: frameColor == color ? 3 : 1,
                ),
                boxShadow: [shadowSm],
              ),
              child: frameColor == color
                ? Icon(
                    Icons.check,
                    color: color == Colors.white ? Colors.black : Colors.white,
                    size: 20,
                  )
                : null,
            ),
          )).toList(),
        ),
      ],
    );
  }

  void _resetSettings() {
    selectedFrame = "frame_1";
    frameWidth = 20.0;
    frameColor = Colors.white;
    setState(() {});
  }

  void _removeFrame() {
    frameWidth = 0.0;
    setState(() {});
  }

  void _applyFrame() {
    // Apply frame to image
    ss("Frame applied successfully!");
    // Navigate back or to next step
  }
}
