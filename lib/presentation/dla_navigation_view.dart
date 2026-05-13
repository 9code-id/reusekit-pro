import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DlaNavigationView extends StatefulWidget {
  const DlaNavigationView({super.key});

  @override
  State<DlaNavigationView> createState() => _DlaNavigationViewState();
}

class _DlaNavigationViewState extends State<DlaNavigationView> {
  String selectedRoute = "fastest";
  bool isNavigating = false;
  bool voiceGuidance = true;
  bool showTraffic = true;
  String currentInstruction = "In 200m, turn right onto Main Street";
  String nextInstruction = "Then continue straight for 1.2 km";
  double progressPercentage = 45.0;

  List<Map<String, dynamic>> routeOptions = [
    {
      "id": "fastest",
      "name": "Fastest Route",
      "duration": "25 min",
      "distance": "12.5 km",
      "traffic": "light",
      "icon": Icons.speed,
      "color": successColor,
    },
    {
      "id": "shortest",
      "name": "Shortest Route", 
      "duration": "32 min",
      "distance": "8.3 km",
      "traffic": "moderate",
      "icon": Icons.straighten,
      "color": primaryColor,
    },
    {
      "id": "eco",
      "name": "Eco Route",
      "duration": "28 min",
      "distance": "11.2 km",
      "traffic": "light",
      "icon": Icons.eco,
      "color": successColor,
    },
  ];

  List<Map<String, dynamic>> navigationSteps = [
    {
      "instruction": "Head north on Oak Street",
      "distance": "0.5 km",
      "icon": Icons.arrow_upward,
      "completed": true,
    },
    {
      "instruction": "Turn right onto Main Street",
      "distance": "0.2 km",
      "icon": Icons.turn_right,
      "completed": false,
      "current": true,
    },
    {
      "instruction": "Continue straight for 1.2 km",
      "distance": "1.2 km",
      "icon": Icons.arrow_upward,
      "completed": false,
    },
    {
      "instruction": "Turn left onto Highway 101",
      "distance": "0.3 km",
      "icon": Icons.turn_left,
      "completed": false,
    },
    {
      "instruction": "Take exit 15 toward Downtown",
      "distance": "2.1 km", 
      "icon": Icons.exit_to_app,
      "completed": false,
    },
    {
      "instruction": "Arrive at destination",
      "distance": "0.1 km",
      "icon": Icons.location_on,
      "completed": false,
    },
  ];

  Map<String, dynamic> currentDelivery = {
    "id": "DEL001",
    "customer": "John Smith",
    "address": "123 Main Street, Downtown",
    "phone": "+1 (555) 123-4567",
    "eta": "10:30 AM",
    "packages": 2,
    "priority": "high",
    "notes": "Ring doorbell twice, leave at front door if no answer",
  };

