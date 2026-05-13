import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaBeforeAfterView extends StatefulWidget {
  const FwaBeforeAfterView({super.key});

  @override
  State<FwaBeforeAfterView> createState() => _FwaBeforeAfterViewState();
}

class _FwaBeforeAfterViewState extends State<FwaBeforeAfterView> {
  List<Map<String, dynamic>> transformations = [
    {
      "id": "transformation_1",
      "title": "3-Month Body Transformation",
      "startDate": "2024-01-15",
      "endDate": "2024-04-15",
      "duration": "3 months",
      "beforePhotos": [
        {
          "angle": "Front",
          "url": "https://picsum.photos/300/400?random=40&keyword=fitness",
        },
        {
          "angle": "Side",
          "url": "https://picsum.photos/300/400?random=41&keyword=fitness",
        },
        {
          "angle": "Back",
          "url": "https://picsum.photos/300/400?random=42&keyword=fitness",
        },
      ],
      "afterPhotos": [
        {
          "angle": "Front",
          "url": "https://picsum.photos/300/400?random=43&keyword=fitness",
        },
        {
          "angle": "Side",
          "url": "https://picsum.photos/300/400?random=44&keyword=fitness",
        },
        {
          "angle": "Back",
          "url": "https://picsum.photos/300/400?random=45&keyword=fitness",
        },
      ],
      "beforeStats": {
        "weight": 78.5,
        "bodyFat": 22.3,
        "muscleMass": 58.2,
        "waist": 89.0,
      },
      "afterStats": {
        "weight": 72.5,
        "bodyFat": 16.8,
        "muscleMass": 62.4,
        "waist": 82.0,
      },
      "achievements": [
        "Lost 6kg body weight",
        "Reduced body fat by 5.5%",
        "Gained 4.2kg muscle mass",
        "Reduced waist by 7cm",
      ],
      "story": "Started my fitness journey with determination to transform my body and improve my health. Through consistent training and proper nutrition, I achieved results beyond my expectations.",
    },
    {
      "id": "transformation_2",
      "title": "6-Month Muscle Building",
      "startDate": "2023-10-15",
      "endDate": "2024-04-15",
      "duration": "6 months",
      "beforePhotos": [
        {
          "angle": "Front",
          "url": "https://picsum.photos/300/400?random=46&keyword=fitness",
        },
        {
          "angle": "Side",
          "url": "https://picsum.photos/300/400?random=47&keyword=fitness",
        },
        {
          "angle": "Back",
          "url": "https://picsum.photos/300/400?random=48&keyword=fitness",
        },
      ],
      "afterPhotos": [
        {
          "angle": "Front",
          "url": "https://picsum.photos/300/400?random=49&keyword=fitness",
        },
        {
          "angle": "Side",
          "url": "https://picsum.photos/300/400?random=50&keyword=fitness",
        },
        {
          "angle": "Back",
          "url": "https://picsum.photos/300/400?random=51&keyword=fitness",
        },
      ],
      "beforeStats": {
        "weight": 68.2,
        "bodyFat": 12.8,
        "muscleMass": 55.1,
        "chest": 92.0,
      },
      "afterStats": {
        "weight": 74.6,
        "bodyFat": 11.2,
        "muscleMass": 63.8,
        "chest": 102.0,
      },
      "achievements": [
        "Gained 6.4kg body weight",
        "Reduced body fat by 1.6%",
        "Gained 8.7kg muscle mass",
        "Increased chest by 10cm",
      ],
      "story": "Focused on clean bulk and strength training to build lean muscle mass while maintaining low body fat percentage. Consistent progressive overload was key to success.",
    },
  ];

