import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsBarberListView extends StatefulWidget {
  const BrsBarberListView({super.key});

  @override
  State<BrsBarberListView> createState() => _BrsBarberListViewState();
}

class _BrsBarberListViewState extends State<BrsBarberListView> {
  String searchQuery = "";
  String selectedSpecialty = "all";
  String selectedRating = "all";
  String selectedAvailability = "all";
  String sortBy = "rating";
  bool isGridView = false;

  final List<Map<String, dynamic>> specialtyOptions = [
    {"label": "All Specialties", "value": "all"},
    {"label": "Classic Cuts", "value": "classic"},
    {"label": "Modern Styles", "value": "modern"},
    {"label": "Beard Styling", "value": "beard"},
    {"label": "Hair Coloring", "value": "coloring"},
  ];

  final List<Map<String, dynamic>> ratingOptions = [
    {"label": "All Ratings", "value": "all"},
    {"label": "5 Stars", "value": "5"},
    {"label": "4+ Stars", "value": "4"},
    {"label": "3+ Stars", "value": "3"},
  ];

  final List<Map<String, dynamic>> availabilityOptions = [
    {"label": "All", "value": "all"},
    {"label": "Available Now", "value": "available"},
    {"label": "Available Today", "value": "today"},
    {"label": "Available This Week", "value": "week"},
  ];

  final List<Map<String, dynamic>> sortOptions = [
    {"label": "Rating", "value": "rating"},
    {"label": "Experience", "value": "experience"},
    {"label": "Price", "value": "price"},
    {"label": "Name", "value": "name"},
  ];

  final List<Map<String, dynamic>> barbers = [
    {
      "id": "1",
      "name": "Michael Rodriguez",
      "title": "Senior Barber",
      "image": "https://picsum.photos/200/200?random=1&keyword=barber",
      "rating": 4.8,
      "totalReviews": 124,
      "experience": 8,
      "specialty": "Classic Cuts & Beard Styling",
      "startingPrice": 35.0,
      "isAvailable": true,
      "nextAvailable": "2:30 PM",
      "workingToday": true,
    },
    {
      "id": "2",
      "name": "James Thompson",
      "title": "Hair Stylist",
      "image": "https://picsum.photos/200/200?random=2&keyword=hairdresser",
      "rating": 4.6,
      "totalReviews": 89,
      "experience": 5,
      "specialty": "Modern Styles & Coloring",
      "startingPrice": 40.0,
      "isAvailable": false,
      "nextAvailable": "Tomorrow 10:00 AM",
      "workingToday": true,
    },
    {
      "id": "3",
      "name": "David Chen",
      "title": "Master Barber",
      "image": "https://picsum.photos/200/200?random=3&keyword=stylist",
      "rating": 4.9,
      "totalReviews": 156,
      "experience": 12,
      "specialty": "Traditional Shaves & Classic Cuts",
      "startingPrice": 45.0,
      "isAvailable": true,
      "nextAvailable": "4:00 PM",
      "workingToday": true,
    },
    {
      "id": "4",
      "name": "Alex Johnson",
      "title": "Barber",
      "image": "https://picsum.photos/200/200?random=4&keyword=barber",
      "rating": 4.4,
      "totalReviews": 67,
      "experience": 3,
      "specialty": "Beard Grooming & Styling",
      "startingPrice": 30.0,
      "isAvailable": true,
      "nextAvailable": "1:15 PM",
      "workingToday": true,
    },
    {
      "id": "5",
      "name": "Robert Martinez",
      "title": "Senior Stylist",
      "image": "https://picsum.photos/200/200?random=5&keyword=hair",
      "rating": 4.7,
      "totalReviews": 98,
      "experience": 7,
      "specialty": "Creative Cuts & Color",
      "startingPrice": 38.0,
      "isAvailable": false,
      "nextAvailable": "Tomorrow 9:00 AM",
      "workingToday": false,
    },
    {
      "id": "6",
      "name": "Thomas Wilson",
      "title": "Barber",
      "image": "https://picsum.photos/200/200?random=6&keyword=cut",
      "rating": 4.5,
      "totalReviews": 43,
      "experience": 2,
      "specialty": "Modern Cuts & Styling",
      "startingPrice": 32.0,
      "isAvailable": true,
      "nextAvailable": "3:45 PM",
      "workingToday": true,
    },
  ];

