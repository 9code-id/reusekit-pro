import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaBeforeAfterView extends StatefulWidget {
  const PpaBeforeAfterView({super.key});

  @override
  State<PpaBeforeAfterView> createState() => _PpaBeforeAfterViewState();
}

class _PpaBeforeAfterViewState extends State<PpaBeforeAfterView> {
  double sliderValue = 0.5;
  String viewMode = "split";
  bool showLabels = true;
  bool autoPlay = false;
  double autoPlaySpeed = 2.0;
  String beforeImage = "https://picsum.photos/400/600?random=1";
  String afterImage = "https://picsum.photos/400/600?random=2";

  final List<Map<String, dynamic>> viewModes = [
    {
      "name": "Split View",
      "value": "split",
      "icon": Icons.view_column,
      "description": "Side by side comparison",
    },
    {
      "name": "Slider",
      "value": "slider",
      "icon": Icons.compare,
      "description": "Draggable slider overlay",
    },
    {
      "name": "Fade",
      "value": "fade",
      "icon": Icons.opacity,
      "description": "Fade between images",
    },
    {
      "name": "Flip",
      "value": "flip",
      "icon": Icons.flip,
      "description": "Tap to flip between images",
    },
  ];

  final List<Map<String, dynamic>> templates = [
    {
      "name": "Beauty",
      "beforeLabel": "Before",
      "afterLabel": "After",
      "style": "modern",
    },
    {
      "name": "Fitness",
      "beforeLabel": "Day 1",
      "afterLabel": "Day 30",
      "style": "bold",
    },
    {
      "name": "Home Renovation",
      "beforeLabel": "Old",
      "afterLabel": "New",
      "style": "classic",
    },
    {
      "name": "Weight Loss",
      "beforeLabel": "Before",
      "afterLabel": "After",
      "style": "motivational",
    },
    {
      "name": "Photography",
      "beforeLabel": "Original",
      "afterLabel": "Edited",
      "style": "professional",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Before & After"),
        actions: [
          QButton(
            icon: Icons.save,
            size: bs.sm,
            onPressed: () {
              _saveComparison();
            },
          ),
          QButton(
            icon: Icons.share,
            size: bs.sm,
            onPressed: () {
              _shareComparison();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main Comparison View
            Container(
              width: double.infinity,
              height: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(radiusMd),
                child: _buildComparisonView(),
              ),
            ),

            // View Mode Selection
            Text(
              "Comparison Mode",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Container(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: viewModes.length,
                itemBuilder: (context, index) {
                  final mode = viewModes[index];
                  final isSelected = viewMode == mode["value"];
                  
                  return Container(
                    width: 100,
                    margin: EdgeInsets.only(right: spSm),
                    child: GestureDetector(
                      onTap: () {
                        viewMode = mode["value"] as String;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor : Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: isSelected ? primaryColor : disabledOutlineBorderColor,
                          ),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          spacing: spXs,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              mode["icon"],
                              color: isSelected ? Colors.white : primaryColor,
                              size: 28,
                            ),
                            Text(
                              "${mode["name"]}",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: isSelected ? Colors.white : primaryColor,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "${mode["description"]}",
                              style: TextStyle(
                                fontSize: 9,
                                color: isSelected ? Colors.white70 : disabledBoldColor,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Image Controls
            Text(
              "Images",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      spacing: spSm,
                      children: [
                        Text(
                          "Before Image",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Container(
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusSm),
                            image: DecorationImage(
                              image: NetworkImage(beforeImage),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        QButton(
                          label: "Change",
                          size: bs.sm,
                          onPressed: () {
                            _changeBeforeImage();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      spacing: spSm,
                      children: [
                        Text(
                          "After Image",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Container(
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusSm),
                            image: DecorationImage(
                              image: NetworkImage(afterImage),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        QButton(
                          label: "Change",
                          size: bs.sm,
                          onPressed: () {
                            _changeAfterImage();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Templates
            Text(
              "Templates",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Container(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: templates.length,
                itemBuilder: (context, index) {
                  final template = templates[index];
                  
                  return Container(
                    width: 120,
                    margin: EdgeInsets.only(right: spSm),
                    child: GestureDetector(
                      onTap: () {
                        _applyTemplate(template);
                      },
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: disabledOutlineBorderColor),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          spacing: spXs,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${template["name"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Row(
                              spacing: 4,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${template["beforeLabel"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  size: 12,
                                  color: disabledBoldColor,
                                ),
                                Text(
                                  "${template["afterLabel"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${template["style"]}",
                              style: TextStyle(
                                fontSize: 9,
                                color: disabledColor,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Settings
            Text(
              "Settings",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  // Show Labels Toggle
                  Row(
                    children: [
                      Text(
                        "Show Labels",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Switch(
                        value: showLabels,
                        onChanged: (value) {
                          showLabels = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),

                  // Auto Play Toggle
                  Row(
                    children: [
                      Text(
                        "Auto Play",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Switch(
                        value: autoPlay,
                        onChanged: (value) {
                          autoPlay = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),

                  // Auto Play Speed (only show if auto play is enabled)
                  if (autoPlay) ...[
                    Row(
                      children: [
                        Text(
                          "Speed",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${autoPlaySpeed.toStringAsFixed(1)}s",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      value: autoPlaySpeed,
                      min: 0.5,
                      max: 5.0,
                      divisions: 18,
                      onChanged: (value) {
                        autoPlaySpeed = value;
                        setState(() {});
                      },
                    ),
                  ],
                ],
              ),
            ),

            // Action Buttons
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Reset",
                    size: bs.md,
                    onPressed: () {
                      sliderValue = 0.5;
                      viewMode = "split";
                      showLabels = true;
                      autoPlay = false;
                      setState(() {});
                      si("Settings reset to default");
                    },
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Export",
                    size: bs.md,
                    onPressed: () {
                      _exportComparison();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComparisonView() {
    switch (viewMode) {
      case "split":
        return _buildSplitView();
      case "slider":
        return _buildSliderView();
      case "fade":
        return _buildFadeView();
      case "flip":
        return _buildFlipView();
      default:
        return _buildSplitView();
    }
  }

  Widget _buildSplitView() {
    return Stack(
      children: [
        Row(
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    beforeImage,
                    fit: BoxFit.cover,
                  ),
                  if (showLabels)
                    Positioned(
                      top: spSm,
                      left: spSm,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(180),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "BEFORE",
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
            Container(
              width: 2,
              color: Colors.white,
            ),
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    afterImage,
                    fit: BoxFit.cover,
                  ),
                  if (showLabels)
                    Positioned(
                      top: spSm,
                      right: spSm,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(180),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "AFTER",
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
          ],
        ),
      ],
    );
  }

  Widget _buildSliderView() {
    return Stack(
      children: [
        // Before image (full)
        Image.network(
          beforeImage,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        // After image (clipped)
        ClipRect(
          child: Align(
            alignment: Alignment.centerLeft,
            widthFactor: sliderValue,
            child: Image.network(
              afterImage,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Slider line
        Positioned(
          left: MediaQuery.of(context).size.width * sliderValue - 1,
          top: 0,
          bottom: 0,
          child: Container(
            width: 2,
            color: Colors.white,
          ),
        ),
        // Slider handle
        Positioned(
          left: MediaQuery.of(context).size.width * sliderValue - 20,
          top: 0,
          bottom: 0,
          child: GestureDetector(
            onPanUpdate: (details) {
              sliderValue = (details.localPosition.dx / MediaQuery.of(context).size.width).clamp(0.0, 1.0);
              setState(() {});
            },
            child: Container(
              width: 40,
              child: Center(
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusXs),
                    boxShadow: [shadowSm],
                  ),
                  child: Icon(
                    Icons.drag_handle,
                    size: 16,
                    color: primaryColor,
                  ),
                ),
              ),
            ),
          ),
        ),
        // Labels
        if (showLabels) ...[
          Positioned(
            top: spSm,
            left: spSm,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(180),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Text(
                "BEFORE",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            top: spSm,
            right: spSm,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(180),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Text(
                "AFTER",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildFadeView() {
    return Stack(
      children: [
        Image.network(
          beforeImage,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        Opacity(
          opacity: sliderValue,
          child: Image.network(
            afterImage,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        // Fade control
        Positioned(
          bottom: spMd,
          left: spMd,
          right: spMd,
          child: Slider(
            value: sliderValue,
            onChanged: (value) {
              sliderValue = value;
              setState(() {});
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFlipView() {
    return GestureDetector(
      onTap: () {
        sliderValue = sliderValue == 0.0 ? 1.0 : 0.0;
        setState(() {});
      },
      child: Stack(
        children: [
          Image.network(
            sliderValue < 0.5 ? beforeImage : afterImage,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          if (showLabels)
            Positioned(
              top: spSm,
              left: spSm,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(180),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  sliderValue < 0.5 ? "BEFORE" : "AFTER",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          Positioned(
            bottom: spMd,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(180),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "Tap to flip",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _changeBeforeImage() {
    beforeImage = "https://picsum.photos/400/600?random=${DateTime.now().millisecondsSinceEpoch}";
    setState(() {});
    si("Before image changed");
  }

  void _changeAfterImage() {
    afterImage = "https://picsum.photos/400/600?random=${DateTime.now().millisecondsSinceEpoch + 1}";
    setState(() {});
    si("After image changed");
  }

  void _applyTemplate(Map<String, dynamic> template) {
    ss("Applied ${template["name"]} template");
  }

  void _saveComparison() {
    ss("Comparison saved to gallery");
  }

  void _shareComparison() {
    ss("Sharing comparison");
  }

  void _exportComparison() {
    ss("Exporting comparison in high quality");
  }
}