  int selectedTransformationIndex = 0;
  String selectedView = "Side by Side";
  List<String> viewOptions = ["Side by Side", "Before/After Slider", "Stats Comparison"];
  int selectedAngleIndex = 0;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> currentTransformation = transformations[selectedTransformationIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text("Before & After"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              _shareTransformation();
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              _downloadComparison();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTransformationSelector(),
            SizedBox(height: spMd),
            _buildTransformationHeader(currentTransformation),
            SizedBox(height: spMd),
            _buildViewModeSelector(),
            SizedBox(height: spMd),
            if (selectedView == "Side by Side") _buildSideBySideView(currentTransformation),
            if (selectedView == "Before/After Slider") _buildSliderView(currentTransformation),
            if (selectedView == "Stats Comparison") _buildStatsComparison(currentTransformation),
            SizedBox(height: spMd),
            _buildAchievements(currentTransformation),
            SizedBox(height: spMd),
            _buildTransformationStory(currentTransformation),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _createNewTransformation();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildTransformationSelector() {
    return Container(
      height: 100,
      child: QHorizontalScroll(
        children: transformations.asMap().entries.map((entry) {
          int index = entry.key;
          Map<String, dynamic> transformation = entry.value;
          bool isSelected = selectedTransformationIndex == index;

          return Container(
            width: 200,
            margin: EdgeInsets.only(right: spSm),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedTransformationIndex = index;
                });
              },
              child: Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor : Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: isSelected ? null : Border.all(color: disabledColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${transformation["title"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.white : primaryColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${transformation["duration"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: isSelected ? Colors.white.withAlpha(200) : disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(
                          Icons.trending_up,
                          size: 16,
                          color: isSelected ? Colors.white : successColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${transformation["achievements"].length} goals",
                          style: TextStyle(
                            fontSize: 10,
                            color: isSelected ? Colors.white.withAlpha(200) : disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTransformationHeader(Map<String, dynamic> transformation) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(180)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.transform,
                color: Colors.white,
                size: 28,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${transformation["title"]}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${DateTime.parse(transformation["startDate"]).dMMMy} - ${DateTime.parse(transformation["endDate"]).dMMMy}",
                      style: TextStyle(
                        color: Colors.white.withAlpha(200),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: _buildHeaderStat(
                  "Duration", 
                  "${transformation["duration"]}",
                  Icons.schedule,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildHeaderStat(
                  "Weight Change", 
                  "${((transformation["afterStats"]["weight"] as double) - (transformation["beforeStats"]["weight"] as double)).toStringAsFixed(1)}kg",
                  Icons.monitor_weight,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildHeaderStat(
                  "Achievements", 
                  "${transformation["achievements"].length}",
                  Icons.emoji_events,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderStat(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(50),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withAlpha(200),
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildViewModeSelector() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Row(
            children: viewOptions.map((view) {
              bool isSelected = selectedView == view;
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedView = view;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: spSm),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : Colors.transparent,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      view,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : primaryColor,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          if (selectedView != "Stats Comparison") ...[
            SizedBox(height: spSm),
            QHorizontalScroll(
              children: ["Front", "Side", "Back"].asMap().entries.map((entry) {
                int index = entry.key;
                String angle = entry.value;
                bool isSelected = selectedAngleIndex == index;

                return Container(
                  margin: EdgeInsets.only(right: spSm),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedAngleIndex = index;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                      decoration: BoxDecoration(
                        color: isSelected ? successColor : successColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "$angle View",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : successColor,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSideBySideView(Map<String, dynamic> transformation) {
    var beforePhoto = (transformation["beforePhotos"] as List)[selectedAngleIndex];
    var afterPhoto = (transformation["afterPhotos"] as List)[selectedAngleIndex];

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Text(
            "${beforePhoto["angle"]} View Comparison",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                      decoration: BoxDecoration(
                        color: dangerColor,
                        borderRadius: BorderRadius.circular(radiusSm),
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
                    SizedBox(height: spSm),
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowMd],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(radiusMd),
                        child: Image.network(
                          "${beforePhoto["url"]}",
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      DateTime.parse("${transformation["startDate"]}").dMMMy,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                      decoration: BoxDecoration(
                        color: successColor,
                        borderRadius: BorderRadius.circular(radiusSm),
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
                    SizedBox(height: spSm),
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowMd],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(radiusMd),
                        child: Image.network(
                          "${afterPhoto["url"]}",
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      DateTime.parse("${transformation["endDate"]}").dMMMy,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSliderView(Map<String, dynamic> transformation) {
    var beforePhoto = (transformation["beforePhotos"] as List)[selectedAngleIndex];
    var afterPhoto = (transformation["afterPhotos"] as List)[selectedAngleIndex];

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Text(
            "Before/After Slider",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Container(
            height: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowMd],
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(radiusMd),
                  child: Image.network(
                    "${beforePhoto["url"]}",
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
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
                      "BEFORE",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Icon(Icons.swipe, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "Swipe to reveal after photo",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsComparison(Map<String, dynamic> transformation) {
    Map<String, dynamic> beforeStats = transformation["beforeStats"];
    Map<String, dynamic> afterStats = transformation["afterStats"];

    List<Map<String, dynamic>> statComparisons = [];
    
    beforeStats.forEach((key, beforeValue) {
      if (afterStats.containsKey(key)) {
        double before = (beforeValue as num).toDouble();
        double after = (afterStats[key] as num).toDouble();
        double change = after - before;
        
        statComparisons.add({
          "metric": key,
          "before": before,
          "after": after,
          "change": change,
          "isPositive": _isPositiveChange(key, change),
        });
      }
    });

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Stats Comparison",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Column(
            children: statComparisons.map((stat) {
              return _buildStatComparisonRow(stat);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildStatComparisonRow(Map<String, dynamic> stat) {
    Color changeColor = stat["isPositive"] ? successColor : dangerColor;
    IconData changeIcon = stat["isPositive"] ? Icons.trending_up : Icons.trending_down;
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(15),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _getMetricDisplayName("${stat["metric"]}"),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "BEFORE",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${(stat["before"] as double).toStringAsFixed(1)}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward,
                color: primaryColor,
                size: 20,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "AFTER",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${(stat["after"] as double).toStringAsFixed(1)}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: changeColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      changeIcon,
                      color: changeColor,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${(stat["change"] as double).abs().toStringAsFixed(1)}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: changeColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAchievements(Map<String, dynamic> transformation) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Key Achievements",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Column(
            children: (transformation["achievements"] as List).map((achievement) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(15),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: successColor,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: successColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "$achievement",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTransformationStory(Map<String, dynamic> transformation) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.auto_stories,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Transformation Story",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            "${transformation["story"]}",
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  String _getMetricDisplayName(String metric) {
    switch (metric) {
      case "weight":
        return "Weight (kg)";
      case "bodyFat":
        return "Body Fat (%)";
      case "muscleMass":
        return "Muscle Mass (kg)";
      case "waist":
        return "Waist (cm)";
      case "chest":
        return "Chest (cm)";
      default:
        return metric;
    }
  }

  bool _isPositiveChange(String metric, double change) {
    switch (metric) {
      case "weight":
      case "bodyFat":
      case "waist":
        return change < 0; // Loss is positive for these metrics
      case "muscleMass":
      case "chest":
        return change > 0; // Gain is positive for these metrics
      default:
        return change > 0;
    }
  }

  void _createNewTransformation() {
    // Create new transformation logic
  }

  void _shareTransformation() {
    // Share transformation logic
  }

  void _downloadComparison() {
    // Download comparison image logic
  }
}
