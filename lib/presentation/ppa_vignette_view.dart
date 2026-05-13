import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaVignetteView extends StatefulWidget {
  const PpaVignetteView({super.key});

  @override
  State<PpaVignetteView> createState() => _PpaVignetteViewState();
}

class _PpaVignetteViewState extends State<PpaVignetteView> {
  double vignetteIntensity = 0.5;
  double vignetteSize = 0.7;
  double vignetteFeather = 0.3;
  String selectedShape = "circular";
  bool isPreviewMode = true;
  
  String originalImage = "https://picsum.photos/600/800?random=1&keyword=portrait";
  
  List<Map<String, dynamic>> vignetteShapes = [
    {"label": "Circular", "value": "circular", "icon": Icons.circle_outlined},
    {"label": "Oval", "value": "oval", "icon": Icons.circle},
    {"label": "Rectangular", "value": "rectangular", "icon": Icons.rectangle_outlined},
    {"label": "Square", "value": "square", "icon": Icons.square_outlined},
  ];

  List<Map<String, dynamic>> presets = [
    {
      "name": "Subtle",
      "intensity": 0.3,
      "size": 0.8,
      "feather": 0.4,
      "preview": "https://picsum.photos/100/100?random=10&keyword=subtle"
    },
    {
      "name": "Dramatic",
      "intensity": 0.8,
      "size": 0.5,
      "feather": 0.2,
      "preview": "https://picsum.photos/100/100?random=11&keyword=dramatic"
    },
    {
      "name": "Vintage",
      "intensity": 0.6,
      "size": 0.6,
      "feather": 0.5,
      "preview": "https://picsum.photos/100/100?random=12&keyword=vintage"
    },
    {
      "name": "Soft Focus",
      "intensity": 0.4,
      "size": 0.9,
      "feather": 0.7,
      "preview": "https://picsum.photos/100/100?random=13&keyword=soft"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vignette Effect"),
        actions: [
          IconButton(
            onPressed: () => _togglePreviewMode(),
            icon: Icon(isPreviewMode ? Icons.visibility_off : Icons.visibility),
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
                  // Original Image
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
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
                  
                  // Vignette Overlay (if preview mode)
                  if (isPreviewMode)
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusMd),
                        gradient: _buildVignetteGradient(),
                      ),
                    ),
                  
                  // Preview Toggle Button
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
                        isPreviewMode ? "WITH EFFECT" : "ORIGINAL",
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
                    // Quick Presets
                    _buildPresetsSection(),

                    // Vignette Shape
                    _buildShapeSelector(),

                    // Intensity Control
                    _buildSliderControl(
                      "Intensity",
                      vignetteIntensity,
                      Icons.opacity,
                      (value) {
                        vignetteIntensity = value;
                        setState(() {});
                      },
                    ),

                    // Size Control
                    _buildSliderControl(
                      "Size",
                      vignetteSize,
                      Icons.fullscreen,
                      (value) {
                        vignetteSize = value;
                        setState(() {});
                      },
                    ),

                    // Feather Control
                    _buildSliderControl(
                      "Feather",
                      vignetteFeather,
                      Icons.blur_on,
                      (value) {
                        vignetteFeather = value;
                        setState(() {});
                      },
                    ),
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
                label: "Reset",
                size: bs.sm,
                onPressed: () => _resetSettings(),
              ),
            ),
            SizedBox(width: spMd),
            Expanded(
              flex: 2,
              child: QButton(
                label: "Apply Effect",
                size: bs.sm,
                onPressed: () => _applyEffect(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPresetsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Quick Presets",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          height: 80,
          child: QHorizontalScroll(
            children: presets.map((preset) => Container(
              width: 80,
              margin: EdgeInsets.only(right: spSm),
              child: _buildPresetCard(preset),
            )).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildPresetCard(Map<String, dynamic> preset) {
    return GestureDetector(
      onTap: () => _applyPreset(preset),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radiusSm),
          boxShadow: [shadowSm],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radiusSm),
          child: Stack(
            children: [
              Image.network(
                "${preset["preview"]}",
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.transparent,
                      Colors.black.withAlpha((preset["intensity"] * 255).toInt()),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: spXs,
                left: spXs,
                right: spXs,
                child: Text(
                  "${preset["name"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShapeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Vignette Shape",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: vignetteShapes.map((shape) => Expanded(
            child: GestureDetector(
              onTap: () {
                selectedShape = shape["value"];
                setState(() {});
              },
              child: Container(
                margin: EdgeInsets.only(right: spXs),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: selectedShape == shape["value"] 
                    ? primaryColor.withAlpha(50)
                    : Colors.grey.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: selectedShape == shape["value"] 
                      ? primaryColor 
                      : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      shape["icon"],
                      color: selectedShape == shape["value"] 
                        ? primaryColor 
                        : disabledBoldColor,
                      size: 24,
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${shape["label"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: selectedShape == shape["value"] 
                          ? primaryColor 
                          : disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildSliderControl(String label, double value, IconData icon, Function(double) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Row(
          children: [
            Icon(icon, color: primaryColor, size: 20),
            SizedBox(width: spSm),
            Text(
              label,
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
                "${(value * 100).toInt()}%",
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
            value: value,
            min: 0.0,
            max: 1.0,
            divisions: 100,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  RadialGradient _buildVignetteGradient() {
    List<Color> colors;
    List<double> stops;
    
    double centerRadius = vignetteSize;
    double fadeRadius = centerRadius + vignetteFeather;
    
    colors = [
      Colors.transparent,
      Colors.transparent,
      Colors.black.withAlpha((vignetteIntensity * 255).toInt()),
    ];
    
    stops = [
      0.0,
      centerRadius,
      fadeRadius.clamp(centerRadius, 1.0),
    ];

    return RadialGradient(
      center: Alignment.center,
      radius: 1.0,
      colors: colors,
      stops: stops,
    );
  }

  void _applyPreset(Map<String, dynamic> preset) {
    vignetteIntensity = preset["intensity"];
    vignetteSize = preset["size"];
    vignetteFeather = preset["feather"];
    setState(() {});
  }

  void _togglePreviewMode() {
    isPreviewMode = !isPreviewMode;
    setState(() {});
  }

  void _resetSettings() {
    vignetteIntensity = 0.5;
    vignetteSize = 0.7;
    vignetteFeather = 0.3;
    selectedShape = "circular";
    setState(() {});
  }

  void _applyEffect() {
    // Apply vignette effect to image
    ss("Vignette effect applied successfully!");
    // Navigate back or to next step
  }
}
