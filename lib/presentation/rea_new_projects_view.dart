import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaNewProjectsView extends StatefulWidget {
  const ReaNewProjectsView({super.key});

  @override
  State<ReaNewProjectsView> createState() => _ReaNewProjectsViewState();
}

class _ReaNewProjectsViewState extends State<ReaNewProjectsView> {
  List<Map<String, dynamic>> newProjects = [
    {
      "id": "NP001",
      "name": "Skyline Towers",
      "developer": "Premium Constructions",
      "location": "Downtown Manhattan, NY",
      "image": "https://picsum.photos/300/200?random=1&keyword=building",
      "projectType": "Residential",
      "status": "Pre-Launch",
      "launchDate": "2024-08-15",
      "possessionDate": "2026-12-31",
      "totalUnits": 245,
      "availableUnits": 245,
      "priceRange": {
        "min": 850000,
        "max": 2500000,
      },
      "configurations": ["2 BHK", "3 BHK", "4 BHK", "Penthouse"],
      "amenities": ["Swimming Pool", "Gym", "Clubhouse", "Parking", "Security"],
      "approvals": ["RERA", "NOC", "Environmental Clearance"],
      "highlights": [
        "Prime location in business district",
        "20% below market rate",
        "Flexible payment plans",
        "Zero registration charges"
      ],
      "floorPlans": 4,
      "videos": 2,
      "rating": 4.8,
      "reviews": 124,
      "bookingAmount": 100000,
      "isBookmarkable": true,
      "isBookmarked": false,
    },
    {
      "id": "NP002",
      "name": "Green Valley Residences",
      "developer": "EcoSpace Developers",
      "location": "Brooklyn Heights, NY",
      "image": "https://picsum.photos/300/200?random=2&keyword=apartment",
      "projectType": "Residential",
      "status": "Under Construction",
      "launchDate": "2024-03-01",
      "possessionDate": "2025-10-15",
      "totalUnits": 180,
      "availableUnits": 67,
      "priceRange": {
        "min": 650000,
        "max": 1800000,
      },
      "configurations": ["1 BHK", "2 BHK", "3 BHK"],
      "amenities": ["Garden", "Children's Play Area", "Jogging Track", "Parking"],
      "approvals": ["RERA", "Municipal Approval"],
      "highlights": [
        "Eco-friendly construction",
        "Near metro station",
        "90% sold out",
        "Ready for possession soon"
      ],
      "floorPlans": 3,
      "videos": 1,
      "rating": 4.6,
      "reviews": 89,
      "bookingAmount": 75000,
      "isBookmarkable": true,
      "isBookmarked": true,
    },
    {
      "id": "NP003",
      "name": "Metro Square Commercial",
      "developer": "Urban Developers",
      "location": "Queens Plaza, NY",
      "image": "https://picsum.photos/300/200?random=3&keyword=office",
      "projectType": "Commercial",
      "status": "Newly Launched",
      "launchDate": "2024-06-01",
      "possessionDate": "2025-08-30",
      "totalUnits": 120,
      "availableUnits": 98,
      "priceRange": {
        "min": 400000,
        "max": 1200000,
      },
      "configurations": ["Office Space", "Retail Shop", "Food Court"],
      "amenities": ["Elevators", "Power Backup", "Parking", "Security", "Cafeteria"],
      "approvals": ["RERA", "Fire Safety", "Municipal NOC"],
      "highlights": [
        "High rental yield area",
        "Metro connectivity",
        "Investment opportunity",
        "Flexible unit sizes"
      ],
      "floorPlans": 5,
      "videos": 3,
      "rating": 4.7,
      "reviews": 156,
      "bookingAmount": 50000,
      "isBookmarkable": true,
      "isBookmarked": false,
    },
  ];

  String selectedFilter = "All";
  String selectedLocation = "All";
  String selectedStatus = "All";
  String selectedType = "All";
  
