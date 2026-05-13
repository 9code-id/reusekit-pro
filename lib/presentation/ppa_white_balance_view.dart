import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaWhiteBalanceView extends StatefulWidget {
  const PpaWhiteBalanceView({super.key});

  @override
  State<PpaWhiteBalanceView> createState() => _PpaWhiteBalanceViewState();
}

class _PpaWhiteBalanceViewState extends State<PpaWhiteBalanceView> {
  String whiteBalanceMode = "Auto";
  double colorTemperature = 5500.0;
  double tint = 0.0;
  bool isFineAdjustment = false;
  bool isCustomPreset = false;
  
  List<Map<String, dynamic>> wbModeOptions = [
    {"label": "Auto", "value": "Auto"},
    {"label": "Daylight", "value": "Daylight"},
    {"label": "Cloudy", "value": "Cloudy"},
    {"label": "Shade", "value": "Shade"},
    {"label": "Tungsten", "value": "Tungsten"},
    {"label": "Fluorescent", "value": "Fluorescent"},
    {"label": "Flash", "value": "Flash"},
    {"label": "Custom", "value": "Custom"},
  ];
  
  Map<String, double> presetTemperatures = {
    "Tungsten": 3200.0,
    "Fluorescent": 4000.0,
    "Daylight": 5500.0,
    "Flash": 5500.0,
    "Cloudy": 6500.0,
    "Shade": 7500.0,
  };
  
  List<Map<String, dynamic>> customPresets = [
    {"name": "Indoor Evening", "temp": 2800.0, "tint": -0.5},
    {"name": "Office Light", "temp": 4200.0, "tint": 0.2},
    {"name": "Golden Hour", "temp": 3000.0, "tint": 0.8},
    {"name": "Blue Hour", "temp": 8000.0, "tint": -0.3},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("White Balance"),
        actions: [
          IconButton(
            onPressed: () {
              _setCustomWhiteBalance();
            },
            icon: Icon(Icons.colorize),
          ),
          IconButton(
            onPressed: () {
              _saveAsPreset();
            },
            icon: Icon(Icons.bookmark_add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Color Temperature Preview
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor, width: 2),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(radiusMd),
                child: Stack(
                  children: [
                    // Color temperature gradient background
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            _getColorFromTemperature(colorTemperature - 1000),
                            _getColorFromTemperature(colorTemperature),
                            _getColorFromTemperature(colorTemperature + 1000),
                          ],
                          stops: [0.0, 0.5, 1.0],
                        ),
                      ),
                    ),
                    
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(100),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.wb_sunny,
                              size: 48,
                              color: Colors.white,
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "White Balance Preview",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "${colorTemperature.toInt()}K",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              whiteBalanceMode,
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    // Tint indicator
                    Positioned(
                      top: spSm,
                      right: spSm,
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(150),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Tint",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "${tint >= 0 ? '+' : ''}${tint.toStringAsFixed(1)}",
                              style: TextStyle(
                                color: tint == 0 ? Colors.white : primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // White Balance Mode
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "White Balance Mode",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  QDropdownField(
                    label: "Mode",
                    items: wbModeOptions,
                    value: whiteBalanceMode,
                    onChanged: (value, label) {
                      setState(() {
                        whiteBalanceMode = value;
                        isCustomPreset = value == "Custom";
                        
                        // Set preset temperature if available
                        if (presetTemperatures.containsKey(value)) {
                          colorTemperature = presetTemperatures[value]!;
                          tint = 0.0;
                        }
                      });
                    },
                  ),
                  
                  // Quick preset buttons
                  Wrap(
                    spacing: spSm,
                    runSpacing: spXs,
                    children: [
                      _buildPresetButton("☀️ Daylight", 5500, () {
                        _applyPreset("Daylight", 5500, 0);
                      }),
                      _buildPresetButton("☁️ Cloudy", 6500, () {
                        _applyPreset("Cloudy", 6500, 0);
                      }),
                      _buildPresetButton("🏠 Tungsten", 3200, () {
                        _applyPreset("Tungsten", 3200, 0);
                      }),
                      _buildPresetButton("💡 Fluorescent", 4000, () {
                        _applyPreset("Fluorescent", 4000, 0);
                      }),
                    ],
                  ),
                ],
              ),
            ),
            
