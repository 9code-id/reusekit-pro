import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaShadowsHighlightsView extends StatefulWidget {
  const PpaShadowsHighlightsView({super.key});

  @override
  State<PpaShadowsHighlightsView> createState() => _PpaShadowsHighlightsViewState();
}

class _PpaShadowsHighlightsViewState extends State<PpaShadowsHighlightsView> {
  double shadowsValue = 0.0;
  double highlightsValue = 0.0;
  double exposureValue = 0.0;
  double contrastValue = 0.0;
  bool previewMode = true;

  List<Map<String, dynamic>> presetSettings = [
    {
      "name": "Natural",
      "shadows": 15.0,
      "highlights": -10.0,
      "exposure": 5.0,
      "contrast": 8.0,
    },
    {
      "name": "Dramatic",
      "shadows": 30.0,
      "highlights": -25.0,
      "exposure": 10.0,
      "contrast": 20.0,
    },
    {
      "name": "Soft",
      "shadows": 8.0,
      "highlights": -5.0,
      "exposure": 2.0,
      "contrast": 5.0,
    },
    {
      "name": "High Key",
      "shadows": 20.0,
      "highlights": 15.0,
      "exposure": 15.0,
      "contrast": -10.0,
    },
    {
      "name": "Low Key",
      "shadows": -15.0,
      "highlights": -30.0,
      "exposure": -10.0,
      "contrast": 25.0,
    },
  ];

  void _applyPreset(Map<String, dynamic> preset) {
    shadowsValue = preset["shadows"];
    highlightsValue = preset["highlights"];
    exposureValue = preset["exposure"];
    contrastValue = preset["contrast"];
    setState(() {});
    ss("Applied ${preset["name"]} preset");
  }

  void _resetToDefault() {
    shadowsValue = 0.0;
    highlightsValue = 0.0;
    exposureValue = 0.0;
    contrastValue = 0.0;
    setState(() {});
    si("Reset to default values");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shadows & Highlights"),
        actions: [
          IconButton(
            icon: Icon(previewMode ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              previewMode = !previewMode;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetToDefault,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusMd),
                image: DecorationImage(
                  image: NetworkImage("https://picsum.photos/400/300?random=1&keyword=portrait"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusMd),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withAlpha((shadowsValue * 2.55).abs().toInt()),
                      Colors.transparent,
                      Colors.white.withAlpha((highlightsValue * 2.55).abs().toInt()),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    if (previewMode)
                      Positioned(
                        top: spSm,
                        left: spSm,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(150),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "Preview Mode",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
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
                spacing: spMd,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Adjustment Controls",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  Column(
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.brightness_4, color: disabledBoldColor, size: 20),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "Shadows: ${shadowsValue.toInt()}",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Slider(
                        value: shadowsValue,
                        min: -100,
                        max: 100,
                        divisions: 200,
                        activeColor: primaryColor,
                        onChanged: (value) {
                          shadowsValue = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),

                  Column(
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.brightness_7, color: disabledBoldColor, size: 20),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "Highlights: ${highlightsValue.toInt()}",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Slider(
                        value: highlightsValue,
                        min: -100,
                        max: 100,
                        divisions: 200,
                        activeColor: primaryColor,
                        onChanged: (value) {
                          highlightsValue = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),

                  Column(
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.exposure, color: disabledBoldColor, size: 20),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "Exposure: ${exposureValue.toInt()}",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Slider(
                        value: exposureValue,
                        min: -50,
                        max: 50,
                        divisions: 100,
                        activeColor: primaryColor,
                        onChanged: (value) {
                          exposureValue = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),

                  Column(
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.contrast, color: disabledBoldColor, size: 20),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "Contrast: ${contrastValue.toInt()}",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Slider(
                        value: contrastValue,
                        min: -50,
                        max: 50,
                        divisions: 100,
                        activeColor: primaryColor,
                        onChanged: (value) {
                          contrastValue = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Text(
              "Quick Presets",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            QHorizontalScroll(
              children: presetSettings.map((preset) {
                return Container(
                  width: 120,
                  margin: EdgeInsets.only(right: spSm),
                  child: GestureDetector(
                    onTap: () => _applyPreset(preset),
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(color: disabledColor),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${preset["name"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "S: ${(preset["shadows"] as num).toInt()}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "H: ${(preset["highlights"] as num).toInt()}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "E: ${(preset["exposure"] as num).toInt()}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "C: ${(preset["contrast"] as num).toInt()}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.lightbulb_outline, color: infoColor, size: 20),
                      SizedBox(width: spSm),
                      Text(
                        "Pro Tips",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Increase shadows to reveal detail in dark areas",
                    style: TextStyle(color: disabledBoldColor, fontSize: 14),
                  ),
                  Text(
                    "• Decrease highlights to recover blown-out areas",
                    style: TextStyle(color: disabledBoldColor, fontSize: 14),
                  ),
                  Text(
                    "• Use exposure for overall brightness adjustments",
                    style: TextStyle(color: disabledBoldColor, fontSize: 14),
                  ),
                  Text(
                    "• Adjust contrast after shadows/highlights for best results",
                    style: TextStyle(color: disabledBoldColor, fontSize: 14),
                  ),
                ],
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Reset All",
                    size: bs.md,
                    onPressed: _resetToDefault,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Apply Changes",
                    size: bs.md,
                    onPressed: () {
                      showLoading();
                      Future.delayed(Duration(seconds: 2), () {
                        hideLoading();
                        ss("Shadows & highlights applied successfully!");
                      });
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
}
