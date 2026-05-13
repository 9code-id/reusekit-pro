import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaVintageFiltersView extends StatefulWidget {
  const PpaVintageFiltersView({super.key});

  @override
  State<PpaVintageFiltersView> createState() => _PpaVintageFiltersViewState();
}

class _PpaVintageFiltersViewState extends State<PpaVintageFiltersView> {
  String selectedVintageFilter = "";
  double grainIntensity = 50.0;
  double vignetteIntensity = 30.0;
  double fadeIntensity = 25.0;
  double dustIntensity = 15.0;
  bool lightLeaksEnabled = false;
  bool scratchesEnabled = false;

  List<Map<String, dynamic>> vintageFilters = [
    {
      "name": "Classic Film",
      "description": "Traditional film photography look",
      "era": "1970s",
      "thumbnail": "https://picsum.photos/80/80?random=1&keyword=vintage",
      "color": Colors.amber,
      "grain": 40.0,
      "vignette": 25.0,
      "fade": 20.0,
    },
    {
      "name": "Polaroid",
      "description": "Instant camera aesthetic",
      "era": "1980s",
      "thumbnail": "https://picsum.photos/80/80?random=2&keyword=retro",
      "color": Colors.yellow,
      "grain": 60.0,
      "vignette": 15.0,
      "fade": 30.0,
    },
    {
      "name": "Sepia Dreams",
      "description": "Warm brown toned vintage",
      "era": "1920s",
      "thumbnail": "https://picsum.photos/80/80?random=3&keyword=old",
      "color": Colors.brown,
      "grain": 35.0,
      "vignette": 40.0,
      "fade": 35.0,
    },
    {
      "name": "Faded Glory",
      "description": "Washed out nostalgic feel",
      "era": "1960s",
      "thumbnail": "https://picsum.photos/80/80?random=4&keyword=classic",
      "color": Colors.orange,
      "grain": 45.0,
      "vignette": 35.0,
      "fade": 50.0,
    },
    {
      "name": "Golden Hour",
      "description": "Warm golden vintage tones",
      "era": "1950s",
      "thumbnail": "https://picsum.photos/80/80?random=5&keyword=golden",
      "color": Colors.amber[700]!,
      "grain": 30.0,
      "vignette": 20.0,
      "fade": 15.0,
    },
    {
      "name": "Cold War",
      "description": "Cool toned vintage aesthetic",
      "era": "1940s",
      "thumbnail": "https://picsum.photos/80/80?random=6&keyword=war",
      "color": Colors.blueGrey,
      "grain": 50.0,
      "vignette": 45.0,
      "fade": 40.0,
    },
    {
      "name": "Summer of '69",
      "description": "Bright vintage summer vibes",
      "era": "1960s",
      "thumbnail": "https://picsum.photos/80/80?random=7&keyword=summer",
      "color": Colors.orange[400]!,
      "grain": 25.0,
      "vignette": 15.0,
      "fade": 20.0,
    },
    {
      "name": "Film Noir",
      "description": "Dark dramatic vintage style",
      "era": "1930s",
      "thumbnail": "https://picsum.photos/80/80?random=8&keyword=noir",
      "color": Colors.grey[700]!,
      "grain": 55.0,
      "vignette": 60.0,
      "fade": 45.0,
    },
  ];

  void _applyVintageFilter(Map<String, dynamic> filter) {
    selectedVintageFilter = filter["name"];
    grainIntensity = filter["grain"];
    vignetteIntensity = filter["vignette"];
    fadeIntensity = filter["fade"];
    setState(() {});
    ss("Applied ${filter["name"]} vintage filter");
  }

