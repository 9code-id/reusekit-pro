import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaColorBalanceView extends StatefulWidget {
  const PpaColorBalanceView({super.key});

  @override
  State<PpaColorBalanceView> createState() => _PpaColorBalanceViewState();
}

class _PpaColorBalanceViewState extends State<PpaColorBalanceView> {
  double cyanRedBalance = 0.0;
  double magentaGreenBalance = 0.0;
  double yellowBlueBalance = 0.0;
  double temperature = 0.0;
  double tint = 0.0;
  String selectedToneRange = "Midtones";
  bool preserveLuminosity = true;

  List<Map<String, dynamic>> toneRanges = [
    {"label": "Shadows", "value": "Shadows"},
    {"label": "Midtones", "value": "Midtones"},
    {"label": "Highlights", "value": "Highlights"},
  ];

  List<Map<String, dynamic>> colorPresets = [
    {
      "name": "Warm",
      "temperature": 25.0,
      "tint": 5.0,
      "cyanRed": 10.0,
      "magentaGreen": -5.0,
      "yellowBlue": 15.0,
    },
    {
      "name": "Cool",
      "temperature": -20.0,
      "tint": -3.0,
      "cyanRed": -8.0,
      "magentaGreen": 3.0,
      "yellowBlue": -12.0,
    },
    {
      "name": "Neutral",
      "temperature": 0.0,
      "tint": 0.0,
      "cyanRed": 0.0,
      "magentaGreen": 0.0,
      "yellowBlue": 0.0,
    },
    {
      "name": "Vintage",
      "temperature": 15.0,
      "tint": 8.0,
      "cyanRed": 12.0,
      "magentaGreen": -10.0,
      "yellowBlue": 20.0,
    },
    {
      "name": "Cinema",
      "temperature": -10.0,
      "tint": 5.0,
      "cyanRed": -15.0,
      "magentaGreen": 8.0,
      "yellowBlue": -5.0,
    },
  ];

  void _applyPreset(Map<String, dynamic> preset) {
    temperature = preset["temperature"];
    tint = preset["tint"];
    cyanRedBalance = preset["cyanRed"];
    magentaGreenBalance = preset["magentaGreen"];
    yellowBlueBalance = preset["yellowBlue"];
    setState(() {});
    ss("Applied ${preset["name"]} color balance");
  }

  void _resetColorBalance() {
    cyanRedBalance = 0.0;
    magentaGreenBalance = 0.0;
    yellowBlueBalance = 0.0;
    temperature = 0.0;
    tint = 0.0;
    setState(() {});
    si("Reset to neutral color balance");
  }

