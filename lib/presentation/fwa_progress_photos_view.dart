import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaProgressPhotosView extends StatefulWidget {
  const FwaProgressPhotosView({super.key});

  @override
  State<FwaProgressPhotosView> createState() => _FwaProgressPhotosViewState();
}

class _FwaProgressPhotosViewState extends State<FwaProgressPhotosView> {
  List<Map<String, dynamic>> photoSessions = [
    {
      "date": "2024-03-15",
      "title": "Month 3 Progress",
      "photos": [
        {
          "type": "front",
          "url": "https://picsum.photos/300/400?random=31&keyword=fitness",
          "angle": "Front View"
        },
        {
          "type": "side",
          "url": "https://picsum.photos/300/400?random=32&keyword=fitness",
          "angle": "Side View"
        },
        {
          "type": "back",
          "url": "https://picsum.photos/300/400?random=33&keyword=fitness",
          "angle": "Back View"
        },
      ],
      "weight": 72.5,
      "bodyFat": 18.5,
      "notes": "Visible muscle definition improvement",
    },
    {
      "date": "2024-02-15",
      "title": "Month 2 Progress",
      "photos": [
        {
          "type": "front",
          "url": "https://picsum.photos/300/400?random=34&keyword=fitness",
          "angle": "Front View"
        },
        {
          "type": "side",
          "url": "https://picsum.photos/300/400?random=35&keyword=fitness",
          "angle": "Side View"
        },
        {
          "type": "back",
          "url": "https://picsum.photos/300/400?random=36&keyword=fitness",
          "angle": "Back View"
        },
      ],
      "weight": 73.8,
      "bodyFat": 19.2,
      "notes": "Starting to see changes in posture",
    },
    {
      "date": "2024-01-15",
      "title": "Month 1 Progress",
      "photos": [
        {
          "type": "front",
          "url": "https://picsum.photos/300/400?random=37&keyword=fitness",
          "angle": "Front View"
        },
        {
          "type": "side",
          "url": "https://picsum.photos/300/400?random=38&keyword=fitness",
          "angle": "Side View"
        },
        {
          "type": "back",
          "url": "https://picsum.photos/300/400?random=39&keyword=fitness",
          "angle": "Back View"
        },
      ],
      "weight": 75.2,
      "bodyFat": 20.8,
      "notes": "Starting point - baseline photos",
    },
  ];

  String selectedView = "Grid";
  List<String> viewOptions = ["Grid", "Timeline", "Compare"];
  
  int selectedSessionIndex = 0;
  String selectedPhotoType = "front";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Progress Photos"),
        actions: [
          IconButton(
            icon: Icon(Icons.view_module),
            onPressed: () {
              _showViewOptions();
            },
          ),
          IconButton(
            icon: Icon(Icons.compare),
            onPressed: () {
              _showCompareView();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProgressOverview(),
            SizedBox(height: spMd),
            _buildViewSelector(),
            SizedBox(height: spMd),
            if (selectedView == "Grid") _buildGridView(),
            if (selectedView == "Timeline") _buildTimelineView(),
            if (selectedView == "Compare") _buildCompareView(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addNewPhotoSession();
        },
        child: Icon(Icons.camera_alt),
      ),
    );
  }

