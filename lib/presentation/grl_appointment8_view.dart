import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlAppointment8View extends StatefulWidget {
  @override
  State<GrlAppointment8View> createState() => _GrlAppointment8ViewState();
}

class _GrlAppointment8ViewState extends State<GrlAppointment8View> {
  String searchQuery = "";
  String selectedSpecialty = "";
  String selectedLocation = "";
  String selectedDate = "";
  String selectedTime = "";
  String sortBy = "rating";

  List<Map<String, dynamic>> doctors = [
    {
      "id": 1,
      "name": "Dr. Sarah Johnson",
      "specialty": "Cardiologist",
      "rating": 4.9,
      "reviewCount": 127,
      "experience": "15 years",
      "hospital": "City Medical Center",
      "location": "Downtown",
      "distance": "2.5 km",
      "nextAvailable": "2024-01-15",
      "price": 150.0,
      "image": "https://picsum.photos/80/80?random=1&keyword=doctor",
      "verified": true,
      "languages": ["English", "Spanish"],
      "availableToday": true,
    },
    {
      "id": 2,
      "name": "Dr. Michael Chen",
      "specialty": "Dermatologist",
      "rating": 4.8,
      "reviewCount": 89,
      "experience": "12 years",
      "hospital": "Skin Care Clinic",
      "location": "Midtown",
      "distance": "1.8 km",
      "nextAvailable": "2024-01-16",
      "price": 120.0,
      "image": "https://picsum.photos/80/80?random=2&keyword=doctor",
      "verified": true,
      "languages": ["English", "Mandarin"],
      "availableToday": false,
    },
    {
      "id": 3,
      "name": "Dr. Emily Davis",
      "specialty": "Pediatrician",
      "rating": 4.7,
      "reviewCount": 156,
      "experience": "8 years",
      "hospital": "Children's Hospital",
      "location": "Northside",
      "distance": "3.2 km",
      "nextAvailable": "2024-01-14",
      "price": 80.0,
      "image": "https://picsum.photos/80/80?random=3&keyword=doctor",
      "verified": true,
      "languages": ["English", "French"],
      "availableToday": true,
    },
    {
      "id": 4,
      "name": "Dr. Robert Wilson",
      "specialty": "Orthopedist",
      "rating": 4.6,
      "reviewCount": 73,
      "experience": "20 years",
      "hospital": "Bone & Joint Center",
      "location": "Westside",
      "distance": "4.1 km",
      "nextAvailable": "2024-01-17",
      "price": 200.0,
      "image": "https://picsum.photos/80/80?random=4&keyword=doctor",
      "verified": true,
      "languages": ["English"],
      "availableToday": false,
    },
    {
      "id": 5,
      "name": "Dr. Lisa Martinez",
      "specialty": "Gynecologist",
      "rating": 4.9,
      "reviewCount": 98,
      "experience": "10 years",
      "hospital": "Women's Health Center",
      "location": "Downtown",
      "distance": "2.0 km",
      "nextAvailable": "2024-01-15",
      "price": 130.0,
      "image": "https://picsum.photos/80/80?random=5&keyword=doctor",
      "verified": true,
      "languages": ["English", "Spanish"],
      "availableToday": true,
    },
  ];

  List<Map<String, dynamic>> specialties = [
    {"label": "All Specialties", "value": ""},
    {"label": "Cardiologist", "value": "Cardiologist"},
    {"label": "Dermatologist", "value": "Dermatologist"},
    {"label": "Pediatrician", "value": "Pediatrician"},
    {"label": "Orthopedist", "value": "Orthopedist"},
    {"label": "Gynecologist", "value": "Gynecologist"},
  ];

