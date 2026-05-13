import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaArtisticEffectsView extends StatefulWidget {
  const PpaArtisticEffectsView({super.key});

  @override
  State<PpaArtisticEffectsView> createState() => _PpaArtisticEffectsViewState();
}

class _PpaArtisticEffectsViewState extends State<PpaArtisticEffectsView> {
  String selectedEffect = "";
  double effectIntensity = 70.0;
  double brushSize = 50.0;
  double edgeDetail = 30.0;
  double colorBalance = 50.0;
  bool preserveOriginalColors = false;

  List<Map<String, dynamic>> artisticEffects = [
    {
      "name": "Oil Painting",
      "description": "Classic oil painting effect",
      "thumbnail": "https://picsum.photos/80/80?random=1&keyword=painting",
      "category": "Traditional",
      "intensity": 75.0,
      "brushSize": 60.0,
      "edgeDetail": 25.0,
      "color": Colors.orange[600]!,
    },
    {
      "name": "Watercolor",
      "description": "Soft watercolor painting style",
      "thumbnail": "https://picsum.photos/80/80?random=2&keyword=watercolor",
      "category": "Traditional",
      "intensity": 65.0,
      "brushSize": 40.0,
      "edgeDetail": 15.0,
      "color": Colors.blue[300]!,
    },
    {
      "name": "Pencil Sketch",
      "description": "Hand-drawn pencil artwork",
      "thumbnail": "https://picsum.photos/80/80?random=3&keyword=sketch",
      "category": "Drawing",
      "intensity": 80.0,
      "brushSize": 20.0,
      "edgeDetail": 70.0,
      "color": Colors.grey[600]!,
    },
    {
      "name": "Acrylic Paint",
      "description": "Bold acrylic painting effect",
      "thumbnail": "https://picsum.photos/80/80?random=4&keyword=acrylic",
      "category": "Traditional",
      "intensity": 85.0,
      "brushSize": 70.0,
      "edgeDetail": 35.0,
      "color": Colors.purple[500]!,
    },
    {
      "name": "Pastel Drawing",
      "description": "Soft pastel art style",
      "thumbnail": "https://picsum.photos/80/80?random=5&keyword=pastel",
      "category": "Drawing",
      "intensity": 60.0,
      "brushSize": 45.0,
      "edgeDetail": 20.0,
      "color": Colors.pink[300]!,
    },
    {
      "name": "Ink Wash",
      "description": "Traditional ink painting",
      "thumbnail": "https://picsum.photos/80/80?random=6&keyword=ink",
      "category": "Traditional",
      "intensity": 70.0,
      "brushSize": 35.0,
      "edgeDetail": 50.0,
      "color": Colors.indigo[700]!,
    },
    {
      "name": "Pop Art",
      "description": "Bold pop art style",
      "thumbnail": "https://picsum.photos/80/80?random=7&keyword=pop",
      "category": "Modern",
      "intensity": 90.0,
      "brushSize": 30.0,
      "edgeDetail": 60.0,
      "color": Colors.red[500]!,
    },
    {
      "name": "Abstract",
      "description": "Abstract artistic interpretation",
      "thumbnail": "https://picsum.photos/80/80?random=8&keyword=abstract",
      "category": "Modern",
      "intensity": 95.0,
      "brushSize": 80.0,
      "edgeDetail": 10.0,
      "color": Colors.teal[500]!,
    },
    {
      "name": "Charcoal Drawing",
      "description": "Rich charcoal artwork",
      "thumbnail": "https://picsum.photos/80/80?random=9&keyword=charcoal",
      "category": "Drawing",
      "intensity": 75.0,
      "brushSize": 25.0,
      "edgeDetail": 65.0,
      "color": Colors.grey[800]!,
    },
    {
      "name": "Digital Art",
      "description": "Modern digital painting",
      "thumbnail": "https://picsum.photos/80/80?random=10&keyword=digital",
      "category": "Modern",
      "intensity": 80.0,
      "brushSize": 55.0,
      "edgeDetail": 40.0,
      "color": Colors.cyan[500]!,
    },
    {
      "name": "Impressionist",
      "description": "Impressionist painting style",
      "thumbnail": "https://picsum.photos/80/80?random=11&keyword=impressionist",
      "category": "Traditional",
      "intensity": 70.0,
      "brushSize": 50.0,
      "edgeDetail": 30.0,
      "color": Colors.amber[600]!,
    },
    {
      "name": "Mosaic",
      "description": "Tile mosaic art effect",
      "thumbnail": "https://picsum.photos/80/80?random=12&keyword=mosaic",
      "category": "Modern",
      "intensity": 85.0,
      "brushSize": 15.0,
      "edgeDetail": 80.0,
      "color": Colors.green[600]!,
    },
  ];

  List<String> get categories {
    Set<String> categorySet = artisticEffects.map((e) => e["category"] as String).toSet();
    return ["All", ...categorySet.toList()];
  }

  String selectedCategory = "All";

  List<Map<String, dynamic>> get filteredEffects {
    if (selectedCategory == "All") return artisticEffects;
    return artisticEffects.where((effect) => effect["category"] == selectedCategory).toList();
  }

  void _applyArtisticEffect(Map<String, dynamic> effect) {
    selectedEffect = effect["name"];
    effectIntensity = effect["intensity"];
    brushSize = effect["brushSize"];
    edgeDetail = effect["edgeDetail"];
    setState(() {});
    ss("Applied ${effect["name"]} artistic effect");
  }

