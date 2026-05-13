import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PpaLocationDataView extends StatefulWidget {
  const PpaLocationDataView({super.key});

  @override
  State<PpaLocationDataView> createState() => _PpaLocationDataViewState();
}

class _PpaLocationDataViewState extends State<PpaLocationDataView> {
  bool showMap = true;
  String selectedTimeframe = "Today";
  
  List<Map<String, dynamic>> locationHistory = [
    {
      "time": "3:45 PM",
      "location": "Golden Gate Park",
      "address": "San Francisco, CA",
      "coordinates": "37.7749° N, 122.4194° W",
      "photos": 15,
      "isActive": true,
    },
    {
      "time": "2:30 PM",
      "location": "Fisherman's Wharf",
      "address": "Pier 39, San Francisco",
      "coordinates": "37.8087° N, 122.4098° W",
      "photos": 8,
      "isActive": false,
    },
    {
      "time": "1:15 PM",
      "location": "Lombard Street",
      "address": "Russian Hill, San Francisco",
      "coordinates": "37.8021° N, 122.4187° W",
      "photos": 12,
      "isActive": false,
    },
    {
      "time": "11:45 AM",
      "location": "Alcatraz Island",
      "address": "San Francisco Bay",
      "coordinates": "37.8267° N, 122.4233° W",
      "photos": 23,
      "isActive": false,
    },
  ];

  List<String> timeframes = ["Today", "Yesterday", "This Week", "This Month"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location Data"),
        actions: [
          QButton(
            icon: showMap ? Icons.list : Icons.map,
            size: bs.sm,
            onPressed: () {
              showMap = !showMap;
              setState(() {});
            },
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.download,
            size: bs.sm,
            onPressed: () {
              ss("Location data exported successfully");
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Timeframe Filter
          Container(
            padding: EdgeInsets.all(spMd),
            child: QCategoryPicker(
              items: timeframes.map((timeframe) => {
                "label": timeframe,
                "value": timeframe,
              }).toList(),
              value: selectedTimeframe,
              onChanged: (index, label, value, item) {
                selectedTimeframe = value;
                setState(() {});
              },
            ),
          ),
          
          // Current Location Card
          Container(
            margin: EdgeInsets.symmetric(horizontal: spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowMd],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        Icons.my_location,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Current Location",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withValues(alpha: 0.8),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Golden Gate Park",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "37.7749° N, 122.4194° W",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withValues(alpha: 0.8),
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
                      child: _buildStatCard("15", "Photos", Icons.photo_camera),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildStatCard("2.3km", "Distance", Icons.straighten),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: _buildStatCard("1h 15m", "Duration", Icons.access_time),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Map or List View
          Expanded(
            child: showMap ? _buildMapView() : _buildListView(),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
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
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapView() {
    return Container(
      margin: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Stack(
        children: [
          // Map placeholder
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusMd),
              image: DecorationImage(
                image: NetworkImage("https://picsum.photos/400/300?random=2&keyword=map"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          // Location pins
          ...locationHistory.asMap().entries.map((entry) {
            int index = entry.key;
            Map<String, dynamic> location = entry.value;
            
            return Positioned(
              left: 50.0 + (index * 80),
              top: 100.0 + (index * 30),
              child: GestureDetector(
                onTap: () {
                  _showLocationDetails(location);
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: location["isActive"] ? primaryColor : successColor,
                    borderRadius: BorderRadius.circular(radiusLg),
                    border: Border.all(color: Colors.white, width: 3),
                    boxShadow: [shadowMd],
                  ),
                  child: Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            );
          }).toList(),
          
          // Map controls
          Positioned(
            top: spMd,
            right: spMd,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: QButton(
                    icon: Icons.zoom_in,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ),
                SizedBox(height: spXs),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: QButton(
                    icon: Icons.zoom_out,
                    size: bs.sm,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spSm,
        children: locationHistory.map((location) {
          return Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
              border: location["isActive"] 
                ? Border.all(color: primaryColor, width: 2)
                : null,
            ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: location["isActive"] 
                      ? primaryColor.withValues(alpha: 0.1) 
                      : successColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    Icons.location_on,
                    color: location["isActive"] ? primaryColor : successColor,
                    size: 24,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${location["location"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          if (location["isActive"]) ...[
                            SizedBox(width: spXs),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "Current",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${location["address"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${location["coordinates"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${location["time"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(width: spMd),
                          Icon(
                            Icons.photo_camera,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${location["photos"]} photos",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _showLocationDetails(location);
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  void _showLocationDetails(Map<String, dynamic> location) {
    // Navigate to location details
    ss("Viewing details for ${location["location"]}");
  }
}