  List<Map<String, dynamic>> get filteredBarbers {
    return barbers.where((barber) {
      // Search filter
      if (searchQuery.isNotEmpty) {
        final name = (barber["name"] as String).toLowerCase();
        final specialty = (barber["specialty"] as String).toLowerCase();
        final query = searchQuery.toLowerCase();
        if (!name.contains(query) && !specialty.contains(query)) {
          return false;
        }
      }

      // Specialty filter
      if (selectedSpecialty != "all") {
        final specialty = (barber["specialty"] as String).toLowerCase();
        if (!specialty.contains(selectedSpecialty)) {
          return false;
        }
      }

      // Rating filter
      if (selectedRating != "all") {
        final rating = barber["rating"] as double;
        final minRating = double.parse(selectedRating);
        if (rating < minRating) {
          return false;
        }
      }

      // Availability filter
      if (selectedAvailability != "all") {
        final isAvailable = barber["isAvailable"] as bool;
        final workingToday = barber["workingToday"] as bool;
        
        switch (selectedAvailability) {
          case "available":
            if (!isAvailable) return false;
            break;
          case "today":
            if (!workingToday) return false;
            break;
          case "week":
            // For demo, assume all barbers are available this week
            break;
        }
      }

      return true;
    }).toList();
  }

  Widget _buildStarRating(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating.floor() ? Icons.star : 
          index < rating ? Icons.star_half : Icons.star_border,
          color: warningColor,
          size: 14,
        );
      }),
    );
  }

  Widget _buildBarberCard(Map<String, dynamic> barber) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            spacing: spSm,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${barber["image"]}",
                  width: isGridView ? 60 : 70,
                  height: isGridView ? 60 : 70,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "${barber["name"]}",
                      style: TextStyle(
                        fontSize: isGridView ? 14 : fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${barber["title"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: isGridView ? 11 : 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: [
                        _buildStarRating(barber["rating"] as double),
                        SizedBox(width: spXs),
                        Text(
                          "${barber["rating"]} (${barber["totalReviews"]})",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: isGridView ? 10 : 11,
                          ),
                        ),
                      ],
                    ),
                    if (!isGridView) ...[
                      Text(
                        "${barber["specialty"]}",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "${barber["experience"]} years experience",
                        style: TextStyle(
                          color: successColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (!isGridView)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "From \$${(barber["startingPrice"] as double).toStringAsFixed(0)}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: barber["isAvailable"] 
                            ? successColor.withAlpha(20) 
                            : dangerColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        barber["isAvailable"] ? "Available" : "Busy",
                        style: TextStyle(
                          color: barber["isAvailable"] ? successColor : dangerColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
          
          if (isGridView) ...[
            Text(
              "${barber["specialty"]}",
              style: TextStyle(
                color: primaryColor,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "From \$${(barber["startingPrice"] as double).toStringAsFixed(0)}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spSm,
                    vertical: spXs,
                  ),
                  decoration: BoxDecoration(
                    color: barber["isAvailable"] 
                        ? successColor.withAlpha(20) 
                        : dangerColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    barber["isAvailable"] ? "Available" : "Busy",
                    style: TextStyle(
                      color: barber["isAvailable"] ? successColor : dangerColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],

          if (barber["isAvailable"]) ...[
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.schedule,
                    color: infoColor,
                    size: 16,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Next available: ${barber["nextAvailable"]}",
                    style: TextStyle(
                      color: infoColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],

          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "View Profile",
                  size: bs.sm,
                  onPressed: () {
                    si("Opening ${barber["name"]}'s profile...");
                  },
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Book Now",
                  size: bs.sm,
                  onPressed: () {
                    ss("Booking with ${barber["name"]}...");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = filteredBarbers;

    return Scaffold(
      appBar: AppBar(
        title: Text("Our Barbers"),
        actions: [
          QButton(
            icon: isGridView ? Icons.list : Icons.grid_view,
            size: bs.sm,
            onPressed: () {
              isGridView = !isGridView;
              setState(() {});
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filters
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                // Search Bar
                Row(
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search barbers...",
                        value: searchQuery,
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
                        _showFilterBottomSheet();
                      },
                    ),
                  ],
                ),

                // Quick Filters
                QHorizontalScroll(
                  children: [
                    _buildQuickFilter("All", selectedSpecialty == "all", () {
                      selectedSpecialty = "all";
                      setState(() {});
                    }),
                    _buildQuickFilter("Available Now", selectedAvailability == "available", () {
                      selectedAvailability = selectedAvailability == "available" ? "all" : "available";
                      setState(() {});
                    }),
                    _buildQuickFilter("5 Stars", selectedRating == "5", () {
                      selectedRating = selectedRating == "5" ? "all" : "5";
                      setState(() {});
                    }),
                    _buildQuickFilter("Classic Cuts", selectedSpecialty == "classic", () {
                      selectedSpecialty = selectedSpecialty == "classic" ? "all" : "classic";
                      setState(() {});
                    }),
                    _buildQuickFilter("Beard Styling", selectedSpecialty == "beard", () {
                      selectedSpecialty = selectedSpecialty == "beard" ? "all" : "beard";
                      setState(() {});
                    }),
                  ],
                ),
              ],
            ),
          ),

          // Results Count and Sort
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${filtered.length} barber${filtered.length != 1 ? 's' : ''} found",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Sort by:",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      label: sortBy.toUpperCase(),
                      size: bs.sm,
                      onPressed: () {
                        _showSortBottomSheet();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Barbers List
          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 60,
                          color: disabledColor,
                        ),
                        SizedBox(height: spMd),
                        Text(
                          "No barbers found",
                          style: TextStyle(
                            fontSize: fsH6,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "Try adjusting your filters",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: spMd),
                        QButton(
                          label: "Clear Filters",
                          size: bs.sm,
                          onPressed: () {
                            searchQuery = "";
                            selectedSpecialty = "all";
                            selectedRating = "all";
                            selectedAvailability = "all";
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  )
                : isGridView
                    ? ResponsiveGridView(
                        padding: EdgeInsets.all(spMd),
                        minItemWidth: 200,
                        children: filtered.map((barber) => _buildBarberCard(barber)).toList(),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.all(spMd),
                        itemCount: filtered.length,
                        itemBuilder: (context, index) => _buildBarberCard(filtered[index]),
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickFilter(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
        margin: EdgeInsets.only(right: spSm),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(radiusLg),
          border: Border.all(
            color: isSelected ? primaryColor : disabledOutlineBorderColor,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : disabledBoldColor,
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Filters",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                QButton(
                  label: "Clear All",
                  size: bs.sm,
                  onPressed: () {
                    selectedSpecialty = "all";
                    selectedRating = "all";
                    selectedAvailability = "all";
                    setState(() {});
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            QDropdownField(
              label: "Specialty",
              items: specialtyOptions,
              value: selectedSpecialty,
              onChanged: (value, label) {
                selectedSpecialty = value;
                setState(() {});
              },
            ),
            QDropdownField(
              label: "Minimum Rating",
              items: ratingOptions,
              value: selectedRating,
              onChanged: (value, label) {
                selectedRating = value;
                setState(() {});
              },
            ),
            QDropdownField(
              label: "Availability",
              items: availabilityOptions,
              value: selectedAvailability,
              onChanged: (value, label) {
                selectedAvailability = value;
                setState(() {});
              },
            ),
            Container(
              width: double.infinity,
              child: QButton(
                label: "Apply Filters",
                size: bs.md,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSortBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spSm,
          children: [
            Text(
              "Sort By",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            ...sortOptions.map((option) {
              final isSelected = sortBy == option["value"];
              return GestureDetector(
                onTap: () {
                  sortBy = option["value"];
                  setState(() {});
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor.withAlpha(20) : Colors.transparent,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isSelected ? Icons.check_circle : Icons.circle,
                        color: isSelected ? primaryColor : disabledBoldColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "${option["label"]}",
                        style: TextStyle(
                          color: isSelected ? primaryColor : disabledBoldColor,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