            // Color Temperature Control
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Color Temperature",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "Fine Adjust",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(width: spXs),
                          Switch(
                            value: isFineAdjustment,
                            onChanged: (value) {
                              setState(() {
                                isFineAdjustment = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  
                  Text(
                    "${colorTemperature.toInt()}K",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  Slider(
                    value: colorTemperature,
                    min: 2000,
                    max: 10000,
                    divisions: isFineAdjustment ? 800 : 80,
                    onChanged: (value) {
                      setState(() {
                        colorTemperature = value;
                        whiteBalanceMode = "Custom";
                      });
                    },
                  ),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            "2000K",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Warm",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.orange,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "6500K",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Neutral",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "10000K",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Cool",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  
                  // Color temperature bar
                  Container(
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusSm),
                      gradient: LinearGradient(
                        colors: [
                          Colors.orange.shade300,
                          Colors.yellow.shade200,
                          Colors.white,
                          Colors.blue.shade200,
                          Colors.blue.shade400,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Tint Control
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Tint Adjustment",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  Text(
                    "${tint >= 0 ? '+' : ''}${tint.toStringAsFixed(1)}",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: tint == 0 ? Colors.black : primaryColor,
                    ),
                  ),
                  
                  Slider(
                    value: tint,
                    min: -2.0,
                    max: 2.0,
                    divisions: 40,
                    onChanged: (value) {
                      setState(() {
                        tint = value;
                        whiteBalanceMode = "Custom";
                      });
                    },
                  ),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            "-2",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Green",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "0",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Neutral",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "+2",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Magenta",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.pink,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Reset Tint",
                          size: bs.sm,
                          onPressed: () {
                            setState(() {
                              tint = 0.0;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Custom Presets
            if (customPresets.isNotEmpty)
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Text(
                      "Custom Presets",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    ...customPresets.map((preset) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: primaryColor.withAlpha(30)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: _getColorFromTemperature(preset["temp"]),
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(color: disabledColor),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    preset["name"],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "${(preset["temp"] as double).toInt()}K, Tint: ${(preset["tint"] as double) >= 0 ? '+' : ''}${(preset["tint"] as double).toStringAsFixed(1)}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  colorTemperature = preset["temp"];
                                  tint = preset["tint"];
                                  whiteBalanceMode = "Custom";
                                });
                                ss("Applied ${preset["name"]} preset");
                              },
                              child: Container(
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            
            // Action Buttons
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                children: [
                  Text(
                    "Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Auto WB",
                          size: bs.sm,
                          onPressed: () {
                            setState(() {
                              whiteBalanceMode = "Auto";
                              colorTemperature = 5500;
                              tint = 0;
                            });
                            ss("Auto white balance enabled");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Reset",
                          size: bs.sm,
                          onPressed: () {
                            _resetToDefaults();
                          },
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
  }
  
  Widget _buildPresetButton(String label, double temp, VoidCallback onTap) {
    final isSelected = colorTemperature == temp && whiteBalanceMode != "Auto";
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: spSm,
          vertical: spXs,
        ),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : primaryColor.withAlpha(20),
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: isSelected ? primaryColor : primaryColor.withAlpha(50),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : primaryColor,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
  
  Color _getColorFromTemperature(double temperature) {
    // Simplified color temperature to RGB conversion
    if (temperature < 3000) {
      return Colors.orange.shade400;
    } else if (temperature < 4000) {
      return Colors.orange.shade200;
    } else if (temperature < 5000) {
      return Colors.yellow.shade100;
    } else if (temperature < 6000) {
      return Colors.white;
    } else if (temperature < 7000) {
      return Colors.blue.shade50;
    } else if (temperature < 8000) {
      return Colors.blue.shade100;
    } else {
      return Colors.blue.shade200;
    }
  }
  
  void _applyPreset(String mode, double temp, double tintValue) {
    setState(() {
      whiteBalanceMode = mode;
      colorTemperature = temp;
      tint = tintValue;
    });
    ss("Applied $mode preset");
  }
  
  void _setCustomWhiteBalance() {
    ss("Tap on a neutral area to set custom white balance");
  }
  
  void _saveAsPreset() {
    setState(() {
      customPresets.add({
        "name": "Custom ${customPresets.length + 1}",
        "temp": colorTemperature,
        "tint": tint,
      });
    });
    ss("White balance saved as preset");
  }
  
  void _resetToDefaults() {
    setState(() {
      whiteBalanceMode = "Auto";
      colorTemperature = 5500.0;
      tint = 0.0;
      isFineAdjustment = false;
      isCustomPreset = false;
    });
    ss("White balance settings reset to defaults");
  }
}