  List<Map<String, dynamic>> locations = [
    {"label": "All Locations", "value": ""},
    {"label": "Downtown", "value": "Downtown"},
    {"label": "Midtown", "value": "Midtown"},
    {"label": "Northside", "value": "Northside"},
    {"label": "Westside", "value": "Westside"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Rating", "value": "rating"},
    {"label": "Price (Low to High)", "value": "price_asc"},
    {"label": "Price (High to Low)", "value": "price_desc"},
    {"label": "Distance", "value": "distance"},
    {"label": "Available Today", "value": "availability"},
  ];

  List<Map<String, dynamic>> get filteredDoctors {
    List<Map<String, dynamic>> filtered = doctors;

    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((doctor) =>
        "${doctor["name"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
        "${doctor["specialty"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
        "${doctor["hospital"]}".toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }

    // Filter by specialty
    if (selectedSpecialty.isNotEmpty) {
      filtered = filtered.where((doctor) => 
        "${doctor["specialty"]}" == selectedSpecialty
      ).toList();
    }

    // Filter by location
    if (selectedLocation.isNotEmpty) {
      filtered = filtered.where((doctor) => 
        "${doctor["location"]}" == selectedLocation
      ).toList();
    }

    // Sort results
    switch (sortBy) {
      case "rating":
        filtered.sort((a, b) => (b["rating"] as double).compareTo(a["rating"] as double));
        break;
      case "price_asc":
        filtered.sort((a, b) => (a["price"] as double).compareTo(b["price"] as double));
        break;
      case "price_desc":
        filtered.sort((a, b) => (b["price"] as double).compareTo(a["price"] as double));
        break;
      case "distance":
        filtered.sort((a, b) => 
          double.parse("${a["distance"]}".replaceAll(" km", ""))
            .compareTo(double.parse("${b["distance"]}".replaceAll(" km", ""))));
        break;
      case "availability":
        filtered.sort((a, b) => 
          (b["availableToday"] as bool ? 1 : 0)
            .compareTo(a["availableToday"] as bool ? 1 : 0));
        break;
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Find Doctors"),
        actions: [
          QButton(
            icon: Icons.map,
            size: bs.sm,
            onPressed: () {
              // Navigate to map view
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: Column(
        children: [
          // Search and Filters Section
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                // Search Bar
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search doctors, specialties, hospitals",
                        value: searchQuery,
                        hint: "e.g., Dr. Johnson, Cardiologist",
                        onChanged: (value) {
                          searchQuery = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    QButton(
                      icon: Icons.filter_list,
                      size: bs.sm,
                      onPressed: () {
                        _showFilterDialog();
                      },
                    ),
                  ],
                ),

                SizedBox(height: spMd),

                // Quick Filters
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Specialty",
                        items: specialties,
                        value: selectedSpecialty,
                        onChanged: (value, label) {
                          selectedSpecialty = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Sort by",
                        items: sortOptions,
                        value: sortBy,
                        onChanged: (value, label) {
                          sortBy = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Results Counter
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            color: disabledColor.withAlpha(10),
            child: Row(
              children: [
                Text(
                  "${filteredDoctors.length} doctors found",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                if (searchQuery.isNotEmpty || selectedSpecialty.isNotEmpty || selectedLocation.isNotEmpty) ...[
                  GestureDetector(
                    onTap: () {
                      searchQuery = "";
                      selectedSpecialty = "";
                      selectedLocation = "";
                      setState(() {});
                    },
                    child: Text(
                      "Clear filters",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Doctors List
          Expanded(
            child: filteredDoctors.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 80,
                          color: disabledColor,
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "No doctors found",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "Try adjusting your search criteria",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledColor,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(spMd),
                    itemCount: filteredDoctors.length,
                    itemBuilder: (context, index) {
                      final doctor = filteredDoctors[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: spMd),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          children: [
                            // Header with availability badge
                            if (doctor["availableToday"] as bool) ...[
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                  horizontal: spMd,
                                  vertical: spSm,
                                ),
                                decoration: BoxDecoration(
                                  color: successColor.withAlpha(10),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(radiusLg),
                                    topRight: Radius.circular(radiusLg),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: successColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Text(
                                      "Available Today",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: successColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],

                            // Main Content
                            Padding(
                              padding: EdgeInsets.all(spMd),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      // Doctor Image
                                      Stack(
                                        children: [
                                          Container(
                                            width: 80,
                                            height: 80,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(radiusLg),
                                              image: DecorationImage(
                                                image: NetworkImage("${doctor["image"]}"),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          if (doctor["verified"] as bool) ...[
                                            Positioned(
                                              bottom: 0,
                                              right: 0,
                                              child: Container(
                                                padding: EdgeInsets.all(spXs),
                                                decoration: BoxDecoration(
                                                  color: successColor,
                                                  borderRadius: BorderRadius.circular(radiusXs),
                                                ),
                                                child: Icon(
                                                  Icons.verified,
                                                  color: Colors.white,
                                                  size: 12,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                      SizedBox(width: spMd),

                                      // Doctor Info
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${doctor["name"]}",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: primaryColor,
                                              ),
                                            ),
                                            SizedBox(height: spXs),
                                            Text(
                                              "${doctor["specialty"]}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                            SizedBox(height: spXs),
                                            Text(
                                              "${doctor["experience"]} experience",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledColor,
                                              ),
                                            ),
                                            SizedBox(height: spSm),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: warningColor,
                                                  size: 16,
                                                ),
                                                SizedBox(width: spXs),
                                                Text(
                                                  "${doctor["rating"]}",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    color: primaryColor,
                                                  ),
                                                ),
                                                SizedBox(width: spXs),
                                                Text(
                                                  "(${doctor["reviewCount"]})",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: disabledColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),

                                      // Price
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "\$${((doctor["price"] as num).toDouble()).currency}",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: successColor,
                                            ),
                                          ),
                                          SizedBox(height: spXs),
                                          Text(
                                            "per visit",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: spMd),

                                  // Hospital and Location Info
                                  Container(
                                    padding: EdgeInsets.all(spSm),
                                    decoration: BoxDecoration(
                                      color: disabledColor.withAlpha(10),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.local_hospital,
                                              size: 16,
                                              color: primaryColor,
                                            ),
                                            SizedBox(width: spSm),
                                            Expanded(
                                              child: Text(
                                                "${doctor["hospital"]}",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: primaryColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: spSm),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              size: 16,
                                              color: disabledBoldColor,
                                            ),
                                            SizedBox(width: spSm),
                                            Text(
                                              "${doctor["location"]}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                            Spacer(),
                                            Icon(
                                              Icons.directions,
                                              size: 16,
                                              color: disabledBoldColor,
                                            ),
                                            SizedBox(width: spXs),
                                            Text(
                                              "${doctor["distance"]}",
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

                                  SizedBox(height: spMd),

                                  // Languages and Next Available
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Languages",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledColor,
                                              ),
                                            ),
                                            Text(
                                              "${(doctor["languages"] as List).join(", ")}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Next Available",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledColor,
                                            ),
                                          ),
                                          Text(
                                            DateTime.parse("${doctor["nextAvailable"]}").dMMMy,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: spMd),

                                  // Action Buttons
                                  Row(
                                    children: [
                                      Expanded(
                                        child: QButton(
                                          label: "View Profile",
                                          size: bs.sm,
                                          onPressed: () {
                                            // Navigate to doctor profile
                                          },
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Expanded(
                                        child: QButton(
                                          label: "Book Now",
                                          size: bs.sm,
                                          onPressed: () {
                                            // Navigate to booking
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
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Filter Options"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QDropdownField(
              label: "Location",
              items: locations,
              value: selectedLocation,
              onChanged: (value, label) {
                selectedLocation = value;
                setState(() {});
              },
            ),
            SizedBox(height: spMd),
            QDatePicker(
              label: "Available Date",
              value: selectedDate.isNotEmpty ? DateTime.parse(selectedDate) : DateTime.now(),
              onChanged: (value) {
                selectedDate = value.toString().split(' ')[0];
                setState(() {});
              },
            ),
          ],
        ),
        actions: [
          QButton(
            label: "Clear",
            size: bs.sm,
            onPressed: () {
              selectedLocation = "";
              selectedDate = "";
              setState(() {});
              back();
            },
          ),
          QButton(
            label: "Apply",
            size: bs.sm,
            onPressed: () {
              setState(() {});
              back();
            },
          ),
        ],
      ),
    );
  }
}
