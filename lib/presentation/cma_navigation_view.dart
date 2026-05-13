import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaNavigationView extends StatefulWidget {
  const CmaNavigationView({super.key});

  @override
  State<CmaNavigationView> createState() => _CmaNavigationViewState();
}

class _CmaNavigationViewState extends State<CmaNavigationView> {
  String fromLocation = "";
  String toLocation = "";
  String selectedVehicle = "personal";
  bool avoidTolls = false;
  bool avoidHighways = false;
  bool optimizeForFuel = true;

  List<Map<String, dynamic>> vehicleTypes = [
    {"label": "Personal Car", "value": "personal"},
    {"label": "Motorcycle", "value": "motorcycle"},
    {"label": "Truck", "value": "truck"},
    {"label": "Van", "value": "van"}
  ];

  List<Map<String, dynamic>> routeOptions = [
    {
      "id": "route1",
      "name": "Fastest Route",
      "distance": 12.5,
      "duration": "25 mins",
      "fuelCost": 8.50,
      "tollCost": 6.75,
      "traffic": "Light",
      "description": "Via Highway 101 and Market Street",
      "highlights": ["Fastest option", "Some tolls", "Light traffic"],
      "trafficColor": "success"
    },
    {
      "id": "route2", 
      "name": "Scenic Route",
      "distance": 15.8,
      "duration": "32 mins",
      "fuelCost": 10.20,
      "tollCost": 0.00,
      "traffic": "Moderate",
      "description": "Via Embarcadero and Golden Gate Park",
      "highlights": ["No tolls", "Scenic views", "Moderate traffic"],
      "trafficColor": "warning"
    },
    {
      "id": "route3",
      "name": "Economy Route", 
      "distance": 11.2,
      "duration": "28 mins",
      "fuelCost": 7.80,
      "tollCost": 0.00,
      "traffic": "Heavy",
      "description": "Via Local Streets and Mission District",
      "highlights": ["Lowest cost", "No tolls", "Heavy traffic"],
      "trafficColor": "danger"
    }
  ];

  List<Map<String, dynamic>> recentDestinations = [
    {
      "name": "San Francisco Airport",
      "address": "San Francisco, CA 94128",
      "type": "Airport",
      "icon": Icons.flight
    },
    {
      "name": "Union Square",
      "address": "Powell St, San Francisco, CA",
      "type": "Shopping",
      "icon": Icons.shopping_bag
    },
    {
      "name": "Golden Gate Bridge",
      "address": "Golden Gate Bridge, San Francisco, CA",
      "type": "Landmark",
      "icon": Icons.landscape
    },
    {
      "name": "Fisherman's Wharf",
      "address": "Pier 39, San Francisco, CA",
      "type": "Tourist Attraction",
      "icon": Icons.water
    }
  ];

  String selectedRoute = "route1";