  Widget _buildProgressOverview() {
    Map<String, dynamic> latestSession = photoSessions.first;
    Map<String, dynamic> firstSession = photoSessions.last;

    double weightLoss = (firstSession["weight"] as double) - (latestSession["weight"] as double);
    double bodyFatReduction = (firstSession["bodyFat"] as double) - (latestSession["bodyFat"] as double);

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
                Icons.photo_camera,
                color: Colors.white,
                size: 28,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Photo Journey",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${photoSessions.length} photo sessions captured",
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
                child: _buildOverviewStat(
                  "Weight Lost", 
                  "${weightLoss.toStringAsFixed(1)}kg",
                  Icons.trending_down,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildOverviewStat(
                  "Body Fat", 
                  "-${bodyFatReduction.toStringAsFixed(1)}%",
                  Icons.fitness_center,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildOverviewStat(
                  "Duration", 
                  "3 Months",
                  Icons.schedule,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewStat(String label, String value, IconData icon) {
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
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withAlpha(200),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildViewSelector() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
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
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : primaryColor,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildGridView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "All Photo Sessions",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Column(
          children: photoSessions.map((session) {
            return _buildPhotoSessionCard(session);
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPhotoSessionCard(Map<String, dynamic> session) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
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
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.calendar_today,
                  color: primaryColor,
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${session["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      DateTime.parse("${session["date"]}").dMMMy,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.fullscreen, color: disabledBoldColor),
                onPressed: () {
                  _showFullScreenPhotos(session);
                },
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Text(
                "Weight: ${session["weight"]}kg",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spMd),
              Text(
                "Body Fat: ${session["bodyFat"]}%",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Container(
            height: 120,
            child: QHorizontalScroll(
              children: (session["photos"] as List).map((photo) {
                return Container(
                  margin: EdgeInsets.only(right: spSm),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radiusSm),
                            boxShadow: [shadowSm],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(radiusSm),
                            child: Image.network(
                              "${photo["url"]}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${photo["angle"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          if (session["notes"] != null && (session["notes"] as String).isNotEmpty) ...[
            SizedBox(height: spMd),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(15),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.note,
                    color: primaryColor,
                    size: 16,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "${session["notes"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTimelineView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Progress Timeline",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Column(
          children: photoSessions.asMap().entries.map((entry) {
            int index = entry.key;
            Map<String, dynamic> session = entry.value;
            bool isLast = index == photoSessions.length - 1;

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                        boxShadow: [shadowSm],
                      ),
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    if (!isLast)
                      Container(
                        width: 2,
                        height: 80,
                        color: disabledColor,
                      ),
                  ],
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: spMd),
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
                          "${session["title"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          DateTime.parse("${session["date"]}").dMMMy,
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Container(
                          height: 80,
                          child: QHorizontalScroll(
                            children: (session["photos"] as List).map((photo) {
                              return Container(
                                width: 60,
                                margin: EdgeInsets.only(right: spSm),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  child: Image.network(
                                    "${photo["url"]}",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCompareView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Photo Comparison",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Select Sessions to Compare:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              Row(
                children: [
                  Expanded(
                    child: _buildSessionSelector("Before", photoSessions.last),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: _buildSessionSelector("After", photoSessions.first),
                  ),
                ],
              ),
              SizedBox(height: spMd),
              QHorizontalScroll(
                children: ["front", "side", "back"].map((type) {
                  bool isSelected = selectedPhotoType == type;
                  return Container(
                    margin: EdgeInsets.only(right: spSm),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedPhotoType = type;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor : primaryColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${type.toUpperCase()} VIEW",
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
              SizedBox(height: spMd),
              _buildComparisonPhotos(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSessionSelector(String label, Map<String, dynamic> session) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spXs),
        Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(15),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${session["title"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Text(
                "Weight: ${session["weight"]}kg",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildComparisonPhotos() {
    Map<String, dynamic> beforeSession = photoSessions.last;
    Map<String, dynamic> afterSession = photoSessions.first;

    var beforePhoto = (beforeSession["photos"] as List).firstWhere(
      (photo) => photo["type"] == selectedPhotoType,
    );
    var afterPhoto = (afterSession["photos"] as List).firstWhere(
      (photo) => photo["type"] == selectedPhotoType,
    );

    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Text(
                "BEFORE",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: dangerColor,
                ),
              ),
              SizedBox(height: spSm),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(radiusSm),
                  child: Image.network(
                    "${beforePhoto["url"]}",
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
              SizedBox(height: spSm),
              Text(
                DateTime.parse("${beforeSession["date"]}").dMMMy,
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
              Text(
                "AFTER",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
              SizedBox(height: spSm),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(radiusSm),
                  child: Image.network(
                    "${afterPhoto["url"]}",
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
              SizedBox(height: spSm),
              Text(
                DateTime.parse("${afterSession["date"]}").dMMMy,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _addNewPhotoSession() {
    // Add new photo session logic
  }

  void _showViewOptions() {
    // Show view options
  }

  void _showCompareView() {
    setState(() {
      selectedView = "Compare";
    });
  }

  void _showFullScreenPhotos(Map<String, dynamic> session) {
    // Show full screen photos
  }
}
