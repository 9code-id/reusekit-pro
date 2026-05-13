import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlCamera8View extends StatefulWidget {
  @override
  State<GrlCamera8View> createState() => _GrlCamera8ViewState();
}

class _GrlCamera8ViewState extends State<GrlCamera8View> {
  bool isPortraitMode = true;
  double blurIntensity = 5.0;
  String lightingStyle = "Natural";
  bool faceDetection = true;
  List<Rect> detectedFaces = [];

  List<Map<String, dynamic>> lightingOptions = [
    {"name": "Natural", "icon": Icons.wb_sunny},
    {"name": "Studio", "icon": Icons.lightbulb},
    {"name": "Contour", "icon": Icons.face_retouching_natural},
    {"name": "Stage", "icon": Icons.theater_comedy},
    {"name": "Stage Mono", "icon": Icons.monochrome_photos},
  ];

  List<Map<String, dynamic>> portraitGallery = [
    {
      "image": "https://picsum.photos/300/400?random=1&keyword=portrait",
      "lighting": "Natural",
      "blur": 3.5,
    },
    {
      "image": "https://picsum.photos/300/400?random=2&keyword=portrait",
      "lighting": "Studio",
      "blur": 7.2,
    },
    {
      "image": "https://picsum.photos/300/400?random=3&keyword=portrait",
      "lighting": "Contour",
      "blur": 5.8,
    },
  ];

  @override
  void initState() {
    super.initState();
    _simulateFaceDetection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          _buildPortraitHeader(),
          Expanded(
            child: _buildPortraitPreview(),
          ),
          _buildLightingControls(),
          _buildPortraitControls(),
        ],
      ),
    );
  }

  Widget _buildPortraitHeader() {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + spSm,
        left: spMd,
        right: spMd,
        bottom: spSm,
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            GestureDetector(
              onTap: () => back(),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 24,
              ),
            ),
            SizedBox(width: spMd),
            Text(
              "Portrait Mode",
              style: TextStyle(
                color: Colors.white,
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                faceDetection = !faceDetection;
                setState(() {});
                if (faceDetection) {
                  _simulateFaceDetection();
                } else {
                  detectedFaces.clear();
                  setState(() {});
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spSm,
                  vertical: spXs,
                ),
                decoration: BoxDecoration(
                  color: faceDetection ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: Colors.white.withAlpha(102),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.face,
                      color: faceDetection ? Colors.black : Colors.white,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Face ID",
                      style: TextStyle(
                        color: faceDetection ? Colors.black : Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPortraitPreview() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: spMd),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(radiusLg),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radiusLg),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              child: Image.network(
                "https://picsum.photos/400/600?random=9&keyword=portrait",
                fit: BoxFit.cover,
              ),
            ),
            _buildBlurOverlay(),
            _buildFaceDetectionBoxes(),
            _buildPortraitSettings(),
            _buildDepthPreview(),
          ],
        ),
      ),
    );
  }

  Widget _buildBlurOverlay() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 0.6,
          colors: [
            Colors.transparent,
            Colors.black.withAlpha((blurIntensity * 25.5).round()),
          ],
          stops: [0.3, 1.0],
        ),
      ),
    );
  }

  Widget _buildFaceDetectionBoxes() {
    if (!faceDetection || detectedFaces.isEmpty) return Container();

    return Stack(
      children: detectedFaces.map((face) {
        return Positioned(
          left: face.left,
          top: face.top,
          child: Container(
            width: face.width,
            height: face.height,
            decoration: BoxDecoration(
              border: Border.all(
                color: successColor,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: -20,
                  left: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spXs,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: successColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "Face",
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
        );
      }).toList(),
    );
  }

  Widget _buildPortraitSettings() {
    return Positioned(
      top: spMd,
      right: spMd,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(128),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Column(
              children: [
                Text(
                  "ƒ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  blurIntensity.toStringAsFixed(1),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spSm),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: spXs,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(128),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              lightingStyle,
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDepthPreview() {
    return Positioned(
      bottom: spMd,
      right: spMd,
      child: GestureDetector(
        onTap: () {
          _showDepthMap();
        },
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.black.withAlpha(128),
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(
              color: Colors.white.withAlpha(102),
              width: 2,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.layers,
                color: Colors.white,
                size: 20,
              ),
              SizedBox(height: 2),
              Text(
                "Depth",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLightingControls() {
    return Container(
      height: 80,
      padding: EdgeInsets.symmetric(vertical: spSm),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: spMd),
        itemCount: lightingOptions.length,
        itemBuilder: (context, index) {
          final option = lightingOptions[index];
          final isSelected = lightingStyle == option["name"];

          return GestureDetector(
            onTap: () {
              lightingStyle = option["name"] as String;
              setState(() {});
            },
            child: Container(
              width: 70,
              margin: EdgeInsets.only(right: spSm),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.white : Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withAlpha(102),
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      option["icon"] as IconData,
                      color: isSelected ? Colors.black : Colors.white,
                      size: 20,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${option["name"]}",
                    style: TextStyle(
                      color: isSelected ? Colors.white : disabledBoldColor,
                      fontSize: 10,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPortraitControls() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: spMd,
                vertical: spSm,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(128),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Row(
                children: [
                  Text(
                    "ƒ/1.4",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Expanded(
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 2,
                        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8),
                        overlayShape: RoundSliderOverlayShape(overlayRadius: 16),
                        activeTrackColor: Colors.white,
                        inactiveTrackColor: Colors.white.withAlpha(102),
                        thumbColor: Colors.white,
                        overlayColor: Colors.white.withAlpha(51),
                      ),
                      child: Slider(
                        value: blurIntensity,
                        min: 1.0,
                        max: 10.0,
                        onChanged: (value) {
                          blurIntensity = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                  Text(
                    "ƒ/16",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    _showPortraitGallery();
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: Colors.white.withAlpha(102),
                        width: 2,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(radiusSm - 2),
                      child: Stack(
                        children: [
                          Image.network(
                            portraitGallery.first["image"] as String,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: RadialGradient(
                                center: Alignment.center,
                                radius: 0.6,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withAlpha(77),
                                ],
                                stops: [0.3, 1.0],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _capturePortrait();
                  },
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 6,
                      ),
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.black,
                      size: 32,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    isPortraitMode = !isPortraitMode;
                    setState(() {});
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: isPortraitMode ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: Colors.white.withAlpha(102),
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      Icons.portrait,
                      color: isPortraitMode ? Colors.black : Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _simulateFaceDetection() {
    Future.delayed(Duration(milliseconds: 500), () {
      if (faceDetection) {
        detectedFaces = [
          Rect.fromLTWH(
            MediaQuery.of(context).size.width * 0.3,
            MediaQuery.of(context).size.height * 0.25,
            100,
            120,
          ),
        ];
        setState(() {});
      }
    });
  }

  void _capturePortrait() {
    portraitGallery.insert(0, {
      "image": "https://picsum.photos/300/400?random=${DateTime.now().millisecondsSinceEpoch}&keyword=portrait",
      "lighting": lightingStyle,
      "blur": blurIntensity,
    });
    
    if (portraitGallery.length > 10) {
      portraitGallery.removeLast();
    }
    
    setState(() {});
  }

  void _showDepthMap() {
    // Depth map visualization
  }

  void _showPortraitGallery() {
    // Portrait gallery implementation
  }
}