  Color _getTrafficColor(String traffic) {
    switch (traffic.toLowerCase()) {
      case 'light':
        return successColor;
      case 'moderate':
        return warningColor;
      case 'heavy':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _startNavigation() {
    if (fromLocation.isEmpty || toLocation.isEmpty) {
      se("Please enter both start and destination locations");
      return;
    }
    
    ss("Navigation started successfully");
    // Navigate to active navigation view
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Navigation"),
        actions: [
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: () {
              // Get current location
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Route Input Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.navigation,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Plan Your Route",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
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
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: successColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QTextField(
                              label: "From",
                              value: fromLocation,
                              hint: "Enter starting location",
                              onChanged: (value) {
                                fromLocation = value;
                                setState(() {});
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          QButton(
                            icon: Icons.my_location,
                            size: bs.sm,
                            onPressed: () {
                              fromLocation = "Current Location";
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: dangerColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: QTextField(
                              label: "To",
                              value: toLocation,
                              hint: "Enter destination",
                              onChanged: (value) {
                                toLocation = value;
                                setState(() {});
                              },
                            ),
                          ),
                          SizedBox(width: spSm),
                          QButton(
                            icon: Icons.swap_vert,
                            size: bs.sm,
                            onPressed: () {
                              String temp = fromLocation;
                              fromLocation = toLocation;
                              toLocation = temp;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Vehicle and Preferences
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.settings,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Preferences",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  QDropdownField(
                    label: "Vehicle Type",
                    items: vehicleTypes,
                    value: selectedVehicle,
                    onChanged: (value, label) {
                      selectedVehicle = value;
                      setState(() {});
                    },
                  ),
                  QSwitch(
                    items: [
                      {
                        "label": "Avoid tolls",
                        "value": "tolls",
                        "checked": avoidTolls,
                      },
                      {
                        "label": "Avoid highways",
                        "value": "highways", 
                        "checked": avoidHighways,
                      },
                      {
                        "label": "Optimize for fuel efficiency",
                        "value": "fuel",
                        "checked": optimizeForFuel,
                      }
                    ],
                    value: [
                      if (avoidTolls) {"label": "Avoid tolls", "value": "tolls", "checked": true},
                      if (avoidHighways) {"label": "Avoid highways", "value": "highways", "checked": true},
                      if (optimizeForFuel) {"label": "Optimize for fuel efficiency", "value": "fuel", "checked": true}
                    ],
                    onChanged: (values, ids) {
                      setState(() {
                        avoidTolls = values.any((v) => v["value"] == "tolls");
                        avoidHighways = values.any((v) => v["value"] == "highways");
                        optimizeForFuel = values.any((v) => v["value"] == "fuel");
                      });
                    },
                  ),
                ],
              ),
            ),

            // Recent Destinations
            Container(
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
                        Icons.history,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Recent Destinations",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.5,
                      crossAxisSpacing: spSm,
                      mainAxisSpacing: spSm,
                    ),
                    itemCount: recentDestinations.length,
                    itemBuilder: (context, index) {
                      final destination = recentDestinations[index];
                      return GestureDetector(
                        onTap: () {
                          toLocation = "${destination["name"]}";
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: primaryColor.withAlpha(30),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                destination["icon"] as IconData,
                                color: primaryColor,
                                size: 32,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${destination["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "${destination["type"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Route Options
            if (fromLocation.isNotEmpty && toLocation.isNotEmpty) ...[
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(spMd),
                      child: Row(
                        children: [
                          Icon(
                            Icons.alt_route,
                            color: primaryColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "Route Options",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: routeOptions.length,
                      separatorBuilder: (context, index) => Divider(
                        height: 1,
                        color: disabledOutlineBorderColor,
                      ),
                      itemBuilder: (context, index) {
                        final route = routeOptions[index];
                        final isSelected = selectedRoute == route["id"];
                        
                        return GestureDetector(
                          onTap: () {
                            selectedRoute = "${route["id"]}";
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.all(spMd),
                            color: isSelected ? primaryColor.withAlpha(10) : Colors.transparent,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Radio<String>(
                                      value: "${route["id"]}",
                                      groupValue: selectedRoute,
                                      onChanged: (value) {
                                        selectedRoute = value!;
                                        setState(() {});
                                      },
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "${route["name"]}",
                                                style: TextStyle(
                                                  fontSize: fsH6,
                                                  fontWeight: FontWeight.bold,
                                                  color: primaryColor,
                                                ),
                                              ),
                                              Spacer(),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: spSm,
                                                  vertical: spXs,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: _getTrafficColor("${route["traffic"]}").withAlpha(30),
                                                  borderRadius: BorderRadius.circular(radiusSm),
                                                ),
                                                child: Text(
                                                  "${route["traffic"]} Traffic",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: _getTrafficColor("${route["traffic"]}"),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: spXs),
                                          Text(
                                            "${route["description"]}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spSm),
                                
                                // Route Stats
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.all(spSm),
                                        decoration: BoxDecoration(
                                          color: infoColor.withAlpha(10),
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.straighten,
                                              color: infoColor,
                                              size: 20,
                                            ),
                                            SizedBox(height: spXs),
                                            Text(
                                              "${(route["distance"] as double).toStringAsFixed(1)} mi",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: infoColor,
                                              ),
                                            ),
                                            Text(
                                              "Distance",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.all(spSm),
                                        decoration: BoxDecoration(
                                          color: warningColor.withAlpha(10),
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.schedule,
                                              color: warningColor,
                                              size: 20,
                                            ),
                                            SizedBox(height: spXs),
                                            Text(
                                              "${route["duration"]}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: warningColor,
                                              ),
                                            ),
                                            Text(
                                              "Duration",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.all(spSm),
                                        decoration: BoxDecoration(
                                          color: successColor.withAlpha(10),
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.attach_money,
                                              color: successColor,
                                              size: 20,
                                            ),
                                            SizedBox(height: spXs),
                                            Text(
                                              "\$${((route["fuelCost"] as double) + (route["tollCost"] as double)).currency}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: successColor,
                                              ),
                                            ),
                                            Text(
                                              "Total Cost",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spSm),

                                // Route Highlights
                                Wrap(
                                  spacing: spXs,
                                  runSpacing: spXs,
                                  children: (route["highlights"] as List).map<Widget>((highlight) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spSm,
                                        vertical: spXs,
                                      ),
                                      decoration: BoxDecoration(
                                        color: primaryColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusSm),
                                      ),
                                      child: Text(
                                        "$highlight",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: primaryColor,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              // Start Navigation Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Start Navigation",
                  icon: Icons.navigation,
                  size: bs.md,
                  onPressed: _startNavigation,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
