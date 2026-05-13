import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsLocationPickerView extends StatefulWidget {
  const BrsLocationPickerView({super.key});

  @override
  State<BrsLocationPickerView> createState() => _BrsLocationPickerViewState();
}

class _BrsLocationPickerViewState extends State<BrsLocationPickerView> {
  String searchQuery = "";
  String selectedAddress = "";
  bool useCurrentLocation = false;
  
  List<Map<String, dynamic>> recentLocations = [
    {
      "title": "Home",
      "address": "123 Main Street, Downtown, NY 10001",
      "type": "home",
      "icon": Icons.home,
    },
    {
      "title": "Work",
      "address": "456 Business Ave, Financial District, NY 10005",
      "type": "work",
      "icon": Icons.work,
    },
    {
      "title": "Gym",
      "address": "789 Fitness Blvd, Sports Complex, NY 10003",
      "type": "gym",
      "icon": Icons.fitness_center,
    },
  ];

  List<Map<String, dynamic>> searchResults = [
    {
      "title": "Central Park Barbershop",
      "address": "Central Park West, Upper West Side, NY 10024",
      "distance": "2.1 km",
      "type": "barbershop",
    },
    {
      "title": "Manhattan Mall",
      "address": "100 W 33rd St, Herald Square, NY 10001",
      "distance": "3.5 km",
      "type": "mall",
    },
    {
      "title": "Times Square",
      "address": "Times Square, Midtown, NY 10036",
      "distance": "4.2 km",
      "type": "landmark",
    },
    {
      "title": "Brooklyn Bridge",
      "address": "Brooklyn Bridge, NYC, NY 10038",
      "distance": "5.8 km",
      "type": "landmark",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose Location"),
        actions: [
          TextButton(
            onPressed: selectedAddress.isNotEmpty ? () {
              ss("Location selected: $selectedAddress");
              back();
            } : null,
            child: Text(
              "Done",
              style: TextStyle(
                color: selectedAddress.isNotEmpty ? primaryColor : disabledBoldColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: disabledBoldColor,
                      size: 20,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QTextField(
                        label: "Search for location",
                        value: searchQuery,
                        hint: "Enter address, landmark, or area",
                        onChanged: (value) {
                          searchQuery = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                // Current Location Option
                GestureDetector(
                  onTap: () {
                    useCurrentLocation = !useCurrentLocation;
                    if (useCurrentLocation) {
                      selectedAddress = "Current Location";
                    } else {
                      selectedAddress = "";
                    }
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: useCurrentLocation ? primaryColor.withAlpha(50) : Colors.transparent,
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: useCurrentLocation ? primaryColor : disabledOutlineBorderColor,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.my_location,
                          color: useCurrentLocation ? primaryColor : disabledBoldColor,
                          size: 20,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Use Current Location",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: useCurrentLocation ? primaryColor : Colors.black,
                                ),
                              ),
                              Text(
                                "Automatically detect your location",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (useCurrentLocation)
                          Icon(
                            Icons.check_circle,
                            color: successColor,
                            size: 20,
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Recent Locations
                  if (recentLocations.isNotEmpty) ...[
                    Text(
                      "Recent Locations",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    
                    ...recentLocations.map((location) {
                      bool isSelected = selectedAddress == location["address"];
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        child: GestureDetector(
                          onTap: () {
                            selectedAddress = "${location["address"]}";
                            useCurrentLocation = false;
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: isSelected ? primaryColor.withAlpha(50) : Colors.white,
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: isSelected ? primaryColor : disabledOutlineBorderColor,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: isSelected ? primaryColor : disabledColor,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Icon(
                                    location["icon"] as IconData,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${location["title"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: isSelected ? primaryColor : Colors.black,
                                        ),
                                      ),
                                      Text(
                                        "${location["address"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                if (isSelected)
                                  Icon(
                                    Icons.check_circle,
                                    color: successColor,
                                    size: 20,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    
                    SizedBox(height: spMd),
                  ],
                  
                  // Search Results
                  if (searchQuery.isNotEmpty) ...[
                    Row(
                      children: [
                        Text(
                          "Search Results",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${searchResults.length} results",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    
                    ...searchResults.map((result) {
                      bool isSelected = selectedAddress == result["address"];
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        child: GestureDetector(
                          onTap: () {
                            selectedAddress = "${result["address"]}";
                            useCurrentLocation = false;
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: isSelected ? primaryColor.withAlpha(50) : Colors.white,
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: isSelected ? primaryColor : disabledOutlineBorderColor,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: isSelected ? primaryColor : disabledBoldColor,
                                  size: 20,
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${result["title"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: isSelected ? primaryColor : Colors.black,
                                        ),
                                      ),
                                      Text(
                                        "${result["address"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      if (result["distance"] != null)
                                        Text(
                                          "${result["distance"]}",
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: primaryColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    if (isSelected)
                                      Icon(
                                        Icons.check_circle,
                                        color: successColor,
                                        size: 20,
                                      ),
                                    SizedBox(height: spXs),
                                    GestureDetector(
                                      onTap: () {
                                        ss("Viewing on map");
                                      },
                                      child: Icon(
                                        Icons.map,
                                        color: disabledBoldColor,
                                        size: 16,
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
                  ] else ...[
                    // Suggestions when not searching
                    Text(
                      "Suggestions",
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
                        color: infoColor.withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: infoColor.withAlpha(100)),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.location_searching,
                            color: infoColor,
                            size: 32,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Find Nearby Barbershops",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: infoColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Select a location to discover barbershops around you",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          
          // Bottom Action
          if (selectedAddress.isNotEmpty)
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [shadowSm],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusSm),
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Selected Location",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                selectedAddress,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: spSm),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Confirm Location",
                      onPressed: () {
                        ss("Location confirmed: $selectedAddress");
                        back();
                      },
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
