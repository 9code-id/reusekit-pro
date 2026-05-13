import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class WcaLocationSetupView extends StatefulWidget {
  const WcaLocationSetupView({super.key});

  @override
  State<WcaLocationSetupView> createState() => _WcaLocationSetupViewState();
}

class _WcaLocationSetupViewState extends State<WcaLocationSetupView> {
  bool useCurrentLocation = true;
  bool isDetectingLocation = false;
  String detectedLocation = "";
  String selectedLocation = "";

  final List<Map<String, dynamic>> recentLocations = [
    {
      "name": "New York, NY",
      "country": "United States",
      "coordinates": "40.7128°N, 74.0060°W",
      "icon": Icons.location_city,
    },
    {
      "name": "London, UK",
      "country": "United Kingdom", 
      "coordinates": "51.5074°N, 0.1278°W",
      "icon": Icons.location_city,
    },
    {
      "name": "Tokyo, Japan",
      "country": "Japan",
      "coordinates": "35.6762°N, 139.6503°E",
      "icon": Icons.location_city,
    },
  ];

  Future<void> _detectCurrentLocation() async {
    isDetectingLocation = true;
    setState(() {});

    // Simulate location detection
    await Future.delayed(Duration(seconds: 3));

    detectedLocation = "San Francisco, CA";
    selectedLocation = detectedLocation;
    isDetectingLocation = false;
    useCurrentLocation = true;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _detectCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location Setup"),
        actions: [
          if (selectedLocation.isNotEmpty)
            TextButton(
              onPressed: () {
                // Navigate to home with selected location
              },
              child: Text(
                "Done",
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Location Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: useCurrentLocation ? primaryColor.withAlpha(20) : Colors.grey.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: useCurrentLocation ? primaryColor : Colors.grey.withAlpha(100),
                  width: 2,
                ),
              ),
              child: Row(
                children: [
                  Radio<bool>(
                    value: true,
                    groupValue: useCurrentLocation,
                    onChanged: (value) {
                      if (!isDetectingLocation) {
                        useCurrentLocation = value!;
                        if (useCurrentLocation) {
                          selectedLocation = detectedLocation;
                        }
                        setState(() {});
                      }
                    },
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.my_location,
                              color: useCurrentLocation ? primaryColor : disabledColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Use Current Location",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: useCurrentLocation ? primaryColor : disabledColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        if (isDetectingLocation)
                          Row(
                            children: [
                              SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "Detecting location...",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          )
                        else if (detectedLocation.isNotEmpty)
                          Text(
                            detectedLocation,
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (!isDetectingLocation && detectedLocation.isEmpty)
                    GestureDetector(
                      onTap: _detectCurrentLocation,
                      child: Icon(
                        Icons.refresh,
                        color: primaryColor,
                      ),
                    ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Manual Location Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: !useCurrentLocation ? primaryColor.withAlpha(20) : Colors.grey.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: !useCurrentLocation ? primaryColor : Colors.grey.withAlpha(100),
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Radio<bool>(
                        value: false,
                        groupValue: useCurrentLocation,
                        onChanged: (value) {
                          useCurrentLocation = value!;
                          setState(() {});
                        },
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: !useCurrentLocation ? primaryColor : disabledColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Choose Location Manually",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: !useCurrentLocation ? primaryColor : disabledColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (!useCurrentLocation) ...[
                    SizedBox(height: spMd),
                    GestureDetector(
                      onTap: () {
                        // Navigate to manual location search
                      },
                      child: Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(color: Colors.grey.withAlpha(100)),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: disabledBoldColor,
                              size: 20,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Search for a city or location",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: disabledBoldColor,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Recent Locations
            Text(
              "Recent Locations",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),

            ...List.generate(recentLocations.length, (index) {
              final location = recentLocations[index];
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: GestureDetector(
                  onTap: () {
                    selectedLocation = "${location["name"]}";
                    useCurrentLocation = false;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            location["icon"],
                            color: primaryColor,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${location["name"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${location["country"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${location["coordinates"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (selectedLocation == location["name"])
                          Icon(
                            Icons.check_circle,
                            color: successColor,
                            size: 24,
                          )
                        else
                          Icon(
                            Icons.arrow_forward_ios,
                            color: disabledBoldColor,
                            size: 16,
                          ),
                      ],
                    ),
                  ),
                ),
              );
            }),

            SizedBox(height: spLg),

            QButton(
              label: "Continue",
              size: bs.md,
              onPressed: selectedLocation.isNotEmpty ? () {
                // Navigate to home
              } : null,
            ),
          ],
        ),
      ),
    );
  }
}