  void _autoWhiteBalance() {
    // Simulate auto white balance
    temperature = -5.0;
    tint = 2.0;
    setState(() {});
    ss("Auto white balance applied");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Color Balance"),
        actions: [
          IconButton(
            icon: Icon(Icons.auto_fix_high),
            onPressed: _autoWhiteBalance,
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetColorBalance,
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
                  image: NetworkImage("https://picsum.photos/400/250?random=4&keyword=portrait"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusMd),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      _getTemperatureColor().withAlpha(50),
                      _getTintColor().withAlpha(30),
                      _getBalanceColor().withAlpha(40),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Stack(
                  children: [
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
                          "Range: $selectedToneRange",
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

            Text(
              "Tone Range Selection",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            QHorizontalScroll(
              children: toneRanges.map((range) {
                bool isSelected = selectedToneRange == range["value"];
                return Container(
                  width: 100,
                  margin: EdgeInsets.only(right: spSm),
                  child: GestureDetector(
                    onTap: () {
                      selectedToneRange = range["value"];
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
                        "${range["label"]}",
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
                    "White Balance",
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
                          Icon(Icons.thermostat, color: disabledBoldColor, size: 20),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "Temperature: ${temperature.toInt()}K",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Slider(
                        value: temperature,
                        min: -100,
                        max: 100,
                        divisions: 200,
                        activeColor: primaryColor,
                        onChanged: (value) {
                          temperature = value;
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
                          Icon(Icons.invert_colors, color: disabledBoldColor, size: 20),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "Tint: ${tint.toInt()}",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Slider(
                        value: tint,
                        min: -50,
                        max: 50,
                        divisions: 100,
                        activeColor: primaryColor,
                        onChanged: (value) {
                          tint = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ],
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
                    "Color Balance Controls",
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
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: Colors.cyan,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Cyan",
                            style: TextStyle(fontSize: 12, color: disabledBoldColor),
                          ),
                          Expanded(
                            child: Slider(
                              value: cyanRedBalance,
                              min: -100,
                              max: 100,
                              divisions: 200,
                              activeColor: cyanRedBalance < 0 ? Colors.cyan : Colors.red,
                              onChanged: (value) {
                                cyanRedBalance = value;
                                setState(() {});
                              },
                            ),
                          ),
                          Text(
                            "Red",
                            style: TextStyle(fontSize: 12, color: disabledBoldColor),
                          ),
                          SizedBox(width: spXs),
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Cyan ← ${cyanRedBalance.toInt()} → Red",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),

                  Column(
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: Colors.purple,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Magenta",
                            style: TextStyle(fontSize: 12, color: disabledBoldColor),
                          ),
                          Expanded(
                            child: Slider(
                              value: magentaGreenBalance,
                              min: -100,
                              max: 100,
                              divisions: 200,
                              activeColor: magentaGreenBalance < 0 ? Colors.purple : Colors.green,
                              onChanged: (value) {
                                magentaGreenBalance = value;
                                setState(() {});
                              },
                            ),
                          ),
                          Text(
                            "Green",
                            style: TextStyle(fontSize: 12, color: disabledBoldColor),
                          ),
                          SizedBox(width: spXs),
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Magenta ← ${magentaGreenBalance.toInt()} → Green",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),

                  Column(
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: Colors.yellow,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Yellow",
                            style: TextStyle(fontSize: 12, color: disabledBoldColor),
                          ),
                          Expanded(
                            child: Slider(
                              value: yellowBlueBalance,
                              min: -100,
                              max: 100,
                              divisions: 200,
                              activeColor: yellowBlueBalance < 0 ? Colors.yellow : Colors.blue,
                              onChanged: (value) {
                                yellowBlueBalance = value;
                                setState(() {});
                              },
                            ),
                          ),
                          Text(
                            "Blue",
                            style: TextStyle(fontSize: 12, color: disabledBoldColor),
                          ),
                          SizedBox(width: spXs),
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Yellow ← ${yellowBlueBalance.toInt()} → Blue",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          label: "Preserve Luminosity",
                          items: [
                            {
                              "label": "Preserve brightness values",
                              "value": true,
                              "checked": preserveLuminosity,
                            }
                          ],
                          value: [
                            if (preserveLuminosity)
                              {
                                "label": "Preserve brightness values",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            preserveLuminosity = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Text(
              "Color Presets",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            QHorizontalScroll(
              children: colorPresets.map((preset) {
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
                          Row(
                            children: [
                              Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: _getPresetColor(preset),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "T:${(preset["temperature"] as num).toInt()}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Tint: ${(preset["tint"] as num).toInt()}",
                            style: TextStyle(
                              fontSize: 10,
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
                color: warningColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: warningColor.withAlpha(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.palette, color: warningColor, size: 20),
                      SizedBox(width: spSm),
                      Text(
                        "Color Balance Tips",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "• Adjust temperature for warm/cool feeling",
                    style: TextStyle(color: disabledBoldColor, fontSize: 14),
                  ),
                  Text(
                    "• Use tint to correct green/magenta color casts",
                    style: TextStyle(color: disabledBoldColor, fontSize: 14),
                  ),
                  Text(
                    "• Work on specific tonal ranges for precise control",
                    style: TextStyle(color: disabledBoldColor, fontSize: 14),
                  ),
                  Text(
                    "• Preserve luminosity to maintain original brightness",
                    style: TextStyle(color: disabledBoldColor, fontSize: 14),
                  ),
                ],
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Auto Balance",
                    size: bs.md,
                    onPressed: _autoWhiteBalance,
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
                        ss("Color balance applied successfully!");
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

  Color _getTemperatureColor() {
    if (temperature > 0) {
      return Colors.orange;
    } else if (temperature < 0) {
      return Colors.blue;
    }
    return Colors.transparent;
  }

  Color _getTintColor() {
    if (tint > 0) {
      return Colors.purple;
    } else if (tint < 0) {
      return Colors.green;
    }
    return Colors.transparent;
  }

  Color _getBalanceColor() {
    // Mix all balance values to create composite color
    return Colors.white.withAlpha(50);
  }

  Color _getPresetColor(Map<String, dynamic> preset) {
    double temp = preset["temperature"];
    if (temp > 0) {
      return Colors.orange;
    } else if (temp < 0) {
      return Colors.blue;
    }
    return Colors.grey;
  }
}
