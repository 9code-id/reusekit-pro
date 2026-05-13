import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaIsoSettingsView extends StatefulWidget {
  const PpaIsoSettingsView({super.key});

  @override
  State<PpaIsoSettingsView> createState() => _PpaIsoSettingsViewState();
}

class _PpaIsoSettingsViewState extends State<PpaIsoSettingsView> {
  bool isAutoISO = true;
  double manualISO = 100.0;
  double maxAutoISO = 1600.0;
  double minAutoISO = 100.0;
  String isoMode = "Standard";
  bool isNoiseReduction = true;
  double noiseReductionStrength = 3.0;
  
  List<Map<String, dynamic>> isoModeOptions = [
    {"label": "Standard", "value": "Standard"},
    {"label": "Low Noise", "value": "Low Noise"},
    {"label": "High Performance", "value": "High Performance"},
    {"label": "Extended Range", "value": "Extended Range"},
  ];
  
  List<double> isoValues = [
    50, 64, 80, 100, 125, 160, 200, 250, 320, 400, 500, 640, 800, 1000, 1250, 1600, 2000, 2500, 3200, 4000, 5000, 6400, 8000, 10000, 12800, 16000, 20000, 25600, 32000, 40000, 51200, 64000, 81200, 102400
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ISO Settings"),
        actions: [
          IconButton(
            onPressed: () {
              _showNoiseAnalysis();
            },
            icon: Icon(Icons.analytics),
          ),
          IconButton(
            onPressed: () {
              _resetToDefaults();
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // ISO Preview Area
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor, width: 2),
              ),
              child: Stack(
                children: [
                  // Noise simulation based on ISO
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.grain,
                          size: 48,
                          color: Colors.white,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "ISO Preview",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "ISO ${_getCurrentISO().toInt()}",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _getNoiseLevel(_getCurrentISO()),
                          style: TextStyle(
                            color: _getNoiseColor(_getCurrentISO()),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // ISO mode indicator
                  Positioned(
                    top: spSm,
                    left: spSm,
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(180),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isAutoISO ? "AUTO ISO" : "MANUAL ISO",
                            style: TextStyle(
                              color: isAutoISO ? successColor : warningColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            isoMode,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  // Noise level indicator
                  Positioned(
                    top: spSm,
                    right: spSm,
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(180),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Noise Level",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                          Text(
                            _getNoiseLevel(_getCurrentISO()),
                            style: TextStyle(
                              color: _getNoiseColor(_getCurrentISO()),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  // Auto ISO range indicator
                  if (isAutoISO)
                    Positioned(
                      bottom: spSm,
                      left: spSm,
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(180),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "Range: ${minAutoISO.toInt()}-${maxAutoISO.toInt()}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            
            // ISO Mode Selection
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Auto ISO",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Camera automatically adjusts ISO",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: isAutoISO,
                        onChanged: (value) {
                          setState(() {
                            isAutoISO = value;
                          });
                        },
                      ),
                    ],
                  ),
                  
                  QDropdownField(
                    label: "ISO Mode",
                    items: isoModeOptions,
                    value: isoMode,
                    onChanged: (value, label) {
                      isoMode = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            
            // Auto ISO Settings
            if (isAutoISO)
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
                      "Auto ISO Range",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    Text(
                      "Minimum ISO: ${minAutoISO.toInt()}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Slider(
                      value: minAutoISO,
                      min: 50,
                      max: 1600,
                      divisions: _getValidISODivisions(50, 1600),
                      onChanged: (value) {
                        setState(() {
                          minAutoISO = _findClosestISO(value);
                          if (minAutoISO >= maxAutoISO) {
                            maxAutoISO = _getNextISO(minAutoISO);
                          }
                        });
                      },
                    ),
                    
                    Text(
                      "Maximum ISO: ${maxAutoISO.toInt()}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Slider(
                      value: maxAutoISO,
                      min: minAutoISO,
                      max: 25600,
                      divisions: _getValidISODivisions(minAutoISO, 25600),
                      onChanged: (value) {
                        setState(() {
                          maxAutoISO = _findClosestISO(value);
                        });
                      },
                    ),
                    
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "Camera will automatically adjust ISO between ${minAutoISO.toInt()} and ${maxAutoISO.toInt()} based on lighting conditions",
                        style: TextStyle(
                          fontSize: 14,
                          color: infoColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            
            // Manual ISO Settings
            if (!isAutoISO)
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
                      "Manual ISO",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    Text(
                      "ISO ${manualISO.toInt()}",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    Slider(
                      value: manualISO,
                      min: 50,
                      max: 102400,
                      divisions: isoValues.length - 1,
                      onChanged: (value) {
                        setState(() {
                          manualISO = _findClosestISO(value);
                        });
                      },
                    ),
                    
                    // Quick ISO buttons
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: [
                        _buildISOButton(100),
                        _buildISOButton(200),
                        _buildISOButton(400),
                        _buildISOButton(800),
                        _buildISOButton(1600),
                        _buildISOButton(3200),
                        _buildISOButton(6400),
                        _buildISOButton(12800),
                      ],
                    ),
                    
                    // ISO characteristics
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: _getNoiseColor(manualISO).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "ISO ${manualISO.toInt()} Characteristics:",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: _getNoiseColor(manualISO),
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            _getISODescription(manualISO),
                            style: TextStyle(
                              fontSize: 14,
                              color: _getNoiseColor(manualISO),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            
            // Noise Reduction Settings
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Noise Reduction",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Reduce image noise at high ISO",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: isNoiseReduction,
                        onChanged: (value) {
                          setState(() {
                            isNoiseReduction = value;
                          });
                        },
                      ),
                    ],
                  ),
                  
                  if (isNoiseReduction) ...[
                    Text(
                      "Noise Reduction Strength: ${noiseReductionStrength.toStringAsFixed(0)}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Slider(
                      value: noiseReductionStrength,
                      min: 1,
                      max: 5,
                      divisions: 4,
                      onChanged: (value) {
                        setState(() {
                          noiseReductionStrength = value;
                        });
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Mild",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "Strong",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            
            // ISO Performance Chart
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
                    "ISO Performance Guide",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  ...isoValues.take(12).map((iso) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        vertical: spXs,
                        horizontal: spSm,
                      ),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: (_getCurrentISO() == iso) 
                            ? primaryColor.withAlpha(20) 
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: (_getCurrentISO() == iso) 
                            ? Border.all(color: primaryColor) 
                            : null,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            child: Text(
                              "ISO ${iso.toInt()}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: (_getCurrentISO() == iso) 
                                    ? primaryColor 
                                    : Colors.black,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: List.generate(5, (index) {
                                return Container(
                                  width: 20,
                                  height: 8,
                                  margin: EdgeInsets.only(right: 2),
                                  decoration: BoxDecoration(
                                    color: index < _getNoiseBarCount(iso) 
                                        ? _getNoiseColor(iso) 
                                        : Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                );
                              }),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            _getNoiseLevel(iso),
                            style: TextStyle(
                              fontSize: 12,
                              color: _getNoiseColor(iso),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildISOButton(double iso) {
    final isSelected = manualISO == iso;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          manualISO = iso;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: spSm,
          vertical: spXs,
        ),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : primaryColor.withAlpha(20),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Text(
          "${iso.toInt()}",
          style: TextStyle(
            color: isSelected ? Colors.white : primaryColor,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
  
  double _getCurrentISO() {
    return isAutoISO ? ((minAutoISO + maxAutoISO) / 2) : manualISO;
  }
  
  double _findClosestISO(double target) {
    return isoValues.reduce((a, b) => 
        (a - target).abs() < (b - target).abs() ? a : b
    );
  }
  
  double _getNextISO(double currentISO) {
    final currentIndex = isoValues.indexOf(currentISO);
    if (currentIndex < isoValues.length - 1) {
      return isoValues[currentIndex + 1];
    }
    return currentISO;
  }
  
  int _getValidISODivisions(double min, double max) {
    return isoValues.where((iso) => iso >= min && iso <= max).length - 1;
  }
  
  String _getNoiseLevel(double iso) {
    if (iso <= 200) return "Excellent";
    if (iso <= 800) return "Good";
    if (iso <= 3200) return "Acceptable";
    if (iso <= 12800) return "Noisy";
    return "Very Noisy";
  }
  
  Color _getNoiseColor(double iso) {
    if (iso <= 200) return successColor;
    if (iso <= 800) return Colors.green;
    if (iso <= 3200) return warningColor;
    if (iso <= 12800) return Colors.orange;
    return dangerColor;
  }
  
  int _getNoiseBarCount(double iso) {
    if (iso <= 200) return 1;
    if (iso <= 800) return 2;
    if (iso <= 3200) return 3;
    if (iso <= 12800) return 4;
    return 5;
  }
  
  String _getISODescription(double iso) {
    if (iso <= 100) {
      return "Best image quality, minimal noise. Use in bright light or with tripod.";
    } else if (iso <= 400) {
      return "Excellent quality with very low noise. Good for general photography.";
    } else if (iso <= 1600) {
      return "Good quality with acceptable noise. Suitable for indoor photography.";
    } else if (iso <= 6400) {
      return "Moderate noise but usable. Good for low light situations.";
    } else if (iso <= 25600) {
      return "High noise but still usable with processing. For very low light.";
    } else {
      return "Very high noise. Emergency use only for extreme low light.";
    }
  }
  
  void _showNoiseAnalysis() {
    si("Noise analysis shows current image quality at ISO ${_getCurrentISO().toInt()}");
  }
  
  void _resetToDefaults() {
    setState(() {
      isAutoISO = true;
      manualISO = 100.0;
      maxAutoISO = 1600.0;
      minAutoISO = 100.0;
      isoMode = "Standard";
      isNoiseReduction = true;
      noiseReductionStrength = 3.0;
    });
    ss("ISO settings reset to defaults");
  }
}