  Map<String, dynamic> routeProgress = {
    "totalDistance": "12.5 km",
    "remainingDistance": "6.8 km",
    "totalTime": "25 min",
    "remainingTime": "14 min",
    "averageSpeed": "28 km/h",
    "currentSpeed": "35 km/h",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Navigation"),
        actions: [
          QButton(
            icon: voiceGuidance ? Icons.volume_up : Icons.volume_off,
            size: bs.sm,
            onPressed: () => _toggleVoiceGuidance(),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.settings,
            size: bs.sm,
            onPressed: () => _showNavigationSettings(),
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: Column(
        children: [
          if (!isNavigating) _buildRouteSelection(),
          if (isNavigating) ...[
            _buildNavigationHeader(),
            _buildMapContainer(),
            _buildNavigationControls(),
          ],
        ],
      ),
    );
  }

  Widget _buildRouteSelection() {
    return Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Destination Info
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Delivery Destination",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${currentDelivery["address"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
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
                        child: _buildInfoChip(
                          "${currentDelivery["customer"]}",
                          Icons.person,
                          primaryColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildInfoChip(
                          "Priority: ${currentDelivery["priority"]}",
                          Icons.priority_high,
                          currentDelivery["priority"] == "high" ? dangerColor : warningColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Route Options
            Text(
              "Choose Route",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            Column(
              children: List.generate(routeOptions.length, (index) {
                final route = routeOptions[index];
                final isSelected = selectedRoute == route["id"];
                
                return GestureDetector(
                  onTap: () {
                    selectedRoute = route["id"];
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor.withAlpha(20) : Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledColor,
                        width: isSelected ? 2 : 1,
                      ),
                      boxShadow: [shadowSm],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: route["color"].withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            route["icon"],
                            color: route["color"],
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${route["name"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Text(
                                    "${route["duration"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "• ${route["distance"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: route["traffic"] == "light" 
                                ? successColor.withAlpha(20)
                                : warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${route["traffic"]} traffic",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: route["traffic"] == "light" ? successColor : warningColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),

            SizedBox(height: spMd),

            // Start Navigation Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Start Navigation",
                icon: Icons.navigation,
                size: bs.md,
                onPressed: () => _startNavigation(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor,
        boxShadow: [shadowMd],
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Current Instruction
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    Icons.turn_right,
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
                        "In 200m",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                      Text(
                        currentInstruction,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Progress and ETA
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "ETA: ${currentDelivery["eta"]}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "${routeProgress["remainingDistance"]} • ${routeProgress["remainingTime"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spMd,
                    vertical: spSm,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Text(
                    "${routeProgress["currentSpeed"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Progress Bar
            Container(
              width: double.infinity,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(50),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: progressPercentage / 100,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMapContainer() {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          image: DecorationImage(
            image: NetworkImage("https://picsum.photos/800/600?random=101&keyword=navigation"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // Route Line
            Positioned(
              left: 50,
              top: 100,
              child: Container(
                width: 250,
                height: 4,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
              ),
            ),
            
            // Current Location
            Positioned(
              left: 60,
              top: 98,
              child: Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: successColor,
                  shape: BoxShape.circle,
                  boxShadow: [shadowMd],
                ),
                child: Icon(
                  Icons.navigation,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
            
            // Destination
            Positioned(
              right: 60,
              bottom: 120,
              child: Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: dangerColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowMd],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.white,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${currentDelivery["id"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Next Turn Preview
            Positioned(
              top: spMd,
              right: spMd,
              child: Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.arrow_upward,
                      color: primaryColor,
                      size: 24,
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "1.2 km",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationControls() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowMd],
      ),
      child: Row(
        children: [
          Expanded(
            child: QButton(
              label: "End Navigation",
              icon: Icons.stop,
              size: bs.sm,
              color: dangerColor,
              onPressed: () => _endNavigation(),
            ),
          ),
          SizedBox(width: spMd),
          QButton(
            icon: Icons.phone,
            size: bs.sm,
            onPressed: () => _callCustomer(),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.list,
            size: bs.sm,
            onPressed: () => _showRouteSteps(),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.my_location,
            size: bs.sm,
            onPressed: () => _centerOnCurrentLocation(),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(String text, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: spSm,
        vertical: spXs,
      ),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: color,
            size: 16,
          ),
          SizedBox(width: spXs),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  void _startNavigation() {
    isNavigating = true;
    setState(() {});
    ss("Navigation started");
  }

  void _endNavigation() {
    isNavigating = false;
    setState(() {});
    ss("Navigation ended");
  }

  void _toggleVoiceGuidance() {
    voiceGuidance = !voiceGuidance;
    setState(() {});
    ss("Voice guidance ${voiceGuidance ? "enabled" : "disabled"}");
  }

  void _callCustomer() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Call Customer"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Call ${currentDelivery["customer"]}?"),
            SizedBox(height: spSm),
            Text(
              "${currentDelivery["phone"]}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Call",
            size: bs.sm,
            onPressed: () {
              back();
              ss("Calling customer...");
            },
          ),
        ],
      ),
    );
  }

  void _showRouteSteps() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Route Steps",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            Expanded(
              child: ListView.builder(
                itemCount: navigationSteps.length,
                itemBuilder: (context, index) {
                  final step = navigationSteps[index];
                  final isCompleted = step["completed"] == true;
                  final isCurrent = step["current"] == true;
                  
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: isCurrent 
                          ? primaryColor.withAlpha(20)
                          : isCompleted 
                              ? successColor.withAlpha(20)
                              : Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          step["icon"],
                          color: isCurrent 
                              ? primaryColor
                              : isCompleted 
                                  ? successColor
                                  : disabledBoldColor,
                          size: 20,
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${step["instruction"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${step["distance"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isCompleted)
                          Icon(
                            Icons.check_circle,
                            color: successColor,
                            size: 16,
                          ),
                        if (isCurrent)
                          Icon(
                            Icons.my_location,
                            color: primaryColor,
                            size: 16,
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showNavigationSettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Navigation Settings"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CheckboxListTile(
              title: Text("Voice Guidance"),
              value: voiceGuidance,
              activeColor: primaryColor,
              onChanged: (value) {
                voiceGuidance = value ?? false;
                setState(() {});
              },
            ),
            CheckboxListTile(
              title: Text("Show Traffic"),
              value: showTraffic,
              activeColor: primaryColor,
              onChanged: (value) {
                showTraffic = value ?? false;
                setState(() {});
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => back(),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Save",
            size: bs.sm,
            onPressed: () => back(),
          ),
        ],
      ),
    );
  }

  void _centerOnCurrentLocation() {
    ss("Centered on current location");
  }
}