  void _resetVintageFilter() {
    selectedVintageFilter = "";
    grainIntensity = 50.0;
    vignetteIntensity = 30.0;
    fadeIntensity = 25.0;
    dustIntensity = 15.0;
    lightLeaksEnabled = false;
    scratchesEnabled = false;
    setState(() {});
    si("Reset vintage filter settings");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vintage Filters"),
        actions: [
          IconButton(
            icon: Icon(Icons.auto_fix_normal),
            onPressed: () {
              // Random vintage effect
              final randomFilter = vintageFilters[DateTime.now().millisecond % vintageFilters.length];
              _applyVintageFilter(randomFilter);
              lightLeaksEnabled = true;
              scratchesEnabled = true;
              dustIntensity = 25.0;
              setState(() {});
              ss("Applied random vintage effect");
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetVintageFilter,
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
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusMd),
                image: DecorationImage(
                  image: NetworkImage("https://picsum.photos/400/250?random=9&keyword=portrait"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  if (selectedVintageFilter.isNotEmpty)
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusMd),
                        gradient: RadialGradient(
                          center: Alignment.center,
                          radius: 0.8,
                          colors: [
                            Colors.transparent,
                            Colors.black.withAlpha((vignetteIntensity * 2.55).toInt()),
                          ],
                        ),
                      ),
                    ),
                  if (selectedVintageFilter.isNotEmpty)
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusMd),
                        color: _getSelectedFilterColor().withAlpha((fadeIntensity * 1.5).toInt()),
                      ),
                    ),
                  if (lightLeaksEnabled)
                    Positioned(
                      top: 20,
                      right: 30,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                            colors: [
                              Colors.orange.withAlpha(150),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                  if (selectedVintageFilter.isNotEmpty)
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
                          selectedVintageFilter,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  if (selectedVintageFilter.isNotEmpty)
                    Positioned(
                      bottom: spSm,
                      right: spSm,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: _getSelectedFilterColor().withAlpha(200),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          _getSelectedFilterEra(),
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

            Text(
              "Vintage Filter Collection",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 160,
              children: vintageFilters.map((filter) {
                bool isSelected = selectedVintageFilter == filter["name"];
                return GestureDetector(
                  onTap: () => _applyVintageFilter(filter),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledColor,
                        width: isSelected ? 3 : 1,
                      ),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                            image: DecorationImage(
                              image: NetworkImage("${filter["thumbnail"]}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                              gradient: LinearGradient(
                                colors: [
                                  (filter["color"] as Color).withAlpha(120),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                            child: Stack(
                              children: [
                                if (isSelected)
                                  Positioned(
                                    top: spXs,
                                    right: spXs,
                                    child: Icon(
                                      Icons.check_circle,
                                      color: primaryColor,
                                      size: 20,
                                    ),
                                  ),
                                Positioned(
                                  top: spXs,
                                  left: spXs,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withAlpha(150),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${filter["era"]}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${filter["name"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isSelected ? primaryColor : Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${filter["description"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: filter["color"] as Color,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Grain: ${(filter["grain"] as num).toInt()}%",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                      fontWeight: FontWeight.w500,
                                    ),
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
              }).toList(),
            ),

            if (selectedVintageFilter.isNotEmpty)
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
                      "Fine-tune Vintage Effects",
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
                            Icon(Icons.grain, color: disabledBoldColor, size: 20),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "Film Grain: ${grainIntensity.toInt()}%",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Slider(
                          value: grainIntensity,
                          min: 0,
                          max: 100,
                          divisions: 100,
                          activeColor: primaryColor,
                          onChanged: (value) {
                            grainIntensity = value;
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
                            Icon(Icons.vignette, color: disabledBoldColor, size: 20),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "Vignette: ${vignetteIntensity.toInt()}%",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Slider(
                          value: vignetteIntensity,
                          min: 0,
                          max: 100,
                          divisions: 100,
                          activeColor: primaryColor,
                          onChanged: (value) {
                            vignetteIntensity = value;
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
                            Icon(Icons.opacity, color: disabledBoldColor, size: 20),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "Fade: ${fadeIntensity.toInt()}%",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Slider(
                          value: fadeIntensity,
                          min: 0,
                          max: 100,
                          divisions: 100,
                          activeColor: primaryColor,
                          onChanged: (value) {
                            fadeIntensity = value;
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
                            Icon(Icons.scatter_plot, color: disabledBoldColor, size: 20),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "Dust & Dirt: ${dustIntensity.toInt()}%",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Slider(
                          value: dustIntensity,
                          min: 0,
                          max: 50,
                          divisions: 50,
                          activeColor: primaryColor,
                          onChanged: (value) {
                            dustIntensity = value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            if (selectedVintageFilter.isNotEmpty)
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
                      "Vintage Effects",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: QSwitch(
                            label: "Light Leaks",
                            items: [
                              {
                                "label": "Add vintage light leaks",
                                "value": true,
                                "checked": lightLeaksEnabled,
                              }
                            ],
                            value: [
                              if (lightLeaksEnabled)
                                {
                                  "label": "Add vintage light leaks",
                                  "value": true,
                                  "checked": true
                                }
                            ],
                            onChanged: (values, ids) {
                              lightLeaksEnabled = values.isNotEmpty;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: QSwitch(
                            label: "Film Scratches",
                            items: [
                              {
                                "label": "Add film damage scratches",
                                "value": true,
                                "checked": scratchesEnabled,
                              }
                            ],
                            value: [
                              if (scratchesEnabled)
                                {
                                  "label": "Add film damage scratches",
                                  "value": true,
                                  "checked": true
                                }
                            ],
                            onChanged: (values, ids) {
                              scratchesEnabled = values.isNotEmpty;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: warningColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.camera_roll, color: warningColor, size: 20),
                      SizedBox(width: spSm),
                      Text(
                        "Vintage Photography Tips",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Film grain adds authentic texture to photos",
                    style: TextStyle(color: disabledBoldColor, fontSize: 14),
                  ),
                  Text(
                    "• Vignettes draw focus to the center subject",
                    style: TextStyle(color: disabledBoldColor, fontSize: 14),
                  ),
                  Text(
                    "• Fade effects create that washed-out vintage look",
                    style: TextStyle(color: disabledBoldColor, fontSize: 14),
                  ),
                  Text(
                    "• Light leaks and scratches add character and authenticity",
                    style: TextStyle(color: disabledBoldColor, fontSize: 14),
                  ),
                ],
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Reset Vintage",
                    size: bs.md,
                    onPressed: _resetVintageFilter,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Apply Vintage",
                    size: bs.md,
                    onPressed: () {
                      if (selectedVintageFilter.isEmpty) {
                        se("Please select a vintage filter first");
                        return;
                      }
                      showLoading();
                      Future.delayed(Duration(seconds: 2), () {
                        hideLoading();
                        ss("Vintage filter applied successfully!");
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

  Color _getSelectedFilterColor() {
    if (selectedVintageFilter.isEmpty) return Colors.transparent;
    
    final filter = vintageFilters.firstWhere(
      (f) => f["name"] == selectedVintageFilter,
      orElse: () => {"color": Colors.amber},
    );
    
    return filter["color"] as Color;
  }

  String _getSelectedFilterEra() {
    if (selectedVintageFilter.isEmpty) return "";
    
    final filter = vintageFilters.firstWhere(
      (f) => f["name"] == selectedVintageFilter,
      orElse: () => {"era": ""},
    );
    
    return filter["era"] as String;
  }
}