  List<String> filterOptions = ["All", "Price: Low to High", "Price: High to Low", "Launch Date", "Possession Date"];
  List<String> locationOptions = ["All", "Manhattan", "Brooklyn", "Queens", "Bronx"];
  List<String> statusOptions = ["All", "Pre-Launch", "Newly Launched", "Under Construction"];
  List<String> typeOptions = ["All", "Residential", "Commercial", "Mixed Use"];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredProjects = _getFilteredProjects();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("New Projects"),
        actions: [
          IconButton(
            onPressed: () => _showFilterDialog(),
            icon: Icon(Icons.filter_list),
          ),
          IconButton(
            onPressed: () => _viewBookmarks(),
            icon: Icon(Icons.bookmarks),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildQuickFilters(),
          _buildProjectStats(),
          Expanded(
            child: _buildProjectsList(filteredProjects),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickFilters() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          QCategoryPicker(
            label: "Project Status",
            items: statusOptions.map((status) => {
              "label": status,
              "value": status,
            }).toList(),
            value: selectedStatus,
            onChanged: (index, label, value, item) {
              setState(() {
                selectedStatus = value;
              });
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Location",
                  items: locationOptions.map((location) => {
                    "label": location,
                    "value": location,
                  }).toList(),
                  value: selectedLocation,
                  onChanged: (value, label) {
                    setState(() {
                      selectedLocation = value;
                    });
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Type",
                  items: typeOptions.map((type) => {
                    "label": type,
                    "value": type,
                  }).toList(),
                  value: selectedType,
                  onChanged: (value, label) {
                    setState(() {
                      selectedType = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProjectStats() {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: primaryColor.withAlpha(40)),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem(
              "${newProjects.length}",
              "Total Projects",
              Icons.apartment,
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: primaryColor.withAlpha(60),
          ),
          Expanded(
            child: _buildStatItem(
              "${newProjects.where((p) => p["status"] == "Pre-Launch").length}",
              "Pre-Launch",
              Icons.schedule,
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: primaryColor.withAlpha(60),
          ),
          Expanded(
            child: _buildStatItem(
              "${newProjects.where((p) => p["status"] == "Under Construction").length}",
              "Under Construction",
              Icons.construction,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label, IconData icon) {
    return Column(
      spacing: spXs,
      children: [
        Icon(
          icon,
          color: primaryColor,
          size: 20,
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildProjectsList(List<Map<String, dynamic>> projects) {
    if (projects.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: disabledColor,
            ),
            SizedBox(height: spSm),
            Text(
              "No projects found",
              style: TextStyle(
                fontSize: 16,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: projects.map((project) => _buildProjectCard(project)).toList(),
      ),
    );
  }

  Widget _buildProjectCard(Map<String, dynamic> project) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(radiusSm),
                  topRight: Radius.circular(radiusSm),
                ),
                child: Image.network(
                  "${project["image"]}",
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: spSm,
                left: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spSm,
                    vertical: spXs,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(project["status"]),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${project["status"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: spSm,
                right: spSm,
                child: GestureDetector(
                  onTap: () => _toggleBookmark(project),
                  child: Container(
                    padding: EdgeInsets.all(spXs),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Icon(
                      project["isBookmarked"] as bool
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                      color: project["isBookmarked"] as bool
                          ? primaryColor
                          : disabledBoldColor,
                      size: 20,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: spSm,
                right: spSm,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spSm,
                    vertical: spXs,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(180),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.photo_library,
                        color: Colors.white,
                        size: 12,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${project["floorPlans"]} Plans",
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${project["name"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "by ${project["developer"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star,
                              color: warningColor,
                              size: 14,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${project["rating"]} (${project["reviews"]})",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: warningColor,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${project["projectType"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: disabledBoldColor,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "${project["location"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "\$${((project["priceRange"]["min"] as int).toDouble()).currency} - \$${((project["priceRange"]["max"] as int).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spXs,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${project["availableUnits"]}/${project["totalUnits"]} available",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: infoColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Wrap(
                  spacing: spXs,
                  runSpacing: spXs,
                  children: (project["configurations"] as List).take(3).map((config) => Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spXs,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      config.toString(),
                      style: TextStyle(
                        fontSize: 10,
                        color: primaryColor,
                      ),
                    ),
                  )).toList(),
                ),
                if ((project["highlights"] as List).isNotEmpty) ...[
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Key Highlights",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        ...((project["highlights"] as List).take(2).map((highlight) => Padding(
                          padding: EdgeInsets.only(bottom: 2),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: successColor,
                                size: 12,
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  highlight.toString(),
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: successColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ))),
                      ],
                    ),
                  ),
                ],
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      color: disabledBoldColor,
                      size: 14,
                    ),
                    SizedBox(width: spXs),
                    Expanded(
                      child: Text(
                        "Possession: ${DateTime.parse(project["possessionDate"]).dMMMy}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                    Text(
                      "Book from \$${((project["bookingAmount"] as int).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: QButton(
                        label: "View Details",
                        size: bs.sm,
                        onPressed: () => _viewProjectDetails(project),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QButton(
                        label: "Book Now",
                        size: bs.sm,
                        onPressed: () => _bookProject(project),
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
  }

  List<Map<String, dynamic>> _getFilteredProjects() {
    List<Map<String, dynamic>> filtered = List.from(newProjects);

    if (selectedStatus != "All") {
      filtered = filtered.where((p) => p["status"] == selectedStatus).toList();
    }

    if (selectedLocation != "All") {
      filtered = filtered.where((p) => 
        (p["location"] as String).contains(selectedLocation)).toList();
    }

    if (selectedType != "All") {
      filtered = filtered.where((p) => p["projectType"] == selectedType).toList();
    }

    // Sort based on selected filter
    switch (selectedFilter) {
      case "Price: Low to High":
        filtered.sort((a, b) => 
          (a["priceRange"]["min"] as int).compareTo(b["priceRange"]["min"] as int));
        break;
      case "Price: High to Low":
        filtered.sort((a, b) => 
          (b["priceRange"]["max"] as int).compareTo(a["priceRange"]["max"] as int));
        break;
      case "Launch Date":
        filtered.sort((a, b) => 
          DateTime.parse(a["launchDate"]).compareTo(DateTime.parse(b["launchDate"])));
        break;
      case "Possession Date":
        filtered.sort((a, b) => 
          DateTime.parse(a["possessionDate"]).compareTo(DateTime.parse(b["possessionDate"])));
        break;
    }

    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Pre-Launch":
        return warningColor;
      case "Newly Launched":
        return successColor;
      case "Under Construction":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spSm,
          children: [
            Text(
              "Sort Projects",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            ...filterOptions.map((filter) => ListTile(
              title: Text(filter),
              trailing: selectedFilter == filter ? Icon(Icons.check, color: primaryColor) : null,
              onTap: () {
                setState(() {
                  selectedFilter = filter;
                });
                back();
              },
            )),
          ],
        ),
      ),
    );
  }

  void _toggleBookmark(Map<String, dynamic> project) {
    setState(() {
      project["isBookmarked"] = !(project["isBookmarked"] as bool);
    });
    
    String message = project["isBookmarked"] as bool
        ? "Added to bookmarks"
        : "Removed from bookmarks";
    ss(message);
  }

  void _viewProjectDetails(Map<String, dynamic> project) {
    si("Opening ${project["name"]} details");
  }

  void _bookProject(Map<String, dynamic> project) async {
    bool isConfirmed = await confirm(
      "Book ${project["name"]} for \$${((project["bookingAmount"] as int).toDouble()).currency}?",
    );
    if (isConfirmed) {
      ss("Booking initiated for ${project["name"]}");
    }
  }

  void _viewBookmarks() {
    si("Opening bookmarked projects");
  }
}