  void _resetArtisticEffect() {
    selectedEffect = "";
    effectIntensity = 70.0;
    brushSize = 50.0;
    edgeDetail = 30.0;
    colorBalance = 50.0;
    preserveOriginalColors = false;
    setState(() {});
    si("Reset artistic effect settings");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Artistic Effects"),
        actions: [
          IconButton(
            icon: Icon(Icons.shuffle),
            onPressed: () {
              final randomEffect = artisticEffects[DateTime.now().millisecond % artisticEffects.length];
              _applyArtisticEffect(randomEffect);
              ss("Applied random artistic effect");
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetArtisticEffect,
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
                  image: NetworkImage("https://picsum.photos/400/250?random=13&keyword=portrait"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  if (selectedEffect.isNotEmpty)
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusMd),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            _getEffectColor().withAlpha((effectIntensity * 0.8).toInt()),
                            Colors.transparent,
                            _getEffectColor().withAlpha((effectIntensity * 0.6).toInt()),
                          ],
                        ),
                      ),
                    ),
                  if (selectedEffect.isNotEmpty)
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
                          selectedEffect,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                    bottom: spSm,
                    right: spSm,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: _getEffectColor().withAlpha(200),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "Intensity ${effectIntensity.toInt()}%",
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
              "Art Categories",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            QHorizontalScroll(
              children: categories.map((category) {
                bool isSelected = selectedCategory == category;
                return Container(
                  width: 100,
                  margin: EdgeInsets.only(right: spSm),
                  child: GestureDetector(
                    onTap: () {
                      selectedCategory = category;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm, horizontal: spSm),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor : Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(
                          color: isSelected ? primaryColor : disabledColor,
                          width: 2,
                        ),
                        boxShadow: [shadowSm],
                      ),
                      child: Text(
                        category,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isSelected ? Colors.white : primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            Text(
              "${selectedCategory == "All" ? "All" : selectedCategory} Artistic Effects",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 160,
              children: filteredEffects.map((effect) {
                bool isSelected = selectedEffect == effect["name"];
                return GestureDetector(
                  onTap: () => _applyArtisticEffect(effect),
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
                              image: NetworkImage("${effect["thumbnail"]}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                              gradient: LinearGradient(
                                colors: [
                                  (effect["color"] as Color).withAlpha(100),
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
                                      "${effect["category"]}",
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
                                "${effect["name"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isSelected ? primaryColor : Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${effect["description"]}",
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
                                      color: effect["color"] as Color,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "Brush: ${(effect["brushSize"] as num).toInt()}",
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

            if (selectedEffect.isNotEmpty)
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
                      "Fine-tune Artistic Effect",
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
                            Icon(Icons.tune, color: disabledBoldColor, size: 20),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "Effect Intensity: ${effectIntensity.toInt()}%",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Slider(
                          value: effectIntensity,
                          min: 0,
                          max: 100,
                          divisions: 100,
                          activeColor: primaryColor,
                          onChanged: (value) {
                            effectIntensity = value;
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
                            Icon(Icons.brush, color: disabledBoldColor, size: 20),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "Brush Size: ${brushSize.toInt()}%",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Slider(
                          value: brushSize,
                          min: 10,
                          max: 100,
                          divisions: 90,
                          activeColor: primaryColor,
                          onChanged: (value) {
                            brushSize = value;
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
                            Icon(Icons.crop, color: disabledBoldColor, size: 20),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "Edge Detail: ${edgeDetail.toInt()}%",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Slider(
                          value: edgeDetail,
                          min: 0,
                          max: 100,
                          divisions: 100,
                          activeColor: primaryColor,
                          onChanged: (value) {
                            edgeDetail = value;
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
                            Icon(Icons.color_lens, color: disabledBoldColor, size: 20),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "Color Balance: ${colorBalance.toInt()}%",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Slider(
                          value: colorBalance,
                          min: 0,
                          max: 100,
                          divisions: 100,
                          activeColor: primaryColor,
                          onChanged: (value) {
                            colorBalance = value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: QSwitch(
                            label: "Preserve Original Colors",
                            items: [
                              {
                                "label": "Keep original color palette",
                                "value": true,
                                "checked": preserveOriginalColors,
                              }
                            ],
                            value: [
                              if (preserveOriginalColors)
                                {
                                  "label": "Keep original color palette",
                                  "value": true,
                                  "checked": true
                                }
                            ],
                            onChanged: (values, ids) {
                              preserveOriginalColors = values.isNotEmpty;
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
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: infoColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.palette, color: infoColor, size: 20),
                      SizedBox(width: spSm),
                      Text(
                        "Artistic Effect Tips",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Oil painting works great for portraits",
                    style: TextStyle(color: disabledBoldColor, fontSize: 14),
                  ),
                  Text(
                    "• Watercolor is perfect for landscapes",
                    style: TextStyle(color: disabledBoldColor, fontSize: 14),
                  ),
                  Text(
                    "• Pencil sketch enhances architectural photos",
                    style: TextStyle(color: disabledBoldColor, fontSize: 14),
                  ),
                  Text(
                    "• Adjust brush size for fine or bold strokes",
                    style: TextStyle(color: disabledBoldColor, fontSize: 14),
                  ),
                ],
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Reset Effect",
                    size: bs.md,
                    onPressed: _resetArtisticEffect,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Apply Effect",
                    size: bs.md,
                    onPressed: () {
                      if (selectedEffect.isEmpty) {
                        se("Please select an artistic effect first");
                        return;
                      }
                      showLoading();
                      Future.delayed(Duration(seconds: 2), () {
                        hideLoading();
                        ss("$selectedEffect effect applied successfully!");
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

  Color _getEffectColor() {
    if (selectedEffect.isEmpty) return Colors.transparent;
    
    final effect = artisticEffects.firstWhere(
      (e) => e["name"] == selectedEffect,
      orElse: () => {"color": Colors.grey},
    );
    
    return effect["color"] as Color;
  }
}
